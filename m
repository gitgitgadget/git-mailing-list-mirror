Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC122FDE8
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129904; cv=none; b=GpyAvai0/kwE6kJ1CCMVSVkEruVMPTUUgY/zGEgM2bUTKUc69OuhSPfFZwxe0bFBgiEKdD/7TbDqIyo9HEpOt4essrr7m6yg8/yKIofaGYQaFKYgKgavET3HgY0Vy/882Ls8leyxZJOerlELodsaFcGGlPahUOB9W95E9PHcPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129904; c=relaxed/simple;
	bh=Zt2nPPjrERdEcJo4aE0ZkxrfYgoSyAVhmmvmfhyegHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQL2pOA2oDnx6clbIbsphn/d+gPaxOr1+5CmqOfzSl2dFW38vU7fbJ9Efm/Ow3ZBXKaLLN50JHWTg9NDayPNcQve9djTmhsTEQ2Hr9mi67PTcFZq/BOS/UDSCQSmSLJQFZ/uI69CwBHC6I41OmOoTBrG2dRWJHbYBbLiKmhO7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RYnakv0i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+uPBBGO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RYnakv0i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+uPBBGO"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0F8C2540102;
	Thu,  5 Jun 2025 09:25:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 05 Jun 2025 09:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749129901; x=1749216301; bh=VT3v6Dm69A
	XcQcFoRVh3YjlYMTD7vBjHfXXKn6xHq0g=; b=RYnakv0i0KGsdXFtJ2sjC2StdZ
	BriJWuYK8nPXdDdVwQUU0Ky/4FMs6R47HRjS2Ghc4PEFizHwz0kw/RtMnHN61JzW
	vmTdkgqvvV0TWEhnpW2HVCL0TepmAVo3Cp+JP/lBiwzUNYBxBRLs8xw1dCYSPFID
	FrnNYhXtigFRfG82fAZ38danOZyk2tuYOODdHZ18MHwj6puMhDfPADQBZ+daJbgS
	+tN8Ka2ANybQnaKKH44kK+y4LxqGJMskpBOuPdHUe+dgjO14i8FVRGoWUDQnjYhp
	OE7FB0Hz0FiGyHc8JAf9nngMbeyWKDOUWK9AoU5SJuf5BDWBpmYJD1Oc4dIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749129901; x=1749216301; bh=VT3v6Dm69AXcQcFoRVh3YjlYMTD7vBjHfXX
	Kn6xHq0g=; b=F+uPBBGOGPMUcF74NlBIfUV1sHPa0D4WM46GdSYqwIAjssxzjCM
	/NYEQX1zXLfYUj6g85q1DXpQ6VDUe0wUtEiYr2WP0oofTCDpTQmru1vdXNFRZHYG
	a1l/DtDmDZjGXeyji/a0dXHaemiD4iKHAtsvSKK55rczSUOvEZZ4Ep4U6bb/rf1l
	KtYYjBtKsFadZGx8199jymgc1tuvGKnE16OddG2dH/PNlN1Zvha0P3DcF8vpnzBU
	rfmBW/Q5zStK+UbmRn2rExy4jXTEjyDF8JAB4JFDFLTLNy2AbnGDP1y6IxR0zcZy
	PZD9/iwn6krA6W8p4kuajjgMycIJiJ5hT4g==
X-ME-Sender: <xms:rZpBaPtl6TEqPXbrklKe9IeqZBLJIMQfiT6Ob6Mft2vtT-sbp81f0w>
    <xme:rZpBaAcKWueaPGZ-QuoZYXBVUpdrLD32MQ3uHcrL8u69Q22FK-2efACthcnhWEjGX
    bg8ZzzAyfN2fmI6Hw>
X-ME-Received: <xmr:rZpBaCznLK6WiUiV_AvB9ByVouMQZVYb6ldBjgXANwzDoE3uH2584LDnbtB6IMtCkOP0yT3d4axrM3CMG5-Zdb6kBKqW92aGtAGZMLqYpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:rZpBaONhQwpTJCo6Rvqs0grh7EN0ZhSWR2zJwkvEimJX9mJ8IdlfpA>
    <xmx:rZpBaP9jKjwGs1CgcvstuK4u9W7VGhRYLn2S4sdpM8Ni-xO3coTAxw>
    <xmx:rZpBaOVJ3oVjRY6mykbRW5wdy1QP2hRnyMGfNghZA8rjc-kKX6ubeQ>
    <xmx:rZpBaAfGwt3WcYxlIf6gS5CUWZ3dOYa7s39-Q004wissKBrC6DOGng>
    <xmx:rZpBaGSQtsNerheZxE6kbta5WIEl3ilYG4AtpYGCDR2hodTqPFZeH3aU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 09:25:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a91ec05 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 13:24:58 +0000 (UTC)
Date: Thu, 5 Jun 2025 15:24:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/10] t/unit-tests: finalize migration of
 reftable-related tests
Message-ID: <aEGaqZU2FdLqL79L@pks.im>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
 <20250602122559.208780-11-kuforiji98@gmail.com>
 <aD793WJpsHm3d3Q8@pks.im>
 <CAGedMtdaDR1E9YWXQOQKKtKj7rgjmRy6cLMC+A+7B39r=u5Amg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtdaDR1E9YWXQOQKKtKj7rgjmRy6cLMC+A+7B39r=u5Amg@mail.gmail.com>

On Thu, Jun 05, 2025 at 01:56:43PM +0100, Seyi Kuforiji wrote:
> On Tue, 3 Jun 2025 at 14:51, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Jun 02, 2025 at 01:25:58PM +0100, Seyi Kuforiji wrote:
> > > diff --git a/Makefile b/Makefile
> > > index 8ed8f234f4..8d8f2d574d 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1380,13 +1380,11 @@ CLAR_TEST_SUITES += u-urlmatch-normalization
> > >  CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
> > >  CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
> > >  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> > > -CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
> > >  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
> > > -CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
> > > +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
> > > +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
> > >
> > > -UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
> > >  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
> >
> > Can't "test-lib.c" also be deleted now?
> >
> > Patrick
> 
> I don't think we can just yet, as `t/helper/test-example-tap` imports
> the `test-lib.h.h` header file. Fixing that would be beyond the scope
> of this patch series, don't you think?

Yup, agreed. It may be useful to point out this detail in the commit
message.

Patrick
