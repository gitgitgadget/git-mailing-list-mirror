Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833483A8F7
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760802274; cv=none; b=hu/YW/xLbAhPR9Fqddy0lNAp6XvFm0Dh+k+ibIUeCMOQWB/r+hHSbAj0mxEaeMtM4mylSIoOp2bztUS1izStWXXhv4JZoYAxAORF8VO3tGnZlfE0fvOogyIiHztLYFRHnUwu8DeAR5kC6XEFgA2//ySHtupxPpUu8nA93IdDejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760802274; c=relaxed/simple;
	bh=rgr3NZr9ypqKOBtOfKf4c8yDUmBmU24Nz08o+NSpSKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rgexXJaFLHpJkwgvHvvMn7xZJR2o/YQkMFa25jOtpehetFAKfrYRkIr1FoFBNKHVLtVQyf3WSozxOfN72ErxVZpwlBnFmL7ZZAeZPcgbpMqTciltrcFIhG6/i+8mVnk95dgeEfTFfoZalJttqwn41tMvU5qwhM+DQjv4Hd+1ZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H41IT93j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tc0LBdvv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H41IT93j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tc0LBdvv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A1C011D00097;
	Sat, 18 Oct 2025 11:44:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 18 Oct 2025 11:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760802271;
	 x=1760888671; bh=ng3umn9KHQo/eudSsxv9Ld6eTpcL+qs5cwI2r+HAHR8=; b=
	H41IT93j4h+pk9M0039pCAmFZyL0BsRFhe4sAKH6eBSlbdOCJYQBhIcTNMbyFLWC
	DqyMULqluL7vBWGICxfyWYhdxhHcSEZ32O4apA3p6B1IuN5q3I7tR0oULRSUsuq6
	f3ptNmUu5s7bfjQVIl0VTZggqeZ6CB5GMrYLkjWBKLiZfdrtr3QjRRUpEw4E1Vwa
	ksPiEwz2p7AOTV4hThRVdAF+wADQFR4FvCL/zPrRcbX539VoU1I5MHFGUKQFzzIZ
	K/enoXhR4pAqoaT44qaZbv0pvAXzWC1IusTXew98gIr4lH8SpEsmbyNj/iGQxQwB
	nk7QXXR0TgG6wnoTD2Qr+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760802271; x=
	1760888671; bh=ng3umn9KHQo/eudSsxv9Ld6eTpcL+qs5cwI2r+HAHR8=; b=t
	c0LBdvvf+ZcwXfe7Jmx+/azor+hYN08mXeX38cRhqVgDQ077n2M7jkv+rAXtnCMm
	7gOUgotZeiHIajY7pgRCeMwKJB/CHAbrHudvQC9nIuleAryf947QcNMWClDs1uma
	aRNmoG6vYP0Wo1xgqG/BWb67WxvDWHwSmw9fkQxRXjwSFrwtc41qFpTHWwIiQqxK
	RXhGvJ+lrENs28MMSfusON6KILzAwdiPDkwNtyeyWdBQ9GvMYCzKrl1OXi3+TKb8
	BaXN8lJzIo2sVwH1WXx7UKX4L8WMuGg6XtkATi3fBBlRTurbuVs5If5fYCamhiQm
	t8lFIDSF95bfdvwlK0j6Q==
X-ME-Sender: <xms:37XzaDu6WDgSHhEu4a9xndnVElAe5_NKoDr0kuX9MeFYEfMuU1v1MQ>
    <xme:37XzaLUzqagt95bnTCkzuDZ4A5RVM9jDmr_GJRM16c7oBbWYdybEJGmC-K3urU0_6
    xzEwLOi6F0RAraxs7k1D-EVqj2r0-oOQ4ayQ7IMWkiNuQxVuBJpk0I>
X-ME-Received: <xmr:37XzaPE0bhjD9iEWJ_c313yEfqmsXwwFIbZPC1WHNSwBJoGt_xLTpfEKRIlcUvGkUV4W5crVWj8Sjw65RpvyIzhy2fKUEW3PJTG6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedvgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:37XzaN06Srz7mu7KRDgL3uLGjnu7FbyOof2jtTQuxjCtymaLtzTlsw>
    <xmx:37XzaBNbT_tGtNqLTZ6C37TAEy2qS7VCY1gT-CCz6_zNNg0akak1Dw>
    <xmx:37XzaM4yHcAm86m5uYczhgAJejnzGwLvDeIzQoFi2SBuQY8QUN4ElQ>
    <xmx:37XzaL39NNiYsiF370QCC6iQ7xNu3IJyZtM_7iS6nlMrVSAqRkdm9A>
    <xmx:37XzaMXx_Pd_0KWo1DOenWreTW0JB53GeiiTlgWtXpz_P9Iq-pSV2Vx2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Oct 2025 11:44:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>,  Jeff King <peff@peff.net>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
In-Reply-To: <20251018094722.GC1060824@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 18 Oct 2025 05:47:22 -0400")
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
	<xmqqh5vx1p0q.fsf@gitster.g>
	<6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com>
	<20251018094722.GC1060824@coredump.intra.peff.net>
Date: Sat, 18 Oct 2025 08:44:29 -0700
Message-ID: <xmqqa51ow6xu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> On Sat, Oct 18, 2025 at 09:11:34AM +0800, Lidong Yan wrote:
>
>> > Test that exercises "git diff -I<regex>" is in line with what the
>> > original b55e6d36eb wanted to address, but given that we saw a
>> > recent regression report like [*], I would have liked to see "git
>> > diff --quiet" in the test as well.
>> 
>> I will read Peff’s test and see if I should also add some similar tests
>
> What I was hoping was that we'd apply my patch, as a matter of release
> engineering (backing out the regression-causing bit of b55e6d36eb). And
> then you could make more-specific fixes on top (since -I would still
> have potential problems). And then you don't need to add a test for the
> regression case, since it's already there.

Yup, that matches my expectation more closely, which is

 * We'll do the "send to /dev/null as we used to do before the
   dry-run thing" on the 'maint' front, which will be merged up to
   'master' and above.

 * We'll queue "here are fixes to the recently introduced dry-run
   code" (without the /dev/null thing mixed in), and cook that in
   the usual 'seen' down to 'next' down to 'master' route.

In a distant future, we may consider removing the /dev/null thing
once the dry-run code path proves to be stable and robust.

Thanks.
