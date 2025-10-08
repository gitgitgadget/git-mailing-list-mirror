Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851422F0C6D
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908171; cv=none; b=j66MY5n+UxHDZ7pGVNpl8S14hhc9cGs2KOp/vdJ16ssW7p6yM74cJlI/jzCnPR5TXuttpiq2iD38r94MHnvtP2/4mXmoPo9zL3KqIc0ap3pH6CV2lu+v1+xrRwouap5x7d6y49Az0acUawVKef/aW+gzkQ/W3paChugNblBdArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908171; c=relaxed/simple;
	bh=q5tns3G/lR+eGUuAwhdmWkhZ0soA0SyOtzVJIEYPVBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ1A61VkObeszs9CuqpKojDr+iYgwyhCy/CHSLhV8yDVTdS2RaMna4Xp7j6JukeKb3xXfUVa4Gww8EyOg3zCqdpNhY+S7rlqw9rl1vUwv6jAWqxwNXWRSACw6ek4Rov1hEFowekSo79HQcqrid/IR2wfUV8UFfDrtBjJ2fi2knk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T5HQhB5u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FIjCWxvv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T5HQhB5u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FIjCWxvv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A436E1D006A1;
	Wed,  8 Oct 2025 03:22:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 03:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759908168; x=1759994568; bh=0HyBowrqWE
	QBBudANd4OFCbKAAkkjcmcrxq/LkSW2Lc=; b=T5HQhB5uy+LOjnTaD1dJg6nCOU
	iugsK9Wt49M1Xe/dC2zKqWTzY8waDPR9BCnDxfxMmGH1hvKSpNgQbTze9JQaDq1O
	eiM77Z0TUNSiINU6txTBan0t7megBCG3B4mxmkxB1PFsxJco2GVzvChuUfmiKeEg
	OV0k7OtY0LIyKmq1oTDfe7V7rnNdKIBoBy2fSgEnU0Rzoa9vvYLE4EP/BU5ZwesA
	AAasqEyaT5C5AJhY59GV5yDsyfNApDhwYzYks/Oocuh1Fo585U7fc5lCHzA/iFsS
	FXyTD01lNBJrCtrBA3niiyUHoy4AJkw2jOfFX7hZiyk8QC6H37ozlxaKMGHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759908168; x=1759994568; bh=0HyBowrqWEQBBudANd4OFCbKAAkkjcmcrxq
	/LkSW2Lc=; b=FIjCWxvv6DH4bkc5BadprU/Sh+yan7Rfie4NlhOshOVtaR1b1JX
	R3kWqIFkx6qc5pB+8FZcywmB1uDUh9CwNh8B2QF0HhqYWdXrDathK0AYCG34Nuak
	V+dvSh2e24eyi433v/Xg/ptW5EYOmqHzhkiC+XXH8AgGzXAdXXF81m80tcZOsGZU
	MZvaho+/liDhYP2vjPN2TvaO0MyhH1EvlrU+9/bTh+iPtnGdh1YOu0tixFfbPVsk
	pXFiff8eF8CMgXIKb1Eq4ZN0IjLQP3M/r2WfRniEwKGhuluKQFkxiFJ6ARSFPwjU
	J8bnoq088GToFi/H99P1nIVaa4kIZjPsPHw==
X-ME-Sender: <xms:SBHmaGI0Vmq6MunKvz6gCZT4zjb8iHZvEUV1X__B0SPjotQycXxvqQ>
    <xme:SBHmaFIaS2MN1Q3rGOEBgp2ZUZx29RSUoQjItnJqffpFecm7CC-i-14tUJFAme_5x
    5wkB1PFLgdBEbn60zXNNsgmVThDd9d52DiCZsoP7YjpTTtSQAnFrw>
X-ME-Received: <xmr:SBHmaLvuIY5LVlH4qC7Zu3ox44EPPgPMox6bpmKxUw_8XIzlT5pySauyE4W9_jBPnADKRzxJdusNcKb96jdoalZ8SZO8tDoKh9sNfuGJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:SBHmaKS1chgjwwBMW53meQTavmvWALRrqWm-4EAgFKdjXqlBCqMLrQ>
    <xmx:SBHmaJPkedB86icKZmfnbflgnttUCw7GQUiNEzgZX6qNfW10sbo6uQ>
    <xmx:SBHmaHayXMcMqJ8tfGQJlKRpVTHicQDzucsEzE7i-SkPoaELHqqEFA>
    <xmx:SBHmaLwTgYviKtLMxKDJYMNQC9kYUeujDlpGsOCP6df-BkglxBi7vQ>
    <xmx:SBHmaLOsYXMJT5jC5b0P6GBvzj5xnKHiGs5w0imTlBlel5fl8FS0I3d->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 03:22:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0d02115 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 07:22:46 +0000 (UTC)
Date: Wed, 8 Oct 2025 09:22:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 0/2] Makefile update libgit.a: Include xdiff and
 reftable in libgit.a
Message-ID: <aOYRQoDx599G19t1@pks.im>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
 <pull.2065.v2.git.git.1759447647.gitgitgadget@gmail.com>
 <xmqqbjmoueaq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjmoueaq.fsf@gitster.g>

On Fri, Oct 03, 2025 at 09:43:09AM -0700, Junio C Hamano wrote:
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Changes in v2:
> >
> >  * Add xdiff and reftable objects directly to LIB_OBJS.
> >  * Explain why xdiff-objs is removed.
> 
> Both changes look sensible.  Will queue.  Thanks.

Agreed, this version looks good to me. Thanks!

Patrick
