Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66325216448
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427400; cv=none; b=mS2EAKYv0+t7qaWLgze793YvHRNMaasXzuQj77OVfWEtVhdd0xIsPYqhl3o1okQ3UycvGAqGMz6UB/yxWeeppHowxvaQcHvuFoKRsdLH+Qelw1Xue0eERznYL0Eiu6Ce8NPKTcFU/+WKPX1NXIqGaWncvEVEA2Dpt6pcSKuKqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427400; c=relaxed/simple;
	bh=SEdCCp+RRNiiDgCDemrGMgcOPiQqf21OB5TUTlTGMbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CnWp/0ayeKWmPSGZGpxa2+3nquYAx8HRV99r0Xq+7IEDXXAbcT+ARtvjUM80LaSkmAsFZ/bgYRZiXSuiaAA6RvClgWz/duUhP6Y95HP9n0pNVW3y6KG37DChsJO6YXU9ECCZWJRXiIDYmqMsoVjbYoCyXCXcZW4qabSRcIHjKbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=keBEbcAg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eo3dgYFd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="keBEbcAg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eo3dgYFd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 435AB11401C0;
	Tue,  8 Oct 2024 18:43:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 18:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728427396; x=1728513796; bh=64fJv1jYvg
	s7fLQ/Bb99Ojokrb2E0GAa/25wGhjiGRo=; b=keBEbcAgG+SbAFsFERgiZbWv7T
	Pfee+iDmdMKevOTo1fAnAqx3RPYXRuV259OFrn6h/T6Qn5QNFKGlAjs10KmNluiZ
	ZcWxMbmM+qRXUCQtvPESTVBFMhqNdeqO7sFttTpkbqiflEQCtG+au7IHDNEyxNN+
	+VSftVZLcOo6d6Hci8dfT1lC6aRV1iXiDRRq3EnC7t5+gXGT4euqvIkLsan9GUS2
	K4nMqMZbHAiRRCqJXCOuHp+j2sRaHM0RNPcOKJ3ctg3QNflzSXuPjzNWWHBitIM+
	9gt4be1O6iwjqxc2Gn4kdzVLgc7sXONclvakjmNWMMI2dX3GgZyvMUcG8GkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728427396; x=1728513796; bh=64fJv1jYvgs7fLQ/Bb99Ojokrb2E
	0GAa/25wGhjiGRo=; b=eo3dgYFdDt4jHmyx5r9hNAHgLjM2G/lOuMbdC6ECtvAC
	XBLKb7yf82VA1v7SJDGC2DyXWwbMMQDj8IZCvcaS6hjbKn3QfUTVIUfv6HfGLtG8
	XhzR/tmHjBEltxX8hU4r+UuPifMXaCVClh18tD9b4bkqKbJHWsG5KqcnUFkfRqkb
	m2V4tymWpsHKvx7TpY6i6fjxwp4j5HL+QxO+AwCeWym+JHJWV7LTHa9+BadmWJxp
	bu+P2aNAgC+C5tpbLOyjCyxVOZcQF1rjclYrkHvS0kqk5vkxoPqrclqv2a3ncorb
	izyDSWajMoBB9iDPtAv5uhuGBaDFbOvQwND9vvwrSQ==
X-ME-Sender: <xms:g7UFZyMDOsET1chDvKIMD56JKq_pd9VuT49l38SPIVE1t0-AfYRxHw>
    <xme:g7UFZw_kvurigvylfyafHpr_ZRIt1LV7GmpLFuOXPAIZ6iuCUr79QyAFyxYDUNGWT
    I-j4AoTTAGImfoyuQ>
X-ME-Received: <xmr:g7UFZ5TsYKux5K68cq3wTb6jhxQwUMUzXTLUGIwCt_uUmIT5ZUauFQhK2eLYbKtw6Qsaf6P2Tid8DHK67Qyo3vGJfTbD5-ZQBQ6JIGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeike
    eufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggr
    lhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhokhgtvghvihgtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:g7UFZysfJcKNAWWymocc92OFgq-OJGNjo6e9feziTKx0993MZqyjUg>
    <xmx:g7UFZ6ertkXCXNqBXZYRnWpBQTB7GYilZtqD9LbhqOMp2lxRsoC88A>
    <xmx:g7UFZ2282V286LMKpSfSvbNY3nxPrY2c5cqzbtgrL3_I7fi4hBsQlA>
    <xmx:g7UFZ--5GEKASZlCPbyfPushJFzRWNEw-WhnKFp_vrsIovtSYbDmYw>
    <xmx:hLUFZwuQdQHkCT1BKOGEgSPSlZ9-IKYKH-y3DaLgIPFPoxJEYktfWJv2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 18:43:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  jonathantanmy@google.com,
  sokcevic@google.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 0/3] repack: pack everything into promisor packfile
 in partial repos
In-Reply-To: <xmqq4j5mz295.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	08 Oct 2024 14:57:42 -0700")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20241008081350.8950-1-hanyang.tony@bytedance.com>
	<xmqq4j5mz295.fsf@gitster.g>
Date: Tue, 08 Oct 2024 15:43:13 -0700
Message-ID: <xmqqzfnexlku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I've managed to apply and then merge, so unless review discussions
> find needs for updates, there is no need for immediate reroll, but
> if you end up having to update these patches, it is a good idea to
> rebase the topic on top of v2.47.0 that was released early this
> week, as we are now entering a new development cycle.

When merged to the tip of 'seen', it seems to break t5710.  It might
be due to mismerge, but can you check on your end?

Thanks.
