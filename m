Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C11A7065
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976236; cv=none; b=cB4CD1alcCSePBKs1gDdwI6t8eMs2dfOs7x+jNWnP6VSbUA3CTFLIYzWkAPMTAqPjQAt8cggUdtW1m+uOXksmHhZ0eMLwpFi8gbeWeO1JD7eWaQeRCh73m0ooLfTL3uFxDJzzUQrNLeF2xh0ykilEKquamf5gbuY1+v/vzihr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976236; c=relaxed/simple;
	bh=J0b1a9z4S/9ivKox74nLIIvfs8WQOqdxuGhpUya/dN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NvdN6Erumel07Uzj7lQIt42NtCl3crCtUxdZbm3PisVt9/UyNCKFldIHtzfpqxXWJcN7uEXVDfcpN2+Knxb8wxd3uiHq99rfPiALG/v96UkmkAVPtw+4/g7gnh0rtXy0pfhycryktRk5MlLNtb3nqzOBLRNkDvm9ST1JWkvqKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=krYxWKtl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p54IfIyg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="krYxWKtl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p54IfIyg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 459F611401DD;
	Thu,  3 Oct 2024 13:23:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 13:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727976234; x=1728062634; bh=J0b1a9z4S/
	9ivKox74nLIIvfs8WQOqdxuGhpUya/dN4=; b=krYxWKtlkCn4i5q9WC9M6vpYV6
	rNO+MEuwJUCO/xajdoA4egKjw7b5awXSWMuM+F0vEKgxit826cB5vuK34ylppVbi
	00zx8ANH4eWDfpiSbNfly7Iy/QSKIHPreDaIyFdTFwjB2NMgO8e/+cgHieuMSLLC
	eg0DDNnlGthRkHq39hBBEO40ety5t4p4/8ScwaiAyWt9klbgD/C/Dwt0Pvi+0M/1
	VDA5IzPLQLmZAV53QLiSDK8xF33qNQaG+p+zCcIz/IAYxgFjkY+Rg3QF8Pu/oeie
	zW7n4CezYWdHDEOUMHMZULq7yXxdrmneTIBGnnvvLHGDtNfSTCaFAh243Hsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727976234; x=1728062634; bh=J0b1a9z4S/9ivKox74nLIIvfs8WQ
	OqdxuGhpUya/dN4=; b=p54IfIyg4Zopj3hXcxCzQuJ2OEIl1cP2EW1EKKN231IZ
	Klejgy6t+ez1MXe9E+k0crK5Irs9jfwEsbYjMUxnazAoag0EnZLrT6g98EtCfVrF
	UM8f9JQf6ybBLcS157CSWq0rFhdDvyVQFkN+b8E+ESlkkFVOCOPnF22FKnYbiBDE
	9FxByslNmXQjv0wndzH5mFMkUens+sC6ZE/5Apf8yAWf/tdz2/b0f6tuXDeteFW6
	bzV1ZvlnzU9EAlHcvUmmoGrOx2vnVjYq2hDLRWKGKtWEFDLFs/Yv/uOCD8pj6L2V
	wI3aLv/vXhqcDhiqpo3ta2JqJUFAVEAvJsViWHwmOQ==
X-ME-Sender: <xms:KtP-Zk9xE2Cyk6ZiN5nTYgJx87TYy6hGpu90lTKxGHZ_PqAPzKVm8Q>
    <xme:KtP-ZstU3p5s6Oev3HCY7kd2AJVXGj46TOLa9ynxkPkZt0oe1_QxMbuyTF6YnOzef
    BFYRDCx4L_L-hN4Gw>
X-ME-Received: <xmr:KtP-ZqDUXJFIqOLevzlyUciVTyFpfOYRdPoirE1f_42q4G9vIK_mDcD7qkGTjXDhrA2SDMlrAL-KBQ_NhqrOjGA628AkA6mJr8LNCvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhonhhsthgrnhhtihhnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KtP-Zke08VOBSaUqSkdEDSu03bvu1wx5MwXwDLtS2ohxHNIUHD7SIw>
    <xmx:KtP-ZpNQmeUtkZBWBNPrWr_-gso55qB8Wnz-0HfBqCV0UVS7PxfChw>
    <xmx:KtP-Zun8FcPw0pG6vQ5rXv50yX2_H667x08qo3f4OkPTuJQlyMhnFQ>
    <xmx:KtP-ZruW_3gbspnpTsELu5GXRBCCB8MT0IVTcchlJL5GGEmGGVXzcQ>
    <xmx:KtP-Zs2i3GTFTkDfcIHmuqMfXuBXt2_wmyDxXo07uvpSNOZfAMM22tWT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 13:23:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v3] Documentation: mention the amlog in
 howto/maintain-git.txt
In-Reply-To: <88a13b9f2b6e7fbed517a7e268e4e371d84a9a10.1727917792.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 2 Oct 2024 21:09:56 -0400")
References: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
	<88a13b9f2b6e7fbed517a7e268e4e371d84a9a10.1727917792.git.me@ttaylorr.com>
Date: Thu, 03 Oct 2024 10:23:52 -0700
Message-ID: <xmqqo741hzh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> (This bit me during the first integration round I did as interim
> maintainer[1] involved a lot of manual clean-up. More recently it has
> come up as part of a research effort to better understand a patch's
> lifecycle on the list[2].)

Thanks.

