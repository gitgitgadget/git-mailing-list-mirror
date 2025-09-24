Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332D280004
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700558; cv=none; b=BNZ4813EHOZ2wqcRy4yW5WJiLVOhJAecPWiAfYixF9AhF1XAOMh65KCCeNJoMLgBiGEXZwvHuRVm72n3MWeGfFIryLZ49g0TjfON+XoPy96ErqJyEFfGq2W4IGLs6d0laopZRsJNhgQSIjClx2NFcnSbSwvNzP4S000Me3/CBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700558; c=relaxed/simple;
	bh=4JjdbspGCSMB9sDDoPXYB0Ca9YXfK3sEkStpDlsR6s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYBc8KW5zQQoiSJMnX66vfn9Dg6qgQf3QchKl1bbwNAW5FMKqk+LvFyq4VeYebu6VPIXeu9lGlqO+Cq9hzDpHMWsqhRglMdrBaenESkj+LJN7oECFoZQK4QkevEUHB88Gy9CICPzjtoYfQUEMb3XQrwVf5LnVDZ2Z31pQXSuXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k/GoyMSU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sh24Xtlm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k/GoyMSU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sh24Xtlm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FF591400087;
	Wed, 24 Sep 2025 03:55:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 03:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758700555; x=1758786955; bh=i89ZkieCOu
	XoWQ18MkYlQXq+WMCzk6UUECQBMgUKNA4=; b=k/GoyMSUhUztq80mUWTe4SkDnZ
	uUCzAgIWY+Z/R5qGWDtsvJiPigXV1idgtLXNjZlUktTgmHMQCk533mdsEsML78ni
	x+kdbGGELV7p+08AFXcBnnqjGZMWvFicAXfogFK79XR7AAgJ28G0vr4RbdZVqkY7
	nUq7BBGgoRWevRNeU61DDuxS+WSUslu5iYCEoVX27pKSvrQjC/sPx64ZprgjN00n
	A944kRlY5NIMiGJ4buqCNE1IbiXeDZgYiL6H6n6ag+47td0SlF8YpFrAWJE/d7fX
	WMqzryvt58Aa4XXVdfTDgBDF7XmirXVY9cCQt6ygmrOWJ4F2iURGED+PRWuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758700555; x=1758786955; bh=i89ZkieCOuXoWQ18MkYlQXq+WMCzk6UUECQ
	BMgUKNA4=; b=Sh24XtlmW29nBfULUU86uoBhF3PqPV8z0KxO0ub+360uJTaMGCG
	bHE0dDm/Beh45/P+yuxkeo7N5GA6B21GxRaYWt4i4NQjA2wTJRFzcEb0655Y8rdm
	5cwRwcU+z8BUKIzo/MI+YcVpC0ALTpdQJI4a9FEVSd1ioA9ZGdYXcUPEUPC1E6d4
	N7kljYk2bMoKe0C3VYMiu7jvCZy/Uq8nJn82J3tGmSUDz8jk4KbJ73Nx17uuJbd+
	wPnZ6N/CKZImbz3TtYGZmyuUIQZJQVFgKhBR8eLQyexBv9RcQZtpgyXGRfMjMBEj
	LFtMa+BY6xWfPuH4ev03JVp8HRfGRZF6Ckg==
X-ME-Sender: <xms:C6TTaDHeAbnbnia1RqA3S0gx_FKX4EF7do-J9mH_x4Jrhc_NmT3hCA>
    <xme:C6TTaHVhxinJySbDjMPF1mvdTFp-5IqxYJbYgwLyTxJkU9fl_IFTvIa9_SFG-6sv3
    vwzSDRuRde0ircPYASBpBze1beMl-Fjox3-Q-z2-vEwz9izMazF-w>
