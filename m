Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82B1AC8AB
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720276; cv=none; b=TbdPp2rbqN8Mi/vGVljSqgfxqlTFZCnXaQHe+P7+0KoFHZTFtNKE7AKlz3fMKbNPZaJYxGY78Qr/TBM2WRN1Hzbmh6cvuC+9yaQHrVgoa4QpQ6ck1YwoCuH9YyvL1hRnrRIeURx+mS+u+rlRTW6CEakyvnWF3ClEPzhtJsw8Yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720276; c=relaxed/simple;
	bh=0e66WbNnhPq27GOSZi8YsHpW2aSKzOopsG+c5YTLApY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWcI6v8dyQR8IcxG98TFWcDqOzuMddxWXjm0BAtVuxcknPYT1YtkKhE2JRWUg10ZFbl8OC+tdCAHtXtGEoEVM74n9lqwuZBzw19fDPbs+GQ4UzxvqBwuBOVePRTEWsBtv9nDFrNjAXA+lF/S94BrThs1KssHT6FHufIbwnaHPws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xc85xMzf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QtYkzMJy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xc85xMzf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QtYkzMJy"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id CDA24138FFDF;
	Thu, 15 Aug 2024 04:18:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 15 Aug 2024 04:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723709882; x=1723796282; bh=8m69pU82ON
	1NkTCvyEIFnzFZ14d4LenmXfxHzZLIZ/w=; b=Xc85xMzf8raMc8/a9GxSE1aLAp
	7YrU54WOEkXDi0nDUew3X0WRcTHVVtHQQOgYnkqz3zw9v4fr2ZVwAZMN+fad9vTB
	dIs3OVVlTa854aAfd7AYkhE2kYNeFfdqDZmQc6QWOTdRHDvt3qKpKZhn3LHFEzoR
	fScP1ms69Dn/NQ5pV7lEB0ihkPTxtKrnqk7uI3CdTyzKvvR/gjBXy0qVkI3iSRzX
	jcXUi/3aagd9tR+J31vIf1ciJYXqrofU3l48ZhdHLhUoIrfyTdhbBYooSOcpJYUb
	dtijQW5u/nu6hNmn5FayHajMxqs/2Tl4XNX2HFxFSLJ5oFs+Jg2V0opHyU+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723709882; x=1723796282; bh=8m69pU82ON1NkTCvyEIFnzFZ14d4
	LenmXfxHzZLIZ/w=; b=QtYkzMJyWRLkIX9izZTf7+5lTByXL0OktgRlAAjstJB+
	rIjXPdlhI89FvIfUJ+4Eh/JIDGUTP8aNXaXkbJfgjdJDubCAgzDcS5N3EfIFCzJg
	wMgIkAPbAIrpxlfI22wP2juNuZNtLjTKBG3/DI4CUNhUgdm2FUAB1QFw2KSbrlos
	2wywCsZ3poYtOIZZRxli0TYXtuFOGFUmeq7siXRVg/jEK9ANI6AwF0/8i6XeWUfK
	GtFcEBRgOZNFQ5MJqgv0IHAKVuD8pIAwRxKcAzoTCh4qiNO+w4GcWH9YyE7iYCi+
	6ofJDuzmY1Dr0zKmo+BorKfbIVfUMM3JhqCvZOIjlQ==
X-ME-Sender: <xms:urm9ZjFBce0HBQwNkwsB6hphMsonscdjeW1ghLeaQvBMBPGUXGNvhQ>
    <xme:urm9ZgXk7LgAUYjYOuJ_fz1DDxNk0SEVc4xzVw1qaEjWLWlbZhdOFfatn2scq3d8o
    9ai9EsxPPTKaPQszA>
X-ME-Received: <xmr:urm9ZlLstRPPWGGhbx96LZCVdql5JH3PLp_gnoJjtdWslhwHjnh60jvxKKsfhX16PJTJiAYCot4oKrH-My1BlJMisFcZ0wRpYjQRJQajY0mEYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:urm9ZhG3QhPok71nKgvMdUWVkkPtG3yuzk9YTakJ4an1Pko1X4vkbw>
    <xmx:urm9ZpX80OGlFtaM3LSrr7ZD1wZUkwrZsrJ9XsEWY62IYYdLUMR6gg>
    <xmx:urm9ZsMFLHnvATIQiYkXlSjxGgZFmwJ8s-0qUY1xDdVDi1WWKa7XLQ>
    <xmx:urm9Zo03TQFgNUs3_yn7skxh5yBE5qvSH__vZtH_0sX5F1SlKAvHGw>
    <xmx:urm9ZmgnJbJC_ATjmWfJAyuB6bCSnsjdgjMwOhzVfnsxaLjZWTmDH4sp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:18:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 313b8f1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 08:17:40 +0000 (UTC)
Date: Thu, 15 Aug 2024 10:17:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
Message-ID: <Zr25t1S-srZOShLC@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
 <D3GA39J7D5UW.KCFXXN036OD@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3GA39J7D5UW.KCFXXN036OD@jamesliu.io>

On Thu, Aug 15, 2024 at 04:40:51PM +1000, James Liu wrote:
> On Tue Aug 13, 2024 at 5:18 PM AEST, Patrick Steinhardt wrote:
> > diff --git a/run-command.c b/run-command.c
> > index 45ba544932..94f2f3079f 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1808,16 +1808,26 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
> >  
> >  int prepare_auto_maintenance(int quiet, struct child_process *maint)
> >  {
> > -	int enabled;
> > +	int enabled, auto_detach;
> >  
> >  	if (!git_config_get_bool("maintenance.auto", &enabled) &&
> >  	    !enabled)
> >  		return 0;
> >  
> > +	/*
> > +	 * When `maintenance.autoDetach` isn't set, then we fall back to
> > +	 * honoring `gc.autoDetach`. This is somewhat weird, but required to
> > +	 * retain behaviour from when we used to run git-gc(1) here.
> > +	 */
> > +	if (git_config_get_bool("maintenance.autodetach", &auto_detach) &&
> > +	    git_config_get_bool("gc.autodetach", &auto_detach))
> > +		auto_detach = 1;
> > +
> 
> Do the two `*.autodetach` values need to be camel-cased or does it not
> matter? I've noticed a mix of both through the codebase so I suppose
> it's not case-sensitive.

Config keys are case-insensitive in general, and as far as I am aware we
typically use the all-lowercase variant when retrieving config keys. On
the other hand, in our docs we spell the config keys camel-cased to help
the user make sense of it.

Patrick
