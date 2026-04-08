Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6A2441B8
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643444; cv=none; b=T9rU3WjuAdHrzYVglkZdypYaULxd/HY+EZyb020kJ834kLVwf9rv66xoZoq3PuA8p2DFz4D3BGli18LF5ah+TwpS8RChScYKlM2U2qgUkqDdrPE8KCO5itL5CzwTtDjlGD6CruHlXSgZF4Eh+p2deAn/Ss0K/yilYxfcuaLUXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643444; c=relaxed/simple;
	bh=LjsSrQs7gcsPFQ2fU7TGFQjP8/3bKA+bly5UcJ2dzsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1qosVdEAZlck+pMMeiScWyHsA2OIJHTy/BXBbBfA64859a9Ngddmzx/zenAvibMLzL57mkr3VcSnlXvuz3pMNd+toAVu3RRaziKTKZeLE5tjt0LwC7TamMsni4vctVcZLy9JX50ql923uqzCb9qvg6bJMWF6Yamd1PKyYffD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eZPPuHok; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uM3S4vep; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eZPPuHok";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uM3S4vep"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A468BEC01AD;
	Wed,  8 Apr 2026 06:17:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 08 Apr 2026 06:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775643440; x=1775729840; bh=ymxlEjfZgv
	/icWLHPIUgmftcUkIATzPLIReBcsxJujw=; b=eZPPuHokXW9HyEU52wj0GBKmlq
	Wv4IQHiXZsT9e4ccFHIsY9tg9nNwS1tXShoT19LDt56JvnlUnDJtdOlZvUytkDWV
	k5wtYox4fZUovOXzsh4TPHcK7YWMkkp3IC0+Bg6ulQ47C+PcZjaDrQcrrA6ycAqu
	HsUwD0L8G8o9cZz2l4x/fg8yrfXx6J5OP6JufH18hrmJ8D1cHxOoLnfbio41TpmT
	xihpgFDJIvUJ9xhoBSW7U8Kp5q+p1dvzC6bw9/mX09ZjUBht/cz88YNTQgF6/zpG
	8XyH/bN3aAfqXyLdVVcmcbqoPMlMkY7/bsbrGABYr9H06Eif/y2UeeRvNOpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775643440; x=1775729840; bh=ymxlEjfZgv/icWLHPIUgmftcUkIATzPLIRe
	BcsxJujw=; b=uM3S4vepjuxLV3mpjtkOu6KJmNUz5VscY5wddRw63gFAVEgR95T
	wsUABG6ZvTyG2XFi25h9qemUPXl95zZJKnlbDyn7CAhq1CXDELMys6V9yefRHtw3
	6nXGSkkIlf/CWMYI2NnXlnVtmdP6376sKga7j0I8rPxsFNXxtbV9CA7k5PFAesTz
	rPu+9+stFyz4JBCQTib7LhKkeNpUNsLYr17hDy/kJYwLLPEfZ5rxUNexYeHnWOPd
	MIy55WWk48nB0OHXD68jtDDHDuFrNjIQm7SodH93haKjfUap8SxqxlDN1aGfKVF8
	gZ9T1ljeCzmL7UkZLN+bdheaprJfxUuhQtw==
X-ME-Sender: <xms:MCvWaRles5KiBI72fj6VYJpE37t3VDcm6OZO8N3-Ptduxhxo93D90w>
    <xme:MCvWab6BXph04KoUiwNuw3dHHmYOORKK5HYNvF6W1IyCYu6QOYLWnOz8Jhj_-Dqqs
    rjUtcAolUO_LBYVjgxsIBf0b3fUvXhPfdrEMHZDF61Dqeb7ikRr7Q>
X-ME-Received: <xmr:MCvWad2vgrvEEzyhx18iksH0rOZZiaBurGaXI3ZFR0aUXUDwbaaz8XZjkafbCFYMGKcPqSo_43-m-rytyDIa0tmAS-j-ePnaB8QdIio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhiefgvdffvddtuefhlefgleehgfefveeuteffudfgheetgfevlefhueeuveeuvdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgoh
    hoghhlvgdrtghomh
X-ME-Proxy: <xmx:MCvWaeGMSnujgDlxz5Hi_YN7NSaGLUCnN_zF6cKtCoSu1iGeWZRsAA>
    <xmx:MCvWaUiw-p6psk_DT8Y-ooglgcZbzRd-2KMpCUZVDUJOXkk-XxcmVA>
    <xmx:MCvWaZC8Nb5TnWdYlwqZTf-32HCOievrtsszj878_KJ5MF4445WyiQ>
    <xmx:MCvWaeT5zXtNaQJVmNIv6jHfZdAUg-LIk96U8Th2tIKEdARDuPvtww>
    <xmx:MCvWaV7n0yjmgMb2Tr4g8l6ebdLSKurJhVjtUZwCIdTD2UF6VLvRjOqE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 06:17:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d12b0855 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 10:17:17 +0000 (UTC)
Date: Wed, 8 Apr 2026 12:17:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v6 00/12] Run hooks in parallel
Message-ID: <adYrKgEo24M3MUSd@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260404082934.173788-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404082934.173788-1-adrian.ratiu@collabora.com>

On Sat, Apr 04, 2026 at 11:29:22AM +0300, Adrian Ratiu wrote:
> Hello everyone,
> 
> This series enables running hook commands in parallel and is now
> based on the master branch because all prerequisites have landed.
> 
> v6 is just a minor refresh which includes a meson build fix provided
> by Patrick and fixes a trivial conflict with the master branch for
> that specific patch.
> 
> Branch is pushed to GitHub: [1]
> Successful CI run: [2]
> 
> 1: https://github.com/10ne1/git/tree/dev/aratiu/parallel-hooks-v6
> 2: https://github.com/10ne1/git/actions/runs/23974475271
> 
> Changes in v6:
> * Included the meson.build patch fix supplied by Patrick and added
> him as co-author on patch 10 (Patrick)
> * Fixed a trivial code conflict on the master branch due to build
> scripts having moved into tools/ for the above patch (Adrian)

Thanks, this looks good to me.

Patrick
