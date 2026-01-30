Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0E350A36
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777902; cv=none; b=SnCDnrAj7GVcSirwEVKht8sQuexei6eFRLjlO7oc3ml+DzR9RRnYCPv/qGNBuTddtyXSBInuKwz4lojqrJYa/CnZn4LEhNkW8ssVGrf8uVx8VDmzk2tFMeIcWQxjlGdUihH3lZwLUfqLYsjW9Q0O5XbWVrvQ5Z53vSI5Vb/xEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777902; c=relaxed/simple;
	bh=NM6v2H+JjUkIC9KmSE3UFGN72HEzh/lWCJnkmydXar8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1B5cukNVVWMgL0IQbrM0X6gxSWUqtrTBDW5ueZZVRjclJhqg3pMlL6A1LzJ+DvB9zoh+m1f+lUIOexhCj7OOBYJiJemPtLu1mbygTYR0RHIHwI2RTlB5tzBcVXrRfAHYoPvH8OFRH8hhbjuADbfnBca5bRXw6T4z+UsD5Fx3yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QqwqWXz8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NP5edReu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QqwqWXz8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NP5edReu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0FF71400133;
	Fri, 30 Jan 2026 07:58:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 07:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769777900; x=1769864300; bh=PN+pwxGVdJ
	Swsy+TD0wFYthCoTaFFOWvAh/ovpp5WtI=; b=QqwqWXz8jN1E35l3Qje1/KBpnB
	siz5Fr6l2vTstK7jEOrIooLbLVhLYEXM0npxNayccM59m8a7ynaoJInZSH1/S4il
	FDi/85LRXGZGWzOAx87KnErthe8/VVawYxOUMui8mvXT9w1tcUO/7T9ZwFAflL4e
	jf4F6OKK1nJ/i9Y6Zv7TgBilKzSD6sm1VYy9uqHr9nJaHPCYzKWPDYcjbngnW4is
	upT5+O1BPG5hHkDBfAXsVSXnY2Kp4Ft7jAXf8/a1Yr4QvAC6JFmMghaufL2fbB0n
	zqJ2U65LmQL6QNNH+V+mlUsN1AKVRe69ZPtRe7qLAYrOghVP92JRpCXNIMCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769777900; x=1769864300; bh=PN+pwxGVdJSwsy+TD0wFYthCoTaFFOWvAh/
	ovpp5WtI=; b=NP5edReuJ5fcZzi6ynE7iYoXKoBx8wBjoUU8YskWVzedzS+zoi4
	OD+AlgpN+5095uBQnzmPqHyIBVPd9hYre0DE8yVXec5R2aw7WAZ/Jn5EJnlDtm6K
	KJ9cFoC0UNXhg8k2B4rOvjyKH8jiW5YJq5q+4n2hbZd2uuFUvgdAB3GNHQsK1DKl
	U/H8dPAC6nz8r/YqLEtKhtA0mVLZ0anEYPtoy9HC6ORMuNgdZXQlyX/I5pacURAK
	VUzEIxdV/GRWWVz4J3hMOhH8qQazWj4d0a3kC0/+1xpvc9fiM6JB+Tdk981laQoq
	LLEmDDPiVzx2wEPnl5beHqIHDruu/UG+NNw==
X-ME-Sender: <xms:7Kp8aW118OD2jteKTGJfnY28wlDQzjeMzwDxyIORVmah11ufwkINhg>
    <xme:7Kp8aQGujPm1ALRoxyZenocX2dnBZf1HVUDuzHnc7ONhBxg-fhHkFyWOZKc5CDAoS
    uVgaJ55SLVusc3F0rHuQZ0fxP9LCZltkOGLIWxyqhSNBt4ySuOd6Q>
X-ME-Received: <xmr:7Kp8aT4KEVq5b5fOKRc5CAbyiPxOerzBHqxHDrSvVha0QOIGt0svNjOT3QETuIdG0GbBN9Hy9Q2hiA7KJpMkHm1BL9fh-CF0zdublU9f2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mh
X-ME-Proxy: <xmx:7Kp8aWsevbaPdX6EfIFvMMgpByckKj4_amC_cBNWNaJd7opSMT0vPA>
    <xmx:7Kp8aU5LvzmIgQ85MVAwCBQ6Xu0zJfjenGR7254oJt-VEG29kZagnQ>
    <xmx:7Kp8aRVymdJqDTaSh2lkkEo34GIH1a9VbHJdjJuUi2qjJI723FvM3g>
    <xmx:7Kp8aW-EG3Gt3BbnHZFUrVyi1KwYddWxv1ynfo2X6-0jThmRVcn5lQ>
    <xmx:7Kp8afYpkmPrF264fXMrmdSf7DHW8nFOl7JoyJGQOWGGK1Jk0DXkKMzg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 07:58:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a9627d6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 12:58:18 +0000 (UTC)
Date: Fri, 30 Jan 2026 13:58:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] bisect: fix misuse of `refs_for_each_ref_in()`
Message-ID: <aXyq4__RBadFPBoW@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-3-deccae3ea725@pks.im>
 <20260129081420.GA589284@coredump.intra.peff.net>
 <xmqq343ocopx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq343ocopx.fsf@gitster.g>

On Thu, Jan 29, 2026 at 09:28:58AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Jan 28, 2026 at 09:49:22AM +0100, Patrick Steinhardt wrote:
> >
> >> Furthermore, taking a closer look, we strip the prefix only to re-add it
> >> in `mark_for_removal()`. This is somewhat roundabout, as we can instead
> >> call `refs_for_each_fullref_in()` to not do any stripping at all. Do so
> >> to simplify the code a bit.
> >
> > Yeah, I think the result is much better.
> >
> > We might also want this simplification on top:
> 
> Very good.  Thanks, both, for improvements.

Indeed, I'll apply your patch on top of what I have. Thanks!

Patrick
