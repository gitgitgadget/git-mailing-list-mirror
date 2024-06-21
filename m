Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2AB170849
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964632; cv=none; b=fNRl1vx31kw0nK1wmE7/ch0nbHwl8OrEcHXcCNh9wzUohZfql9KTDHBzMI7XvdFtK7jWcXY6rp46PVBTH+byS0l8kXLksOos7SYyHm1xbtnggZdu0Rwxpd/SyuhzVvLCPR65yGAJ9uOLhaTr0vgDQLfmQRFdh2kRSlQNjvvm2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964632; c=relaxed/simple;
	bh=mdvOiTnoiFmmyF5/dZ6TMsT5rDTkCUmMSBaN5/eXfdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZId0GGkGViLJMAznnc4yVEyKB+3uWclGASlS+IM5JvHYONGQMvt+Zx9Hhff9qBh1rmQAvGdKwZyLSSzmNatuG8GpfFPCIl8hEXkHkCAMvW+NwKFSsebekSksDZnRn9K89m6Itc+rkLbfBwScb8KU/nrQIdbRp4wESyJnMEMNl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsL7FoVu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsL7FoVu"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso16447245e9.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 03:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718964629; x=1719569429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aqg7uDsJC3d4kGwAZLbbtzIwjS88rBaQm/b4yM4aho8=;
        b=DsL7FoVungQT1yJj4NINDpK8keSWtrcnezOP2ndagbkKoilXWvRO2g+obnY5S0d0pM
         232tZ+epVpKSBn8NjouuSoc9U1ZrnsjrLIdOeN2lfUKweiCtpRUkBYHVA57lbLfnGi1D
         w6dlDlXrNFje4Ck8/rTf2Pb5fwbDRUCio+3LhpRIYpfuNq8ozTbBqnvuK/J0ZmCAVf1O
         DmPExKJ05dmNyuLcWjdELyCBzuyCXiNJkMU67XSHOsbh3+uwNdLIVcD+szhn+l2UpUNq
         2N8c1XbIFDm6aYwNpQH85Yhpw7a5XdBVFFKccPC2GHrO8D2pxsXlg7gsgCVJr1ycNLHa
         8Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718964629; x=1719569429;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqg7uDsJC3d4kGwAZLbbtzIwjS88rBaQm/b4yM4aho8=;
        b=QEwRB/Tm1MiL3wtgGTyvv6HyXfyYkqBVZ4Ri5RC/MXxwfD53L7gucR5WtzVW3HG4oO
         tdX38kOJduUs8cPKDKnR2chf5g43/Y8TMDT/kY/e0ezjIIazfwzaxe9ZP9Cx7099sVE2
         naiQQhfUTcqAg3WxNZfmmPgDTJWsSYHdZ5lrl8jjGk+s+KXXDIiJnCK8iHPnXdrpDvd1
         DpwX/rCq5MOb7LtrmUJ4blGMVCUmcLP31NBYk6Hv3nOzPwG7+8m9lTfh0R+yzEfeD4Az
         qY08KEFMWJQ3NIiLIB1xJCPR5Tt1VkdCgZGwelk1q4TRCvWx6XIaHaUy8NCilZFx9Lgf
         E2vA==
X-Gm-Message-State: AOJu0Yy716l4foJuXAhvSC2yISWYfBhPNgCOJBq1hwgTEqUBOFuX+Fat
	mJic/Adbtp6unns3UewROB+DIaByzBYxp7vHmFthgLcNokfBJ38o
X-Google-Smtp-Source: AGHT+IEDJgx6LpHxw/NoWOlrAudG7lIsNYOZiBoyedVq9/aQmvN2v9ZxURChOU9Sn+ZO/QeJI2p8Ow==
X-Received: by 2002:a05:600c:492f:b0:421:7198:3d76 with SMTP id 5b1f17b1804b1-42475295f03mr58607405e9.28.1718964629049;
        Fri, 21 Jun 2024 03:10:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36676e11337sm954758f8f.1.2024.06.21.03.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 03:10:28 -0700 (PDT)
Message-ID: <d0deaa08-2894-4e89-ba51-7bed8e785ef3@gmail.com>
Date: Fri, 21 Jun 2024 11:10:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug: Git Maintenance does not register multiple repos
To: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: git@vger.kernel.org
References: <CAG=Um+0LXVRHmvKdTB9WHJujjh9agK_ZHdv45ffzMsqX65NLVw@mail.gmail.com>
 <665f77a0-f301-40ae-ab94-2920d15fcc8d@app.fastmail.com>
 <CAG=Um+1EyB08n7oH6rgqPmmn0OWndUdv4vEsY5Hcv3aaf-BHxg@mail.gmail.com>
 <4480de3f-851f-4cf7-889f-b5ab7c4e0223@app.fastmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <4480de3f-851f-4cf7-889f-b5ab7c4e0223@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/06/2024 07:58, Kristoffer Haugsbakk wrote:
> On Thu, Jun 20, 2024, at 17:34, Shubham Kanodia wrote:
>> 1. What spec does the config file follow?
> 
> Apparently there isn’t a spec because it is bespoke.

The syntax is documented on the "git config" man page.

>> 2. What is the correct way then to get an "effective" git config
>> value? Typically, I assumed that if a value appeared twice in the git
>> config, the second would override the first (for say, `core.editor`).
>>    How does git parse "overrides" vs "arrays" if they are defined using
>> the same syntax?
> 
> There are two dimensions
> 
> 1. How config variables are parsed
> 2. What is expected of the specific config variable

To expand a little on what Kristoffer has said - this means that you 
need to know in advance what type of variable you are checking. You can 
do that by reading the documentation for that variable on the "git 
config" man page. "git config" also offers the --type=<type> option to 
normalize values to the expected type.

Best Wishes

Phillip

> `core.editor` is a single value. You can test with
> 
> ```
> [core]
> 	editor=vim
> 	editor=nano
> ```
> 
> The last one wins here. `core.editor` expects a single value.
> 
> But you can define a multi-valued variable
> 
> ```
> [customsection]
>      mycustomvariable = value1
>      mycustomvariable = value2
>      mycustomvariable = value3
> ```
> 
> ```
> $ git config --global --get-all customsection.mycustomvariable
> value1
> value2
> value3
> ```
> 

