Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F5286430
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761521385; cv=none; b=b5zK9rSKonzj/4RtM8YXwhRBy1CHrt8hHnA6MmTiBFrILrwbKCleqNLbmdOS79RAoDpBGlizaXIG2su0kefrMWrlvs+z3lluoBI+Ena21OqJcBQVruy25a+ycWWs3lhwlVOy1cDKuYA0TmmyTen+jvW1uHk2ISSzwdM8spDBq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761521385; c=relaxed/simple;
	bh=2TyXrlEFaNYzExdqUqjGJdOjDbdwAjuOKj4Dac6Tvn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CxF+qpTLt72xYCApeGtp1AdrVf+wtMo2grrzLNtrLex+31oDo2iAE4MF4QYZC4sxVuZ28mZ0iQ/g1xiKnW+6EVv/Vg3tecHK2U181qGxgGJirGTbnPxEm78p6mCNyENXgWR3rdrWuyOpJ0IQJFE98ijUidmqJ8PAgycMTC1CvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h6flPYpT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SnCDUnDh; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h6flPYpT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SnCDUnDh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6508C7A01D0;
	Sun, 26 Oct 2025 19:29:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 26 Oct 2025 19:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761521382; x=1761607782; bh=5iex0Q61KB
	dE5g+4wUQv4uOObrzCi+SVrAbqms86nNs=; b=h6flPYpTXa5GuuRQJsA0KhTLF4
	tXOAntZ3+oNDMur3fQ9A8oKkJvj88w/CN4FoivAlaBlwbI1kMKxow81Su7HvrdUo
	uF/HUUP8KIi4FP4jFVTfvCr+qI0uqUSST4jqLV+eHXgvE7ICsAoQgWBaI96Z/CiZ
	8Hc0YUUVr9sIudGFHdS/bQbwLIRfC5kEjHTM5Ou5SAkWQn+451EYj6B7DCLTmCKp
	bLCpcFGhiuE78z9h2sbf3/rq2hI1QoFrXn5gfbFOMbfn2H6/N7TZwGSvTpxBDSPO
	TFIYdP6+i9Dv/upe5X3DE1rs/BVf26s+Ixzo/5/c5Y/XjGtIq9EOKc2rfnbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761521382; x=1761607782; bh=5iex0Q61KBdE5g+4wUQv4uOObrzCi+SVrAb
	qms86nNs=; b=SnCDUnDh25+qREUWqWUHUaC9mPb8A+BuhcPRPuxrBhEdCxk6gjh
	YAbhak8sjnCcxBAN6B72LfqPp0e+Q2xSD/SacpOjjaCJVm4wQN2uWPY1r8ddwaku
	qG0vKIf9qNkTUe66/npjCxfT6uyocHMPReUu+jUJdi1z4XR4IoykghdPrCLJbbl8
	KOqoz0P0uUESzijACzeaEKtcBi492sBmh898Zx8pTFql1HHZwbB2mPQkVUL4bSok
	qHIXNdu3DQCMlkcj7VqpkoP3ZEHY4hK5aXdezualPO8LCjmVIRvU5B9KlS/0cI83
	zF3M4kT9YU+pFbGRUFzYO50OD8ehAsyGw8Q==
X-ME-Sender: <xms:5q7-aCzbjm_qsuz_ByPBGTeNpBOlAzU2MmuKfzFNa_4TV6WTd857sQ>
    <xme:5q7-aFSae3B_GLcjPrIdkBn9gELVHVYoYwlkj_XSxqpoAFHWD2lOJrhHmqOlCrT3E
    UdGlynq9KXpMVJK31kxpgaE9TSdQLpExP7nH6Zooau0XOXSvJjPHQg>
X-ME-Received: <xmr:5q7-aJU7onw8e4pQFBxKSxKxEmVY4m3DOUl6tSys-qKC1XG44dJywqi6jzAX6raqJEkL6zJSnRitZPLhaDgIQOnwKrIxNNMU0v4Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeigeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepshhruhhtvggvshhhrdhoshhssehprhhothhonh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5q7-aHZKF8_eHtQVZ063Qh385K_VABnLH_Ydfll5oIrpyIh2Af45aw>
    <xmx:5q7-aP3t2b83Vm2xlYsZOCqrUjcYuoStGA5QMRuOVowiFzu2GAAs4g>
    <xmx:5q7-aJjwbZWESRTPwz9WLnBxh2Aw1LSUgCYKKGOhnfjftHZtDW6o9Q>
    <xmx:5q7-aDYUA4q9DKxIUy8NYhUeOh7wCWE0kN8xGZHtkLAjA-FC4N7SVw>
    <xmx:5q7-aBrR6WID1GsN5DHuOaqFt6-raGM-porjWZ7k27LoLt3JPi2GPDaw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 19:29:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
In-Reply-To: <20251026152614.GB2095501@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 26 Oct 2025 11:26:14 -0400")
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
	<20251014003404.GC1507@coredump.intra.peff.net>
	<xmqq7bwltlb8.fsf@gitster.g>
	<20251026152614.GB2095501@coredump.intra.peff.net>
Date: Sun, 26 Oct 2025 16:29:40 -0700
Message-ID: <xmqq7bwhmecb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I also wonder how expensive that memcmp() is. ;) Obviously not very, but
> if the point is that we are trying to save fnmatch from looking at that
> one extra character, we already pinching pennies in a mostly
> un-measurable way.

I added the "limit to known bad case" in the illustration not for
performance but for correctness.  This was because just like we
weren't convinced that the "**/" may be the only case that breaks
the existing optimization, I was worried if stepping back by one
byte may somehow make a pattern that should not match mistakenly
match.

In any case, your numbers did make sense and tells us that optimized
strncmp() is much faster than comparing a byte at a time, which is
expected.

Thanks.
