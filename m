Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5C34D38C
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796100; cv=none; b=kczjQ8B7prh2bM9rbvBHavSEcQ/IMkwMIMYKbVVKCtv0ms2dZHTCUf7DagnjG1gcYtwy+RiVkgYPx1rXtkhwfVAodrZD8eUfS+oCet4MQfERyMlCwRACzo01KPB0IUkEt7oh2PD40kprvhTOi3mwn7agb0It9TL1Y5xtTl7zjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796100; c=relaxed/simple;
	bh=Q5fBdGQXpftiNjMiMzUaSfXdEsVe1b141Mr7xjyHqYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1PTp35QOQ6p3zZzO0ekpPfJ/K1KE4I8LPX3Y+KF8+uCMCjyHQ4QuIUJuhWGul7P1qyoMJw0x4NpAkNI0o/DytQ1iRw7C3TN9iaREV84yt2N7FmA9G/QJ0VjQbNJazS8+10P+oP7uxZQ7lqBw4IlFpbr8hPCxTwXTDb2RgSdDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRYZpzHG; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRYZpzHG"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-431048c4068so567630f8f.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767796097; x=1768400897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SGhtzFnLzTyc0F34BwlLY/+8UN3TOIKkjYoHShrv/y4=;
        b=gRYZpzHGhlrt9i1ZTbvfLmTeTzCzcuzxGhN42+h34HRvuUetvscySC3/haGcr+oFYr
         QaxEUZRiDBQ8u33w/tSzfPzs3lhyRrkVlOQ/XLxXMyQSMsr5Ldd4zjHp3an4bEl3fMl5
         qBVsISlzmJX1PGEH73bThb0nhjhuRMbhlgEdUE2xsQU0h8j6beCJYiCk2swsJcd3lGLA
         J7f6/GuccodCh2g5NxQBTTsxEAmsWTXCURSeUihXLfWsdfk1hFLCiJrvnJnZrIg++pBE
         YUD+p1xUrTLHR0+7Sk1NbReE9qwIuaHD2BiPi3VlsouLScjHdxhWLKKoefXEbBDKluNY
         q18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796097; x=1768400897;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGhtzFnLzTyc0F34BwlLY/+8UN3TOIKkjYoHShrv/y4=;
        b=uwvqfHWIuKgYbPSdH1p09Y22UaQHMkoIGj9VBUh8FJyU7XUha1GJETt4EVdP6XzAcU
         jDieqhrhwWRDUEWBb8X0XSaP0tHz2Vb0mtAV3/kbQuoCmRV46RxuXFOo9JxHo6O0fh/J
         JN0InscyDksO7D5hFPJ6emg7dRUfOCAu8bysl94O4slqbnktood1fbvrbRS6LkiVL/fd
         wZQrr4zInHns0nKBiVM8Pi4jlusuD0sCUV3pOBFzMGwPOImPyHDNDJAEmnpND68IjfsH
         yCikmXqCd8NloU0+IK3N0J8EIJqL9VxC5Gyx1wn+XnKfTGXyhVPz7kAhTq3//UBGR1nF
         IPlg==
X-Forwarded-Encrypted: i=1; AJvYcCUv4wkTWCEO2VgccOGvuPHGfT9rMCEpBtwIrIZ6lofUyjT1k0CVgZoLHM42vi3mSHwchJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO//nN46YANBVQ5yjAljPUEipN/flOxrslSqQ9VgLZgA5zNyBt
	ZrAqy7s33yLntZIJCQHlAm6NZdQFt1SmeIr2hauHHaWzrh6basyKS5c2
X-Gm-Gg: AY/fxX66jPvVP1ZeJ4+Y85Wquq13xpmKdp3Xb4hn5Y3BJ5JcjBnIHGCx5apkuCnm8gB
	FjvL3Ka6kpVelBO25gaBo9D2pfJOmX6YS+WcMiHuAZntHLnKgdA9K4z5smzogQAdfY1xQLAawfQ
	jsghCm+yvUuJ7vLAq864h5kdSsqlJ5vzhjK1RST04I5roGSF/OjFSrO4dbFIaRk8JHQ60y5SXe4
	y2vPa8Hw4iAQPzzSCOBNo9iRKT/4FAcsWm38ktWiArxXqogqu7m4PdEh983pFTPn6ftqD+cysZN
	OCX/Upqit+BNfmW4bOJZ5jpqkWxfVQCqSxOK22DlTYFh+cpO5jg0aQ17X2GeCSw79GlnrTHL+0Y
	JfWKyTfdfmv1mQ9mxGlBYCmBvOrMN+UiNXZO3Vy1KTsZXCPhGxDcwwKc17roMCfmT0XbcEJS65s
	ILUHx3yVDvIrsybjbes4kTOqmFtss4MS8mUWAA8zfU0RhY+aRgvwKsHwS9h4w3ypO8fQ==
X-Google-Smtp-Source: AGHT+IEHUQvc3EmqYzQZt6ZgtZtV1IqU7R/do8HrKFOIAIAuIe5e4QFd/ZoYO+yZg0EEOGQs+pikVQ==
X-Received: by 2002:a05:6000:430e:b0:432:b953:b02b with SMTP id ffacd0b85a97d-432bcfd3d7cmr8387191f8f.16.1767796096871;
        Wed, 07 Jan 2026 06:28:16 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dadcfsm10685238f8f.3.2026.01.07.06.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:28:16 -0800 (PST)
Message-ID: <331595ad-5c6a-4e01-bd0f-1dabb4bc0fcb@gmail.com>
Date: Wed, 7 Jan 2026 14:28:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
To: Collin Funk <collin.funk1@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>,
 Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
 <aVrCHr_NRDqNjPn0@fruit.crustytoothpaste.net>
 <CALH9GrYOjb92gjrtdjwapFH9L73XGg1Kan8uz1aVLpSXNURi+Q@mail.gmail.com>
 <aV2ZS1lvLivi8xRH@fruit.crustytoothpaste.net> <87secimchc.fsf@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <87secimchc.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/01/2026 01:35, Collin Funk wrote:
> 
> An unfortunate trend that I have seen with Rust programs is that they
> completely disregard the systems locale. E.g. using
> LC_ALL=en_US.ISO-8859-1 and passing an "À" character as an option will
> typically fail since it is encoded as 0xC0 which is not a valid UTF-8
> character.
> 
> I figured it was worth bringing up since Git may wany to think about it
> some before introducing more Rust. I think it can be worked around by
> using OsString [1], but I guess many people choose not to.

Git will certainly want to continue to support non-utf8 encodings. 
That's perfectly possible in rust but in my (rather limited) experience 
it does take a bit more effort than the equivalent code using the 
standard library's String type. I find it particularly annoying that 
"cargo run" refuses to pass non-utf8 arguments to the program being run 
when the program has been carefully written to support them.

Thanks

Phillip
