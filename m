Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC425569
	for <git@vger.kernel.org>; Mon,  6 May 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013469; cv=none; b=b5WxCyavYEIFswj9WyBPm5qgkM8hwNKJC9jHD1XTwTlvNRtucqBJIVUpBnJjdJOq0hwF1N5SzlGAQiHR43dJG32f+Z38yX0/O51icinasT2hXuE6pCFXd1hXfJ6q2mTEGX3Okaj4GlYtmQi2LWFsHSV0Zuj11kpWI822oVsuvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013469; c=relaxed/simple;
	bh=llYzWOV5Z3oB+ELHMcgn9d1oHDktz3Szwon5kSC9XtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg7UPqiwprvMJtVqelrNqJykWUhfr/LrcN2SPiclIg7CMHfvnw6WXNpnbY/glKMuHbUx6WIx8VyNzdSkbwF9YadL13VBiAqnUKgFBfSyo2Fx9dVQ13jfKCfE0qzUXT4CfN5yClLilLtDw1RGRU7/EjiX8t0z+dgQkVnrPN92wMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eTgJmHdz; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eTgJmHdz"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6153d85053aso14068257b3.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715013467; x=1715618267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vn7/iSxaFIoknA4U7jog2dgXHo6HUbonMlmWP9Rz6I=;
        b=eTgJmHdz6tiNoDa5b1qi16sBpjIHjgUKuM4yKWUsq0H6C5kDqL9x8RuSyemTK5FjHZ
         ABa6F45QmVAaSFsmsqzNy0IrIAi2BsslC9keR4ZOxSpfKXWxEe1o/qWyo4FbKeHV9iq5
         aM/NtfAD+nQoRQ0kOJ9V+9009DqV7hNyGuC3BKiH7iE5cHVdwZRA6EZ1ODmkLwhHa8cu
         ONDqXhSBs7KM+3C1YNZ+GgLX/7WMH39PZ4xpQKWrYQpOUUoNJ2hrZe5oCYCOiSSVanO8
         8pPWm7qB6hdzZEGOsOkfBz1fCoh0Bmihn+pk+Llai1/Gn3oHdA3vNhchPRjwl/Fxa5aE
         5GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715013467; x=1715618267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Vn7/iSxaFIoknA4U7jog2dgXHo6HUbonMlmWP9Rz6I=;
        b=oyoDmqile0IXq7OIqTG6SLuDAxnWiYIwN7Owi13uIGGwoPVMHNH5Q86528QkhMyhFq
         jV9THi2tMKXjNgdzLpFY9H/6dD90O8cZyLrWB2/VANDNJ5HPbeFXsBI+//P/uzI+Ujqb
         QSm96EX73p/KJwXIKNf/ea5gLk9V/t+BxKMuJxcbLoAd1BADYW9G3nGIoMtPX8/OFpZv
         K++Y+KyFwzwEfh+8H6NyvCpt+Bi2hZO/tywF1Y45Ma1BaSHgZLIZNZ25pt87THNhtnhX
         RajGuZlo4g8WPyjCmfEp9UNd7gXqv7DYk1jjXvrx2dWsd7PJUK1AjHCUMGl7ryqn8NIv
         QoyQ==
X-Gm-Message-State: AOJu0Yz7Dv2+lzzoXl7VhzDvRB/x+/gsH460eCLjF51/9cWlLvM1DNaN
	rVAPSsQjumA4+8niEDwp2nbd+xAS5eD+Xad6bZ5JoKG7VQgmzA/Xg1KmIPxspSY=
X-Google-Smtp-Source: AGHT+IE3X/EBTFBW54WtwGIGfLi09i+Z5dLbOel8acLtQCD78z+kQVU1ni6TCEC1ILNqn6z6Qb2qaQ==
X-Received: by 2002:a81:9286:0:b0:60a:448:ff4f with SMTP id j128-20020a819286000000b0060a0448ff4fmr10261955ywg.41.1715013466466;
        Mon, 06 May 2024 09:37:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n22-20020a81af16000000b00617f34f6794sm2208248ywh.121.2024.05.06.09.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:37:46 -0700 (PDT)
Date: Mon, 6 May 2024 12:37:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/23] Documentation/technical: describe pseudo-merge
 bitmaps format
Message-ID: <ZjkHT9XVl7ua8E14@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <43fd5e3597151a86254e18e08ffd8cadbcb6e4f0.1714422410.git.me@ttaylorr.com>
 <ZjjEjNRp2BAMWJ47@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjjEjNRp2BAMWJ47@tanuki>

