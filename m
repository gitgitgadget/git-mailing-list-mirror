Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53114BF8A
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057719; cv=none; b=ahLavzOvJKmJlu5XttqmYO59fS5rkOmxRXAD79AzMFK9RtkEMdKGcRegiCUkzR6+Bsl/z7JrXSFNYJc9He6oaj2YjGzTkwOKOuA2WT+uW+2WrnS9Q/sNO1I31SbZsy83QGf9wzTrzbZOcJb68OUEJy1A/J4XZoFthvageKmg7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057719; c=relaxed/simple;
	bh=MJ/Zvhb8ab+RMBdIemBHsvArQIAHJn8VwnazDMGL9tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCtKuZAHwGD/tmt3owhU6X6A+omHuFAcVTGLJHZ2YGWQYSt0S9dytHdmhJx8w8HVJzG/dros98VwPYIrfAvQC3cJl8NAZHMDE7PBg1kPByQ3HukXtnK45iBd0bu3dtWgwmwV3RZxCUb2yncazBCE4z6QhCcz8WOwiPwXUQAwMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sBl/jm7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZ2sx77t; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sBl/jm7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZ2sx77t"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 701D81150011;
	Mon, 19 Aug 2024 04:55:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Aug 2024 04:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724057716; x=1724144116; bh=dyWqkqxlH6
	1rqIAtGc3bQ/xUUEx4IFi85rHGGhBoH7M=; b=sBl/jm7AZMrDb/rZbxpYQK91ZC
	Oin3T5wSuvoBaZ1nV6b8vO6Wz/YIGXnPLRgQCfeGQR0jmKj1NIzboj9Wam/n4JOL
	BX4T2RHxHj5nlPjuESkJb+kL0GM2vo43bVCshTAsKCowoHg0OHM8U1NowRkntDEi
	/0BOWboCB83u42eQQDiM3rVso+p+GAwfPP4GlZNmznt5IIIp4sJRf2U2JcOC4w7z
	PWcMRpbxDVcZ2x3zGwOgrc6u/hvHTU9QKF8S97Quo1tyzqFL6HsvLzEFgkb9lA+L
	P2RniuEm3F8GfqQMjNZZsK0/5ZEaHj+/2aVshOTGf/wcHnX97n3AXmUG5ZoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724057716; x=1724144116; bh=dyWqkqxlH61rqIAtGc3bQ/xUUEx4
	IFi85rHGGhBoH7M=; b=dZ2sx77tpZMIxdGJzhN/Lb+kntH41AT938BJ5Cl6gFhR
	FmQpz1SyJR13SLzKDByjjWAg77Cxq1DNUX1UjCsVLSnSs8/i10qs5xlsJ2Ls/U1U
	nk/J1PDPWGKe6WTbUSY9LUiugJB5t6FqFKNkxWxvYAfOlIlHlKRzHHYg9o4+Nxtw
	tDPaXar3wqMXGvwqZKsiSDk0tQK0PnUBK4y2RRIl9jCIvtpZFwHUHdBMsM9Q6pkz
	y62uq4fEl3H3X+okV7fHGDnUdCgyHMRiKHCL1eOkjhs3x/bQmmTNiWZKFwmyM7Pu
	vh9hUA4bFmGwHDGTi257bVxJ58nm7br04I0/FKRgQw==
X-ME-Sender: <xms:cwjDZh9Lsn07Rj-KIFf-3Jv3KypK6s1Dud2HVczyadB2Iw3XI3FlBA>
    <xme:cwjDZlvy8R6NwBrSc84jr_SQlkOxG8IdFAxIGOIHqCmpuBpruoo49fT2bnLoTRbPy
    uzZ1C8R7i-X0Ff3GQ>
X-ME-Received: <xmr:cwjDZvBKBtosVHAwFuLO97iLLasz5F9zP2f-l79FMPBqqdxUgQRtZL3g-omGp_ianuyjMm5unH_lLlEJiijSxYkyStgBuwpfuB464vINv2VLs5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepleeuffeggeehvedtteekiefftddtheetkeeutdekgeei
    tddvhfeuveduleekgefhnecuffhomhgrihhnpehlohhoshgvqdhosghjvggtthhsrdgruh
    htohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpth
    htohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cwjDZlf0JPaq9Uu5XbDp2jz9qc3MHZP0Dk20Sxw3Y4BgUqzmex2MGw>
    <xmx:cwjDZmP3ue8PDEpF-9_H9Nhr_-ZwSVhz60K3L-je38jeqc7OL-qjQg>
    <xmx:cwjDZnnjm5ArwCOacFGP9aJGJs3rkMBRDjDr2TIrIVvw6Y0p1TER5A>
    <xmx:cwjDZgsi6LRMfz6Jd-YVE9Qh9-cbHwaMAZywDOEL0Gws2_bAe0dvNQ>
    <xmx:dAjDZlfJ-KLym-jNDzlSCQe8buRJ2-kFQd3CHqohHe0cvpvQ0WJb4QL4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 04:55:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e188800 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 08:54:43 +0000 (UTC)
Date: Mon, 19 Aug 2024 10:55:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t7900: fix flaky test due to leaking background job
Message-ID: <ZsMIa_5jCFs4OWYx@tanuki>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <4805bb6f6c2c96a2c40d1d8359b63b8c7045e0b6.1724053639.git.ps@pks.im>
 <20240819084943.GB2955268@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819084943.GB2955268@coredump.intra.peff.net>

On Mon, Aug 19, 2024 at 04:49:43AM -0400, Jeff King wrote:
> On Mon, Aug 19, 2024 at 09:47:59AM +0200, Patrick Steinhardt wrote:
> 
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index 06ab43cfb5..074eadcd1c 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -967,8 +967,13 @@ test_expect_success '--detach causes maintenance to run in background' '
> >  		git config set maintenance.loose-objects.auto 1 &&
> >  		git config set maintenance.incremental-repack.enabled true &&
> >  
> > -		git maintenance run --detach >out 2>&1 &&
> > -		test_must_be_empty out
> > +		# The extra file descriptor gets inherited to the child
> > +		# process, and by reading stdout we thus essentially wait for
> > +		# that descriptor to get closed, which indicates that the child
> > +		# is done, too.
> > +		output=$(git maintenance run --detach 2>&1 9>&1) &&
> > +		printf "%s" "$output" >output &&
> > +		test_must_be_empty output
> >  	)
> >  '
> 
> This looks correct, but should we be doing it for all of the "git
> maintenance" runs in that script? They're all going to kick off detached
> gc jobs, I think.

Only those that use `--detach` run in the background.

Patrick
