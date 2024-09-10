Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E717624F
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948549; cv=none; b=DOE6eHVj9Tj+8WHbKNgU60E1M4m1DlxXa1BDt6JdbQxO1QQNFyJjxsO66elo2oP98nGJ58iPNNh8L0uU1/Z8tI4G+NXKLcXcGR09BlRoC2iEonTm9hSBRDR/V1da0zcD6J4d0qLGomORKHLm3ngw6/QvflASkJV7zQ9lcbjS8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948549; c=relaxed/simple;
	bh=bYUQwWxtSCbYU4dJOfLDQCnT7KOaWTqaG97OExVZLcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS/lfkqga/HtfOTHOcglOVA47mtZcE+Q++eszCa706wX43hCJ9WqS2rgEXKuxlwd2rajM/uwymMlLeOOPTz2N1Faj4TmcTjya13Hppqr6B3X+50rWQttYO6/X0YF4vwRdbIoapHFAWh7BUlV8y+MOuepb0c2H7YIwyfDm5P1XAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VCrH4vWr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrQsx2m0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VCrH4vWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrQsx2m0"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 26A6B1380328;
	Tue, 10 Sep 2024 02:09:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Sep 2024 02:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725948546; x=1726034946; bh=5xxH8O9oLd
	PzEuozNla0g8sR/XVOm9ApmyvBA9vn2+0=; b=VCrH4vWrvBeqLPgIWV831p412a
	vPVPAEukrsDIBSb2cP0N0l1iGFtaq4OogYQLaOal1UDx7VHnnMqVjMa4pNnaQSu/
	CkMnS6hXZplnpnXIHzgf2gTpF3IvT3JDU1Q4GqW79HHEj5BB+i93S+1U7duffR7U
	NuZVlfoGNy+LvQt9OjAC8ryeaTy2b+wY9GuneOyimFswl/URPuEOF3ykFXqYNGi+
	lseB9nfdIksd2LbWwvzergk5vv/FhGjtpGRKOf53T00DM5ugmahJm/+UDYBxYYV4
	Ium9ZoPMHTMUD0Cq1kACmyr7WkqSnRzXnj3c3uFYD3liX29C0o0W8CPyET6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725948546; x=1726034946; bh=5xxH8O9oLdPzEuozNla0g8sR/XVO
	m9ApmyvBA9vn2+0=; b=KrQsx2m0KxhVwuciU7CEvF4zelHIyqw1LiF3XhVwlYTn
	YzPJTBbWI7A7709sLaTUxDIZBj6bLNsq4SKdpAMHiUExIRU87iXd9dy2sY/YLxwn
	BBiDeoMLDG07DRlLgQu8qebwl7/p2RhFoDCZy7fzkEBt2v3VHiCvN0bB1JiKgqHG
	fkdLYI+Va1eOuwqoUn4ChV7oOpHsedJYQH3zmdRS6KL+YG4b/7j3VxsnrLatJCmI
	pDXDLZ4BQe31d2A2EgWhTHS0TTjUVQRsNdyGTGL+p8u0hlT0aFLjGL7drK/+xyp1
	hCgWtS0zJL6btX6FL5nGN7ujqxeUVhpERt+/2LPW6Q==
X-ME-Sender: <xms:guLfZm9FLNgSbuEqn3vVR3ZncjQgfjCjGWYVFfCNb8L-r7n4MOP6Hw>
    <xme:guLfZmtmhV3p0oODwywIptNTawt-4L7BSLCfUkpaRIhjtjtgokTbivqaAU8m-wg-P
    JpCyXYi00gahGbWxg>
X-ME-Received: <xmr:guLfZsAV1ddkzuosxi8D9jrT431_qYeJD2mY-D0utT3J-DdbpGdaQ01lfq0NnmPv5IwwAZMJThPbbyV2D3h3WxaGrD3imICAUMGqyLpdq33AdgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsghrohhokhgvsegr
    lhgthhgvmhhishhtshdrihho
X-ME-Proxy: <xmx:guLfZucuKCkHQe5L4KDirHp0J8g3KF9wJGXkWg9JYRE8JLBZ0oAO3A>
    <xmx:guLfZrNGd2s0hjbMd8VTxKaaLpSb-IiKZyaPJAg_nqZ7KN2o08WgnA>
    <xmx:guLfZomIONO8Z3dQuEoH_dts6pxS-NoK2QMuFkovhONrft6D_b1O-Q>
    <xmx:guLfZtvJptiKVqKDCAhAd6r4yawBF-lC5XJ6qhqvFWkzFJkxadFHnA>
    <xmx:guLfZkoWjA-T25doOxtLdhGTVPGKkEuQxfrXPDAihR2sgaElJuDIo7O8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:09:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 02613ac2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:09:01 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:09:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 6/9] ref-filter: fix leak of %(trailers) "argbuf"
Message-ID: <Zt_ifxQq-6wNaQ3J@pks.im>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909231828.GF921834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909231828.GF921834@coredump.intra.peff.net>

On Mon, Sep 09, 2024 at 07:18:28PM -0400, Jeff King wrote:
> When we parse a placeholder like "%(trailers:key=foo)", our atom parsing
> function is passed just the argument string "key=foo". We duplicate this
> into its own string, but never free it, causing a leak.
> 
> We do the duplication for two reasons:
> 
>   1. There's a mismatch with the pretty.c trailer-formatting code that
>      we rely on. It expects to see a closing paren, like "key=foo)". So
>      we duplicate the argument string with that extra character to pass
>      along.
> 
>      This is probably something we could fix in the long run, but it's
>      somewhat non-trivial if we want to avoid regressing error cases for
>      things like "git log --format='%(trailer:oops'". So let's accept
>      it as a necessity for now.
> 
>   2. The argument parser expects to store the list of "key" entries
>      ("foo" in this case) in a string-list. It also stores the length of
>      the string in the string-list "util" field. The original caller in
>      pretty.c uses this with a "nodup" string list to avoid making extra
>      copies, which creates a subtle dependency on the lifetime of the
>      original format string.
> 
>      We do the same here, which creates that same dependency. So we
>      can't simply free it as soon as the parsing is done.
> 
> There are two possible solutions here. The first is to hold on to the
> duplicated "argbuf" string in the used_atom struct, so that it lives as
> long as the string_list which references it.
> 
> But I think a less-subtle solution, and what this patch does, is to
> switch to a duplicating string_list. That makes it self-contained, and
> lets us free argbuf immediately. It may involve a few extra allocations,
> but this parsing is something that happens once per program, not once
> per output ref.

Sensible. I found that in many cases, the `nodup` variants of string
lists bring more pain than real benefit.

> This clears up one case that LSan finds in t6300, but there are more.

Yeah, there are a bunch of memory leaks around atom parsing in general
exposed by t6300. Thanks for plugging some of them!

Patrick
