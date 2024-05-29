Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5D15B0E6
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021793; cv=none; b=QKGKAl4r3gq7ycnzH7Y9R4/Fcjx0qXJoYRDL6+5seVA+BH6G4vffCzljHsyeVF8BxedsvH6SGVX602Y3AumFNEgVNRNL57o6ItLyVGFWVWFSQJPzMznI/oZdq+bR2avZe2YBycAGhUdwBDJZEDSa4eUSwF3bT8HUhUp+5FkiP7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021793; c=relaxed/simple;
	bh=RLFC7suVXpudFMxQJdXxUI+MOE/qv8OzYtJLfz1cumI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZGxzenpk8XCcYyo1jovg5zK3kMqjMrm6oEk4FHBR/JM83nY9/9yHtUE9yvKYKEPKzpgbd9DWnkSQfNuqSvS22FseKHs6SIICy/gKY0iIU9v3ZgT/HFj2fvhmALREvF1HSFJ8JHodiV49yGe0wHG3Ax9KIywhEzvYSd863TowZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WOxHMFCU; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WOxHMFCU"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a08b1a81bso1624267b3.3
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717021791; x=1717626591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zas6W90v/ZmXk1re4n7J7bcYTecfqETmNOR4dehIuGA=;
        b=WOxHMFCUQlsV3XI0dk/b6nXnVEWAvIsLwrLAa7/ts1HR43ohdUG3LJu9aq4Oc36NSN
         rX9MWgJQIwwA8Z+9UtuO6DVIhNZg641quUHyX1s8LnAJ+X+zxMia8TLeKV1txllYtxel
         E0bwhDVF01zoIy4sFrGakgY8yQ84LySuOMl/n4OT2+UOIDwS+u+JP/m4GXGoURdtyxHt
         Hl4lTdxWIgk+qzj5d0vUiV0Vva11s750IKxRfaLTEAj0ib/grGT7xFYC1dXlSb/ZlIIi
         yZpaRx/n0ukcyCAZc9kY7eSBVLeyGfIBzBazz2VSnlOleyIzOMH7FQJjc/T9PsAaBeRb
         3Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021791; x=1717626591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zas6W90v/ZmXk1re4n7J7bcYTecfqETmNOR4dehIuGA=;
        b=sdACmPywkIjU58AX1VG+8twg+jFXVlQbKpR/d9YM0yud+J5c2pAD4qpdZxkgeRaDDf
         NQfbqUzMv8QPKf9sHkFU0ucHGfrUxrTuDWuLOrSSf81F44lqztLt/yHIT0k8s9Y0gLuq
         Zwu452Hl4Wb7MlNyjV+S1YoTcEEMvZjT0/4BWKPaTbSzjHa7rD3yAnK61CdVhK2TiX6F
         xRpQDtZbQyEhP6bjfqXavIUNK7Zoha8VK73ZdMn/LI+vqLBHvbWiTAyp5ME3G7MJi7MF
         ZTbnLq3KSSZsAZyW91moy0hsyBh8k+S9ukW3ciGGLOnCwOaHDd8yB7MJCFRqHnGidKnP
         LUyw==
X-Gm-Message-State: AOJu0Yyf8OtUE5m8JateqkJgXbsVbdZmIbOleRvEevSVlzifdMfK779Z
	4abWHaCxTVaND+eGbQJ4DspmmZGpl5XIXoQA0XLcKirYVrwY2nrowj3YMuqNN4+Xjmtuv1CoON/
	TJF4=
X-Google-Smtp-Source: AGHT+IHodBO2TkSPFyFfvk0dgZzK/WFkg2+uxWnF51W5QMwsQDGachyvHRz+ZwdGK0acZKhbrmuZqg==
X-Received: by 2002:a05:690c:c:b0:60a:66c0:d5fe with SMTP id 00721157ae682-62c6bbf9558mr6619137b3.13.1717021790588;
        Wed, 29 May 2024 15:29:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a4ee0ffsm25770537b3.94.2024.05.29.15.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:29:49 -0700 (PDT)
Date: Wed, 29 May 2024 18:29:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] midx-write.c: tolerate `--preferred-pack` without
 bitmaps
