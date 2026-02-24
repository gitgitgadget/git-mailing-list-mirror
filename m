Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B21DB95E
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958861; cv=none; b=gSwObJe5yLeyiVXWLFiaYDXIsgVMLUsvTKamC3y/80GovJVCwd6vO8gMZQNkLYr9VKNwYCN6AC38wclFjqoMtFE3XNC0XGKL+lUJ6c/hoQNbwb2gf599elXgkqXoy5wNWkXUIKQYnN1Edk2WKsdkfdSgnXW22SNpmC6toFXiTTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958861; c=relaxed/simple;
	bh=iQI+HTOcF88ezOt2Cxh8e6CiS71ADCSEK3I56ZlSaNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG7VqigrwawroNjqZMoTNeO3cYbWLlC1h+sJsmjEh+gr4wmf/Q7cEoFJjFbvRkV8IBmjfvCLEdJEPPLY9Z59m4CWpB024ejGYZA+QEAIgHpy3Dqp03++bqibKtRMV30LDkQ+Aqwy+P/wvt4z4Cad4LDfI3AgGTh0iT8f73jDFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Yf+4+f+C; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Yf+4+f+C"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899afcec41eso5539296d6.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771958859; x=1772563659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFsZS/pvH2pZuQ/AxV5SJGC67VQDWFgMEVx5OG0+bSM=;
        b=Yf+4+f+CVGfU651iPYPO7RApGkv7TCqnJTbyqkJhEBV1gtUws6jv8zrXnx1nLTqmoQ
         He7QEEI24BL4fsnQEhjXSy1DWw63ZCsyiPtc3EQyqHq/XSn/L2yPNA6EmRrOgnTN3S/t
         A07Hrq48HoCHJT36Jz7DOBYexNQoXbAnWZmm1i80qvF9IAZvjtQrVZ5GCg94LcVyjZkB
         qHRZ472OKOwLF4yen+c90dtN674bUBk0w6aMW3rCrjvW5RaCWjdOmjT6qLPGnd1PVABG
         jmx5MB+xxhGNIfVTDbbNX7HvHDY6SHevn3Uab3BbCFoDwnsjthkaBPNH6e0qZSrO/cl8
         BpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958859; x=1772563659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFsZS/pvH2pZuQ/AxV5SJGC67VQDWFgMEVx5OG0+bSM=;
        b=sXX/WB3Cbg/BRcnpnD9h4dOIEGkJPsyYLdNK4jEI0UuBv11oLbzb1r9MSPQypNmkkg
         cINmjF/elmLxHVlC6d6a0mqfZYjamyDW30m8yva/eiyQYATtDlhTRMs1ZMWg0iz1sVLU
         jZE+gks1hO6SVpG+1Hxa8kK6b211k/wE8s6/n6NklcfdHfvbUC/478eWeOSbZ0Qnm8+o
         IvcHOo5JeWJ++dW02J/ip8DGDjZCbP0fDApBqjIL44Zkx6NxFmRkp9dbUqgK9PW3Hm9O
         2UoVsH86bKflGwmF+3Tjl+UskCVu8VtxWCYFkoy+qtTY8g09a9YlUgpj4ld3slM8CrZ/
         8oIA==
X-Gm-Message-State: AOJu0YzCG+CNUjFNhsZLevA9NZx6wg4lZuigCk7kjL3hCd2jOoO3iX37
	l6LJb8qdnxBEjZIPCBYxqNLgaL2tLWZqBpwz4tr1qP63hZp64WvXk91I4VIUgpgaGkE=