X-ME-Received: <xmr:C6TTaKKqzMB9XhD5RcQHxniAnhTV-vBdKOgTSqtANXiwUTbD0_OwE1uOHF2UwdBPHuyC3gjFKpfyYdQfwpK10TrsCpZp1VXC8aVnHLq-vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:C6TTaP9A6pqDagrORgeoP041NCaxCxIlkxax2OgaS84iTGfdLG-ZVA>
    <xmx:C6TTaFL8dyaJTwx4A6lnDWkxf0pqcGUZ0XgKJOvVvZNlDBZ_PZdI_A>
    <xmx:C6TTaMlo9jNoNlR0Pb2YPMbAcyXxEh0vonMFelBMw7SYomO5Axm76Q>
    <xmx:C6TTaBNHRvE0cdXh7P9Zh1pQnoOUsaQHuCW4ECqST1WocBpJzqsEGQ>
    <xmx:C6TTaE6w5g_gYF57Obt21vZ6wzv24IDpw8LwQk9edJyDSRDRL9W1zE-I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 03:55:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57104116 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 07:55:53 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:55:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/9] docs: add documentation for loose objects
Message-ID: <aNOkBuigxCODIcVN@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-6-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919010911.649831-6-sandals@crustytoothpaste.net>

On Fri, Sep 19, 2025 at 01:09:07AM +0000, brian m. carlson wrote:
> We currently have no documentation for how loose objects are stored.
> Let's add some here so its easy for people to understand how they

Nit: s/its/it is/

> diff --git a/Documentation/gitformat-loose.adoc b/Documentation/gitformat-loose.adoc
> new file mode 100644
> index 0000000000..c8bef606fb
> --- /dev/null
> +++ b/Documentation/gitformat-loose.adoc

Do we maybe want to call this "gitformat-loose-objects(5)"? "loose"
feels rather generic.

> @@ -0,0 +1,49 @@
> +gitformat-loose(5)
> +==================

Makes me wonder whether we should also have gitformat-reffiles(5) and
gitformat-reftables(5). Obviously nothing you have to do, but rather an
action item for myself or others interested in the ref backends.

> +NAME
> +----
> +gitformat-loose - Git loose object format
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +$GIT_DIR/objects/[0-9a-f][0-9a-f]/*
> +$GIT_DIR/objects/loose-object-idx
> +$GIT_DIR/objects/loose-map/map-*.map

It's a bit weird to list the mapping files here without explaining them.
Should we maybe drop them for now and only add them once we also add a
section explaining their format?

On the other hand, maybe it's better to list those files and not explain
them compared to not mentioning them at all. Not quite sure.

> +DESCRIPTION
> +-----------
> +
> +Loose objects are how Git initially stores most of its primary repository data.
> +Over the lifetime of a repository, objects are usually written as loose objects
> +initially and then converted into packs.

I feel that "most of its primary repository data" is a bit misleading,
as one can expect that most of the data should be in packfiles instead.
How about the following instead:

    Loose objects are how Git stores individual objects, where every
    object is written as a separate file.

    Over the lifetime of a repository, new objects are typically written
    as loose objects initially. Eventually, these loose objects will be
    compacted into packfiles via repository maintenance to improve disk
    space usage and speed up the lookup of those objects.

> +== Loose objects
> +
> +Each loose object contains a prefix, followed immediately by the data of the
> +object.  The prefix contains `<type> <size>\0`.  `<type>` is one of `blob`,
> +`tree`, `commit`, or `tag` and `size` is the size of the data (without the
> +prefix) as a decimal integer expressed in ASCII.
> +
> +The entire contents, prefix and data concatenated, is then compressed with zlib
> +and the compressed data is stored in the file.  The object ID of the object is
> +the SHA-1 or SHA-256 (as appropriate) hash of the uncompressed data.
> +
> +The file for the loose object is stored under the `objects` directory, with the
> +first two hex characters of the object ID being the directory and the remaining
> +characters being the file name.

Should we maybe give a hint why we have these sharding directories?

Patrick
