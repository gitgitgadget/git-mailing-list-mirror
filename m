Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491014D439
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945702; cv=none; b=osYhrvVF6UoAZF+CTqF6e9BLQT7tCuqvcx42rYjFAvjq6jOfzkNrzfvmG4moQzjWnOWcV8KUkCTcUB7Fy084ba0eEG6U+/IoImUd4g6ywG5r+FGzd5vbVQGO1PQdzBKqLsRJF1YbQhZui95XbfssPW6xmbZ6dBQxsbUgAomEJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945702; c=relaxed/simple;
	bh=J7fbIAhE4jCNonn3aAeFna0drxxSUsG9x7GT4GluIM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf/um6NbElznEVQEudxdGpv2XS9NMV0mTX3zuhxgi+sdAZdYveUTx9gAGllgyGHaL+dVXvWi4fGLqIRqEZWRKm4P0wFgxf8gJYp2Q7gXuPN3n91NadGM+wjZq7qASwdW83lJnK962YdT+CDeiDA/q/GlklxRUtTIEgY8xxhIB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BdY/W41u; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BdY/W41u"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e28fc40fdccso4355643276.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728945699; x=1729550499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plKzjz2l5FrcLS3tXpeWnFAIfurRVP9/Y6RAvKGzKLs=;
        b=BdY/W41uf9qinPaDWqQQJuWNWsrsabigvpsNEKXOH71DJu4I2v8XY1KCOADKANFpaV
         7/rZHUuEvTwA2taOomkgHEdEvpuEL6XiS7kskKXOnKlX10xW2SLsOuwRLu4AIi55vu9R
         Z+xeOQ1l8U866+OwFiM9SwuCuCJMDkNqJeaWnPA9yzHsZ5+CbqfH5WHM1a/G/bZmZ0Nc
         iJwqe/CkfwUC3vczD2Sg05Bx7s+l7bdk+dXIUEUbkp3RgwffvgSM8aTAkMPic0BBA2IE
         Xr29LwQC9w+8eHA14KLz2HXY0rbiz++IgXI7lFnHI/hwQOrav87wqlZj8kHZnJmmpja1
         NUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945699; x=1729550499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plKzjz2l5FrcLS3tXpeWnFAIfurRVP9/Y6RAvKGzKLs=;
        b=CYf5JheR50u2Q6SW0MB4VbMjiBuANiEgtDEpRu9Wd6bzjt4o6jEdNA4w9b0Zlyxf4K
         zo+N0iamC8AQbJoxqKnRNb0beQDviYWv1vJomxm0p/8mpHtnibmrWscNTmLAcDjds7+3
         R7bNmE0XnF0IrO5U/RYW6WyCJmoAfh86KKOByCOPWzFmyTRvnP9vxt+JzB59hTe6id0T
         arKNxlVyHYkHwm1J/0YkP5saNz5Qa5SVjzQHT22ivGyxd2xUtpHVonsazqqJm87aqaKY
         sCP6eQi8fbPd45IhoXrPClpUetJg8Sn/cbA8qJRMkHEUuzlrXQ2R0/IlW8ZFepKXoBVp
         2BQA==
X-Gm-Message-State: AOJu0YxZZVWlJFHW6G43ZXxovPtSwhU09CnZekX9bJN6775Poa3KkZ39
	m0Uoa4v0aN5lv5/gP0TbHNTzByZKEZTis+u/j093vfZsdcF09TAZGvm4aFvIJU8=
X-Google-Smtp-Source: AGHT+IFvEWCMNiw4X8SwinQaSnn9h/cygO2fkEJG/UnERd44cjGz2IJxA0IdaTJmZQ+1oM6zVQNulQ==
X-Received: by 2002:a25:6406:0:b0:e29:494e:a21d with SMTP id 3f1490d57ef6-e29494ea4c9mr3843382276.22.1728945699445;
        Mon, 14 Oct 2024 15:41:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfae04sm13825276.4.2024.10.14.15.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:41:38 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:41:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/10] reftable/stack: adapt `format_name()` to handle
 allocation failures
Message-ID: <Zw2eIbeWUygH9+hn@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <1f08163009b87596188165863b89b62c5f521e00.1728910727.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f08163009b87596188165863b89b62c5f521e00.1728910727.git.ps@pks.im>

On Mon, Oct 14, 2024 at 03:02:37PM +0200, Patrick Steinhardt wrote:
> @@ -846,7 +846,10 @@ int reftable_addition_add(struct reftable_addition *add,
>  	int tab_fd;
>
>  	reftable_buf_reset(&next_name);
> -	format_name(&next_name, add->next_update_index, add->next_update_index);
> +
> +	err = format_name(&next_name, add->next_update_index, add->next_update_index);
> +	if (err < 0)
> +		goto done;
>
>  	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
>  	reftable_buf_addstr(&temp_tab_file_name, ".temp.XXXXXX");

The conversion to store the return value of 'format_name()' here makes
sense. I was going to ask why this call to reftable_buf_addstr() does
not have its own return value checked similarly, but I see that it is
handled specially a few commits later on.

I think that what you wrote here is fine, but there are a couple of
alternatives IMHO that may be worth considering in the future:

  - You could do these conversions function by function, where each
    patch handles all potential allocation failures.

    This generates more patches, but makes each individual patch a
    little easier to review in isolation, since the reviewer does not
    have to page in and out the context of what different functions do,
    etc.

  - Alternatively, you could mention something along the lines of "this
    step does not make any of these functions entirely resilient against
    allocation failures, but future commits will address the remaining
    components" to avoid temporary confusion on the reader's part
    wondering why only part of the code appears to handle allocation
    failures.

Thanks,
Taylor
