Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB32247280
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541418; cv=none; b=jxCFi1JEGI3rZAfffxRHnSShEtGO6107qVF+hPoz5DyWQ5aFU7CDPtHeaVQjluMVzeR1MuVeUPXhpDOTe70B7DAMJWFNhnju9wnfNXBVUMvMhjs86wU9ofeLhI+E3oso9RU1ryoHcqUbGKzM3VMwSB/dZdzEhiKN9QDbyO3rRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541418; c=relaxed/simple;
	bh=SJPj//sOPQxVTCclsN7W6d0DpAudfYGKGjNGjtSRGV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SKBe5UPyOUhqpmAHdrdrMgjtPpMuWq+sA2PJ64enJQSeye4R0kF/8EEeMWmbmvilBPOuPhD+uW84ZQx+85NRgT+RISYSEKFH+s500x8grCBde2WYT5M5OQJHzdRk1jiqW/Zgr3GmSroAx3LVO/MyRY46kdKDLf9ga9q8uWh9Sjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2m+JBiXN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ScZ9QBUR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2m+JBiXN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ScZ9QBUR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BB60AEC00AF;
	Thu, 19 Feb 2026 17:50:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 19 Feb 2026 17:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771541415;
	 x=1771627815; bh=qJ6Arxc72iCOhqxvQTg4tMcQ4EN6X6aKh54pUpQ08kc=; b=
	2m+JBiXN6rZtwFJTyMs+qtjBtnCEuHq5lgsUTg2IgolN1opLwDLyRs55P8/K6owj
	Y1g8qjl8n8duYQ7l4PA9mdKAuSTkclKDRX4UvEAcXDGdTYADjuh8j3dX0vpt3f/j
	mqNbjmnHJDy8dfZRjF/bsyk27JKMm4pkRM+lG2VzD4601w6opNm96lWX+Tu6xcQA
	5vDnDJb8pC0RCe3u4cHxllfvEhJOVsNZEP+Ygw1p6K1r4r4UQ8BjKtPltJSrkJ2L
	b1ni2pgj+deuyyaLYlcSUhxMTOrKsEeoRYeS3h9nEVdc0nCfxgtz2kCB97OcipwA
	Ze3YqjXQQSi1qvsR/JOwNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771541415; x=
	1771627815; bh=qJ6Arxc72iCOhqxvQTg4tMcQ4EN6X6aKh54pUpQ08kc=; b=S
	cZ9QBURTq2L6AlaN0Rm5PRSkLKS/UyklMDvbMiKm7SUKymlfF8qac4fUMws3s9TY
	vuotwvVU0CejSiZzT69enpqKDzEFG79AODasUvib34TXIGvcsIUnGB4vv9zZWeRW
	Qrc1WIMYXcTlncNxEnERk05EH/+5KXBbeb8BYMEJNkalKbT6ZkFLcQFD2w8L7Y/N
	paTm14KqyS2Rl21EQ/WzFTKrMdP4B0f84PccT5iNJ08KsYqxX1TjAK2VvVNdTPHx
	MWKIP/nE6PEYemRcoUy8E+agtDCKYyJqu7P4ToBPC3r0SPQUbs9orNu69xC3NPL+
	CH6uZdRWcMIFwDLkyQ7PA==
X-ME-Sender: <xms:p5OXaUNwtNd3-hln39gkDdTbZ6o1hniK21NE1wmBuD7VhtZkgRQZLw>
    <xme:p5OXaR3loKemRP4hlg9gF-JiaFK_I43HD-JmcNX2odLlBrUVjfR_tD8raci9XVsoY
    vMSxpXbnaVguHJfLHGnIf_b_bad82iG9B1xakq1LHNsqqWa4Fd3_6g>
X-ME-Received: <xmr:p5OXaTkuKO3tWe-DNWngiAENkzKQfvnnoXJ4gDqPh8-OUd21epxyDmzhCAEU6rE3lt6-l7T-zdaQKSfQkNBj6CnHBz40KA-nhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeijeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegskhhkrghrrggtrgihsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:p5OXaYUO0KPrENrDj0iE1LkvmXHPVdL3JuEGRJ6JiVla21MwCYapMQ>
    <xmx:p5OXaZtpU5q150-kysrz_qzVBePxCe2fzOQvBF6F0qXIhCS-1604gA>
    <xmx:p5OXabaSRW-LpkL5m1DD_5qogVVEg-dgTaQ57BXqAZDg56LizRA5rA>
    <xmx:p5OXaYVDcEwp4bjaCuLbXxeCKvMEZLZdB18Q0NqYY-VWByzderq7bA>
    <xmx:p5OXafnoejJv5uV01Bci4r1KLRGXsveWa4wMQqzEnAwnZTWRuZxvhA8x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 17:50:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [GSOC PATCH 0/2] mailmap: reduce global state
In-Reply-To: <xmqqh5rc2zuq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	19 Feb 2026 13:22:05 -0800")
References: <20260219125954.3539324-1-bkkaracay@gmail.com>
	<xmqqh5rc2zuq.fsf@gitster.g>
Date: Thu, 19 Feb 2026 14:50:13 -0800
Message-ID: <xmqqpl601h7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Burak Kaan Karaçay <bkkaracay@gmail.com> writes:
>
>> This patch series aims to reduce the global variable dependency of the
>> mailmap subsystem:
>>
>>   - Patch 1 eliminates the implicit 'the_repository' dependency in the
>>     'read_mailmap' and 'read_mailmap_blob' functions by adding a
>>     'struct repository' parameter.
>>
>>   - Patch 2 removes the 'git_mailmap_file' and 'git_mailmap_blob' global
>>     variables, shifting to on-demand configuration reading via the config
>>     set helpers and using local variables.
>
> These are surprisingly simple and straight-forward, as the final
> destination has nothing to do with any global, and not even part of
> a long-lived structure like "repo", but just a simple string_list
> mailmap.  Nicely done.
>
> Will queue.

Oops, not so fast.  "make hdr-check" catches a problem in this topic.

    mailmap.h:11:30: error: 'struct repository' declared inside parameter list will not be visible outside of this definition or
    declaration [-Werror]

