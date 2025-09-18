Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102872749DC
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174582; cv=none; b=Lr/F5NrZCw3H6h9sZtSAwPFQ9QKxlHWN8GgIbotNhBiaVUUBrEoVETy/j+V7WDpti7VdlgjCRFrDJyAWfXsaMBSsRoSCNpeV0EZH/qHkvz2B6RwHzX0wqev3nAeonxkcKwHpJJ8AwyKFQSfBrzRmmeKJcNMp9tuBgh8wHnjlZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174582; c=relaxed/simple;
	bh=BwpRBZkm/NdY/PGW2F48Wf+5iZTI1gRUg+Z6bUGkZaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iihgfi+CxHx7buRFuOzRbWjQdo5lRGN1i2mbAy/kJasKIC8V6RG7yMLTWxX8uRRtO1v6/fj7yqCARro0DR7io1jbAHrwICnrkdq9isuKJU0xLmgkkl+g8ntdN2a35RJZ1VnWKL62nLggesNtvqzCfowL6S9gQJMWgYmWSahBvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IwLSlq5R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xgcgsn2z; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IwLSlq5R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xgcgsn2z"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B9F2BEC0376;
	Thu, 18 Sep 2025 01:49:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 18 Sep 2025 01:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758174578; x=1758260978; bh=y4zsP+pBqq
	X1vy/qQ35wu8hCJszEXp6JDTtNLh53HVk=; b=IwLSlq5RVQ7f5dL4ZhrL42Iiv+
	I6HzZbSkaUPQVQmZRVdnWD0dCPdqNLKuCkaqsCqwEtAqoc1hXTxgVjwiGfXob4iq
	ZnRP/uzspycIVZZsR84qRR8PgVYBGdb/cdAOEThRqy8CHuQ/5m+Z+DQ+bMn4ZEa/
	diWU3gE1DEWROv/UJFUOG0DrqUJYxG7Y9xHQFfzkFdZIDcoibSMEnYg5z0Sq3DQk
	9ky4sCPpmuFGk4ynO51/iYti5vUQPpxV8kVFVjmcMgymCCyNtBDvxFGLg/IjMEn8
	vQ2atxI1+iUl/EO+8sl++N6vBrRar50GDCfbuym3S6hx3LYyUJqhVWCuDkdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758174578; x=1758260978; bh=y4zsP+pBqqX1vy/qQ35wu8hCJszEXp6JDTt
	NLh53HVk=; b=Xgcgsn2zHdfLsjSQC/4O89DQzbL9pZAzm5R1pYPvKYVp+NXxJ64
	DZEep4nkrjlJmpAxxj6+PfNI4oidZT04uzjmi6dGtDUSpHRXtXbul9Ta3zQMrlya
	ja7NmnOMb+MVSbQAByCma6rRQ/5Oq1VWaW3+7At28i7G6fE0mAugY6hgTpo0AoVy
	zhn7xLrEcsnb+wcxcPeR8lYyR/gaif19SCokSKS3a/KiEgjTlzThQ6WuKy0AsXNA
	ktQ27TY1zt8keJ9iYRtMh7zdK4ANTLDSZTZT0fN8QZLOS4fXwnIs0q/3KfeJCch4
	OlUca1DRFmq4Ha6VHsax2JTCgTg56+TkXZw==
X-ME-Sender: <xms:cZ3LaJCcmqSWCkJSaLD1if-8nRBpQEmGuZf1Tfek0D9xiV7UyBqLCA>
    <xme:cZ3LaKwRvGd-CQ3z7vwgs9L1iRTJixzon1HUwGAq9MEQTGY6_Yuwark2KeKTgedyC
    d709PUcTOPInrgQcg>
X-ME-Received: <xmr:cZ3LaOCRTn7qgqTvPfXHzYISsDGzZnMvckCu6vKC7TNwgtQu40cSgJgFwgERD34-elfWxu8U_v6_IDwwRI9Of-C1cpZVTG2RXynOPRxDDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvedugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cZ3LaPbXZIPNl_SxxizqS5iiaRFzEUuXM4HfWzYKHNtPesHYc1_Epg>
    <xmx:cp3LaOh4UAH-_458ZufoK8tuiKCAieRvQtPfif9kgnhDgYUpaQw2Tw>
    <xmx:cp3LaJ70lu8AKEybuOdgtmHe-BVE2FC8T7oV-ky_kphxBhROYwWl0w>
    <xmx:cp3LaN7b4ovLhva6UZbXqlTJYe9KOKJO6x65vinCQPUJfrFt0SHs1w>
    <xmx:cp3LaCBCV4-UEDoyWNt0BGeCGHykEp7H97X4AQbL9ZpwtTGPm9Df9O68>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 01:49:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b1eaf17 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 05:49:35 +0000 (UTC)
Date: Thu, 18 Sep 2025 07:49:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] combine-diff: don't override recursive flag in
 diff_tree_combined()
Message-ID: <aMuda6sqEiwxxAgp@pks.im>
References: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
 <aMkNiC_s-Dt4iRPp@pks.im>
 <87ecs6o21e.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecs6o21e.fsf@iotcl.com>

On Tue, Sep 16, 2025 at 05:22:21PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Do we know to set `diffopt.flags.recursive` in that case already,
> > or do we handle recursion manually in that case?
> 
> git-last-modified sets that flag when `-r` or `--recursive` is given.
> That flag is passed down to diff_tree_combined(), which reuses that
> value (and no longer overrided it). Does that answer your question?

Yup, it does.

> >> diff --git a/combine-diff.c b/combine-diff.c
> >> index 3878faabe7bb2f7c80cffbf3add6123f17960627..305414efdf436d53fee8d79aa4219f6a4dd3445e 100644
> >> --- a/combine-diff.c
> >> +++ b/combine-diff.c
> >> @@ -1515,7 +1515,6 @@ void diff_tree_combined(const struct object_id *oid,
> >>  
> >>  	diffopts = *opt;
> >>  	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
> >> -	diffopts.flags.recursive = 1;
> >>  	diffopts.flags.allow_external = 0;
> >>  
> >>  	/* find set of paths that everybody touches
> >
> > With the above I'm a bit worried that we're changing behaviour for
> > direct or indirect callers without noticing. Our tests may not detect
> > any regressions, but that doesn't really prove that there is none.
> 
> As I've been trying to explain in the first version[1] of my patch, I
> would say my change fixes a bug. Agreed, it's an ancient old bug, I
> still consider it a bug. I think in practice no one will notice this
> change in behaviour, because otherwise they would have complained about
> the buggy behaviour.
> 
> For the callsites we didn't address, I'm doubtful anyone will notice a
> change. Also, as I'm laying out above, we only see a bug in rare edge
> cases. That's also why we don't see any test failures.
> 
> So yes, there might be a change in behaviour, but it will be correct and
> barely anyone will notice.
> 
> Unfortunately I don't have any data to prove this.

The old code certainly feels fishy, that much I can say. Other than that
I'm not knowledgeable enough in this code area to have an informed
opinion. The old mailing list thread [1] doesn't surface any useful
info, either.

Patrick

[1]: https://lore.kernel.org/git/7vwtgqas0y.fsf@assigned-by-dhcp.cox.net/
