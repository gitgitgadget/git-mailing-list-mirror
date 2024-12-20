Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39A219A63
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713818; cv=none; b=PWdqRHVOW5cU7Hlr+O9HYQA7tfxdiP15fTk1LjROsX9iyNPr4fcfkTErZ4ZDyQBRyenI5tj0Mkx6as7jPiWkYO8eKZNgIp1aM19rC6va5cjvRJNvtUMxdbcfYOnVIGLP7VNJM8Go2Mjgg6fOhd7dstehFOUzT6/wVwQ/oA/lV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713818; c=relaxed/simple;
	bh=u2R28s6nVWTVrAM5kV51Rhz14ptPtNSCqZvC+oeBUWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8xyzZpaU9PxdRJ8mFci4V6AYe+hLQM01kVI4zpr/9XtCt7ZsU3p4Gb/tu9Mtb509lEtZpsDkDUGVRjJwYuDu4sD4rLjCxhLkul3nnUmsypjLD1v4w0J9gIEU2L0f1+P7aSQDN8KrGjzMYLmW/9ktJZRKQWM1XcI9yO/d7TpapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fDLcz95z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOdp9Ua0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fDLcz95z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOdp9Ua0"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9857F1140225;
	Fri, 20 Dec 2024 11:48:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Dec 2024 11:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734713335; x=1734799735; bh=LYt5Pz6Gdq
	ILwtxqycsOOnlHYjmU1RnArZ0y6pap8dk=; b=fDLcz95zrc/DBJRvFjcXn2fkE9
	YJWlh67h5F6Ve2TOG2lhQgeo8tXgDaQD04+hrHVfa40ufYPHxUKC3Db5yEO+hZtK
	e9nC0BVsXesxHk8Q5p8CIb6knA7mUmUIuXwdadhqDAlJAQXuUa+2dY2oVSx31xgV
	+sXCOXtoJwGi+mz3IrSjI9GIuT2CyO5y8quvE15AioT0W9+G6ix/IcDSAQBUTsM7
	Hrs4QLI49qM+oLTxyITW8tkFVUG0kYcSsotMimniOxkY/tUxarrsMw0VPnuUcABL
	1bu9ssCAm4TeUDOtqJzBN0lmKjj7Q544HEn9KqCprm04+aj/VQozvqAImM1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734713335; x=1734799735; bh=LYt5Pz6GdqILwtxqycsOOnlHYjmU1RnArZ0
	y6pap8dk=; b=iOdp9Ua0qnwPp/ZtdKbwmaBeHJBxF/9/cAtXyuExd8NADJzQPoY
	trlSf10g69MdHqhxaJYI0nIscWh5RT5p/qM+h/j5NhVCF5sr/3TgjLy75P3JnX7+
	y1OVcfM5XA8Z5U1d5MwsBDq28O9FC3SDV8b6vPJ8AeqjIHq9YaFnjnOnBHe4VJxG
	xSsIJdIYLDq4ErFxPfeh2mt8olrwR6wqp34aGeK4LrSr9IhHJFOS7Qx/2fIXWP2m
	/iN2w9mtDOF5f/avkVoZQMqfHWWuqe3bEYhFXYoHxyRlejiiltg7Q8ObjhbuUu/r
	87ONzafqq7ObVnP3VxxWO91Kmk9Yj+0v6Zw==
X-ME-Sender: <xms:959lZ_V0wb5hTWVjxHuKxMvT1D8ZbbYyXeKcLTI3HigZx6VdtCMnmA>
    <xme:959lZ3kGRZdBm2s09ahY7hYQg-NBPymmpH5rdfHYklL206E4pnEMls_j2AaSSzIb_
    NkIdcqCtU1M_maCVw>
X-ME-Received: <xmr:959lZ7bPIEnrpUpl6bzWWtQHwr-A3lu7q0NwaQjryP_SWgf1u8yN6EzEs9DFyMks3qd3hDpYBjYz0MNgkb2mQcLA9_IGnVNvOlMf_cBcHzqeiCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelueefudelud
    etgeeiudeludelhfegtedvveelveelkeehgffhheegtedvvdfgueenucffohhmrghinhep
    rhgsrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:959lZ6VgQTIhwwuF4L1qWQYkR0T8LKUFvM4I7zhjdIpbCriMex-mmA>
    <xmx:959lZ5koCo1HVWZtMlxHhJNwrvXt_hlIlO2-b4fhnTDfGF8te8n5bQ>
    <xmx:959lZ3dbv8lNnt1vQEbLLtaQt6CWLgpxXwXC9KtS-3CXCcH_kccieA>
    <xmx:959lZzFt-MiZTbZ6vgU1m6Fsm1mcN1RpPywZSboH1U1X78mvkXBfRA>
    <xmx:959lZyAR3r_-Gx-r7Iac8GlBouyjP7HLz-pqtRalMlzmGHYJVA1qsDeB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 11:48:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4dcbaf8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 16:46:58 +0000 (UTC)
Date: Fri, 20 Dec 2024 17:47:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Message-ID: <Z2WfirfrpYYFgYdw@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
 <20241220155433.GC152570@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220155433.GC152570@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 10:54:33AM -0500, Jeff King wrote:
> On Fri, Dec 20, 2024 at 01:22:48PM +0100, Patrick Steinhardt wrote:
> 
> > In preceding commits we fixed that build info set via e.g. `make
> > GIT_VERSION=foo` didn't get propagated to GIT-VERSION-GEN. Similarly
> > though, setting build info via "config.mak" does not work anymore either
> > because the variables are only declared as Makefile variables and thus
> > aren't accessible by the script.
> > 
> > Fix the issue by exporting those variables via "shared.mak". This also
> > allows us to deduplicate the export of GIT_USER_AGENT.
> 
> This looks good. It fixes the issue, and I am happy that:
> 
> >  asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
> > -	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
> > +	$(QUIET_GEN)$(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
> 
> ...these spots get even simpler.

Meh. I just noticed that this doesn't work: we include GIT-VERSION-FILE
and export its value, and consequently any subsequent invocation of
GIT-VERSION-GEN will continue to use the value that we have in
GIT-VERSION-FILE. So it's effectively only computed the first time.

This would all be much simpler if we didn't include the file in the
first place. In Documentation/Makefile we don't indeed use it anymore.
But in the top-level Makefile we do use it to generate the name of a
couple of archives. I'll have a look there.

Patrick
