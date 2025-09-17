Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4E302770
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134333; cv=none; b=JNGiNBEvucCjYgoMOeyQJIHtjvlQiwSVcb5aSMLkRh2Lmgcj3llu2cqHhFLeKZqMLj+9anOQLP7lRY14ZLF+DThNggHOcuuf/isAZCZr952FP//xCx8obh2R6pdZVF3uvDuYjvwofyW0stfpib3fywvRyebglVIfyqnE4MtKPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134333; c=relaxed/simple;
	bh=djzM7tavbRJqxkjuuw8N2Bo9LBBqUtOyY0Xm02PLr2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BccP/fu7E26haaPa6vtj5H7j8XAQv0izm9nchFzbgN9wuZ0oivS4mrNGOJmDJbgvbukvk8v5jPMygGe8aGYZR9BGA7Ky7CFRZ6wdeIONM3LnyDGiRlaIayFG4jwvZnJzEwgDVK7SPbyTQ0JtX8/hVTbQ7hSkujZ2sifGCOFgM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vD2O+OeP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOp50/s9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vD2O+OeP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOp50/s9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 48099EC02AB;
	Wed, 17 Sep 2025 14:38:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 14:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758134330; x=1758220730; bh=eGplanwSI/
	p4ixWsf1p9Ubitu1AIcdkYalApW2VGxQc=; b=vD2O+OePlAWy+d+DCN3xjWzWUe
	TgGJYCq/OSx5gXXg0d8AfG3UN5U9R2DiaYvfkquIMNOPaZykXYmYsKx2z9TxLAfO
	VJrAVnHopukurXlAPY8ZttT148y+nR3ZnWlSUasBgZpckbq9PQ8Vp4whAtGNVYOb
	Wcr44EcZNrkdii6iaX/Zdt4tDV0pb08nnGEeXG/UIySRvbfAhNcdW69WSJUcw6aX
	ipBkU0f0vJF3icsbVVnX3UggM2ujkaaINrl6sV40pO5pnu+AIdba/GXPbubtMusv
	5rwi8VG2vJjEU9KXtUKk3G/FYXzGsUcCuBzxD8r4lZ9s0bn0dMkF3eEh0ZHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758134330; x=1758220730; bh=eGplanwSI/p4ixWsf1p9Ubitu1AIcdkYalA
	pW2VGxQc=; b=UOp50/s9Ino/LIieo6mip+1knRyAhBkwhHL9G/+vV84S/vvct4m
	m/K6nW/+9HPU31NEBmxTGBvmZsdwKa9Md9XvcyL/Ea2iTCwgDl7B1n5lZyTyNCSk
	MFIOiJ9+yo1jmwcg7BzxkYKCf2FFNk9FH15Lf0bq2WU5PZz27Rk+XvyC6lwrTOEm
	hXc6WGqmd0y9bqoCpVPGf1olY+xtr6/LTRk8DYeCTAxnefjDmtB6QPL738RyYP/N
	P4s2mXERMiHamME5a7aJ1mNbgFXEi/JTk3xVg9D1NURhTP4Mp7PIBiLNxWCW/S5l
	qXgUQnGNzeJv2u4qZW+H7P2xoe0+RliUMDw==
X-ME-Sender: <xms:OgDLaMnOpvfeF46jh4gRvC_SlW_2e4HKoAU6RMgKOM5bM8iOGrD16A>
    <xme:OgDLaHU0LeJ0fLZh63U_OvozGFp8vYWYkeQpdEZI1XkwyV7OpfdJsfay2YQDatCI2
    jCVcF9k7_HBt1rsIQ>
X-ME-Received: <xmr:OgDLaBGe3UEbdAyG8logPAwkWe74rjIjR00jCZMly0jacCsxgyw_9_v5aILreMXwln1QyPeBSaexhlagyMERc3R_9mlo-Je77j1L7aI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OgDLaDdQIdI5OvVoqdzjGGds-Jv_JFJJgTIuB3YW7qzi2iMS3cPDsw>
    <xmx:OgDLaCLr8A5nvRNwdP7TgrYYrNuXvezoA45ROJSc6Tx2d6Xvx0F57A>
    <xmx:OgDLaIHxZWXYAvmCN3HXwbRIglXSSwExO9FAFJrACRS3xvkIpwb2bA>
    <xmx:OgDLaFD7vjurW9-RRqvsu7OQz8sGXxCFgKd_byuxx9VLpun43wCZsw>
    <xmx:OgDLaG1cirn14FrxxzP1FUe7k_TxwnV0u22HphTG_yjNO3k_D66dIA1B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 14:38:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 0/7] doc: git-checkout: clarify DESCRIPTION section
In-Reply-To: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Wed, 10 Sep 2025 19:14:22 +0000")
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
	<pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 11:38:48 -0700
Message-ID: <xmqq8qicdivb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in v4:
>
>  * Rewrite all the commit messages to try to take a more Problem / Solution
>    approach, from Junio's review and thanks to help from @nasamuffin in
>    Discord. Also change the cover letter format to match the style in
>    https://lore.kernel.org/git/CAOLa=ZStgwBN0fMK3YxoqeR+1i772f621supva3Kvr7YPq4g8g@mail.gmail.com/T/#m8c99a3144cbdfb445e04f8f83a79364bfe8d797d
>    , which hopefully matches the norms of this mailing list better.
>  * Try a different approach to the "left unchanged...", from Junio's review
>  * Bring back "index" (with a few hints about what the word might mean),
>    from Junio's review.
>  * Bring back the numbered list at the beginning from v1, since I think I
>    misunderstood a comment about lists, and that the original was clearer
>  * Fix an issue I noticed in -B ("instead of failing", not "instead of
>    creating it")
>  * Add a comma after branch or commit, to try to make it clear what "either"
>    refers to in that sentence
>  * Replace "will fail without making any changes" throughout with just "will
>    fail". I think the default assumption is that Git will fail operations in
>    a clean way, and that cases where it does not fail cleanly are the
>    exceptions that the documentation should flag.

Thanks for updating.  After re-reading these over, I think the
updated text is a vast improvement.  Also, after waiting for a
while, we haven't heard much more comments on these changes.

Shall we congratulate a job very well done, declare victory, and
merge these down to 'next' now?

Thanks.
