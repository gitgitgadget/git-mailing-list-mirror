Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6A20E6
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019870; cv=none; b=AAWmR0ERPoRJpx+ijUcfwR17xKQDJ6DHX8sIeSrwFjKzSfB0UeaxEj3tTOBGeLCkwTax2cR3uz9KrQbPGl9nic4fLLZjMyDet1lsBEEuhAce5Tx+mOlHe/b5aCnafhfi0mCMqfBZc6wa0PvPZMD/ZYRMnmu6+LSd0LnRd0Wknfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019870; c=relaxed/simple;
	bh=6Uxxzsb66ST8VFVy2XwA1Je68cSZyaHX42Ma3J1ef9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BroM/mhXVk5TluM3kAXzUcghIT0Jq+G2gHJE68YFqzWq1A5UBU5aI9nXM8Spe5iPW0demyiSgprc/I5/x5p+UhKZiW2BYcTyeYKIzQaprRlkXQ+/xAbdUaU2wfezxDoPUNxZNajEgA3X9sbvBW2Q2epT6qh72SbqbR9Fb5iBqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx5olXj4; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx5olXj4"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86d00ae076dso14617439f.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752019868; x=1752624668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/HJAz3e7gCYb1SWAipOaq3K22WhU9NW6xpDQEQJtM0=;
        b=fx5olXj4dJ1CsHrUvGFua3sbt9MVOFtRxI39jBqPPoTYcv9uiR+2qzGf9i9nUfAD+k
         yYBIW91ap7m2PCXHDC9SyAZ7BvSNRGtrADjkEySkmRhc+VIW6irG8va4Uls85IZM0mXK
         BR7A4bmxLXM2ilfH6wKZzekbs9H0mGZ+p2tJDAIsPx6V6yjnMjtLZDxvMBQakrd2rxrk
         GmbuqJPcZvhf5vsXNpOtDJ123LU8nqhlfxDeTTohdW7pLn8WVWZtuj1B2UzD/98LpKcE
         qQl4ImPcBtruSH0fCIXKu0l71pov1fA0Dr9rkGJl9eppFyOXUYBnB4Fks6XnXGg1ndJP
         TGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752019868; x=1752624668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/HJAz3e7gCYb1SWAipOaq3K22WhU9NW6xpDQEQJtM0=;
        b=KdVMkH/+m/S7Bs78r2vM0+97bYYGPfOQxcBPfGOeyUg0pr6DAjURNy2MptkISIXnh/
         F8FhbK/V+dTlF0pYcuCUwO3gPCeCvEkNKei0iwF9TtYXb0q61UTxIjjdjonhK+OrttV3
         ZVLsH6ZPMf3R7abNR4m3eOQiomyp1WbsifMQF7epKAI8G+cJZ0JYBItfdKh40FSFMBYY
         lamQP8pATwdxjSuhICR0GNr3z+OkwRUs+95p7Doy9zKG+MIrItYni+LnAewpD/Ql7s+H
         C6I7Z4S8BS/3UdUdnUK5otZqAeJTK+TSVBi2zxdOKOc2VDSU5kPTeKEotqj8d2kWLRST
         k0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVwGM7Q3tVlxE354sN2AzrfK/Y0l3a70OIUTC14Ws+1x9r9a4ljG06j44ESWJ9gLSgRhjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGBLVNiPq6+zPafZVDwPdwWE2Y/1y0K7MuNFY90yVhYlPQnpBz
	m8qP/cZ5j63tOZTSW4oUj9ts38Bx+D9amq4d75PFDXdr4iJ0WWA7wMISK25P7In4WxjzLrjfMXN
	KDJggiEiiaQcz/RHSjG7p6YKGLNiD0I4=
X-Gm-Gg: ASbGncuXKwXJrvIGPdl5mxcXSE8ESNIrL8j6A6OwuYQ4NgDpvK2EXcYUy/NHeRvlGVR
	xsKA1km1+Ku9HFVmmJ8UM5KMnAihSPxqXA8pa8Bt+KI+VMuTExaNtB3ZhN6qkWJUxXPnxcmR298
	XvTcqM3LmoiY1+e8XbiT/oBiLDJwT2TJcAy4KOwH462hW0yt8hwDWjFMMhSQ==
X-Google-Smtp-Source: AGHT+IGeWXJlD/Xj/3q56n/uHa8kih6U+4dyfgqZaOHUaudFpUMydn/8VnGKwxQyd0BqN9P2+1MYFaxgcpn6teCj2zM=
X-Received: by 2002:a5d:9383:0:b0:879:39eb:988f with SMTP id
 ca18e2360f4ac-8794c371680mr476370639f.2.1752019868458; Tue, 08 Jul 2025
 17:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619133630.727274-1-christian.couder@gmail.com>
 <20250708091738.4072857-1-christian.couder@gmail.com> <CABPp-BF6OvH8oh=jG_8fWoC5gW+9E+wx=uDEk1uerJTOva5isg@mail.gmail.com>
 <xmqqqzyqqlh3.fsf@gitster.g>
In-Reply-To: <xmqqqzyqqlh3.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 8 Jul 2025 17:10:57 -0700
X-Gm-Features: Ac12FXzuYUSsx51LyzTZH1hSIqN-guXcKUuFNjXJFGZ1R1nlYDjxhANR_9DDG7M
Message-ID: <CABPp-BHb-yK1E0h4K9rJ1dk3HC6urv6b16birVv-L1pMsqs3Fg@mail.gmail.com>
Subject: Re: [PATCH v5] fast-(import|export): improve on commit signature
 output format
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 5:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
[...]
> Yup, thanks, both of you.  It seems that we are getting closer to
> the finish line?

I think so; a few small touch-ups and I think this one should be good to go=
.
