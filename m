Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8B19F120
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234590; cv=none; b=BfqFPo0Wf+iWxSA9G/v25NhLryabW2Y1TbaJN9VCCh5nb9qNG4JbZvmQL/AhudL0rCo8zwjOQVa/m5j+PKGD+nu7fqvNFmIwFtpuYbkKnejhOma2LEKw45bgPB57mXnpQ8EFIeTWIF/uxghYI48P5JkRD6JFoFaXyjsYKcdI/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234590; c=relaxed/simple;
	bh=bLqsSjOoVyA/kyP1dezRAcxoRnWvrRmSKuoZc56Hsn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAlElDw3UZg3AF8sDqkYB+Kr99MpVDzgoBqU+G6GZGpLdEkYcfgShERF25dz86YHtLXuK+qej6xBbSP9NqRkjpKQ5ut+Z6IjHEISEnN+5wRw8WaVq5NekM21GdRAVElgUB1n9X5FofZBz4gYi5JsspB8DyrxRNhwfq5gSWV78aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Afzj2mCE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0NfwuH9; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Afzj2mCE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0NfwuH9"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CD1A11400E3;
	Thu, 30 Jan 2025 05:56:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jan 2025 05:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738234587;
	 x=1738320987; bh=OqVan6KZkFWV26pX0noWY1xQsGxVwskFvuoehvC9Xws=; b=
	Afzj2mCEizcbJP1fA6WaF1uV4tJTIPkaaxdKO9tK8V79icywq9WceJbORyZ9EbO5
	qFmt1LHkk3xV8dD9Y7hU7KvOoTT12ty6Ax8O2GiZjsqARb9t1WB3mUx1fJum04QU
	IxUtia52ifMDU170kTyboEBG3Svq/dTfywh1rdtwz+eYKbdVSiqPObQkJnA5rfwK
	eaSCW4HcPSfijF4PMP0zgWLHo424VvNuBsNYs6F+azN7bxQKDeurbs3+w8lPwxmc
	orBrnY8Ifs/6ER/rqOm1YqCpLsmxpeITIXQmwsbdbV4Yty8H4r17W4XTIcAPODmq
	rGKjzloYZqB+xhyaKQ5NpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738234587; x=
	1738320987; bh=OqVan6KZkFWV26pX0noWY1xQsGxVwskFvuoehvC9Xws=; b=H
	0NfwuH9E00wouIGQfzVz/0cIDAr9sh/sV89ztJUcqS7A0iCoEW2ZLB9PAG2XI+83
	k1A/qAd6/zSri1e9vZJJRwWeDQNbEawWGqofow4BpC+2SPxi9zMyqVo7AFB44shr
	ereONBCDZm9whrE6IdcCnTNKAipU6X2loECHRJHzawehzyILELWCVgsmIgR5ib12
	zT3cCzSF9pKFuahoPgTZYq2e7xkmJyKsj0EDSdn3sqcDDY6Btw1gtEDFo6H8rG0n
	9NWOUsiZtXf4KpHmr7jtNWQdr69QK9CUrmH4F4JscAqHa1oQqY7j5awSu2GF++rz
	dYenHYxoDroFJbYBTDmWQ==
X-ME-Sender: <xms:21qbZ4Xf_Snzj-O--uQIdVANMqAja7E5Ro-xjcboV6SDt3Pb8cvLiQ>
    <xme:21qbZ8nFe6SO4hePZnrQ-7eLecUUNtThHQKgCcE6m3TwDTPlo1A5UZTzfv5zeNPiD
    GlIGowqXTfgjTC4_A>
X-ME-Received: <xmr:21qbZ8YkEtfAWR2q-c6pk3U-oLjYndr2uepDM73wRHsg-ZtIm4cpZs4MedzQ9mwUFPU3muCZTLrIf8WGfKWBrsxeXSqXXTUarxShpFLedFLV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:21qbZ3X4Lr-3Qx3VR0k2rzrHFBx8WnLEXgN0lXn3k0zKh56Ei2s3pA>
    <xmx:21qbZymsWFiFiZ-uEHJvL9wV-99U5gysxlp5jHAEyij7jLOzNmXP4A>
    <xmx:21qbZ8e_IA3VWjJo_1h2CrGI4Mo25fhqDuQKe-twZmwDPvfeNPAy7A>
    <xmx:21qbZ0EDUNM4d8hAaA_xe6xGnVBZJPGx7r1fQQ1cPz6WFAxW9b-3Tg>
    <xmx:21qbZzBZrBvYL51CnPOQl4TWi2pImFEAufaCTuIz2nByw_J0LyczbXMt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 05:56:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 228c300a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 10:56:24 +0000 (UTC)
Date: Thu, 30 Jan 2025 11:56:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
Message-ID: <Z5ta1wJ1NQ1EdLJD@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
 <Z44u7od-mDiKcKVZ@pks.im>
 <xmqqr04vzyz9.fsf@gitster.g>
 <b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
 <Z5srHBSPKQlsuH53@pks.im>
 <CAP8UFD0s1nOr5EDx0MW=u7grpmywRTpGzx0v_d4PSjmgJ0ZBbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0s1nOr5EDx0MW=u7grpmywRTpGzx0v_d4PSjmgJ0ZBbQ@mail.gmail.com>

On Thu, Jan 30, 2025 at 09:37:47AM +0100, Christian Couder wrote:
> On Thu, Jan 30, 2025 at 8:32 AM Patrick Steinhardt <ps@pks.im> wrote:
> > This one doesn't feel like a sensible addition to me as it is
> > open-ended.
> >
> > >   - Replace a run_command*() call by direct calls to C functions
> >
> > This one, too.
> 
> We could put those two in a section for projects that are a bit larger
> than microprojects though. It might help those who have already worked
> on a microproject and want to do something a bit more involved.
> 
> It happens more and more often that people who want to apply to the
> GSoC or Outreachy start getting involved early, which is nice. They
> often have time, after their microproject and before working on their
> application, to work on something a bit more involved. So it would be
> nice if they could easily find something else to work on like those
> two ideas and others similar to them.

The issue I have with these is less about the project size, but more
about them not being clearly defined. There is no easy way to identify
sites that can be adapted, and neither is there a common understanding
in the project that this is even something we want to do. So personally
I'd leave them out of a first iteration so that we only have a set of
"trivial" projects that are commonly accepted, which allows us to focus
on the form of the new document instead of bikeshedding the proposed
projects.

Which doesn't mean that we shouldn't discuss adding these projects at
all. But I'd rather think that should be left for another iteration so
that we can discuss their scope and merit more in depth.

Patrick
