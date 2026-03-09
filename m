Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22F3D5227
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067701; cv=none; b=m1lgtc1gF0YbwFGIwJL03owfLjP0hjCqSpJDhrUEh25PZy3jh+c89jMlTFoqi0k1wYRC0IohZ84hlyXDwsqwNaO/l+T4jbnbE1UGIANKkSEaIQjuXbH9rL/LDs1atQsnWf/LVDVSd7lKqlMcVco2/fSELXor90iG5G5GAIrR2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067701; c=relaxed/simple;
	bh=4mdjSBRPYG8iRLk0NRu5m0WqU7wea+ievMpDEh7XkRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWSPTn7MXhs0DsXYt4CeB81Rjeo2nYnnjSrFVrKaf1JWYnkkjNPrapqSd4Dxz73c5IE3WAm9MkLu/tRQV/9+Gl3MsnanVbbY6JEUtJqXv5nyMliclTB3JOlNvxi2Uf6li4ABxAT/FLfflIZHGpBEb9ju46JCwTo0FRv75bwKlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JP7RQO2c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZrQFABt; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JP7RQO2c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZrQFABt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A0EE140002F;
	Mon,  9 Mar 2026 10:48:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Mar 2026 10:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773067699; x=1773154099; bh=Z6Bg2xTt+d
	AoWgXQQoYIZd04yrKMBexX3icexKz/hfA=; b=JP7RQO2c3bNHnOqLb8mDxp7cww
	25p9izukFleEiN0wLAoAKzEtXW3NWczBzZR6RDnaH5VY58NRozBtz6njYLKunf+F
	oL0XYriA/CC9w8ISmGCbxOVWL7Hw78nGhxDBm6I+ssVddYlpyXwZDHumGBBiElpT
	4/lCR31E1LvS9rMWUvvUb/WY5oPfscnFmlGgrhMGBqarT1Syli3pO/gyQ+sp8sRo
	GIiMmcxivsqqTK+gFhfmKgvIGTUr8LGv0MwSzspF8Uv45MNZuqJdkJ2GaaUBuoNx
	TlJcwD9wtBEOw+i0zR3n5xCz17/soZl/ZAYtcovozwkjuBQAurI9iaupZW6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773067699; x=1773154099; bh=Z6Bg2xTt+dAoWgXQQoYIZd04yrKMBexX3ic
	exKz/hfA=; b=BZrQFABtZ00Y44cBYlUJoHV0N8DOBqlYEOY190SyU/w7ltozVCw
	CdbmDT4/Iemc3GwGmSQNOnXAEk6uBELAlyA2h0gmwaduplv2TlVYxVykHh4V8h7h
	Mrc5Mqohkjl/uTQuaMLYEJjCiwgVxAEihKRRu7wIbGzVJIHB/ZdUM2shv+v9dhov
	rJnwhORCY47A2cHgFaLOaEIBHPujChMT7uhilkzwFBtMMTyFZT+l2SGeTxEOoSH5
	nWAYcgALxXUixUgGn2DFKHtX6/2tHd1RlDPrOHT+ENZWknnKgzh8PVaIJWynq+fR
	kZIWRR+iXIneIjFSgASq3xcmVJ2pRC/2b3g==
X-ME-Sender: <xms:st2uaYcFfegZcMcjUv0lC2Sr-AmkVLk-KxXiOLF51OMYTBDkaIqGww>
    <xme:st2uaRNl1d0ATN1Xvs9DYoELXDY3uGwjT-HfzIjP-iGiEWopQLJCi5cH7GvXSm2HH
    croVqysBo45EBjvVB3cwp-Wsk4NqFW9_ZyDcGwQwac8iRI2pPvOew>
X-ME-Received: <xmr:st2uaegoGUIQiS5czgQpvhQKFA7_Ay47aZg043j_1jTeGuq192S4eS6XocYuOROyK1jE0NMU6pqmxwRyJ-srRGPyjg9_JgvJVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvvghs
    hhhighhurhhgrghonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:st2uac3odn5TmBsqhElW8Zc3Gbk8YnqE8eICDpq9FuVKLEzd5RdQpA>
    <xmx:st2uaQiDBr7zsmuALmmUjKg_rITE8WrFea7eQyShhKf3NQv7A1eXCw>
    <xmx:st2uaUdIdcwn-6whq_b7uXLO2Txw3qKwIo1a4mFBxn24OZdUxXzn3g>
    <xmx:st2uabmjPijCt7p7SjEy0-M-r2aeDMMvlFjR2i1Dg2s66sIgSkRoTQ>
    <xmx:s92uaSf36sWiSLBZ5v0tNSnF421PM_Xmcs8mRZFLwrT9rxJ7_cwCdllf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 10:48:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v1 1/2] worktree: do not pass strbuf by value
In-Reply-To: <20260308180359.31188-2-deveshigurgaon@gmail.com> (Deveshi
	Dwivedi's message of "Sun, 8 Mar 2026 18:03:58 +0000")
References: <20260308180359.31188-1-deveshigurgaon@gmail.com>
	<20260308180359.31188-2-deveshigurgaon@gmail.com>
Date: Mon, 09 Mar 2026 07:48:16 -0700
Message-ID: <xmqqh5qp6oun.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> The function only needs the string values, not the strbuf machinery.
> Switch it to take const char * and update all callers to pass .buf.

Makes perfect sense.  Thanks for noticing and fixing these.

> -		write_worktree_linking_files(dotgit, gitdir, use_relative_paths);
> +		write_worktree_linking_files(dotgit.buf, gitdir.buf, use_relative_paths);
> ...
> -void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitdir,
> +void write_worktree_linking_files(const char *dotgit, const char *gitdir,
>  				  int use_relative_paths)
>  {

This updated function signature makes it plenty clear that the
function does not modify anything in gitdir, so the caller shouldn't
be affected.  Nice.
