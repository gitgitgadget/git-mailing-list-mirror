Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238C15E8B
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782520899; cv=none; b=sishMPj9sb8LFnMvZcEc2m1sZQTUuqnHSCSXQ2m9K80U0k3sNoYXk8+pFTZ7ZFDetylurEfvxAxvDXcJ0tDalkbhL5QGf76xmeklWI1YAonsSkFoGYeB6LRbLh7TkABuwZGeu+0Vzd7JAlfAfbpQKc2v0TlDgc+bbFry8YYtbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782520899; c=relaxed/simple;
	bh=IlOHwAE7pL4Gtx5uW5P18Jxxv5K71IvDjUbCXyfB8yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw0dblZZe7X4t8dnQhMMfpo6yCc51NFsbM4D0Nh2iksJuOxB1MCt6aZgft/ragI+Q+659OeimJtcb1KquJ+/ERw/eqxAOJ1Vs9u/9tJvi7JWzu6D9AzwGoZz8rgN35TZzAI0cBfClFNX3M/LN0YZpffWK3AOaI6CTtTgchLbV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jlVTEss6; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jlVTEss6"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80b9993928dso17276577b3.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 17:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782520897; x=1783125697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0Lxs4Ajy1a1Z3g++QcVKpqPmVkfZeYt6RZGtmqpPZI=;
        b=jlVTEss6xyxDTlYfTQY6ogygc1p21Eg9ekFprektg7UgcVKCDaYvomggJorIsMvREI
         N5T/998M69aq3ypQMTm/FY7qIdI2aU1fjOF4Zd18o3o5Cgxv2PemnSKPJbnxwDKLcctd
         vm+u3T0/KSo9XMOFZmB8Nis7E4t5mY8W28AjAoDr53sJUSoLlKOQEkoZFJToVZWxWEkb
         e/8hxPcl1xl3VPKuJG2u6fbBBGQDkqK48inlmLAeQwb1/a7h4XhyehWojNNHXhAWHlOB
         5MttnBz+Xx95V8IJwbcPr+WCM4NW3KOvL06hR50eiC5svdImXatE+n9SFH+97tpcBOxN
         aJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782520897; x=1783125697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0Lxs4Ajy1a1Z3g++QcVKpqPmVkfZeYt6RZGtmqpPZI=;
        b=iCxZ/FXv8P+/XQARYsX79NR0+C4LvyEFD/cvyiWiewTwuZ4C9nRFBNHtG1n9kHRouX
         0IjhETNYw26IZSaJSGHap/N8Cp6FHkhbVReW+tXa0k65hLYi87ZzMWLB/sPTEXb2LDpR
         pgmJIxXjdPBFWGy2VV9mvkQn4iKL7O3DEt/lJUfDiXG9z9WpdbcidkVjADBrRjQS7dQx
         Xj0UKyiiEgUdfgtj1VtpzJbGVnw6FrIoSUA1kqcmTP1Fo4TtuotvvDb3Mi440bCpkIe+
         d71+CBXagFgjRWNoTeqmynTyBKCUI1tzJll4NvPzzndGSNNLmkBtyUtSiR4K29+qi+6b
         RNvA==
X-Gm-Message-State: AOJu0Yz+wXQcg+ln7KBlXfH/1jLXCqKmDKXjhOl5aXseO1Ut8h3yj3uy
	+MvAmm3+p5zSD3VSl6xLyEpal3V7sJTmWOgFDwHRC6iGgvVlpldlIkW7AR1yQXhV7aM=