On Mon, May 06, 2024 at 01:52:44PM +0200, Patrick Steinhardt wrote:
> > diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
> > index f5d200939b0..63a7177ac08 100644
> > --- a/Documentation/technical/bitmap-format.txt
> > +++ b/Documentation/technical/bitmap-format.txt
> > @@ -255,3 +255,182 @@ triplet is -
> >  	xor_row (4 byte integer, network byte order): ::
> >  	The position of the triplet whose bitmap is used to compress
> >  	this one, or `0xffffffff` if no such bitmap exists.
> > +
> > +Pseudo-merge bitmaps
> > +--------------------
> > +
> > +If the `BITMAP_OPT_PSEUDO_MERGES` flag is set, a variable number of
> > +bytes (preceding the name-hash cache, commit lookup table, and trailing
> > +checksum) of the `.bitmap` file is used to store pseudo-merge bitmaps.
>
> Here you say that the section is supposed to come before some other
> sections, whereas the first sentence in the "File format" section says
> that it is the last section in a bitmap file.

This is a quirk of the on-disk .bitmap format. New sections are added
before existing sections, so if you were reading the file from beginning
to end, you'd see the pseudo-merges extension, then the lookup table,
then the name-hash cache (assuming all were written).

I think that describing them in the order they were introduced here
makes more sense, leaving their layout within the .bitmap file as an
implementation detail.

If you feel strongly otherwise, let's clean it up outside of this series
since this whole portion of the documentation would need to be
reordered.

> > +A "pseudo-merge bitmap" is used to refer to a pair of bitmaps, as
> > +follows:
> > +
> > +Commit bitmap::
> > +
> > +  A bitmap whose set bits describe the set of commits included in the
> > +  pseudo-merge's "merge" bitmap (as below).
> > +
> > +Merge bitmap::
> > +
> > +  A bitmap whose set bits describe the reachability closure over the set
> > +  of commits in the pseudo-merge's "commits" bitmap (as above). An
> > +  identical bitmap would be generated for an octopus merge with the same
> > +  set of parents as described in the commits bitmap.
> > +
> > +Pseudo-merge bitmaps can accelerate bitmap traversals when all commits
> > +for a given pseudo-merge are listed on either side of the traversal,
> > +either directly (by explicitly asking for them as part of the `HAVES`
> > +or `WANTS`) or indirectly (by encountering them during a fill-in
> > +traversal).
> > +
> > +=== Use-cases
>
> I feel like starting with the problems that the whole feature is
> intended to solve would help the reading flow quite a bit. So I'd move
> this whole section up.

I think we may want something in the middle, more like a "problem
statement". I wrote up a section that aims to do that, and tries to both
briefly describe the problem (first), as well as a small overview of
what the solution is. Let me know what you think:

--- 8< ---
diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 63a7177ac0..144f377e35 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -263,6 +263,26 @@ If the `BITMAP_OPT_PSEUDO_MERGES` flag is set, a variable number of
 bytes (preceding the name-hash cache, commit lookup table, and trailing
 checksum) of the `.bitmap` file is used to store pseudo-merge bitmaps.

+=== Problem
+
+When a bitmap traversal is performed, the client may have to do some
+amount of "fill-in" traversal to find the set of objects reachable from
+references which do not have bitmap coverage within the repository.
+
+This fill-in traversal can be expensive, and can become a significant
+bottleneck in repositories that have a large number of references with
+poor bitmap coverage. Ideally every single reference would have
+reachability bitmap coverage, but this is also not feasible as doing so
+would reduce cache locality when reading the .bitmap file, and we would
+also spend a significant amount of time XOR'ing individual bitmaps
+together to generate a result.
+
+This section describes "pseudo-merge bitmaps", a new kind of
+reachability bitmap that describes the set of objects reachable from a
+group of references, rather than an individual reference.
+
+=== Overview
+
 A "pseudo-merge bitmap" is used to refer to a pair of bitmaps, as
 follows:
--- >8 ---

