Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016B13E8C74
	for <git@vger.kernel.org>; Mon, 11 May 2026 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505756; cv=none; b=F4cCT0a3qYu2dCQfqQluvBayvlQMMqdIFpe1WCCSzjZGWQHSYRCPDbsfXJA7zSDz/LXRHAyztld9PtWNyUBdusveOV5hnWW2e9mgv2hQCn+EjCykp/eVL2QOZiWdzxphs1ySFEo54crxsAXfukNHl1FhIH4T2CBYxJa3bxgEZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505756; c=relaxed/simple;
	bh=Ko60UUaxSdKOkiQOTl1APxz6Y0dhwWNRcWxAxzkD1uY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KF/Sp9NxGKiEsvWYlAbUzGGec7FJorcfEHvpha2ebBRCKHB8rSTi46xlOqRCGyp6mVQZ+mKt4f6UgLH6R/rhhkLb/SDalpoBBKvmJAPQSe+4nyAkZFBI9Ut+jGiQQ2FqWztymOxk4QL4HkBap4SieerwBfFGUxg9p9VVvr5VfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SdRgUva8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bUxvZkaD; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SdRgUva8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bUxvZkaD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E142EC039D;
	Mon, 11 May 2026 09:22:34 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 09:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778505754;
	 x=1778592154; bh=W+jmckgq3nnbefatur6VybogS7hYahkHHpZ/RAcGE7w=; b=
	SdRgUva8LsrAy7YQ/kq3d471OXf0UxmlmNl+ePyydEUHj5UnSFJW5z6F+T8nm5bI
	HPLnHB/KCtSUw72U35KYB9eCAkfU918WDpaD0wG7X3ooMVA5Qwgkcsor+vshMqVD
	Gw6H97XvkB0ZGb7qWxtrenm/E9vfmpazcqCuZQ79ZTg4BCi3sIELawxOmeahnFBa
	pqMeG6745Xb9lKXd79Qm//Zt8MPmIXLOos0ZxlAlaDPaNKknXxdFgYdb7yUEw/vs
	SiWxSl3FxqfGCmmdrsCXbXzzFg0UjjzBonYbvhgQzCpo/1jLwJ4ZcokjYdaxHcZR
	IJulz6MjVyhxjRVL63SGUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778505754; x=1778592154; bh=W
	+jmckgq3nnbefatur6VybogS7hYahkHHpZ/RAcGE7w=; b=bUxvZkaDhSDeKpzG3
	jmaYVhJ5A/Auhf6/tNFJkce8eThwwWWV/VjPBLgCyzdpX60zRES5FMegAj2iFfLd
	ZkMECzYJLbxZUBUZSod4uyegfyk1S1kn6+A2camWNOslHR+WtupoSrIiD+IXuF/+
	IEWL1TEvpboagimqrIsn5e44HKsdzz4DJMA3oa1+0TlnozXRS2+lmB+9frvXE4Ur
	3kZtTxD3eJLujvtVgdJ/aGXo9w4iQUqQKxm9VEW48Smrxqa57VI1ku7kgL+vu2Oa
	E04/YSBQH9fHw4+flgQNYui3V9ZDSobkaLLMiWkAt08Z+aDTbqtvgLjPSGI8hkY8
	BRIlg==
X-ME-Sender: <xms:GtgBahrIdyI43YO2mgkapV_MiTc2GBuixaITlcXlQ8W_VPPl1oiqams>
    <xme:GtgBaudiTipVzsHBTSkUiVMc8a6rkCPuh4_CKSrWoDDlms2-YXhjcgKoabJycX2VG
    P247VR4eTpfKMQcAPZd_ueBTHObwoV1VkkmEYDuQ4EYYIFrHiAdUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfeg
    feejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GtgBasVpDBemqcB1Afga3OC-blOeY_8-3IFrlhZnjNyyBT6zVfv3hg>
    <xmx:GtgBauhPxnaJt-ZkeRRHRtlbLGKvveQwY_Id2b2k3f3LEE40t0HZEQ>
    <xmx:GtgBan_z4IFlEKToYVDN3kp2fUtqfwuax828RvTMCYhjAhluH1G2_g>
    <xmx:GtgBaoCyN6Axfaz5l8cUQ69W-Ib5FSi5zeFZWNGt8UCscMU9n515mg>
    <xmx:GtgBahMI_cJxvBsYWcFNPjaTgCDmhL5qbc5wF-bKwaM7-qz5imHYZVze>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 11519C4006E; Mon, 11 May 2026 09:22:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 May 2026 15:22:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <67e2fee4-7743-49c7-886f-f6d0d415f494@app.fastmail.com>
In-Reply-To: <xmqq4iketzh0.fsf@gitster.g>
References: <xmqq4iketzh0.fsf@gitster.g>
Subject: kh/name-rev-custom-format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026, at 05:08, Junio C Hamano wrote:
> * kh/name-rev-custom-format (2026-05-07) 5 commits
>  - format-rev: introduce builtin for on-demand pretty formatting
>  - name-rev: make dedicated --annotate-stdin --name-only test
>  - name-rev: factor code for sharing with a new command
>  - name-rev: run clang-format before factoring code
>  - name-rev: wrap both blocks in braces
>
>  A new builtin "git format-rev" is introduced for pretty formatting
>  one revision expression per line or commit object names found in
>  running text.
>
>  Will merge to 'next'.
>  source: <V4_CV_format-rev.6aa@msgid.xyz>

I=E2=80=99m very glad that it ready for `next`. But... please hold off on
merging it to `next` for the next version. I managed to make an
AsciiDoc mistake.

Sorry about that.
