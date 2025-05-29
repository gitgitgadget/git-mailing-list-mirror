Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455D22CBF8
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535995; cv=none; b=RnPHBWmM5ZZ+rdFTfTN2aBtWR6A4zPFQDKqtjuQ6U0KsQwXMNaUnIXFkVCR9t/rcy76rrImOxbvxnhZrD/iRoxpGMoAThA2IhE+8E84U+z8P0iMjBPyH3gVdLVndnOweFJ0xzkhgvgkc3QKKD4HxwkNhZNNwYpSkT2w5gZcnLjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535995; c=relaxed/simple;
	bh=udUxf+BlBHC1UWSQjEhRFZHHO4lg+Y9zlRabFdDAxLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hofdIUZdJMBfpYWD52PvPvxxXljnt1YBsvesgzdayG54hcO9a+7p0vKlYiK1KWBP45Jayk5cLd0zacdESxmjNt27K5KPvHe6cBbjvLKwawVXZdvIORXti9a2PjfkLLfXH+e/ecC1nQPM48ZaRuwwf1uacdac0zN+igp0zqKd304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gLPVIPnk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P5pN2GaJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gLPVIPnk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P5pN2GaJ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8266913802B7;
	Thu, 29 May 2025 12:25:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 29 May 2025 12:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748535922; x=1748622322; bh=57xlykGRSV
	AAuFWcdCHmv/WwY64AwZV2ox8y7enY/NU=; b=gLPVIPnkqUg7AAB9ePGHWy/Bz4
	81if92meiZQ2UPXtPb+Z4Ya/wT1mqZkiJQt5uU3hcDiNob8RAJ/vCfXj5nJA4Cjq
	Kn1EryxAZsy8k05BZr2r0nk4WqS5+w60ecsvLVV5iFRygP1iIZPousuPo4eoBIst
	SYhwynuHrYE0MPsvT6Gy9jrYQLHsUH3c0C7pg1iO9fgym9FBmHBd0OR+KTULlwNE
	87LQwNPipl3TV2JY7mgTmJDOTo3ctJbKmsJhjCZyUuIRdKT9Ftg+bRRljimJ2NFY
	HTqWSklKRsjLOCrHgWB9Z5ILe6yDYNqYoERygPn96hcoR50CinHmlz2dqFdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748535922; x=1748622322; bh=57xlykGRSVAAuFWcdCHmv/WwY64AwZV2ox8
	y7enY/NU=; b=P5pN2GaJWypr8BRQmEYZN1ORgdYB1cw6B0Cwdos94CX/CaoW2wa
	EtUc4qhaCERm/OgfPdWBfx4TRUB36BcsmAr+HdF8LyP4tf9oqic6K7e4BcVLwx9w
	/i+UoObB0q/VXcr9VM8KfGKN54l7jppzU1l5vInFqMN8Ec+NnstspOcK9QNXMFIp
	j+DMv2ZlW66cak/JZvnbhgyApuX4nNIf3eqIqqEgNp0HRSDcwcLKZMSqZue7cIb1
	ZsouQNhIV2KLZYeXzjlaHdbMC0ySNZAYnzPFpAQOFWWs1doVOIxT8bAOv22xxr+0
	tdeA7ItGC/HuR3PiTZERzNnXUN/ztI/3xZw==
X-ME-Sender: <xms:cYo4aP_VDoxf62c4g4hT7lqLtdkMplLKnxnTB_RH9Ct1foQAy0_YLQ>
    <xme:cYo4aLtTnqelImueyvCZ2w8TrIl3TKe9gGfgkAeefwJeciHINgd0G2S-miuqQ_Fsj
    iX6luy-3qyzy2XYqA>
X-ME-Received: <xmr:cYo4aNAAaO_n0eU_awcpGIBrvlmju_k_ca_alsRdasJCqjsXWjfYVUPh3pp4W6ZZ9_1nSc4ZevWHVvuhPIcw_SnQeOaMTSMb5j1Z_IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieeitdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhn
    shhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:cYo4aLekpsSMiJ6WVvvsukLo3_L4BEJGbgk-ihpFDIAUGmmVwg-IsQ>
    <xmx:cYo4aENQ6Dl_FfZevh_cnMviscaInE5OwhJHkScNZq6U2ueY51xHZg>
    <xmx:cYo4aNn6sPgVfvbhvviACph-ALR3RgRZpCmo503IZcW4p6YQWVO92Q>
    <xmx:cYo4aOtVY8U2TP_R5UuRlQdEJj1PGBvmVFXnIVwIPZ5-X1PjhWuZLw>
    <xmx:coo4aKqP34SpAJYDOmrTasUgOFEombUJvHswjjTfQ8untQyImTprxeR7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 12:25:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Aditya Garg <gargaditya08@live.com>,  git@vger.kernel.org,  Eric
 Sunshine <sunshine@sunshineco.com>,  sandals@crustytoothpaste.net,  Zi Yao
 <ziyao@disroot.org>,  Jeff King <peff@peff.net>,  Ben Knoble
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v7 6/9] imap-send: enable user to choose between libcurl
 and openssl using the config
In-Reply-To: <42e07f4d-9888-4a1e-826a-b53b7d84fef6@gmail.com> (Phillip Wood's
	message of "Thu, 29 May 2025 14:58:17 +0100")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597B56233DA6815FC7CA96EB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<42e07f4d-9888-4a1e-826a-b53b7d84fef6@gmail.com>
Date: Thu, 29 May 2025 09:25:20 -0700
Message-ID: <xmqqldqfl6z3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm wondering why anyone would want to switch the backend at run-time?
> There has been talk in the past about removing the openssl code [1]
> and just relying on the curl backend. I think that is a worthwhile
> goal as it simplifies the code and means we would avoid having to
> worry about whether we're using openssl correctly [2].

Excellent point.  Is there a downside if we only do imap via cURL
library and lose the code that directly use OpenSSL?
