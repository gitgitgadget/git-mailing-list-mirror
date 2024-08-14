Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBFC1AE027
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640216; cv=none; b=gMZ7myjijJC5k/YQmh50mU1Tuvfy+Ib6RqMB26dA7ImdiSlDwlSEYuzYYygQbqGYCQoFT/rVhGq5JrgVRg9YJzIMR0PG8AUymF3BuKkScyFlAh+QO1AbijQRVMb9D8dalkNoyKj/YlHQ8845BouC9794dm+22KwDBYmzfea6w7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640216; c=relaxed/simple;
	bh=Cc+s/Ju/TdyEqxWynMFRFiZfkkvUAtxVUgKUpH2hRzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFqHd/LnBYzw9MElX+W8v5MnB+eSV/pedAHn6uoE0FxQo+tPhzTcf+XwMda5pDxU8jmPv2hqZDd1HiLxJKrzwinpsQpKpUzmSrHVip1xlnL4NJolbddDeHbGzIGjtSlIOQiAim4rPR02Gs05IuaiaHddhuEvSNLA0Zj+bJB2k80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kiNlLsOl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GBB68+Ki; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kiNlLsOl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBB68+Ki"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8219B1381D7A;
	Wed, 14 Aug 2024 08:56:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 08:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723640213; x=1723726613; bh=4JJdjxh6Mg
	ghRsP8B3WA8N6O3NqAb5i9p1XI5nqOW0I=; b=kiNlLsOlWT6p4yroEAuytW93Cu
	16v2o32SkpmRFPX3r0Npw/OAyYYNO/MfUI4+yfx6iWFIq9XRi3IvpUxm1XbpHMeU
	Xl65j+w1lN9YlAo6a10Z2g6ZO9str115jlb3kFI4YKrqE472LjDcOhIRV4CBQQGM
	3vhCN4okvpTVfQA9CArbXQAGsp8p7Oau36rrl7D18EJZmzWX0yCh2PgXKgjioIOC
	akrV5zizv7fr11GJWudHG0nVkoBoCNEprjAzwOnbYNsHIWkG9VJdxlDlwIYpXBKx
	Ty376paVYt0xxIhXyaBMvaoxvUfr0Czpp8ifKEbShDgW9ccA1WDRyCKVof2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723640213; x=1723726613; bh=4JJdjxh6MgghRsP8B3WA8N6O3NqA
	b5i9p1XI5nqOW0I=; b=GBB68+KiS8Bq2JflOMD0+sfvFYnkhMFYYi6TP2jWbz6J
	+GGjL2zzRIYTe8XGuxfGlSfx0gGlf9d4+qjgOtdb6qwpTTO5BaWOdOt0bGUtRYJe
	GTvganB5BaGka/Z60s1mnx7DYJfgOms9uc85UyJqNAx6/hHClDTmf9WYRhYrn+sb
	iFPs1u/pfCfScNrahIhgrvSLhlCgmRFQfFaI3Rfc0OURn6+oDaVrgiWc9J4cSdQ5
	ju0lzcuIW5wZ9d4SE+kw868DAZL0ZM/t9vkBAHi45GBlkU2BGjJqsHFZPysJUZfi
	y0Q+MBP1srfea7XsMXzDvAmP/C/REj01XIzaCoWeFw==
X-ME-Sender: <xms:lam8ZhxLiq9gRI08qtBtkOo9m0U00Oz2Gco8d0iJ4d4F-6uhUeZh8w>
    <xme:lam8ZhQ_I8ulq15CN0gA2LiH0BVzoX3K-3vyPOhmxk_MxrTkVRxnMr4IoocXa_b39
    Lg1jvoxeaO7SmVBRA>
X-ME-Received: <xmr:lam8ZrUrfp49gPrPmORRb3CGU2o7FTghCZFdVtnNUdo-2UEFtbJeiWaNXurErezeGXXHxj-sdS16Gl4D5T5fjPLk6PgMTGvsMqVinqnDtxQIyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lam8ZjimvFyKb0Htk1gITXMWFH66zsbJXvMuFP6aFEDyqxV02NplqA>
    <xmx:lam8ZjDajAFSF5PF-cLJ-iMoERsv-DPdgrlYpntTbtETqtFRzmwfbQ>
    <xmx:lam8ZsKiJnq49nfWaZQgupp-FIP8JcUTReLWr0pgcn8IYdcLrKL3yw>
    <xmx:lam8ZiAqI3ISdj7rls4DBbNr917yanZdZ0clxRPMwxVHFjqdC2GAVg>
    <xmx:lam8ZmP9ZsTwUJVF9Vb6ZEvtUB4LJ_P4PPClizKAZ2AJ2MsbnbWSeQjb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 08:56:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3fd2ba31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 12:56:31 +0000 (UTC)
Date: Wed, 14 Aug 2024 14:56:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] reftable/merged: expose functions to initialize
 iterators
Message-ID: <ZryphS1KICCYWi9z@tanuki>
References: <cover.1723528765.git.ps@pks.im>
 <404d64effde3bee424e338d858ed507ff83dff20.1723528765.git.ps@pks.im>
 <CAOLa=ZSY8EWuXAK_tF4sSYGHs2Mv6nE-YtVtVkau4k5h=hOEdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSY8EWuXAK_tF4sSYGHs2Mv6nE-YtVtVkau4k5h=hOEdA@mail.gmail.com>

On Tue, Aug 13, 2024 at 05:36:27AM -0400, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We do not expose any functions via our public headers that would allow a
> > caller to initialize a reftable iterator from a merged table. Instead,
> > they are expected to go via the generic `reftable_table` interface,
> > which is somewhat roundabout.
> >
> > Implement two new functions to initialize iterators for ref and log
> > records to plug this gap.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/merged.c          | 12 ++++++++++++
> >  reftable/reftable-merged.h |  8 ++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/reftable/merged.c b/reftable/merged.c
> > index 6adce44f4b..8d78b3da71 100644
> > --- a/reftable/merged.c
> > +++ b/reftable/merged.c
> > @@ -254,6 +254,18 @@ void merged_table_init_iter(struct reftable_merged_table *mt,
> >  	iterator_from_merged_iter(it, mi);
> >  }
> >
> > +void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
> > +					     struct reftable_iterator *it)
> > +{
> > +	merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
> > +}
> > +
> > +void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
> > +					     struct reftable_iterator *it)
> > +{
> > +	merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
> > +}
> > +
> 
> These too look similar to `static void
> reftable_merged_table_init_iter_void` defined a little below, I wonder
> if we could have simply exposed that? Perhaps we remove it in the
> upcoming patches.

Yup, `reftable_merged_table_init_iter_void()` is about to go away. But
regardless of that, even if it didn't it would make sense to have both
functions. The `iter_void()` one takes an arbitrary block type as input,
which we never expose via our public interfaces. So it has to stay an
implementation detail. The new ones added here do not expose the block
type.

Patrick
