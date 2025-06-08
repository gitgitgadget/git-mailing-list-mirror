Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F455BA45
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415857; cv=none; b=mN655N/4Az37JFHJ0p7jjaicK3y/vJXEPZl6S2RwxqE93W51P2JqiRc4Mv35SmAW4hI2Oc1nvNQRf9liNHOjoD9dzDOKvphb6MIPZMNTV17b25iwqA6QnTowrJ8gANYz8toH8cnf46uZGhIpuxPf+4za7eYV/HSibMK1Er6gqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415857; c=relaxed/simple;
	bh=2uRxk6FILtk2cPUPgfjqt/CD1manDbrd53lIbuwws98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WLqW6Bwb6PbhrR1q3LWKi5nfH2CiWVk/nhUAWJOFHg1hHKua4X5Uiec9PhxDNPfY2+HIc2tKGRbM/fVGq1iBDKE6ExzApIYBZ8Q9fxg1fd7/rs9blQQZm6O2NWdfOOqGYf2c5hndjFtBKzawt36lI9Y8HIggyRYn2y/hgoPcsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R/TH4uJI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PzF4GvGo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R/TH4uJI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PzF4GvGo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0027F114013F;
	Sun,  8 Jun 2025 16:50:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 08 Jun 2025 16:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749415853; x=1749502253; bh=7hEIKEg8at
	Z7XJFajSlsT5Lhk15JvVx8LoPC5dJ83F8=; b=R/TH4uJIUR8/8xNMmHKraaSjv0
	YsCwnzuXFL9Pyp8V3916pz4wJm1cViUHKMgVHoyjymZfE5JcTEbsmVU27T1GxXPV
	FeZWqDQyA9hTOYXIhP1T32AVTaTsopryRwNmNasZ9dzCije41Zcy2B7U4J/hP7F0
	Ge7Z6e+gssiJhdhRwVGY6gjcQpD1I0ptyo6/VAOe5tJ8dDCg6ViKZWgjXpgsBhPD
	D0y7CBuRCLLxDo0Dr0P6p03getXTvomGG/tTYfBZD4GVJlRyV65yC0UhLDqzBW9O
	b/wLBdNTwuF0+MTHXXfk/ZsFOkPOf85DTSikhmvd03GGPRdQixaq2pAWv1fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749415853; x=1749502253; bh=7hEIKEg8atZ7XJFajSlsT5Lhk15JvVx8LoP
	C5dJ83F8=; b=PzF4GvGoaxwsCKchFRq3hZ/ziQKuEffnHjd8+GSoyuTuOZ1VPUh
	EeDIudVJ7ObsTMmWCCiJQktaTE2AaLZUgqijiM1zzgEfngWfLRW6+eJEY/gyRu5d
	7ZueaBrRRP6bYzJIfEGECgcElC+9KJsOEHe9ERqKFUKTe8lcJ6otAaCXXctTs/B/
	okaRY1I1KvGcmkJL7MwM3TAmtZkGOFxGf9I1u5tAtt5+QWO38roS/qWUpY65CEmh
	aOF3DD8S7BpZiZHdfSrSCEqiPfsm2RTjKyfiyS+4ABj4dy1YwCazrzawekJqsElV
	eZuSO0nU1myGrHyCotOcXqFhjeFq3d3+Liw==
X-ME-Sender: <xms:rfdFaCueq5A-TPbUGleb6KcmrK3RdLrqjaYDIFA_3EW7g7emw9PPaA>
    <xme:rfdFaHcWxyoV_Slcp8VoC9A2AjVliahIXM1p4jBfxt2mm5Y0mZ03BK_897R-6rsGc
    KHUqIbNTAirUNlNMQ>
X-ME-Received: <xmr:rfdFaNzSB_Sc7K3YejvOKgDhYRPWnSTugcGa2HpYMWBtWvJaNV572ZYJcNq5LjpTEgFvA2KZBLBkqHXx-QvbuzsNFKFVbZVoZXzb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rfdFaNPbeV7q3iQte7d0lQxHaa7UfDEo1ELi_2GSXH8e6eSNHVIvgw>
    <xmx:rfdFaC_vKZIwDhECkemhcaKkemri0uzXviGvqgB7qBoYAWJ1wnOcgg>
    <xmx:rfdFaFWt-aq43XbCBFISFfVwi3qOdUUiUlG8QnW-idTwA19qqlLJdQ>
    <xmx:rfdFaLe8AhGJwOdoTgb-y9mIXrtdPov16UMPCsaH3FKDux7E1d3k7Q>
    <xmx:rfdFaAZFe3zfVQ3YjKzTSPw0B2vAJ8tCnhwcpK7SmUahWgV10NzIa52N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 16:50:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao
 <ziyao@disroot.org>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v15 00/10] imap-send: make it usable again and add
 OAuth2.0 support
In-Reply-To: <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Sun, 8 Jun 2025 10:55:09 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 08 Jun 2025 13:50:51 -0700
Message-ID: <xmqqcybevtxw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Aditya Garg (10):
>   imap-send: fix bug causing cfg->folder being set to NULL
>   imap-send: fix memory leak in case auth_cram_md5 fails
>   imap-send: gracefully fail if CRAM-MD5 authentication is requested
>     without OpenSSL
>   imap-send: add support for OAuth2.0 authentication
>   imap-send: add PLAIN authentication method to OpenSSL
>   imap-send: enable specifying the folder using the command line
>   imap-send: fix minor mistakes in the logs
>   imap-send: display port alongwith host when git credential is invoked
>   imap-send: display the destination mailbox when sending a message
>   imap-send: add ability to list the available folders

Very nicely organized, starting from obvious fixes and usability
polishing at the beginning of the series, followed by feature
enhancements to add new variants to the existing framework, followed
by three new features.  The "ok"->"OK" change seems somewhat out of
place (I would have done it early if the changes are not controversial,
or very late after the series if the changes looked merely subjective,
and not in the middle either case), but other than that the series is
now organized perfectly.

I think the "fixes" and "auth method enhancements" in the earlier
part are the same as before and I was happy with the resulting code.

I didn't seriously read the last three or four patches during the
previous round, so I would say they still need reviews, but the
early part of the series now looks very well.

Thanks.

