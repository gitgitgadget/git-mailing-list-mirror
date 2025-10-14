Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E14235072
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468835; cv=none; b=ZcfFKmnxJsuzqc7nnuSGfUVdF3Tvd4u1ujzcFaelELGuaeSF4z23RpDjPuQ2Sm71kEY2lYNM/GOvS8UYbiqqqNRtDawcZDG/GvlLK9MM/04lKHEfIkAEVPBuInENZOHRmiHP5gWnF4Rr1e6pts6+Sft41Vh+lfECpJYNUFNgwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468835; c=relaxed/simple;
	bh=Qv1u4E47Ltxf/MIMt+vTvFIVG/6XQMkmP/Vb/IggolU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fbyu0pXqdl1q/IHCZaCgl5zGMXuohKXKCvq605pnyllEpUDtlQoCJ8aRMkLPEKYZrg9xPfx4n0yjqlEc/O3UBga7XH+ssmj9eoF8XwElWb8Tj8E90XmPn36ocitNqHL/bokgbheXxyxejZsYxAZyim4gUwdwvfNHneLMADNyVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7bq8tfO; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7bq8tfO"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c0e8367d4eso2072173a34.1
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760468833; x=1761073633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zn7CyR3hATClZo2F+den9st4BY0g90TvaIq2E5DbZas=;
        b=Z7bq8tfOq2KhxALxvgECnNjHVN11bMXRZLQJG304tk4AoUYtnR8rJnGVUjjaoMppQL
         4zDelEqrzZrEXORd2ZUW/SFT5oQE3a0Q/RYNOwD+kbfHBaeK2ErtPJgDZKXIkmA0+w5O
         rWr17A0DRdJp92ORgqXdmC5T3UIhm1GJrhk228KYcRukFWhSzB2oC3/8PUgAgutFmCAr
         cCvW2GAYHmrJEsNW41YlYNCHMJ4M+OvlL4u3UrvZAUuHzSOQas9X0h9pbq/UnJ/exuaU
         SGvFgh4nDb13NQWT5ui1aNdYGdDPGRNUph63G8jIxyj5LDWUKvifB44+MCgg6zAVzstP
         Xmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760468833; x=1761073633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn7CyR3hATClZo2F+den9st4BY0g90TvaIq2E5DbZas=;
        b=wAAXFWgPL75kqICgw+ubR+cvX5xlZ+9KvFcrSonFOlVHFFCIYL3MENeq5K9bg4+RTE
         2AD3p4h3tMwmfRNR/qMNRdrbpRaygKohi11y3kM6/hKMeHekh8JJvLDnTPpXTQgcF8lB
         t8gJ3K0OtkaQAgdGU/F0FqfeBE9xbR8CvGCISrSF0M7Dbxi8w6GRfDjPXhPd9wccOEUc
         u+EUeHuDakRbNWB5hatMB04iZFhXf3abYzXVbKydYj9Q1ShAe1kMMmTX+ndF8aZuYFvq
         fddFXN1qN96Phshxabp9jAmMHCAUBlkHMdCa5jTHNOHmkEjDOnDMaUwDny2TTP8NCY1B
         42Ug==
X-Gm-Message-State: AOJu0YwASZ/IFt27NaZL2JxZnmpvDb+5jLDg4WcEw9k5/yCMh9o+9176
	T5vmaS5+AupX3JdzyNR8cLs40wVM1KxNMnPZBh0Bjyp4NfTPYI8b5ZKgP2KvmA==
