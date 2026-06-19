Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E232DC321
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853682; cv=none; b=KpXswbVeZNKyTuc/okSLLd3bw34ECEPaNNRqXSu+REmh9z4fjYF43tDyzW6sjEJnZQGb7xZr8Q5upA0K2aEVBY79br1dpx/3J+kR53MgLvkVaY3kLjnzXCSCkFD0ctgoUG7HTtaVOwXonDigNBkKDw5l+7uV4IFgYLhEZy3sLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853682; c=relaxed/simple;
	bh=VS9LrcC1VZlccK9vC4zoN8A1oAUQoqzNnm9YJtVGdgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH9r35uPdvZ3nTP4uoM3yMV4GqXy0q4cFHXAVUn1zBwM7vjWSWIHEjHyA+oB1XLP64/OwBYxSVPuM3rdzX5ROYmk+9Da7Do6s/xdfKp6UPk4CoZ082xT5++luN+Dv+OXk0zMEm1kAyenhqzk/HLsZttmgq16udoHng46BWTlkmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W7oup7Iz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vb+p2pbU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W7oup7Iz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vb+p2pbU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F0E27A017A;
	Fri, 19 Jun 2026 03:21:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 19 Jun 2026 03:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781853680; x=1781940080; bh=rh0FwU5WYn
	Zm2T4sqLLaAUBVD0WK2PaQ4eyzrYq0vVM=; b=W7oup7IzxT/r1XZgtJrRFT41aA
	a/1ASElJJSWNYDpslsMR6yK3B4vlNoGxO0zanoZ5jgE8XZINbEKOGg8d7vl39+Q8
	vYaCnF4kptsjfdhqjzIEH42J/+oxB5+QxSNJWwFqGaOU9zBZH8iWNpKszw6SJyHV
	oa6bK07p/UX7UvHZzYwdDcSWxv/ExFhlT1CLtbhJBzOfMlgq6XVuit0RTgQSXb7S
	LQtl3bv0rgdg+UjDQ8Kb3jksx8uIV7QIRWdI/AEdLdUO/S9FTEhlx3yIc7D4tos/
	UFXtIktr9H7Icluq28E1RGjEk9h8zMeNVLiSfa5ps8P/a/ePW+9sS+4aq3Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781853680; x=1781940080; bh=rh0FwU5WYnZm2T4sqLLaAUBVD0WK2PaQ4ey
	zrYq0vVM=; b=Vb+p2pbUvjNVORRuCLEnafphPNoNfLlvwbp6lMl+lhWXx9EcDOC
	wZDRaWgW481eYiYqVEDH3AmFXC4NLetWn8EegqJZjoLXiPwaYBknPLBEXXfuNS31
	tWHBZ03PPcEZIvu3nLedHlMBzCeIeLCt73cuEm7rNRjjtyffposhGAT5YIg0P13i
	rFT54wCU2QfRH6AEyTpuWdtn+SLRebVUSC3FGBusJKnTcGRIVkG3f8oRd3WLTGcy
	ANZuQbwcquegV/mDQmnrvSGYJKWAJncOIvH3Fmasj1WnvfPfBLDCA093EKjji9iG
	N6J2x7p7tCp6zNpAyAn0O4KfRq/Z0p4TtOw==
X-ME-Sender: <xms:8O00amCfKiwY3_00Z03xklHe4cHiQkEgdWpuFQhgzsiowDkb5tP0qA>
    <xme:8O00anYCA2EBHVg_jdANQhBd5T-2hqufP19PhI0XbVs6CZj0zul_mYni2uYY8mOh6
    t8mMrZ9rD2ShU0XJSqvjuu7JcmdIOgOgrgcTSWSJxh-JcIw5MjtfSU>
X-ME-Received: <xmr:8O00ah6jWD773WAekE2FFVQSWkwDo7NWzrtoyo5V5PqQEBitWfwn2pQXZXkbEIEArNWiyjgzL8EkGD2TyhJ4XqdqAnVRFEu03djjVUzySyE>
X-ME-Proxy-Cause: dmFkZTFoeuJU3QTWt4me62vKvrjjPT52nTQPZ0eVUsyQuHtzBSJ0MYwyNv6f90VBHWf1dZ
    BVbe5aznl6lW5dnjvFlPVLATq8TuhE/+/8IBQ//aZgNkcykwf9Fb5d2I9XCVa/YVpQybws
    DPuO3Y7ZTShc8eoA1Ml7Bnh+cqctNJL23RpHcOo4YkUn5/239TdOUSS4eCjMqKbj9GUgO8
    CBT2hH+HqHrTef0QsBgY14Lv0WC+LqSeFyvtqhlFD9OzUrSFWJy9ytM1uN3qNATEzXC/o/
    VRHmNT+6sXKd3XIxRVK3G3BlFBCNnem2uJdhmyysuu6lzanxa310RkP+ILS/WQy3w/ajOR
    4JVely4WltS7Nn6Ps5ckDF6pRZy6TibN30mrX7+M1TbAWyX3oxEUhE9X0hl1xXVkHxxdEJ
    AXH+dtaFur8BfmEm/XbCI36NlqDsS5rOsSzvdRSfY6Dapessr7p75bb0mQSS5QiEKWgo9I
    6yBltrqj3jpYm95ka9yQs4fC82tupDO3/6aeFaML+EFNx2qIc2PsZjZKjnRmo+iuFC573U
    iBNq70UewK3PFnNKtuRgYDmngD+ZvaWP+hFDfOgG8Ug6mX2xtfrercfX9vZrmexq1y9WOU
    jnWenqsC2H/RhIj7sXrSIiQC//8PJ7Ol2PO6lLmCHbGqB6FXZ+GXV/S2Kptg
X-ME-Proxy: <xmx:8O00agaSkxc-EaOwKD2xeZqj3undeKGdqa4zAk6T53ekeVRQ7daPGQ>
    <xmx:8O00aohNpKVz1L5aANrh74KgfMmftpTSobZlrv3Rghx0OI5h6kOfbA>
    <xmx:8O00ap-M-ZGqpNlwPTCL8PHTbIX0EescIarGB-Er1sveulZ-mrNf-w>
    <xmx:8O00aroBZTZEQx2vX3RHyga_tqJ67WTX-PJ2SlSvhdQLn-6-gaSPBQ>
    <xmx:8O00arp3VJYoorX2BvOZj7t0KPbvZ2W4RLX6nuWU3xXQanBRrIAoRAG4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 03:21:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b38d98f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 07:21:17 +0000 (UTC)
Date: Fri, 19 Jun 2026 09:21:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: git-2.55.0-rc1 t4216 broken TAP failures on non-x86 arch
Message-ID: <ajTt6xmQxYg6ppMG@pks.im>
References: <20260617220330.n6byiFQr@teonanacatl.net>
 <ajOP1IOjA3EYvRfm@pks.im>
 <xmqq4iizpkig.fsf@gitster.g>
 <20260618233536.GA1431359@coredump.intra.peff.net>
 <xmqqeci3nz7h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeci3nz7h.fsf@gitster.g>

On Thu, Jun 18, 2026 at 05:36:18PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > ... But since 389c83025d (t:
> > let prove fail when parsing invalid TAP output, 2026-06-04) it will
> > cause a test failure.
> 
> Thanks.  That was the piece I was missing.

I've sent a patch via [1]. Thanks!

Patrick

[1]: <20260619-pks-t4216-drop-unused-prereq-v1-1-2ce0d7bea088@pks.im>