Message-ID: <ZlesVWe/22lFTgGl@nand.local>
References: <cover.1716482279.git.me@ttaylorr.com>
 <c753bc379b005ecaf131f8f1ae9c5b80b2712759.1716482279.git.me@ttaylorr.com>
 <ZlbdnkFIg1H_KQxS@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlbdnkFIg1H_KQxS@tanuki>

On Wed, May 29, 2024 at 09:47:52AM +0200, Patrick Steinhardt wrote:
> On Thu, May 23, 2024 at 12:38:03PM -0400, Taylor Blau wrote:
> > When passing a preferred pack to the MIDX write machinery, we ensure
> > that the given preferred pack is non-empty since 5d3cd09a808 (midx:
> > reject empty `--preferred-pack`'s, 2021-08-31).
> >
> > However packs are only loaded (via `write_midx_internal()`, though a
> > subsequent patch will refactor this code out to its own function) when
> > the `MIDX_WRITE_REV_INDEX` flag is set.
> >
> > So if a caller runs:
> >
> >     $ git multi-pack-index write --preferred-pack=...
> >
> > with both (a) an existing MIDX, and (b) specifies a pack from that MIDX
> > as the preferred one, without passing `--bitmap`, then the check added
> > in 5d3cd09a808 will result in a segfault.
>
> The check you're talking about is the following one, right?
>
>     if (ctx.preferred_pack_idx > -1) {
>             struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
>             if (!preferred->num_objects) {
>                     error(_("cannot select preferred pack %s with no objects"),
>                           preferred->pack_name);
>                     result = 1;
>                     goto cleanup;
>             }
>     }
>
> And the segfault is because the index wasn't populated, and thus
> `ctx.info[ctx.preferred_pack_idx].p == NULL`?

Exactly.

> > Note that packs loaded from disk which don't appear in an existing MIDX
> > do not trigger this issue, as those packs are loaded unconditionally. We
> > conditionally load packs from a MIDX since we tolerate MIDXs whose
> > packs do not resolve (i.e., via the MIDX write after removing
> > unreferenced packs via 'git multi-pack-index expire').
> >
> > In practice, this isn't possible to trigger when running `git
> > multi-pack-index write` from via `git repack`, as the latter always
>
> s/from via/via/

Ah, oops, thanks.

> > passes `--stdin-packs`, which prevents us from loading an existing MIDX,
> > as it forces all packs to be read from disk.
> >
> > But a future commit in this series will change that behavior to
> > unconditionally load an existing MIDX, even with `--stdin-packs`, making
> > this behavior trigger-able from 'repack' much more easily.
> >
> > Prevent this from being an issue by removing the segfault altogether by
>
> Removing segfaults is always good :)
>
> > calling `prepare_midx_pack()` on packs loaded from an existing MIDX when
> > either the `MIDX_WRITE_REV_INDEX` flag is set *or* we specified a
> > `--preferred-pack`.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  midx-write.c                |  8 +++++++-
> >  t/t5319-multi-pack-index.sh | 23 +++++++++++++++++++++++
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/midx-write.c b/midx-write.c
> > index 9d096d5a28..03e95ae821 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -930,11 +930,17 @@ static int write_midx_internal(const char *object_dir,
> >  		for (i = 0; i < ctx.m->num_packs; i++) {
> >  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
> >
> > -			if (flags & MIDX_WRITE_REV_INDEX) {
> > +			if (flags & MIDX_WRITE_REV_INDEX ||
> > +			    preferred_pack_name) {
> >  				/*
> >  				 * If generating a reverse index, need to have
> >  				 * packed_git's loaded to compare their
> >  				 * mtimes and object count.
> > +				 *
> > +				 * If a preferred pack is specified,
> > +				 * need to have packed_git's loaded to
> > +				 * ensure the chosen preferred pack has
> > +				 * a non-zero object count.
> >  				 */
> >  				if (prepare_midx_pack(the_repository, ctx.m, i)) {
> >  					error(_("could not load pack"));
>
> We now end up loading all packs, but in practice it should be sufficient
> to only load the preferred pack, right? Is there a particular reason why
> we now load all packs?

I had originally considered that, but discarded the idea because it
seemed like it might be fragile to depend on those two points in the
code having the exact same notion of what the preferred pack is.

Since it's cheap enough to load all of these packs in unconditionally
anyways, that's the route that I ended up taking here.

Thanks,
Taylor
