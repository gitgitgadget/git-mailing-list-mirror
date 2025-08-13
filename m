Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA502D4B68
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068802; cv=none; b=mhwOkLSVje6U2mt6s6/gnpDAKw85zNVA9hYr3Urh0aABvg7WMGIoQAfxZgAbom4KzJh4TaT0CGooK7VkD+iDglEAdw/lha7GBfCdH00MxGGUsS2ML4AXYM8kgRADwqZYnl/jVoO795lKPK5BcitMRhVFQ/BW3ruFb9bLrGw+ZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068802; c=relaxed/simple;
	bh=5F53e9O/gWzUyTUfo+4RHOmvynkoTHJ3k1QWYjt2iaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYr6APaMs2r/HFZb2fa6xHYLF2MLyUucnj58s/5LP6jN/2w3jxig5wjkzwgTuwzfdMa3YzkYLtquRj/gqIGkpVlL1Tq80rLCGyYNsMK/lJ2M0ii3b2KVhVfHuEvpWzMylZ6BPkq0hD/2rEHGv5rGHnlK811jaaSe+DKdy0yYKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l6Ib8HHb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ac1zIblC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l6Ib8HHb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ac1zIblC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 808BB7A0126;
	Wed, 13 Aug 2025 03:06:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 13 Aug 2025 03:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755068799; x=1755155199; bh=HGuLSy5Ssl
	3Gkx17hAB/Q4N0dE1glm+0AudGG7+sEMQ=; b=l6Ib8HHbEDwmR56MndFSJqcV9H
	ABOc5S/4+AK7jsuDX2ydJkRjb+/ZUc7JA+q9OTt2sc81GVm7tyWmtZjatbMygN9l
	ygz75wPidnbXs2PM+4zf36IFPEgVlpPsi88uPd7LhHlr5mTssCsF+xcaqO/eSnN0
	YKl7Fq1WxA3M8KvRw0A83jMj8LvyhMDyB4YpbnAuICaovYH57hdG+mBbSSwh95kA
	xfbXBMFB//+naEaS10L97xScYI7plfOvKLLBL9G+ZWj3ockKkmIxhGBNnmQUmzsu
	GrmG2Bk00FYOefYX+coJpCP0T/lJmXvwp01gpI7BACBctooB7lczzWbXBy6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755068799; x=1755155199; bh=HGuLSy5Ssl3Gkx17hAB/Q4N0dE1glm+0Aud
	GG7+sEMQ=; b=ac1zIblCJ8je8m9Tj/tTC7tHEPNZdV3UrwlkapzMGzLDA/fLtaO
	Z0OysPhI7IMb6b+Oryu+WR/Et3fqCJzuIJUt0rU7fqB0UTQvk8WNsH0n9XZo8gmV
	yYVbDkGuoik3JjoAlvHbeTFpR13O4ryB8Q9WOnTW3hxw9VQOCBZUfJXDFidU3DyW
	Uw0A6/Osc8P5YPXyOJnx3gjD7fNrw0eJEqpgfdyAl4XaG04iwubT+n+F6+YjqABi
	XbQcIJGLuRj+swxsgw8+8JOJVJAEuWR+t7eKdRE+jBPlnhVQz4FGEqnvyUwEDsja
	GFfPxx/7uTJX1UjOCb6oES7dR/psr/WPVbA==
X-ME-Sender: <xms:fzmcaMKktV3BJlwLVwFg_SG13X_2JDK2vO7P_Ef9EX3erO-D2uinfA>
    <xme:fzmcaPZ6s2v_r1_Xsyvkn33tXNmeB3kyhGlvBs_Wf6-iHMqd0Zdm-KFr66XgBGXKL
    r_5awd9Fs11IWNSxA>
X-ME-Received: <xmr:fzmcaGLidrPlNGXyFfdsS1tMT2cLcl18ze99z0scS4xKsAUWH5APGQ7Q2F7R__ui8tCgVF4W1zOynan_Rc9lY5KULW_AMQOaR98CVeB06jY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fzmcaFDru1FQz4SCTAgmW6sSbKc_N25i-kdgIAKConFfURF0zFSAWg>
    <xmx:fzmcaDqSvvqWWh9rDkq_cHT_9fvIPzvJ1QIJzJ-_Aww5VfmBIK4qWw>
    <xmx:fzmcaIhoz4Fxup0DQqQGXmPANhLxouCVvlMnoMhO93hvzpT285-Qdg>
    <xmx:fzmcaIByyE0GltWI6HTKHQY5qwqWdnIClrkqC5voNrahSo7dDkAKKg>
    <xmx:fzmcaAM_tVXI1C5FYS9SIQevhsmIZjKYt46fj1pyaShIvXVJ5c_N4QkP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 03:06:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a635fff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 07:06:36 +0000 (UTC)
Date: Wed, 13 Aug 2025 09:06:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #05; Mon, 11)
Message-ID: <aJw5eenXu5CO5z2W@pks.im>
References: <xmqqwm79x7ra.fsf@gitster.g>
 <aJs5Gee3ZVCJX8dk@pks.im>
 <aJtSqgJ7w02Ox74w@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJtSqgJ7w02Ox74w@nand.local>

On Tue, Aug 12, 2025 at 10:41:46AM -0400, Taylor Blau wrote:
> On Tue, Aug 12, 2025 at 02:52:41PM +0200, Patrick Steinhardt wrote:
> > > * ps/commit-graph-wo-globals (2025-08-07) 10 commits
> > >  - commit-graph: stop passing in redundant repository
> > >  - commit-graph: stop using `the_repository`
> > >  - commit-graph: stop using `the_hash_algo`
> > >  - commit-graph: refactor `parse_commit_graph()` to take a repository
> > >  - commit-graph: store the hash algorithm instead of its length
> > >  - commit-graph: stop using `the_hash_algo` via macros
> > >  - commit-graph: fix sign comparison warnings
> > >  - commit-graph: fix type for some write options
> > >  - commit-graph: stop using signed integers to count Bloom filters
> > >  - trace2: introduce function to trace unsigned integers
> > >
> > >  Remove dependency on the_repository and other globals from the
> > >  commit-graph code, and other changes unrelated to de-globaling.
> > >
> > >  Will merge to 'next'?
> > >  source: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
> >
> > I don't intend to reroll this series for now. As long as you are happy
> > with the signedness-related patches I think this should be ready.
> 
> I am still not sold on the first four of these patches, and I share
> Junio's concern[1] that the "int -> unsigned int" changes are not well
> justified.
> 
> As a practical concern, the "max_commits" and "size_mult" values should
> never come even close to INT_MAX, so I am not sure that the wider range
> is giving us all that much. I am a little more convinced by the Bloom
> filter changes, but since they are purely for debugging and also
> exceedingly unlikely to exceed the signed INT_MAX, I do not think they
> are absolutely necessary.
> 
> That said, I don't feel strongly enough about the lack of justification
> here to hold up this series[^2], so I am fine with it moving forward if
> both you and Junio are happy with it as-is. But I am left wanting a
> stronger justification for the first half of the changes.

Fair. I don't want to spend too much time on this signedness topic,
either. So I'd go with either:

  - Taking the signedness patches as-is. They don't regress the status
    quo and allow us to warn about future unintentional signedness bugs,
    even though the fixes are mostly of theoretical value.

  - I drop the signedness-conversion patches altogether.

The more important part for me is to get the second half of patches
merged anyway. So while I think that the first half of patches are nice
to have, I can live with dropping them.

Let me know which of these options you prefer.

Patrick
