Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9F1E5712
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586239; cv=none; b=YMOHgqQUOIE9jpo20xAADAMZroYiXLG568dz5Mpt8F/Hb13q3X9psFJjNEr47qhOv8n5LcRk/lxu93lW9oO7ybmW8Ein5WK7ZMLB48G2azmritCv8nBfcp/MiJWOi0uTqFri5rbi8/006tVBNckX1IJwQo6Xzk9KbUk0abAvLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586239; c=relaxed/simple;
	bh=yX+uVy4fVeLzL5v9kou+gVcEHJZr1VikrHu7FHAdRFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BbJUgeF37c2Vq/eN1Va8bPzhueVhMmudt48gDsKOWWt3op4R6vnHq64mLBQjMWdVyjyD0Q1F4fR3qHCr8HciChuGSuPL5VyTnMmiN1E8EkjSCfIfLYA3H9xmnpjOtZZfVPuO30TQGBiS0g5l9ZwG9QNSmHavjiNN08V394g0Gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jHNTPGVi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DralFrdz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHNTPGVi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DralFrdz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32EF211401D8;
	Thu, 10 Oct 2024 14:50:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 10 Oct 2024 14:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728586236;
	 x=1728672636; bh=yX+uVy4fVeLzL5v9kou+gVcEHJZr1VikrHu7FHAdRFA=; b=
	jHNTPGViZZAdHln85Z/qluB121YWwnMEXHg5ApfQdkT78r7AgaMAR8SQ8XZkeyT9
	cXqTKIj3gBkjiuxWcs6i6rrWd5G1GXEq8r+Y9hSx7wxLRRRvrRWGVRork5PQYLfy
	et4rO0741zkqeHXOYZzbOUTGutvOSa8gJOmh6129/FatP4qnmibDVKD/br5leYfx
	/E3a0frLH44pVTU1hGMJBMi7qowVVL7LOHYg35Ae2+kdqMj+hkop9rtKEKu4ZJmg
	/vs37dQcDQWj3yukVzXBW6Q3IyMMzBEdkvNY2ntZAWH1Ymf4txi5bbxxXT6/WjVA
	TkcPvBdvBcB9vqdHv1PBaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728586236; x=
	1728672636; bh=yX+uVy4fVeLzL5v9kou+gVcEHJZr1VikrHu7FHAdRFA=; b=D
	ralFrdztuOK4v2BinO5Au8jQAlluj/VGtTw9Wf2oAhg+SmeDrTd46cUmEXUMbfNf
	zrHadRpgNWvkzfaSZLNie5+R0+8pWnwsmBRyDetLZ0Ro6BDHbc2tm7FSxWtbiaeJ
	ESru/pWZX0o8jVwaWoAp/jh9qQ3YZCrIJAFxSrKDvEkCjzFTVk27CEqMVg7MOVVF
	yyiiu3/31lUkppBB9DOs1B8/ZMqJiLZYXMpLgXqLuOtjbTX0TJgn908s5183tBd9
	UAKnHkhILmuTRmVDmWlRjhJQlBkUcXU053XUgMRh6Q66/lNkUGBj+AfjuyC+fYWD
	VjfkNRU41KFisqrt0bOWA==
X-ME-Sender: <xms:_CEIZ5_2Zx9Xg7iKKjGrl2jmCdchl37RUteV4-IujBr0EEENTmevIg>
    <xme:_CEIZ9v3YEs-4wQDP2QUSSveoyZ2mToTD5vocTTtIqPBUtlmhX0hO7bLj8vfLRNkw
    xflbSuGDDxLNn-fnw>
X-ME-Received: <xmr:_CEIZ3CiPJZ5UYXTWwQ6BZNSu5E9NrpMKmdw-YTxuX-dD-pwlzMy48gCqlTz5FEVwK05dH3_u3DL9DtrRrfHBQKaPFwHd-1FiT4FimM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghvrhgrihhphh
    hilhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_CEIZ9c15ZWRSJ89xh6N5O7gTM6ztyUnCTDEIoC_61zHQ0MX9BhcVg>
    <xmx:_CEIZ-PabhHAeE0pKgdlImdSm5VTpIvJ-5uSnJTlBak3Hc4cIJvabQ>
    <xmx:_CEIZ_nABSlBZiyHoPE3xDBLmp3QCqAvZfZdIo97C4a0V2n0FlIB4g>
    <xmx:_CEIZ4tx_Oh8lJVcgfOvrazVG2ciIHIEPfgSTWGR0zOGGCMDLebMag>
    <xmx:_CEIZ11vPbWFaRn3ZupzjktcwrlQK8-3-1G1AKcfpYrfVkOkBl2ruIFy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 14:50:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Philippe Blain via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
In-Reply-To: <C05B01E0-5007-4FB9-94CD-CBE74E79F9B7@gmail.com> (Philippe
	Blain's message of "Thu, 10 Oct 2024 08:04:10 -0400")
References: <ZwSt0ZrlDaYCzfRX@pks.im>
	<C05B01E0-5007-4FB9-94CD-CBE74E79F9B7@gmail.com>
Date: Thu, 10 Oct 2024 11:50:34 -0700
Message-ID: <xmqq34l3lrlx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I had a closer look at how the header dependencies are handled in
> the Makefile and I think a cleaner and more idiomatic way to fix
> the problem would be to add clar.suite to GENERATED_H.

If it is a header file (e.g. we could run "make hdr-check" on it to
make sure it is self-contained, if we wanted to check it), that
sounds like a very appropriate thing to do.

> I’ll try to send a v2 tomorrow so maybe hold on to merging it to
> next for the moment, Junio.

Thanks.
