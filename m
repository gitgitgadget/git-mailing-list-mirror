Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93B283FC4
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652109; cv=none; b=GPn9C7wwfZikSoTvGTQiqNN8YVYonghEmGFqZfTYVpapxW04dIiQinQAMaX6sdHqO+m/5OZizJ+lcVaSDWv3BM8FOHGyhCmarTaBD5xRryW86CTw2d5dtWd6BNqO7QPFLtrvfIwZe/iFt4dlpTNPqwLPGgybBkEd3gH3vKora00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652109; c=relaxed/simple;
	bh=zj9IKo0zOBUE03gaCakgyejAiJJ91DGvziTilTSxV4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERCxaP+ssPYeMtbeDdaOIYUQpf26sl9pAHKhz4HuG3/LlH0YR6QW73a2PKXaJp8EcpC7LdFO52O+h+CWnmPaPGGSmgn8tBfco9SkkJN7lTqmdUBOR0IOHUDuydXyubz2Tf3hhx/iCMgioPa1mMLuvSPJk97bGp2nEBgMxVBiYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TlIQV39N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rPLhqrQg; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TlIQV39N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rPLhqrQg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3C907A0060;
	Mon,  5 Jan 2026 17:28:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 05 Jan 2026 17:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767652106; x=1767738506; bh=u/ztCl1AjA
	WJ8v6nDcR5iPHcMxPWDL19QP7cPp3oa+0=; b=TlIQV39NFMycU4BgdDkoMi7SSs
	w4sQ5Tv6hBE6uaKpmJD84Hwn9ygk6c+fJQkgaWDxhYs5TInPC6Imh0jeqGgKqgzk
	xBMp7U1cFfF/HV6KSs+j5Yi8FtQBuPrMDQ8KNs0m2pXmDymAvPNsqqOZbw4jMkSx
	e0YypdYE0SKwOf4VouYaSiqxlsrceCFXqFH/p57ytuh4OQmbCXJkBMb0JpW0Qw1M
	mOTi6K657glbuLrlEZxj82lBV5gf0cI9bQ3nJTXVc84xN1mkrb3XhFh7dEOOrFJt
	9OihYMO9EaAlQ/5AIZ4egEKc8/nJI4bih7J4fHXyjCS99PNgnZ0DvkZ9zv4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767652106; x=1767738506; bh=u/ztCl1AjAWJ8v6nDcR5iPHcMxPWDL19QP7
	cPp3oa+0=; b=rPLhqrQg4GJWJOs0+V9Dh7R5ukd6hyh923zJW6nMGGU2Cd/vnvo
	oXnhDY25QPh3xGMe8FAVrvJYcqq1AMqAtH8czIahHiACsKpQSdIKyq78gHYpxfEj
	fLPIXpgWVKd4XPwtfk1w1aUDVgKuFbkI1OCGCf5setEax3nG3LZGqUMjO8fplbMS
	4n5hDfAYK0EW+SFvjNV1mGDvn+orsMILWGfJMUPhRU/rIx2CvFRJFYbyoeGm0CLV
	ZDsNHjpc1+nBv5D2EKNUYdBjhiP0BqtbPDpNAOCrLF5xxquGPhZq0S/gJ14ekCLw
	dPQ6jpev9BCdKOTYdmoegy2R3nSMzDXyl2w==
X-ME-Sender: <xms:CjtcadvbpPQRf0fdVeEt0WbesmyfGANfarFmf9L0KlRuQAFKTan-gw>
    <xme:CjtcaZA-UBLjKjAXQg8foy1qfXunqa8rAiNd8hYsmaqU0tOXTK0E7cG8UuPmC6lhM
    lkXej796GSzbcwjDdY_T3W00Zi0DA0fEs_bqKFHRc1mwBgNudCu>
X-ME-Received: <xmr:CjtcaUbYPfi6xZj3DRDztg_t0OB_V2hZhM3nEKQ8VR-idI_jdwRAGXIOvfoFhRgLw5W_PwBDsyOTS1uxsZh_vLeS4Tl99PLePQMM5Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:CjtcaUWvuGSUX3m5sgzmsMCInw-TI2sIqIh7s-72N1nZA-6xaLCnDQ>
    <xmx:CjtcaTPONrscjD6aocZIvxTJAVar7d7iL_Wki9E71CNKFalryzj84A>
    <xmx:CjtcaeZTPVYYsYta2YqN2c3cDG5VAJBeY0_gczmNW0qPd-lyjvzBKA>
    <xmx:CjtcaS9ZjGZkYQ-G7Gv4HCavh-3ZzEzww6EYrjS8N_OpphZNz6-iyA>
    <xmx:CjtcaW91hi1KJ4zAev-dAIUjoYrhtGayAFWlbNri_kHr2qN0CiRpYUed>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 17:28:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>,  git@vger.kernel.org,
  Christian Couder <christian.couder@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile"
 into repo-setting
In-Reply-To: <3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com> (Phillip Wood's
	message of "Mon, 5 Jan 2026 15:00:28 +0000")
References: <aVfzMsN2ouY3UBFG@ubuntu>
	<a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
	<3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com>
Date: Tue, 06 Jan 2026 07:28:25 +0900
Message-ID: <xmqqwm1vk83a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 05/01/2026 14:23, Phillip Wood wrote:
>> 
>> It is quite common that moving from parsing config settings eagerly by 
>> calling repo_config() at startup to parsing them lazily via 'stuct 
>> repo_settings' causes regressions like this. We really should find a way 
>> to address that before moving more settings into 'struct repo_settings'
>
> See 
> https://lore.kernel.org/git/d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.com 
> for some discussion about a possible solution.

Nice, but I suspect it would be an improvement already without
passing repository instance via git_default_config() and instead
have the code use the_repository; it is even possible not to have
any repository when the callchain executes.
