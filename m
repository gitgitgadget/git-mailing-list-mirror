Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB8285056
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341498; cv=none; b=ElFO43nRB62cU4cHMFBvn3uFhMJ7xNVjDIvwLmR7Pv9FN30xJQ9rVD3TjIiicLKc9X3zU80oBN//UOoUBx+8+zvZrcdCCY0RGafhBQQ6ixc3yg4389sk4MvCNyyAk7SpRlHd0One7b+ipGbIEmEeV/y/UDfJXfCXrUGXKH0k0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341498; c=relaxed/simple;
	bh=PY59K+GpszX01LoGNQwV/bw+zh7j4bu5fGALjQM8CLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imC6YFMXTf6f3koSke5yyZnZxBA1pDvzQtjX9e6VlFkkHNiIsUb5Rcc7NhcC+E7OKB/5B+6Z6gDDe3xHwuCnoYcYdSC/EyoLc01P+mnNPKvbAoE/Z3GuI496zniAdFN1aET0zLk3rvdKQ9XBWqL6NO1chUI13ds/BALp2agE4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kd3Q8eKN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7xmAkCT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kd3Q8eKN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7xmAkCT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4436D140018E;
	Tue, 24 Mar 2026 04:38:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Mar 2026 04:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774341491; x=1774427891; bh=knMJZFKt9d
	IPnULfdyLKO5usQAHH44rnsNZ9/989kj4=; b=Kd3Q8eKN7o3gTDoxJadzHHX1K8
	YcGa+PwvuKjgCmih9w7RvCqL8x1+vGPUKom5SD6GiVbOXdfGR9W/nJItlmHG9UHJ
	GX65UN5uiQo9vCqw3H4tKvCuhPRie1CnDGVtqBtebJPGCMDEZOT7UMJBr8JAkUm9
	Qu2dRNXQa6qZG33oHHDfjrnCPPzKOaI88PugkUiLFG0nGnaF8q1E9voIrRMZNwtF
	Mu+zakauxC7llHN1itaqvalYHIg9+1wFEDezXZE74LPHYv8ShOkDScsx/WkR4Bdf
	VGVoFrmJnaoE8I+hztUt9gw+dBxAObC2XTHVPpV5J3NR8YE3FiYkRWcOHHnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774341491; x=1774427891; bh=knMJZFKt9dIPnULfdyLKO5usQAHH44rnsNZ
	9/989kj4=; b=g7xmAkCTBlQFpFlwxbM+KZWk6bf6buMO+3nTfIGwlTRjHdQbj0u
	nGwm6T5x+Bs7llDDOociIa6ilXSE0ZCenzREOuP6yJVTNtWFY4S8Qif1JtNzq7AN
	CMcEa3tIUnADWNEIQmDJOajinRF9GnXt7neES9/NGRLNs8NX7eDRb8zT94iz1zvl
	aS1aGxDS3G7u71LOT7cEOdZ6CjUPM2YHMt6uHcPrZUwTxd35cf3t9Bo/pK1pH8gB
	ziQT71EeIPM9m9H1pmmPcoKluOvH5iX6Q0mrnj6u1Z2/iO3jmet1D/w1328VfGEe
	3cVTjfJU6u+IoNkWyNllnSKykQSiSAbAmcg==
X-ME-Sender: <xms:c03Cad-_xkMAmS_8zVKnx5canH2-lvKiWuO8tkEw8QU2_bGGA76SHA>
    <xme:c03CaYnywsoeZqtHsRGQFXqKvFD09-wmCSI4iv6yl80a9d5i4PZxWu1Mub1tsBLcW
    ASJkQyxCNazcTSnkjjce6pl3SUelsdq3m5Hu0OQMtVYbaHRZeRPOA>
X-ME-Received: <xmr:c03CaTXtRoJ4zRZovWD-tebJoOWxphbvl2r7Nr4tYK0efC9503rCwRxmPKOvFMZWelfdeGx_WYcvDqfsjHJ9T9IWiB4rHFP5cqKAMo6m5s3tYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfehtefgveelhfeuueevuedvnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    rggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhm
X-ME-Proxy: <xmx:c03CadHHzVkR9FquWOm2d856Ui6e5NrR2MWweY3Y2nmsI-w4oVeGqw>
    <xmx:c03CafeW5cWc-UdeBDXnCSLUJpoiDmFNdR4nWMFk47AXTQ11_1XdWw>
    <xmx:c03CaeKKE-qf6E1bWGRSR7Z9-kiCYd8qQ7XPYghQ35FuBBxdIVluXQ>
    <xmx:c03CaUF2qpPOzYzluJgztfXKNO95nixge5cHUgEzxCxGwKLGoRpuwQ>
    <xmx:c03CaWYrQPz6FbR1kNIBCgx2pUYKdezL5_IznlVMMnmZpidzxu3XQD0V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 04:38:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8769a5a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 08:38:09 +0000 (UTC)
Date: Tue, 24 Mar 2026 09:38:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2 00/10] config-hook cleanups and two small 'git hook
 list' features
Message-ID: <acJNblQ8WRGIri0V@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <xmqqmrzy5xwe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrzy5xwe.fsf@gitster.g>

On Mon, Mar 23, 2026 at 09:11:13AM -0700, Junio C Hamano wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> 
> > Hello everyone,
> >
> > v2 addresses all the feedback received in v1, many thanks to everyone
> > who contributed.
> >
> > This series is just minor cleanups / refactorings + two minor feature additions
> > to `git hook list`, which resulted from the previous series review discussions:
> >
> > 1. The ability to show the config scope (--show-scope).
> > 2. The ability to show which hooks are disabled.
> >
> > This is now based on the master branch.
> >
> > I have pushed the branch to Github [1] and provided a clean CI run [2] with
> > the exception of a known breakage for some MacOS builders (REG_ENHANCED).
> >
> > Thanks again,
> > Adrian
> >
> > 1: https://github.com/10ne1/git/tree/dev/aratiu/config-cleanups-v2
> > 2: https://github.com/10ne1/git/actions/runs/23340298770
> >
> > Changes in v2:
> > * Cleanly rebased on master, no conflicts (Adrian)
> > * Fix first patch build break by updating call-sites in same commit (Szeder)
> > * Drop UNUSED from function declaration in the header file (Eric)
> > * Drop the new struct hook_config_cache because it's redundant (Junio)
> > * git hook list now prints in tab separated output format similar
> >   to git config --show-scope to improve machine parseability (Junio, Patrick)
> > * Fix small style issues, comments, type, commit messages. (Eric, Patrick)
> 
> These came just before the weekend for many people, so let's hold to
> see if we hear further comments for a few days and then merge it
> down to 'next'.

Sorry, I've been a bit behind on the mailing list recently. I've got a
few further comments that might warrant a v3, but I think we're overall
close.

Thanks!

Patrick
