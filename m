Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE41F7553
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754013; cv=none; b=LR9TXyQDk3rxAOroFOD96+tLxhFsZY2NdbdK1KXrFJc6H3AqVrOL3WXvzdQiUwkuy9nNqcADxhBteRxT2wv4lpWXzTRVo/bXdaElOcwroLGlM01KNPUco6BAv448V0dft6fC7j/oyzh5j+WR2F1Z1pTeWwtIHxl72894mzkqxeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754013; c=relaxed/simple;
	bh=NFaB8DGcfDfZRJVVfjd0Eca8Y8qd74IO64qaLbfGAmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm+hMlznsGPAYwH50cuJCRpKqlY4y6SrjoHbYlqACIsHAwDaoex03y2OYfDSoA9GmDIZGkYsrscS068EcQeMKUatIfuwY3QY+ke8ac3DBAufYlgk/JmaPUQkq6PaNTfFNXoffc7KrsW543TBnQJHCNiQ8N/atZ9mKeHBDmF5O5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NrC66cym; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NrC66cym"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e5a5a59094so42152907b3.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 13:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730754010; x=1731358810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fNdsIKzRTpGVwLozqnF76E3ZGvLhtiuWtoSNjnUymcQ=;
        b=NrC66cymny6+i9LeNCl7w6g7maJFkPGvxyYwuAOLMvXRt6vdyta1ySYQatQJL3PHU9
         IhQvaPMTn90tKpvT0cCAG17kdtvvlUkQuuH7UgRw8zt+T05IcmBBMc0yNFaevVFm86cv
         D/hOdklpRqhklz7kb/zSBgnsjL/juwReNSKrULZ3XjcfsWqQKuBwwLLLXU+6jHw/QRRC
         PkN3Fzd/0yHQ7KuQcbi3rYAkQCYLjd7f5SLigYxE60wHAS/6v1F+oHeLp4ude/7T1BIn
         JG8mmLrteynalBocc2hSj6/qel2jypdbywnN4oA8ZjHDQRqieL7udTkE7tQojQGzwo66
         utVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754010; x=1731358810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNdsIKzRTpGVwLozqnF76E3ZGvLhtiuWtoSNjnUymcQ=;
        b=HbLZRuQTlNkZMLyqiulYIe1676N4sLEzeR4aviam0D0zNjC6+vVsTheDDK4g20G+51
         nRUMG4+oTKp1NMl5QnPMwrVBOfwur6QNThLIpxuUm2Pe8tcgyAQ/rbUzwE5gvzVfC9Sp
         ponPf1xUeCItzjXyt043kmVt3s1HJL1O2qJBdyY5IkAiUqid+HCxcZjaaGEcdyEFvgvQ
         rebvwi7kL74q+FkjfjxC166YI+Ts+jiN57cMGsM0X75/sv+GVtDd1Emf2gSWQqmgE/mX
         v4ajNzWBu9S5s99B44xITb7Ru8wEUVfBR0xFPjDpLjCZClNjqIeB0IgNx3jc6jP7OchI
         CRkw==
X-Gm-Message-State: AOJu0Yy0s39NxsQzUQvtipca6SAHiXKqHrDB166DZbIBSyLiJ+03KMcJ
	ArwHs3c8EJfZu6BVrUKRMxZ1Ac/06QsOQRk6h+Lghz/biOksaQtR6+NYMIo5HOo=
X-Google-Smtp-Source: AGHT+IHajx5GW6AlqRKATOjYi02cEWiXpNsZXHpHBuLQma87lHNnuOgp7vs/LnkH3df+jcpM/EvYuQ==
X-Received: by 2002:a05:690c:6e8e:b0:6dd:ce14:a245 with SMTP id 00721157ae682-6ea64a8d443mr133493337b3.6.1730754010384;
        Mon, 04 Nov 2024 13:00:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a6101esm2185723276.11.2024.11.04.13.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:00:09 -0800 (PST)
Date: Mon, 4 Nov 2024 16:00:08 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 09/11] pack-bitmap: enable cross-pack delta reuse
Message-ID: <Zyk12FZ+NcOUALAz@nand.local>
References: <cover.1728505840.git.me@ttaylorr.com>
 <ca3a916cd6e93aaa09ccff9f77fc127254222068.1728505840.git.me@ttaylorr.com>
 <20241011083134.GG18010@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011083134.GG18010@coredump.intra.peff.net>

