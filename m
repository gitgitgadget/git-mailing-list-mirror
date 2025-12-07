Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616CC22C32D
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765102659; cv=none; b=uEFu0PRoE1d4y0Ok3HqlYqT6fjUGYkZNbFX6wqQFBlS8BXg9DBE2F5sRujOZOWEJyzq+qNCp7RlPjOcX8RTEs9vNyFGuXKeNV9kjif6rJLp4rrgBhH66mVGIoEkM4WEKZXPPowNm1Hzz5tF13SrATagPuiqFI8jic5wKb859TBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765102659; c=relaxed/simple;
	bh=vPBGDGog7cwGaJrzo2Ouw75MmohXsyvVFGZXs8+UBTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyvNAiLc9z5qpBCb7lLujCfmU1C6JZB962pcmvkHofsx6nhckihH2bQfbTFKJQdhWsnFysmKk0oNQv5uAmIBrlvFvp+llRN3d4rTzIndypkhDbCPqlGFcP9wgx32eUZud7yHQbw66kD5vriIdvly+azxnEdyIGCHiZq2QCNtgeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSrqZttR; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSrqZttR"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2a45877bd5eso5672639eec.0
        for <git@vger.kernel.org>; Sun, 07 Dec 2025 02:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765102657; x=1765707457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vPBGDGog7cwGaJrzo2Ouw75MmohXsyvVFGZXs8+UBTs=;
        b=OSrqZttRLI//G1ipZJrxp/da1y2vF5rSEYiMRFUHDC0R0kO/SJ5+Rk5eux9wQHzS/Y
         aGDtqdfo0Rk52kmZh85Lo1M/3YXRTkoGLqRfGOA2BsbjBYgjdWhVJIgmHSzkoS3lspRU
         Y+k+bjNulFUVNM4DLjQ/ovYDtze7+LGL+//KZRvLN2NGK16KjsG+B+q4aG3De/alAg4X
         sw2b1EOLiK9L6ffyna0UXfWVFwiY3MjSGJhMWPoMGNmLM7/ixHfBOBL6g+twPey31Wkb
         V5+KJznfTtgGsqLAnvQwi41omR/Fdm+b3XzebON4ayXjIIfyV4Vn5BI1lNveZ7HCfohb
         +ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765102657; x=1765707457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPBGDGog7cwGaJrzo2Ouw75MmohXsyvVFGZXs8+UBTs=;
        b=DM8mYgs5IgSBEpZJJZonHVss8Seo3LvS8+YBnpiPVYRWRlACrPdWbxtF7yj+ugIWkA
         9uqgsNJqJlLkNh3YBH+0v1jWtl02k7dcZMJF2dB68utjPUvB5MyS07fYNN2V2e7vrpy5
         RwCxPCZnTnyXAn0CT4stTB32Xxl2j2yDEuBM6j7PUEzsFz/6fuDvTl7svxyAo2mKMGQt
         6UcyWxFDzPSfRW4xFPbwUV2xv1jRYbktftbUOHery9bYoIv6BnNYNLiMH/jYVnlKT3EK
         TBiBbJsLYWd/YDlhdJZJwyNMgh6DnFTKLdMiht4MJhLhZUh8GeZKiBgmI3xQT81jy385
         dl2w==
X-Gm-Message-State: AOJu0Yy6qtpJnKbfFHxnKqxFYP2elLxeMKcEK+ou18bOLAwODhUhPIwE
	/Ej0hJ1yRx8e1P+kKPRmTludTP1ZUYJ5IfsgzqqZfIDV1BWii8qmvpIUCCZVYA==
X-Gm-Gg: ASbGncvj235fsfPy692FQpwkZcYAgWPU2CrRUG0WXIso59dmmHvOVHcZViYqFf2DxkE
	Qw4366km/hb2h8RQabas3IU6k5ZRpADoGOgtr8FtMik62DY3jjjVRopCG5WJGWXf5Sr631+PhAd
	50IiuQqfjj8eBJIj0jNr7Z7F4utH1kMACbDOK7PCxXan5p7DfGPIUzj87PnK/LCdnCk0Nqp/6n3
	1NhXAZY36oyHgFoIz5LB3GY++cBw+GWmDbTRPo7pDIc4MNL64Z5HG1oLYliU+K5Sb/Rb8B6rvgl
	grQfCnS5kRFW6BCCLCjPDmBWA8zB+Km1EBOpTEKcqxXROCaNFH0IfiP1S2ElXBfD06vAVF2nBnx
	5oTw+nuIrDLB3anDCgNlAreYKgkU6OdPJAG/qTt15qPO3Ae9QMW8R+UgQv3jCqipRT73RMqNPNh
	RkZ0c2oyAYONIvB4Z+DolreJXxYdzgmwQeZieR9ZIMBGYzWIB6UVU8FZPcPuTki1oKF19vu62YB
	sa6Dp+/f+CtCZBptEsYzN3++i9w2JCosmTh+Wya5HzdHg==
X-Google-Smtp-Source: AGHT+IFznJ5PEvynlTOhmEAR4QRL1GzbWXx7K99nKDMuVofGdHyG7SNQEk/5dLesnSD0V8Siq8MPUg==
X-Received: by 2002:a05:7300:8818:b0:2ab:9d23:f0b1 with SMTP id 5a478bee46e88-2aba34c1809mr5795166eec.13.1765102657262;
        Sun, 07 Dec 2025 02:17:37 -0800 (PST)
Received: from macbookair.lan (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87aa5fcsm27279293eec.3.2025.12.07.02.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 02:17:36 -0800 (PST)
Date: Sun, 7 Dec 2025 02:17:35 -0800
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/2] Few fixes for cross-compiling with Meson
Message-ID: <3tucvydzaelj2mngkocb75l52nssxkkdtt3dj4paviatd3uvnc@u2sy4vig7owz>
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>

On Tue, Dec 02, 2025 at 11:48:07AM -0800, Toon Claes wrote:
> I was cross-compiling for s390x.

Just to clarify, you mean Linux on IBM Z/LinuxOne, not 64bit ZOS/ZVM, right?

Carlo
