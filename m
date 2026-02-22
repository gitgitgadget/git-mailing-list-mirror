Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6EDF6C
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771730542; cv=none; b=D6aIOMEhYOJ9VL5gpEKISfik4tqcxvIH5y+TA9MVClzv+v6Ff7GE5mbusmDObK6TRi1wUxINopfg49mNFVA9c3ixIv18b4ePKiCN6hYLYPxP/q5SiaZixw8MkhI5LYiVpWAGRB64ombwEZS2GfjLZ1l38FMvCxzmYISeypdamxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771730542; c=relaxed/simple;
	bh=keCWndOXvxGNIRaKCopXDX4DS2JM6G4UJex+gAOh8yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEQHBL6H0Qq/OU05vMW2toyxo3X1V+Nsz3PB+uK/yuLZcS0+1sIe27fvYwhnygewGJ9eEKotKXMFcXNtVY0/0iEFgPeA2KpZ0BYjN+lvfNkL6cQR2IKB8qCEL0I63G2nBWGOt+uFiL9bHQ6EydIwGrACrm+40Trc/KuVuQUhKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjuEO0gB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjuEO0gB"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354bf10f057so283572a91.0
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 19:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771730541; x=1772335341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3fPEhGF7TJtA6kD9zcRqDE3oNizcPxXC85aW0EOufdo=;
        b=GjuEO0gBjgnlp3K8DRBEAuxAJTfMQW29BAS+nU2zGkS6v1C/cXNLTKW6RSddCKtXVw
         KvinMsyT3/gj6KHW8T/FvJqKm8s96Cko29BkI8WwmMCWpaADPzbk4pCVKxQ6S+j7efrC
         eW3zQwP6FctY70RAABJnVOxSDKZF/u3V8+FWZqyPQzNPtO/ZvN4UWSMiuIsHqjZ+Uxw/
         mCPxLxLeJLJp4k6lILrnHOA1IYZyLLGVvpqMu1FVJ2TRNwHKom282nXRRn3QhR/JycE+
         4Gs4Xn9CVrZ8Q9BvY9O80/MVS3kSAfDZ26dwEeSe5UrqRFOYZ+gjMCkDvZJx1h65RjaA
         IWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771730541; x=1772335341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fPEhGF7TJtA6kD9zcRqDE3oNizcPxXC85aW0EOufdo=;
        b=O+/m2EALHeSSd/UiOXYKXRIF2hQyvBQisWrKdUm7i7ac4OlTyAFGshQIO2bQmzCwUj
         yUF827c2FNjsVvUxVX4SGYHDj8NaXbZAzlZnah6+120u37gX1XXEflc0a92tGK/g0PHq
         mP6RfvslTYZ/RmHDqbpoGuxORsP9FTb1zAicZl6faJC5I3Ks/erQ9X2f/1kkfgcXmjoI
         Y4HQ8r7y0z6wf8fxuYKlrLPEAdyMY5t6qAvViXy7FfVpt4VNtZqglv9VBuvpBGLOlzII
         kaEjGpqeqoceM92lpDQCRQV67Q6+btOf/G1VR/WYCqUtC//4Hbfd5gbAtamfsmMC0x/P
         gUbw==
X-Gm-Message-State: AOJu0YznYOWm/U3fQ9nx1YVQ50r/lxpsMFCuXJYrXuiUv1j140MssfRy
	Fd602K8ucFyW2POJdp0RpsU5yRz3SXvKePVjs3K+Qiy6sieKKC3t3cq6
X-Gm-Gg: AZuq6aIC3jWmmdmkLnVWegdL8rU3NCKMoIR/K7ahisQ+4a05SvgR/2+7XixlrQvFKoE
	lw+VgewXnWdVygJHQGpQuf08R5Ekj1e/Qv7m9TncKJn7PlfX9l2EOxlXHFyWUMy2O+P3VspRbwM
	uT1XFVSK+LyLOc1ZVlWYGaA86Dv+dCIpAES7vtFtDCUN9aS/Tkz9YVVSPTMd6hUqNDkRE4lTyJv
	wFmdDPRE/qOse4FvQXuJ/Xr1Xwh7xF4ezLJe9NItkMbijD0E/gmL18kqx8DN1PlbwHPGJS9R6QN
	FnvVvsrVmG4HwJiO5dAbmgbcRfbp2aNIp4Bwg7XLnN5GbsIm/usJ01sEZnxiNSiSk8uDGNUwSDx
	66QcYfdts97eHPrHdEipBBjnY2XVQmZxK6m2pHX3e+9NPVkjbHr42ZY5yREu+mMNxxtU3NBicYo
	D+LbDnAHAzpwbrhvZyfHAaHjwtUP8=
X-Received: by 2002:a17:90b:5687:b0:356:1dad:1b04 with SMTP id 98e67ed59e1d1-358ae8a8e00mr3005456a91.3.1771730541077;
        Sat, 21 Feb 2026 19:22:21 -0800 (PST)
Received: from [10.16.17.83] ([111.223.90.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358a1be4619sm2936624a91.5.2026.02.21.19.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 19:22:20 -0800 (PST)
Message-ID: <b2f0153e-8401-437c-bec5-333b3375782b@gmail.com>
Date: Sun, 22 Feb 2026 11:22:17 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] setup: allow cwd/.git to be a symlink to a directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
References: <20260218124638.176936-1-a3205153416@gmail.com>
 <20260220164512.216901-1-a3205153416@gmail.com> <xmqqfr6vxpkn.fsf@gitster.g>
 <60e4cbcd-6dfe-4e1a-9c63-be905c815bed@gmail.com> <xmqqqzqerp21.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqqzqerp21.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

Thanks for the review.
> Exactly.  That is where my reference to "not tightening everything
> at once" comes from.

Happy that I'm on the right track.

> Yup.  Perhaps it would deserve a new "/* NEEDSWORK: should we catch a
> directory .git that is not a git directory here? */" comment there.

Indeed. Will add soon.

Regards,

Yuchen

