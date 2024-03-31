Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01275144D24
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711923197; cv=none; b=I2AB8H3vtaNEJVnwZJKqHMA/REjDNtSnpOmbJuEZCZ4ielZa6o1YZ3IYwmmhFQ8caqS2ut2vKpspmC3ytWtOswwiTMVvTggD071aIcJYybaYqNmM68WStHKOxRjMainM7WxdvThguSE+xUMN7xeS4uaVmULO87YxyUdGhfKF0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711923197; c=relaxed/simple;
	bh=Fo/lYGw5NdADHiz5iWIpmwgORU4GiiX0PUXLOoM62Hc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lOEHOweKu/qr6U6bqd6pdPIF83fgkoTlBGTyUWxL1L8CawWemalMIDhuzqI8nHojjkrYLRC17Fy5+0LYWdldCAKEJb4evHF64HnWeuumhpHHA4ZmdfFwigNU7X6oFV9J8K5oRzF/E2cAD1yiUJrEpQdQDbZfWIIgb7v21higIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qziaw9PD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qziaw9PD"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33eee0258abso1898426f8f.3
        for <git@vger.kernel.org>; Sun, 31 Mar 2024 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711923194; x=1712527994; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fo/lYGw5NdADHiz5iWIpmwgORU4GiiX0PUXLOoM62Hc=;
        b=Qziaw9PDb73CF6Rf0xgoIV0M5VDnMTITbOpgIiKR6JZic80eXXy9TvPlxPv8IhdmON
         UfUS2NDMojJF3F3WeCSK2+tfj03EtiphVvv6XU6oZK95i8XldLqCdaVj2yABdx8ZxYV5
         W7zdxt0ElBftse3gPbnyi7r7YzhOsUhf1zViA8gd+tWyEDp80hz1ldKupSA9g090Y6vk
         L4Bkcfn7iXZmDQcEjtb4JjRL7Zfe8Rp9JDrY7zMdWlLiVx7XWLKvBKg+Qd4+QRh207Qm
         s8EJw1TdEuw/zF1L3IaNpwCZoEyzSQSypq1OUtKbyPtQ9EqXJ6mselzNP5lrFp9XtlVQ
         Z+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711923194; x=1712527994;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fo/lYGw5NdADHiz5iWIpmwgORU4GiiX0PUXLOoM62Hc=;
        b=M/YgLUM49df2jgUsXO4Ntd9d4KdgLzHoznW25PqxI3Bmf6kauALOs8nHsY/Jt8gQVy
         Qgt94lS2nGs2g0uS7HaE5YquYA9OZ5oH2eb0x2OmKq8X4VlWKhFWLSPunRygjf8yAXWk
         sC54r2ztkbfBHVJySa3ttIS9UnZD+w9wLo9eBmR17Nvqunr2tJLyhNzLpwopzM1gokMB
         bAx3pehtaJklPsR+3nBPYbVA0aTTknVaHPhqbE3kw+qd2oPriHMB+Kw1UqnBgijgUvtI
         B4HDROBHO8MuLE9ErizWnxu1mzpIjsaGSUPQuPiG9fWwaqAb9271q7m2gQu5cqHRO7wy
         1cXw==
X-Gm-Message-State: AOJu0Yxad3bCvaEr8hGScyviit8dhQx7zpomBFgjDyCYtdQszwkQAMY3
	lVa4jakhzyxmNQUWSbG+FKzX+oQ76eChpY6PiIeKh5kxw9CRgB8bTQzL3pb2pqT7SbsbL8Y1Dbc
	G1+yHeO2rAUw3IEIFsWTEfdPP8dDxTbQMdMs=
X-Google-Smtp-Source: AGHT+IGa4gsD56CCRen1KYGkODbwzo16FhwqcuBKlEjW0sLfryGSC09FIIPyknsn3VBCxyD5fbJdkTq6dWk4oFztn4w=
X-Received: by 2002:a05:6000:1212:b0:33d:a944:54c0 with SMTP id
 e18-20020a056000121200b0033da94454c0mr4652914wrx.22.1711923194073; Sun, 31
 Mar 2024 15:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Nude F. Ninja" <nudefninja@gmail.com>
Date: Sun, 31 Mar 2024 23:13:03 +0100
Message-ID: <CAOSCdbFg8jY1_0JE0+xf8oxrJjx-Kj0Cb0pPg3oUAXMN5q=kzw@mail.gmail.com>
Subject: :/regex syntax picks stash entries over regular commits
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
I ran git stash push, which created the stash entry "On main: dark
mode". Then I committed changes before noticing an oversight with the
previous commit. I wrote the fix and ran git commit --fixup :/dark

What did you expect to happen? (Expected behavior)
The fixup commit should have referenced the previous commit.

What happened instead? (Actual behavior)
It referenced the stash entry.

What's different between what you expected and what actually happened?
I cannot autosquash the commit that refers to the stash entry. I
suggest adding an option to prefer (older) regular commits over
(newer) stash entries when specifying a commit with the :/regex
syntax. In any case I think it's a bug for the --fixup option to
readily produce a commit that does not work with the --autosquash
option which it seems it was designed for.


[System Info]
git version:
git version 2.39.3 (Apple Git-146)
