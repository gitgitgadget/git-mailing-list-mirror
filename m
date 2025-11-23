Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE871242D7B
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763935261; cv=none; b=vC/x/E7ftX03LgpLftxX/lMP6vF40rMcd0t0nBYkGkquTP6W7ByrW7oUwpvzyB+iRgRU5K7kYXYJsnBxLz9GLs5q2KOv4uVhduR7a1tWI94wvksWcG5UlzHC0f/efQQdjrpnny4BU+aprDG4bIpYZqWoGQd3kVHkt7BymD2WPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763935261; c=relaxed/simple;
	bh=3CMro81jWlkrH0ZWWPoUkG+qhGOFpL5E+kHktLuV5qU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=R6YyhT5fQuIQlE96JzVK3IAZKI1DWU4PXBhx5nuDnmWHqlxpLBXVw+2h6F1L3jsLlrLT/ZacmqYcEzOIWOt1kHZqBkPIUNVxy39h2+oylG+2u8oHDQposD3qZ+0vbgQneacXswlSoKhvnWZT7opJwcqzVfn5rrFXo3FHj1fboX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJnm6/ph; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJnm6/ph"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343684a06b2so3725787a91.1
        for <git@vger.kernel.org>; Sun, 23 Nov 2025 14:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763935259; x=1764540059; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zN6UyvWvpG7q8mtTA/bob7lBVEIeBVku+606L1DZMZ0=;
        b=GJnm6/phr6WPUibzXpd4Cb/ZASCyVSaK7eavUZgQlkcSYxfMYtG2eWCQ8HxM9jBUo/
         +S725g18dsYS2wh2CiZWvYDuCsQofQeRJ72VlC78HP80N0vE9SRScgu+w6/lxTX3QnoP
         VajwxZlNygU1iWCBGI8Qp1vRIO+RlUz/SUPC5di6g6PtXwrU9aXmcNpM5WVX7EEEYDS8
         jeih43ANzDNoUX8zowD8b6d75+J/gIiUmQ9MTEBjiBPFy1fF4Bqj61eawURgaSmb/uEn
         lWLgDJZA+mOTVZHZIQVyFfzh7mD9scF9bGpDycrocrsl4ZMMNIHy/hdpGGX5cVEdmONW
         9NRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763935259; x=1764540059;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zN6UyvWvpG7q8mtTA/bob7lBVEIeBVku+606L1DZMZ0=;
        b=eijzAWtKy0P2IJUoXjLEYPmA8Nuj2iHec7Rz6w0UJP41XoquP6JVrqH4IW3Qhfva2T
         EmwRagGCVvoDIkLIZ3d/3L9JQu2EsJpqeyIesNaeceWqrAPYBpRa2ER7AG6gNKzRLnCV
         zxiVYrMD71Oba9HiO6bPONqPTRjNrvYA7Tjrq2iXGSs2LP/oPDysYYzAD4FcB/qDd4UW
         l4aSIP30aYoyvK7S1na76UquBFte6IGiQHDKQYvcRT0tlqAp08UGn121bZarCNhglfSi
         5I7saGaKlxwwqurjvALscg80lWHo/WsyVJ3rWiLPryslmdGhBCHcQjODvKXgJACMPj97
         R+YA==
X-Gm-Message-State: AOJu0Yw5ALf3If2iMZm36bpqv5q7Cx0MJihGSRml3q6kOU1h87p68Q0o
	NSVfts0DBNLnypJnsCm1zbyok9XjiP1vrvoII6mEmMwCQTHNQ2+bPjwHxo+kJbfH5kAR+nuxV3Q
	kc4ylrE8OTijKciOFqspCQpVb0Bxkg7xlmoz7
X-Gm-Gg: ASbGncuyf1iYJ/Q0xy+A1jqEpPUiqsM8kH+omdnz8c5d8xwLYV/MuNQTc1W12s3fjs3
	8JsIPFy+7cONGT0QFqEcl9z3qvDwU8iCYydrzW5rTXQ5zy10V7XXIb3xOhrCTozBXwkCAoVai2e
	RfyViSTOoElKsMysR3UvBI7qOwBQeTe81QXBYIYH0ClTgg+l3gWPp5ZKgiWvUxZkgnKyYKx0AIr
	FqBRD05a3zYozUg+g9ovkLaZkx0VkDB4gyGLF/CbhhASegTqY0PsNnUUYg49kOM0pB7LzY=
X-Google-Smtp-Source: AGHT+IGkX6Da3Tp/RKFVfHXVFxdMoCUQCfoqwVMbrLtJfBL44/6eepwWOowWFXnJGkv9+msdsr//pqcAa9LKV04vlJ0=
X-Received: by 2002:a17:90b:48c3:b0:343:bd86:b5a6 with SMTP id
 98e67ed59e1d1-34733f51605mr8748871a91.34.1763935258593; Sun, 23 Nov 2025
 14:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Hammer <daniel.hammer@gmail.com>
Date: Sun, 23 Nov 2025 23:00:32 +0100
X-Gm-Features: AWmQ_bnY5V2wOm-YfeJ0lZDSPrBg6hSRBkK36dV8vOA0oSTPSiNq9mogTrUG1Wg
Message-ID: <CALrqSpeAiSU5JtdePf1Haygd_a08AKu6iBrO-LZDjcW8KCqJLg@mail.gmail.com>
Subject: git whatchanged deprecation
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi git devs,

Regarding:
> $ git whatchanged
> 'git whatchanged' is nominated for removal.
> If you still use this command, please add an extra
> option, '--i-still-use-this', on the command line
> and let us know you still use it by sending an e-mail
> to <git@vger.kernel.org>.  Thanks.
> fatal: refusing to run without --i-still-use-this

I still use this, usually multiple times a day.


The flag approach seems unnecessarily heavy handed, when amending the
documentation would have sufficed.

As far as I can tell from the documentation, this is just shorthand
for a(nother) counter-intuitive git command.

Hope this DevEx regression is reversed ASAP.

Thanks in advance,

DH