X-Gm-Gg: ASbGncsZdQVYgxCQHDD4V42hazZQUucPSueBpVJyEv4OmmrBhYU7k8FOtbSqF2BrTn5
	qPItpEMIpc0akGcWg4tREUXcfc3lNRfUiksTV60g9e/EfcFfodvvyLjVOvumPK+wqtj+kqYPdRO
	sYUYvFLgNAPUObfo38LkhmrL73ZL7LN3yPPI4uW05yRyUVPgUq+BNpxxQb84boPFBXs8Xut5eTW
	VW8S6/3tgSPpCzlUkMg2ttSj1LsIt1ieOroRd47bsCI2zsXOczQTqoDZDLQEIu3SJCSU92a8Lhr
	zj5Ddh+n4Pgy9IifQrZRHqnDU+nV9HWYg9N/1LkJj/bTkYT6qrMUOM8X6RN6ItZjtheTFr7gkJm
	vbXA2DddzfPGELPuV89CpP10nsC1KSL1+4xg=
X-Google-Smtp-Source: AGHT+IF3bzWlGl75/ACmxAJUYHezRFpvKK4r177PbkIge5Gf8fbZO81OkBE4+Cb87GgWbcBNb1eCgA==
X-Received: by 2002:a05:6830:700e:b0:7af:1367:4f85 with SMTP id 46e09a7af769-7c0df82d758mr12429896a34.36.1760468832545;
        Tue, 14 Oct 2025 12:07:12 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7c0f911aacesm4745516a34.27.2025.10.14.12.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:07:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:07:11 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/6] object-name: convert to use
 `packfile_store_get_all_packs()`
Message-ID: <j6kcv2zs2k5346mol2ojy6xcrtsszgfrm2dlhy263xxygnqus2@jcw4ppho4cnc>
References: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
 <20251009-pks-packfiles-convert-get-all-v2-1-0d73b87ce711@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-1-0d73b87ce711@pks.im>

On 25/10/09 10:01AM, Patrick Steinhardt wrote:
> When searching for abbreviated or when trying to disambiguate object IDs
> we do this in two steps:
> 
>   1. We search through the multi-pack index.
> 
>   2. We search through all packfiles not part of any multi-pack index.
> 
> The second step uses `packfile_store_get_packs()`, which knows to skip
> loading any packfiles that are indexed by an MIDX; this is exactly what
> we want.
> 
> But that function is somewhat problematic, as its behaviour is stateful
> and is influenced by `packfile_store_get_all_packs()`. This function
> basically does the same as `packfile_store_get_packs()`, but in addition
> it also loads all packfiles indexed by an MIDX. The problem here is that
> both of these functions act on the same linked list of packfiles, and
> thus depending on whether or not `get_all_packs()` was called the result
> returned by `get_packs()` will be different. Consequently, all callers
> of `get_packs()` need to be prepared to see MIDX'd packs even though
> these should in theory be excluded.

So IIUC, calling packfile_store_get_packs() before
packfile_store_get_all_packs() has been invoked results in all the packs
being returned anyways. This is indeed confusing.

> This interface is confusing and thus potentially dangerous, which is why
> we're converting all callers of `get_packs()` to use `get_all_packs()`
> instead.
>
> Do so for the above functions in "object-name.c". As explained, we
> already know to skip any MIDX'd packs in both `find_abbrev_len_packed()`
> and `find_short_packed_object()`, so it's fine to start loading MIDX'd
> packfiles.

Ok, converting all the callers to `get_all_packs()` requires them to
handle receiving MIDX packfiles also. It sounds like these callsites are
already prepared for this reality though.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-name.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/object-name.c b/object-name.c
> index f6902e140d..4e62bfa330 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -213,7 +213,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
>  			unique_in_midx(m, ds);
>  	}
>  
> -	for (p = packfile_store_get_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
> +	for (p = packfile_store_get_all_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
>  	     p = p->next)
>  		unique_in_pack(p, ds);
>  }
> @@ -805,7 +805,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
>  			find_abbrev_len_for_midx(m, mad);
>  	}
>  
> -	for (p = packfile_store_get_packs(mad->repo->objects->packfiles); p; p = p->next)
> +	for (p = packfile_store_get_all_packs(mad->repo->objects->packfiles); p; p = p->next)
>  		find_abbrev_len_for_pack(p, mad);
>  }

Looks good.

-Justin
