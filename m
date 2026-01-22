Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D891332919
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769123519; cv=none; b=l4OkyY4fZ8fbZIODKQQqmXBtfn+wJYK8tFTWYxtvRtcbBhDwOHHnb4KLUjV3hJRR9Yx7y2hf4qMRVex1ALox5UiAzQwzZKGBCdPJBhDlklEo+vPkFkq8B8hPT2fm2sPLCPlG1Q9hJNvJ1gSCEb1Ho5fruw6oYgJkPQ+GimdyxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769123519; c=relaxed/simple;
	bh=O7hbgNHJ/UzmtR/UHuuwoqqk58yWNRbkz5w89LfjqJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IxX3yEn2zAlciZBf2ovCPKpPmwC/cCFaeRuUROH1cF0YtWxNOr98IlarCk29vXfrH9M6MgU4y89E9oIOYPyjViKOl1mpmZ9jiUM7T4oZBloRR4gU0ozSGy3jb9PCXR827O+tU0nF0Oq8URmtS0a39PeJMUSCqGWfAxiWLR/nUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HtL2hUm/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obZHNQXe; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HtL2hUm/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obZHNQXe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AE18EC0DEC;
	Thu, 22 Jan 2026 18:11:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 22 Jan 2026 18:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769123506; x=1769209906; bh=O7hbgNHJ/U
	zmtR/UHuuwoqqk58yWNRbkz5w89LfjqJI=; b=HtL2hUm/Ypwhq5qB7oFoGtOThS
	mq30W8wyYCpaitwZSOoydOr2kz330COzUCQbtURxpVwsDmX4iQhhm7C9RXAeyHwu
	v6a75M6tTwiCh9BKyqiA8VMPUDLGTkBSgn94xSV1mHUXqCRygpDpyR9hbXwEphPX
	+LFJz4pzvuzgljTWp4msap4Y5nLVpeYcZwtmbAwC2baBJNgcupTl5FiCpnY5IQuv
	bj8MTeKi82Jq1XOlPkm44TAKefjy8zYrdoyyy+JCtU39Lr4u2M3bLnflVWytg8Lm
	e4PjJ+OwKUt2YOCEGMB7CxUM2+wApZcrk8RED1VvGY0HjjuxibW+A5xHB30g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769123506; x=1769209906; bh=O7hbgNHJ/UzmtR/UHuuwoqqk58yWNRbkz5w
	89LfjqJI=; b=obZHNQXevkNRwr50COvZAgaS1kSeXeNvKYIfJLoe8UZqJqhWyqj
	4llEvP2zgRemMNvt87ABoCImrJKnsfEwFuAtnXRMmy43QaKg1IPYrGIvDFfWlUDP
	S2hZVJwXwS2NVNIMsRB7CRryTohu3Q1mYEvPo1T7+w3W+46vhqYGByYRFhYoAWau
	NYEOA6NNxekPKOg+Z0u9mc2OcEhMqyU7nhhi+Y3rVxDWN5Ps2H6/rbylOeg2Am8t
	oo0MtLQfQ3N8uIN3BiDMoNGif4q+tjs6/79cymcrP7LfKoCq2jQDrjytYAcLDc4i
	VZUYyZlvFWVF+rPal950v8Rsf4Mp578mi2A==
X-ME-Sender: <xms:sq5yaW2zEKw06dfhUByajkG6qUkuIDcmILslZMHnsKSSEGSp9yrc-A>
    <xme:sq5yaf85-U3xMcC-Py9MMjpJP5HffxFdbhWTU8S_i3EMR6O5c3-njp1vQgO5r0jPB
    aT0U2Ebswv8oSZfUAbRPxiCGG9aivQBNpX3m__tNW0oCqamA2SFJms>
X-ME-Received: <xmr:sq5yaXNeX1m-SZZtBEoa2DUyaK-RjIk-nwxzbXS9xOY3tVW9bAc4AXTxZcE9sMd4yK7TSosAzGhFPpL-Wj8HoZmKQgWvaOd0jrIbg9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sq5yaTezGw6ZEbcdkMxVGUdxhwjmmtovPB0eKFhxuLew9YskkHx9Yw>
    <xmx:sq5yaWV1mALVxq_vNGWsTDXZFRfMHsbFG5SkTz9ylzqP8s_fMKWMnA>
    <xmx:sq5yabgTe-ckQ0dqJK2iljXfRE9H8YsHVwarBpTXlLQzrQgdQ3sSrA>
    <xmx:sq5yaV_99zbfSyTwHTWnl7OQDiMLfjzPWHQzXOiGzn74aFIprtvTpg>
    <xmx:sq5yaWh-WaRy8bdbj3jqF3Nj_G-B-iY_Iyg5YNt7hMW9W_fq5SwDACIo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 18:11:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] revision: add --maximal-only option
In-Reply-To: <7daff220-f93a-463a-b586-dd876b51edae@gmail.com> (Derrick
	Stolee's message of "Thu, 22 Jan 2026 17:15:55 -0500")
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
	<pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
	<xmqqikctl3vj.fsf@gitster.g>
	<7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
Date: Thu, 22 Jan 2026 15:11:44 -0800
Message-ID: <xmqqwm19jl8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> The merge-base --independent calculation is basically asking for
> the maximal set among commits in the intersection of two (or more)
> commit histories. One trick the merge-base calculation does is
> that it first looks for the --boundary commits, and then reduces
> from within that set. This avoid walking further into the history
> than necessary.
> ...
> And this would likely return the tips of the two branches, but
> also will detect if one already reaches the other or if one of
> 'main' or 'release' reaches one or both of them, excluding it
> from the maximal set.

Thanks for your thoughts.
