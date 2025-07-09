Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A01CAA85
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047838; cv=none; b=BtJIwAWSy6Hw/aAvPTIHhUTZH+6rJu30S8js4Ircc3yIQDu8UUcteYCALjiRftPXkoK5e+BDaTbP2z2W4y8Xl42FZ7cCD7z9mWuJWt9v0n4OF4qrj0jeX4VkXNgXsfQ8UOYgeaxc8B0If2vMJQbpETxCjxj1AmyTIBVHS0OEgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047838; c=relaxed/simple;
	bh=zEtLJjFxM2wNVn/tts9l+gRTVH+haGk14OCF9eI7DpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL9ymypxBLKBxuWeaPCaW6X+iu0Yha078zp3xFE2Xosky0SEykg0d5I5kYsep53Q4TYKlyB1TdR6zKaVtVdqOA+lihqbUrEEY5FnLtHxJX2Qle6YbLvpGarT7lmBUCFQoj8QBP6L5HgA8D4RsISptvTZrG884n+hqjzOgNDc3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtqmlLKr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtqmlLKr"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b595891d2so40336741fa.2
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 00:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752047835; x=1752652635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zEtLJjFxM2wNVn/tts9l+gRTVH+haGk14OCF9eI7DpM=;
        b=UtqmlLKrJmiIFl/d9ln/NK2Jh8m7Ke/BJG6QVryFjXdhRTMxTEoswmDatS5Ra/EIOC
         iP7Y9k3ZKklts7kNV+6jWs0/jHO0C+m0gCKneCR8iRzsY3gH4v7xQfz1cjkA2yloBt0C
         dLmzVeqbVHRVXSZ62V8BPFi8PNgGHFgxLSXaAwICO9UtSIiu/OyYQa97dTRUT5Jscdgm
         7/oFBKP09nvJYOzCX7ph1SDclJmoKk1GGtSZJaSFGtwj+JU/g+ulQXgVyhF+dos33S2b
         hBOsRcFuYD+SHxktTKtwRKtBHxSdiD1DGZ7X17ZRzB1N6c9PcdbkcDWoOzle2cMv7FEk
         nUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752047835; x=1752652635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEtLJjFxM2wNVn/tts9l+gRTVH+haGk14OCF9eI7DpM=;
        b=IH6bigjrqLLYMO6vnMzGQ5rO2AOfhjVQT1zkRSqCKsdO0Y2xyNjvtawg6Fq6CDoShw
         F86bugk1dw2iMg3fIH33JVPF8UlLZDRTc3W0B6WeQqE6VSxoX86xP9083qArKUgcAHFo
         6g4mb7hfAgFD6vIQuZjfh75GF8snfsPpMExaI4Ug16cKHlwlGwtGfZZmWv8w0n7iXwr0
         Lvu0XNnGsLbbLWhPw85/sNfh5vic+bkg8b9Ba66Mt2pULH6Tar8IHij7RtE85YlRNDnD
         D9WTHghmsd4Ca9orSrEjlk+uXSAqNi81BKsugORCjXtL+NaMibF953UzpLkTV0W7ObT8
         dP2g==
X-Forwarded-Encrypted: i=1; AJvYcCWidLgFv1kuHtgBwaaYyQgv/MBU6znNswadxWucI+Ck0czyRshvDuGCBQEpU84IRkr1nIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5p3tUbaTLMtUQbj/kqqUd5ftyZFhY4KLnUtEQs05xKK3Mx8X
	WdkfinYrXMp4FvPexgiTC25wWe6wj2k9RsZapDcL9f1tr0EELTV6BJNaYhFL770KWK9BvA3nDIg
	FvMnhKMQFv7tAsyGyDx2B3ZCzoBTo/EW2tfTC40M=
X-Gm-Gg: ASbGncv8Ol63cBTJFB4pGCLyZZB87nCu5S+0nFqvPkXeGMn5Q6804eflgGEqUr1/fuZ
	Xwzkcg85GgOFpfDtHqUo1QjU8fYALvAFGErNu34c+En9PGnbm5GPGBD5WAitkG8tmmkV+QPJsIU
	4dIlgKp2vQT/TCSmIV2x5kB0oJY5aPaG4DrzwAPM8SJfKY6sV9cxj6qtJIzDvWC0jFMZcTIVOiN
	pEZSw==
X-Google-Smtp-Source: AGHT+IFFHLaaX7ADjTnu5oQTS+kydWEM7T1urz2l8768QEFLhvRYF8Zo3mZ0iMXyDhcnX8txXuo3zivJiZ4Iru2fd1Q=
X-Received: by 2002:a05:651c:2105:b0:32b:50c5:2593 with SMTP id
 38308e7fff4ca-32f484b0724mr3954581fa.18.1752047834894; Wed, 09 Jul 2025
 00:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com> <xmqqms9eql73.fsf@gitster.g>
In-Reply-To: <xmqqms9eql73.fsf@gitster.g>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Wed, 9 Jul 2025 08:57:04 +0100
X-Gm-Features: Ac12FXw5Q688SiKiNSuRSOAkg91aM8wtIrtXbbHsLV1amfPdfMWwUy7RQGAWArs
Message-ID: <CAP9jKjE0DiZeCB7LG-a7sFP+GXk8WoLy=uZ4qkyCjzYxpPopvQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Better support for customising context lines in
 --patch commands
To: Junio C Hamano <gitster@pobox.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <christian.couder@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

I will respond to everything soon I hope, life has been in the way and
I didn't anticipate so many comments :-)

Based on a skim read of the comments, the main thing I'm not sure I
will be able to achieve is implementing the valid value range that a
Rene has been working on as I don't have that context, but I'm not
sure if this is a necessity to add?
