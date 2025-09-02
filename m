Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD83E573
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803061; cv=none; b=glZfDZEib0IXfUtrF2P5oH+p2sBWP7mhnGXMmNKEFHokHRUnV+GXn4M6wBqheRBUDds1vfQlrLjGx6dS8XX/2hIBfwQj1/MKR230CsXE+iXts7M0oLYyh6OxBWqvhe1OqsogFCe187cG1TCX/2X/RuYtteE5ZzDPGWjmhMF/mHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803061; c=relaxed/simple;
	bh=n7ksQQ2HwtdS7DXiYy4xlZWQbjlG5weXslp7Lce7ZOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLl1ezwA83ltdPcQE8KnPb1l7Phsvunr/D5nh7kZc/eaxQQaDSdWImrtL9t/b41flDbt3++rOi4t9YEqrPle01PM522gZW/1E1SMp1fOM+tI0v+/2bte+JR8WC14L0ON4k12v28y0PpXlMndDiaic6WuvLKhAb/2fBFTcduX9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FZpz5dnT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgZNvoUE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FZpz5dnT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgZNvoUE"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D31FEEC0540;
	Tue,  2 Sep 2025 04:50:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 02 Sep 2025 04:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756803058; x=1756889458; bh=qT+esleklN
	jxi186mSpB8bj/tMtdetY/3Vp87QGw+dU=; b=FZpz5dnTPlkaEl+OSvsKEwtQPW
	FfKUyp0fC/DF43fxu/eLTg17A/aTT0GGDxuTz7A7Rk443qQdRGCMfn6/ALOM+5Fp
	GiLhqVeGXDRbwz+O1nHVczgjakaFBT3um8DeOnAgV7vCpbZKKvV8rSaGsiGrCS8T
	2Rm4hN9YJXv5VQUFv4iVQTBTFGr6qzR731dlZ0OLByfUdnzyhjeudTPRArIkkcAq
	YSJkUnfb2UrIol/C2XnOjjfiA4P4JohBV7MP6kWSfYRMqNwMTYJHltECBdX8Wxux
	BhawaCj4JUMaj9/c2weR7JHhNxr00Gbp9fMnE8OJo3wu76eSNSoFEBldFPUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756803058; x=1756889458; bh=qT+esleklNjxi186mSpB8bj/tMtdetY/3Vp
	87QGw+dU=; b=LgZNvoUEbjNFBNurFBuq+yfWLByzfUO4frl8HOOWT7LhSk/7ZYW
	U5G1esC83T5xZ9TlII7yQ5Ni24bbIEJ9V9z/RN1hybCQifzwBcVBFotmXE/ivZJh
	P4KdJGZ0/X00H2l7W8Qm92Tnv+IFt6Hge6GZsO9LjrvebijuBpN9AnBupL1/NCRf
	cwwEJPmAH8932bHDtG8BLgt0KVNlUalK4lT75S1IBLZ+/2xk3Jac+IFBKPStF4kg
	H0bhKTxyetQ0I87k+TwUtBH4PXg7bB83nQT5DBNT/+c+CwDZ41YioLVn2HEOMewb
	ChRJD9WjkQvDfty1NiMXq92zpuN6c4dBy1g==
X-ME-Sender: <xms:8q-2aKkDQN9GdRR5kNtNHBMqfMP3Ur8j-3FRDI8W_axG_SMU5tOLJw>
    <xme:8q-2aMZyQe0gW8LMk9T7pReHF1CsNVtjo2jHM5mS2b4lrNVb8d02Tifs6TTHQqVCi
    W4Dya6gFjVQ0giUWg>
