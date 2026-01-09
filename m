Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214527B348
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970512; cv=none; b=O7YI9uZQ9uFjC/8Rhmi/0g3xMNqItQI/cCOc6GCuAbCJgofBq4e7DOEwk5+DrbLcBAARs1NeliLeo+hIqtz8PwiB3ozp11tLCpoEAypsTZdZ5QXFZFE6X0tx1YeR4LxNxKs3XAU5UBuQGo61VnzRC8L2GS0lV5JIpWP0vvj5ESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970512; c=relaxed/simple;
	bh=3ihsvvEnl9kcEVF6EFvSGJ7DLWGxZGGUKRwPJ35hOO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJuHJ6QK18pQ00ICRyoHwH4N+8AmgBQvMuPpPznRbeb8Zt+pAwH/VDpuh4u9d7MS0E8NCM+6aoM0Th1nzStiA0K2FVe7gQpyDKfFmmK2fFObe3aZMOP282Lh+z/Y04RFiVN8XlEJNJjujRv0xdMI0JeazZ7WZWzL2WP4w/zh/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RU6fCuWq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXSIaDQU; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RU6fCuWq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXSIaDQU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 11BA71D00025;
	Fri,  9 Jan 2026 09:55:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 09:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767970510;
	 x=1768056910; bh=Aavr33onjw13eCCY7dnWQ/acmqnBQ/To3vbD4c1N9uM=; b=
	RU6fCuWqKBQP8d456EnLufWqeNW0QnBJiJYPt/GXrrF/WRu/DxMKasHXWOlgYA7/
	WXxnCr5RkPIGA8Ig5BRyvU307tfuyG7aqhdYQ+ZdGluaIAqdRVlRmY6Tl4XILrUc
	6/aUlEm81v4y0wbhm0JgUuOvKmXvFKKpzGzVViTA6mw68IM57JVKFJK/1A6yrPBg
	N1y6J3i6784zMupApxEbgd5Rb635X98+ndWIiXLLzxH21PNbIm2xjxg237IK2ptA
	MOFJocWGKlEWE1bEWs5ODpzjgw6dsREOnipPp7K5u8X+4I5C9Ifq8ttr7lF08drq
	JYkU2kOenfyP9nzTWFknPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767970510; x=
	1768056910; bh=Aavr33onjw13eCCY7dnWQ/acmqnBQ/To3vbD4c1N9uM=; b=b
	XSIaDQU6tNU3TaX4Xm7ZKoWPT9ah4Py3yId9WYkqx0NnFF0WK49eyMbOSB0s4ClZ
	JCItnD7jAzYt0nst+zebbrq2c7g6DNtJ6a4h/c18FUCD4GtaGSWtS0572NUC3ZBO
	h17YRYhWzGZmsJQVKJaFytuyg07RvrV4jDGMCgOeoWIxLO7mRzAXRI6kFv41TniU
	NnmL1HsiGkfn3G2bIwDp65Ag0dQ7remZyzvp6KDEVRR3rZCrSaCyF0rMdRscdHqz
	GcwSYsQyReItVy3NC54eo4CLZ8Zl1J1ebFyp6lWEJzU7K97eAOFAUn2FV6UvYizD
	XF1gG+AIu3beKp4VT+wpQ==
X-ME-Sender: <xms:zhZhacFH0R-HPk_lM-D7qD1b7awuoYxsC_m19CvF3T3_w-hn5imw3Q>
    <xme:zhZhacWzrXmkzS8401j_9Qkx5jXQQgPr1w754piR_Q1BGydE6UDdo-v8tNT2LZx2i
    caHlHPoNiBruB2KPPoJ65uqQ1p7ZOI4S94lCyWE_lqwXhXOJsOwIMo>
X-ME-Received: <xmr:zhZhabKW_ttXv-BrxnKM3D0NhSxsMA9rbyuPJlbzHM66yaJwLgJRQpQYX85mXpya2f4iLXnzYrQC9IgAd6_3tRQXHdQBGluc_ONm0Tqvcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhushhhkhgrrhhk
    uhhmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgs
    rghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:zhZhac8jAoigqiOfKbvSC72AA_VzMIfHEnD1-vVqsoDF-N0JmxVgxQ>
    <xmx:zhZhaeJuKgchK9WCug4PZ6T0ykUxgpw7QJFN94pG8X_oud6flNw4_Q>
    <xmx:zhZhaRmQnq_tnHC76KI3iDOURkkxCyJKIhELIQHX0r2M2PK3aU94mg>
    <xmx:zhZhaSPk8Eg3-hewY6CA26UlfOEwgcyq11ytLjA2QXyic9vn2MPnGA>
    <xmx:zhZhaWpPTMQ4Hv51SvQDlOFd3bQB7mMyXi2mQlRmQdzqnXxX1E5QGF1X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:55:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12ac3964 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 14:55:08 +0000 (UTC)
Date: Fri, 9 Jan 2026 15:55:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: Re: [PATCH v2 0/6] doc: patch-id: six small improvements
Message-ID: <aWEWydo-P5m0D5xR@pks.im>
References: <CV_doc_patch-id_3.1ab@msgid.xyz>
 <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <V2_CV_doc_patch-id_3.1b2@msgid.xyz>

On Fri, Jan 09, 2026 at 03:25:56PM +0100, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Topic name: kh/doc-patch-id-3
> 
> Topic summary: Improvements to git-patch-id(1).  Fix git-diff-tree(1)
> mention, Fix '--verbatim' documentation, and four other small
> improvements.
> 
> This is the third patch series for git-patch-id(1). This one only has
> small improvements.
> 
> • Patch series 1:
>   • Topic: kh/doc-patch-id-markup-fix
>   • https://lore.kernel.org/git/v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name/
> • Patch series 2:
>   • Topic: kh/doc-patch-id-1
>   • https://lore.kernel.org/git/v2-38645ea253c.1760369708.git.code@khaugsbakk.name/
> 
> § Changtes in v2
> 
> Fix markup in commit message.

This version looks good to me based on the range-diff, thanks!

Patrick
