Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F5E1FFC4F
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745996894; cv=none; b=UvoPEoNTLHxbCz7d33QI0n5XJOhpoSOqHh5sLudhNSUI42Js8GVEZCuY9OzCKpFgekqipumrPl/Ra+VSEI4zeVTOM3RENGkUPopsm1xTMWlXPlAaUf5sgdrccanwGWr+j6tiOH7ICmui56LBNEf4tSz0OQNWy8m48CBOSZg3ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745996894; c=relaxed/simple;
	bh=V1krt49anlKfCEYQz2Ak3kW2TsqlHL87YRPpmcQIpDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWbAp2BvO8Y1bohTQMTexWJ5RqyKozcfPYOYJpmZCHju+VJ7ThQZOVruAJQTddSkd1KMIh48bFHBKnpj4kfSfqn+oKFLVAgb7iWSWeDCJQ2rSwGyzljPbA5MqOuWQqYjOM4QKOtzN9aSs4O5hC5Q0q/r8ardbZPfjXadsHi8Pko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iZmLfMyi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eX4d60xi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iZmLfMyi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eX4d60xi"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D0F3F114023C;
	Wed, 30 Apr 2025 03:08:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 30 Apr 2025 03:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745996889; x=1746083289; bh=J6cFNHvvhp
	X2/08IgEEc9/5FmZFvH7dOXmNSC3HSZ+Q=; b=iZmLfMyi+ab5eY1K196fDKkHBZ
	cDeioJz5oH2Cy+Iw/p30eWNcoe4XupR65YFhFctW/0hBFA73VKiOU1HkRvAfrFIr
	3OXRlx+h0e2WyMTmbNxfSdMJTMy0kDlNYBfWjuLvDXZ7iUlIbqjeUEYZwped3xaq
	syVF2Ep0wyiV7nLmCDT1z7Vh937DldGdAauEIgqJgzBy1Aq9yAJBPfjS4dsQS9GJ
	jZe6W/PCt6gcplDkvUq7yHJQ8bqpnSvV+SUh51nHhXSGG5RgSIfpNqX95VsKwofs
	Ot3keyPhYmmZLkcce/fBvv3CdmjGsZSBYk8sXfMQoFhb09PM31hMvvmGLF/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745996889; x=1746083289; bh=J6cFNHvvhpX2/08IgEEc9/5FmZFvH7dOXmN
	SC3HSZ+Q=; b=eX4d60xiIsCITw2iCRwebcfbJrOQ+yewiMqpU42JD9/0uOq4kT8
	27lfN+hbfj59StF+NwCumfVj7cfkC6DEAL0ayPR49iiQxEYNHHFMHh245slKySRM
	12IKd1XnYt6yvLitbkWq/RRCfxvsm9HEuwLLFAGRumuxkQEmnf2XytinPgAJHaP+
	qNgoFUentvWdwWRRsraLxWBKgRzDffZdg862RpkGEzPWPF/QnEtxOzqx8aEJ4clb
	hW3aGgiIYiESrHxUMQCyO1oQUHks+UBLao+GDBKGLml/4wsbz6m17gM+2Jwlgh0q
	EnyJAzTW/DhxAGg3tLHCQ8HGZJLxo0oZ30g==
X-ME-Sender: <xms:WcwRaBwd6umTD78S4E2OMdkUnzZFiPhwf4uiBRCL2pQM5pXIlUokeg>
    <xme:WcwRaBSpm1ReZ7dRnbm3IJ05yU-E9G2GRgPz__HvdoFGEWEttgen9ZmLsQynjJ-op
    hOGLc8BwG2LhH--DQ>
X-ME-Received: <xmr:WcwRaLVN_w2zxk5uQK1-fr1pHf308U8OvsyL3Jjj8tpCQUkwy48okMhh2RLUheqx5N0yc1QhnjVcIGrKD3yqkfaF6tbg-_2bNgRZkHzlRNuQew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeitdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WcwRaDggRDMdFJTuxxKB9QFEyZB22PiVDA3fcRs1cA8kGwP2EmUHfQ>
    <xmx:WcwRaDDM14h_2NXJ6nOc5BsLzGBQMnHbIT8R83iHNj07uB5EJKIpow>
    <xmx:WcwRaMKse4LhZ_B0FRqeNsyGwAqdWyloyoKf2XHRPT1kfMA4vm6Pig>
    <xmx:WcwRaCBsVJ3dq7jjX5i140JvvUo1qnjsWeJ0Rj3DmN_RmZnRfUEOsQ>
    <xmx:WcwRaKdkjzgWHVkXFQ5ehXS9Jta5WREqgAyeVpL0oTaleYVLG_FLE_uB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 03:08:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a84cd15 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 07:08:07 +0000 (UTC)
Date: Wed, 30 Apr 2025 09:08:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
Message-ID: <aBHMVm9QIKZwiaBX@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
 <3cc1ef7b-40d5-4802-9bf9-ff28824ce563@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc1ef7b-40d5-4802-9bf9-ff28824ce563@gmail.com>

On Tue, Apr 29, 2025 at 04:02:18PM -0400, Derrick Stolee wrote:
> On 4/25/2025 3:29 AM, Patrick Steinhardt wrote:
> 
> > Right now, git-maintenance(1) still executes git-gc(1). With these last
> > gaps plugged though we can in theory fully replace git-gc(1) with finer
> > grained tasks without losing any functionality. The benefit is that it
> > becomes possible for users to have finer-grained control over what
> > exactly the maintenance does.
> > 
> > This patch series doesn't do that yet, but only implements whatever is
> > needed to get there.
> 
> Thanks for putting this together. I think this is a noble goal, allowing
> users and system administrators more options to fine-tune the best ways to
> optimize their repos.
> 
> I wonder if any of these fine-grained steps would be valuable to add to
> the default background maintenance schedule (perhaps as a follow-up)?

I think so, yes. My immediate goal is to change `git maintenance run
--auto` to not run git-gc(1) by default anymore, but to instead have it
run the fine-grained steps. But we should probably at the same time also
adapt the background maintenance to use the same fine-grained tasks so
that the outcome matches.

My idea would be that we implement all of this via high-level strategies
that get honored by scheduled, auto and explicit maintenance alike. We
already have the "incremental" strategy, but there are other strategies
that might make sense to introduce. There should be at least one
strategy that achieves the same as git-gc(1) does right now, but there's
probably more opportunities here to have e.g. a "geometric" strategy.

Users can then pick whatever strategy works best for them, with us
providing a good default as well as rationale why we recommend one
strategy over another. Furthermore, expert users can of course tweak
these strategies even further by explicitly configuring which of the
fine-grained tasks should run.

Thinking ahead a bit, one might even be prompted to auto-select
strategies based on repository properties. A tiny repository likely does
not need multi-pack indices and cruft packs, but a huge behemoth like
the Chromium repository probably would benefit. But that is an iteration
that one can think about in the future.

Patrick
