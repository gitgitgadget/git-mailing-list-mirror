Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240B374739
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161415; cv=none; b=fqAGIVg0lFLEMx9kNWsL2l6U0kLhFzKcYXrtjqntKHp99L/FPfugK+2hxBmXtrlqcl1mEJwE/IthsMoj4TLM6r0g/KInMLvQIKq8VA+Anx5skgBGJLIBZE9731FPlJVqQfQFAUupBiIs9R4QX1MH8ghpImdt3VdmVzx9JV9xy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161415; c=relaxed/simple;
	bh=Dovu0/FPyADB0gZiiP0dr1KkYThURO2crfenXjUCpk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLbfxpwgtGf511J3vPqdL7HMmeTiRaj25j7QRBWSvMk1v5zfiQfIx9lAty2dQ5u9+RH7VEjKdyyKh6NDurRiWJefya5UrlFeRz5A2eSB8Xggo86aKnvUC4bZeMUvZJNZEWSEux8QSdEJKjgGULKELRkaFoejPuIAimWHlRJuXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iz+Mn6Zj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mlQdkflg; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iz+Mn6Zj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlQdkflg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 874627A00EB;
	Fri, 23 Jan 2026 04:43:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Jan 2026 04:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769161401; x=1769247801; bh=7IJmPQEDYl
	2qpgMYjT0tFKFCbFfBvIjV6oBbnei1WAU=; b=iz+Mn6ZjUVUEtWmiXk6Ei5N66v
	ViptGQW82QMiVr95qtJfBVNo7RwzJ6nucQik7JCURFIB9kdzNyyQzDhe5GAMORwA
	HEXOY+jayeHuYT/Ot7pXk7zob+5gvGBNTkXCn2EZTg0DKXOD6WZZvhxJa6l4ErnA
	QFPBRSAY6HlyXaTwkB5kcl75hY9H+/V17g+xrYP7g0uTfGQWeXyB5/0T0ohh0CN6
	VPs/U9n5B55LW2cZRWNyFyZYPldxbPqni/oVimdLH0UugZW6fjEwypMBvj+1Tf+j
	HSfAiNINDQzcmDE2mVsf1QkF8rMIqO540T+NGv5UXVHZexsXdsHEuX7sjwDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769161401; x=1769247801; bh=7IJmPQEDYl2qpgMYjT0tFKFCbFfBvIjV6oB
	bnei1WAU=; b=mlQdkflgdqpuIQPa6cs8HfWH8vCkasce2IL/e1hlVm6OhPxqcxN
	MwQyYGMR+wm0detmUGJ63hCmi3zwKTf/F3L4bLjk/JlFtRyN6Id5eqk6PKtrfD1H
	Co7i9CewwQ4vZnpJ7VDTqiBdizXZ+IKZokH2uZa8NFAMICndeB97YCAAv0n1/S5/
	tLjQzZpJmWKK73lrVuRi0NSJi9X/pn9eYQ+T46icb0c+5eYY1Bk9jqAe0AYXC72O
	rP6FLo55r1gXhzilYtKzy7ElYPt3R0T9zaOz3gXwuD3vUA+YUeHxFZzNSopyrv79
	xYUafaSGfyioZjDM7/XYFKR6Chm7N9H3sCg==
X-ME-Sender: <xms:uUJzaYS5lOHCEeubq-N-juRsn7ZW_SC-8oB4UFZNQIaPcgQL_zBygA>
    <xme:uUJzacp73EOz3Hl0P8RIyLkrJNnjs9BHwGVDTY-E-SSfaiBuri3JVGxgav5Ggjg3Y
    CxnP_WIRd6NPgPf6m0gPZunASdddylRVRwNxkFjCn8dOUkWiCM73IU>
X-ME-Received: <xmr:uUJzaeLDYumHUTw2D95cx1_ifk1TKqsgeYtH1YurH-j3azmyQimiWR1jgmwbecT4HBdh8IzKfq3TqLf5-lfWMdwoUBFsANMRoK0GpUGOZym_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uUJzaXqdAzFJzA7kUKkmSGvK6tXN1MHV-OtoWrGyP7LOR37ZADHdmA>
    <xmx:uUJzaexlk0u6fkIj-SzWMSJAP4CKTYfOfRA_htmmMsIdItbva9iMPA>
    <xmx:uUJzaTPH4Dxo6ChHdRrzcRYC84LrhGcZQ_siz4g2cDgLhYatII2z_Q>
    <xmx:uUJzab7q6RGzR9pZmq7SVvkHcpT4fV2NB4QgqTX4u2Lvn5LKHcU57Q>
    <xmx:uUJzaavAQaHgGB1psGvwpCdY88uf-MHF83_oMUDBzvMGi7rOhgTq1C3L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 04:43:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8061312 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Jan 2026 09:43:19 +0000 (UTC)
Date: Fri, 23 Jan 2026 10:43:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Message-ID: <aXNCtCZwP57Tfu60@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-12-12c4dfd24227@pks.im>
 <aXLNM+AOpdQtmisC@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXLNM+AOpdQtmisC@nand.local>

