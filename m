Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823092405F9
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568002; cv=none; b=RuFP7POGXYlGozJIwpB6QG9aY3UxO4kGxYif6fON66EzXuJDndqUMXud4obzzgG5nZcEe06rxDipfHI0GsPZ/1TcphWTNJgj/x2/wSinDFcf+U+7IX9gniTP6/dfouvELV+oZTi09ddRHS3LhmpCmem+iI4ffLa0+U5sP9YQLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568002; c=relaxed/simple;
	bh=vCFfNhApV+j/dRy4c7wjnHTSKOI2WqEQWnTfgM40x7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxcJz6eScPM2HuJLrDxCdXruW+McVACrWscyuBvWvbRVvixcu2BuTQcYaydD+ALUYQgL+OK6QkWvIN2Fs/DC3PjGrbS++TSLNudAawzh+Ov9ApPmRkoVpSwYYdzMrYP3OMT1Qa5thfbUG+FamesEBC4h4vN0ljDw057wDXHQ4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ypOzyn/b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnwVIVY9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ypOzyn/b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnwVIVY9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 291B8EC02A5;
	Tue, 15 Jul 2025 04:26:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Jul 2025 04:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752567997; x=1752654397; bh=Og8+4921Uq
	OAdS5VuPmsxCi7TsovmUG20nl12aOYbR8=; b=ypOzyn/b1PiVB5O+XuCZJwQXha
	uZTVE14G8zy6rCrZ5yvTBnzrErXzzuVsTc7nDit3AhEReKjVtGhpAzzs7V9wAIaI
	jO5JzOExAyrdrXPj8CeJjX1lHgjOYuyVAywYdA3sn+zHumErrxYJZDrO+DxoaB8s
	M5wJfXHlDE4stEnysHZNkIzrRU43rsewpt4IW9Eo7SzgeyEss9Kb/agp4ug4xbb+
	7QCWrtaEmer7ggLl6V6B0JKKRPnpis5bfbTLvKdB6SStrA1ANoVOTdJE8rT0H/pT
	7m9Zvlv5z6r7ywCq/t8V1ehjh6mdAHAeyUaXQqgqwWFvUYKkqcpuIfHWW+/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752567997; x=1752654397; bh=Og8+4921UqOAdS5VuPmsxCi7TsovmUG20nl
	12aOYbR8=; b=OnwVIVY96wHQXHOnhhVEB/1sDowuBLFtcXY+kB0LtLu+iFmmY73
	wInPvxtfHpGRNPIWTByq2PRmyGziJQmD+Rd4iW5xjA9JJytx4JRnJxOluWtimBM8
	NmdTud+dypRROBBZ8DjRuzlx6QPk7ulpaxGZRoGkiflVfc/RrYj7W/Owrp8KPtRe
	cEMcYeg0wBTuDzoojcFfp6usW/uaNL1G4pjgttfe7ez7CHjq06BtX5n/Ju17k0zS
	lCG8Bcn3/wwIuIwFA2w9jBbP3EewBLoqRig4AUxy8bv7bXuZ6DL515ZnEcKhOpdy
	EOPIuVQ4h72w7o2DqgKwqSL9uyCB1McddgA==
X-ME-Sender: <xms:vBB2aAkYYUo9Cri6wqpi6weFQ6TAeK-0ncZNLZWwQ5CkLS52IWXTfQ>
    <xme:vBB2aABIhBFdWnNNfEMpiGLQq8MMd8q72g8Z_5_-Fi8clbc47JkskNRXcLhIL2Cpy
    QAg7j3sq_SgXDGGdg>
