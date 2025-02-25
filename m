Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5317E01B
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507487; cv=none; b=R/MZf6URNzhao6LR51ldJM77hAFY3ciH3f4Llupde7NGkKo812GrD4iz1NgPk2hjeZYHNEeMhUghKgnHSGpRuorbCA44AUMrbkXf4knfGaPOS1KDT4twWY/d5Qm51olfL2d3osn6tde6GhHoMqzJVyVOiz9+iWiGlvrcJbt5+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507487; c=relaxed/simple;
	bh=9hWS1Y9Tp+JjtCTZstSfxnSVFaIZJqyAjeGjar/RkXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Teoo3EkSbEFYdRZxiQA5ywScGrMhuy/VqSKxxcrT+PI19wGmB5UTY02+1G6Jzm5rav+LkOjqbmgDqyL9XhS6YZJannUSqz18aFPGCa8Ru4bKhyXysZSet/HTCDDtnHAyvvmFFS6h8NF84oTsqe73NzWHGAJyw2uW1Hr/4KmO8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0t1kzgU/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCO31vx+; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0t1kzgU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCO31vx+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 17CF513809A0;
	Tue, 25 Feb 2025 13:18:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 13:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740507484; x=1740593884; bh=NR6s41OzeE
	oqs06gxuUZQVXtHFwFO+w+pJOcQJPJtV0=; b=0t1kzgU/0mGmMjtw7NsZo4lMFL
	FCBl+HeWuNctnpqpASUyD2o4W/spv1exSyR4dUwbdPTsHUNCPDyodBOVJIva+gtT
	TGpBjbh1yUW2otoNfcVhk53ovMJ3KGfABJkAA9rRCHEw/WMnypzogUSGecpZJUAb
	Z3K8HkRs5Hb/UYf0WXbNG2r20AzOvANqcry6zrNRLWMTMA/DlWRAPAaSU5s4uh4a
	JKId/vpfAoqamzqRPjyOOCx2buxbNF3/xFagVblzjAaZQi9psfMk9zCOp28fWHRC
	1AO16Sv11D/NUDMZrQN3XVCBZTDkvjWlxIFwgvj/br28Fm6oq6b2oKnS0nmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740507484; x=1740593884; bh=NR6s41OzeEoqs06gxuUZQVXtHFwFO+w+pJO
	cQJPJtV0=; b=RCO31vx+OpKjlw4SyHOX2zqCU5b73e/tyDqf+USrvZZW1h2YYJB
	Il6NmmQ1MIS3R7l9Cx+3JyuCeNSFK3VOkvQOIljlFUPr8bkARlyh2evn3ufSbLcN
	xW6OYesy8MW6MTPCmN3ulvQf+7KYcOHaPcu+CShSz8Nck92VUCQjMsboMXsYiAb5
	r0EaSRpVl3bQOwOaoi85EPyN6WGTGPdN1bk7YcM77C0AH0a7lZ8ZKyeCFZhK47JY
	IVZublav5guGlOvuKVaTh4VOPo3t3YiN4qemBI9hy6Dq9JzXExr9rbJYRDtVM1fs
	JPY+QriZi5RjTMtgEICEvDnBE+vJsAju3qA==
X-ME-Sender: <xms:Wwm-Z1SGZHkuERZUgJXYkTJDmcTk3vSo_FKRyT1D0h7WGo0YWMgXkw>
    <xme:Wwm-Z-zF4vVkDvh_myWDXJRlNwc9OhddiQ4y8K3tE1MqyL8LxzQW49jBATF6J8b3b
    aYwZyJXc2JN3cPZKw>
X-ME-Received: <xmr:Wwm-Z62lUITk5IYTJ3y4GyHL_4v8GglGVLVpQKfcQ6sggZhWNSPzYV9QZ0pYunFtxd-JbTi_O3U_nFaDMvC0g7mCPfBdEd1-DdP2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvih
    hkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Wwm-Z9Bkj9GNVIxRvzru5z7bHisNSsJvOhbsjfGLRREx-1KwmVBO7w>
    <xmx:Wwm-Z-iQpJo_vuHJ2ye3BMC2RbQMBqMNfGFxop6h7GLbQ60WUzwqRw>
    <xmx:Wwm-Zxq_CPmXz-fhRVLDS-tecZBaO9kkZUCZsGV3UGXki7dGbRGZTA>
    <xmx:Wwm-Z5hLAA_3xvSf2fBUKM5hY0BRRih2aeqlROSKxFvN07rKfTBg2A>
    <xmx:XAm-Z2e15sdcCchCXiYg4ccBIi80UA-WQ8wBUSm4EuP0agYgMgIg9EEs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 13:18:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v3] merge-strategies.adoc: detail submodule merge
In-Reply-To: <20250225161800.8268-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Tue, 25 Feb 2025 13:18:00 -0300")
References: <20250225161800.8268-1-lucasseikioshiro@gmail.com>
Date: Tue, 25 Feb 2025 10:18:02 -0800
Message-ID: <xmqqr03lkhwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Submodule merges are, in general, similar to other merges based on oid
> three-way-merge. When a conflict happens, however, Git has two special
> cases (introduced in 68d03e4a6e44) on handling the conflict before
> yielding it to the user. From the merge-ort and merge-recursive sources:
>
> - "Case #1: a is contained in b or vice versa": both strategies try to
> perform a fast-forward in the submodules if the commit referred by the
> conflicted submodule is descendant of another;
>
> - "Case #2: There are one or more merges that contain a and b in the
> submodule.  If there is only one, then present it as a suggestion to the
> user, but leave it marked unmerged so the user needs to confirm the
> resolution."
>
> Add a small paragraph on merge-strategies.adoc describing this behavior.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>
> This v3 keeps the same content as the previous v2. However, it uses the
> proper way to declare paragraphs inside explanations and replaces the
> duplicated paragraph in `recursive` strategy by a small paragraph
> telling that it behaves the same way as `ort` when merging submodules.
>
>  Documentation/merge-strategies.adoc | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
> index 5fc54ec060..9c30f1c900 100644
> --- a/Documentation/merge-strategies.adoc
> +++ b/Documentation/merge-strategies.adoc
> @@ -22,6 +22,13 @@ ort::
>  	was written as a replacement for the previous default
>  	algorithm, `recursive`.
>  +
> +In the case where the path is a submodule, if the submodule commit used on
> +one side of the merge is a descendant of the submodule commit used on the
> +other side of the merge, Git attempts to fast-forward to the
> +descendant. Otherwise, Git will treat this case as a conflict, suggesting
> +as a resolution a submodule commit that is descendant of the conflicting
> +ones, if one exists.
> ++
>  The 'ort' strategy can take the following options:

OK.

> @@ -95,6 +102,10 @@ recursive::
>  	renames.  It does not make use of detected copies.  This was
>  	the default strategy for resolving two heads from Git v0.99.9k
>  	until v2.33.0.
> +
> ++
> +For a path that is a submodule, the same caution as 'ort' applies to this
> +strategy.
>  +
>  The 'recursive' strategy takes the same options as 'ort'.  However,
>  there are three additional options that 'ort' ignores (not documented


Should the blank line be added above '+'?  I somehow doubt it.

Other than that, looking very good.

Thanks.