On Fri, Oct 11, 2024 at 04:31:34AM -0400, Jeff King wrote:
> On Wed, Oct 09, 2024 at 04:31:28PM -0400, Taylor Blau wrote:
>
> > In order to do this, the pack-reuse code within pack-bitmap.c marks
> > bits in a separate bitmap called 'reuse_as_ref_delta'. Objects whose
> > bits are marked in that bitmap must be converted from OFS_DELTAs to
> > REF_DELTAs.
> >
> > To mark bits in that bitmap, we adjust find_base_bitmap_pos() to
> > return the bitmap position of any delta object's base regardless of
> > whether or not it came from the same pack. This is done by:
> >
> >   1. First converting the base object's into a pack position (via
> >      `offset_to_pack_pos()`).
> >
> >   2. Then converting from pack position into into lexical order (via
> >      `pack_pos_to_index()`).
> >
> >   3. Then into an object ID (via `nth_packed_object_id()`).
> >
> >   4. Then into a position in the MIDX's lexical order of object IDs
> >      (via `bsearch_midx()`).
> >
> >   5. And finally into a position in the MIDX's pseudo-pack order (via
> >      `midx_pair_to_pack_pos()`).
> >
> > If we can find that base object in the MIDX, then we use its position
> > in the MIDX's pseudo-pack order to determine whether or not it was
> > selected from the same pack. If it is, no adjustment is necessary.
> > Otherwise, we mark the delta object's position in the new
> > `reuse_as_ref_delta` bitmap, and convert accordingly from within
> > `write_reused_pack_one()`.
>
> OK, that makes sense. It does feel like a non-trivial amount of work to
> do for each delta we're going to (potentially) reuse from a midx'd pack.
> Can we recognize the common case that the base is in the same pack and
> also being sent/reused without doing the full conversion to oid and the
> resulting bsearch?

I don't think it ends up saving you anything if you don't find anything
matching the pack/offset pair in the MIDX. If you perform that lookup
with bsearch_midx() and get nothing back, then you have to take the
slower path above anyway.

My figuring here was that it would be better to uniformly take a
slightly slower path instead of taking a hopefully-faster path which
might fail, only to then go back to the slower path on top.

Of course, you could do both, or apply some heuristics like avoiding the
cross-pack lookup if you know you're in the preferred pack, etc. I'm not
sure how much it is worth doing so, TBH.

> > @@ -1182,10 +1188,24 @@ static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
> >  	if (pos >= end)
> >  		return reuse_packfile->bitmap_pos / BITS_IN_EWORD;
> >
> > -	while (pos < end &&
> > -	       reuse_packfile_bitmap->words[pos / BITS_IN_EWORD] == (eword_t)~0)
> > +	while (pos < end) {
> > +		size_t wpos = pos / BITS_IN_EWORD;
> > +		eword_t reuse;
> > +
> > +		reuse = reuse_packfile_bitmap->words[wpos];
> > +		if (reuse_as_ref_delta_packfile_bitmap) {
> > +			/*
> > +			 * Can't reuse verbatim any objects which need
> > +			 * to be first rewritten as REF_DELTAs.
> > +			 */
> > +			reuse &= ~reuse_as_ref_delta_packfile_bitmap->words[wpos];
> > +		}
> > +
> > +		if (reuse != (eword_t)~0)
> > +			break;
> > +
> >  		pos += BITS_IN_EWORD;
> > -
> > +	}
>
> This is accessing reuse_as_ref_delta_packfile_bitmap->words directly
> using pos/end as limits. But those come from reuse_packfile_bitmap. Are
> we guaranteed to have zero-extended the reuse_as_ref_delta bitmap as far
> as the original went?

Yeah, we know this is OK because both are allocated with the same size
in reuse_partial_packfile_from_bitmap(), where the relevant portion is:

    word_alloc = objects_nr / BITS_IN_EWORD;
    if (objects_nr % BITS_IN_EWORD)
            word_alloc++;

    reuse = bitmap_word_alloc(word_alloc);
    reuse_as_ref_delta = bitmap_word_alloc(word_alloc);

all of the bitmap_set() operations on the former are bounded in
try_partial_reuse(), but adding a length check can be done here as an
extra safety measure.

> Could we just be calling bitmap_get() here, which would do the length
> check for us? Though I guess we would miss out on some whole-word magic
> it is doing. So maybe we need to just do that length check ourselves.

Yeah, we don't use bitmap_get() because we want to access the whole word
at a time.

Thanks,
Taylor
