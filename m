Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C2192B90
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025853; cv=none; b=UlX/aEN7VSkKzxNOKgEpRotnVg8NN7E1sjcCBkGw74PrcbnsfLAfLD5lYNbrcIiBcfhj2N4pzn42EEoQp3Gdkjp8jj2RBytTx6Qa6xqoidDzXVl1JH9vwK5e+z7a/tHvUsbZsotLAPudbrkFlU6+JRoje9YXnYZopfI2CBT/Owo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025853; c=relaxed/simple;
	bh=z1k2rXbdZhPQ/dd4BzVmugnPzwfYHzeY/HtYWvzHiqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WQWRHSylTidYpkHkTu0eXqeRc5n0lymDEWtXVpTXgONZGfK/1BgoerfPcm6IlR1lU2aPqqdTmz2aKVShXw14yRppmXjNkMu57ak//1ZMgkuf8Rx2Rzn8NQvHcg3poQCW4f/k4PRfAvdO5WvHrjmqj6CeH8b+YyelBu7L7xgn8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZrcXB8Eq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zUkD4DqL; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZrcXB8Eq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zUkD4DqL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CFC981D00210;
	Fri, 20 Mar 2026 12:57:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 12:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774025850;
	 x=1774112250; bh=nw/9pP8LUYYwJA7dvNXIV41eKZHJKPRLRhCml85ZaDo=; b=
	ZrcXB8Eqe4ydlAvjNAC7P4al/AigeN9tT7c0gWJLSPqxQE8IO+8ok6/qonrS9kOX
	SaBvZoeBrXU8NtIuKYYyhoPz3rPuAQ13bhOHo3Vs3XrhJQ6rESSB4XhqLCF0ZzZt
	PWvpUtjrQ9f+L3Z67f3G7dfYySFI4e42z0DsJT53yka+gzreaGLHjHmd8RtP0KGW
	bw0UVfVHu8UOzO/uMeaNvX97qh6cxgRQUnsFdaWhZ+ap39N26DxpfVKjAxkCGyjS
	oPYvZo2cH2/lOPzKaDqEnuRYzlXJxcN2u7u0O/lFuPfrh4tFbmaO+fnnTn0/ztQA
	F0KOJb+/rdjO489WsyeU4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774025850; x=
	1774112250; bh=nw/9pP8LUYYwJA7dvNXIV41eKZHJKPRLRhCml85ZaDo=; b=z
	UkD4DqLbnOUV4cyE1ZHj8WbtkLqZvJS0Gf1tbYo7s3g03npFq596gwRArShRhANR
	YZ+fyyiyWnAk/Auo/192m37+PH3dAsRr2iq8wIT39wPex3iSRH66q8Lsequ4p86b
	CleaZAGHAzxUWgfrFuaZeC0RYpiRhma2DxXzpV4dgYhBS3t81WaRROxj+t8dwNEw
	gJVZIOVoUyonTwVpVIwD5QbdPfG/GNZfA8S6K+6RGCPqTXF0+z8k0Tkwj43/IcEr
	3H5YzSW9RlOIlgartnQwkadGaQ1gHKy7kJa94FuY8el4fDLZzPjCYEkfsSoJttEV
	iBnpNz6moRYE3TtySYYjA==
X-ME-Sender: <xms:eny9afgyJlYSCvApu_vHpSEZShaXZolbcjQ0mBMqYvh5l8LDRZG6lg>
    <xme:eny9aTBE3W9mfqWAPtQwi-dnuPDQEic_CtJl5CjNuBIsDTouHc-6mcmwGW4ePfOan
    TNuCmOAWwbsrH6LCsDd2CeEsk3i1OJCnin4bwRFYSGZQRXEAZFgcA>
X-ME-Received: <xmr:eny9aUE2o1Y3CSTKh1Ocq3t4g6gJom_mrqJUEVVU1IpMMCL5Ts4qq78Rv0NZGV6hL490LkWWNYKfAkDJQgJ2WdELkB11I4B5ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:eny9abKNSMHESElmFs73QxHDbt9clHtFyWyjZa9tOkXLeJYnkXsZGg>
    <xmx:eny9aYl2iyRJZD_h_5TAD_VuctbO-sNEnQVNiJdcbAVLgbG8CjjO-w>
    <xmx:eny9aTTcwj5rS5eyzU6XvwmLPNMmYNniPkXgFpDpTjvgukJbQefVjg>
    <xmx:eny9aaKNqWp-aU4hQX6Cgq1-4tyR0WZISVjlU8Q-uadmxNgoReH5eA>
    <xmx:eny9aZa8FX0RVbQpEfg0SBTmPRMYgxDU4eAhCZSSupZ5FJ6ZZVG2QISU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 12:57:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] regex: not all macOS platforms seem to have REG_ENHANCED
In-Reply-To: <d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de> (Johannes
	Schindelin's message of "Fri, 20 Mar 2026 09:55:15 +0100 (CET)")
References: <xmqq8qbnigxp.fsf@gitster.g>
	<6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de>
	<77b6ec9f-46a5-1f38-9733-188e20da55ec@gmx.de>
	<d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de>
Date: Fri, 20 Mar 2026 09:57:28 -0700
Message-ID: <xmqq8qbmfngn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Work around this by setting `NO_REGEX` when `CC=clang` on Darwin, which
> makes the build use Git's bundled regex implementation instead of the
> system one.  This sidesteps the missing `REG_ENHANCED` define entirely.

While this may make things built identically between CI environment
and end-user environment, do we have to worry about what we lose by
not using system supplied regex library?

If the answer is "no, we do not lose anything, and even if we do,
that's miniscule loss that does not matter", then I like the
approach.

I wonder if we could do something like this instead?

	ifeq ($(CC),clang)
		CC := /usr/bin/clang
	eneidf

as was suggested in one of the downthread messages by René?

Thanks.
