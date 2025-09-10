Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744532F75A
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515404; cv=none; b=s92Q3CD6BZOYeD4hjtYDDofPWK0FIMLKEQMBcZHr6JjXQggLT0nnjZtsyvA6RcODG2zY+PD9GYLXLhy7mT36fz7HL9RD/50jrRSBNrDjLQsriVAJVbPUWAIcs53lf1uCNr2pfYH5zT5sU1FMszaiG8alLqlVEgttNTIp1rmJ5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515404; c=relaxed/simple;
	bh=aIrVqxBWfYb6BPJ1zeSef0dcT5h2/kMu/Ykrn9Zd7j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSfjdLnQx/2297IEEpDfSGoe7GxScO0/CN4jYSdQVfDa3rqDX8x+eBLmfjjAZC41MlynYY9+7N/M0xh5UR+bfrq3+2uhQcV3HsIxCVAdTqsOcCVdeMauJsxoQgdfImItOGISdXFu507MmTE/0qQFK7cUuoFU0FVccw4eyNdp4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTjwsJ7K; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTjwsJ7K"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74526ca7a46so2708948a34.2
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757515401; x=1758120201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvNpxsSBosHJSiL2sj5bsT+SBYZNJphNmmoAIjxVgeg=;
        b=fTjwsJ7KYOAL4G3ebKk7kXwReHMaGNE8ewUseCDek6vcXaixAl0mItGw1Xa9gVyEIf
         c55vjhqtBHGf0iYJuI99o5KuWnaFilXARwqbKb0oGQTHDOZluglCU6dUJv+TOa1iCPlh
         pgBMsKdPIKX0vcIdREqqyAU2YJ82E5Yf8AisUiDAUacZUlOeVNSJ8X1Tci4v0D/JV0ux
         rA3q1cAGPBFhL0DzSCcFAAXtY/r8ybl7FBaTc8wkroMvgdA43di3Hi+KCBKScMQ+DGys
         H47LL/Tlv3mXC/jyhVWKnI0CFSkpuZoMG1R8cy7ZKBNwLxN5mZ7j8gKwQ6pL2Xsw80sR
         UvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757515401; x=1758120201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvNpxsSBosHJSiL2sj5bsT+SBYZNJphNmmoAIjxVgeg=;
        b=M1AGA5ZpSAwwhV2FKif0v+Uxk9M+9S3/LHC40AXopo8H9xaRAM5mu/a01a2MtTsLTi
         hMK68zzfva00biq52hzBw7JOTB5+QFiBDJQLhUhCleAyQqoeeVY0L85y1uqESVxE3ALP
         vxj6zRWG52XCrzQo99bDwmqhzdn6J9mqwQODNcFPr3+LQ6yAEPAeYldb9e65E1KUR58W
         kE0C3i/U7sB3FkGrvoFBiX8AlTvzq1BUVazGHtl1iEd8u1k6lhVyINFtuu1ugSRRuBoi
         XFbzgnXHYpPqLfBPpeSPqe5MGiNq0KCffmYO8+i2Bp2/4i2PAbG0eP1H102Vm2TSdc/T
         4New==
X-Gm-Message-State: AOJu0YxQJrjAA8+DGIe7ny4k+Q98tkf7J778ZbJVPla2oT4QwbFUYspm
	ldwU9FpUYYTQGYO/BTd6EYNef61xTyR/1wG9Z6l8QqA9Z69jRH6XFieSrkrhUw==
X-Gm-Gg: ASbGncvFTx6pID6qyU9V4la3ZJ2xA3FHyLz+sF9fsX5HKX7EzSbEMQRmEo8i0KZQHkB
	Cb6os8jKsxn45Rq53K9iNXPnUrM34nrkFwfqRwN04nK9hyN1qozZIkAXSgf8gImUs414BSyG1Xz
	FP5L4KtBlNWJRN2HIdlyqWhMGnGmCjvFgVa59Q2tJBcP3mZZNY1WPPOoaLiWuBDK4ia+hOYW4cq
	XkY3zG6TeT+eBI+/v1XM4yvG+xhUqCW4YHhC1wHnRE7ntMjtJENsi9j3Yd84rkqKSp1U/x4AoR8
	p0d5+XcbaEAgnvrAm6NgcyE/3IYY/lCTvPmc8jSi9Aw3GdEpJofSpPi41AC7CmRwGhmglR+v49U
	cukdpDVVhwDy2NRplbcIXCA+/xUE=
X-Google-Smtp-Source: AGHT+IFzPl9blmTlBHzrUcuVVnyrqkf5MQ6xZwcxRblmYvcy0sbQceeckhsfoGTO4Gq/+Bhl8BZ2Ew==
X-Received: by 2002:a05:6830:668f:b0:746:d8cc:4bb with SMTP id 46e09a7af769-74c704b57d4mr8957089a34.8.1757515401429;
        Wed, 10 Sep 2025 07:43:21 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7458e848c23sm6850121a34.43.2025.09.10.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:43:20 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:43:20 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] odb: drop deprecated wrapper functions
Message-ID: <fho5ch7r6d54tqxd56s4lcrv3ms6w4mytpbieere3qv3lz34zw@ufb22yd5w6xl>
References: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>

On 25/09/10 03:12PM, Patrick Steinhardt wrote:
> diff --git a/odb.h b/odb.h
> index 3dfc66d75a..e8b9dff948 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -475,37 +475,4 @@ static inline int odb_write_object(struct object_database *odb,
>  	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
>  }
>  
> -/* Compatibility wrappers, to be removed once Git 2.51 has been released. */
> -#include "repository.h"
> -
> -static inline int oid_object_info_extended(struct repository *r,
> -					   const struct object_id *oid,
> -					   struct object_info *oi,
> -					   unsigned flags)
> -{
> -	return odb_read_object_info_extended(r->objects, oid, oi, flags);
> -}
> -
> -static inline int oid_object_info(struct repository *r,
> -				  const struct object_id *oid,
> -				  unsigned long *sizep)
> -{
> -	return odb_read_object_info(r->objects, oid, sizep);
> -}
> -
> -static inline void *repo_read_object_file(struct repository *r,
> -					  const struct object_id *oid,
> -					  enum object_type *type,
> -					  unsigned long *size)
> -{
> -	return odb_read_object(r->objects, oid, type, size);
> -}
> -
> -static inline int has_object(struct repository *r,
> -			     const struct object_id *oid,
> -			     unsigned flags)
> -{
> -	return odb_has_object(r->objects, oid, flags);
> -}
> -
>  #endif /* ODB_H */

Nice to see this cleanup. This patch looks obviously correct to me.

-Justin
