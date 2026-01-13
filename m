Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722882749C7
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332374; cv=none; b=JbftrUNfWy5xFQm03B4no/co3wq0AOASG3ClgMpminYE07vFU+IDGO3JnQCzEarlJJ89wp28WeiZvasZR4k8YwqvOMrPlqqPSWKsiZNrJ7vUe+nm3/oIYrwnTuFUN4FNeVO2W1s9IYxyL38ntFMkE+ZahfizPhsGf46OI77w5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332374; c=relaxed/simple;
	bh=WeJ3HaUye8oLtybtcUTAu6l0RbY5MBDg2XuyjT71Y5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ne+4lDDwoLd8P93jO402eiQb2XPppfqBZBiAd6KgAM9g4imaeV5TFwYhY9jiYDcFWar94x4OeCcstZxfTuFscZ7q90L8uFWfA21CndAev0h641f1fO7ckD+BLrAzJXNhvR7fpi16yJIkL6EMYOtI65C6NHSdubKGnBFcfhjzxKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RMiMR2RX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RiSSR4YL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMiMR2RX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RiSSR4YL"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D251EC0233;
	Tue, 13 Jan 2026 14:26:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 13 Jan 2026 14:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768332371; x=1768418771; bh=4TuS+j2Dzw
	eoQjiplC1JgqM1Wng/e0TIkU+/R5tGDFo=; b=RMiMR2RXoPI0wQnfESRGimmqHl
	RFeHQys4VZwY5UhPZDPgkfJr53+0Fkt0LdHhvffY9igIYX4ImiKYBqw7rTqNj9d9
	tZd2jVg43n8ROl806J+mtZ5McDkm4Bih7OJOs/w08BDcmIoGyTYhotXrJjxP0X4J
	TxFzkbuMqwtEXH0MJmSfjNW6H9qhHjmhWmfHmb04LjpLowN1xhv/clicpv5zVO8F
	c0Qx0a+ZBpjJhtaVcUDoS1yS1q2CjSyB8CayQZeHl04e7AjybCM/3FRlMGncOsyj
	X+R5Y9v2Ixehnkw9Q3GgtbCfpCk34iVLVT1/bqiaPTm5WMgqZZwBaIjShJxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768332371; x=1768418771; bh=4TuS+j2DzweoQjiplC1JgqM1Wng/e0TIkU+
	/R5tGDFo=; b=RiSSR4YLaifuYJe+/uTVdlGZcMkRdCs135gauzvcxzQ3FyyxXT4
	qX70qOlkcXRPUPNyEHmGSihElRdqp67CZxTWOdNYj4rL9jA6LrAjT2CEXxymYqEY
	45jmMHPaM1jWbrStStHwonYPo497uA/nGN+8/BsBqJGEtXnkdb3Y5ilh7s7gAPC6
	Eda4lAqDxBdz/AQIZz7LsvyxTxRNGP9fwfNJEpCr1NHS75G7yPEFfd0wTkUe1NFo
	LHZry+5PsOpNNK9jk8/ROrhvB0nT1T7XhT/KTzrBvgvlCnFnO5xTjkI5PNYbzqxr
	YrudjEQ3nFMV96zofRPqZ8AaUWYZAmk06Dw==
X-ME-Sender: <xms:U5xmaddX3L_iA8EH-35R7oLKnH70hxzkFXiwPSyQwoW910txMd_UbA>
    <xme:U5xmadxwpEYoVq2mu5llQ0ZpfZj6zx_S-4qNk6Gxiw9ZrOhC4Yg56ePiT31uJ2qrq
    i2D4mdJ3TaZK2JNoRUJPTr_EDbIz8gWlXCsROtvPs2YqDcgbKYG>
X-ME-Received: <xmr:U5xmaaKKVysypECxx0CZGtqiY0bymOm2v1Wafiz1Hc_vAnvNKjV4T46YGteoamvWtKHvxzPrYqJw1ugLhOo4ZuiqtVK6NfglTX0LjoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdduudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:U5xmaXFIuHHlfyRNIFbD8j5XZjgi6g9x7vNEuxsu62H62qgMgM1PYw>
    <xmx:U5xmae-NOESp4VARlAINj5iGT9hcMTSjEj0eXnbq-F9VZpgjdczIlA>
    <xmx:U5xmafLejgeoDPsGP5AY0xboL8Mc-WIyhapQTGtkmHI8FF70F3VXqA>
    <xmx:U5xmaUtVQcDy6Q0tsPpkZzf_8S2EerBVL7Go85_tYieSHBPjIiGehg>
    <xmx:U5xmaRVWM_tNvBSs25a1FariUnQT1TUpC-vXAyLqWy-_3-pKvBKwaO_m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 14:26:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v2 1/3] environment: stop storing
 `core.attributesFile` globally
In-Reply-To: <b6f8deaa405a59812265160fe1d41ad515a9f388.1768318762.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Tue, 13 Jan 2026 17:44:00 +0100")
References: <cover.1768318762.git.belkid98@gmail.com>
	<b6f8deaa405a59812265160fe1d41ad515a9f388.1768318762.git.belkid98@gmail.com>
Date: Tue, 13 Jan 2026 11:26:09 -0800
Message-ID: <xmqqzf6hiab2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> The config value parsed in git_default_core_config() is loaded eagerly
> and stored in the global variable `git_attributes_file`.
> Storing this value in a global variable can lead to unexpected
> behaviours when more than one Git repository run in the same Git process.

There are quite a many global singleton variables that are accessed
by git_default_core_config(), and this patch addresses only one of
them.  Are most of these variables per repository, or are there some
variables that are inherently just one for a user or for a system?

>  extern int warn_on_object_refname_ambiguity;
>  extern char *apply_default_whitespace;
>  extern char *apply_default_ignorewhitespace;
> -extern char *git_attributes_file;
>  extern int zlib_compression_level;
>  extern int pack_compression_level;
>  extern unsigned long pack_size_limit_cfg;
