Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB92D5951
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501368; cv=none; b=b8QRwhKuo/AnkzDD7onJGnRK/f42t3OFLGc29XhjgNP+KytVOxfjmnQE4i497qhKSH5L8Cl5gwohRvR3LHPPrk82g9mLxNdoT8DjJgmM0VGVduQJvEbBxSVICL9ijAUXMBm/nvusGWhkrvxvC6jq01kgimh92yezhhIIwXHEX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501368; c=relaxed/simple;
	bh=HagHysg3iNxqfJe9hLSsEVvU8GF0P3WHZacTVbHONI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjyfNazkIofsEvEU2O03d0juRhFcjyMFv6mHsInwHHSqQpjkSWm7YXa6s1izlKsL23EB9iPa3+MhKjoC2a/qVl+Lp+cdMhZOH0EaGxp1iru1bD/MnLMgJ/EgkItHjaHagmFH+XHjMangpgp8LeJH9cK8XC97RpRLUySUHseRu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BAq4qgWz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOeys3q9; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BAq4qgWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOeys3q9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7773D1D001E9;
	Wed, 10 Sep 2025 06:49:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Sep 2025 06:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757501364; x=1757587764; bh=9TFU41K2AI
	oHxQMTQjVFywNkVwWT7W2Rmzr13lwPBJ8=; b=BAq4qgWz5pcdE5yU78dHLWGrPV
	AzRMASCxt7j8yhJ1idIiw9ahMe6kpRuSrEUOrW1mz4NuqKuFhGcomZwCoBr3ujMU
	3uQthDskgi/bfU+ScWpGeysWme++tDFb1HIbfzFQxKwwrK1hoY8bD4EkAtb3jCmf
	7f8a4yI7FDTagii8XCQydQb0l9++OjDe9bvuM+sbEBqNsXKEXIBISpvbkfudoltI
	o++sDp/SwvJDRQONbVVg0ht9lrWSAiNWHR4o42Fr2pbatBAmi25Mps66sTsg4ENu
	DVcF9IHUj7SuPN0ZYPEMD6JyTayrntBcb1Ffo0qcpLRtUqbnXd7vdlhzoOVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757501364; x=1757587764; bh=9TFU41K2AIoHxQMTQjVFywNkVwWT7W2Rmzr
	13lwPBJ8=; b=gOeys3q9QQlN8Y23by647jNkAvUdYEvwW05V087p0mfBZ9IO7gh
	sFBbQjojUHBG9zuu6kcLcTG1fORup7Vy9HH5x5/4CfkRdZMRs9GleZ93tmKkdbSm
	aWbWvtxO8mbx3IGIapR70n98YtZ0z+UD2n8MWe2l370Lb8lRaXAgjxM+cfG3Q+7B
	KxW4SfS1bbd0wVO1xEYMNnmYmotefuKdZKsNJT+Pzfudm5ptCCBOCFmChXdlOn7M
	Dhu2IzbIFuTbxImm9JglLkdXWtZN860PttW2QhmSF02as/XB/Va6cmI/xBNmuHFa
	njFghXOLIYFr9lEN5dDJpkTrFstssOOALGA==
X-ME-Sender: <xms:slfBaMGhu0OGX7pTUJWCo0MuuHXBeAvzJ4l2IUvf-WFlrTKvIY8XEA>
    <xme:slfBaBLl6ZIqmMbo_hy-LIsrDtjIN2lqKc20Ys9sovz25hdb3tvWbhNVKrcz-_VJq
    ByoQZ6cIAkqHIqLpw>
X-ME-Received: <xmr:slfBaMnYY5WMOzB7BvN7DhjUK2ZWPm8HFPQyfunpmYi4eV_fTyWwYRjgGSGzb4cT00ZN44ZpEXGxcoGsXTAhQRDaTKm4ppbgofs9uB4cqEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughu
    nhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvih
    hsrdhmvg
X-ME-Proxy: <xmx:slfBaKzovgue5ZWpkWJgtAgwKgqu2AjneCGYqq5PP5ZkvpRiPeyTnw>
    <xmx:slfBaGsMjl-sFQy5anss-I2uVE036WiGiguf8R-8bIKcFcYV3t9qeQ>
    <xmx:slfBaMHbKuyePHeSgVS2I8p9sh4dMHdq6BleLuB1zq2XuaPFpEGMMw>
    <xmx:slfBaM7GLFp7AwCmYu5DJFfFPua7PGOA2TqaUPTcsQvNav_TJFBENw>
    <xmx:tFfBaB2K4_3FeWeeF7y6aYothB_DHlfD36iRJh6c-HdL_-aOZcPk-Jx9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 06:49:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad14bd4c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 10:49:18 +0000 (UTC)
Date: Wed, 10 Sep 2025 12:49:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
Message-ID: <aMFXqww91uxp_xCk@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com>
 <aLrzqR2Z9jz5CuJu@pks.im>
 <7c25d5a6-1b34-485e-93f9-25bbe37d5bd4@gmail.com>
 <aME1Bfv-IPq0zRG5@pks.im>
 <740cf3c1-2d82-4675-ab22-80d1f362395e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <740cf3c1-2d82-4675-ab22-80d1f362395e@gmail.com>

On Wed, Sep 10, 2025 at 10:32:02AM +0100, Phillip Wood wrote:
> On 10/09/2025 09:21, Patrick Steinhardt wrote:
> > On Tue, Sep 09, 2025 at 10:12:39AM +0100, Phillip Wood wrote:
> > > On 05/09/2025 15:28, Patrick Steinhardt wrote:
> > > > 
> > > > I have a plan layed out in the BreakingChanges document that mentions
> > > > how I'm proposing to do the transition:
> > > > 
> > > >     1. We introduce it with auto-detection for Meson and default-disabled
> > > >        for our Makefile in Git 2.52.
> > > 
> > > I'm not sure how much this helps us. You've said elsewhere that you don't
> > > want to be inundated with bug reports which is fair enough, but I'm fairly
> > > skeptical that we're going to get enough people enabling this get a useful
> > > amount of early feedback. So I wonder if it would be better just to bite the
> > > bullet and enable it by default from the start. I think I saw Elijah making
> > > a similar argument elsewhere in this thread.
> > 
> > The patch series may not be ready for all platforms yet though. Windows
> > support is still untested and probably not working, so I first need to
> > get that done. This is basically the reason why I'm proposing to have it
> > auto-detected at first: I want to be able to iterate without breaking
> > any platforms yet.
> > 
> > How about we do a compromise: we initially introduce it
> > default-disabled, but default-enable it in the next release already
> > instead of first tying it to `-Dbreaking_changes=true`? That would
> > accelerate the proposed timeline a bit.
> 
> If we really can't get the windows support working before the next release
> then making it disabled by default on that platform makes sense and in that
> case it is probably simpler to make the default the same across all
> platforms. It would be nice to get the windows side working, I had assumed
> that would be fairly easy because the patches exist in Ezekiel's series but
> maybe I'm missing something. I'm also hopeless at keeping track of when the
> next release is so maybe there isn't much time.

Oh, it's probably not going to be hard, and yes, I'll pick the patches
from Ezekiel's series in the follow-up.

My intention here is to focus more on the overall roadmap in this patch
series though, so I'm trying to keep it as simple as possible initially.
Agreeing on the roadmap is the more important thing, and seeing that we
talk about a timeline that is going to stretch across at least a year I
don't see a reason why we would need to rush making this opt-out rather
than opt-in.

One step at a time :)

Patrick
