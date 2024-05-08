Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F556A8D2
	for <git@vger.kernel.org>; Wed,  8 May 2024 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174116; cv=none; b=rEHWKkHZ+xV0rYL++dvzw8POGxDq67DWjxwRnSx75ag6s7caEc25sWBYEgZB6ARRkiic24ajkatiDfhHiRnfSR7MAOtg1g8Z2nToOVqngia6RYTwkYsbHicEMidcskxKIETelqBvhZdPJsPvD5F1xwok8PbmxrznGwHsG1umuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174116; c=relaxed/simple;
	bh=Bs5GXNeZEaYjPVR5X0LLgsdP9ICbe5teRGZIAxlo8r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXboxh9+Ubw6dMnrSwjcHpig+7xb6ZHdG3n3uSgOc4u2ETh8j+Morp8C04+FRVb7qzhCVycojhygIFBX89EF2+clNok5fRDRkuATl7cnaTnbr9r/tpcwvMlxHvBGRtgwyF28qJE6ojhpKCieRZwXkwwxfVShd5sDbxzoFUMGEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZECg5vw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZECg5vw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34db9a38755so4098226f8f.1
        for <git@vger.kernel.org>; Wed, 08 May 2024 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715174113; x=1715778913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0e13/rvS4QWXtWlzpb1obEUgNFQTVoXLqZb6qJp5KU=;
        b=XZECg5vwMwP4Z0Oq0FnMpsOG66gf0WY4w8w0ExGoZ2wFiI2Ge4zr+fuHonSj6gNDsl
         tcIBFSPZVw1IJYIY5ORw5oS7MhtDIL07PH14CPvOlg+IrPfZdDZWwMC4Rv9Oby90T5FB
         vw4Jq+Z8qsMYZP/Vu+RLoNegqDn9a7AFgejpxOaL2I/w9sfMbhgjTyOZ8U4he27FBcVF
         cIBWIFEcdgnf9IYNCatXgZegpZRGuIFhZ5NKE+gtjrJSya1UiUvyhlqqGFMRzLT+3Fe0
         ykR1aSUDwzi/gTSw3VgCzIlxMDcg6PHbv1GQFPoW1conEejXw7VfaSIJtZP/5W6lZQFs
         ziPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715174113; x=1715778913;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0e13/rvS4QWXtWlzpb1obEUgNFQTVoXLqZb6qJp5KU=;
        b=a4OGd/xZ9WNiMotKgh7sB3+RKlCeWnTjnkGBNZZA9WpbgwcT6IKBXUh0ifNHDxRz1Y
         ZeKW1/vZPuRsfyQrOVGtWLftq1j1bO5dC2Wz548qPbHuy/pOdYZp/WPq10aCXv14thXt
         B2FHBAmItWz+XtLjqz7ehZyQV35DgAAA7GZyF7HvumoAH2hIFwEGi3keZ8ChjAz8DKpy
         rbsM1fuCzDgyXOQg7e+4UEHoQ6QDavXD9hQJObEMjJ4IPwf+NjrWoCaFjnvzjLmJvPgw
         uUDzdeXHkW/lgN5Sq772/Bc/jahfqYXfhFTmQBn+fpmhg3ViiQ2R7GRJOLRitjcNj4oe
         W4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWE3PI4Xy1oLL9qNZ2aOj+RScc5YwjkJ8OPgUD7bxi1x8DBHKZvpsnzOOT3jHoUXUOfRYirn5xV3LhLG0+3kiXuqI5k
X-Gm-Message-State: AOJu0Yzrl+WnlGJz2OCco/vY3VJHoxdRIl+dBlHjqQ86bjXp9fhF/FHf
	BHWYLDlSkgSpi0vgUkEV45du9RacurxYDMscwEPlyWMWXZZ6MWCX
X-Google-Smtp-Source: AGHT+IHq2ncuv9nrNFcdPr6x7CvLb+inz0RiCfIndPwl+o0zmrNKYRYLKPwM5hyKrtQhh8e+FIV2Pw==
X-Received: by 2002:adf:f851:0:b0:34f:41e7:eb37 with SMTP id ffacd0b85a97d-34fca2441f8mr2532856f8f.30.1715174112892;
        Wed, 08 May 2024 06:15:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0041be78ae1f0sm2328541wms.2.2024.05.08.06.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 06:15:12 -0700 (PDT)
Message-ID: <077b69f1-cffa-44d5-8614-7f83b63442f8@gmail.com>
Date: Wed, 8 May 2024 14:15:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

Thanks putting this together, I think it will be a useful way discussing 
deprecations and removals.

On 07/05/2024 09:27, Patrick Steinhardt wrote:
> Over time, Git has grown quite a lot. With this evolution, many ideas
> that were sensible at the time they were introduced are not anymore and
> are thus considered to be deprecated. And while some deprecations may be
> noted in manpages, most of them are actually deprecated in the "hive
> mind" of the Git community, only.
> 
> Introduce a new document that lists upcoming breaking changes to address
> this issue. This document serves multiple purposes:
> 
>    - It is a way to facilitate discussion around proposed deprecations.
> 
>    - It allows users to learn about deprecations and speak up in case
>      they have good reasons why a certain feature should not be
>      deprecated.
 >
>    - It states intent and documents where the Git project wants to go.

Is the plan to use this document to track the progress/status of 
proposed deprecations? For example the config based hooks implementation 
is stalled at the moment and would need some work before we can remove 
$GIT_DIR/hooks

> +### Removals
> +
> + - git-config(1) has learned to use subcommands that replace implicit actions
> +   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. `git config
> +   --unset-all`). The actions will be removed in favor of subcommands.
> +   Prerequisite for this change is that the new subcommands have been out for at
> +   least for two years to give script authors time to migrate.

I agree we want to allow plenty of time for script authors to migrate 
their scripts here.

> + - githooks(5) can be installed by placing them into `$GIT_DIR/hooks/`. This has
> +   been a source of multiple remote code execution vulnerabilities.

I'm not sure about the reasoning here as a hook has to be enabled by the 
user before it is run. There are good reasons to prefer config based 
hooks such as the ability to run multiple scripts per hook event but I 
don't think they are inherently more secure.

Best Wishes

Phillip
