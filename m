Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AB2AF1B
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484277; cv=none; b=f0mwoAYq2g2J/TCbAF4dcWDg8rekQLoDYmh0BERXMQ9oHj+6XY7glrrJFpTzneoJQOLjQ0oUukj4veVMnoaEnw9SDbZcyjgzPn9uzRq6tkeFU5PES490eCDXg3Hd1Dr1oMz2neBXNIaKEyb90ocHL6B25G2PeYKyuLk2UBex3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484277; c=relaxed/simple;
	bh=F4MV2KH1TVQYsKe7oOLvQVMwNg68sHKuz1Tv1/zJxjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rMoAQwB48qyVI5MPPMLPx5Lyxwwzjmbcbw+2tgMWwPkY7WPhVGCgm3G62MOWWChwaiqep1Jg51C78pAZ0IQ5QNsM0mXFR7XmZ3eCB4F2J1bOU4TaxeeLGPmo/TFb7J40zV2vTph/3HzqE+NnzwlHgqGp+eDwtqENIk38aebr6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4sqv0hJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z7R9kcY6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4sqv0hJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z7R9kcY6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BEE313801DE;
	Tue, 17 Dec 2024 20:11:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 17 Dec 2024 20:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734484273; x=1734570673; bh=jw+D9MnHYX
	g/XNXKS7lgaq5nzbx/7ejQPBtrfFxbcdo=; b=h4sqv0hJOAxZH4CW6lcHO0ObJR
	DCNGE7L/rObZYj5PNHho7zMSC46YNFizHYsJ5M8R2yiQTSsHOxn+L+Ejm61VZfTc
	f1xgEMva5BwO+NKFXJo6qha7QlsjnPcHKVjQFJLgCRr1/0UQgEpbj5dprh4uuzVL
	HGtYcHf0p5OOKEhjrG62yh1POZh++4h1Uh5xOSldrUmxusquk22Nmryi5F0bsM3Z
	jnReynvH0bBA08PA+wRvsy0eTkQPCMj6ab0b1XVBBiFGT29MA3Yl+c1WCUnbBOQR
	BxWS6Ewvnl44lzDOctIPEU5UgmXQlQHA5U9RQTt37b31MBQDHhPl5jNzYUaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734484273; x=1734570673; bh=jw+D9MnHYXg/XNXKS7lgaq5nzbx/7ejQPBt
	rfFxbcdo=; b=z7R9kcY68UvUEPkSwr671RwKfT7DSkW6qVkzjU+YQe/fI9PnCsz
	QhsOVnqU240k9oGzaumS9Mw0logppbBDaVX42+yBk8G+4jiGD/UTIBzjtu5s1N2E
	uXJRmFDw8Cs70ATHbPPwb0Ml1fLlvjrLVhyZ0MmTmV6j6XR34ofiY1DFKrdTq37q
	KCLxKVWdE+cdfsUwGMakZFi/wy5aC90q70aOmUW2hghpit7sscNUWolsxPN9mpIr
	MOurt7IbRnBmtYTbwMtYoMatHFxqdCoZ/S+Jc30DZhUUdNCwhuLc5QV9cddgyltz
	r/0YWiIcQ9xAwUoP1740nrzjYwoGLM2YWmA==
X-ME-Sender: <xms:MCFiZ8V1PVcyC7Zx3wiAYzyxGhPlG1t_WW9bZvI1X256Jfn3cf1iVA>
    <xme:MCFiZwk_jAzgc4vJ7eoiGQBqBsqpr2QTQfHqPkqQ8DF6m-81vcyVwcrPxtVKkLJg3
    6xNJwWuX3KPxvz9RA>
X-ME-Received: <xmr:MCFiZwZFBTq8WTtQxwwWuOOZV39aEEFbPb9PtRw8wIrRESBmp5WLE1EMPGu6iy4cBmfouu58rIvz7a1BncUYDsxb3JH6qi5Q4I-Chxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeigdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevueffueeihfekheeilefgfffggeelteejffeh
    ledtuddvudeigfehgedtkefgtdenucffohhmrghinheptghonhhfrdhinhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhpvggtthhrrg
    hlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:MCFiZ7UzrYqU5RsgkKingPe57mBR_N5AvBl2Y7IXG19HT4uZ1Tsdzg>
    <xmx:MCFiZ2lmU4XNtgnDVcZf2ZpU4Hb1PXN1pPoV2u22CXBZNG9lwg_Zbw>
    <xmx:MCFiZweNN6rFHW5QXKjB0XyM3f9wMxFaf5FIwkYBR_TUZ4GcYym03w>
    <xmx:MCFiZ4HnbOmNdbxMgBQBBVvvm6xp5vMVjMLSRDSeCfs9NdxLuN97oQ>
    <xmx:MSFiZ3CFaaQjesoXlVXxauOyp_pO9Ljr9VY-ZuJdaVymACXaISrqyb4X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 20:11:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2] doc: remove extra quotes in generated docs
In-Reply-To: <pull.1847.v2.git.git.1734483422181.gitgitgadget@gmail.com> (Kyle
	Lippincott via GitGitGadget's message of "Wed, 18 Dec 2024 00:57:02
	+0000")
References: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com>
	<pull.1847.v2.git.git.1734483422181.gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 17:11:11 -0800
Message-ID: <xmqqfrmlyevk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Lippincott <spectral@google.com>
>
> Commit a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
> 2024-12-06) moved these variables from the Makefile to asciidoc.conf.in.
> When doing so, some extraneous quotes were added; these are visible in
> the generated .xml files, at least, and possibly in other locations:
>
> ```
> --- a/tmp/orig-git-bisect.xml
> +++ b/Documentation/git-bisect.xml
> @@ -5,14 +5,14 @@
>  <refentry lang="en">
>  <refentryinfo>
>      <title>git-bisect(1)</title>
> -    <date>2024-12-06</date>
> -<revhistory><revision><date>2024-12-06</date></revision></revhistory>
> +    <date>'2024-12-06'</date>^M
> +<revhistory><revision><date>'2024-12-06'</date></revision></revhistory>^M
>  </refentryinfo>
>  <refmeta>
>  <refentrytitle>git-bisect</refentrytitle>
>  <manvolnum>1</manvolnum>
> -<refmiscinfo class="source">Git 2.47.1.409.g9bb10d27e7</refmiscinfo>
> -<refmiscinfo class="manual">Git Manual</refmiscinfo>
> +<refmiscinfo class="source">'Git 2.47.1.410.ga38edab7c8'</refmiscinfo>^M
> +<refmiscinfo class="manual">'Git Manual'</refmiscinfo>^M
>  </refmeta>
>  <refnamediv>
>      <refname>git-bisect</refname>
> ```

Thanks.

Will apply and mark it for 'next' and then 'master'.

