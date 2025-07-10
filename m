Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA11E520B
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183424; cv=none; b=UutkUZtO6cKfW0bvlHqpoMwd2aZCgKtIcuZuDKEXnzfbhI/bsLadk909siU7PX2GzwqUGwOkRkRisWf1xftUhoOQQ/udbZ4XIVFQOSt0ISwW/fFuwqOYraiw/M/tPh7X9kjAIgwg+E5DSz39YzFr9phDmCdXD6BDp5XIS50jQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183424; c=relaxed/simple;
	bh=X+rVsu3GiKzq/iGP94HuWougqZCtThn+VDQwqto0Uq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFDIPjEgBC8v6/RxzeaJQnTS7aNWd2WE6lBNI+90xdGwzl93fS9HeDIF+afUpvKrkALfJSI42vsC/xXmWODhbXzHhy4Rj7aWIUtIqfBciZ+rIJgTuIl5BEV4yc6AYuaEs0p6zM9uDkHOpQ6P+4U5Wgpis2CKCN18J2LNT/g1pCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUhXXund; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUhXXund"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-735a8be4ea9so338468a34.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752183422; x=1752788222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlo3a16X1D2x0UI9Y9oW8XIWcbUf4bqrMeINucDAjx0=;
        b=NUhXXunduFH3uiz6ep1lR6KPTWIqcGCRXy69cSvZMewY5elXC/fH1n/VtmOd3tUHjR
         W3tPyVLv3iMW+pe3lsJv3eNUTm4XJJtdvGmynO/g13th7mwQSJYsAer6srcBZp5/olSa
         44sch9hOa08RdyZhY6GaXIofNrYJbGjrTDfqc9UZ6ppG/wMlM4s6h+DTkS4Jd2ofkQXL
         j7OLl7bXkW47Da6qHmCTKkQbB+VvE9/KO33oEVlx+2MTptScfG/aSNK6LGCkibbQ1SEj
         Vmt33HtokJ9xfGQ3wpcEMxGWSs3kK4zlbLMdD/R251CoHYe4Cee0icOxCSr9mXeG1egq
         ArRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183422; x=1752788222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlo3a16X1D2x0UI9Y9oW8XIWcbUf4bqrMeINucDAjx0=;
        b=pR3DYRSgKs4LxpWj64RWoCbMcUlIoyK84rsFivigyrvGxzI3buifqZxh4vmWivJHfT
         SRjMdMA6oLk0LCl0iC38YiaX/XwtAyUEe0j+Np1NaBU5a/jgKJEIkHvlGyiduOTnHpuz
         PTnBEW91OJuCK+z04pRc4xpK1FXFPwgGdF3CoWYngV0IbwAdBLOpTc0BzR/nPXFox6LK
         z/hEQfs7lJ+CYrExZuSKV1KZILOuhtuFjKbagUSUxfKIM/xSTIzSpgWKgq/QQTyCh1vH
         Dci1MLp4UxtCmUjdlJIYPiBfWos2t5WGWcxR3FnOyaCu9Hxm19SK5+IhCkfue7cUPRrE
         Gz8g==
X-Gm-Message-State: AOJu0YyUiFhw3H1V44yN9hJBonYegZc77eAH6nPjEI/dxUSlmwQ4RrrZ
	h1vZQUEHOsBfbt0Gj/wvNsBONJ3hjCgQSh8vIx6/aPtv/3bAcQRsJ50LQbZQlA==
X-Gm-Gg: ASbGncu6CtqFm28w7YfICcvUtISgEn8BxQZp1EZgajmcDn6EI0kMO6urmKKHsFBZ9C6
	Kiwg4kXkEFfu1T687NY651ZkeAGNMHHEPP2olR1CaCLYwIGeYJEGUyW+YskPg1u0Zj5T7TP652f
	J3HVZoBeqXxMGisHE+Yyld8MwMUWCBpd+VDgilLwiV1CQg9un2v42hm715PpwyhGyClGg5Xrmc5
	spMHhj+H+xvYWApZq1DQ3NCmrsRRi7DAfXEZFssTnwUhsEofkGRrdTUuz5DejK/uoYkMS09DWHd
	mAyPCzssfGmRd4RM5c5AUv8GIC4sUwiffqee0zU7GL/KEr6wo8sFhESEcd6HdXolHKBe0yGSopM
	FQaBZqw2lONkjphA=
