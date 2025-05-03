Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B74C98
	for <git@vger.kernel.org>; Sat,  3 May 2025 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746246079; cv=none; b=tZDpWnUt8YLbAQCbdmGHEzvgHykNvg1+OnDDxVMnnZ8IE/pCtVZgsu3k1PDxpwQWgsQz0LSE7iFUYAGBwAzLxaJFo/K96WwFzVkzf+mak0AC6WNsJvqcNbimjQNF0EiGtnn0fsy5EIpXwLBgi6uL6901ngz8xaDyhYJStVONw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746246079; c=relaxed/simple;
	bh=e3k5DDxM2BsMx9FRxcjDJFK7gf6GqnTwPPZwwlY2Jl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FLSX7zupNHHOTY66TVYzp5Y+qup1h88gcMAsyLwjeL/5ADsui0xehGkWZnhWi1+1vdtRtWnNKrOjK5JR28/MIvUx64M+3Gro8F4pjlnuury1c1P69JiqHvgukgEsN5ZI6p5XOh3wRFJTDoIMO6zQIKiHAcUOJsrUQGHZogPKRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkiQVXn7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkiQVXn7"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739525d4e12so2856728b3a.3
        for <git@vger.kernel.org>; Fri, 02 May 2025 21:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746246077; x=1746850877; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRsKqC3gXjsNNeqT6Pb8HIaG/+c7GCcSudqpnhrr+ys=;
        b=dkiQVXn7/dy0bijXA2BUJBdzuhSqGucxAru4HCkOh48BZwrWMzvgJ/SgsoWfGkJpOT
         8RiasnWfRNukopomeCVilGDLsSgjwBx7syT8O3ui6tRA12AiBOuVNpAM8KN2u0wFFaTz
         TsPDXRkeK6Oux2qc83VMaf5TPSfM8Tkt38jP9vDMlNiOWTuz5vTo6/0g84gEZ+T87S5m
         HwiYhXfEikir4sRiFplWpYxbRXT5ndR+cA7kFeI5ffGhn0xQxH9l4FdzXZ4HOANGFKvA
         l+9Pm+IFTzan/2GMXbUWXWHDSaHURGsCIn6Wg4rT+4Jk9kqRCfbPmVqCCl7rHK3timb+
         YAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746246077; x=1746850877;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRsKqC3gXjsNNeqT6Pb8HIaG/+c7GCcSudqpnhrr+ys=;
        b=YQlIwumBvqIZmPY7KV3qrr0ioW/P0pbTrQOiNLz+w6+epF32O9rKOTZ5kKPosZ8MAY
         YnsAsawtrQ851m/mIczJjlotbx8rusjGQULP0u/oYhZBAjta8e62fzq4x6D0393g1lIc
         lN4pvwXWQCmG4K/FdnnxToBfWCGBc8oS5cgdl/m3ScVE4y/5E16GhjsMajk1b+UGfpSa
         QBhxlXGonSjW+Hm2LrX08dGpRp4nYjiZCWVR5nxNrsSSkbxoX+HurU7Boos4nj5y6+K6
         yp4zRQlPmKcaZp+Ze549fVXmiuRpXofc3bCy1V2SL7lHj/DvCFjLiz9Sfl9Q2DC0q2d8
         uavQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqQAr+G3NfkziWOSaZ7qcNHD5FReGMEPez/Y9ynuBVoxDKZ6REDDIFR7npE1uFnqbKZLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy2jW3BncdnUAhpzlYkCxbVaYjRg435fqSMqEt2oyzc/sVCAgO
	2Wa3My0vlSXJExrLnop86SADb0BRHkxfYSbRk+Xvi5vMQ6Q5I3vN
X-Gm-Gg: ASbGncvFsjygh9yEodfL3ke9oNdx4vDF6mwutnMsh2GQTSA4lLmwWULLennYJAayvrj
	M+TQxG4PnKj05wwkeza711YlRE3Uz1z3t0r+NduLv0mcVD8BiAbCZNrg398/1D74i/Oq3RMuNHi
	wHcFWN7V61m4A0k8tAaEwXsMGMQn/lVUQLtGAflXVVfn5WgjWU32j5BO06UWUEYUhFx0IcM4DP2
	aIAf+I3wiVa88lGQvkxbn9ejkbOFLXggLjuGFWoSJvp2EL4/703fe+hAWLOeEihbgTVR7XAGnxX
	J83GjVZhA9Z1HoWpyS7uLj78A+sBcTh7
X-Google-Smtp-Source: AGHT+IF7Zt+Yiop4vG1MaZo786QHWDhtZFzGe2I0rM8gjtBhRwhcH+DEENEu1m7s/lukvL/6fj7KTQ==
X-Received: by 2002:a05:6a00:340b:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-74058904a5amr8216260b3a.4.1746246076896;
        Fri, 02 May 2025 21:21:16 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::4bd0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405c2e7596sm2262836b3a.147.2025.05.02.21.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 21:21:16 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  shejialuo@gmail.com,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
In-Reply-To: <xmqqtt62sdv9.fsf@gitster.g>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
	<xmqqtt62sdv9.fsf@gitster.g>
Date: Fri, 02 May 2025 21:21:15 -0700
Message-ID: <87jz6ycojo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Thanks, both.  Will queue after fixing the proposed log message a
> bit (the sample must be indented, especially when it contains lines
> that look like a patch).

Yes, that looks better. Thanks!

>> I suspect we'll also hit this on FreeBSD, which has a similar issue in
>> that it returns `EMLINK` instead of `ELOOP`.
>
> I won't expect Collin or you to redo this patch to cover FreeBSD;
> anybody with FreeBSD box/vm can do a separate patch on a different
> day.

It is no problem. I have access to a FreeBSD 14.2 machine. I can confirm
that it fails with EMLINK.

My V2 patch fixes the issue on both platforms. From the documentation
OpenBSD shouldn't be an issue. But if so it should be trivial to fix.

Collin
