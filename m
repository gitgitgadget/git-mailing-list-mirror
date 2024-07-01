Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEDF219E4
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719812554; cv=none; b=JGylaEyzRYpmvNm8s5xP/ftfOM8Z2QFVFaLXZyMXXFyCSlg2bipDZAOnrhK13Ezlz9/dchWLja+Aa0EdQqkWmguEpBM68Iu05MHJJ6fJZGUDuMaAn/L3hwXM0VxJrrm9XV+SrMIdRtg1m04tBg0UHiufJjwPkHdP3IvLXZrO/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719812554; c=relaxed/simple;
	bh=Dn1GKsXjPXBBkhn9mwgqP/wNxmhNTXdqzKMe1DU8uR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qki3XWRyqlRLATamzrloot4PWWpAN2R35zUueoZf0uQqIJsbrpvCKwbaRY6XvLdsKbl1UmCTRjSZ6dVwrcyLMkOW9t9mPPc2gxXIVdogjyhssklg3vQZFvpNXSYS72A06nAdqK0JG+mQB7Fhsn2hU3QMchvhR8ZHMZ1NWydfMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMIHii8b; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMIHii8b"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a728f74c23dso271776966b.1
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 22:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719812551; x=1720417351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn1GKsXjPXBBkhn9mwgqP/wNxmhNTXdqzKMe1DU8uR4=;
        b=HMIHii8bqlQaMD6iKcteujkwureOhs0LkIKONKFqZ8BDRCIWSS6LqvQlWXbbK5KRqJ
         yd0/czhLP9emSIX5TjbFJBHYRrCmz4uYpUzvGarxFz7zdnSzzkRXcpCHC2dz+SFchMLV
         HOjOxZSp6O6jS2HgKzzotgJz16A2AL9+ZzDV3xqeKUx5ALpBlQnry5Ok4Lq1Hj7aAhro
         aMMx0Cjmqxcw76KIbCBBZXRcEIAGQOxsyfKumuYYf/NksOHWRXvdvCez7AIt65E9pmKC
         Ek84DSejtUehHOxALn338DVMmCUqsB6LEdwJahXTAI7uHQAG+briyb0bnVD4qSIkY0ln
         4oUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719812551; x=1720417351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dn1GKsXjPXBBkhn9mwgqP/wNxmhNTXdqzKMe1DU8uR4=;
        b=Y2v4f5NJZThGGOioq6dMsCR4qCu9U+Mt6DbhjspNj6vi+C5SLcKAe1/aES2RhqJi9l
         wY8vtbxayI1/Pj2KcdRlRuz0ZIFK1/glyyzoqkxFfCW70t2K8o/yn/WiB81yz24tWbzx
         sXD5n58SYlbLuT4//yToLJc6erSYM9UY8n94k7I9FUKptN/YRQrBWKPMP3E9PyIhfr7i
         ZzgIfKk74yPm9jnD7FFkH7Ag7bJc4bTjjEIbVT1iZ1gRpswJfnat73BOanolozN93bg4
         QWCXdBquYJD03PYlwvEh5ccmahZE1I9FCowkAjADWJHuBVltT8WHFRcX+KWuR5BMqBaR
         qtGw==
X-Gm-Message-State: AOJu0Yy88UT5bdrgffgvfHrues6fS2Z0+NSVmJBVVLsAoRN2biD4d1v3
	DG+L1hG9LKAj7aEFSx6ERT/rsrIdQbCnTF/7XAf7ceDJwm7yVbPqKoka6dXmttEYDTda5K/Jp7O
	t8+oUDFmVIp9zwavTOY1YGSJGlZu62Fj53Mxvyg==
X-Google-Smtp-Source: AGHT+IGL1i+ALC1eRSLX0LLUBJRYGjPf1rkk4UZfaxZAk5efJ81nxOyAkaDK0UVpr3TavV9eJ3nOprmQHFWHMB5c/Oc=
X-Received: by 2002:a17:906:4693:b0:a72:8cab:b590 with SMTP id
 a640c23a62f3a-a7514454512mr270832166b.41.1719812550478; Sun, 30 Jun 2024
 22:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
 <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
 <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com> <CA+J6zkSFCUYLRTRE0Gwug4-fF9f9-YbfRz_atArmMLLCtQDr1g@mail.gmail.com>
In-Reply-To: <CA+J6zkSFCUYLRTRE0Gwug4-fF9f9-YbfRz_atArmMLLCtQDr1g@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 1 Jul 2024 11:12:19 +0530
Message-ID: <CA+J6zkSxcogPXdAdr7VL0B3MnQxQNYwOT5Kw2iK_YfPLW7CMcg@mail.gmail.com>
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the fifth week of GSoC's
official Coding period:
https://chand-ra.github.io/2024/06/30/Coding-Period-Week-5.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/
