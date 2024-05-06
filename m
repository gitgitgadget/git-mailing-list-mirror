Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4438494
	for <git@vger.kernel.org>; Mon,  6 May 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021297; cv=none; b=C8qdD5QyvzYCcKefIy4vlZZ1JalhrBlbAYx8MQbzXGkm45Oy8q3/7TV530s5iUpOdWD+HWHNl6nfIb7yNdaoEanl7FoPSypAC2mlapEeS12SaeoWunn/sj1JebpvennAxrGJ62+ryUwxfngwtTQaZJIQNlMYU+6oT9uxk2kKOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021297; c=relaxed/simple;
	bh=03MavXYindXDudjIBG4DaKFuz5Dv02jm/VZ0J8jeVJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aufahsyq+iBRjGmLqWOOz5DJZh7TcPuaCced+UNBKXxOa/iHWXIIK73YOuloFkcAAqgYRMyC54UB/i9lHBNWddnOR0iXIF1KQ2zNj3Plwa4DbsGt7ZRYTrz/xxCvl4VftbI93wppkui9+9m2+JBf6wzuTlRFmls2F2xObev1za4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1lb7er/6; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1lb7er/6"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62036051972so25515507b3.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715021295; x=1715626095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxp7Pb4wTuA8PnZ/2b951PW1PGiZBQx5ZYTvVQEvbdw=;
        b=1lb7er/668031lMIUsyOee0AOFdQZjXlf7c2AvMi1N31yn3ATXvcrrLOoap2NjBaWb
         eT/4IBbCfcSKtOwhWUP0aP3KK+MMjS6oenj9GTEjkTYKScVQjGJ0fmdfq0/hAEl0dakU
         0Bc3CkbLYp1R1dTGVf2bCUyt9E1cdMRN9uP9kTmEyFdACqkb5+fx3g85EiFr50+dURgN
         dpHd5v7vjNKtL7CwTg914h9TOe9upllaq3MTynTPmZhOjIOTyOErmDS8/KzgWdCIiueL
         BqcIVDXcWkb5LpLZvJHrUCMM+4Yj8W8iCqspm0cTbiPmr5jDpCgGuwgy9k6NaB568mtv
         jbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021295; x=1715626095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxp7Pb4wTuA8PnZ/2b951PW1PGiZBQx5ZYTvVQEvbdw=;
        b=QmxbpSRSdnv13itjRCzOpBG4Oqs4s5mb2Cgw7j0DisbeEzXpcEJh9EPvAFwW19je7v
         pBuv/qHRlRhIHCmtPW2z5nsjMWzN2VxwfwFAigzNZyKkhSaQzE1zI28GtbicFIjwQWfM
         Gn/NUeDUeWo8yGBBONxTOdsX4nEViU+PBL1TxOR2lfVNlvULKo09ztMbHbznZMAFRmf9
         pSTE3jI2lfmo36L91cv7Nc+CMbCT+lo7dKiOHmKcNmYL8ba01UGpBtgr2kKlK92S1I4m
         8XjKQyWCVis3PUNH449SY8lJkSdZ4xEvZyjVkZZO/PdHFiB17bLms6FFkPVVan3Pxr3L
         Tk2Q==
X-Gm-Message-State: AOJu0Yy3wBO079nZd/qS7RFj9JhR9CENqXXQbOf1vZUM7N8DJKJGa+3e
	HdnsIFrkhY7tKsgDa/xZ8vwjAsjp5bztHgfO+x5BklxZHuQxYpmB/aQHq2FKSXjgOOIxysWMr95
	AQLc=
X-Google-Smtp-Source: AGHT+IEcLb96IonqIe8Y3UsJU5z/xPSPtq1m6yGdFt/iC1uLga0cdK9n8KNZBVcPj1kEGS9N83zZWw==
X-Received: by 2002:a0d:d987:0:b0:61b:748:55a1 with SMTP id b129-20020a0dd987000000b0061b074855a1mr10817539ywe.13.1715021294875;
        Mon, 06 May 2024 11:48:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z79-20020a0dd752000000b00617ca37b612sm2294009ywd.91.2024.05.06.11.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:48:14 -0700 (PDT)
Date: Mon, 6 May 2024 14:48:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/23] pack-bitmap-write: support storing pseudo-merge
 commits
Message-ID: <Zjkl6vMHCeDsJKdR@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <ee33a70324589a98c2239530b03cc2d7afbdfb9e.1714422410.git.me@ttaylorr.com>
 <ZjjEmGHYnw20wVBg@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjjEmGHYnw20wVBg@tanuki>

On Mon, May 06, 2024 at 01:52:56PM +0200, Patrick Steinhardt wrote:
> On Mon, Apr 29, 2024 at 04:43:15PM -0400, Taylor Blau wrote:
> [snip]
> > @@ -46,6 +48,11 @@ struct bitmap_writer {
> >
> >  static struct bitmap_writer writer;
> >
> > +static inline int bitmap_writer_selected_nr(void)
> > +{
> > +	return writer.selected_nr - writer.pseudo_merges_nr;
> > +}
>
> This function may use a comment to explain what its meaning actually is.
> Like, `bitmap_writer_selected_nr()` is obviously not the same as the
> `selected_nr` of the `bitmap_writer`, which is quite confusing. So why
> do we subtract values and why are there two different `selected_nr`s?

selected_nr is the total number of bitmaps we are writing (including
pseudo-merges), and writer.pseudo_merges_nr is the number of those
bitmaps which are pseudo-merges.

I renamed this function to bitmap_writer_nr_selected_commits() which
should clarify things, let me know if that works!

> [snip]
> > diff --git a/pack-bitmap.h b/pack-bitmap.h
> > index dae2d68a338..ca9acd2f735 100644
> > --- a/pack-bitmap.h
> > +++ b/pack-bitmap.h
> > @@ -21,6 +21,7 @@ struct bitmap_disk_header {
> >  	unsigned char checksum[GIT_MAX_RAWSZ];
> >  };
> >
> > +#define BITMAP_PSEUDO_MERGE (1u<<21)
> >  #define NEEDS_BITMAP (1u<<22)
>
> This flag is already used by "builtin/pack-objects.c", which may be fine.
> But in any case, shouldn't we update "object.h" with both of these flags?

I can't see where in builtin/pack-objects.c this flag is used. The table
in object.h says that bit 21 is used in:

  - list-objects-filter.c
  - builtin/index-pack.c
  - builtin/unpack-objects.c

But I think those are all fine. We don't call unpack-objects from the
bitmap writing paths, and the same is true of index-pack (since we're
writing the pack out directly).

list-objects-filter.c should also be OK, since I am 99% sure that these
two code paths do not collide, but even if they do, that field is only
set on tree objects from the list-objects-filter.c code path, and the
new bits in pack-bitmap.h are only set on commit objects.

Regardless, let me not forget to update the table in object.h! Thanks
for reminding me.

Thanks,
Taylor
