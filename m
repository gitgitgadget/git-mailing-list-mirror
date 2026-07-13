Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013734C83C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975341; cv=none; b=ENDLsFTYC+z/4BH9kXi1/OuaaYuNTypynSh6DJgabxeaENUrQKO0vQeKNwSzYZSkSanmIqJM60GjqN6moEJgyDmu6bdb7A2RUUZrbmho5Yz8NEcZ8l/jPUay+dNOeFBqIMp3jdAB9rOisu71mx9e4crOCLYUnHrfQRcwJ3HgzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975341; c=relaxed/simple;
	bh=RDKE/Lh/FhuJHzyICHUYb2EoO2kW2GF1emTpU+k8Wzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XahJBkLDhXSY5RY9J5gx0kHAFPiIHADqqPefIHJrU2GHC3bzPURH/hetT3ZfLHbvRvOrAfHVEbNyPlQdH4IBuywUMyAVF4D4rf/QE/7Mc1yCVUCWhN5acVQfUr8f3nlJDSHwFp6Y1ENB711WChIoT0wzoiXI4r1ab7vdYHlKLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QeneElEE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AKpN9uJe; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QeneElEE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKpN9uJe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 54AE51D000FF;
	Mon, 13 Jul 2026 16:42:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jul 2026 16:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783975339; x=1784061739; bh=Q9D4wor3bs
	vLtog8LKtS+9jJdj+Lqfh/IwplzUte8S8=; b=QeneElEEv69OTSM1zsc48Z339b
	w5HlL0ONYv/dfEgYcx/wIQjjN6YOPL5OMEWBM0xWnzvMxAzzJOvLYhNs9e1xbwIT
	SBgzPtA1kq56XK/C7k2cgsD3VylzbAFhAvPVI/feNtFIZrofKqDPLLXopOUyKDez
	eV7FYN2u+Hr3yO13w8XIV9LNXcsYESho6/G1yM9aseeHHd1kDOkCj4V91+4qVNEv
	MJYKAobzblnqRP73tzyDTFne2KLXn9SrPM+2XX3XimMrMCq5qvYWPZzmrbW61j4z
	68RDTeX6CJx6wmLb4ShOjMe552gt1rwJS9gpscEVw0rziNaHwp3TdmbM+ZLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783975339; x=1784061739; bh=Q9D4wor3bsvLtog8LKtS+9jJdj+Lqfh/Iwp
	lzUte8S8=; b=AKpN9uJeZC8TrFA4SELsyhK0vwA7kn+xl4QbXE0FflITste2kf3
	GqRVOJeFwDYLT1xIQdm2vBBDm9MAr8NiTaYhkwkDO3ts2J0ACfkjZ0HWLX4Oc4Us
	vIlwdpHm/NyQSwIQundPxxMQ/vSK5FNdzSHk1xI8hpnf3XMRsKJ9HTHYjqO3dnS1
	0DWo3+AauUjgnRs2KTWfh/DQCOGciRxmnlToOyTi7P5n0N3USXfHJ02hluK02Lxq
	8v2BsVK7h6PaWgxm+SJ5FriL/+bQFpOaAZUwvOInjPYcrOVVpyROEmipxu2iyvur
	xmDocdUDnJl1ECtrpiGabCLEwk6uHeGwzOA==
X-ME-Sender: <xms:q01VailEIauSqyirEJsgzt2LwEPtZyRSQ1Eq5-9jq29UGIAY-ttlHA>
    <xme:q01VatgcpBvKh2xEAV6fVt3v0EJjMPWq2_Viq9Hgp72YfMKgeQDDr-tjfU-D3XB7Y
    W2P5K9grjR9wjdUSWphkMtYD4hLguFUUm9ENCtUJZqFOdmuUjWZzQ>
