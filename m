Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D4201100
	for <git@vger.kernel.org>; Fri, 30 May 2025 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592801; cv=none; b=V+OAdGUZidqAiTeXO3Z/Y+KA28CDW5u/WyxlBWmV/a7zLaaAP81R6YUw/mSOogrHlV/gWhCG2PqA+EuJFQbT8HY+8BXoqnLIZM8YFphO02Dd2CstRKh7GOQY6d3Q+sHi1uxBScfiVp7GwyekS45AUDw3LTIqIzt+wdjkRKTbkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592801; c=relaxed/simple;
	bh=jI44ZwvGLqPvXOA0A7GdxjfhAQmP+VHwqExgkSH9KqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJM0EonwH5oDDmBXeySL2+MP5D6E4ZHkTLwsGL4W1vKD3hKvqwwSCOOTR6l6l0dMYfedumTfrEqvHGisAMEVO/5pS6TmYl7d5kHfaslaobYReN4/Ive0FXF1aJ0VfxhrOuBbmxUQZWO6GYYke4AJMSnvApNa0iMb+kNC/xWeWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bi13lTpR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NofxspKU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bi13lTpR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NofxspKU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E9E971380265;
	Fri, 30 May 2025 04:13:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 30 May 2025 04:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748592797; x=1748679197; bh=069N2GvffY
	QBA+a7cNd1DIIDmbwAnCQ4EhAp/nvbRIQ=; b=bi13lTpR/JwOEJmF0ZOP4B+V1e
	WklOOn/vdlny8AxsS184cdk0967kwS2phxQBkhh6KIWvg/LNgJMA4xUSDY/h0JcF
	r6f4TLGtB0k0Myj5fWKLm1sEkJuWde/EAcxsTIuxM5gJAAFNz5woycEwT/Mzw8IM
	g3P3ZrF92gBjE11RQmWVGoeJUstczW4Ffk3VSpgLXyjz4JvLPQzUsWpcYxFIihL9
	PPxA/bGojjRVIxWOzPXXWja/K3ylHC9jiAPbYwuVXhefrKsj8k1YVRh01xsMQJt4
	h+ZyI77TtunsU+HtiSAVG0wlVQ3ubyTNfQfzo+lEWDLUzkitEqUTRkFt90Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748592797; x=1748679197; bh=069N2GvffYQBA+a7cNd1DIIDmbwAnCQ4EhA
	p/nvbRIQ=; b=NofxspKUDtScutRwKV0kfPOGP8c/h9yq6iBzgov1nG2D7wzYS6Q
	54iYz+GDLbhhxEfFD0juwg8rJoeXAPgjbdedUXS0qJlr2cx81nudYJL+ACU0z2ox
	VE+Hasu2364kJXdQfYOmPKYAUskpV2SJLwe/FOl325oNih223IdEH5/T1YK2CRPq
	gvYh4KAJIWvapj7N6KpMbv9g8w11HpvVyAOXHYLQ8qse8F4zRTjevGQPduej+mVw
	r87S1+VwswKJa5ntGw2v8KHIuPTcyRqa9qNT9690jjzEJVolhVtJ/P1qsOqOQvEb
	0pJOJJZ8fJ0NecbDelLfsDy7tX/lyIK/atw==
X-ME-Sender: <xms:nWg5aPbaG3qQAk8QvTk7X1de17eRpqmlhAF8eYztZyPL0mPWbP4TdA>
    <xme:nWg5aOZaU3uAx2Fcdhd6xrnF-MMXrl5lroCTh6ZST5wvEUROEFnNZH7u50a78ae-C
    WhRLPUlPRl_WpEoyQ>
X-ME-Received: <xmr:nWg5aB-wkJ1qsIgRpeB9apTgj7WtyldcohO_PqTE8qxYRXsFD_a8rV88DNaUbc8LKMTs3qCnx-OgYmq0N2b3qozRgqPA7BJxhwqVH7SrbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeehtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefgvdektdfgveevieff
    leeuuedvhfdtkedvteeigfejveekgedvtdfgtdfgvdeiheenucffohhmrghinhepghhith
    hhuhgsrdgtohhmpdhgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepie
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepfhgvrhhnrghnugholhhimhgrsghushhinhgvshhssehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:nWg5aFpDTpg_N_13YtniseRxeUuXKCU7lR0N2fCoy1bsy6bUeHsO_A>
    <xmx:nWg5aKpNEYmnzrM1qDr_jJTf4kx1EEtKbAOPfMe_wMuXYoCo75YTFw>
    <xmx:nWg5aLRpw209qOJJsIevmFyrT4I9CT_YwgyLXi_RRlg7I19J6Rl2IQ>
    <xmx:nWg5aCpLuUm3InW9SmfqaA2HkagEM-suOvMO2RRRwR2sQVA8S1VjQw>
    <xmx:nWg5aBDw1Mqs0ydiDDBFcLLR3lvISElyaCo105UjE_1gN1rgDPvLbeKA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 04:13:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 270b05a6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 08:13:14 +0000 (UTC)
Date: Fri, 30 May 2025 10:13:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Fernando Gouveia Lima <fernandolimabusiness@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	stolee@gmail.com, peff@peff.net
Subject: Re: [Newcomer PATCH] log-tree.c: Supress Wsign-compare-warning
Message-ID: <aDlolSPcYTSaFGV2@pks.im>
References: <20250521202409.26879-1-fernandolimabusiness@gmail.com>
 <xmqqsekx8yef.fsf@gitster.g>
 <aDCQWr3MBX4L7sbA@pks.im>
 <xmqqy0unxo7d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0unxo7d.fsf@gitster.g>

On Fri, May 23, 2025 at 09:54:14AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > I do agree though this not a good project for newcomers, as fixing those
> > bugs is quite intricate overall. So we should definitely remove this
> > project from the microprojects page.
> 
> Yeah, that is something I am quite certain about.

I have created https://github.com/git/git.github.io/pull/779 to get rid
of this microproject now.

Patrick
