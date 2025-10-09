Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B724501C
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759991780; cv=none; b=L4HRwlQYIpN3KQfNaJ3V6zgG2gUuouiJt/qgRqH5S7Ip+n0WIq7rIJU2RnvLNzT3kpy2SaSGQsGzgqa/Je+GlffrofvRic9pmscnP3/APO8l7bXpNRATYzDQx5G4mzg5oVu1QueHQKzHadby0dNn7rZ6NzP4cKIe68mbD5XoCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759991780; c=relaxed/simple;
	bh=BxkcYFnfo598hs5O2qtvs2LhdkwMSNMzb1QKplHcTv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwKOwRIhZzV98ve9MrerZ6zQMtNEm27njoepZ5VJOUVGUXXEBIgB0v3p8nUinlRhlTfgUukKDHmpd9jWcVF39Fq0rsaJYyss735nOoaGKoVTb6Mj0LWMM/b8YAvzhiu0wNe0h/KVGFVstaYhkWEMqte1vA/1asVvkWh+T7I1+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bKm9b2gr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PtpOCBty; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bKm9b2gr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PtpOCBty"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D4FA1D00041;
	Thu,  9 Oct 2025 02:36:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 09 Oct 2025 02:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759991777; x=1760078177; bh=PoracYGJth
	EE+FT9I9pSZiXQctWjFsDqrZHYZ/2pVis=; b=bKm9b2grEPahjpVyiNDAInX+pw
	P7vLMvqODNNweevE65qo9LUs4cgvaNx+pHHVIKGdLH9IWMq+o5dUNn5HeGUwRfkJ
	5g2PxKRcYHjQiw7NF/0JW3fUEpEjIZC8YlALzXp+fDKw9J0wc/y8VDPkA93K+RmP
	fgLXFbgnExzT7WOAQ02rUgHEzFDAsr/bno0FJpcozSVfxKijkgSJ3BvslUQWiRVg
	3+nAfWZpK9cAvU0ex918YlHPoigc5L40dT1HjLHHg6EwZRmfr3i8guCK7VnlBQ0q
	kIyQfw5pi7rTWPbV5JRHGpAa254mdt8PI5QdfJtwsOYCiGC+J0yu8GxwsIUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759991777; x=1760078177; bh=PoracYGJthEE+FT9I9pSZiXQctWjFsDqrZH
	YZ/2pVis=; b=PtpOCBtyaOeaTvSTo8mmU80Eki3D1uSYPJHXCj0vf15v8j75B2M
	LNwHLBdq+YAECHVqCWwN6+SyYklEPaXKkHyO8LZKEFrzmnE4mKGcCH3G+aRDAdYM
	Mqtm4LbzWS7MDcgklddmg7n76saJkMOQaXn4adzdJj8M2PeYphGhWfkxLNdev1nb
	pAdIvyt4SP51vIuk1vKTUn+fJhTxMBZeAQW4sEXhFyYsBE4TGOKhJMWL+5KA2myZ
	EsX2jFocCbxaHCRcxzdD9FVHhe5FggfnQYFJMG3sYlMeG+WOK7cR46Ywa3D2buJA
	fapBHtQ6oZUUmrk+XoZcVuCZp/jNNTCHe5w==
X-ME-Sender: <xms:4VfnaJaBsptyZ9zgYXuqO78_jLnltp5034uJ72UaS_v5mfvGQ6G4sg>
    <xme:4VfnaGaQSQ5wxF-Rnee_dQllsb7C5re1l2gOxLAjfm7X2a1pKpSlhGJ84MKN08Ah0
    KrvZ6RveWhbMHS0j2VhS1sEHXWdBL9QRQ8x8RvBUOlD-7I8e4WBCQ>
