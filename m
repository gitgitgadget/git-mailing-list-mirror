Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FA2F25FB
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769127227; cv=none; b=jK3mYN7UOLTEaeymnmMhS+VEFeT3dFh/M1s9iZFPKViLsoRBLjc3MOHMvIOSUo7SPH7PT5CxbMKxzOnAowXIMvauTfhrDUNL/9+qjlns6/+aT2D0oknYABqvk5LUSPwt1iVm4yja0cGjx99bJ8L+tmA44LgVAy+d+2RWlkxjROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769127227; c=relaxed/simple;
	bh=vVvvGz2ksrg/YAaGwYh9QW2B0MKETw3ksj7EozQR3WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XirZmSP8WD4owpTfJAaF7s82ky61mkLOiGfC+CbsaPaWjK8k63jjL+GsQHtH5Lhc7kfynV0WOUrfibw3eQ8838OIDWKOT5YNhjxT+kEWhXE/7P5PPOy8l7gt5+pGtD3OvxUKRhGUikWWFUX1w1O2vPI5Q1JBU/AcDV/AiwA7NaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GhwzpvSA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GhwzpvSA"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8948273f5d0so13544796d6.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 16:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769127220; x=1769732020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUjlJ3JJRE5eSNUWbLtD1kNmNjknV2pKOYXSsuzZqBE=;
        b=GhwzpvSAP5Xby/fBv5iskm7JEqnnp5OBRwJpCiYBBI7cfSj4jmT9ooRNPmKlCgcDeJ
         VWZNGn4ZnyIhfRoUgge4R5SJp+QszWYcjn310xU1rIp+x+SJ7pbFUqE1GaOEbqo+yVlv
         WZTjyRY/rIVdEYVql0g/2QVd7KyCMv9y/CC/a5n3WL46HkGpcqcr242WW5sBKzeOqlNX
         k12BB/r7OpJ2R9PVSWuLApOziSNwrXf1q8wqAQZDGRlOjOy9AGKF/YP6WGWZC6z0gB2k
         eKjNGE5+xstpMCWTyvqowkwbpgAyHapAbjwDW7kuk5kgwBZP39egZmF1H3Nx1432QdYf
         g/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769127220; x=1769732020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUjlJ3JJRE5eSNUWbLtD1kNmNjknV2pKOYXSsuzZqBE=;
        b=BqC/tBsRaGqIFCIOSswLsTAzFkyKZYqHCSdKU/1F1BPBej834tIyDXnYSMec66Tjz0
         yLOQzPrsuqKond8sX0spoW7qRDJ0lIitEj2v2gonWsVIJ7pAXKqoN3VHl6X2yZ0oyCl9
         OtE4j4tdTLNDP1zVoebuuV7gyTWRUGjyQLQ66zDhg2OasOzmU9/TLAzb54LTwiIr55t7
         sO2PEbTfOaj5G4b15R2vySxy/KLwktGEzYbG4L/N3NAp+WCRJSIRHBHuqU7sUMp1/Ckn
         FuTM94UawWvHx3u7C8qndq0iE9apbkd5im82tN8qw6lyxvjgMq9hDld80JekQMWRmc/e
         qdhA==
X-Gm-Message-State: AOJu0YxB3g4uvcAPycvAlk9MQ1idjrS0YQDyL04zI4i2dgU8x3SNlpML
	BW9YkEQmRZAJfv00mY3nSoVfgVgX9Xle458WkzCk6jXsnW0sH2mqzIX7UBnhuB6c48c=
X-Gm-Gg: AZuq6aK4lfG2zsaVqV/Is27JbnpYU4rlZ2unpT5PfWKX2ajFha6zHoC4ItM3pdkwmVw
	TaR42wDl3MUrRB5ZqF1DkB1mRZ3mxc2/W9WDcJ2H6rRh8tLBQH8k+pxCSq9h0ycXd+9rmbcbD8R
	SRGAKMh6v6OeOCMra9SdxXLk2uXS+JKPkg07f+pAMIS40oCbo4HBSxDK3XyQ3vYOrKhAn76iI73
	le28q4oFChEn2G9aTLj5hXi+X3HT5mwNTTbUfwTH5/qPJOYeD9DkAJ8OCyEhz6ahrExBkTqPTD4
	zvflVPblVM9L9iV7ukzdhlVcpYvqRgdreqBNiVpUafvGg9TfA/SPE4X9roUV2cih0UnceGkG43/
	awfYYXKoEatspPrAWZD9/YRe9P7hu4eYmpo4Pe6c5vgB6Nu3xDfdQ1XHMj7r/4PrqBFZpKEX5h4
	kpaOtJzIxt1vQREmUBLKtrvVMmk0m2RKj3vd/3sN8Qs42ASs08jsMoEnfGnde4Gk++eb9vn9D/2
	8FvR+rNqtMWFJDy3w==
X-Received: by 2002:a05:6214:3305:b0:890:5770:7f77 with SMTP id 6a1803df08f44-89482716c7emr47106136d6.28.1769127220310;
        Thu, 22 Jan 2026 16:13:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491937381sm5171416d6.43.2026.01.22.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:13:40 -0800 (PST)
Date: Thu, 22 Jan 2026 19:13:38 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/14] odb: introduce `odb_for_each_object()`
Message-ID: <aXK9MkCTt6LrSi+E@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-7-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-7-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:23PM +0100, Patrick Steinhardt wrote:
> Introduce a new function `odb_for_each_object()` that knows to iterate
> through all objects part of a given object database. This function is
> essentially a simple wrapper around the object database sources.
>
> Subsequent commits will adapt callers to use this new function.

Makes sense.

> +int odb_for_each_object(struct object_database *odb,
> +			struct object_info *oi,
> +			odb_for_each_object_cb cb,
> +			void *cb_data,
> +			unsigned flags)
> +{
> +	int ret;
> +
> +	odb_prepare_alternates(odb);
> +	for (struct odb_source *source = odb->sources; source; source = source->next) {
> +		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
> +			continue;
> +
> +		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
> +			ret = odb_source_loose_for_each_object(source, oi, cb, cb_data, flags);
> +			if (ret)
> +				return ret;
> +		}

Having the bits corresponding to these two flags be set means that we
can avoid looking into the source entirely, as we know ahead of time
that none of its objects would match the caller's criteria.

> +		ret = packfile_store_for_each_object(source->packfiles, oi, cb, cb_data, flags);

...but when we *do* need to iterate through an individual source, we
pass the flags down to that source which handles the rest of them. Good.

Thanks,
Taylor
