Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC84A08
	for <git@vger.kernel.org>; Sat, 31 May 2025 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748652324; cv=none; b=TTz1d99qZxMjLJRupcjvYM5MkScBUYEN6anxYrHIQtOQl2or1cOmuExHjuuy0KtMWTXQxKEDbxnzOKPlGa3O+h9RXb34ZQCNCvqnMUuJkjX6xCz+afBL6CIBumrpjaZ0YjFV4pjbuvDSOGlfL1BuKxQKEwhwtihsQU6506BuNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748652324; c=relaxed/simple;
	bh=h4Q8mEDkzZH64ikxCUcWzgwABcvmOrrWTY0x1Kkg0T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gV4CI4R72ExfxRiwb6s9chxHyBuOkrciHjC3sTfcBKiXrrNKtFZnp4hBRAr6C/T1YtU650KMLjHjZyi6qIDoIRpmLz83i/Ku7OldfJ0WQAFAYaKwUqsZQc9i53cPAjZ/95q2qZOH1vZfPGmE5VlF0OYsDQrtWvmIfRkkl4VaSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U5DiyWOY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TvgESrku; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U5DiyWOY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TvgESrku"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D36411400C5;
	Fri, 30 May 2025 20:45:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 20:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748652321; x=1748738721; bh=Pf6cBdZuV0
	19BLFYuPUNNqEv5CN2bGO/R+DJTo4Uryk=; b=U5DiyWOYcXRmyhTKKXQV4F/EPg
	Hfrxl6jK/zD48UF4ChC2RZHAekHA3ahEzOoQE4CJmY1tX+EwY1UCj9Q8N25WxxiP
	TVxL1KRsiARRs2RRaJJoTw3wFvR2D1RAdSJWjoT/WDrKeifYSvvLWBMaBn7C08a/
	8aI02n0ejHq8ypV3WV1ebFXCoql4km/PB5Oum0CK6qC9aAFYVDIHX9ZGyCJWN5a+
	R852CnmRg751eCbPk5EBsc8I3TUv8Xp6ooiim2UAx3oZxTSB7+Ff3VLpSCX32N7x
	aZkhIWFSu7jqOU69TNW5XZdasla7yPyEl2FxQT4yLXoXkHecjzdiMQ8LCXLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748652321; x=1748738721; bh=Pf6cBdZuV019BLFYuPUNNqEv5CN2bGO/R+D
	JTo4Uryk=; b=TvgESrkupmnSG4ATxlDFkICzC4DJLe4w2Bt6bpKCjOW3gh9jDFg
	yWUAoM7wg/P1dYOovV4K0g26OsjVfOdgYos1wXzh71qdZRVEQoXCbGFvZabbDh8g
	c2FMVwCzS7fOoHhebqoTWvsPBcm/8Yow4dDwZ2EgxIkGXiYiePiGWYaLRlZJj6Da
	QzXKECPuld5k/k3UmUB8ZK4mUTPdhOKAlsQG4IA+BkiHbFhwecNRyeEUxbK2ewEk
	dzlDyMUhqwaKqC3atWYYG/eay3OHa7R1+fJSedthwpnlrZrNaMj3oE8XbAS1qdSI
	+u/2XlKhePeYNsCyC8w6UAxme7UbtZrpmZA==
X-ME-Sender: <xms:IFE6aByxuEl1fZJRJWVrwXouleuybWy1irIK_lWvmybPp5LhR7M78A>
    <xme:IFE6aBStiCjAygUg5XJGyL1KlySLb-nXIWNEkY2vboJRUri0qdihYRvu5BgA4asrN
    5FlL7h4a6otSuJTAA>
X-ME-Received: <xmr:IFE6aLUBgus-EMbfrccNF0wcr0hBMi0G2H45W5Sy9zLcJwBWs9WH_K_Utqw2G8LXC4PkgXF5SZRipdLODJ1ZM8W7hr5dnc_9xdfd7kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeftdegkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepiihihigrohesughishhrohhothdr
    ohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvg
    drnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:IFE6aDjEouF1S4KSaBVPWwx9y55gs_NnJzOBgy8tZBEM7xt-C86PzA>
    <xmx:IFE6aDCge_4M5Y-nsjO_HBrUOXl94sQ7Mi_YLQa9ACMhR4CNSShb2A>
    <xmx:IFE6aMLwtDnKFPWQs9baggpnrhfNSMgtvx1b0vtu0kPf1UuQqZIDvA>
    <xmx:IFE6aCBgzsPEPBxNNUFsB6AKd-BW1V_UeF1vmk-KvmRikKDf8ENvdA>
    <xmx:IVE6aGXb3nrGqtNv-WpYneSAlzX5DwQnAi2WxIz7gzbDz-N5NhpVh4cG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 20:45:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao
 <ziyao@disroot.org>,  sandals@crustytoothpaste.net,  Jeff King
 <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v9 5/9] imap-send: enable specifying the folder using
 the command line
In-Reply-To: <PN3PR01MB9597C14385FFA97ADF5ED3C9B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 30 May 2025 23:02:18 +0530")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597C14385FFA97ADF5ED3C9B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 30 May 2025 17:45:19 -0700
Message-ID: <xmqqecw5d2w0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Some users may very often want to imap-send messages to a folder
> other than the default set in the config. Add a command line
> argument for the same.
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  Documentation/config/imap.adoc   |  5 +++--
>  Documentation/git-imap-send.adoc | 15 +++++++++++----
>  imap-send.c                      |  9 ++++++++-
>  3 files changed, 22 insertions(+), 7 deletions(-)

Did you forget to adjust tests that expect the traditional messages?