X-Gm-Gg: AZuq6aL/N+sM0LuIjWB4qR4eX+1DLVD4FHShkgc/Fw6Rd97MivQISXZl59807hNUudq
	JOp5Zu6l0tPrY4JseyJc1lyoaOM/g8vGCUtDA98WWvwb+aNVlfW5cARFBHVzqhjG2p43tepLB58
	ZslucTbuRiSTNLlbaqQQfeMm4sigvy4ctR0SxPFejvRUc6W226KOyWwyozIvr5G6H7jrFqFU4sc
	/do0fdZ9wT6io7rMH5MkiTpOwCvDG1Qw8trDe/tBJ4Zz6YyJETqm4tR8gS5+XrpVDsOkDH1Yti7
	DmRvF7+YuejOfUnIU81nY23YD3G0xRtej9SJg47jTUbNoAk6PniH+ZXVOGKNhMZg7/mztam7wt7
	2gNp+aRb+9X6JSvOYXEq1MkQShJzDlNukZmi5Tn4d7LAnUhNvc/UikLk4JRy1Vujp5cjBF488Gu
	otKfZEX7c1uUaYItwqo2ItQoqX/BZWuZP+AGiHp2icQznIaP7pRiPupAxN5KXK8XAysFp0qdnkW
	PabWCekqrGkl08jtYDMcpRbtCOhaQ==
X-Received: by 2002:a05:622a:654:b0:501:1794:f9e7 with SMTP id d75a77b69052e-5070bbd837bmr168722411cf.31.1771958858583;
        Tue, 24 Feb 2026 10:47:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d544cabsm114918911cf.13.2026.02.24.10.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:47:38 -0800 (PST)
Date: Tue, 24 Feb 2026 13:47:31 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/18] midx: do not require packs to be sorted in
 lexicographic order
Message-ID: <aZ3yQ7D54jcyQhLY@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <72bcd4ed6c7f685f58bb3b905fe553173abe1845.1768420450.git.me@ttaylorr.com>
 <aXhqo3f-NeUcO2IM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXhqo3f-NeUcO2IM@pks.im>

On Tue, Jan 27, 2026 at 08:34:59AM +0100, Patrick Steinhardt wrote:
> On Wed, Jan 14, 2026 at 02:54:45PM -0500, Taylor Blau wrote:
> [snip]
> > Because this change produces MIDXs which may not be correctly read with
> > external tools or older versions of Git. Though older versions of Git
> > know how to gracefully degrade and ignore any MIDX(s) they consider
> > corrupt, external tools may not be as robust. To avoid unintentionally
> > breaking any such tools, guard this change behind a version bump in the
> > MIDX's on-disk format.
>
> s/Because t/T/?

Nice spotting, thank you.

> > @@ -105,6 +108,8 @@ struct write_midx_context {
> >
> >  	uint32_t preferred_pack_idx;
> >
> > +	int version; /* must be MIDX_VERSION_V1 or _V2 */
>
> Tiny nit: this could be converted into an `enum` for implicit
> documentation.

I wrote it this way initially, but ended up dropping the type down to
"int" because the enum values named "_V1" and "_V2" would have integral
values of "1", and "2", respectively.

> > diff --git a/midx.c b/midx.c
> > index 19ef230d3fd..1327d0a3695 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -656,17 +658,40 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
> >  	return strcmp(idx_or_pack_name, idx_name);
> >  }
> >
> > +
> > +static int midx_pack_names_cmp(const void *a, const void *b, void *m_)
> > +{
> > +	struct multi_pack_index *m = m_;
> > +	return strcmp(m->pack_names[*(const size_t *)a],
> > +		      m->pack_names[*(const size_t *)b]);
> > +}
>
> Okay, this took a second to figure out. The `pack_names_sorted` is an
> array of `size_t` indexes into `m->pack_names`. So what we get here are
> these indices, and we can compare by using those indices via
> `m->pack_names`. Makes sense.
>
> I was wondering whether this would be easier to follow if
> `pack_names_sorted` was a simple array of unowned pointers. So it would
> contain the same pointers as `pack_names`, but properly sorted. It would
> have the downside of more confusing ownership semantics though.

Exactly. For that reason, I generally prefer holding onto a permutation
array (of indices) rather than a permuted form of the existing array.
The ownership of the former is unambiguous, but the latter is IMHO not.

> I assume we cannot live with a simple `bool sorted` field and then sort
> `pack_names` lazily?

Unfortunately not, because the pack_names array is indexed by the
pack_int_id, which we have to preserve.

Thanks,
Taylor
