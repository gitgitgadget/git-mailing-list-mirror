Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A115D5D8
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059045; cv=none; b=NO93YobordI97Qhq4sokd52sCGZZ/B792iwIqVa6/pv4tSZ3errpmy1ux+IMPWSU5DoX4bXIIZYum3iFMF7TJk5G83J3SupswnsTs1Rh9+K8tMwPBGvK7MoWVdFjYa/4QuuTpGGwfO2ezbirMItoCBN0Ywh2WTEOMOiKtKPMct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059045; c=relaxed/simple;
	bh=Dsuw87vX9zNBKUwFRZbZDFqgYjaC7l6M3y1YlDOjt00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Torl1KS5r/ElGiHDxs3ueORNxMeOIv0CNIuo9RtyvQ6AqZvZWwdGxZuVUTjN7qPH12e6rxQRSP8NJwb3rSTLA9c3hy2bpZz4UEOepabrFu5hmCwyTbMtVpiUnm3EUVy0rPe4R0OWvBG5Ol+nYiLLKznnyZyFp0yxtU+16Gg9QV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qaiy1vaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZQl6L7h; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qaiy1vaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZQl6L7h"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 183D61150836;
	Mon, 19 Aug 2024 05:17:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Aug 2024 05:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724059043; x=1724145443; bh=S2qThJ4jvA
	XehXUSZ5eH+q1moCK9mX9v4GbW4cp2mbE=; b=Qaiy1vaEuN6xVInZILR8cDXEox
	H2/lQI+f349PCRaSzn99B+brzDvFyIumNwlPulA2zUd4xYr0u6pHzyxo+FZ9KiAV
	m3NYR1/ojqevv4ramqf+pgXbdde1BdJEIWczF0YBQgkR8kR5FumA24E1tMQVXksI
	OaqxZaWRZwZeWsGfe2AuCiOjq+RzbewDYKPXA1XoOX6P/q/Jt6hROUOgNat7Kw4/
	1fme6+CPDqhUszc01V9SUtpO+8dOWIxxFge4Zuuf2kT0LY3W1COGtsNJZw8DE4Ff
	sSE5Jqx0bThs3jWDAXugY0VHbwrN3NrDOTW4C4Z5oxBbk6sOzb+MjvsiHCNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724059043; x=1724145443; bh=S2qThJ4jvAXehXUSZ5eH+q1moCK9
	mX9v4GbW4cp2mbE=; b=hZQl6L7hLuNiOzLXStweb+swJJmQRmFuYNbhRHl6B4K/
	awixBJ9ni3EYSAqtekVX8wScHUE1vM7+JYZsgbs7LKchIg51c7AZx4Mf0Pz6kAT1
	lL05c+1FhIUbwYD1SIa03XZrlWtvLIvBNGpijl2w2KRIoeLpjw/4m5f7mkd7fqcS
	dBS13OQP7Rm89DvClPB0XMDDi5CSLChxFuWnTgdtRySIuRgyJVMoz3ivcDk55RdU
	bd9V0noZYuozZhQG6dH7EYdkfVEBzu9iFJ6TpO+da0E5qsH7urJTWCU+7tJOYxHY
	QQFIQmGDg8nRfrRWRk7I9RaU8u5+q9ywqX0VhKmUQg==
X-ME-Sender: <xms:og3DZjrFSzB3McGzqR3plx2IsnsC5NSVPW0FgtNoIOLZFTB3drzWag>
    <xme:og3DZtox4wgtRd1SCvBybzicvWvxdlRkLihzbBxjR2sYFUrXa6wraMmq8sNQgagn7
    2uoOIHkS9Yfoam52A>
X-ME-Received: <xmr:og3DZgNu3t-qhua5xxg882w2AYra8pRLS65lUTbkAq-0yeZ1oUzCELvRvYCf1pFEzrO_ZEO25Lvvn3LNOmR7gR1T4JRkIts7CiiVtY_qvK88PWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:og3DZm71MnL1Au8_1LCzh_Zfkc8SPZwUFcNVnCyA-jPol2h7rSZMbA>
    <xmx:og3DZi4Y30nC_xca5KsZ9lfRXcVpaDXh-5whXlzokVh4Nd3-3aZ6Hg>
    <xmx:og3DZug7BZPM_rXN7fqtZFJJa8UDNwqRzdg47y98hqNkThRgB5qGVA>
    <xmx:og3DZk6DiilZvfm71tvnxVcbwkwGVjjMjZfskUdlst7QAkskPCrX1g>
    <xmx:ow3DZpbmRFFgAux2b6HtDk2gUFqo--94YoWpIeyHwqcG-oiTaR-48P17>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 05:17:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7251e16b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 09:16:51 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:17:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t7900: fix flaky test due to leaking background job
Message-ID: <ZsMNndPUOgKrqI4t@tanuki>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <4805bb6f6c2c96a2c40d1d8359b63b8c7045e0b6.1724053639.git.ps@pks.im>
 <20240819084943.GB2955268@coredump.intra.peff.net>
 <ZsMIa_5jCFs4OWYx@tanuki>
 <20240819091241.GA2958552@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819091241.GA2958552@coredump.intra.peff.net>

On Mon, Aug 19, 2024 at 05:12:41AM -0400, Jeff King wrote:
> On Mon, Aug 19, 2024 at 10:55:07AM +0200, Patrick Steinhardt wrote:
> 
> > > This looks correct, but should we be doing it for all of the "git
> > > maintenance" runs in that script? They're all going to kick off detached
> > > gc jobs, I think.
> > 
> > Only those that use `--detach` run in the background.
> 
> I thought since the default for maintenance.autoDetach was true, all of
> the "--auto" ones would need something similar. I notice a lot of those
> use "--task", though, so maybe that doesn't count. I'm not clear on all
> of the rules.

`maintenance.autoDetach` only influences the auto-maintenance as
executed by `run_auto_maintenance()`.

Patrick
