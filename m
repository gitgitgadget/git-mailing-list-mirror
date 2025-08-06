Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E614431
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463190; cv=none; b=SbLL47O98ebAcD9uaBEp3D5AQM/0PSVbVm4u4luK+Rqlyg3pmb7G8HkdNFg/j5IeRLwUDLBxnqU/vBPGtK9ggyuYE35HIlu54n1c9DZaoxHogeY4j06tcu41XL/bCDyEQoIlreMWTkYk85vcC24OCZZwC/2ez/a37vpscOyyVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463190; c=relaxed/simple;
	bh=L7xYaXdUa7A6k50gUYNlRsScvDUMS+AOkBaUfQURUhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXwdpFjZT1HC9gJJ9e0TKeeqe84HXsr1v9pdtb8j7uhLTiaOkqr6HKWCJvm8MiNg5HMkGV9k5pRODqwlNzGWJlVBDxQt+LJePgXkBW1oE1Jr8o61mTpT8VnNHWzHXPRMAQWS3kEhMyjOESYuS3OyhMRk3ZrIE7IoNxP7pW6D2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HCyZ1t7B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqkXiWKZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HCyZ1t7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqkXiWKZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A75D7A0088;
	Wed,  6 Aug 2025 02:53:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 06 Aug 2025 02:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754463187; x=1754549587; bh=0jP5ye0AWD
	WDhSHO5X9sewOIaTkteiFM/s54KJEIiyA=; b=HCyZ1t7BdZdu9Nu07IsSsyKkkd
	MmlfHmMq023OqXANY37HayJs8u9Yqg2ceiUz24PfZjHs/RzektGOLsuFRUGgmkEn
	/CmxhB+j1SeQ0UwE5XIoTxOGHwpD5CxJqzTz8B6cisPlkZuxY78+8RpEii06WUOi
	dwtT87jEZm6JJpdR3vQbsLANAmaUvpdC2yGZWqE19RvtvG4M/D0w9UE4Yv2IEN7p
	8kDvo75wg5ETykr7P1B5aZ400nwJX8GNO38QkDiSeBjDMIX6TqKb4hArdUd9N5+w
	MncEPcrjdJfEmbz1H9WkjoWSam9ORDY3ZlHt4ap4TSuJRLrsLLi0b7VMU6NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754463187; x=1754549587; bh=0jP5ye0AWDWDhSHO5X9sewOIaTkteiFM/s5
	4KJEIiyA=; b=fqkXiWKZFv5d1i5Y0OkNG3arBoOgh7NKAfUe6VTUmTEAFXiwb6k
	W8fJDDBtMG9tsFshuj1kqRu7mNe6QRu9gzvOq+gQx6OuriyAdywgzYFVo59wCU/M
	R/ibeEBEUEdx6TBk2NM6+7s/3/tUUGm20GD3IGQKcmHwbR8mkKy26kRNBqDTr7L1
	veY1O7fuEDClMOiBWAno6zJeanQ6yGvfsEVLVFPACT70hO9GwEkq3V9IIDqpzKJ5
	i/fGlw/JUXTwS0d+MS3L6o07Jn49PNTvmCVo+3VE55gePpLv+/RrLZyRxxtEFuGy
	MPrIaWDXJ8mbB2Ikb1jhq0wNDyX5xP6JqxQ==
X-ME-Sender: <xms:0_uSaGoD-ajg8cTmnRCZjwosxMT89hrv5DTRKjY-cL2JtVutfQZ4-w>
    <xme:0_uSaE2mGPEdFZdTDAeulLacXyuhBpdFTST71rezL3183OZwpZuXZKusiaphSXXDd
    PHTcDyaVI_yzBJPEQ>
X-ME-Received: <xmr:0_uSaNBFvgkov7WqrEosAtA63w0lrOp0sAEwzg3-PJW2O3yMsrmJTXmr4-Th_l8F9m0W40KD0OYJgpq-D-IINO4GBp7nFRxC1uKoxHgsYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0_uSaEcXQ75t5wKDQSR78mJM-_qMu9ZNF6HxNaKJPadfsCD4hIaFJA>
    <xmx:0_uSaKiehu5qaUEfhonxFa_hVI4ZZk08itp29-D0gop2enVks78CbA>
    <xmx:0_uSaEowUVD_laAZGczwnIoe4CDXbbnshzewKBc0jk4oQfASWD9Axw>
    <xmx:0_uSaCED_oWDsFwlTvwomH1hdzDVY03DGoH3EedsMDYoIjuGyjrUNQ>
    <xmx:0_uSaPHysho68ErKQF3ZwJ3xil8_CgpY4QvhmwJpIkmBlszeFRO3x6kh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 02:53:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7abc40f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 06:53:06 +0000 (UTC)
Date: Wed, 6 Aug 2025 08:53:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/9] commit-graph: stop using `the_hash_algo`
Message-ID: <aJL7z2kHXCW1exWH@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-7-850d626eb2e8@pks.im>
 <aJEvzR4wuve/9ltU@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJEvzR4wuve/9ltU@nand.local>

On Mon, Aug 04, 2025 at 06:10:21PM -0400, Taylor Blau wrote:
> On Mon, Aug 04, 2025 at 10:17:23AM +0200, Patrick Steinhardt wrote:
> > Stop using `the_hash_algo` as it implicitly relies on `the_repository`.
> > Instead, we either use the hash algo provided via the context or, if
> > there is no such hash algo, we use `the_repository` explicitly. Such
> > uses will be removed in subsequent commits.
> 
> Seems reasonable, and the implementation looks straightforward to me,
> however I wonder...
> 
> > @@ -129,6 +130,7 @@ struct repo_settings;
> >   * prior to calling parse_commit_graph().
> >   */
> >  struct commit_graph *parse_commit_graph(struct repo_settings *s,
> > +					const struct git_hash_algo *hash_algo,
> >  					void *graph_map, size_t graph_size);
> 
> ...does it make more sense to take a 'struct repository *' here instead
> of passing both its settings and hash_algo separately? Is there a
> scenario where we would want to parse a commit graph with a (settings,
> hash_algo) pair that does not match that of any single repository?

Fair. That'd also allow us to move the call of `prepare_repo_settings()`
into this function.

There's one catch though: in "oss-fuzz/fuzz-commit-graph.c" we manually
stub out both the repository's hash function and its settings. But we
can appease it by also setting `the_repository->settings.initialized`,
which ensures that we won't try to populate the settings anymore.

Will amend.

Patrick
