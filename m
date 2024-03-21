Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036EA132489
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059219; cv=none; b=MM97wszu1C13PGOBKlt+QnuYlzeeiRBDCL+CrK4tGkBOMI8eCSClx5cTm8hoytO17LMYg7wj6z4JQIE68zX7hZd6Cs1H/TUabzxkg05mSHW8EB2OM4XsPbS/BMyXuZBjt05yFLl+tRqZ6cx8CrUyJapaRfZTynP7H7No/hTKgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059219; c=relaxed/simple;
	bh=B2vSPHzcWg81c6rSaYZ+bmMKSpbRA1VWCYmzHl6WCcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIK9Oyl/ueYlSHDd/Ds13XBU0yiyySRYxRqU+GLEiTkAqhQcl/MTqs8kCB1BVVF528ItDfyx0T36y4NvJrFLQhb8fZHivlHQsC/+8ZZYaS19fQBWHZO55QKyhTJCpjdTDSnvD2QZSMGxYu1qUP8aVLgb4vzDQ7ZYIUwjB3ByuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qTTWCjQU; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qTTWCjQU"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e0cfda8e00so388389241.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711059217; x=1711664017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SQ33QVaX98eqvfo6TLYa5soypts1b2XkPYoeFZAqVE=;
        b=qTTWCjQUBwA7LDV0SRBe89TP3mkqyKakG0lMdjAOkQFBP4WZ+ETnrljt7x2J2g4c2i
         epc/gC0mGmSip1ZBrJJlxlpSWo07I9Is2RYvQmcskM17JP1asiyvbIhLga/OkIXNsAos
         9EqIAnw7ooB7+hDePkW0k5S1LXS7b7ZmdEi/n/Qd1GWoLVTvBMZ5bP96bDT/c66DwD8N
         vQPElLvAOE83A1k1nbgHPXdUXCLAe2ZtNf3w1KbbERT3Uak6BqqzvMZHhJozHoMbSrq3
         GUTe3SFdQxJm/BWxPsWQZecVFGoXRH0uUMRL0bGqQrZ4Ay+T7QOBbJTpD6I3GBYITdwF
         Y5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711059217; x=1711664017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SQ33QVaX98eqvfo6TLYa5soypts1b2XkPYoeFZAqVE=;
        b=TbUz9/inWywRZEmm9F1QBBM+GNiBfGFGsV0UJhJm+jApyP+71upc6kbB0pYicTl+24
         7jLvljsGvQdgbCuejMx+Shk9k65gpsFAoCiJu/fDyDoIB82krcBYqPGm2O/2KxcVPHYb
         lk3HVtycIJwrPlRHYrOHZnytJSALfatwMiDwMboFwW7roCcOe4rgYAz13r6C3n6+VhX5
         cXhCmBdjA9ZAFNkIoPqop9wD3yOOEtgz8uddGOhWZlYATerOrkvtQ0HbgxtkUZmCRaP+
         cLpDJroWbgVgp+VQ5S1m2IZqnM/88cVFv3U01P2IVqtAhXzxwNO5J/OMU/bAWYYWCLz9
         lhdw==
X-Gm-Message-State: AOJu0YzBkRQ33kBQcu1+e3ADPIN5D5vrWS1alUIFCPQ8HpgYLzsUMPQa
	ZPTF6AY+s+XXbS5MWVVUT4CxgowQhYhUH6thwaJspVEEx7+j0HJn9n3J9gj98hk=
X-Google-Smtp-Source: AGHT+IGWby5+RYY2QqcsycD63/zvMmX1LiQ/p69KbnF4mjkKu7c19beqPmG3Z8OS8G3S51HQV5dHVw==
X-Received: by 2002:a05:6102:6d2:b0:473:18d9:caf5 with SMTP id m18-20020a05610206d200b0047318d9caf5mr1085799vsg.24.1711059216832;
        Thu, 21 Mar 2024 15:13:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j12-20020a05621419cc00b006910e7edfedsm364073qvc.62.2024.03.21.15.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:13:36 -0700 (PDT)
Date: Thu, 21 Mar 2024 18:13:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 01/24] Documentation/technical: describe pseudo-merge
 bitmaps format
Message-ID: <ZfyxCLpjbaScIdWA@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <76e7e3b9cca7fb957384ed98f2cd32cf11ff8488.1710972293.git.me@ttaylorr.com>
 <xmqqcyrn6zyd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyrn6zyd.fsf@gitster.g>

On Thu, Mar 21, 2024 at 02:24:10PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +Pseudo-merge bitmaps can accelerate bitmap traversals when all commits
> > +for a given pseudo-merge are listed on either side of the traversal,
> > +either directly (by explicitly asking for them as part of the `HAVES`
> > +or `WANTS`) or indirectly (by encountering them during a fill-in
> > +traversal).
>
> "either side of" implies there are two sides.  Is it correct to
> understand that they are "the side reachable from HAVE" and "the
> other side that is reachable from WANT"?

