Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15864AEF7
	for <git@vger.kernel.org>; Wed, 15 May 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804246; cv=none; b=VCGbRV92cgrsVUYx3MUGMKjieeu4OCXNggycDFdjiAJ9MLqJad2XnnTOZp0C6G7bwqR1zrEgfAlmmH6HT/uNHLX51/Z4lYuktfFt7E7Banq6tyTpl5vAY52XcxuXSzntMg+dKqF3cyU+LSUxsKGVRpCcMjGHWJNjlgGdBbp9CXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804246; c=relaxed/simple;
	bh=M83YlqKe1Kc44BMBnNYeAO4QNfdldoG97aTtjejH3wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYDwc/HRNWYumMyrlD0vmYFGwt2htP6glv9a1jCpW2ml+qwGN7eXCVdnxEekpE7cdxmSheKxFONr97L9jdBuAHl1qqbT2zUlg6lijk40A/AvluusMV7wLI86c3UIWICwSoKkhXW3FXO/GC79lno/qah0kHNKmjxTZ6TYKh9Spkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aldo+Veu; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aldo+Veu"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23f5a31d948so4699428fac.0
        for <git@vger.kernel.org>; Wed, 15 May 2024 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715804244; x=1716409044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJT8qu+bSvNth+L+7zjc1rB+zeGcqBhfyoeWQlOEWn4=;
        b=aldo+Veu0QJnExLB7VUs6K9CIySqFbIwlGuNrZM4nCGgUTQvQ4TyMcPIQ3fMD2qRnQ
         q/z9kw3u+cmBMXm/5ENixYbGfZdx6KhzN9VsFef9Tw1/yp9l7Kp+kxYXCUHeMfgovQ5L
         fOW/FGMejOhtk1GWAutmj/SOllr5hbHweZbcYu6kT3ZipeW3lattEVmgBTHF1cum9OGp
         gt3/8RgCGdaLQicUVG2g3L/EzR/JEGVMpaKsKF0Mj58oc15t0vOSv/EtpmyR7dkUC1Uf
         noprFyuDK3dlfXzeIRZaXLoEKJXwXEXQOxQMOlPH1lo25tOGzTzwVsUIG687CiyEbB9N
         OX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715804244; x=1716409044;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJT8qu+bSvNth+L+7zjc1rB+zeGcqBhfyoeWQlOEWn4=;
        b=Zl6a54PBlKLYUS0kMxrqZQwfrLVYeIbVORexu/89Zb0ADgj7WxGbPALe9iEIGsIwTn
         m026m2tvtTsREodxm7kwEZjOYcNJ9dyRmoy0VVjdPP3mH0teWBnBuFujC+NkOpzxuEh0
         UR5AP0Jzx5Ca0Kd3VWJ5X1Qs89gosqEa3na34fLzpP0oQb894COg1OzTZ125YrgYOYU2
         ztKbSEteR914jnMyKLvrhZdgHJQ1Qcs4VapyPy3cq3nuDZ+MOt5oBGGX929HO2/VHdJs
         6kqj4GjlEzNNLlBZgb4NzUaUkn0rG4C4L6tq3LncHTFOSY67RkKuIYO+sOvG1QG+2IV5
         bSKg==
X-Gm-Message-State: AOJu0YwN5m22W4MBo3Z2xQs5hyWCHfprUObrp4Q+Liz0WP2r4n7TFTnO
	wJpS5C/lT/flmYyWzDr7zClvhbU7SZKi3agUVXJ1C9ZH8WmRDU9Q
X-Google-Smtp-Source: AGHT+IEgpTpAUSfsnr0Kr+sFDn5WS7zQQqZal7/RUsOROEWqR6igvFjtgE8GNonSDoo/izCWZb6LwA==
X-Received: by 2002:a05:6870:4191:b0:23c:6cb5:24f6 with SMTP id 586e51a60fabf-241728f480cmr20576753fac.7.1715804243482;
        Wed, 15 May 2024 13:17:23 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412ac756c1sm3180041fac.44.2024.05.15.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:17:23 -0700 (PDT)
Date: Wed, 15 May 2024 15:15:55 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] reftable: prepare for re-seekable iterators
Message-ID: <hkjaxz4qykmiby3xxsq23mnlawsp7e6kgarbvo3owdoepi6dii@znu6igt7ki2c>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>

On 24/05/13 10:46AM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that prepares the reftable
> iterators to become re-seekable. These refactorings will eventually
> allow us to reuse data structures by iterators and optimize for certain
> cases.
> 
> Changes compared to v1:
> 
>   - Various fixes to commit messages.
> 
>   - Fixed a copy & pasted comment to refer to logs instead of refs.
> 
> The series continues to build on top of ps/reftable-write-optim. There
> is a merge conflict with the in-flight ps/reftable-write-options, but
> given that this series has not yet been merged to next and because Junio
> has already resolved the conflict in "seen" I decided to not pull it in
> as an additional dependency.

Thanks Patrick! From the range-diff, this version looks good to me :)

-Justin
