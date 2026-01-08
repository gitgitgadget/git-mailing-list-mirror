Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404B44DB77
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877737; cv=none; b=SG5rvXQNU8gm3er5NCswJ76KatseTmoFQ5BtsAig2wESrPlZpTVRZVcca1er5MFsGt858YkWFmpIEXZKj7/irFsRwv7UiuASprvvzIxRY4O8HkDWrndk8IMCrFlIjBt/wU4mZEvDCWS+tbpmn7ejYTYFcs0W1Z3keXSKQuiryjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877737; c=relaxed/simple;
	bh=Zn3gvipB4mo3VGiMFev0MFsf6EzXzMJXscXTXOBTEBg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GTHF7beIfQaf+EvX1Xihk6m8TKvGCr+fmSCPBloZQSprZkWm+EX0oI1h4qMv6makdV2+Z4WkZjXzDUsviHFARQ5HulWbHtl13S1PTw5oMcMmakxOl5BUyEo4JX648HlXcyCX9vZs/GFisWeBxya3wgG41+DbX+G9AnppN0tBKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mFv0Nimt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NkYf56jt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mFv0Nimt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NkYf56jt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D637EEC01D6;
	Thu,  8 Jan 2026 08:08:53 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 08:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767877733;
	 x=1767964133; bh=PO68wqTmY3Mju11OWLLdlEHwEKeYjPQ1X1AardUOz3Y=; b=
	mFv0NimtNBvZD6u4upEQmE5nT+YV4gnCIpY4z5yg2QdFHtf7djZypoD8qcvnswVH
	/iiPKVrqiRcbALj++brN4qATGa/iXit3wQa+ky/JgGSlqT5n36Nngohv7x21yioi
	rtTzgNFYvGWO8nB2znId7Pyk9sQseeFnJeYTZ2wFTz0TfGnGPfC6A387SMemW2rr
	C8C8KoeX7sg540trwW+PNRBO43uzj8XyUJKsmrkEYQGu8x+J8rRsjgH9GzeHWCle
	P2c+ns4MKxIwL4aCHz7dGzPnJuEHxZpjYj38RomE2XoDf93ByaQdDUBpbqMeYmC7
	jURGOCgA7aChJjaOEggKhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767877733; x=1767964133; bh=P
	O68wqTmY3Mju11OWLLdlEHwEKeYjPQ1X1AardUOz3Y=; b=NkYf56jtmrqUkTpAq
	qh+szVXy3otn0RPmLZdJ7Hxep+BdRiiCy3cxDamt36fY8ARFDOHoaCnZbUwB7fjb
	QO1rdy9oBmnx+V4HKtOyS1QfXMafj+p4cxPFQTewKDzjpeiYuC0PmJJvlwvCnQba
	MYMEjwQntjNTY/OBW63NgLZXdp0NY1EMQ5cw4D7/AZCRBMn9Xt8J+bmOdygqYp8G
	EVWz6KesgQCdVU7qdX3erTRMPFCAS0twH8a4IQjCUAtCy3Wc/kxnb3Vy6QmFrhbi
	DRAJEoZ+KAlMuCNcRmAqdsG4FyZTJrNe12Nu50ZqrzqLTN8QH4tDRGNgys3Gcvjs
	eFknw==
X-ME-Sender: <xms:ZaxfabuuZxpMnXI7R8W5Bs_7a2x8y6CPsB0oQn3TiY0nAVAd8YQI8UI>
    <xme:ZaxfaXQ7FH_27GAXQD2uOQk_SFWSW70_wzx0glMUwvJpBu8Uztg0nkJ-klFjfjkTB
    DjAp4GEmKJJ78Pq6RdQKbz9nCgURW-VWgiZGN4lHDlwJ7kUlPuFTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeitdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludev
    heetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZaxfaaY6t8s8x7N7TKdH8SSEFQPMpaQ7MdY75Z5HsIsMyL4u7PXLbA>
    <xmx:ZaxfabVll4j2vaSjT0fLdMNeSOukdh17r95mfe3vi_EAk-QmXpN_Uw>
    <xmx:ZaxfachpedCngVsD-0isZl4v5zvu9oDJz3ermebTgle43wQ8IZEuuA>
    <xmx:ZaxfaZWls2rtAzTMW1DXaizhh3yEwwSE2c-c2z8vrDVrIwVpRveaGQ>
    <xmx:ZaxfaZBNnOKYX1Kbhut6e_vV9E8-JREdWYMmu87y_U5UpsC-r0i505_1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B454F1EA0068; Thu,  8 Jan 2026 08:08:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGh3jZH4C6tB
Date: Thu, 08 Jan 2026 14:08:33 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <44cd16d2-eabf-4ff4-9bc6-da370bbe858d@app.fastmail.com>
In-Reply-To: <xmqq1pk0gvxc.fsf@gitster.g>
References: <xmqq1pk0gvxc.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Jan 2026, #03)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> * kh/replay-invalid-onto-advance (2026-01-05) 6 commits
>   (merged to 'next' on 2026-01-08 at 1024748f91)
>  + t3650: add more regression tests for failure conditions
>  + replay: die if we cannot parse object
>  + replay: improve code comment and die message
>  + replay: die descriptively when invalid commit-ish is given
>  + replay: find *onto only after testing for ref name
>  + replay: remove dead code and rearrange
>  (this branch is used by ps/history and pw/replay-drop-empty.)
>
>  Test coverage of "git replay" has been improved.

I still disagree with this summary. ;)

<460f1f96-4236-4d19-bdfa-6c86bad811c5@app.fastmail.com>

>
>  Will merge to 'master'.
>  cf. <CABPp-BGFNyKkpcWWksqvNqyXspMqfywbYyyhuSUaL41YHNHoNg@mail.gmail.com>
>  source: <V3_CV_replay_die_descr.1a4@msgid.xyz>
>[snip]