Yes, exactly.

> > +=== Use-cases
> > +
> > +For example, suppose there exists a pseudo-merge bitmap with a large
> > +number of commits, all of which are listed in the `WANTS` section of
> > +some bitmap traversal query. When pseudo-merge bitmaps are enabled, the
> > +bitmap machinery can quickly determine there is a pseudo-merge which
> > +satisfies some subset of the wanted objects on either side of the query.
>
> Here you only talk about WANT but still mention "either side of".
> How would the HAVE side of the query contribute to the computation?

Apologies for the confusion. In the first sentence, I'm talking about a
specific case where all parents of a pseudo-merge commit are listed
in/reachable from the WANTS side of a traversal.

The second sentence describes the general case. The order should be
swapped so that the second sentence comes first, and vice-versa for the
sentence beginning with "For example, [...]".

> > +  ** `commits_bitmap`, an EWAH-compressed bitmap describing the set of
> > +     commits included in the this psuedo-merge.
> > +
> > +  ** `merge_bitmap`, an EWAH-compressed bitmap describing the union of
> > +     the set of objects reachable from all commits listed in the
> > +     `commits_bitmap`.
>
> "union of the set of objects reachable from all", meaning if an
> object is listed here, all commits in commits_bitmap are guaranteed
> to reach that object?  It sounds more like the intersction of sets
> than union.

Oops, yes, I definitely meant intersection here. Thanks for a close
read.

> > +* A lookup table, mapping pseudo-merged commits to the pseudo-merges
> > +  they belong to. Entries appear in increasing order of each commit's
> > +  bit position. Each entry is 12 bytes wide, and is comprised of the
> > +  following:
>
> "a pseudo-merged commit" is a new term.  It was explained what "a
> pseudo-merge bitmap" is already, and it was explained that "a
> pseudo-merge bitmap" consists of a pair of bitmaps (commit bitmap
> that records which commit belongs to the "pseudo-merge", and merge
> bitmap that records objects reachable from all commits in the commit
> bitmap).  But we haven't heard of "a pseudo-merged commit", or what
> the verb "to pseudo-merge a commit" means.
>
> Does it merely mean "a commit that is recorded in the commit-bitmap
> half of a pseudo-merge bitmap"?  It still is unclear at this point
> in the description if a commit can be part of only one such
> commit-bitmap and makes readers reading hiccup, until a few
> paragraphs below where extended table is there to help a commit
> recorded in commit-bitmap of more than one pseudo-merge bitmaps.

Sorry for being unclear here. A pseudo-merge "commit" refers to a
conceptual octopus-merge commit whose parents are the ones listed in the
"parents" bitmap of the pseudo-merge bitmap, as defined. The "objects"
bitmap is the set of objects reachable from that imaginary commit, or,
equivalently, the intersection of objects reachable from the commits
listed in the parents bitmap.

I'll make this more clear in the next version, thanks.

> I'll stop here for now, but this made me even more convinced that
> the presentation order needs to be rethought to sell why this whole
> thing is a good idea by telling readers what problem it is solving,
> why a new data structure helps and how, etc.  Perhaps you can start
> by trying to write a paragraph of description for the topic suitable
> for the "What's cooking" report, which needs to do a good elevator
> pitch.

I'm sorry that the ordering was sub-optimal here. For the purposes of
the WC report, I would write the following if I were queuing this topic:

  * tb/pseudo-merge-bitmaps (2024-03-21) 24 commits
   - t/perf: implement performace tests for pseudo-merge bitmaps
   - pseudo-merge: implement support for finding existing merges
   - ewah: `bitmap_equals_ewah()`
   - pack-bitmap: extra trace2 information
   - pack-bitmap.c: use pseudo-merges during traversal
   - t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
   - pack-bitmap: implement test helpers for pseudo-merge
   - ewah: implement `ewah_bitmap_popcount()`
   - pseudo-merge: implement support for reading pseudo-merge commits
   - pack-bitmap.c: read pseudo-merge extension
   - pseudo-merge: scaffolding for reads
   - pack-bitmap: extract `read_bitmap()` function
   - pack-bitmap-write.c: write pseudo-merge table
   - pack-bitmap-write.c: select pseudo-merge commits
   - pseudo-merge: implement support for selecting pseudo-merge commits
   - pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
   - pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
   - pack-bitmap-write: support storing pseudo-merge commits
   - pseudo-merge.ch: initial commit
   - pack-bitmap: move some initialization to `bitmap_writer_init()`
   - pack-bitmap: drop unused `max_bitmaps` parameter
   - ewah: implement `ewah_bitmap_is_subset()`
   - config: repo_config_get_expiry()
   - Documentation/technical: describe pseudo-merge bitmaps format

   The pack-bitmap machinery has been extended to write bitmaps for
   pseudo-merges, which are imaginary commits which act as octopus
   merges covering groups of the un-bitmapped parts of history at
   reference tips.

Thanks,
Taylor
