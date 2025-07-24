Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5A223716
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390437; cv=none; b=rridb3emRMMqURYHlvMzWgHXCRW682f6W/4e9CMCX2yZnebpag3PCPvurPKTOv3snwUvZkhzRu9e+t9KHZ0Nd+UltCmGmbA5DSi2DhLHVyUy4lv3SJONCNprB4TlEhbh/7VgV0ycuh1vz09dHGT+LgiKZJxq106oqgc4fuvbids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390437; c=relaxed/simple;
	bh=kuPrzkXxCDAnhxa8KlyzEm8QEychnP4jQARRb1LZOGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HsX36j6X4srOm+zNNsOb9AW+9NBLLwol/mbmAQWOhr1TE20cT+zjx2p5Gm7IAKCGs/ZswdxYIcrFM1a+FXiQeKpddfz1269JfRc5FPjDpYaaRYTval3P/iaB6e1RyMXv9xyWy4jWPA/Jihj8KkS0eHnVo6Zfh8EpWJGolehPFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dkJ3Kt7E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NkzhGBbG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dkJ3Kt7E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NkzhGBbG"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A9A25EC01C1;
	Thu, 24 Jul 2025 16:53:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 24 Jul 2025 16:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753390433; x=1753476833; bh=ZJ5rFZSZUh
	9KC/w4jcWVPndrC+UQ7I6rbv6gKEnqkG0=; b=dkJ3Kt7E0xAsZHnVfDcvjuVpAn
	G4G+3eEcBLG6iXEmRoBZ1zBXptyx6PhZbZM469UF/TqaV8NHjuhnHIXSNEfGCOK4
	ldz4Ro3wi4MYuktbIZezhN1dNplgmS17Ks5hX0r5gAD1CmtF/Avk33DBM9QFawjG
	cN2Ecrx+0z+HUqOdUV74/8M2rTBABm9IOZ7e0R6Va89Qm/Nx1l0mjaP/ecjuzMvy
	q6UcpN0lb7Vqb+8B6o58PvyuHieuiF9xMgM2Y5tKTl+kS+nhPE0xV6NXf4Jwerly
	KBPkdgUaMFeaIvry+ALCQujHQ2jcXOwMbzuy+DW9JnDcBNMQpjM7vyzSQdRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753390433; x=1753476833; bh=ZJ5rFZSZUh9KC/w4jcWVPndrC+UQ7I6rbv6
	gKEnqkG0=; b=NkzhGBbGiRvZaJEGyBYuBT6SsvCdlSUKWqpUuTgtmKkUjpfnhKQ
	r8MCcqJ2uU2sD44dBP6oQLPSNk2HUP8vWgATYQDGwtSPQ52wmiTo//UL3u4hm0F3
	pn3ySCthW0IqKKTjv+mrO/eFHygrk+gtQA39po2J3yN+dD+mBimtKDnDUxzFaRjW
	drdCQaeC+YbtF91B1pRw78QsHUNsyM8N1jRGVbOW0p7dlvgJxTD0DwD4YI44d1f+
	Yiyn71csx5H5FIfAEEYh13qBKn4Ijs/h5aBwFZ/BaN27vuVSvmtvGb034QD4O7DG
	tqrYzjox0Ap05NWTsr4C43mKd2ZdnF+6cUA==
X-ME-Sender: <xms:YZ2CaMME83CcMwpeGRKcpahhGDBgnvZIDxyjlavaRssY4ySTVzRQeA>
    <xme:YZ2CaGNBAiB790WYpBDgS9UHRQRY9dnnZekcD6hlhihC5PEH2tL5sP44L5Eynd9j7
    krcAyschbxehGtPOQ>
X-ME-Received: <xmr:YZ2CaMtMw7F6WmnSvuVxmYPJpDa4iowBLaUgy3E6sAxN6FGkegROxTP4wsh43l4ytQDQ8KyfuOpZvmMS_o0LHVYuSVOTjGMcFZt6bqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttd
    ehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YZ2CaAWQq2b9TJHfxjKIZG7cvndo7hkUc2szDSrcuHJffCCVKCMo-Q>
    <xmx:YZ2CaEtRnv-JnY4MENJTA7tDRdUeTyRfSazLuL_q45kPPvgairs1hw>
    <xmx:YZ2CaMUIaXxsXnm1Ce4YTDE9Ddy-PkAY7xGtrrUIzD8gZFZIpHwe8w>
    <xmx:YZ2CaHl6ZKVthyFam5U872PQTzwXdNB2nllMSD1O1TmkqogY3cIDYg>
    <xmx:YZ2CaK0vTmzVVaBWMlGg8C94TXETpND6REwcVlmX3xU-unymDaXnUNO9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 16:53:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] submodule: prevent overwriting .gitmodules on path
 reuse
In-Reply-To: <20250724152418.45226-2-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Thu, 24 Jul 2025 20:54:17 +0530")
References: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
	<20250724152418.45226-2-jayatheerthkulkarni2005@gmail.com>
Date: Thu, 24 Jul 2025 13:53:51 -0700
Message-ID: <xmqqjz3xz4ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Adding a submodule at a path that previously hosted
> another submodule (e.g., 'child') reuses the submodule
> name derived from the path. If the original submodule
> was only moved (e.g., to 'child_old') and not renamed,
> this silently overwrites its configuration in .gitmodules.
>
> This behavior loses user configuration and causes
> confusion when the original submodule is expected
> to remain intact. It assumes that the path-derived
> name is always safe to reuse, even though the name
> might still be in use elsewhere in the repository.
>
> Teach module_add() to check if the computed submodule
> name already exists in the repository's submodule config,
> and if so, refuse the operation unless the user explicitly
> renames the submodule or uses the --force option,
> which will automatically generate a unique name by
> appending a number (e.g., child1).
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---

Very well described.

> +	existing = submodule_from_name(the_repository,
> +					null_oid(the_hash_algo),
> +					add_data.sm_name);
> +	
> +	if (existing && strcmp(existing->path, add_data.sm_path)) {
> +		if (!force) {
> +			die(_("submodule name '%s' already used for path '%s'"),
> +			add_data.sm_name, existing->path);

I'll locally fix this funny indentation; not a reason to require an
update.

> +		}
> +		/* --force: build <name><n> until unique */
> +		for (i = 1; ; i++) {

I think you can narrow the scope of "i" to this loop alone.  I'll
locally do so (and if anything breaks, which I doubt); not a reason
to require an update.

> + ...
> +		# Now adding a *new* repo at the old name must fail
> +		git init ../child2-origin &&
> +		git -C ../child2-origin commit --allow-empty -m init &&
> +		test_must_fail git submodule add ../child2-origin child

Shouldn't we also check what this failed command tell the end-user?  E.g.

	test_must_fail git submodule add ../child2-origin child	2>err &&
	test_grep "alreayd used for" err

