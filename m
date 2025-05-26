Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FA207A3A
	for <git@vger.kernel.org>; Mon, 26 May 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264185; cv=none; b=NuRIm3PBByeint6DzbbRac/Y5WtOXh68ihEy1KS4VkIDfOgryaAzFw59hgdRu6yOODDLU/0m8SSJhC5Qpp7e49xqLCuRchXw5FoAB+/vCqS+t2bM2cOeeJ/LbJ/sjM1FPYT3OTvMiLJZEwaRdK5DuZ1bRkDVJAXt7tf0yOXFFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264185; c=relaxed/simple;
	bh=YrFftOiS1k730Plaz+zzLRrkvlIsB/KYe3KgEaMVAAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhEeqMlI9sP3MiGligv4RrLDj2wSYZtX7YsZ9oTIr9rO4LdHJtqLufeM3vQkfcEGpcsO2H8sWAeK+/9wal2qJrXprkZLV9/+iyf98vBpthP6FmlPzvDcqi10I9K6XzqoLvmF8c1I28O1OzWwR6/2erbb00sOL+vRvlz3H/dpyho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W2WQ+qDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HzZK7C2b; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W2WQ+qDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HzZK7C2b"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95F85114010A;
	Mon, 26 May 2025 08:56:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 26 May 2025 08:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748264181;
	 x=1748350581; bh=u8pVWDzisMvAxjgeRi/j4+QwEb0fv2ugWnUvBgY0+2Y=; b=
	W2WQ+qDAslBJGn4oQ6iv3zeG4WSQGKBNNn0EJKq4/4vxpP7o9OHtB2guE8LBSffw
	6eoiQu9bRy8CSoHsCKLAPf+SnlW+oF+wP1ODlWG5+Wn7A5EP/5yVboSeyrL05W2w
	5hXo1njmrOidtBPU/L+GbBRKfAYY7l9rvHfSzOtYGYsJsDrnn+Bmg3xdyFQU3tf7
	WKnnGrTzMRFt8BZQxgBUvhLJnkGBz6CxoLISt1QAB+mKLuIO56BpmaK+nFqgahlE
	bH2sZOZw/3lORJZvR/4MZasWp4BmoukFGSyvqzCsF8rcRcfzPbmr4jmMw9Ob+eoH
	Y4Ac7S9Dam4ggWTBf/Ui0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748264181; x=
	1748350581; bh=u8pVWDzisMvAxjgeRi/j4+QwEb0fv2ugWnUvBgY0+2Y=; b=H
	zZK7C2bs9mTLmwLGBP+bcb8rqhf7+i/F636LQ7GKt23LwrGE2tJ/5on46ln9nVg2
	kNP29dnQREQ+zJnhFR2u9FzsF0xDUChrO1aaZ2yanLbOU080YSwr8Ugx85w7V2fb
	UBtkDc1FSwC/J6T+wlZlVFif4TKJvzmBGNcWuim4fpTM3r1wQuVETP3ZVXHFz+w9
	Q+Gi/08RZWCZBKILNwbJj97JFr2+E8iXgGBOtVB0dp7gU7Ava8h8WgSP3cdKxT12
	woRHdPr4mj51XDHxCwKtRCtLQ+paSvsqeivxnhN+aZP76ko5Y8qia8mFJR0/2Jsc
	1TLSTi+Y2EZqguEvEQpNQ==
X-ME-Sender: <xms:9GQ0aGF6XONpjGs8IEhuL5Dm6bI6K9lYA6vQJxkV7ruIDm8nVvEgng>
    <xme:9GQ0aHVdtRsf6tNhzEOpv9zwTL31ob_AbG4trGT8wKLg_WSgYfYJZAZ4MBru7tEV3
    2vKmQOf3_RSTu6ecQ>
X-ME-Received: <xmr:9GQ0aAJBbFNNh-2w6hAUMuXvz1nwi3jLN47HSytUwcAvCE6Qy44y4Qhyr4haM1qltRU-BvtCgY9AjHAkZdEWZF6nL8Qv9PjM2fuD4X2-HFgdUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeej
    leegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
    dprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9GQ0aAHmOrYmkwvqAZOtfc1cb9Sm6zTJ5Sv9LlvMbUXcuvPvGNW9lg>
    <xmx:9GQ0aMWY6KT8Dwn2aM64NzhI7h5dIEdhqgkwv99cnIeAs5dAqb8JBw>
    <xmx:9GQ0aDOmzFyhAUAKTEzzBPU9jx_VQ5FhWvOE9Ldy4nA1HAdUm34HCA>
    <xmx:9GQ0aD0nFkQnGM1FJiKzN24QrcEjsH0PvrWuu4e1k-L0Enxxm45VhQ>
    <xmx:9WQ0aBIpLMmOg58PFdu0kUxFmYwV9bePBryTLBZYzGjZWDbfzUD8f3NT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 08:56:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e8a98be (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 12:56:18 +0000 (UTC)
Date: Mon, 26 May 2025 14:56:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 10/10] t/unit-tests: adapt lib-reftable{c,h} helper
 functions to clar
