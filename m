Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EE2BB1D
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534762; cv=none; b=gfMLkjRH2bYPA8HcKN739UUnH9H/9k5hn6R/RL5KYYP3iH6+daWwcC0CRGOjVqfJ4UxFP64VTEqHcPRwvb6vcssuEwDz4O9aHdh5p1z/1eR01DgCDUqDgIp8IQnq6nsOkmxS+DUSRnyvitBRgt3+VfsYyxHCY04M4XpHYyq1rg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534762; c=relaxed/simple;
	bh=LxW/PiZILtdVhxOfG7tKpzzUAcmjElF5bjYg/NFhQZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gRSfWZX70p/2MX4LFukRZ5jRNK6VDDuclopfj/j81ojYQdYA3ALD5iS7Ts7vztK7ScqQCwr5j5oToKMdlCaLZea/kmbQOE9/WXMa6jlcqEF130KX5XwfBfS6INy7CRVNOERLj3NOegNyp0mgf/joYw2VmrRFxBm8RHTOJfR2jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cWubggq4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFP6HJdq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cWubggq4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFP6HJdq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06C121400365;
	Wed, 10 Sep 2025 16:05:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 16:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757534759; x=1757621159; bh=LxW/PiZILt
	dVhxOfG7tKpzzUAcmjElF5bjYg/NFhQZk=; b=cWubggq4JzrDySId/ZzRiToQd+
	IS+nHgWBPIPwWJL8eOj8xaaZn8u+0/PbDzOQKWKbZEQk2OHZLzZeiIbVAb0OU/t4
	4Xab+X+DBADk0++hum1OtHR6qc56Zh3W/xLi6lUtdGvLEEF9nkY7ZTAqXZs+It3Z
	/8jXKdQ2j1TjgZr4tpvPMjZxg3laWowI73PDlBq3snHpry7h07rOOarsT0tppNHX
	yl+PoJfnqDeDUyyaVAYSHKVFD82Q/S53ILg2JhUS1AAibx8Uulehn2EwIt/F+IuE
	SscRj61w1dpuwi/bgDXvluDaS/7gsQeGEz2rZrxfQu0QAm5B+pSyr0mSM/kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757534759; x=1757621159; bh=LxW/PiZILtdVhxOfG7tKpzzUAcmjElF5bjY
	g/NFhQZk=; b=cFP6HJdq5OFtiZSG5mAgzhENSGchfaLutnhmvdlMn7ihb/mNIr0
	SuMF1oaOCJ+x4LFEmUib2OBVevdlhPidfu5RRkkNDt7seXIFtZ8PbXGQ98Dc8Qx4
	/aczTvHUAjTOKf7oSqfhD2mrjx5YK9Rzs7slh2Oac+8CtJxRHKqA+/T4odnBJTuO
	58xaH5uzLtJqgw22U3qBfbO2GKx1CcYB4yF0JqrAb5oAN0Rx6j/7bvfuzhdpcOwY
	WjTBQwz4SpsVGx08dppOhDMicYt7MtokJZyqO/LM0ZHI2ZxRLJOgDKAXNw31uFD/
	6HORTkuB2nF3cg5F5NGElzspzfxToFNS/iw==
X-ME-Sender: <xms:JtrBaFrbzlJdTstym8adL0jyTcr2FPkyaFajUmtUSqvIBI7Jw5q35g>
    <xme:JtrBaEn_qvHVy52QiJzw1gssfuH3Oe1CRyVlt5xY1AIwmYjoHZfFxgLdZ9AtHmevV
    VS4w7v24C7M0U0Kvw>
X-ME-Received: <xmr:JtrBaN1lX6HKnCVqi1LEhvL5TcF0Efjd0FdD3ZFqjJa84pznd5IC6YvdzOfb_ChIKaWto-e9W7ku0BhW2HQeOlwNiSr9N0mJ5gdA-IE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprh
    gtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghrthhi
    nhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JtrBaJR7HSEkLDH1XlZQeosiPiHmkPec814v13WncMt7lEAjwc2dYQ>
    <xmx:JtrBaOyTvLue-4QFFFi6IvzKj5d2vH0ITaQTbU6JVBpQQFsvEpAVvQ>
    <xmx:JtrBaBBUhOQZAUOChNiTnUvDiXFijnXt8EtSsG0yY5n_4nYzI5K9uw>
    <xmx:JtrBaCELUsH0FI-e0mUzs0GXc7VIl0r9lbuPG3n-LtSBwYH8B591lw>
    <xmx:JtrBaLaEtk6DprD0IoIbtMqMrMh8mxRkcyTZg89L3mnoJV9zMY0XijX6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 16:05:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
	(Patrick Steinhardt's message of "Thu, 04 Sep 2025 16:27:30 +0200")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
Date: Wed, 10 Sep 2025 13:05:57 -0700
Message-ID: <xmqqcy7yrs2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Note: this patch series is growing quite large overall. I'll send one
> last version of the complete series with the RFC tag, but after that
> I'll probably split the series into two and stop after introducing the
> "reorder" command.

I haven't merged this to 'seen', not because I do not like what it
does, but simply because I do not have enough concentration to deal
with conflicts with some in-flight topics (IIRC it textually overlapped
with Peff's add-i color topic).

Thanks.
