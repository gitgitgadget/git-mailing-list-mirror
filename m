Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129161F4722
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220584; cv=none; b=E+v0MSLu33pcicWyfHbmmdFHG2OQFyzG1f36++KVXRHa2y7GvKUO7aQBvOMcoe65i4jmLYhMHdQhjx7rQxlB1gN96V6W3MgRRfwNJPoJzDT+Lqvin0cTEsi46IyslsEilqZb/uVSKjW8Oa9oLPqcP5L9lbU6JcLR5w3joeAmjd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220584; c=relaxed/simple;
	bh=HeFMkMLABVvCVBIax3nf/6f+8WrpYX1VYU3v7+mMNw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh6zjunzvUP5TSoAyJRDBhxGnazhWKRWeDdmU39YeAqhIx7pNrJH0LCIq35ej/gaFrteEv13/vkKA/7WGHxWw3lEuFpWb4uh6aBrQGcYshvkY0b7VJhjdgIgppsSEi6Ami4C63VvdeQQ6JCLVXeuyuZ7IO1AsVaSh6Opji6Kv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EzsEgum+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jeifu0Up; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EzsEgum+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jeifu0Up"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 017517A011C;
	Fri, 11 Jul 2025 03:56:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 03:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752220578; x=1752306978; bh=OIxToSwx80
	1yQOp4nk44OPOdUGVkJG/KAXFWQFyfdq4=; b=EzsEgum+dNPUES82wYzGgPo24m
	tB1RROGIzSMe1k24Kdttrbl6Yx0uCCixwWUjAghiogDx3iCM3dcKBdSkPdbo8Zi5
	NEU5fsV6YjNcCy/45neAA83AqLckb6JDRmlBIm0uEUX1rfYbTqeo9qwUSg3iiYAB
	7AyR46+Rr+rrNSa4isG299UXoZinx7yd+64cMCvyZbhNy3rsCDx4eiaYZlItr6+n
	YgA6ixA8a/OZOcrHCAf3wfZ8QgnzO4JsNybwrgyXWfu9WwrY2GGxUX4zOQ7BMOvn
	tpF6gapEuQOuV1+ojszDWIeHXnPA7+MHi+/Avss+cIAIIAnu/7SWuHZw2DKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752220578; x=1752306978; bh=OIxToSwx801yQOp4nk44OPOdUGVkJG/KAXF
	WQFyfdq4=; b=Jeifu0UpfR1063mVfX8JPUNcaCEUd8IDnLsUeZzpxjK4vC3TOtb
	+52yTmOEBu7zl5yVB5m5q6glK//0DtQt0qj3t7rWPjWA19hls3foQRAweVQRxm0q
	SIBZjRrwpUgUYFNc9qrmY3gvzrd96JdBEI4k3RaWXOvkD6BLvCrG14A/nMnwosh6
	cloPY67g4bif73GHtq+Y1ZJA8HUUaLyU6Hd31detGdXkQOwMZqL2J6XliXpKZe47
	Bj/wNu+NPGmGejKvWVkoamfJ8ccfVlc/auYrXCdeH9ZUHjVNzbLU6KEs5EB08NEx
	4TP/YRgPkVeh0ryBxpCw/AkXIUJ1mK4cS7w==
X-ME-Sender: <xms:osNwaH2ITLyasAggPxiggXwBFMRZKVr-jYD4IBrbu5u5J5ALi7RYng>
    <xme:osNwaAp5XJbPQNnfVi7cl6Jg8hSnIpkLqelokX8W2A97Z9Eh4v9hUBbSh7RUlXZlx
    gGe4_tfBMinXYRBKQ>
X-ME-Received: <xmr:osNwaEeTdjRvAURbntwk2bI33tr_LcwgTJdmdCmAy4N_qnBQlK4yqFddF4cZy3cu4SAjNCCyKF7NbrhkZHxplsuwkGfp4I94bNgZtzvubA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthgrnhhhuhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnsehlihhnuhigfhhouhhn
    uggrthhiohhnrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:osNwaPq0g-MeQFNMVVrXjRqTU9G1HFdQi-uIridJdzK4L7PEToCaOA>
    <xmx:osNwaFH4uiTl8bhP1vJMH9l7g6sWWVyl5doEwWedFJmwOk7RvmSVPQ>
    <xmx:osNwaPuTS09EWmCfiDMP6W32t9w7mr-FOVWNfarYlbQUTmymCp03Ew>
    <xmx:osNwaHVqstqVljf4oHVe48IvE-qYh1oLBes6xq5-o8z9q5woAHQ8dQ>
    <xmx:osNwaKnMnwQBUgnAZUP7ab5WVRH6ezJcEx7oE0hJmuN5lSfz8vgC04Gc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 03:56:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44f9295d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 11 Jul 2025 07:56:15 +0000 (UTC)
Date: Fri, 11 Jul 2025 09:56:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Stan Hu <stanhu@gmail.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH RESEND] sane-ctype: fix compiler error on Amazon Linux 2
Message-ID: <aHDDnKx9sK1ctzIR@pks.im>
References: <20250710-pks-ctype-v1-1-1db7e7568ea2@pks.im>
 <aG-EfIfyXxmS_x22@pks.im>
 <aG-HMnO11lCYgPiY@pks.im>
 <xmqqtt3j69r8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt3j69r8.fsf@gitster.g>

On Thu, Jul 10, 2025 at 02:01:15PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> > This error bisect back to 75a044f748 (git-compat-util.h: split out
> >> > POSIX-emulating bits, 2025-02-18), where lots of bits got split out of
> >> > "git-compat-util.h" into a new "compat/posix.h" header.
> 
> So there was a subtle change in the inclusion order or something,
> i.e. we used to include <sane-ctype.h> a lot earlier as part of the
> <git-compat-util.h> that tightly controls inclusion order exactly to
> avoid this kind of problems, but that has eroded recently?
> 
> In any case, it means that our definitions in <sane-ctype.h> will be
> overwritten if we allow system-supplied <ctype.h> included, and this
> is an obvious workaround, likely to remain correct as long as their
> <ctype.h> is not so broken to allow multiple inclusion.

Yup, exactly. Toon figured out that this is actually neither glibc nor
GCC that causes this -- it's OpenSSL that transitively pulls in
<ctype.h>. Later versions of OpenSSL seem to not do that anymore.

I can reroll and update the commit message, but am a bit hesitant given
that I wasn't able to send out this mail in the first place due to
whatever reason :/

Patrick
