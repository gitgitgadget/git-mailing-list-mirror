Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0F26E6F3
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660948; cv=none; b=YPxNWGaP+juBRei6FLk4hUGsBKohVjUtX43FmZPFqEyc4khRuIrF+i0lwRGbDNy6zy3LW802fIgPH6A1BQSyUnLmORJHaBMdy04kPwR293fsFlruD1I1H1Z56mVFAUF0FIs5SwtJWM6KLotrMf7SiwzFuilgCGNKWype9my/KTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660948; c=relaxed/simple;
	bh=s1+FwzBeSyHPx4OHLcq+TYklHZY5z7ROYhQj0WDvwng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEBIHqDJtl0iHJuFl8Ip3FzFvnltI+XPJ1gjKfrA3rh2RSQsflV0Tj5paZk4omcWe5rOIUhBkwHcFf+lUFoMDBtBGIVlkt1p9YjIwJEgCgiMm/5QFlyQt7VcLPzAVcVHkildeakKGdZx5Cfc407jK7xpxqxXRA98AGi9W7vS1GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0e0IgCH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0e0IgCH"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-463a0e14b4dso2590138b6e.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 13:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772660946; x=1773265746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9CQFP/95gqh2tLqbs5Zf5tETy+K2QYj4DW9zwCx7PY=;
        b=b0e0IgCHiPJaKJDD9pdTtfh7s1RZAfwtuIm5RkNvZFvWSt05V4n9Ul/OWEs7LwuZVH
         mg++IWvoJ7xRMKsiPNt63QzPiM0PVVJLtbBAGZWAQd8Y02R/mvvLm2wCWy54pGpcfnl9
         mC/L8uIx3sy/dW6ZcgOh3QWTgw1sxWMUKul6QameCHiA37Og+jcV74qan13GGJFF1+EV
         vHL96riHtLnTkNF166NAhUwK/4fyyj79wUL10NFm2kqWVZD+aaX4CWxQpReGo+Vk0yUE
         e4yjIKTgLGk41XHIDyjFfV2AZNm+d9oxxUivRuaaDMTzG1c/om8KJbwQGccqu+i6zuQe
         7Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660946; x=1773265746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9CQFP/95gqh2tLqbs5Zf5tETy+K2QYj4DW9zwCx7PY=;
        b=ux2adkFkoaPph7oCakSVwYsM+D1Y63iSoELeXNjxGLQ3r4qh998zkRFFqM7nC8B3E6
         vDin56qL6ISE1+lmbByr21RdXW/+UqSrzLDP6m88PzwkGAKc2ywPLHXLShxHSaTeeSxs
         +GamCNEkZjnnVjH9JFDY9+bYfBLZckiGNLyt0oZJyZ8xMexZncxSWTC5tqwTl+lQb+4q
         QMPsTq9/MnCnS3jp29/it7KldSex6k6pbPg3i9h4D5owI9Zf+VtCJ70sZfvMPNsMQnaS
         1g3LFxC0ARlnF97xptIJUWAr/aYGLDq20r/Qb+FACIFySccIdBD1PiZuI2+KGpQEmWvd
         2IvQ==
X-Gm-Message-State: AOJu0Yy/cL1N8ZCdMyNQVfD/wF4Mret4gMgAsZEOlJmckv5xi8iHBvtJ
	4ecj9LIzxoYasQv50B75MxnE79H4wlGzPvf8ygV5BseG7OSJv0tU3XUEPwBi0g==
X-Gm-Gg: ATEYQzxxctT/eDaWnF7GfXgLSwr973EYLq2JPxATMIOqvAPcVZ+HFgj3mIOPrVsBlju
	khRM1RLkVtWlYXWWEV6BtUpMIBfFsspgzou37FPxonFJyZ9FooC4WHsLvoXGU1EKtqZnhpYPN1/
	pj3s/c7Ej0ugvD97Gb5yDlwnnBgtoT/YHkDmig0RDwlFK1CugZpzk5rYP/vkufqoyPrCtzK/JjZ
	5dKJH0xNUJPhbs31WaDtGmBe9Gkol5U+X34T6wUlAg9+R/bBLVxCeASAJvutWCs2+8SbHqV1NPU
	eBMiQe5GIiWT6rX2Ng8urQi5Mgw0GAo1g8i6QpOx9pMZH/t2t3M759GBvTrTpKPdkBP2Fv+B/LI
	ABHXLh4bKW77fNXsVk3JGCnW7KKNcA994E0xDdYyZ6F6n5bAFdBEpuT9KDq0WqNcalFIDildmx+
	e0y/l05kKqQykfDOvZ
X-Received: by 2002:a05:6808:14d3:b0:463:c1ef:ef1e with SMTP id 5614622812f47-4651ab4deb8mr1591492b6e.8.1772660945756;
        Wed, 04 Mar 2026 13:49:05 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2c9fc2sm19170130fac.18.2026.03.04.13.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:49:05 -0800 (PST)
Date: Wed, 4 Mar 2026 15:49:01 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/17] odb/source: make `read_alternates()` function
 pluggable
Message-ID: <aain4BYJubg4PRyZ@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-15-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-15-253bac1db598@pks.im>

On 26/02/23 05:18PM, Patrick Steinhardt wrote:
> Introduce a new callback function in `struct odb_source` to make the
> function pluggable.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/odb/source.h b/odb/source.h
> index ddce43eb20..14f5d56f68 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -55,6 +55,7 @@ struct object_id;
>  struct object_info;
>  struct odb_read_stream;
>  struct odb_write_stream;
> +struct strvec;
>  
>  /*
>   * A callback function that can be used to iterate through objects. If given,
> @@ -229,6 +230,20 @@ struct odb_source {
>  	int (*write_object_stream)(struct odb_source *source,
>  				   struct odb_write_stream *stream, size_t len,
>  				   struct object_id *oid);
> +
> +	/*
> +	 * This callback is expected to read the list of alternate object
> +	 * database sources connected to it and write them into the `strvec`.
> +	 *
> +	 * The format is expected to follow the "objectStorage" extension
> +	 * format with `(backend://)?payload` syntax. If the payload contains
> +	 * paths, these paths must be resolved to absolute paths.

This seems sensible, but also sounds like a change that might be worth
explaining in the commit message. Does this mean we should expect an
alternates file containing list prefixed with "files://" to start
working? If so, this doesn't appear to be implemented yet.

-Justin