On Thu, Jan 22, 2026 at 08:21:55PM -0500, Taylor Blau wrote:
> On Wed, Jan 21, 2026 at 01:50:28PM +0100, Patrick Steinhardt wrote:
> >  static int add_object_in_unpacked_pack(const struct object_id *oid,
> > -				       struct packed_git *pack,
> > -				       uint32_t pos,
> > +				       struct object_info *oi,
> >  				       void *data UNUSED)
> >  {
> >  	if (cruft) {
> > -		off_t offset;
> > -		time_t mtime;
> > -
> > -		if (pack->is_cruft) {
> > -			if (load_pack_mtimes(pack) < 0)
> > -				die(_("could not load cruft pack .mtimes"));
> > -			mtime = nth_packed_mtime(pack, pos);
> > -		} else {
> > -			mtime = pack->mtime;
> > -		}
> > -		offset = nth_packed_object_offset(pack, pos);
> > -
> > -		add_cruft_object_entry(oid, OBJ_NONE, pack, offset,
> > -				       NULL, mtime);
> 
> OK, here's where we see the existing logic for determining the mtime of
> an object in the GC sense. I see there's a subsequent patch that also
> makes use of the object_info->mtimep field, and my guess is (not having
> completely read that patch yet) that having the same notion of mtime
> between the two callsites is desirable.
> 
> I still wonder whether imposing that notion of mtime at the object_info
> layer is the right choice. I wonder if it would make more sense to allow
> the caller to have a "statp" pointer filled out (or alternatively stick
> a "struct stat" in both the packed union type as well as the loose one,
> though the latter doesn't yet exist).

The problem with filling out a `struct stat` though is that it will only
apply to backends that actually have a path to stat. There may be other
backends that don't. You could of course pretend that there was a file
and fill in the `st_mtime` field. But I don't really see the benefit
over having a standalone mtime field.

> Then the caller could do something like:
> 
> static time_t object_info_gc_mtime(const struct object_info *oi)
> {
>     if (!oi->statp)
>         BUG("oops!");
> 
>     switch (oi->whence) {
>     case OI_CACHED:
>         return 0;
>     case OI_LOOSE:
>         return oi->statp->st_mtime;
>     case OI_PACKED:
>         struct packed_git *p = oi->u.packed.pack;
>         if (p->is_cruft) {
>             uint32_t pack_pos;
> 
>             if (load_pack_mtimes(p) < 0)
>                 die(_("could not load cruft pack .mtimes for '%s'"),
>                     pack_basename(p));
>             if (offset_to_pack_pos(p, oi->u.packed.offset, &pack_pos) < 0)
>                 die(_("could not find offset for object '%s' in cruft pack '%s'"),
>                     oid_to_hex(&oi->oid),
>                     pack_basename(p));
> 
>             return nth_packed_mtime(p, pack_pos_to_index(p, pack_pos));
>         } else {
>             return p->mtime; /* or oi->statp->st_mtime */
>         }
>     default:
>         BUG("unknown oi->whence: %d", oi->whence);
>     }
> }
> 
> I like the above because it encapsulates the GC-specific interpretation
> of an object's mtime outside of the object_info layer, while adding
> information (namely statp) that is generic enough to be potentially
> useful to other callers who may not be interested in the GC-specific
> interpretation.

This isn't achieving the goal of making the logic pluggable though, as
you now have backend-specific logic outside of the backends. Also, isn't
the end result basically the same as what I have proposed, except that
my version _is_ fully pluggable because the logic is entirely contained
in the backend?

> > @@ -4341,14 +4328,24 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
> >
> >  static void add_objects_in_unpacked_packs(void)
> >  {
> > -	if (for_each_packed_object(to_pack.repo,
> > -				   add_object_in_unpacked_pack,
> > -				   NULL,
> > -				   ODB_FOR_EACH_OBJECT_PACK_ORDER |
> > -				   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
> > -				   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
> > -				   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
> > -		die(_("cannot open pack index"));
> > +	struct odb_source *source;
> > +	time_t mtime;
> > +	struct object_info oi = {
> > +		.mtimep = &mtime,
> > +	};
> > +
> > +	odb_prepare_alternates(to_pack.repo->objects);
> > +	for (source = to_pack.repo->objects->sources; source; source = source->next) {
> > +		if (!source->local)
> > +			continue;
> 
> OK, we dropped the ODB_FOR_EACH_OBJECT_LOCAL_ONLY flag when dispatching
> to the packfile_store iterator, but that's OK, since it's handled above
> here.
> 
> Interestingly, packfile_store_for_each_object_internal() has a similar
> check:
> 
>     if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
>         continue;
> 
> , but I'm wondering whether these are subtly different. Would a
> non-local source ever have packs for which the p->pack_local bit is set?
> Or is the locality of a pack determined relative to the source
> containing it, in which case we'd need to make the check here?

To the best of my knowledge we may only ever end up adding a non-local
pack to the source, but not the other way round. This can for example
happen in git-index-pack(1).

But you know, there isn't any good reason to not continue passing this
flag. Better be safe than sorry.

Thanks!

Patrick
