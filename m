Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94985248F64
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606920; cv=none; b=JOxziGD5goVkbbTi/7UEmsJA1ddFdwIn/xceMECL5VZ+r4fc82pT+y9n2fEgcwdLS0SP4oVN9Un8KtKz42n2U5sDQDdfdban3LkHOosf1fXskoDuJJXRef+M1Chtp3yGW0T/iMgtc/upQXsbVpPi6YhM2Ou/heG4BH36BKEfRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606920; c=relaxed/simple;
	bh=7C8fBgcLxrG9n5JmJV7e3C2vif3JCSVWTfsGWEVPSxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dlIYLpEySHrfWYZH6kSE2OD+29Y+Qsz57S314w5Vc2ZYctlOnMPo+9DD88QvHkjxJRQWPDFqI12lc6TX8UxS/6rfAV+Hs3a//DuzcXYw9MC+oShFrHT08qd5jTGVyXu8B08d2eQD1dfEHlBtae3DkAVEn0cpY8qJXLZjsVzJvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CJ+pT/8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AyepOpJu; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CJ+pT/8U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AyepOpJu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AD007A03A6;
	Thu, 11 Sep 2025 12:08:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 11 Sep 2025 12:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757606917; x=1757693317; bh=N/+wrjnFAU
	4mnEt6x4gNrHnl7rmAArXChn5q9uU3mbo=; b=CJ+pT/8U0KFCtWhzHpz4uUl0+V
	xjJbfpt/Hsh/DDbYdu07kh/lHdvzQj8aY6JxxtZrAVFR4BGGllxP5bLMXoEMkbky
	bu18qklxOrUklvvnCi53LBWAUYEvPZjcaHVPCLtEYXd5tNJR1zKoCVvm52Xox9I0
	dtV6mX46i1XAs95OlLbYRu+36sAY/VyqtaZ11Yf6lJXfBTUZw7W/xiNINMWq5HoY
	ugXJKJdOfDGTniEf5W4uBHZoNtl0+Zk0JphXiEQXuBxbhQUVzD0yHP/nGOCCslEg
	0V4cfBc5OvWMNuqWRXokGAbO9h7a8I9Cqht+URvr3b5/2j9wertY7ATmTNyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757606917; x=1757693317; bh=N/+wrjnFAU4mnEt6x4gNrHnl7rmAArXChn5
	q9uU3mbo=; b=AyepOpJu9nRG22mgB41Y8+wA3BFcCW5WsUJmXN1ByqbKpt5jCAD
	H7U8DTZopX43sZ584jp49MAHpIDc6JYIdZYbbbApnFgvGyge5ySpngCiElHeV6um
	X7kr9LGT1VvlhxLdjSvEjentc8phGGj4bIyplKLja8oCkE6taU/gxZG299M6PTMp
	0xr8u7xmJ7mlppI1Cx9NPtjJI1Mf/UPeto08Neulah7vG5wa+nTa+6FSfNhjVYBQ
	vFsjhXSKCn++Qax2Id601//YEdUuxlngoozu29ZSfDgCyQg/19X2mYautV0KY+8I
	maeXum7hAeShDuBUfqGxXz2j/ZNy6MjhjSA==
X-ME-Sender: <xms:BPTCaB3C6Oj4V2DWVqjVHv8Gw6NGiz5TRo4bHVElxazJUb6YQk5hOg>
    <xme:BPTCaDlHTwXxUQrLd_PItUL8vtsQ-GjciM2fSw0iTY19XGirO4ETZtPpKqSWruXx1
    _WwN_a3CVYXVmF6EA>
X-ME-Received: <xmr:BPTCaIWz6xh35fxYV6-wPvaTRpiCtWGKoeLsx0I7Z0EfTxcp0ZsPALhSlepULpv9Ghox8EqwtXa09A_A59EySjcymfwB3z-H500RlyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlrdhoshhiphho
    vhesihhnnhhomhhothhitghsrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BfTCaJuqVmkVh1o46eUpcKXPMZ-gFwNciFKxgtRbRIceva8HLPWUyA>
    <xmx:BfTCaLY_DmzD2CYY9Aj_mKiRHOoof61ciAM-hCcaXkC3mSPdz_tg9A>
    <xmx:BfTCaIXsT7WA4E-ggm8GW8XrnXiXucCt5ykVNuvazvlJmMzAJi1EZg>
    <xmx:BfTCaAR0lFkX2JwPWtM5FAgO0Vy8VZ96XrNFIGoj5khyu75Iy7B-HA>
    <xmx:BfTCaDQswBxR-Tvu1t_yY5JPgo_ueKGPw0FJdKqKHkwBKKZ8L5TI_1zC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 12:08:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Michael Osipov <michael.osipov@innomotics.com>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/unit-tests: update clar to fcbed04
In-Reply-To: <20250910-b4-pks-clar-update-v1-1-26a196237e0a@pks.im> (Patrick
	Steinhardt's message of "Wed, 10 Sep 2025 15:09:58 +0200")
References: <20250910-b4-pks-clar-update-v1-1-26a196237e0a@pks.im>
Date: Thu, 11 Sep 2025 09:08:35 -0700
Message-ID: <xmqqikhpotto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Junio, I was wondering whether we also want to do this similarly to how
> you handle the gitk/git-gui pull requests. I ultimately don't mind it
> much though, so I'm also happy to do this with "normal" patch series.

I do not think the "git merge -Xsubtree=$directory $URL" merges have
givem us much benefit as we originally hoped.  Even though we have
full history of the other projects' theoretically, digging something
out of that history has not been as seamless process as it could.  I
always ended up doing things in a two-step fashion, i.e.

 (1) ask "log --first-parent" the last commit that touched the
     -Xsubtree=$directory, then

 (2) dig from the second parent of that commit.  This is another
     reason why I do not like to *move* the -Xsubtree=$directory
     without a good rationale.

So I wouldn't particularly recommend it.

Thanks.
