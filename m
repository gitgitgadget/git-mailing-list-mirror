Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0317557E
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086082; cv=none; b=NNdwVP55kkissQ7KjZtqS44Gw1QKQvi0YlnMD+Y9FiD75zpoCeesvrYV6EqOTU+B5h7otKs8hWIAxYDiEqlr+CV7xJL5eqPkJ3gcOnsTAW4UAhlOlHtVZXLa6vmMR00RJ9b5TDeZDeLQYbQUNfBaZnWIJzQLRk5pUS67ERHYXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086082; c=relaxed/simple;
	bh=6HDQ1BAxvjYtRf/8SSdGN42NAiOkOjEa9dOL3AYdsXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPPUDBaP/Lj2wLWCrN4o/GgsuFyGgyQ6MKiZHRbIgXp/LP3MTrswYJ0yMd9ZoguKrsZGmLS4z/feNCmeZ6fOlr0a9v5XbvTxHoj0U4PiUbimNAVpAP0Sgdi3rbCAcxmBirajJKkgxokbZwOoSZho86AnDEjJTyGza1lETCglImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFrtnQBO; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFrtnQBO"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db1eb76702so3318972b6e.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086080; x=1724690880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOZuhFnDznu+4aX9SRJJo7j810fnZZUbGNd645ngyp4=;
        b=iFrtnQBOss8HiWSc8lQdCejzBeCAVQ0Fa0/QRffO4K6f8y0oOdP/LNMxAemSdaXZ/v
         IPL4bsUAuyOiAm1CDwXMmIXtrQ4GjBojnyKQJYJY4bQdi+TS1mb/b3lZpPOIgoR6gklz
         KL+nnip4Kvbkg2+92gLWp7eqSX/LtK7OxQLL8k4CNJnbueyLyQZX3hbLJUL63w7VRPjp
         9Ohr7A3xhE7f/kVFkrEFoTw3xdltj97JUJoTNPD1pUM+uKSp3tJ1PUYQf2OAsiutbpAN
         60rANcKIQlCP3a6+y2bPxv3Hp/64INfHgERPK+mU5FYAa8/MSMKWYj+kOW0iBYQWkep3
         R1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086080; x=1724690880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOZuhFnDznu+4aX9SRJJo7j810fnZZUbGNd645ngyp4=;
        b=u81rh6fe0L+AFvUzcdi9QFNAca/k+3cdpbJtoQ85MqviZBrCqGCGU/zr3iaWk6Yp2Q
         IPIZ6gzyVQc9TH5QMyNDzRdcP3F2WknIAYYr1FAI+dmiN+4mCswLaedu/yMahIX52z3H
         +3m2FBz0Y+mka62c+Q7chj9sQe4SdlOPpIl9iBmApjbvIAHJ3qhV1LUDgrUhpQ57Eqhz
         1j3ymKbcisZNf23aTf/8Y6Z9UIHLO65efdWbkKCOlBdg2PPwvYD0C/mwp5tqCkcDb/j7
         uEQ9DvvoLAt9nut9KCrdQWUmKHxq2AXPmDLI6P4+jnFUeFW0uVwmsNhuhgG3RGiCA3Bl
         avpA==
X-Gm-Message-State: AOJu0YzWVQL9eWhT+jcZs7yqZZyQyW99jiNU2fO8f5fagf7zPEa22Fzd
	80ow2MIZ9AuK/L07+UOf6dijNT3ljzlY4Xn7CoxC7plvzgVT/jMQ+5S2yQ==
X-Google-Smtp-Source: AGHT+IGmAyMsB7S+f96HvvylndE0eNyRgbh0KWUTWMbCziUSqwYoKb7vbZLYR05vKNnutUnMASi3MA==
X-Received: by 2002:a05:6808:18a1:b0:3d8:4603:e7a0 with SMTP id 5614622812f47-3dd3ad47e55mr11947927b6e.27.1724086080394;
        Mon, 19 Aug 2024 09:48:00 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33ef574csm2402515b6e.54.2024.08.19.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:00 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:47:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/10] reftable/merged: stop using generic tables in the
 merged table
Message-ID: <gzhbfjhyhhmje53s3zp4crzvwf7dfkcixl3uxw3h4fvsv32x37@6rvvt7svtrjg>
References: <cover.1723528765.git.ps@pks.im>
 <86e2f9f5dc64eee97510e597820791287032ba29.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e2f9f5dc64eee97510e597820791287032ba29.1723528765.git.ps@pks.im>

On 24/08/13 08:24AM, Patrick Steinhardt wrote:
> The merged table provides access to a reftable stack by merging the
> contents of those tables into a virtual table. These subtables are being
> tracked via `struct reftable_table`, which is a generic interface for
> accessing either a single reftable or a merged reftable. So in theory,
> it would be possible for the merged table to merge together other merged
> tables.
> 
> This is somewhat nonsensical though: we only ever set up a merged table
> over normal reftables, and there is no reason to do otherwise. This
> generic interface thus makes the code way harder to follow and reason
> about than really necessary. The abstraction layer may also have an
> impact on performance, even though the extra set of vtable function
> calls probably doesn't really matter.

Agreed! When I was reading through the reftable code for the first time
I remember being rather confused by this interface. It left me wondering
if merge tables could also be composed of other merge tables, but I
couldn't think of a valid reason to ever do so.

> Refactor the merged tables to use a `struct reftable_reader` for each of
> the subtables instead, which gives us direct access to the underlying
> tables. Adjust names accordingly.

Using `struct reftable_reader` directly instead of the generic `struct
reftable_table` sounds like the right decision and the flexibility
it provids is unneeded and only adds complexity.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip] 
> diff --git a/reftable/merged.h b/reftable/merged.h
> index 2efe571da6..de5fd33f01 100644
> --- a/reftable/merged.h
> +++ b/reftable/merged.h
> @@ -12,8 +12,8 @@ license that can be found in the LICENSE file or at
>  #include "system.h"
>  
>  struct reftable_merged_table {
> -	struct reftable_table *stack;
> -	size_t stack_len;
> +	struct reftable_reader **readers;
> +	size_t readers_len;

The merged table is being made to directly reference the table readers
instead of going through the generic `struct reftable_table`. Makes
sense.

>  	uint32_t hash_id;
>  
>  	/* If unset, produce deletions. This is useful for compaction. For the
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 29c99e2269..f7ae35da72 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -605,9 +605,9 @@ static void iterator_from_table_iter(struct reftable_iterator *it,
>  	it->ops = &table_iter_vtable;
>  }
>  
> -static void reader_init_iter(struct reftable_reader *r,
> -			     struct reftable_iterator *it,
> -			     uint8_t typ)
> +void reader_init_iter(struct reftable_reader *r,
> +		      struct reftable_iterator *it,
> +		      uint8_t typ)
>  {
>  	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
>  
> diff --git a/reftable/reader.h b/reftable/reader.h
> index e869165f23..a2c204d523 100644
> --- a/reftable/reader.h
> +++ b/reftable/reader.h
> @@ -57,6 +57,10 @@ int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
>  void reader_close(struct reftable_reader *r);
>  const char *reader_name(struct reftable_reader *r);
>  
> +void reader_init_iter(struct reftable_reader *r,
> +		      struct reftable_iterator *it,
> +		      uint8_t typ);

At first I was wondering if we should prefix the function name with
`reftable_`, but this is only exposed as part of the internal reftable
interface and matches the format of other "reftable/reader.h" functions.