X-Google-Smtp-Source: AGHT+IEuMvQDHke4sVp3Tjz7bjA0IjMYr1wpyHslJZ34/BthfozlAV21AvJMvZTq3Vb4P6ACPxmgRw==
X-Received: by 2002:a05:6830:610d:b0:73b:2ad0:6225 with SMTP id 46e09a7af769-73cf9e1b12emr878439a34.2.1752183421700;
        Thu, 10 Jul 2025 14:37:01 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cf12a634fsm341448a34.51.2025.07.10.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:37:01 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:31:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] midx: stop using linked list when closing MIDX
Message-ID: <lb7rv7wkpdbekciz4astmtay3u2t7os56jvxpfa5x5vx6ao4vc@jvvnav6ybqzl>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-3-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-3-f31150d21331@pks.im>

On 25/07/09 09:54AM, Patrick Steinhardt wrote:
> When calling `close_midx()` we not only close the multi-pack index for
> one object source, but instead we iterate through the whole linked list
> of MIDXs to close all of them. This linked list is about to go away in
> favor of using the new per-source pointer to its respective MIDX.
> 
> Refactor the function to iterate through sources instead.

The `close_midx()` function itself is not iterating though the sources.
Rather each of the callsites are now resposible to ensure `close_midx()`
is called separately for each source. It might be nice to clarify this a
bit in the message.

I also noticed that there are several other existing `close_midx()`
callsites that we leave as-is. Each of these sites though looks like
they don't care about globally closing all MIDXs so they should be fine.
This might also we worth mentioning.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx.c     | 11 ++++++-----
>  packfile.c | 10 +++++-----
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/midx.c b/midx.c
> index a91231bfcdf..416b3e8b54f 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -401,7 +401,6 @@ void close_midx(struct multi_pack_index *m)
>  	if (!m)
>  		return;
>  
> -	close_midx(m->next);

By dropping this recursive call, now only the single MIDX chain is
closed. Other entries in the list are no longer recursively interated
through and will have to `close_midx()` called on them explicitly.

>  	close_midx(m->base_midx);
>  
>  	munmap((unsigned char *)m->data, m->data_len);
> @@ -835,11 +834,13 @@ void clear_midx_file(struct repository *r)
>  
>  	get_midx_filename(r->hash_algo, &midx, r->objects->sources->path);
>  
> -	if (r->objects && r->objects->multi_pack_index) {
> -		close_midx(r->objects->multi_pack_index);
> -		r->objects->multi_pack_index = NULL;
> -		for (struct odb_source *source = r->objects->sources; source; source = source->next)
> +	if (r->objects) {
> +		for (struct odb_source *source = r->objects->sources; source; source = source->next) {
> +			if (source->multi_pack_index)
> +				close_midx(source->multi_pack_index);
>  			source->multi_pack_index = NULL;
> +		}
> +		r->objects->multi_pack_index = NULL;

At this callsite we want to close all of the loaded MIDX and do so my
iterating through each of the sources. Since we still have the global
MIDX for now, we explicitly unset it.

>  	}
>  
>  	if (remove_path(midx.buf))
> diff --git a/packfile.c b/packfile.c
> index b43dd2fe6cb..546c161d0c1 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -369,12 +369,12 @@ void close_object_store(struct object_database *o)
>  		else
>  			close_pack(p);
>  
> -	if (o->multi_pack_index) {
> -		close_midx(o->multi_pack_index);
> -		o->multi_pack_index = NULL;
> -		for (struct odb_source *source = o->sources; source; source = source->next)
> -			source->multi_pack_index = NULL;
> +	for (struct odb_source *source = o->sources; source; source = source->next) {
> +		if (source->multi_pack_index)
> +			close_midx(source->multi_pack_index);
> +		source->multi_pack_index = NULL;
>  	}
> +	o->multi_pack_index = NULL;

Same here. Looking good :)

-Justin
