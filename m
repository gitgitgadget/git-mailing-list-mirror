Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67C2FE59C
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231741; cv=none; b=M9ePgKVquOt18ZbnLz2ioEHfHEGhpFMARzvcxyljRq6WmyODhikbMu1nZNMmYwM5BDYDanvxd1tcQ7/gd7vrxsu+Ei3Q2ulkETZZlEUyJ8YUhVyHWSH5omnqcH1zKQfDcTuLjFzOoarCtpL5i03brG5k87eFjOQx7sYG0pIxDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231741; c=relaxed/simple;
	bh=opv+FT+3aJjxuCdx6oT0jo+LhIF9RI14l3++W7o/v4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IePnkIL3wSjkh8QxBFNh+b3XR3gQavXyTBrz31FtfMW32G+Bn9dWkY6Ai81Xq/be6Tg90MF5W1epasOeZpudQ90pb+uWMGlm3XiMRgMJtsf1rGk3J9zIl/oqUCPYDoWCnAi3lzLeAJSIVWB70zAYyEJIOjGVcZ8btygkv9QNwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jcmmWXqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDfDDDlR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jcmmWXqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDfDDDlR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 36D56EC0680;
	Mon, 12 Jan 2026 10:28:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 12 Jan 2026 10:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768231739; x=1768318139; bh=c4jjfxuLuT
	EunOcoIQQEfXnmO5ccVRXUi/eVq/2wWtQ=; b=jcmmWXqIvLpI5k+a+wZyieQrTd
	Mm4CZg/jzAHy40i3NJYPoVkiG9DwG4tFDTvD1XGlKcPZoXWS5Ac7E7uKa7prU5n1
	3bCVS8ENA5JItgxuO/yofW25NSO5LaW7TUnM24mRjId2b8aB6WI1B97xIHno81iU
	ig0MjBPABpUr7kUAph+i85cBe2Z7aJXSAB0m6lAnA0UNHvzbuufbEVwSM9NvGCVt
	ntG3Z15Ymh9LGPg5kuKtJa1BxPDAuKWpnG5jeAdua/zXe/XPpDPmy8YA3JY+gESW
	5oPyo8EidGEGVoCrS2m4VE/KUqh3q4t/pUqHCyJtIE+dy4e6kkdF51SOdRhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768231739; x=1768318139; bh=c4jjfxuLuTEunOcoIQQEfXnmO5ccVRXUi/e
	Vq/2wWtQ=; b=LDfDDDlResQNFlra4ECCNTzcW4nRLqoMYRvbytNg8kzdXggF/tP
	nmzif99AMfVwSxr6EJhcTM3EA8/SO7kOoOi8ewh1LgDdFl7zZjvTLjiHUxRhmwQn
	8ZqvoQ0lYq/4MuDvex/8/XO9LUkctY/tuBu/Ve0ppTUnf3UwFSIOAyS6EQ29aRqQ
	a2dXWgOpY5v3jXFnnmo6HkmxEn9SzC1pn7vgSO1/FL2Tnszz4xrtLQWBUVVFhXMC
	zlK/pURuQ9rvotau86dwIb3vsjoYqAGY6BqoFajNh2teo6++OjAead3/4dbPn851
	GZ5rSzp/01EHy9uVjVZhgHcgP142WPN50zw==
X-ME-Sender: <xms:OxNlaeGW2CyABJmAHvhIHrUlVtQqzNL6ZNiR-G0jVX8qeHcZNOcBkw>
    <xme:OxNlaWxbBJfpwnnOgJygc34_fvloSJ-McQvDYPWN9kmbj0f8KH6_UbwLdkCRa6Jrh
    4DI18WVTG_xUit1h1piPikEmNR2ZsBhiCTD1vpKoEpNW_l36zvo>
X-ME-Received: <xmr:OxNlaVj9C1u9dlbvQYuUIcQ7QeXV9cowb4VXo1G-toiipneiT2PzJJONBx0LSR5Em9e1waFHHAf0dLp7-FqwZqtXKxgJOdNKFrpe8I1wWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OxNlaRxyok9_nSW55aSal6jSBkQrra3DLJ7BchWGS4THTWzxNBrw1w>
    <xmx:OxNlaYI54b6gPiDoBNq0aQEtoWeu-z1SZntIdbzBMXuVfXr1tKLF1Q>
    <xmx:OxNlaYTJ-Wmtk53XviVy-KrQpxE8cKyrCeoMGQyTP_5mHL7_Q3OGEw>
    <xmx:OxNlaQpv6jXZJRowz0iRu1Vl5w0TDQCct_qX64OicIJ4AtQ-0aWbsw>
    <xmx:OxNlaYbrn0Awi5MlA_e2kF4BZm8XEYRGjiY_KbV8vGzRmQCk7p1SEkc_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 10:28:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5891fa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 15:28:56 +0000 (UTC)
Date: Mon, 12 Jan 2026 16:28:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 09/10] tree: stop using the_repository
Message-ID: <aWUTNU7WGTwHt6Ks@pks.im>
References: <20260109213021.2546-1-l.s.r@web.de>
 <20260109213021.2546-10-l.s.r@web.de>
 <aWS9Ll8CQ3eILx3z@pks.im>
 <xmqqh5sqoqr0.fsf@gitster.g>
 <aWUMn6G0C1cHA4qY@pks.im>
 <xmqqms2in9hb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms2in9hb.fsf@gitster.g>

On Mon, Jan 12, 2026 at 07:20:32AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> > In any case, I'd propose to move the compatibility macros into a section
> >> > that says something like:
> >> >
> >> >     /* Deprecated wrappers that will be removed once Git 2.53 is released. */
> >> 
> >> Please do not take release schedule hostage to one particular fix-up
> >> series of patches.  Thanks.
> >
> > The intent isn't really to take anything hostage. It's rather intended
> > as a hint that once a specific event has happened, we should take
> > another look at removing these wrappers.
> 
> I am OK with a comment that records the intent, e.g., "let's work
> towards reducing the use of these wrappers", with the plan for the
> next step, e.g., "and once we have done so, remove these."
> 
> But the comment you wrote is forcing people to make sure we remove
> the code that uses these wrappers and unless we finish it we cannot
> release 2.53, no?

That's definitely not my intent. It's really only intended as a hint
when those should be removed at the earliest. Maybe something like the
following instead?

    /*
     * These wrappers can be removed once Git 2.53 is released. If you
     * see this comment and that release has been published then chances
     * are high that we forgot to remove them.
     */

Patrick
