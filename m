Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A8194151
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662579; cv=none; b=qDYd9T8No9zbNNfqgb8cg9wXV25ayYQFv1aHCFJxRg+6zIP7e97yzPyZAGigHyUPvGqFp5namBC+ranW7lgjVkc9pFf/1RsQFGBYuuHqu5MHysztCX7PfA3KFu74TjbC72VNrvg+WNDE1mqUQm44NBGIW5o3ySBoRbAvzLIbJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662579; c=relaxed/simple;
	bh=YlGnDPkRPWTFeNgPgcIF+zsdYd1clAjcZihgmjLx1M4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xq3oWeG2/QdTAoaeTVP9theGzzwACeAfEdm8xTzoAuXFuD4qnpV8M+xH0Zu+RBwvLK92BKNBtOHzTV71s+Rkzsu2sobTwPC+u4cNdGs4b+M/+4Md9Ni00TSUVzgas3gGdzJG3GCPz+vYtffHohwef+sSdt1S9tTuSeikveeAQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mYJUVdE6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/U7/8nP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mYJUVdE6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/U7/8nP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 9918B13801F4;
	Fri, 11 Oct 2024 12:02:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 11 Oct 2024 12:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728662576; x=1728748976; bh=ZmgIN0IY4i
	REANy9fZo3ZqHyruGWPXfSmFut1o1gBPM=; b=mYJUVdE6MFJ04SOD0CImZNrBWV
	F4zdxhsTPrOmeZUYRcbtX0EKtup4/bUibfCw1grs++ViGYRoYHMsmODh8Ji2/L9V
	NHxP/bd4Q+yyB278sLwsRHnbBgn+pcnmgjhPZ8PC+cbpOUXEVgsdFQ0EmJJv+CLS
	SNJ+5JYr+ONjjzhh33be+EHGMWmMRFOd2Gbd1Zs8l2cUhtOnD0y4YFC8jRaaBqHj
	0573DTplrSbYnXSkVrYNRFbmuTqXXwakihuk472uT+8/zFkRgnTAqXFcxTZBXOTz
	rLmPe8dNOWq26MDMyCzk4owXQVidDHoBI+Wg6rRHo8e7lcUOJaBSAnvC+Uww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728662576; x=1728748976; bh=ZmgIN0IY4iREANy9fZo3ZqHyruGW
	PXfSmFut1o1gBPM=; b=J/U7/8nP7+CvPZYBDSLWhbi/m7mHn0at3VeJV6tNY1HD
	ueKGexmvrTi7lmVvmL9emZ/RyinmJHFQ/X2Uc/0R/VyveCeQGmALisA8pFN1Zvsl
	zI1mLpf0gsGADk3itP3x7m1+GQyzWw8/oyaAKCu3KcmqoOlpMO6EBK7uV9UGju+N
	24CE6z99YCxNaY26ntJs5H/oBUPnWER+cKBVyTShX0a1S+55esJn0sd8yxt6HlQl
	n9X10p2DQosiQHId4BiFFCBz+hysd4sf7aRqhSElVdYaqJw7/1jrv5UFNt4HmPZv
	eyf707LfdTE/hGJRduW3xG1SVgR24Gt4eCZcR0jbyw==
X-ME-Sender: <xms:MEwJZwul-e9DosAhwtBMfVtGP1vFU1N2-JOOifI6U0k86Ia2BJ4DLA>
    <xme:MEwJZ9dDrW_dXc4CBiAQoEK5Wgka8E5m732411alv92zjJrtLCBbNiBe0UCr1vDFr
    zRURAgCl9H02UclHg>
X-ME-Received: <xmr:MEwJZ7xkTStKD5aAwKzFvtnbuZpq3Myk6B5dPpbJ1gXsnKC2wyh10M2Nx95fFjMBwSzIs5yEwywYnOLhpzHwWnjLTddZS9doc90nv0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegthhhiiihosggrjhgrmhgvshdvudesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MEwJZzM4qCL-OmKMhlpYvieQn0xQg9dowerMaMgewH-09npn_Ie0Nw>
    <xmx:MEwJZw-EZSl4UAYHlb1KuZNzgnxj9b_gAsWspCXhGdlJ1SvxxS73eg>
    <xmx:MEwJZ7VQmRUGEEcfdxZGqvkx-MgUvSL1p4pKqtHVj2n_CjMUQd_lcA>
    <xmx:MEwJZ5eMQ8DNw-9PjPw4J7nBLAjjhQ6VTaV1PXJ8JIvYujP1c1_oRw>
    <xmx:MEwJZ_mim7wHIvcaVbiNXy0bxcaLthB1AJTowrjNhgFtnnDNEaIYpBLV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 12:02:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  ps@pks.im
Subject: Re: [Outreachy][PATCH v3] t6050: avoid pipes with downstream Git
 commands
In-Reply-To: <20241011154555.584917-1-chizobajames21@gmail.com>
	(chizobajames's message of "Fri, 11 Oct 2024 16:45:55 +0100")
References: <20241010063906.51767-1-chizobajames21@gmail.com>
	<20241011154555.584917-1-chizobajames21@gmail.com>
Date: Fri, 11 Oct 2024 09:02:54 -0700
Message-ID: <xmqq8quuiq4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

chizobajames21@gmail.com writes:

> From: Chizoba ODINAKA <chizobajames21@gmail.com>
>
> In pipes, the exit code of a chain of commands is determined by
> the final command. In order not to miss the exit code of a failed
> Git command, avoid pipes instead write output of Git commands
> into a file.
> For better debugging experience, instances of "grep" were changed
> to "test_grep". "test_grep" provides more context in case of a
> failed "grep".
>
> Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
> ---
> Changes in v3:
> - remove some duplicated lines of code
> - fixed some typo, an ommitted input redirection sign, <,
>   and another omitted logic negation operator, !

I'd suggest looking at your commit title again.  "with downstream
Git commands" sounds like the git being tested is at the tail, not
in front, of a pipeline, which would be perfectly OK arrangement to
see what its exit status is.

The updated patch does indeed use such a construct, e.g.

> +	git cat-file commit $HASH2 >actual &&
> +	test_grep "author A U Thor" actual &&
> +	R=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&

here.

    Subject: [Outreachy][PATCH v3] t6050: don't lose exit status of Git to pipes

or something, perhaps.

Other than that, looking very good.  Big thanks to all of you.