X-ME-Received: <xmr:4VfnaJkVX_NVETDGvYP2LGYiNwKZhHWXLqe7410AZlKS-XSryHBe9vYtMSCfJBfkEEEPMgXCE82Uq4CKAy_aPtyXIMx9NLWdUCEybiiM8gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4VfnaCzxyctHN2pkLnxwb5-9-MW2Un31KCzVQfT_bEhUNJQgokV0lQ>
    <xmx:4VfnaHO1_5nXcL6FNr_1htAN19UcS5kpdqofZBGuOdlT69wVoYJHTw>
    <xmx:4VfnaGR_gex1BO6Afxpmw3bCG5wFBNdEkmpXzfNbuFsxVIzg6Hs88g>
    <xmx:4VfnaFbIWw_VJtQetQn-hhDhwT9IYltxel3AU40J0f0oi1v4xGlPTA>
    <xmx:4VfnaGhRvUi3Ptf--efrTEcyqnVEnjnDSrq-60qXPKz2QpFZmBdJ8xL5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 02:36:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0118958 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 06:36:16 +0000 (UTC)
Date: Thu, 9 Oct 2025 08:36:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] packfile: introduce macro to iterate through packs
Message-ID: <aOdX3ZmITr0FVq4b@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251007-pks-packfiles-convert-get-all-v1-5-428227657a89@pks.im>
 <aObUivWiMdtprQSu@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aObUivWiMdtprQSu@nand.local>

On Wed, Oct 08, 2025 at 05:15:54PM -0400, Taylor Blau wrote:
> On Tue, Oct 07, 2025 at 02:41:11PM +0200, Patrick Steinhardt wrote:
> > We have a bunch of different sites that want to iterate through all
> > packs of a given `struct packfile_store`. This pattern is somewhat
> > verbose and repetitive, which makes it somewhat cumbersome.
> >
> > Introduce a new macro `packfile_store_for_each_pack()` that removes some
> > of the boilerplate.
> 
> Makes sense.
> 
> Since we're talking about adding a convenience macro, I wonder if it
> might make sense to name/treat this one slightly differently. I would
> imagine something like:
> 
>     repo_for_each_pack(the_repository, p) { ... }
> 
> I understand that packfile_store_for_each_pack() is trying to operate on
> a single packfile_source. In practice, would someone ever want to
> iterate over the packfiles in some source but not another one? It's hard
> to know the answer to that question right now without any other
> implementations.

I don't think so, so I'm fine with this direction. In fact, it might
even make my life easier. See further down.

> Perhaps in the meantime you could imagine doing something similar to
> your macro, but instead of reading from the store directly, it could
> read from the repository's store _and_ BUG() if there is more than one
> store to choose from.

I don't think we should BUG() when there's multiple different packfile
stores, as it is mostly likely the intent of the caller anyway to
iterate through all of them.

But that being said, there is a different reason why we may want to
BUG() eventually: if we get pluggable ODBs, then one of the object
sources may not be a source that uses packs in the first place. And in
_that_ case we definitely should alert the developer that something is
wrong and BUG().

So I'll adapt this series to use your proposed `repo_for_each_pack()`
solution.

> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > index 8ee95e0d67..5462c442dc 100644
> > --- a/builtin/fsck.c
> > +++ b/builtin/fsck.c
> > @@ -869,18 +869,19 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
> >  {
> >  	struct packfile_store *packs = r->objects->packfiles;
> >  	struct progress *progress = NULL;
> > +	struct packed_git *p;
> 
> I wondered if this needed to be in scope for the whole function, and
> looking just at the first portion of this hunk it seems like it does
> not. But continuing to read further down shows other spots where it is
> beneficial to have "p" defined at the scope of the whole function.
> 
> >  	uint32_t pack_count = 0;
> >  	int res = 0;
> >
> >  	if (show_progress) {
> > -		for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next)
> > +		packfile_store_for_each_pack(packs, p)
> >  			pack_count++;
> 
> This conversion looks obviously correct. Though I wonder, as an aside,
> do you think it makes sense to have a packfile_store_num_packs()
> function or similar that does this for us?

We probably could, but I don't think we have enough callsites to warrant
it now.

Thanks!

Patrick
