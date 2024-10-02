Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DA8F58
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892295; cv=none; b=p4gqrRjEDIf8dquo5sIOJsrQ/BcamQDbMUNovfWKnz4SRXdeYIEnSYOTvDwKwDkGp/yZWi6qwzooQ71bThbhKZC5DNxktFPjEjn60B30eq2gu3SrTVufFaOKKD9rgsgOZdDK73pGxFdLvkvmLhve0XD4c2CKl4vBw1Acyj8dlYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892295; c=relaxed/simple;
	bh=ITEtWLuvbBKGdWT0GKXhf6BvHta76Oe0+MJUr+wozBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G2xizSXn/IpFF90Qy1H3RqDmpWDYPI372Lf8RQfiTJqHXnzJSS/Jlr/DpHQ+O+DF0uzPRifO0Z9Fg5AUBA9iOSlCqnv8NF9lsVamGgpRkzIeh7iY0mpECUj/TqSIZW6MlowiEsuWd2y8LeSl7baMVfQTTuaRpXxAPqoBh5WtT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K0/ZOW1M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OYjRDx5w; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K0/ZOW1M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYjRDx5w"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6546411401B1;
	Wed,  2 Oct 2024 14:04:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 02 Oct 2024 14:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727892292; x=1727978692; bh=ITEtWLuvbB
	KGdWT0GKXhf6BvHta76Oe0+MJUr+wozBw=; b=K0/ZOW1MazqvPwtKegklZ/s1Qj
	VKiluiVFMUbzTlN0Mw04MP0KF4k/y2WeKAoxADnXbktQqceqBJHdH0qid6cyQ0RB
	S7FuguOAZJo9y2Gw829XWMWbD/o9sSpD0/ZfvyCMK0czZYIY2JlZIYidLnvY9UYm
	21IiArXJZaRB/iKcBf17iuHPmm5iYEE02jZb2gWWxGs8aeGK7FKluSSJjMwjCUSM
	oBedT1dES6hHXuEcbYEg/I9oDy2PoJ7s/8Q0N/r7sFQsDRjehmJWbijz7JS2sV1p
	PNAXy5lFPERBn0i979BeoQ+SDQJDEc/kz/MR2bzHQiVXi7XHY3fdp98U0ckg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727892292; x=1727978692; bh=ITEtWLuvbBKGdWT0GKXhf6BvHta7
	6Oe0+MJUr+wozBw=; b=OYjRDx5wCys1mlvApirlpry8lIsG+r1IrwIawvMqTsem
	jNV4v0hX9Cq6OslhmNl4eEnyiPBMIqB308HhMmjtX3j2VL/ldRfyoNcjRjCF+dU3
	0pB2pFaBoQiYpoUEgMGHfP3R49mZo5MwQjuT/RBjNzOeDBu7lxV/6zSg1j9BY4Nk
	eQiPYHBUXheFlPOGFnjPbOT3yZmIKZ6JoWuzK/+3XSjW0ocLkJTzqhCGG1O9xeyt
	V82xnNZEtxOnhC66jD4amorfdsmQN+8STmOynb/8vwyPvbiShaOwFcaxNlPz5oIu
	owNOFqXnrtNFBFyuvKeSifZk0DJZDgil9IEgDKqTpA==
X-ME-Sender: <xms:RIv9Zn3_76aLzFO2TXBiYKdwXzpzA2OJrbzIS3PwTzSF4_XV1_Fscw>
    <xme:RIv9ZmEy7OiRVGzL579hMjmqzExORKhVt4itAaB9_9CQNhzy2cHFya5QH6RljEtpr
    01ANPyWRdsN7YnPVQ>
X-ME-Received: <xmr:RIv9Zn7xoOhc45ko2woqmvW2qBzazBvYpmHJm7TFyxvxLRiDzGeAkODPdyfycm8JzIf6rGrNwVPXnLTou_YGLrCVbXmFTbr9RIvpUew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrh
    guthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:RIv9Zs1yic4wCz1UtUANVxG6I2cgIFavlG6S_eTBkvoA2wOzk7_1SQ>
    <xmx:RIv9ZqHT6UQIejvRAM9FfHxVBiuu-KKonAlB3Ukr3s5K9K9qaK_a-Q>
    <xmx:RIv9Zt9dBKMcejDgoxLy55clLRgxJnR9ExSQS4jBzyqnK7RcZZjA4w>
    <xmx:RIv9ZnnjY7OKfLmZD6QOpU04GtQQSyMt0pShfL8ICHauPKw0ON3ktw>
    <xmx:RIv9ZnP6BCSIu9xy3FLZCfi4FrR51cdZCLyJK5EUgV_6Xn-rvTfCVXp_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 14:04:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org,
  Edward Thomson
 <ethomson@edwardthomson.com>
Subject: Re: [PATCH v4 00/25] reftable: handle allocation errors
In-Reply-To: <ZvzMIWNfzmZL7eHS@pks.im> (Patrick Steinhardt's message of "Wed,
	2 Oct 2024 06:29:27 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727774935.git.ps@pks.im>
	<xmqqzfnnyakq.fsf@gitster.g>
	<7740463b-84b4-4a69-961c-278ce2901f0d@web.de>
	<xmqqjzervd69.fsf@gitster.g> <ZvzMIWNfzmZL7eHS@pks.im>
Date: Wed, 02 Oct 2024 11:04:50 -0700
Message-ID: <xmqqv7yamldp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> `FREE_AND_NULL()` would already be detected because it expands to code
> that contains `free()`. Same for `REALLOC_ARRAY()` and the likes.

Ah, that is very true.
