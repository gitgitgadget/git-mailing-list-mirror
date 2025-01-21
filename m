Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A771B2EFB
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737493796; cv=none; b=ku8hOulrAvfNIU9Qzro/2Dzd8tbZ8PiSAcMF9g0qzl4cdiByMmHiuOJrteoQmQKwWcWsrUtjhKYRGKt3nlCGFv00fI4GUKyzqy9EzxESmNFqx0PN2La2yB4vVrv7luKNF3J3jp3RBcl5Cc7t86PM8F5nL31sUeMWjZlBM4PIu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737493796; c=relaxed/simple;
	bh=RPXj89IIBFrjle5LbyWiLzSr5nZXtSlm6nYlgWiN8Bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=alauNqf4cOCmXXsQyX/kOIvDUL9OYvWZB2Ak0hpMMx6CmAb5F8T4XnRzcJscbFcZFnGqWNPiU1EkldXG/9brMSoMzN8B40i8aF8vLlHNhHfANz04Yq2RJSKhXHDWnt0wtBhlOnXtQOyPf2zRXuZ8J+uxJce+cLckQDsU65Twi2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FPD7VhxM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EELc8ggF; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FPD7VhxM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EELc8ggF"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 03AD911401F0;
	Tue, 21 Jan 2025 16:09:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 21 Jan 2025 16:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737493792; x=1737580192; bh=QUQn747rR5
	2VQi0qO3U0KJLf6vLGAFN+ljz0QR7LNLc=; b=FPD7VhxM9RUiAZ4Kf13nkqCL6P
	kG+1Mw8I0eEiOWxzWUSdmfjg4N5KLd+X6viVrn4j8SJ0e7yx2nJ96Usa2KvNDOFk
	N8rFA0AuG4sBnskrPP7132k3SWrQeuW5kFezIeEW6qxaGRDlOtt2t0v1blv8yxaA
	dfHOPQ1wdarXKJC4QGmeCPBq9wokopU5Yq1KDD5t3a/XO4/mp4+A/uj2AWzHZ4oT
	soXZLFw8b5KY85UcKDLtw2rW73HjmqlPSG8G0/SmTluVIi8UOtz5sIah3sxo8vhI
	KxDmVDNNOYhfzb/wJPYXPAfee02Xcn4YPdfH0WSgv0Lcbn7ArmsMhnnbnQrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737493792; x=1737580192; bh=QUQn747rR52VQi0qO3U0KJLf6vLGAFN+ljz
	0QR7LNLc=; b=EELc8ggFI/Iy3aCra0mTbftJc65AUkgKSJj1CrMSlxrpH4voS1A
	54r9IDMzeT1zfhbq/aWugS1nhB7ZCr02UYWJG/A+gFVbq1tVy8RfmsMiae1W4IVm
	/MIuVIxRg13A3WXXLNyOwodcPkkgKnZyzXyg6dEuAfmjtMWPIB9Ln3/EImpvnnMA
	R7y7A/8s5QmNjqL7K33GPaogoX04nFhBR7QOlJdnPh4bp85jMQ+eDSbFko4uJohv
	ZLxHJqSGRa+QddInsPmiVR/ym0JGpQFFLNqGmrmMjMnyVcKUX4kCitYG1eedtjds
	d2jdI9B7OQxDGaflMQME3lThjXGiCuGwzQA==
X-ME-Sender: <xms:IA2QZ3DAT3jQ_x6tbcl3fBX5y3XEvkzyhzpNqAk-EnudbSIMG2pj1A>
    <xme:IA2QZ9irD7BThmVWdusWos-YC1k-lvf5xJpPcUKAnEtthrhJHl7uoC-m3a2O3sDQZ
    P7CpX10QHS7t--u4Q>
X-ME-Received: <xmr:IA2QZymTkL0XUGGJkQuZS-DJwFdarKoMwFnozLJ8jvNrEc1r48EEFuQM1ynNKeZ9bF3BWNyPK5vctIGa9ujQrdhm4mtFO_yrDNHm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehrohgsvghrth
    drtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehrrghnuggrlhhlrdgsvg
    gtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:IA2QZ5zqdBcqziDhhj81hop2rtVoDGJHvdlgMEa7DxQ7lKHMhww43w>
    <xmx:IA2QZ8TQo9OZiL5FxAQZ8PEqcy_NKVCUt44AqnRDdptsGrCSESvGzA>
    <xmx:IA2QZ8aX5jdGk3R5yBVfd121ZdFNKudxaeW3bF1Y0c_Z_hPMvv5-6w>
    <xmx:IA2QZ9QUsAoChKPgIg-leIZi7OEep9ze_XhfQG5OnDQU1jsCdtqsvg>
    <xmx:IA2QZxTcm6OiWGdt47mM4ipVI2yXLR0IHJ_Xbkz3oivC7R4ng5zTXPG->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 16:09:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Robert
 Coup <robert.coup@koordinates.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v3 4/5] builtin/pack-redundant: remove subcommand with
 breaking changes
In-Reply-To: <20250120-pks-remote-branches-deprecation-v3-4-c7e539b6a84f@pks.im>
	(Patrick Steinhardt's message of "Mon, 20 Jan 2025 08:43:01 +0100")
References: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
	<20250120-pks-remote-branches-deprecation-v3-4-c7e539b6a84f@pks.im>
Date: Tue, 21 Jan 2025 13:09:50 -0800
Message-ID: <xmqqed0vzxep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The git-pack-redundant(1) subcommand has been announced for removal with
> 53a92c9552 (Documentation/BreakingChanges: announce removal of
> git-pack-redundant(1), 2024-09-02). Stop compiling the subcommand in
> case the `WITH_BREAKING_CHANGES` build flag is set.

Nice.

The date it was added to BreakingChanges document is probably of
much lessor impact and importance to the end users than when we
stopped working unless the user gave "--i-still-use-this" which was
done by 4406522b (pack-redundant: escalate deprecation warning to an
error, 2023-03-23) that was in Git 2.41.

Other than that, I love this step.  The fewer the subcommands, the
happier the users ;-)
