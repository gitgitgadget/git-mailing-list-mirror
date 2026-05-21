Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3DD3C3792
	for <git@vger.kernel.org>; Thu, 21 May 2026 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363592; cv=none; b=FQgbzEG2vTk2vGx2enu6vQekKVBqdtTAdKn9zRv/IFWluWOJb+zkngLqhj35vrX7xa9+ubqnL0UeRSExCiAKB0xdu5jnChL28QrrqyWMnnHy02zU30aVBAEiHxlqN31eUP7fncfrWXRpmQoc9TAp/uZYGd1o0/8EYsfzoYrR0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363592; c=relaxed/simple;
	bh=UZbg/rY0rj2cEVMPm3pYhJ0Nhm+c0zvdAkkGORZQE+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRYRSgq0ERxtXaFC/LkKT3rRj+bM+9Dn553dyzBLh4ciGxpx0NMH6IcQOhosv4huSYW4XuNnK4VBmSLePkkvh6zP7MPaQhLrGyYCKRRC6oRgkgS9sNyd/Xrgc4cvrE4qhTO3e57tPglyCmCmqne1E3EjsIi3cSuBaPyVfpB3MTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f1RZsMIW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5kEPiLN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f1RZsMIW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5kEPiLN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D92A14000E6;
	Thu, 21 May 2026 07:39:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 07:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779363587; x=1779449987; bh=lA4ERLiOVC
	K03QFlpGH7aZSou1HYaS4ZdECw6hw9JK0=; b=f1RZsMIWahExGWHMteR5eVAFEI
	6b8zjT/bIFifdfRWUtrqkIlsajH/PdERrR5WxpmEi4/DwVZ37aq/9QxFIZNK5uyG
	nX7hUv8qElWUPfUz2ULFKkbJ/h+uJnqlUNQCaDa5hkhteumVHxxza8ddNdIhadOz
	jjClxej9+9/tBd3n7lkLRg8LWTT82Bv5hbEBpzBBeLtVMTVadEq0eu2Lc9gWsfSX
	ludg74uR0xLg9phg9AU3eNfvZt2UoYDcr8P79MmaE7wR1T3lYXZEhOGAExPG8UxW
	y7/IfdKdlswvybXf8Mwu+rBUwggzQRQOkP8b+GE4bd4mRsrEk/gWeCwQm0BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779363587; x=1779449987; bh=lA4ERLiOVCK03QFlpGH7aZSou1HYaS4ZdEC
	w6hw9JK0=; b=m5kEPiLN7YlwvCJ7Xd1CE/IkJrRjsaXpz4xmwuBUVLjGp5T25n3
	2lFRRyRqq3/rX5HcnxS/ogT02zqHDY48OvV2clpog41P6kN0HVBg3IfOJCas4wM6
	lZKlbyCpYvRNnRlKfs0XE4kr/cZucjYfMtVE+Xmg/wYDvgY6+rT9Rq6s2JLb1prS
	wBNiLPOcR2iQy0GjRmInJMQx6qnckh1qyz8SwcWGM02Gb49z65jSPDD817QUvvvx
	V6J5gzSRXvRK0zUa99i5KA8tLY1SlcinIsaMna9CNgWKTExq+E5WLNEDEDQLozpH
	2zZkG8VaYg95vc4D+joAPFj36RhE27NkBVA==
X-ME-Sender: <xms:A-8Oal32FEUehXvY88-UfMXOAf1370B-f-kFzkWu1OlyKrzfh8czKg>
    <xme:A-8Oajhr0rQrkqAZP3AYLrGDr1jBUz05Ytj59QkN7OP8FUOFaDzZsEkQjpMNFrcce
    iLNs6GjRyYAqgV7mppFNS-pFUIw6ItP9cfnIUDeD2zKbosBFbC2og>
X-ME-Received: <xmr:A-8OajT_CaYGT9YFhkrFjodLlK76Jzu58rhW-KL7QsZc0cdlqMSqxPe32jVsCEvzLmvUWQZqqpcujpsvvbfi45ZuZ2TpKgjL22TH0IeCp7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:A-8OasjkRPLxsFC4Jixa9NDJEtz-icnTSP7e7XHqZAgaMluJTjI-Mw>
    <xmx:A-8Oar6Uos-7pFQTagTyhw9FnPK4hndzEngrjN6JS5-vu2nGtOoW4Q>
    <xmx:A-8OahCKlWfjUKyVU7lZ0YRwwc3_WVKhYnD97R-vAWzrCbMFDEkcmg>
    <xmx:A-8OaqYySQnVFNcNkmO_H26oQcc9He2C1gy4U9OyXTO5DxD4rRjKOw>
    <xmx:A-8OaoTWdzyB5lMGOkNNjn2RX_QqBHn0t5nlu4ibqDE1v4QNOI8wHXNa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 07:39:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85382622 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 May 2026 11:39:43 +0000 (UTC)
Date: Thu, 21 May 2026 13:39:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] small quote.[ch] cleanup
Message-ID: <ag7u-LkIyYvnhtfX@pks.im>
References: <20260519011837.GA1615637@coredump.intra.peff.net>
 <xmqqjyt084sn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyt084sn.fsf@gitster.g>

On Tue, May 19, 2026 at 12:19:20PM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I noticed some unused code while looking at an unrelated topic. So
> > here's a small cleanup.
> >
> >   [1/3]: quote.h: bump strvec forward declaration to the top
> >   [2/3]: quote: drop sq_dequote_to_argv()
> >   [3/3]: quote: simplify internals of dequoting
> >
> >  quote.c | 21 ++-------------------
> >  quote.h | 14 ++++----------
> >  2 files changed, 6 insertions(+), 29 deletions(-)
> >
> > -Peff
> 
> These were very straight-forward and pleasant to read.  Queued.
> Thanks.

Indeed, all of these steps make sense to me. Thanks!

Patrick
