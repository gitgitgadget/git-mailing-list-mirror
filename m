Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839302EC57C
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923441; cv=none; b=Ehj7QNz6Eajp4Idp0t1Nxsock0jAz1dd/s9mXHVirBQb7duwQDcdNOhAevIr2EnmUfw3piJ+20b2T6jrPtZqZIUmxd+rNCHaPUf20CQfMbrdtmsW6OelQIQkxpJTzfZF2IPDZ+o1kFj2kz1e1UZycgALoJEirIIM9k0zAIemDds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923441; c=relaxed/simple;
	bh=BGN6cbr6P34KSvTxDO6rxZogzyIriuayEjlgahF4K2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VjeqjJx15uxGYF6I5Xr8L1RHJNMcGOpTvtchiK3pz+2bX/VuctR8SzB4/pgwlLH7XUCAlR0GR06YG7VrT3sCzq4InH/TtasoGmoMNE/M8fRaHVCzOAumoBUNgPwVASYC6HNZiOO2GMDoFiQisPjEybN1gu5AAXlEdB8bk0YzPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kEfUmwNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jr0ujSQ2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kEfUmwNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jr0ujSQ2"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B5977A00C8;
	Tue, 20 Jan 2026 10:37:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 20 Jan 2026 10:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768923438; x=1769009838; bh=BGN6cbr6P3
	4KSvTxDO6rxZogzyIriuayEjlgahF4K2A=; b=kEfUmwNSRRPJhc9NdOeUF2comO
	SgU+IVV4gBe7OAWji8jvU9f1C62/PjZ5qL/SF1GQvtQMWstWFcL26K/bJgVneQJM
	LEGDCi4HLKbsGQE9lzAvI+cp8RtYg0FXvrSnx/XDSymVTbkqMxFDvm5IW+qC8dHL
	ErD4gOopRyERYOm1nUPCQXfwGADvYFCT4l7Fg93PoS5c5+9gFeQ/NetSNYDnn87C
	gsUsM/19pnx4D3C5neRTSG762vGwFpmLAm/NEpZUtumWR/vAVH9ie8dVflfVGr62
	+GKjwFvkhUdwLwcaSiAmoHonO0rgiEErGqullEfZBVQTNK2ptNeo/I9U1GLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768923438; x=1769009838; bh=BGN6cbr6P34KSvTxDO6rxZogzyIriuayEjl
	gahF4K2A=; b=Jr0ujSQ2tRWnnblvFTxzL7YnWRAPm7YqcDTo8Cm6MSb1EZLYLcC
	qCwXZVzTxcsCf2mKmCmpIIJw3bGWrZQEYiZ4g2d48MZGlsSSTmhXiID+mYnDR6fr
	bkteKq30i+3bP0XlSXDQsx5VGfNOj7svmMuZrvKO7m2iG5Dtu2tnTcGX2cUPgGgn
	XX/wtNbAii2HlFKMYxI3cUJQq/ds7YskIamzuhXTkJ3oTnHdt39AmLaoJk5yKctT
	NwzYWwBkBWUaMi61P5p4Gs/0KLAfT18SoDleSTnEVrilbCGwgNUTelV7de1nFMHs
	7GEX9Doma6KwU2vAeekEUPAIxN3eoJ3EbrA==
X-ME-Sender: <xms:LqFvacsQzacxbMiutC-WPLUciFidPgKyx1YODYku-GmVFu_6VaYpYA>
    <xme:LqFvaYiD88ITCLFQ_CLpXl1KP4Ehc_ue1pxjg5i4FgzejaMKEaJPxnvSA5yakbLHX
    eUyywQauvXfFZacNJ2He8fU5KYau3v6RiwCsHfrgW4RaD9ThJl31FA>
X-ME-Received: <xmr:LqFvad_ux440vtWoiVKjMg63mKAweDjCmzW0tkecnJeJzN-0nEuS1Rlkw_BAZl-zblxvruM5QLkWHQ_7gy-VwcdwfD4FDBlbx9EnsUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtth
    hopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LqFvabssOnjWGzD1vVdQHbW-fW-9B9VtnHFs_9EHuiUMesG1I2LAQw>
    <xmx:LqFvaRqclwNVmuucFrOqTZQepnjpRBMD6rT8bZw9z2ADWzi6cjBZkQ>
    <xmx:LqFvafrQfBLPEWLgricZ5eWRpWKE3DXpLt1sgMqMraav5oGkj4lXsQ>
    <xmx:LqFvaQbnIPil0HAGXK3GkFH70atB9PDMqGs_l_LY8kkai3IQeL_32g>
    <xmx:LqFvaUHyouOfe7QFZFTjGhP6k2V5vdAA3p8Kze_1zrzxUC4OlXx-L5QS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:37:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Elijah Newren
 <newren@gmail.com>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] replay: drop rev-list formatting options from manual
In-Reply-To: <CALnO6CCaVdJQ2xSPfvxQzVCfPsjbWHhMFUiLoiPQtVn9MeKFOw@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 20 Jan 2026 09:04:25 -0500")
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
	<xmqqldht2fgd.fsf@gitster.g>
	<CALnO6CCaVdJQ2xSPfvxQzVCfPsjbWHhMFUiLoiPQtVn9MeKFOw@mail.gmail.com>
Date: Tue, 20 Jan 2026 07:37:15 -0800
Message-ID: <xmqq5x8w2t3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> If I've understood all that correctly, then I have the Python version
> installed for building Git and it understood the syntax. Given that
> the Ruby version is newer, I think it should also work against the
> spec.

We have CI jobs to catch the differences so hopefully we know soon
enough if one is so badly broken ;-)

Thanks.
