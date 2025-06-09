Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBD1ADC98
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502087; cv=none; b=Bqo73cRT1gTCekysooXDvacAHclzkwc//5LE8Ptv7jKo7Oe1gyIp0VH1PUQcfy5xuKmA6kfJEw7mY8kwoKf89NEYUOKi5sE7G9haTpTXXLQgN0Y+sGfHZG0+K+mlJYm87dqqITr+MnXp6Mk20hp+kfLkQWVxNtuR3/xdR7H9xKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502087; c=relaxed/simple;
	bh=aRyHXcu+mIvl7go+6JKsmp/Tm4EIFzYgCOH+0gqMCIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7nAiwScpa//zIRFsc9RjxCX/uDv92Y1axRC1gjeNgQkYFo+OYDtYmIHsyu31nxa9lgQsTnb+5cxERfrFIO5Rs2SjCtLF9hE5wLbW/1b9ddtiaoZM09keCPOgsWpWTMNCkSrlb0xkt+zcAZrk4sQGIjIHi2kPHbRBNePqGxb5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WFOxP8Ah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PA9KgdsX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WFOxP8Ah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PA9KgdsX"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BBCFC25402D1;
	Mon,  9 Jun 2025 16:48:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Jun 2025 16:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749502084; x=1749588484; bh=sQvknPbkdi
	ZO2HPua0a498yIWiyS+X9cYkyJFiQT8/E=; b=WFOxP8AhveVDBXTChH/2o8P0b+
	AWTydM98l6vMeu678ViRYhIIgLL9NTs6Jfks9TW0WkTFnPcdkW4C2D1ez5P06tM/
	LEjcwWOl7Rs59pL5QbtbMi/72KUW4YTVv6lG/mVmZlHWrRqphQNTMyi+Vqx3C0ks
	TvSDOdxi0RhK/NWgzIbfho4MnHOkgPMyj5xFvl5ZutQdRPZE44ss+01aFn+7i0ec
	15vcGR9eqFzHHaLUb24VW8yFwLm4RUqKZyEmWcrGnvPZ3SCVT6Re+dqmtj3IefNb
	Zwe3ymsvpEgZAuSAHnhsPa75y4c01xGRQRNSwdHhSKg0gS/oK/Eg90kFo7RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749502084; x=1749588484; bh=sQvknPbkdiZO2HPua0a498yIWiyS+X9cYky
	JFiQT8/E=; b=PA9KgdsXnAoTSIZ80X5CRw3NTB2HGFgcHMQTkGnBI9KJgSpM1W0
	C8aq3xYP/o1rbwvVaOQ/kjF3ejfVSgRC3EEM0naqreVPUu0EvUj4bg2nmMsbTq/6
	HvAFI79vHXRcHgLHhxz7vV9pDz2ZsI1Z7Wq7nGSZ4f/qq3CPnaM4ngyqMAHx5rvg
	kua4Taxi+iWQrwjqP6Tv/zXW6Fmc/dxwzVgB7w4+C836B7bTMVjklI+UqsWyo9JL
	bmBtYX55bxoMWD+76Rd4xTaXEeTUcwjBzldpMKCfeazACf/xv2yIDCgoMxDAm11o
	T4bfU3i7iBBlZjKMtsAwEsD13Q3WnBlXWBA==
X-ME-Sender: <xms:g0hHaPK8P8g07j6sevt7jE512vCVfzD4_wkH0DDsm0mb8grAVWSsYw>
    <xme:g0hHaDL78tll8ZLl4VGf2iPBFBkE-0dl9ZX-HroQ8OjBOKRJBZaK8XQQ-0Yek__ea
    dzFvD3rc6Tv5lDnQg>
X-ME-Received: <xmr:g0hHaHs4nP9Ole9ifevSEPis2FOJ2XZXZSw5hDVnv_-0Qdcxr9kVH1uHjj_Fj8z1NsbiZU-Crde210OgHOL4gvNv7exKeL1q1vyW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeljeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohephedtvddtvd
    egfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:g0hHaIb6iTDJcdKe0eSWbK974lCjG4a0vXS0hB0NWGFcA1K5WlTrwQ>
    <xmx:g0hHaGbTnwXDkZtz_Z_uA5MK1Kv1nbYM1OUWFgjAL3MDkj1JosbFJA>
    <xmx:g0hHaMBC6dPAoyQOAOm5aN122E2_Zi670V1ZdzRj2ywBJzCPuAxj5w>
    <xmx:g0hHaEZ950fZkOJINq8FescG-WHM-J-GjKqoG99ob-4W1TjppbAIhA>
    <xmx:hEhHaLAfFQqS8HLhKGO6pj8f9h7VjbqhAIn46QjXiHJNoIjzAPdo2fZ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 16:48:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2] revision: fix memory leak in prepare_show_merge()
In-Reply-To: <pull.1989.v2.git.git.1749456990648.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Mon, 09 Jun 2025 08:16:30
	+0000")
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
	<pull.1989.v2.git.git.1749456990648.gitgitgadget@gmail.com>
Date: Mon, 09 Jun 2025 13:48:01 -0700
Message-ID: <xmqqldq0prpa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success 'show unmerged index' '
> +    git reset --hard &&

We use tabs for indent.

> +
> +    git switch -C base &&
> +    echo "base" > conflicting &&

Let's lose the SP between redirection operator ">" and its target
"conflicting", i.e. 

	echo "base" >conflicting &&

> +    git add conflicting &&
> +    git commit -m "base" &&
> +
> +    git branch hello &&
> +    git branch goodbye &&
> +
> +    git switch hello &&
> +    echo "hello" > conflicting &&
> +    git commit -am "hello" &&
> +
> +    git switch goodbye &&
> +    echo "goodbye" > conflicting &&
> +    git commit -am "goodbye" &&
> +
> +    git switch hello &&
> +    test_must_fail git merge goodbye &&
> +    git show --merge HEAD
> +'
> +
>  test_done
>
> base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
