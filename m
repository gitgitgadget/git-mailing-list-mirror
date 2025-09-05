Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960782727EA
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066977; cv=none; b=DqFsGP3RRDG36jc/uwx0AS2vKzdFnnZy7ac/CSmyAIK46VvAP+XD4hhehTZGwaAJxHRwSkCVey6838N2ub8amCEwOjQfjE/T0DZFphZpw/lG+Uj0i61Uiwv0pGaeM89MrAQN2/yi7s5F08p/HVFOfHYm0Tmdh2iUwLpjwf0wWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066977; c=relaxed/simple;
	bh=S5zvmTkZFs/ilSVwLTAEUrHrw01QGS1aa13Ad+7TR2I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W8bn+yFYfz7bGCw7c7XW5DtGxGDOz2dmX2vH0KIae7SBjIU04/gMipDsk5H0ZJKXxVpiJMav4tIsYdMuF6VCW/nal07BhkgqKURDycvTlX7I6L742wqJ91TKSJrupKtSHI57qByIoXoi7uPUsaFomtoBMKlW0dDslS4dQo5q138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy0JbigI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy0JbigI"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e2055ce7b3so944357f8f.0
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757066974; x=1757671774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=353ZZZODqvi/KInF692QfV+It6UAuRYrsj/AOxxjL0U=;
        b=Iy0JbigI3O1mpWWBskp2FavvvgXVAm2gRxE29AKVw+dxkg41FHZ6hR1O3MQ3+9NnzF
         xnR9A4lSn4Oe9B1hDkUiie8InTmIz501ZAaAOMI2d4EXM0620FJxogB2pI/63qLHOQeS
         QMOc+/ZB7up78zMbghUKuGHLktv1+DpwM2MYPJcBc+Amt5Mv68lEMHBnyFBHSAy3MF5P
         6chGF5sa5EA+POMrxnjEKNr3Ijydi2T11mYGy3pwiRYscG5lzuCBYRx0/KNcjja4UQYT
         eUNo3YaR1kEMc6l+Z7taDGwVKpgYdlzItHSHXemfkKEF+r5lttw+kCosAzNrlmM1xUfW
         FulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757066974; x=1757671774;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=353ZZZODqvi/KInF692QfV+It6UAuRYrsj/AOxxjL0U=;
        b=nCuMee762pMjk9n/d0LbIJd4AfaLCV8wU/1ktyMV0M7qNl43kxgdLwy9cSYf5NjSuI
         4L6hukn8r0D5OsrzAg+BjBxvKhfeBRsMoX0VeR4qN44zjIihVaS56zpWmymIvmUB9GTF
         ag+vmgCVA0PZztwlpGnfISLrULXhEA11fnMIyXs0xR2Rg2tMYV9E8yOHSCq8osOD/LIA
         Tco0iuRH9kFIBDwBxPPsNEa92LJLYO1MgEg1x9+fklUPp5uyGskMMLQ3TFiohK+9B268
         DDgrOW8A0hkfhmIV8uLzXCrwcF6o8zI4W0UGQe21GWmnJJvbFA0mDC0nkkApoIm1ArQd
         GbCA==
X-Gm-Message-State: AOJu0YyVXw+huSr4/jaRfifEuOcqQvLmrpLKpBoGnnjVlfPyKed3BLkz
	EWSiehX2Sog9IAAqcWt4jf+7hFwkkfvqMfAGz/IZPOMLXtp0r3iJ8/2i
X-Gm-Gg: ASbGncvAFTKKB2uW8YpuuJu7bKx8f71CP79iegl3qeFmpxuyThipxepjgF1TyW1GwRj
	OHmJSjfGUW9Iq+Jf4ep/CtgfwQlntXjmsrxcwwvhFoP9UjTOKTyC7QohYLmR4BJtyWVnkcRDxqP
	54YsCNTbcbxVezIAju7c4EnNc1AXSDG0qtqR25WUOMfWaS3wnD19y1kRrxImJLEAN+BBdRkOTT3
	ENIq61kt5YYN3xZfzZG71od4HIXzbsbv+WDeMIIDLQLXHU5bBKx3QKjo/wYxLPFU7j8ct0N/R/H
	EwNd51MPx7xj5r6ObJoQ+MhbzCazHMzPfG18xlvXiNpiED3CNdN0E972YkYg6N+TljWMPU0IeBz
	tFQfZSvqwHsDXm1iVS+QjIGmm1qW7j2Qi7liuwEvFsns6iyEut4GsbUKHmv1ldNemVXan9X8ww5
	eI5HGzyTRrx+6Gz4w=
X-Google-Smtp-Source: AGHT+IE2VoqmqtNnfbvoTwZsfEoygAHFnHfb7U02F4wpqpduaWxaXXNsvhqvxsPInV1pAENlBMtqpg==
X-Received: by 2002:a05:6000:2f81:b0:3e0:b982:ca3d with SMTP id ffacd0b85a97d-3e0b982cdd7mr4765425f8f.59.1757066973777;
        Fri, 05 Sep 2025 03:09:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d204asm31193309f8f.24.2025.09.05.03.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:09:33 -0700 (PDT)
Message-ID: <9f609d58-0abf-4bf3-8482-fc5487d72f31@gmail.com>
Date: Fri, 5 Sep 2025 11:09:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] t0613: stop setting default initial branch
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1756992089.git.phillip.wood@dunelm.org.uk>
 <c4d89c3761be77f1539668c8d543bb73fbf0dfee.1756992089.git.phillip.wood@dunelm.org.uk>
 <xmqqa53a83rg.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa53a83rg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2025 19:35, Junio C Hamano wrote:
> 
> Having to change this many "git init" invocations feels awkward,
> especially when we envision what needs to be done if somebody needs
> to update this file later.  I wonder if a new helper function
> upfront
> 
>          +init_repo () {
>          +	git init --initial-branch master repo
>          +}
>          +
> 
> with many changes like this to the rest of file
> 
> 	-	git init repo &&
> 	+	init_repo &&
> 
> may be easier to maintain over time?  I dunno.

Good idea, that would give us a convenient place to move the comment to 
as well

Thanks

Phillip

