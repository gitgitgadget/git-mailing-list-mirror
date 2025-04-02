Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD4367
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576060; cv=none; b=DzG/K3lrun/pqaQp5Cs08eecgwZANt0UV1ZiSAd2aPlRB8zQy26PHP7g0ENeAJCSshzfFLHyZL6/6mc9Wq7z+mevuWq1EZSGM1GtvO6oLIS5LIesuJcSWEgPuYyvqpygtXsv4RPuz4heCFduS/fGN/10NEHNFMc6WyWZCJTfe0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576060; c=relaxed/simple;
	bh=E9wcilzzCB/S+LAj7sDKAFCoAahhzB4qEJUNhY3DvIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO7m4E4m7WUSsP/71Y1gL01dzILgH8ujsXIQo65INS8T7blcn4zqBW683Q5XMROAOCNe9F+gXn87o33EMWCksjMKB9ZsLR9GNSa0PVT8fHF/TrqrlwZ9G1XCLrkg+DN+hKwLN8iZJUSU0lwC7Q5h9jLTpIywgnwQmWJTdL+uKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WOCdAzWU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJdzoHox; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WOCdAzWU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJdzoHox"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C7D5C254022B;
	Wed,  2 Apr 2025 02:40:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 02 Apr 2025 02:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743576055; x=1743662455; bh=TXsNXfBqkD
	0f3MNzd3gZSYCOf5TkqdyQsuL1ZtPpl+M=; b=WOCdAzWUWKEp/J0lJOUhcvhQbT
	XnWMVmVGSfqI4CEreiiuow9E5v44NUimvzflZIzz52EGOHWXwZP0MgWWiJEyMV4w
	mGsL7yF23rpGkQeUVSxdDnQv8HDta0pALPv8qb5InzBm/i5DxMAbIjSk1RRXZ3Dr
	lO+0IpvQscawcYdPDoEweJ6SrkyxgsUn+BpHEDFw0/OhK8KmnleAxDuDNpJ5zz3w
	MNmrfPZc5HImjzM0DWH/DiWxA2exUawiWQ3juNpjOzLlfGc/zRVi/+AhgkbPQ7Oi
	yxlWvoeOytDqhZgNfkhu1X15jR2xhvzH1oM96PHjl5bawe+dWSF6igK5DHsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743576055; x=1743662455; bh=TXsNXfBqkD0f3MNzd3gZSYCOf5TkqdyQsuL
	1ZtPpl+M=; b=MJdzoHox8WCiXLc2MilLu0wxHrS8BEiPl0wCnEtwnzd/okbnrTg
	pYbq/Jq+Hh5zkI9VbCQRPT1Wr02Xydio9ANQnVtdlOhKgopF/pef5okRZ3Gj8bO9
	1IWpoEZW9EjxjIIk5ySmScWcKcTDal+BqXXfQlq96AMR+HanrkljLkAw2pWntp+D
	kfIZvxP8f5NvRZxje3DaSIWxeE5k1C79pyKUMe1B4HrSYhSNrhZhEq3pu2S/D5Ge
	mXw27XIKuLhSYxibLgvrlQ+KT/rgLTSoq7vOfiggyWreo5q95p8F9PcjVEoPKIYy
	2tj1LDX+S/hrJ+Ohp6W9Gn5MMdxhv7hC0Wg==
X-ME-Sender: <xms:99vsZ70q5NEO7OQSELJs46cx2KyTc9XF5mFnI88SGr_Vuhc2Kj_YRA>
    <xme:99vsZ6EcvvDSPyekkIontqeSMMLmuPcvtIMzSZpEPGnLmS5pJRjfMeGDNcaRAB5Fh
    2_IAhQDdkEkZNlRVw>
X-ME-Received: <xmr:99vsZ74ud0i8pLvqJ7b0SlnGn---Dm8jors14goj-yrIoVF31w06dAfRWHcifGJ6CfPixy2815RcARYLmdIRJfvPytSsAFqk9tdQLiTd20VTnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhgseguvggsihgrnhdrohhrghdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehpshdrrhgvphhorhhtsehgmhigrdhnvght
    pdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoh
    epshgrmhesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:99vsZw0HyQ5YzhSTR-uGRInr4Oye9AAyz4FAByjnpAH_bBHqk3CI3A>
    <xmx:99vsZ-FyLeqFRcHgh6gx9odZs6yDRj_aJ7AL6_zj2G15ZDBlRG-UBQ>
    <xmx:99vsZx-s4hCHL4Pw5n9WpWC_mh0iG4yTKPtkBZ2u9_3HVn2AclEQ4w>
    <xmx:99vsZ7m0WNhrGe2sxUFgld4jgR60x0vq0LV3hI7CNuUGqeVa-oVOOQ>
    <xmx:99vsZyZCPZ1UmDmozLUgXUMAIMWYYDLIm9jmFieRqcOxJJaZdqrZJ0PU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 02:40:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d830141a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 06:40:52 +0000 (UTC)
Date: Wed, 2 Apr 2025 08:40:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sam James <sam@gentoo.org>, Eli Schwartz <eschwartz@gentoo.org>,
	Thorsten Glaser <tg@debian.org>, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH v2 2/5] gitweb: fix generation of "gitweb.js"
Message-ID: <Z-zb7yPcPgJRhhXR@pks.im>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
 <20250331-b4-pks-collect-build-fixes-v2-2-6b06136808f3@pks.im>
 <e9ea3630-a831-dec5-e461-3f550ceb7ec3@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ea3630-a831-dec5-e461-3f550ceb7ec3@gmx.de>

On Tue, Apr 01, 2025 at 06:30:01PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Mon, 31 Mar 2025, Patrick Steinhardt wrote:
> 
> > diff --git a/gitweb/Makefile b/gitweb/Makefile
> > index d5748e93594..26a683d4421 100644
> > --- a/gitweb/Makefile
> > +++ b/gitweb/Makefile
> > @@ -118,7 +118,7 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
> >  $(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
> >  $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
> >  	$(QUIET_GEN)$(RM) $@ $@+ && \
> > -	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
> > +	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $(filter %.js,$^) && \
> >  	mv $@+ $@
> 
> A safer way might be to use `$(filter-out %.sh,$^)` just in case the
> Javascript libraries might at some stage be renamed (I could imagine, for
> example, that someone aims for ideological purity and renames them to
> `*.cjs`).

I could see arguments both ways:

  - If we use "filter-out" the developer now has to remember to also
    filter out files whenever a new dependency is added.

  - If we use "filter" the developer has to remember to update the
    pattern if any of the files are renamed.

I think the developer is going to be more on the guard in the second
case -- after all, renaming files always requires you to also update the
build instructions. On the other hand it's quite easy to miss that you
have to adapt the "filter-out" logic when adding a new dependency. In
the end neither of these solutions is perfect, but the worst part is
that we don't have any tests at all that would detect a broken build.

So I lean towards keeping the current mechanism, but don't feel strongly
about it. Let me know in case you still prefer "filter-out" and I'll
adapt accordingly.

Patrick