X-ME-Received: <xmr:8q-2aFPQoy17bl8lQBZHOR-lzYP1QhbE9pXnQ2pMrykISFgwkPi32V8r4EYsjiTmwVT4hItb8TP4q7gXECPPjtLmh0e2c4bl1z3cAOAxSrT-Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:8q-2aBZ7r097aKAZ8ksmTz9RTK8-aKwezpbtOFhYjENtDVNDgwU_CQ>
    <xmx:8q-2aD16K3HeShRql3Te7RDAPo7wSD2GsARIgn0rYBZtNeKryYvYbA>
    <xmx:8q-2aHftfF2EnFkq6K3gmELkXKZMNFXaiQUqo78vWkRspdv_9_TLSw>
    <xmx:8q-2aEHsakIzIQ13AxzZPhw2oMZMOMi6poWh0ZDKFOX2MOBZvkzCoA>
    <xmx:8q-2aDcYes22GgsQMkOsGXEa-0sW1rQ_sDykf-vnvnp8hvoxq-gRZLwW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 04:50:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3e32e35 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 08:50:57 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:50:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 14/16] packfile: remove `get_packed_git()`
Message-ID: <aLav7vdfxPGTVDQd@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-14-d10623355e9f@pks.im>
 <aK5hpwcCgjkgQB1N@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK5hpwcCgjkgQB1N@nand.local>

On Tue, Aug 26, 2025 at 09:38:47PM -0400, Taylor Blau wrote:
> On Thu, Aug 21, 2025 at 09:39:12AM +0200, Patrick Steinhardt wrote:
> > We have two different functions to retrieve packfiles for a packfile
> > store:
> >
> >   - `get_packed_git()` returns the list of packfiles after having called
> >     `prepare_packed_git()`.
> >
> >   - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
> >     calls `prepare_midx_pack()` for each pack.
> 
> Yeah, having two of these functions that are named so similarly as to
> suggest they do the same thing (even though they don't) is unfortunate,
> and I am glad that we are looking at it here.
> 
> > This means that the latter function also properly loads the info of
> > whether or not a packfile is part of a multi-pack index. Preparing this
> > extra information also shouldn't be significantly more expensive:
> 
> Right; get_packed_git() only loads the non-MIDX'd packs, and
> get_all_packs() loads everything (regardless whether or not a pack is
> part of the MIDX or not).

I initially understood the distinction of these functions to be exactly
this. But after looking further I don't think this is the actual
distinction: both functions end up loading all packfiles in the repo,
with the only distinction being that `get_all_packs()` also prepares the
MIDX for each MIDX'd packfile.

The important thing to note is that an MIDX may only ever refer to
packfiles in the same object directory. And as we have already loaded
all packfiles in that object directory via `prepare_packed_git_one()`
there isn't really any difference in the returned list of packfiles
whatsoever. Both functions end up loading all packfiles, regardless of
whether or not they have an MIDX.

Please double check my understanding though, I have been staring at this
code for quite a while to figure out what the actual differences are,
and whether or not `get_all_packs()` may actually end up loading more
packs than `get_packed_git()`.

> Are all of the get_packed_git() callers prepared to handle packs that
> are in the MIDX? Looking through them:
> 
>  - builtin/gc.c::incremental_repack_auto_condition() skips over
>   'p->multi_pack_index', so this one is fine to convert.
> 
>  - builtin/grep.c::cmd_grep() calls get_packed_git() but doesn't
>    actually use the result, so this should be fine to convert, though I
>    think there is some subtlty here.
> 
>  - builtin/pack-objects.c::want_object_in_pack_mtime() takes a separate
>    pass over the MIDX'd packs before calling get_packed_git_mru() (which
>    itself calls prepare_packed_git()). I think in practice this is OK,
>    since we will have already handled the MIDX'd packs, but this
>    function is now iterating over packs in the MIDX twice, so it may be
>    worth adding a "if (p->multi_pack_index) continue;" in there.
> 
>  - object-name.c::find_short_packed_object() handles MIDX'd packs
>    separately, and unique_in_pack() is a noop for MIDX'd packs, so this
>    one is fine.
> 
>  - object-name.c::find_abbrev_len_packed() is OK for the same reasons.
> 
> So I think that want_object_in_pack_mtime() may need a small tweak, and
> I am not 100% certain that cmd_grep() is OK to convert.

I initially misunderstood the distinction between these two functions
the same as you did, and had a similar list to the above in the initial
commit message. But with the adjusted understanding of the actual
difference between these functions I think it shouldn't be necessary
anymore to go through each caller one by one.

I'll adapt the commit message a bit.

Patrick