X-Gm-Gg: AfdE7cmyUiigPNw6FtZyX1pryYvtj/pIGD31RWY8FNlZpuLUxCkOZ0JlDAJ8x48/2o0
	CoKsvR06tQ3B6tX1Ov4Xp2Mf0KFLCO7MdD7IDK+WHBmYw3hSmoZJMtL8BEs8661dxbUSKsyYo1n
	3z/GF5GdLuZX1o2z0vKSAnq/EpPPdIlDTht1YLpDPw8Wr5vn1IKQ+vVfdH8YEulq++Y/qeG/+vw
	wZVlYP8HFb1bbuqb2+oKFuCz1vyLEJ9PAsrUBIMkv0n+YeoHOlmdgj01d8D3Fm553gL/YI2tcjY
	1NogOoJVFSRRxa0UWff34ynf5msjTF28U1ylEvFtyajbJdDGsdiRNNwq3KKLHBfcG8ynoCz+Mwr
	FYDnf3Rn7YQqJPfEZYrQh9jSNQvI9Psbf2fKbYpfoygMpeAQApOQfol205i+rnZozTZJaN28riL
	WUZ35czANoSeEqd6bfHWduk7MoxueJltRrfV0F13y/b98DI0JSUUjkrryZRqwrQ/GgX3YPQQARk
	D2qWsZo0jTb1UtPiF5cEk4y2IGvbdLtZusCPuwYKfQ0Ob+Oh2RvPh2OhckARY3DjSvT5XyWPUWK
	37InGQ==
X-Received: by 2002:a05:690c:c4ca:b0:80c:85e5:8750 with SMTP id 00721157ae682-80c85e58b1emr28220047b3.57.1782520897179;
        Fri, 26 Jun 2026 17:41:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8ddf97sm91222027b3.29.2026.06.26.17.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 17:41:36 -0700 (PDT)
Date: Fri, 26 Jun 2026 20:41:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 08/10] pack-objects: introduce
 '--stdin-packs=follow-reachable'
Message-ID: <aj8cOhH6hGVZIFft@nand.local>
References: <cover.1782500507.git.me@ttaylorr.com>
 <e3d2e46443d0b32ce29215563dde04ebcf850679.1782500507.git.me@ttaylorr.com>
 <xmqqpl1d56dd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpl1d56dd.fsf@gitster.g>

On Fri, Jun 26, 2026 at 02:39:10PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +/*
> > + * Flag bit set on commits that belong to an included pack during
> > + * '--stdin-packs=follow-reachable'. Used by the pre-walk to
> > + * identify which reachable commits should be tips for the main
> > + * object traversal.
> > + */
> > +#define IN_INCLUDED_PACK (1u<<11)
> > +
> > +static int mark_included_pack_tip(const struct object_id *oid,
> > +				  struct packed_git *p,
> > +				  uint32_t pos,
> > +				  void *data)
> > +{
> > +	struct rev_info *main_revs = data;
> > +	off_t ofs = nth_packed_object_offset(p, pos);
> > +	enum object_type type;
> > +	struct object_info oi = OBJECT_INFO_INIT;
> > +	struct object *obj;
> > +
> > +	oi.typep = &type;
> > +	if (packed_object_info(p, ofs, &oi) < 0)
> > +		return 0;
> > +	if (type != OBJ_COMMIT && type != OBJ_TAG)
> > +		return 0;
>
> We do not care about non commits, non tags.

This should not be an &&, but rather an ||. We only want to handle
objects which are either commits *or* tags via this function.

> > +	obj = parse_object(the_repository, oid);
> > +	if (!obj)
> > +		return 0;
> > +
> > +	obj->flags |= IN_INCLUDED_PACK;
> > +
> > +	if (type == OBJ_TAG && main_revs)
> > +		add_pending_object(main_revs, obj, "");
>
> Any tag object is added to the pending list of the second phase
> traversal here.  Doesn't this retain unreachable tags and
> (unreachable) objects that are only reachable from these unreachable
> tags found in the packfile?  Don't we want to limit this code to add
> only tags that actually are reachable from refs, or something?

Hmm. You're right, if we have an unreachable annotated tag object in one
of the STDIN_PACK_INCLUDE packs, then we'll pick it up and place it in
the non-cruft pack.

I'd have to think more about how to handle this properly to ensure that
*only* reachable objects are included. We probably want to re-order this
code so that we start a traversal from the reference tips, then mark
reachable objects as starting points based on whether or not they appear
in an included pack (and correspondingly do not appear in an excluded
one).

That adjusts how the traversal would work, I think, since we should be
able to pick up the resulting set of objects in a single pass. But I'd
have to think more about it...

Thanks,
Taylor