X-ME-Received: <xmr:vBB2aAfx3NV2yAA603TSiJXpSywT4CK8s013QyJU4hFbYDXwVeoquJDKNFmmxyhl_nBmKxqBLVC0hKR53ZLtfgCUoVLO_EG_p4ofnS-OS7f9ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vBB2aLJn2b1ntQ6y6xOjpb1afVlqI6af7vjFsVL-a7fao1ON48BA0g>
    <xmx:vBB2aDf-arp4sAh3eOnsxQ7OJRu2lMSuEMxiNkL9d9Z-qskrRCHUTQ>
    <xmx:vBB2aC1aPGg7HM3ZP6x0jGW-0MIc4HdprBvKbrmJSzmO1So_pH6PNQ>
    <xmx:vBB2aMjKBHRX8BzZKVMo-blpius5tPOWm3hX1damVUpk0otpZ5x2rA>
    <xmx:vRB2aKBSBhaCjfic2_-AxjBXmTFiOnA74prMC814k8kGZLb1VN_BB764>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:26:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58b7ddf3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:26:34 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:26:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] midx: start tracking per object database source
Message-ID: <aHYQr1O9beg64aOW@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-1-f31150d21331@pks.im>
 <aHBISjW/OErOy3Cp@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBISjW/OErOy3Cp@nand.local>

On Thu, Jul 10, 2025 at 07:10:02PM -0400, Taylor Blau wrote:
> On Wed, Jul 09, 2025 at 09:54:49AM +0200, Patrick Steinhardt wrote:
> > Multi-pack indices are tracked via `struct multi_pack_index`. This data
> > structure is stored as a linked list inside `struct object_database`,
> > which is the global database that spans across all of the object
> > sources.
> >
> > This layout causes two problems:
> >
> >   - Multi-pack indices aren't global to an object database, but instead
> >     there can be one multi-pack index per source. This creates a
> >     mismatch between the on-disk layout and how things are organized in
> >     the object database subsystems and makes some parts, like figuring
> >     out whether a source has an MIDX, quite awkward.
> 
> This is a little confusing to me. What do we consider to be an "object
> database", and what do we consider to be a "source"?
> 
> For instance, if I have a repository with one or more alternates, I
> would imagine that each alternate is a separate "source", and the
> sources together comprise the object database. Does that match the way
> you're thinking about it?
> 
> If so, that makes sense. But if not (i.e., we consider all alternates to
> belong to the same object database and share a single source), then I
> don't know how this will interact with the existing MIDX alternates
> mechanism.
> 
> Some clarification here would be helpful, I think.

I'll add some, sure. This whole infra is currently developing, so it
doesn't hurt to reiterate some of the points that have already landed.

> > diff --git a/midx.c b/midx.c
> > index 3c5bc821730..a91231bfcdf 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -724,28 +724,29 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
> >  	return 0;
> >  }
> >
> > -int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local)
> > +int prepare_multi_pack_index_one(struct odb_source *source, int local)
> 
> OK, so the combination of a repository and "object_dir" path becomes a
> new "struct odb_source", which makes sense. But shouldn't "local" also
> be a property of the odb_source?
> 
> I am not familiar enough with the odb_source work thus far to know
> whether that is a good idea or not, but just something that stood out
> to me while reading.

Yes, you're right on point. I have a follow-up patch series that'll
eventually get rid of some duplicate information that is now present in
the ODB source connected to an MIDX.

[snip]
> > +		source->multi_pack_index = m;
> 
> As an aside, I see that we're calling this new field "multi_pack_index".
> I wonder if it would be better to call it "midx", since typing out
> "multi_pack_index" is a little verbose, and "midx" is a common
> abbreviation that I don't think we would cause any confusion with.

Sure, I can do that.

> > diff --git a/midx.h b/midx.h
> > index 9d1374cbd58..b1626a9a7c4 100644
> > --- a/midx.h
> > +++ b/midx.h
> > @@ -3,11 +3,12 @@
> >
> >  #include "string-list.h"
> >
> > +struct bitmapped_pack;
> > +struct git_hash_algo;
> >  struct object_id;
> > +struct odb_source;
> >  struct pack_entry;
> >  struct repository;
> > -struct bitmapped_pack;
> > -struct git_hash_algo;
> 
> (I'm nit-picking, but a similar note here that the unrelated changes
> make it harder to see what is actually going on in this hunk, which is
> adding a declaration for "struct odb_source".)
> 
> > diff --git a/odb.h b/odb.h
> > index e922f256802..8e79c7be520 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -9,10 +
