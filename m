Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773B1B412A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 00:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824956; cv=none; b=l4ZbmQSie3MZ2xB5KQtTSHYwMoiRSRCohE2rUQmDOt0IBNcgOyU0gad5DLFmhuxVpUMqWtCGWgB0oIXrT6j0Wb46RDSSbDBjhveDbHl3L+Rq1DMMv7BAuQO8CHVaFtrd5b547MfxPbPCMqo1GVkH8zJKhIGFnV+eaGSYOYQlsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824956; c=relaxed/simple;
	bh=Qf6R6edRhvJbTe4S4PKNqfs+63n7uJ5oajZZEAQusLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aUQ94NMheV0KArI3A3bDFoeWkrU2BmrLjBJr6mG2dcRwunBnr4FFZREODgwdrPGazrReXAQ8L0tlVbDpdel1rH+96y+wC8cAMENVNJF/5qLlMURFKAbuoXywKFZzJp0zFcHF1Ak+WeVdadB78O1aCmV2LPL0Hpoe4tb/ZR3JIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kb6z9YbM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TfBBzvT6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kb6z9YbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TfBBzvT6"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC4081140091;
	Sun,  1 Jun 2025 20:42:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 01 Jun 2025 20:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748824953; x=1748911353; bh=LPnEr0hmN1
	XmaA3tYsEtXwxWC6hRNGTl3GQJbHOPjf4=; b=kb6z9YbMUmFFTmA/Kwtyo2cGQS
	KX8+xto63qySgNvlMZ7J/J1mvJknl5UIoUZIMsiQ7bakcPI5rAtA5JJ04jlaNZww
	Zuv1JoCDgR2PmjUnH947mqoHzOa2WRMAzEknGK7XuH2vhAWuQangilxeXkQVysty
	UyV0R6fgKNAjigwcaHLdE6JVB3gxmD+VX5A90tRkjBULPwAWX504bsO2BwlQpik+
	OWe42D6jI4I1lOy4H84Ph1AWKQO4ZClaM4QaYPtnNfrSgwkODht0tNE/zpux8LbI
	lQqdUPqMhQho0v98HZsx+zgNZ09s/S7H0yw28nKiIMiaQmC69bF4VJHbvUdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748824953; x=1748911353; bh=LPnEr0hmN1XmaA3tYsEtXwxWC6hRNGTl3GQ
	JbHOPjf4=; b=TfBBzvT6zJcnnMc0SA3RJonpxqcXWZaIRLUIIeoF8GFkySF98fV
	eakj5wv0D1z+rvCRfx8Fir56JeePw08G9g8miIyF6/WwHY8qCTBWpBBX75narP8F
	Gp+XYcZHB9ttp2yZz0PO4zkkyidXzYKZFUUg5oJkud4146ecDz7fWMA1UJ2tHnkW
	gxtEnGXCJrwFma+IhwOivEWjWtxeJC5tyeeqf2wKV4uNDVnBA2UhH8P7Qaak3h8S
	Dppb9j2M/YzNg6QDYA9PQFa7yUu9Nv1MCCweAFX+V4hLGmcu8DpBcjDBoH2IYGwG
	t2UStUolr3umdJtpkPo+duW5VLOdtH1VI7A==
X-ME-Sender: <xms:efM8aIdYt0PJb8oc73F5s1Bc48Y4Hbt7A34V49Mh-jfADKyGJWxDaA>
    <xme:efM8aKMXBIUnYkAsobhDmIdAG5rwNkoUnYA9r59IN6CnxWcwe6pS1z0BV_xlrce5W
    2zfcemi3CFKI731MA>
X-ME-Received: <xmr:efM8aJjanmueOj9WZI8FMLl89ufokfHry_Np_k8hyODn6TEEBz3Qtx5E-OExC35eVbdgYmQ4fN_DepDf41hpEGWHQlsZGw6KO-wf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefiedvieculddtuddrgeefvddrtd
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
X-ME-Proxy: <xmx:efM8aN8OCySynS2HeAfsEE1wvnYTy9ozgmfPe7bUehenPqn2kQcldw>
    <xmx:efM8aEtz6ZsrSm-Al7g0NHm4Zf_T9r4q8DRE5BanIjgJkk22UqWzqA>
    <xmx:efM8aEEVBvQG1TTNoNavrJnwCWw9ZKeKQw4_PTAUMwbZJz4EM__A3Q>
    <xmx:efM8aDMEOcY_fT8t9g7sTooWj28AjBCXAfNzOPWsL6c5G1zFz8mwPA>
    <xmx:efM8aFL30vtOWo0vBVAU9kYIEQ7dSnsX-jHNPs2bjcmw0mAc01OVzn0I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jun 2025 20:42:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben
 Knoble <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v11 6/9] imap-send: fix minor mistakes in the logs
In-Reply-To: <20250601083821.2440110-7-gargaditya08@live.com> (Aditya Garg's
	message of "Sun, 1 Jun 2025 08:38:55 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250601083821.2440110-1-gargaditya08@live.com>
	<20250601083821.2440110-7-gargaditya08@live.com>
Date: Sun, 01 Jun 2025 17:42:32 -0700
Message-ID: <xmqq8qmbvurr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Some minor mistakes have been found in the logs. Most of them include
> error messages starting with a capital letter, and ending with a period.
> Also, abbreviations like "IMAP" and "OK" should be in uppercase. Fix them.
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  imap-send.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Quite honestly, I am not sure if this churn is worth it.

Unless we are moving to the same error reporting mechanism more
prevalently used elsewhere in our codebase and consistenly use the
error() function instead of calling fprintf().