> > +For example, suppose there exists a pseudo-merge bitmap with a large
> > +number of commits, all of which are listed in the `WANTS` section of
> > +some bitmap traversal query. When pseudo-merge bitmaps are enabled, the
> > +bitmap machinery can quickly determine there is a pseudo-merge which
> > +satisfies some subset of the wanted objects on either side of the query.
> > +Then, we can inflate the EWAH-compressed bitmap, and `OR` it in to the
> > +resulting bitmap. By contrast, without pseudo-merge bitmaps, we would
> > +have to repeat the decompression and `OR`-ing step over a potentially
> > +large number of individual bitmaps, which can take proportionally more
> > +time.
> > +
> > +Another benefit of pseudo-merges arises when there is some combination
> > +of (a) a large number of references, with (b) poor bitmap coverage, and
> > +(c) deep, nested trees, making fill-in traversal relatively expensive.
> > +For example, suppose that there are a large enough number of tags where
> > +bitmapping each of the tags individually is infeasible. Without
> > +pseudo-merge bitmaps, computing the result of, say, `git rev-list
> > +--use-bitmap-index --count --objects --tags` would likely require a
> > +large amount of fill-in traversal. But when a large quantity of those
> > +tags are stored together in a pseudo-merge bitmap, the bitmap machinery
> > +can take advantage of the fact that we only care about the union of
> > +objects reachable from all of those tags, and answer the query much
> > +faster.
>
> I would start the explanation with a discussion of the problem before
> presenting the solution to those problems. In the current version it's
> the other way round, you present a solution to a problem that isn't yet
> explained
>
> It might also be helpful to discuss a bit who is supposed to create
> those pseudo-merge bitmaps. Does Git do so automatically for all tags?
> Does the admin have to configure this? If the latter, when do you want
> to create those and what strategies are there to create them?

The pseudo-merge bitmaps are created by Git itself, configured via the
options described later on in this series. I'm happy to add a specific
call-out, but I would rather do it elsewhere outside of
Documentation/technical/bitmap-format.txt, which I think should be
mostly focused on the on-disk format.

> > +=== File format
> > +
> > +If enabled, pseudo-merge bitmaps are stored in an optional section at
> > +the end of a `.bitmap` file. The format is as follows:
> > +
> > +....
> > ++-------------------------------------------+
> > +|               .bitmap File                |
> > ++-------------------------------------------+
> > +|                                           |
> > +|  Pseudo-merge bitmaps (Variable Length)   |
> > +|  +---------------------------+            |
> > +|  | commits_bitmap (EWAH)     |            |
> > +|  +---------------------------+            |
> > +|  | merge_bitmap (EWAH)       |            |
> > +|  +---------------------------+            |
> > +|                                           |
> > ++-------------------------------------------+
> > +|                                           |
> > +|  Lookup Table                             |
> > +|  +------------+--------------+            |
> > +|  | commit_pos |    offset    |            |
> > +|  +------------+--------------+            |
> > +|  |  4 bytes   |   8 bytes    |            |
> > +|  +------------+--------------+            |
>
> It's a bit confusing that in the EWAH section above you have the type of
> the fields in the same line as the field itself, whereas here you have
> them formatted in a separate box. This makes the reader wonder at first
> whether this is two or four fields. How about the following instead:
>
>     |  Lookup Table                             |
>     |  +---------------------------+            |
>     |  | commit_pos (4 bytes)      |            |
>     |  +---------------------------+            |
>     |  | offset (8 bytes)          |            |
>     |  +---------------------------+            |
>
> The same comment applies to the other sections further down.

Much preferable, thanks. I made the change to use the suggested format
here and elsewhere in the document.

> In case you have multiple pseudo-merge bitmaps, is the whole of the
> above repeated for each bitmap or is it just parts of it?

The "pseudo-merge bitmaps" section contains a variable number of pairs
of EWAH bitmaps, one pair for each pseudo-merge bitmap. I think this is
covered below where it says "one or more pseudo-merge bitmaps, each
containing: [...]", but let me know if I should be more explicit.

> > +* An (optional) extended lookup table (written if and only if there is
> > +  at least one commit which appears in more than one pseudo-merge).
> > +  There are as many entries as commits which appear in multiple
> > +  pseudo-merges. Each entry contains the following:
> > +
> > +  ** `N`, a 4-byte unsigned value equal to the number of pseudo-merges
> > +     which contain a given commit.
>
> How exactly is the given commit identified? Or in other words, given an
> entry in the lookup table here, how do I figure out what commit it
> belongs to?

They aren't identified within this section. The extended lookup table is
indexed into via the lookup table with an offset that is stored in the
`offset` field when the MSB is set.

> > +  ** An array of `N` 8-byte unsigned values, each of which is
> > +     interpreted as an offset (relative to the beginning of the
> > +     `.bitmap` file) at which a pseudo-merge bitmap for this commit can
> > +     be read. These values occur in no particular order.
> > +
> > +* Positions for all pseudo-merges, each stored as an 8-byte unsigned
> > +  value (in network byte-order) containing the offset (relative to the
> > +  beginnign of the `.bitmap` file) of each consecutive pseudo-merge.
>
> s/beginnign/beginning

Great catch, thanks!

Thanks,
Taylor