X-ME-Received: <xmr:q01VaqeyrWZgmCp2HgtjJ4V7OzQS_1zq2dqdb_5kQmIUkCY8Tkf6wMoizRlik2Bkg61dxMt50LO-CGg3rcPcLIfmBQ-akfMUBK-F1Do>
X-ME-Proxy-Cause: dmFkZTE3oBp+rlKaJejwHdLk6t2wKvUV/k+/chAhTeP0R/kr6K8KRltOHNIt8sZTazSDU8
    MaDGxuenQ/+TWuT23GqXeOIy7r9Stdtm4D+wr6RFrc2YHr8HXmE7SMX2cw+U6Gd68UY8c7
    kJggf5R9ujFdbLeJT+wYCOMSW+OmN4EAzL+XyLeVpVE/PvdZdZky9fpk6OGyMy9U4NmAoc
    SAKawb2OXs9DoAbEsvTbdzpJMIi7kXgjtBOC36kaBiozxtQARUb4lzmNLrxe3qwdj2Y/xk
    8AzD+8tHRqX26LIm7Zb7oMZnbTByKWaUFKOixX9N+sx1og7Ej0TPNeEOOJMH0ljJF5hkVC
    zMwhTe6Jui//zmccOkm1ZFh54xzPYPm+UK/xUi1cmv6SQb2tYJJJMSNuJtNyZc6V0xNdRc
    /v+rAkkq6EU/ApjMD+9Wmhm/x1YD0sq3APjEczZQ80TZEkoiugjSfv716m1lOvKbUeVPAg
    EdN+uQcG+igpk8au8aEaFaTM7fH2K1J4x6m8zdFGCioL0inHVVo5eA+Aekf3K8fTMdr3m6
    nNxu+nT8/54BjVoelPMRR7wFAu+VKJvqZm8xBeVV9ShGQqU7SWnHwV78ryR3RA/SZ3UQc4
    CR8MnSmOAOBlXmBJkjWgItsUA3lRY37F+fSosIsYFXpHqx25VufifJmpKDbw
X-ME-Proxy: <xmx:q01VatiKWC5nNcQL58BTot62pP6lSfccEXMUfZl4Yh2Pbp0_SzyjLQ>
    <xmx:q01Vaiz9Bv68INPVXXIYNu4OenjQSilnlP-jk3Gxc5jD7FuW11Ky7Q>
    <xmx:q01VapNyL4wHn-9gn3jXghMYKwt9gePlkrLBdgwcdzNeGpRV9b1CrA>
    <xmx:q01VajVRsHhlDIKlAgTYwFTBfWgeFQ4eVwhc7nMuk7G0hIVHc1OZwg>
    <xmx:q01Vaq4Yv0sOS3P8_QHN-1dRCVptkhCqOp7I8XSE9IzGQDtOzJly5QSe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 16:42:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Taylor Blau <ttaylorr@openai.com>,  Taylor Blau <me@ttaylorr.com>,
  Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
In-Reply-To: <CAL71e4M8-KtnkC5qQP2iuhON=ROoOTVZfbZB8UhJ-+3KgEP9=g@mail.gmail.com>
	(Kristofer Karlsson's message of "Mon, 13 Jul 2026 21:55:51 +0200")
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
	<b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
	<ak0DUx5Y/5y1OINz@nand.local>
	<CAL71e4PuD9D8LRbP3mfxxeMrM+1q--3sCp6oJs=hezdasZUPMw@mail.gmail.com>
	<alFthqGQjsowvpEz@com-79390> <xmqqik6mbhtw.fsf@gitster.g>
	<alF4rYSTxpQUC38K@com-79390> <xmqqech99qe3.fsf@gitster.g>
	<CAL71e4M8-KtnkC5qQP2iuhON=ROoOTVZfbZB8UhJ-+3KgEP9=g@mail.gmail.com>
Date: Mon, 13 Jul 2026 13:42:17 -0700
Message-ID: <xmqqldbewriu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> I've been pondering this dilemma for a bit. I agree with Taylor
> that atomic commits are valuable and I quite like proving the bug
> exists before fixing it.

I do not quite understand.  Even if you fix the code and add a
passing test, the commit remains atomic.  With an artificial
split, you only increase your commit count while making the changes
harder to review.  When grouping a code fix with a newly passing
test:

  * "git show" displays both the implementation changes and the
    test.  You can review both, and if you agree with the behavior
    expected by the test, the change is complete.

  * If the pre-fix behavior is unclear, it is easy to check by
    running:

      $ git show ':!t/' | git apply -R && make test

    This demonstrates exactly how the unfixed code breaks on the
    new test.

> Too late for this round, but I might give that a try in the future
> if I run into a similar scenario again.

The existing tooling already supports this workflow (as demonstrated
by the command above).  Please avoid artificially making the context
larger, as doing so increases the likelihood of merge conflicts with
other changes.
