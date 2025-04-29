Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA9221719
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945723; cv=none; b=dh1Ylwk72I2lfdiQ8FdcnENxTHAr3Mwn/oBRaiGkg1DSB8q4g+1Ms8LHhtaR9O6kJ1t1iySExKTunTgOhTIsNZce56et1pL4hoRinuClheXFrsKzDXd8Zi2En7+TysZSJXLd8I3mslkqX+HJNTnTphEd/P65dGlam+rU4ZjF4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945723; c=relaxed/simple;
	bh=fy8syY7lEdwp7gzpjHnnMJEImJbxlhzbP/AFUQvDuAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXWSPYe75k3WfAuZuKUTphHUcoo/y0aMB/QPGeOTeIIlGXZT/zTYKGO5Gid63621bjDvUx+LGkcDXSXURKEF7BAwV0r+jrCxnDdwhQkYmgUmNaC56GvF6uXzGliNH+hfJ3Un4pIEqBMVmMx1qcUg4Vg6ZuIhNjd6de7NsKgicRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fsu32pMf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhHwes95; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fsu32pMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhHwes95"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A2A213808C1;
	Tue, 29 Apr 2025 12:55:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 29 Apr 2025 12:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745945720; x=1746032120; bh=rentAgwz8s
	vLQYs/UA6i8Yriv0BwWatSiezKBfOS1Ao=; b=Fsu32pMfULUAduY+OMQwALeBna
	x6r/lhb2uQ9Wmyfrk+TQ/ahASH6Qu9c8kmnIM4HAvozkuJZ8jT58Q7TFWIJLklMk
	sHCdKV737bRmZv+G3H6KT1GgMd/Fo8sIP1dK1xe6TGU5DKcfjTWGfuldjiubK7jF
	KDAI6NL2Fw5egSw4qsIJLZL+cB3sVzljeOlUCcbehwLj/53keFVDT7IiDZdSl4Zo
	lWs2JobLC9dk+x2Kakgd+k0LqBwD/LXOMcXGzabdDOqNob1hTctF15UeEz/mtdAg
	5g8d6bo2b+3k2OH6jBYmF94e17356nvZWr+HNqVUKB3/R4rvTx+YqMMjUyNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745945720; x=1746032120; bh=rentAgwz8svLQYs/UA6i8Yriv0BwWatSiez
	KBfOS1Ao=; b=YhHwes95S7+dotd7J4ikMjqRYBx5IVpb/cdrlrQlsoYZs4V1cNz
	ZWTDKUq+BXEwKYIfN2HnxwtigdU8UHDXeNypRvqAObHioGX655Ljeu+oI6sRvDrW
	6va41Qei53aVAydlyqJdBlbn+HSj9FCU+tNXVCRHjanaHkv3PgEdnR7+BTtS5ol4
	u8NhyK2YUrFOs/sWmJ/WJB4VKNdbJLinNuSp6yAcyV+wFT5vHYRzJULo6zqMnlMQ
	qL2wMX4LmYQ+wUax3dgurquCULAwqZTIer7EqKonNZY2TqkCT6w4iIiU9fNe5D90
	jMPIRf7WlIWtHcn8XfUCfdWiOcNR+YPml4g==
X-ME-Sender: <xms:eAQRaLZ7lKkxYfxsDjDaOashWvRm8oWr3BJMYFqlinBTwBhTMB9EgQ>
    <xme:eAQRaKZMHMN8hThavLwEMHOy1imqZYH4yWpV__ub-YyaYrCbtfdep20eVOHTkux_h
    foOT0k8-RSErb_S4A>
X-ME-Received: <xmr:eAQRaN8eUhQdNqJ_ScI9Qaqq2raBjF1glfJgBtMYmHokxXdC8K_AtFV_-rckI_4635EKfmkCgo9t7giNZwc6_KqaF7KG-9tNIPYP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eAQRaBrrKotdxFhYMAwUOaoCdE_wPYTnjWuAqZ1QejZmrZhP6vgVZQ>
    <xmx:eAQRaGo6u1SQPBr7E1N3LEXsMRKsXIVUmTIV70l8HHgBcukeMIirnQ>
    <xmx:eAQRaHS30ZAdLHOFLV_SHskSi4t1e8bWDQVD4fPi-QEmKunrF0hhtA>
    <xmx:eAQRaOrlqj0cNYpQwRQdUlfHjZvbQZIkpxrte5xijYC0e1RL2GBPCg>
    <xmx:eAQRaF0sNrVGMvmatAjrU6gvF97umL4v9g8H06_v6ApvZCLSTK2oAN8f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 12:55:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] hashmap: ensure hashmaps are reusable after
 hashmap_clear()
In-Reply-To: <pull.1911.git.1745941663160.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Tue, 29 Apr 2025 15:47:43
	+0000")
References: <pull.1911.git.1745941663160.gitgitgadget@gmail.com>
Date: Tue, 29 Apr 2025 09:55:18 -0700
Message-ID: <xmqqwmb26h6x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> In the series merged at bf0a430f70b5 (Merge branch 'en/strmap',
> 2020-11-21), strmap was built on top of hashmap and hashmap was extended
> in a few ways to support strmap and be more generally useful.  One of
> the extensions was that hashmap_partial_clear() was introduced to allow
> reuse of the hashmap without freeing the table.  Peff believed that it
> also made sense to introduce a hashmap_clear() which freed everything
> while allowing reuse.
>
> I added hashmap_clear(), but in doing so, overlooked the fact that for
> a hashmap to be reusable, it needs a defined cmpfn and data (the
> HASHMAP_INIT macro requires these fields as parameters, for example).
> So, if we want the hashmap to be reusable, we shouldn't zero out those
> fields.  We probably also shouldn't zero out do_count_items.  (We could
> zero out grow_at and shrink_at, but whether we zero those or not is
> irrelevant as they'll be automatically updated whenever a new entry is
> inserted.)
>
> Since clearing is associated with freeing map->table, and the only thing
> required for consistency after freeing map->table is zeroing tablesize
> and private_size, let's only zero those fields out.

Makes sense.  Thanks for finding and fixing.

I do not think we want to patch all the way down to Git 2.30, ...

> diff --git a/hashmap.c b/hashmap.c
> index ee45ef00852..a711377853f 100644
> --- a/hashmap.c
> +++ b/hashmap.c
> @@ -205,8 +205,9 @@ void hashmap_clear_(struct hashmap *map, ssize_t entry_offset)
>  		return;
>  	if (entry_offset >= 0)  /* called by hashmap_clear_and_free */
>  		free_individual_entries(map, entry_offset);
> -	free(map->table);
> -	memset(map, 0, sizeof(*map));
> +	FREE_AND_NULL(map->table);
> +	map->tablesize = 0;
> +	map->private_size = 0;
>  }
>  
>  struct hashmap_entry *hashmap_get(const struct hashmap *map,
>
> base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3

... but this part of the code has been fairly quiet and the patch
applies very cleanly.  So I'll apply on top of bf0a430f7 and merge
the result---anybody maintaining Git for their LTS distro can then
merge it to their favorite ancient maintenance track ;-)

Thanks.



