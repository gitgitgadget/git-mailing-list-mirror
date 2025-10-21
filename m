Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2961274FFE
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047024; cv=none; b=jQdDTNFcj6uRjxtaYgFTaocB+lYS441WPJw0UDV4WJxGzHWrCdz7R8toD2LSBd8/zcCKy+Do9qRmV0bFPlcl6s+VXXuKvJSJ+xMT2xXRB1yV5ga9XrssLfwSfkIlNePb73T7zp2YYpDO6wd0Fmn67PISx9UVIW551i0zGo0JABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047024; c=relaxed/simple;
	bh=77UcJa8bQkmohszxAVVU604yU3sBKVDc8FFoQAZzWHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN2lL3osw/PCLKCJn9pwsCyoU/R4UXsoLs7ks2v+huX3U5u/F9f9k0NmQHMF8kRbkZQ5TKYklbvoUAoouE3i5jsfOl6/T4LPBxn5fgpU+Zth/vLrNxmvFl5l338lRvArZa3PB0csuLr2GTxpKXhAPr20Fbqqoiw7p9sTm8oJ7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=boJTUEt7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=scB9mcLs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="boJTUEt7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="scB9mcLs"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id AFEB1EC00FB;
	Tue, 21 Oct 2025 07:43:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 21 Oct 2025 07:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761047020; x=1761133420; bh=qHk78F68JJ
	jnwB2vFsSRwTHUwRKP8g2+HBXkcJmkRQg=; b=boJTUEt78V+RIEnH0iYWn1Kmif
	J38DpVmhrJUe6bnBPr+zAhcxSr/BfRcalT+nx81FSs0Trj9Chz/FgFsDi/A8SvPc
	RFblwlQs00DhhE6dJsb/997OOQM5MO5yRjrM/nR+1ChQ3vQxRUevBCe03qnrvkww
	XjFARUqCZwCOgPLHYeMp/Q/7IpC3zmwxjUST0r3WggYNspX13OPVFTMtDJRcgw/t
	fAu/xQd0kRo4U80CdW8FlVy+W84ysBREC+R6TlfiHcaxChzXN7eh9H09fANP/xpH
	hqLwzWjDkBZE86Od5ntIZXxgStq4R+PYMocx1qaPdJRByOtv8pWpfU1fAEyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761047020; x=1761133420; bh=qHk78F68JJjnwB2vFsSRwTHUwRKP8g2+HBX
	kcJmkRQg=; b=scB9mcLsST6b0CemLpv/Npv32WVDq9bQoiESiMubWLL5g0qWLY3
	0zfLOrVKZSHuUg6Dbo3BndiWF1aKxFGprZ5PCfqp/VX6WSBPxxTkYUSBURioSXZV
	KjNl7zvGugrF7y96czpqtQxN3CrAYLa+66evFeT1zBebVMeWpgPwnGlw72WSCDzR
	dRrBbVreBd2VR6U1a7e+1E+cNjmfjEnRzxvaL6pjSQJolAavfaDYNSSVfn2C5Np2
	dw1TqW5coo2UJ8Fy/MUYDAbywbNvKtMrd0p0yXLvR19ympRkkYA/nviJDSmOHqVn
	mj0hFeEs5GtuKmOr70YHKyISfAHt1HcmY1A==
X-ME-Sender: <xms:7HH3aG5aecTV1LJxyOxPYqCX50opbfnQyF5whrOoB3nxM8vvgdRmsA>
    <xme:7HH3aCc1BqPRIG8U7ScDnX5cN86Z-sts3j8Pj5Xjtu8cBSm840tr0Po1F9bfoBZu5
    kIQu2pR3OUgiSp4x4wMVLs4mlQAQ2Bq6jMq4B-PfCE_LezsTX84JQ>
X-ME-Received: <xmr:7HH3aJGAd1Z5JdmMy2BrLdb1b_xD-JJHf44sKfSyP1wU7g4dP-o4eH78xozPZylLa68dI3I145Op0N0zP9M1WieneeGiMoZH0DYEfZUVfjvzJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhrghgrnhho
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:7HH3aDS5nH-YfeFB7J-TejSKDbHy2CB-jCQLTIltYj0zTE1phNl8jA>
    <xmx:7HH3aPbCj3krwg4fgnVN1xOVCF8gxdwXB3U_pZg9igGrARuOMkdvgw>
    <xmx:7HH3aO28yAurz3dyGf4TwhBTUuh5FUFaQG5I8NKW53wurd6bzqLj4w>
    <xmx:7HH3aCpbuNfkMeEB7tDIfAPWA6cyQfXAMlveAJi8kU_3aWr9yttSqQ>
    <xmx:7HH3aA2BVzZeVRsuydkE9McMjTjtpGfyuqYlzwNbW6cHm8BD4nCQVFRg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 07:43:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ee215fb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 11:43:37 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:43:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 01/12] wt-status: provide function to expose status
 for trees
Message-ID: <aPdx5heE7blfnX3e@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-1-8e61ddb86317@pks.im>
 <CAOLa=ZTUDOYb1KVUEZY4KFyoaP-PdXjBvUto0vxOtYanEjoOFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTUDOYb1KVUEZY4KFyoaP-PdXjBvUto0vxOtYanEjoOFA@mail.gmail.com>

On Tue, Oct 14, 2025 at 04:49:14AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/wt-status.c b/wt-status.c
> > index 8ffe6d3988..b66edbfca6 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -612,6 +612,30 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
> >  	}
> >  }
> >
> > +void wt_status_collect_changes_trees(struct wt_status *s,
> > +				     const struct object_id *old_treeish,
> > +				     const struct object_id *new_treeish)
> > +{
> 
> So, my understanding here is that we want to diff two trees
> `old_treeish` and `new_treeish` and then finally store the status change
> in `wt_status`

Exactly.

> > +	struct diff_options opts = { 0 };
> > +
> > +	repo_diff_setup(s->repo, &opts);
> > +	opts.output_format = DIFF_FORMAT_CALLBACK;
> > +	opts.format_callback = wt_status_collect_updated_cb;
> > +	opts.format_callback_data = s;
> > +	opts.detect_rename = s->detect_rename >= 0 ? s->detect_rename : opts.detect_rename;
> > +	opts.rename_limit = s->rename_limit >= 0 ? s->rename_limit : opts.rename_limit;
> > +	opts.rename_score = s->rename_score >= 0 ? s->rename_score : opts.rename_score;
> 
> Curious, why do we need a '>= 0' check here?

I'm mostly just mirroring the same behaviour that we already have in
`wt_status_collect_chanegs_worktree()`.

Patrick
