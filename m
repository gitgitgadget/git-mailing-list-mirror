Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDD36BCCC
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878333; cv=none; b=MF6/F715zJzZJvmrNehhM9H1mWL2z3hPG3u5gAH8jOhTqcI2YW2+MiBsjtlrY47dO9QP1WzYR4lZS6MoPx62fZbCSLJ14+8XQKOclVxv+buWh4wiF2+GsnGSgUf+JDA0j1wg11jedvr7g9UG60nt6yRKs7GrCi+q2DQOtHujfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878333; c=relaxed/simple;
	bh=VqBkV/b2vPssWl4ck0ZwR2hTwXVE0ciwUSnfdN0AVGA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M37YR0WcdqoOv4LoM2QEUmQTg4RglFd5mqxdiyu9Lc5QMlq5yQdbAhdyeBcK5xsYn6WPWq8H6dkwArPBB/YhwtsfaVVJ7fscPtF5dYXQ8DigbHlOO1IW4E+Wiw9Sp1Mlz3BZgKo6qSdi9COdRpo53014G6xljMpgUC3Emc4ESbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dtVBAn1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TzeFVd8f; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dtVBAn1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzeFVd8f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D47B2EC05EE;
	Mon, 23 Feb 2026 15:25:31 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 15:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771878331;
	 x=1771964731; bh=VqBkV/b2vPssWl4ck0ZwR2hTwXVE0ciwUSnfdN0AVGA=; b=
	dtVBAn1uvZDRS37Hh8x6HNHXHrkdYuqICZfj28t6U+1NTW7arXUtENBpKO9KLqA2
	pujGVIaiwfX4bgmh0Uv/cWdw2LHxqEvvjkby3g3uyfIktXck3BgjGeKa6N71PI3d
	2lvJrouEaOGtWHve+Y71SY70Jagq733A55o2emiDHZSLK5Yt1sK2rcU3kbaHmtS2
	RoJ4XQJoSRuqxVDm0KqqIn3shEuNW1NX96sD6vGNUJQp96DmFIK8gQ75rNbJllKV
	kpkXHmu7DRNVfVZxeOrVV11UX227Gjn7A7sr7qiuY+zHoZLvOjtwm7wR2KPnFlDU
	z3zIStNX8rTA7BzSn57lFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771878331; x=
	1771964731; bh=VqBkV/b2vPssWl4ck0ZwR2hTwXVE0ciwUSnfdN0AVGA=; b=T
	zeFVd8fFJ0M0Fk9Tc3BjfVUcEvxLjDH/wm67pUtxdoJSp0Mvg1LPzUtxeZuzQn9m
	UEufctL+7udpU35z6yRL8gRIdrbQQ3nPFHskIOXLk89nx6hMyOZd2fnMbJCiRamu
	vbLflw6dAjfFQ9o8R5So72A2rpRWnzRW1p5APWETfl+I07IpSGiDkT17KSw4V3wv
	RLkD5zY+OBHFwMZ3wRNv1lugEcHGtW6PstkcJyQ8tnV0uZhmjuCnmx4ifNL59Xnj
	ICamc+bn8frjSG9W9PWFEq2KlewgvSBWap+GLonKvm3rzCtGdBO/qBFSA56p7B8L
	izLrERhC7UCCxvNCWlzlQ==
X-ME-Sender: <xms:u7ecafgagGzwftV_M_rOme8rcGPYie5q2vUcQIYtzEa0kroE8BM_MRA>
    <xme:u7ecaW0f9RJYf2n1sn4qfR9WklUHus6D6QRfevFxTIhfo8lC4zydos-BDX304jaBp
    aGTecx00HmlmIidXGc7qLVopLKau-SD547ztt_Lcw-tUoCuAkigwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepsggvnh
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhnrghtrghnsehjohhn
    thgvshdrphgrghgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u7ecabOCt2F10D60VLv8CwP4xbBJhRcMPS5xad4Qc19jugDEoj9cTg>
    <xmx:u7ecafTngBXSg4WBncS_HFPAfbC30jqK_-dv66Za1gUJe5QPC_hq6w>
    <xmx:u7ecaRjKrcvunAbTzliaYfKxlVGrQXpT5t9gDFQZH_gPJFxx2Qb3WQ>
    <xmx:u7ecaQ-74ImtO1ybsRJrfekqVLd3NhoGB09IGNWqd6A3uUhJX3D87w>
    <xmx:u7ecaROl4vnHxORO6onJyV6_0amIdNYCzwTY5sZRIIsp9t2v4-s2DV_w>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A66981EA006B; Mon, 23 Feb 2026 15:25:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdFosU1OfSzV
Date: Mon, 23 Feb 2026 21:25:11 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Jonatan Holmgren" <jonatan@jontes.page>, git@vger.kernel.org,
 "Jeff King" <peff@peff.net>, "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <2951646f-f1be-4ad9-b995-6ce73c3ec85b@app.fastmail.com>
In-Reply-To: <xmqqzf4zky6e.fsf@gitster.g>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260210183110.1151072-1-jonatan@jontes.page>
 <20260210183110.1151072-3-jonatan@jontes.page>
 <112cccfd-ee04-4c23-bc5e-fd269ebc6c1f@app.fastmail.com>
 <6706edc2-04c7-4bd0-81ec-33710088f0bc@app.fastmail.com>
 <xmqqzf4zky6e.fsf@gitster.g>
Subject: Re: [PATCH v2 2/2] alias: support non-alphanumeric names via subsection syntax
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026, at 21:22, Junio C Hamano wrote:
>>[snip]
>> Sorry that I just replied to the first hit that I found in my
>> inbox. This applies to the latest version which is in `next`.
>
> And your fix is the [v7 5/4] <followup-alias-i18n.3e0@msgid.xyz>?
>
> Thanks for being careful.

Yep, I was wondering whether to use In-Reply-To the cover letter but I
didn=E2=80=99t know which approach would be less confusing (freestanding=
 or
reply).
