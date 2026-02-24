Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F31624C5
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771975454; cv=none; b=FTym4ZVviSrElvl207jgx4cyBYmxCX2AUYlnKB2GtOZddL7HMoACMgeaRpFYANe+tTyig49POhR2N9c7qcglel3QBYGjfwRPcxdMQOdVW2ICkZKumq08x16hCEijsF/WrlAvFjlQz4k1L+jZOWhHF7NnPbfsLObS+cWk1e4HC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771975454; c=relaxed/simple;
	bh=3hszlZWvENcyCAqTVDLRr6T9w1J6dkGrCrSHLZoDWQM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GAQI8V/jjnZEHu/0Ta7eEQoNMcotndjoksAeg05lo3cc9F5BufxmCItnY6GohIzp2jCt9I9K4V8chJFOoMC6vTEyoSqnwJBNLSvQJry1MIACgX/c1CIa4ihFq3l/AxM05KT1Nwq7reL32+NMIq+9Avcj0EC5z0XQyOZBzvZ846Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CIcDL0M/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qtHBFj6f; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CIcDL0M/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qtHBFj6f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 608D31400272;
	Tue, 24 Feb 2026 18:24:12 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 18:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771975452;
	 x=1772061852; bh=3hszlZWvENcyCAqTVDLRr6T9w1J6dkGrCrSHLZoDWQM=; b=
	CIcDL0M/wj+j8Eb7j47wMMmuxY/sb2vM8tCRfjm2oxEEqBkysBvsI8B5HBjjTuF9
	YqKSj8fiZWgprlK6sgI67fxUFkqeOQItTjnsxV9jqoDYdPAZYn2IMj/B9DPc/+qY
	Xl9nyfUp4pdFdjL4gPXIauMtW4gfksdwXV5XAGOveKuBLW3SqKFqGUz/c4kdk0B1
	UAh3Hv912bo57ZnRA9thx4AvYy3XC45Qf2ie8ZZOCWgnhnEO1LBQor3BttQwvjH0
	+Gdmgy/U+GbmW09FCPLEHdq/xfnbbIOcBUfU2edbult9yZY6tbLgbi+T6C4vmMFT
	xNabM8AtOyy5L2L1X+gh0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771975452; x=
	1772061852; bh=3hszlZWvENcyCAqTVDLRr6T9w1J6dkGrCrSHLZoDWQM=; b=q
	tHBFj6f/FB3gRVROQTSIYt7Ekk3h+GNUuoJy6vYbIPWVOWd6AIjMWhg7zOKQprpa
	0SZg2/VIj5uSKmFoS5kGFBoz0m2UIrss97M5uUGllLgsfdQ0pTT7PgkYzq1/+Dej
	B/LBBm0PmoW1Tacn5brLz9OARvqqHlAz5YuAbG/r+x4ipcVrS1almZaTdEvLl988
	Y0xHx8DD+ZXGxX4QpuTDT+Cd+IBwX+kWEDe0nzm2cuxgdznDxtwM87bf4J4xhxFg
	2hbu/thb/9apAvMHNMSmo6byLpbXiiAQuQbL2axDBhx80kbybU09q2jkab5rMTyP
	amBKMIRcz3zMKhdenuyDg==
X-ME-Sender: <xms:HDOeaRtVPrPRhPL1BiKReO7xtEh5YuielbBG_SLENqVL3uXUn-w6Mmo>
    <xme:HDOeaVRScwy_mrk9R6pCx2xsYPmcZcfzoCVZ4l1T5KgB6yyhHVdfPD-YF3ZDDAm44
    a9n01PZgNldBo8B8bmt3GtNnmscKIFsRZLKTqVU6H64Cl-uexJo5qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HDOeaba7cl0GNMym3OaY0qS41U7u1N8tIUXrteuykX7zkADjZ7SRDg>
    <xmx:HDOeaTvgNKJNENrFOlwvIlLmvM350j9hPfw2FusgffhrvkulQpCMYA>
    <xmx:HDOeaVNK0tjunZ_c3b6Cb2aSyxsvcNTA9nqvOQLDW3h3vec4CXKVtA>
    <xmx:HDOeaS5WBE7csG_ASJPvYIlatxiBUWdfni1ni6jbPYVGRAycaXKwcw>
    <xmx:HDOeaUoxIkh9puL6EDaztQ3NKYUVkOm1otMwB0G4xuYn7VeC3YcAF0dt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E90D41EA006B; Tue, 24 Feb 2026 18:24:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdFosU1OfSzV
Date: Wed, 25 Feb 2026 00:23:50 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jonatan Holmgren" <jonatan@jontes.page>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <2cf27229-3d4d-4578-b11f-db34701beeb7@app.fastmail.com>
In-Reply-To: <4b80f709-d883-4565-9fe0-d92c80a7ef0f@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218215737.1181147-1-jonatan@jontes.page>
 <20260218215737.1181147-4-jonatan@jontes.page>
 <f1f37010-2e93-4e11-8298-420cd8931d62@app.fastmail.com>
 <4b80f709-d883-4565-9fe0-d92c80a7ef0f@jontes.page>
Subject: Re: [PATCH v7 3/4] alias: support non-alphanumeric names via subsection syntax
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026, at 15:48, Jonatan Holmgren wrote:
>> Is this `r=C3=A4tta till` supposed to have a space in it?
> Absolutely, as a demo of space working fine

Aha, okay. Thanks.
