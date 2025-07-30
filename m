Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF514F90
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753853931; cv=none; b=Re3oF+7jlcy+MgX4RFvb/JtrHbdXRtX3McPc/sQFnwyqfl+c++SNtEzYlvWdE1HGwVBSWqQ1zV542ylEveaGBxDoEzgsgzwyn0/LGcVQP2BUaL/bVt8J7kCPPmyqy4U97qCWWEf3PcgOW+OkPwrAXRAT2siASCyZVB+SvsE6vlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753853931; c=relaxed/simple;
	bh=6bP1MOWF7NtyHIXbOpUIC5rngJaBKmfNtjOEgQ8L9hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXbUcnj1vFb23wt8hQSG/4RoFzgjZs8EiQSs8lSxJWuYgpLgEfPnoI0qJ65LaAi6CcntLjZSbfx1dA44o0g89t71LCPgPQ8MFwxRNoDGKWJC2KyZhh/L5zaC9yIkAit5y1dIaz0B6Twgvo96LmY4OMia7yZbs3JrEcPZALOYe44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IlLuVtnR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nSiXi0XR; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IlLuVtnR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSiXi0XR"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BAFED1D00571;
	Wed, 30 Jul 2025 01:38:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Jul 2025 01:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753853928; x=1753940328; bh=VzqIJdyzgi
	qKJWRzpgnFAOJ4lKNRQ0totUr6TOJn8uE=; b=IlLuVtnRE9axKO7XM84yU4YHeS
	xNKhOTuDf5yDD0zIe1iTLg0dt86g5uj0eyX8I6llySnzwrIHI6uTpLxPP0yUCxqt
	1yDgDEKV6y2wjoN7fMDP5cQkWzQ8pog9kKS7kRh2dB0XwRK3YdHZtaiF1/tbkvB0
	Zau7XMlloJVD1Vsj/crSVbJ12U9B4RkrFsrXIQZnuc1fbbZiSgDbAejYBhC+aWFe
	Go3nsBx7JeUnDiK+PYPG0Cs1PhbewWXGf9QkWFdeImUf98S2fZG+N8rRt2N4P359
	gINYKF//mC7xycXnF14JUjvlJJ4Qv4kNFU2CpxWTuHDB74/DoCJ2RE1ZDqcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753853928; x=1753940328; bh=VzqIJdyzgiqKJWRzpgnFAOJ4lKNRQ0totUr
	6TOJn8uE=; b=nSiXi0XRppdMf9GFOuJBlkajlBWZCw0gTp1z0GZe3HRYuHXhmLA
	bag31EJFUuAmkbgA8qhxZoVdLSyxIyN1G9RkIaJy9pLJYsgsT25Fv74CFJUovTY+
	WAs69vAEC69yULEVPsWDVMwiW29MbNAVu3gOji2gS7HJG6aIDJX3SgbXdP4nyHnF
	eL7Z9g08oBGVfdnIUDPch3fESh4WYs2ZuQ6lH1491vUhHJN5BXlq1OQioiu4AdBR
	uBNjvpXbxtpco9FBGaHdMmynXVfr66CBBcDVKghW4fcORM2iUZhz51fDx/FaFx1k
	GChbH88VGpbv2fsfzcWhZI+ByusI7uWZRMw==
X-ME-Sender: <xms:6K-JaLUSkd0vuOBOOniGDkU2GbjBbnhVGIF8U_8E63FhvBl3LTXO1w>
    <xme:6K-JaDyLuBY4HJ2w10pUJFBR1uKtAtAnwJibDuWw2UkCCBafkvK76X6QCQgE8FZls
    D75BQuMTrHUl6GYgQ>
X-ME-Received: <xmr:6K-JaJN51QQUwkqpIuxlxzO717hn2Ja7K52gOT6kepS77d2n4Y5n0QUSGEsjMZmt4dw4Rzc5oLlKx-YJdN8QZXRnhNUXqgVlHQLadwba>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6K-JaE5TaVHfgOco3snh8FKeTXcWrp2249aO7Hb3gD51d3A0gaCtCg>
    <xmx:6K-JaKN3MFgt932P-ni6b21GHvNLmqnVvg2QkFA3CuTs1KONCPg9jw>
    <xmx:6K-JaCkV-JdvM-G4Ss6f19FbV4qOEUkjONk18y28bh2DtypZWY9p9g>
    <xmx:6K-JaBTQQVlnz4RrpOFT1GU_VOtb-9OVIjQ0rlrR-dUvGisinJyFEA>
    <xmx:6K-JaN6M0iziuZbEDWqN84ruVqvUzGnniqoKDR2PRe7FGkbVrVNqY7yK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 01:38:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d7422a2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Jul 2025 05:38:46 +0000 (UTC)
Date: Wed, 30 Jul 2025 07:38:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] clean: do not pass strbuf by value
Message-ID: <aImv4kZJS4CUqmZ3@pks.im>
References: <xmqqseieogkg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseieogkg.fsf@gitster.g>

On Tue, Jul 29, 2025 at 02:03:27PM -0700, Junio C Hamano wrote:
> When you pass a structure by value, the callee can modify the
> contents of the structure that was passed in without having to worry
> about changing the structure the caller has.  Passing structure by

s/structure/structures/

> value sometimes (but not very often) can be a valid way to give
> callee a temporary variable it can freely modify.
> 
> But not a structure with members that are pointers, like a strbuf.
> 
> builtin/clean.c:list_and_choose() reads a line interactively from
> the user, and passes the line (in a strbuf) to parse_choice() by
> value, which then munges by replacing ',' with ' ' (to accept both
> comma and space separated list of choices).  But because the strbuf
> passed by value still shares the underlying character array buf[],
> this ends up munging the caller's strbuf contents.
> 
> This is a catastrophe waiting to happen.  If the callee causes the
> strbuf to be reallocated, the buf[] the caller has will become
> dangling, and when the caller does strbuf_release(), it would result
> in double-free.
> 
> Stop calling the function with misleading call-by-value with strbuf.

I think the second "with" should be dropped?

> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/clean.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Good finding with an obvious fix. Thanks!

Patrick
