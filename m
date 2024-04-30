Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876B17B505
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497075; cv=none; b=caTPRyP907SQocHIaHxk492whpfCSvn8oJ9iWMoPp7LJLu5KATFkoJZE3fhXkp96d+r3JqN0z3j0quvodsqfJ2ynwunBffbNLTkaRE+nQFsL4gxG9SKnzkEaLHONhCrykXM1KiC2KJOXOPjo5Dn1WHVr8z/hSCkJhVlOG50AhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497075; c=relaxed/simple;
	bh=caeItTowoYRhbKh1RoSe0nrdGZZu7sKSYq2pOi5Nvyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYyrHJpK1kpXWC2qC0BMpackZQIdl6nN10iO0Du77M6fvq6D5xqa9et7dWitRfsjRt178R4byoVVfB3x60wgF9b1kCzhCzbJ3iaamtqsHs5OghoRrBhO3TXmw6b7GWc7gM7wRkTtRx0fh65P7V6m8la1fj804lMlomTXLB/FQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmcfXao5; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmcfXao5"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23d4a716ee7so229561fac.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714497073; x=1715101873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS61lllDx5NG/IHWHCcMDflFXOd8rx/LidJE3CBZtMY=;
        b=WmcfXao5RZODGQWofNkQCjx0Y7srf36eZ0ulLp0FhDQ57E6YMljfXX5SHud1PiZ3zw
         u9E77IsN/srCBMj8gyYYpaqJHuwfkgGkJ+HofGz02KVS/93Ozgmdffhg7VYpQOKcda0w
         WI4gJlfl7YVBChHMjPl9QogbRHxxq4GNmoIiU6jXFvN1VcX6g30GcgtuS9j+4i543LlA
         R+c4B8e0AUSX5IO0N3OaeyOYnunnGy7l3+vyK3bsXBBpHFwaIYVV6tSsIl7TRZTJIDA1
         yn0vvvvDpS1ONwUhvX6Hz9i8bbORuVsGE2nDOeNAl3XIm3NvQh8TXloWJwecXtUhi1Yl
         Unfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714497073; x=1715101873;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS61lllDx5NG/IHWHCcMDflFXOd8rx/LidJE3CBZtMY=;
        b=fLeZjvEzAcuGubEgEuQpyFZPVpPvKPecjUiqpwuDL8Do4iln050qTfz2cMppEtOwcE
         MuWx66t3v2qaptBNmPdWhfSRfjCttyTkL1IIjCuLZiYL1nPNNmCfR0HBj3e/SnOzronf
         VIeoc1EpOG+QJtp8RiSk908TYORiZmCxLfwKD6MpMKEjq7A8bJ+D4fq3i7t+g9M1sOXE
         uLJnHQOZ0Mjel2kpfZsgU+3h1/U2vZ7bsWQzSQ/Hlqt90MEhaKrbXfUxz6no9Wopu5Nz
         sB6AS8TY4oImnNigQ5KRoo5bmwsoadLeY5B59BIH2TQLJ5D+32ovbTM3iyZLwlB26mDj
         skVQ==
X-Gm-Message-State: AOJu0YxwEEwRHklHq97flIrfxToEX7VC3Ow6S8HoBhZXasMcc7bn8NFf
	CmH15b6Qq3qhou1TTuzv1NkwcFaW8oJMopkNs0hwIRmoY4aXagV/ABWxYzrF
X-Google-Smtp-Source: AGHT+IH4oJGQ1gtD/R03hFEi56RktxQ/8f5mO+vkaoyYdbtTzHmqJ0Ruozg16Zom5loLz6PzzsCG0w==
X-Received: by 2002:a05:6870:fb86:b0:229:8236:ae9 with SMTP id kv6-20020a056870fb8600b0022982360ae9mr67754oab.59.1714497072669;
        Tue, 30 Apr 2024 10:11:12 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id he7-20020a056870798700b0023ca5f05b8fsm850716oab.4.2024.04.30.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:11:12 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:09:57 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/10] refs: root refs can be symbolic refs
Message-ID: <zmnute2cow2rbrv3cj5cq4roieyzssaxcnorxhorzyp3wfgllt@ubhsw6dpi5js>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
 <e90b2f8aa98493e9cd3f2c04cb58318780f9f6e5.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e90b2f8aa98493e9cd3f2c04cb58318780f9f6e5.1714479928.git.ps@pks.im>

On 24/04/30 02:26PM, Patrick Steinhardt wrote:
> Before this patch series, root refs except for "HEAD" and our special
> refs were classified as pseudorefs. Furthermore, our terminology
> clarified that pseudorefs must not be symbolic refs. This restriction
> is enforced in `is_root_ref()`, which explicitly checks that a supposed
> root ref resolves to an object ID without recursing.
> 
> This has been extremely confusing right from the start because (in old
> terminology) a ref name may sometimes be a pseudoref and sometimes not
> depending on whether it is a symbolic or regular ref. This behaviour
> does not seem reasonable at all and I very much doubt that it results in
> anything sane.
> 
> Furthermore, the behaviour is different to `is_headref()`, which only
> checks for the ref to exist. While that is in line with our glossary,
> this inconsistency only adds to the confusion.
> 
> Last but not least, the current behaviour can actually lead to a
> segfault when calling `is_root_ref()` with a reference that either does
> not exist or that is a symbolic ref because we never intialized `oid`.

s/intialized/initialized/

> Let's loosen the restrictions in accordance to the new definition of
> root refs, which are simply plain refs that may as well be a symbolic
> ref. Consequently, we can just check for the ref to exist instead of
> requiring it to be a regular ref.
> 
> Add a test that verifies that this does not change user-visible
> behaviour. Namely, we still don't want to show broken refs to the user
> by default in git-for-each-ref(1). What this does allow though is for
> internal callers to surface dangling root refs when they pass in the
> `DO_FOR_EACH_INCLUDE_BROKEN` flag.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c                         | 50 ++++++++++++++++++++++++----------
>  t/t6302-for-each-ref-filter.sh | 17 ++++++++++++
>  2 files changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 5b89e83ad7..ca9844bc3e 100644
> --- a/refs.c
> +++ b/refs.c
...  
>  int is_headref(struct ref_store *refs, const char *refname)
>  {
> -	if (!strcmp(refname, "HEAD"))
> -		return refs_ref_exists(refs, refname);
> +	struct strbuf referent = STRBUF_INIT;
> +	struct object_id oid = { 0 };
> +	int failure_errno, ret = 0;
> +	unsigned int flags;
>  
> -	return 0;
> +	/*
> +	 * Note that we cannot use `refs_ref_exists()` here because that also
> +	 * checks whether its target ref exists in case refname is a symbolic
> +	 * ref.
> +	 */
> +	if (!strcmp(refname, "HEAD")) {
> +		ret = !refs_read_raw_ref(refs, refname, &oid, &referent,
> +					 &flags, &failure_errno);
> +	}
> +
> +	strbuf_release(&referent);
> +	return ret;
>  }

I'm not quite sure I understand why we are changing the behavior of
`is_headref()` here. Do we no longer want to validate the ref exists if
it is symbolic?

In a prior commit, `is_headref()` is commented to mention that we check
whether the reference exists. Maybe that could use some additional
clarification?

-Justin