Message-ID: <aDRk8XeQLWn_jQl3@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-11-kuforiji98@gmail.com>
 <aBSXJcT8REHWrsrx@pks.im>
 <CAGedMtdRwsBwRK6ENaJfbZ1tba4jD1WMyk3HdFft3sC6H2001w@mail.gmail.com>
 <aBiKUGn7avRUcehV@pks.im>
 <CAGedMteAkHj0xc2iq7T+CWa=uJWWg0me8hD6x=Nv8PHPtO1P_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGedMteAkHj0xc2iq7T+CWa=uJWWg0me8hD6x=Nv8PHPtO1P_w@mail.gmail.com>

On Mon, May 26, 2025 at 10:04:43AM +0100, Seyi Chamber wrote:
> On Mon, 5 May 2025 at 10:52, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, May 05, 2025 at 08:27:16AM +0100, Seyi Chamber wrote:
> > > On Fri, 2 May 2025 at 10:58, Patrick Steinhardt <ps@pks.im> wrote:
> > > > On Tue, Apr 29, 2025 at 06:53:02PM +0100, Seyi Kuforiji wrote:
> > > > > diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftable.h
> > > > > index e4c360fa7e..2958db5dc0 100644
> > > > > --- a/t/unit-tests/lib-reftable.h
> > > > > +++ b/t/unit-tests/lib-reftable.h
> > > > > @@ -6,12 +6,12 @@
> > > > >
> > > > >  struct reftable_buf;
> > > > >
> > > > > -void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
> > > > > +void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
> > > > >
> > > > > -struct reftable_writer *t_reftable_strbuf_writer(struct reftable_buf *buf,
> > > > > +struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
> > > > >                                                struct reftable_write_options *opts);
> > > > >
> > > > > -void t_reftable_write_to_buf(struct reftable_buf *buf,
> > > > > +void cl_reftable_write_to_buf(struct reftable_buf *buf,
> > > > >                            struct reftable_ref_record *refs,
> > > > >                            size_t nrecords,
> > > > >                            struct reftable_log_record *logs,
> > > >
> > > > It is quite weird that we declare the replacement functions in
> > > > "unit-test.h" in the first commit only to remove them at a later point.
> > > > It would make way more sense if we introduced the functions in
> > > > "t/unit/lib-reftable.{c,h}" right from the start and then only remove
> > > > the unused functions in the last step.
> > > >
> > > > Patrick
> > >
> > > If I get it correctly, you're suggesting I have both the original
> > > functions and the clar-based variant in `t/unit/lib-reftable.{c,h}`
> >
> > Yup, exactly.
> >
> > Patrick
> 
> Hi Patrick,
> 
> Thanks for the suggestion to move both the original t-helpers and the
> Clar-based cl_ versions into `t/unit/lib-reftable.{c,h}`.
> 
> I’ve tried doing that but ran into some build issues. The Clar-based
> functions use clar_assert and clar_assert_equal, which aren’t
> available to non-Clar tests. Since both sets of helpers would live in
> the same object file, this causes linker errors for binaries that
> don’t link against Clar.
> 
> I also hit Makefile warnings like “target 'lib-reftable.o' given more
> than once,” due to the object being included in both Clar and non-Clar
> test builds. And with all declarations in one header, non-Clar tests
> see prototypes for Clar-only functions they can't link.
> 
> Also facing errors like these:
> `LINK t/unit-tests/bin/t-reftable-basics
> /usr/bin/ld: t/unit-tests/lib-reftable.o: in function
> `cl_reftable_strbuf_writer':
> /home/seyik/git/t/unit-tests/lib-reftable.c:113:(.text+0x520):
> undefined reference to `clar__assert'`
> 
> What would you recommend I do to fix this?

Hm. You could also have a separate "lib-reftable-clar.{c,h}" code unit
that contains the new definitions that you introduce early in your
series. At the end of the series you could then delete the old
"lib-reftable.{c,h}" and rename "lib-reftable-clar.{c,h}" accordingly to
have that name. It's requires a bit more shuffling, but given that the
final commit would then be a plain rename it shouldn't be too bad, I
guess.

Patrick
