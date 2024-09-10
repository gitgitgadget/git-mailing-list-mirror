Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBA144D0C
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949244; cv=none; b=XNs5tgr3YBYi/sXF4nUVbZgHoZhj98AdOTpCQGuKL5RolVACimk1+5qxGbNduKSogi/KVh0qcQv9kRxC//88vjDeEK4Qj6WV6QNPa1T79gPCuMg97FWNZxWIC10/cv9flamK5r1NRBmmKdWQdKkh2Vb7ZFhFnkbxN+Tym4vBWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949244; c=relaxed/simple;
	bh=Sx/GUzWoZdGuWuJcu6hs2wQI/aIOKwBfUbu6X9irW8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S647GbSR7dc4ozuvIJDKLya1b9wSoBVkBhFf/hO8hlubYTlUqKP6neAdd6mYoa2TF00Y4dX5dylCyPuO3sYfLSCQao+rxVLB1fVDUa3VLn8UBT9iCQWPfpL0leYa9GNbODh2+vLr48Uw/Ud8Git1csZpZAOqOkZ+/GkkVvyLTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y/6fuj+4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FfQtRBOF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y/6fuj+4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FfQtRBOF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EB5BC138031B;
	Tue, 10 Sep 2024 02:20:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 10 Sep 2024 02:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725949241; x=1726035641; bh=mA0x5KDUgV
	Vd0xf4vRphAmXIa8+qnjk+FH+0w1wDXqQ=; b=Y/6fuj+4NB2vib+P40ZCIxrUCY
	6f1PaQI1F14C3EgJNxv+3KpJ3bfHRWHJMDbHind7DUXwb8/KnQSqHedmqEaIXFpA
	QGgRX1XeWHkEu3WiZXBU246Q7jYKLysDL7AeDNy/3yFvDXc791rMCfhHDA4fsfwX
	Klrndnack4PbX3DQB5Uux7pakWuGylPEC1dVPpwe4sF79LZPvOMb+ZyZQ3Cr4QLV
	clCwMbbCeUFo0TWwYjWxNnzisgrD0zNa35Ox7Gbztv/f8xfWBjSxMH0ZZZ3XfCjp
	wkpgc8S8DRnkIlRS5HpvFdnmX0Xo8UUKVV0wcfRRQqX4cq3BCpPripH5qXUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725949241; x=1726035641; bh=mA0x5KDUgVVd0xf4vRphAmXIa8+q
	njk+FH+0w1wDXqQ=; b=FfQtRBOFYA5gZwQg1CJ7W2W9d25SvlZT4iBF6TIuCBe6
	+PfKuYRxxQoPtKCm1gWqXpCbV1P3Peo5UDl75LxgnjvuCjScL9yKO0tXIKMosc6d
	UQSInYiGbNiPJZSQjYPzkTxYMKHeufNslh5IRDIpppDms9d3MR6llaRN8BasHw/s
	zYPvZ0aB3DLMriEg3MYEMec3zlIDGFm6u2hRHgpspXvLFhO5PSecnatgCbsRkpH+
	n6LWH+F6dDUrMabpYpdgExSbFu4yZHpfCXM8DvMSNNWhrnDEbAROLL5u4BxPsBoF
	3fc9hiFetm6oWZt0/M9HLMO5PhUNHY/U97L6CFYLqw==
X-ME-Sender: <xms:OeXfZsRj-KvSVZnaEaouhiqrnNhcmZ7tWa_2MXjimfThFemkzosJkQ>
    <xme:OeXfZpyuCptMJLZJ2Hk_3p4JQzntOwCNfA4aaIIUamoCRr00AR2przLus7RDrc2Pd
    ynwAp1E2yztOPsJXQ>
X-ME-Received: <xmr:OeXfZp3YnNP93onaZVa0xD2VqnXnsOEXuUAjexVGr6kyyZOK4KF_Yw2OMoYR86cxlYQ_Y0eZejbCF7UE2bl3TBou4vg2fnvbHyC2f8L1wbMHudw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhp
    vggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtoh
    hmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpd
    hrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:OeXfZgC1BCDHEKIiaAzanzE69p5kgF5MkBjN2BoUY7VbL-f9ivUjxw>
    <xmx:OeXfZljV4vSlUiIU1nr1kjBeVXysz1EAnRREAkVOICVUKoXz2D7Vkw>
    <xmx:OeXfZsqCSI7ZigoSmDlDyeeY7mD48pJdoWl4r_qtX2nkk0CKd1Boyg>
    <xmx:OeXfZoi9NutG75m26FH7toKAZZEnRsFj9o6aLIXEDLKQVMf4-WBiUg>
    <xmx:OeXfZsMVsUt3HZdKAiTTt0q7TDsXNGniuZSiNGqe2otZNKH8_NycNgPP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:20:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b474ae6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:20:34 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:20:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 10/14] Makefile: wire up the clar unit testing
 framework
Message-ID: <Zt_lLsnylKJ9uoqj@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
 <9c74c5ae01989659c0347d2742f820d2161d274b.1725459142.git.ps@pks.im>
 <xmqqfrq8r8s8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrq8r8s8.fsf@gitster.g>

On Mon, Sep 09, 2024 at 11:17:43AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
> > +UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
> > +UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> > +UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/unit-test.o
> > +
> >  UNIT_TEST_PROGRAMS += t-ctype
> >  UNIT_TEST_PROGRAMS += t-example-decorate
> >  UNIT_TEST_PROGRAMS += t-hash
> > @@ -2714,6 +2721,7 @@ OBJECTS += $(XDIFF_OBJS)
> >  OBJECTS += $(FUZZ_OBJS)
> >  OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
> >  OBJECTS += $(UNIT_TEST_OBJS)
> > +OBJECTS += $(UNIT_TESTS_OBJS)
> 
> What is the longer term direction we envision?  Do we aim to retire
> the UNIT_TEST_* and end up with only the clar based tests?

Yeah, that's my plan. I first want to let the new clar-based tests cook
a bit to shake out any issues with it, and address issues with clar that
were raised during review upstream. But once that's done and we see that
it works alright for our purpose I'd aim to convert all test suites to
use the clar such that we ultimately end up with a single unit testing
framework, only.

> At least until that happens, can we have "UNIT_TESTS" -> "CLAR_TEST"
> or something that makes it less confusing?  Every time I see merge
> conflicts around this area in the Makefile, I get puzzled and wonder
> which one is which.

These are indeed quite similarly named, so I see where the confusion
comes from. I'll send a patch in a bit to rename them.

Patrick
