Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4153217704
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 04:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898784; cv=none; b=g2l98AdPOR0i5M57Z3FKIVZQTwg52RIj1vsZsZ38T9ywBy8mFDKilr87ArAAdcOHldpwTX0bM01uI9Ca8J7OUes8Y/l/9BIYuSh4KhcLrdeMDiG4pTWWPAskQVkPmdxGMyG1yfuoQ5vBNgblnDOsRR1PLoTwEnSclpAOVU/8URc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898784; c=relaxed/simple;
	bh=8vxxKconupjfxAnSY4l2mahRzgM2r+LeDNlG88LC1Mk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGDfMpCE9kauJX8PNdXwNEEMkVfO+DdV27Dp3tiIPM/ycDQ9tRkrWBcpyx2tzK4Nq7bGcNwNugPzr4yBz0yVjA7HV7VjALe/IOapugqEuxUZ04cVouJDBWWmEuPWFFCmRUJIyNAO/WSppZYqcLrBz7Wt7YLTHMTGbNqXobLXpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bvi/6T/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C9epqWMC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bvi/6T/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C9epqWMC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D10B87A01A8;
	Wed,  8 Oct 2025 00:46:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 00:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759898781; x=1759985181; bh=q80nX1wAua
	Qjl7khuyOMy2q6EyvDue5kONoG+3EJGcA=; b=bvi/6T/XynEo6Qhs+d/3TzDKiA
	+pcuEa+D38a5u1XpmW0fBZ3J78XSiGDxAH8qE1uiGkEnUB9998g0zScdebKhw5pD
	6FxZoOSkN/JRnwu6iiEUylHDRVGP8DDfiTiJIAMPyi1nysSFe8GiKhqyigUHgkr9
	ZcbPXEpo9I+FlRJfuh8IQi1anDnONKqT63czY9yHdmOplHiUFt7RapjB4jtRWRSB
	B5UjJVQVxH1+zCCUBoluqsERQUOHeK0MrPCgxpH31S8IEk9G6wJU4JUQ6gNwPOdk
	SgcEWCk613MYTgq6Hbbl44LtHPltUtXrYbJUif2jfnsLfTa1DqjqGBjyIZMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759898781; x=1759985181; bh=q80nX1wAuaQjl7khuyOMy2q6EyvDue5kONo
	G+3EJGcA=; b=C9epqWMCSmUAMNgQVj8kJqt6RMjAMaH5CW8r7yLEiRi1br+nxBi
	vSRFTkN2VpSutMLwAmozlrmVmdp00ryGhO6fanPYbrIzed4sIIdN13l6A4d5BbR1
	UXqU49XGJsX5hsvuVK+lf48IXxEOoVkF7M+VBVuoG1ng4HLOsGqlzALoUo5YKSnN
	yrdeDaniAWf1P33VcfXkFjTcPz642QwbtjMzgHWVqtXk7cRcsK6BDjIjvbCQo1gs
	FkyEzzsHSbsn+DPjokRclFutvauHVlZOjB3x7PhNJXTDCMT1lg5ZG5Ox9JncSBm+
	X2+LVr8ikmUACb82i0XWYaM2eW9S2wwHv1A==
X-ME-Sender: <xms:nezlaEkXpgpxBw5rOnCf5hScXr0IvwNbrNsvjcF8AuSsE6ipNyRVPw>
    <xme:nezlaK1AHuq7E5QA3XQz5K4EPouKMqlpbpD5LVfuGUK54uy1vPIBIwZLdG-S7j3Qv
    HXA3JNULldo10JsNAyFuSblxsrLDNrRXxbfyi_q768OJOZp1QZu6A>
X-ME-Received: <xmr:nezlaHoFY_DrQg2bE47AOMgEedRqa8LtHS-5X4zBsylTU5rmBLzmWdsbT9xIeM_WwuJDm6qEq4jfs-m9rauU3SzlgetIs7wR0HRsHZow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehkeeffeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nezlaPf-rAKRasUA4JQ0H9oQEOhszK9DAEcO5mr4d-mRiODirElEFA>
    <xmx:nezlaOqur3vg3O0ZQOirYBp_gvooRYduo1ZO-VqrbSo_NNd8roqWBw>
    <xmx:nezlaIEDQvsVhWAFTOOjJce0XBGPeRzc_kewRdx6onCd1WT2-FA_eg>
    <xmx:nezlaGt3GOtEV20KV0cH2UuQiLwzVUNkkzxF-bOT9y7KM28idMeCxw>
    <xmx:nezlaMVMNA7wYrVn_PBJbt1rcpW4qRmpI06ytBiYLnuMPpyp4ZscX6Ql>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 00:46:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63b71b48 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 04:46:19 +0000 (UTC)
Date: Wed, 8 Oct 2025 06:46:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] rust/varint: add safety comments
Message-ID: <aOXsmIu1BEWzxlVE@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-3-394502abe7ea@pks.im>
 <aOWwcqyithDKQzVs@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOWwcqyithDKQzVs@fruit.crustytoothpaste.net>

On Wed, Oct 08, 2025 at 12:29:38AM +0000, brian m. carlson wrote:
> On 2025-10-07 at 12:36:31, Patrick Steinhardt wrote:
> > +/// # Safety
> > +///
> > +/// The provided buffer must be large enough to store the encoded varint. Callers may either provide
> > +/// a `[u8; 16]` here, which is guaranteed to satisfy all encodable numbers. Or they can call this
> > +/// function with a `NULL` pointer first to figure out array size.
> >  #[no_mangle]
> >  pub unsafe extern "C" fn encode_varint(value: u64, buf: *mut u8) -> u8 {
> >      let mut varint: [u8; 16] = [0; 16];
> 
> I'm planning to do something a little different with this code by
> refactoring it out into a Rust function, so at that point it will no
> longer be possible to provide a buffer smaller than 16 bytes.  Note that
> all callers of this function pass a 16-byte buffer, so that should be
> safe.

Ah, true. I just double-checked, and all callers pass in a 16 byte
buffer indeed. Also means that the NULL-pointer handling can go away in
theory, as we don't use it.

In any case, your direction makes sense once we have Rust-internal
callers of this functionality. We definitely don't want to propagate the
unsafety to callers and should make sure that it is contained to the C
API.

> That doesn't mean that you can't send this patch (and I think your patch
> is good), just that we shouldn't tell people we can use a buffer smaller
> than 16 bytes, since that will at some point no longer be true.
> 
> Here's the current version of the patch I'm planning on sending for
> reference.  I can rebase onto your series once Junio picks it up.

The patch makes sense to me, thanks. I'll not pick it up yet though as
there is no justifiable need as part of my series, but I'm happy to
adjust the comment.

Thanks!

Patrick
