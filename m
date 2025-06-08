Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956E78F2E
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749356425; cv=none; b=NOSxVFdtDy5O6bP1jkIXyJRd0uJ3MZjeaihIgmlFvM2rHzKb1+ujJ1Km0jNc5nCnaZARcHuLNsivVMbj+QUnFHEBNen8DkQ4LkPCJeebcZN84t8x7xdMSWeSnqGYWflMVeI9NrCeYSXkks2mlc9XMN/hhNgwcEBQ1qzSKt5FOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749356425; c=relaxed/simple;
	bh=LV0j87fuY7Ce8aTYllCTuLuorlsJK8cHWG5cHb2jZOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOFm5dPVdxw+gCy3TyHW2V65zX0RcLDl7ZKlhDwI1hJEpsq10Z7cpIyGJgmL2ONrwQoGbvWFhI9kWbKBZ6JsIUCn548r4AWEGTmR78vwRwCBA2Ec0nfa+eDoTlhYRsu3m6EOuyE1+IOYBcW1zIJ+iyAk254L1mykydWAFu3Bazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N8CdzNOG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TAbIQ+wZ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N8CdzNOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TAbIQ+wZ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F050511400B9;
	Sun,  8 Jun 2025 00:20:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 08 Jun 2025 00:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749356421; x=1749442821; bh=LV0j87fuY7
	Ce8aTYllCTuLuorlsJK8cHWG5cHb2jZOM=; b=N8CdzNOGlyV0NjqjKyxNJ8EPiW
	okASHMZX6mmDHXgKKgd8NxyY67T6JEhxWlVb+RLr7QYixWE3s2PQKdq/zk+XtEOu
	xXRrox2aXK6eKczNWPNEWq955gdhIeAbfTRg/Q8t7XCFZiBMdYL9varPERzYWGdM
	9kDweR2ibu8MkpUpMr/eQcKAtyZRDMENoK2xLfcsiIrDcesZfVEFxQhJX6P2ZtPq
	ZQzgNphw7kx+Dbb/LLuiFl2TN20mlJ59/JuJeILnk84DWg//GNAdOJ2Lutb5LK9P
	03ZCPNkEh8DzhF+6+fe0GvMqQ3zQpMoyJAbQQ6Zp8sz1MJn1aXUeeP1mXfuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749356421; x=1749442821; bh=LV0j87fuY7Ce8aTYllCTuLuorlsJK8cHWG5
	cHb2jZOM=; b=TAbIQ+wZYiGJluIGNtLzXus1kscmIMimYzEGX/cAugNKlhjG3SL
	KXpuFlQZbszXM1DRxNh8JvQrarwdFsn5sgIEgu27d630kq5CENyL8yPCtr2gO5k6
	BwKgNHflUP/KgGPMl2vEomb/34Jcky8etxucVMrnjZWxbqP2gcdAaex1MnkqNWmf
	MmiWj+0TA4kn9IrR1TEZAaiy3TZYUSkXRwF4pkYRn/PJ4CI3ha+yCQLcTTj6OuFR
	CtWcLYzhRyav35/jybW1suUuvfmAuKesE4mECeKTCydLt0r81IYaLHwlnvdKvT6G
	SWyKlAENR4lio0k9fqGCerJH6/OzI4nM3Qw==
X-ME-Sender: <xms:hQ9FaJpUxWA0cHclgA6Q4YLoNWnGUZX-kuBRK_TIzpiL063zYymuKQ>
    <xme:hQ9FaLp99U9HrC7iKx0ke0oG-mZZl3qScLCNnDNdP_O9wxELNAO40GPxLGP-j8raS
    cVShi3L0tB88ZIAQw>
X-ME-Received: <xmr:hQ9FaGP8U8WEJgzPVknAwj12Y8J1jT7mP1anjJNCNW8us2L8Ew6WobIoToP_jUznRAh2SrXwof-qZojlBk9-yI4YsoLJu8BL4t_z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdejgeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hQ9FaE7UqkN5URfCmrtmid2FaUnocUIK_ixD_guydqARcDHVmq3BFA>
    <xmx:hQ9FaI49puLOrrfv5DYayTgbgH1plcsb9sGzdWCt3423nSKh8znazg>
    <xmx:hQ9FaMhl5D9kAgsVMsSfnKGXLhwUE_FvWbN3YWXvw1NTfzKrgjT_aQ>
    <xmx:hQ9FaK6Xrh6OJYYJd6yfUp7BpjiWw7OrE_4NS8QhagCr2laT_5Bmaw>
    <xmx:hQ9FaOPabv2oNbYSAr1sAIabGsGRRNIoFXeWfsfqUwoknUeE9B0Npmhh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 00:20:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  brian m carlson
 <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben Knoble
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v14 05/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
In-Reply-To: <PN3PR01MB9597C03C260EC7F5F9237A5FB869A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Sat, 7 Jun 2025 17:13:08 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959732DB7232FFE1ED7D38F3B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqy0u3zhxl.fsf@gitster.g>
	<PN3PR01MB9597C03C260EC7F5F9237A5FB869A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 07 Jun 2025 21:20:19 -0700
Message-ID: <xmqqikl6yid8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> ... if I *have* to move it above, please let me
> know.

This is the second time after I told you what needs to be done you
told me to tell you to do it, isn't it?
