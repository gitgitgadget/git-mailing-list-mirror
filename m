Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655615A85A
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755464984; cv=none; b=nN7QKcoKjfLplAojl/cxrmb/mkeda7cuz8LeyWcNRxQcyRNuMQtlRbUkD+Zb6ozaELtit/Ct2xeoHsbLlClVXlfJWVxEJB2jC4vS8Si5Bna6hWZ7pP1ipgt3oMe8owvJTitY/zE8ZsLIE5re4riin70zP1ux+QWgTKNZvU6F5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755464984; c=relaxed/simple;
	bh=2jE9sdRFupq2uSCk1ZWWEOSW2q3v7RodSrfKpoJpU/A=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IIAmfyXzhTEP0pu8xI8YodDH3997p8UUXbB83HuyDOacsTKDZKWLIhrcd8gEQZKZ4wHDUqPh0BWr3PFP8gzvqU+exHjHMAYOZGfaJhY4IvZ/AByBNX0R1VY4cqqHTzjS09mG3R+o8jeuXoSN+VBKSaEQ8f1UMe4aNVn2VLQGt9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jOMLBVVu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/zZZcNg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jOMLBVVu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/zZZcNg"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 555A11400027;
	Sun, 17 Aug 2025 17:09:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 17 Aug 2025 17:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755464981;
	 x=1755551381; bh=2jE9sdRFupq2uSCk1ZWWEOSW2q3v7RodSrfKpoJpU/A=; b=
	jOMLBVVuBkMw0sJEMGknWimqlbLUl4/RIv5ZTU4VD7TOadD/eigP9EXqkbjgfSEx
	dXTkTf15iFB/Mid6lfIZBZqwIdTiz2Q97d3JCuEhz9HHCwNNXtEK4tl775SyjANE
	Fw+Ek1QhNxwU8sF4kDiTYzkEF1xpMXYecv3vS2ByzXQ51joMl8+jOqpsMUn9Bi+B
	f+UsUGRdXpOnfpLHwG8Y/iDTxogIyrN2qZjTA/8ZZ2afQWI8FVjHxAvRoMv5fMWf
	WK5g8mhJ5hX2sULFnGTH0TAIeioXouo8k1UCrGjJYyokur2Bwf1pi2B+Q2+cmhqg
	3tpeYx85vMVznMw1QCUC+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755464981; x=1755551381; bh=2
	jE9sdRFupq2uSCk1ZWWEOSW2q3v7RodSrfKpoJpU/A=; b=e/zZZcNgzbWIwbUMd
	81SBuYFMfYCDC71KITkzpkpDbMYyFarkmFu68PgNsvWFvYfJCwEFiAq490By0JaX
	/6irlItqvXcMP8sT942tWVqBkCp4S/fBw2AdS1DOR7Efyx3FmldmvmtZaTE/QV7P
	k6iEVCyz3LtRTOM6FqJqlzUkqmnXBHBipguHSPEp+/fkH8UkBvPycZQPSqVH2mDZ
	6tdAQ72TWrPQNFx2AyoiBEXq8eKKfduL7YnJd4BbiYfAfNjo8lwxFzp4Dw/JVgZX
	nk27r8ErEV6V7EWaoRtOqUVJRM8QrTJ24zg+6uvDVVswQDnq+H5sVpRxgKwRj/HT
	QRhVQ==
X-ME-Sender: <xms:FUWiaNH128btW4RcGrDLbCjEkFi9RbpwKc7oH8BvFwu3SBD9QOa6JvA>
    <xme:FUWiaCWMI20MKpbNy11a32bCJDJURfJEjM9NnBR4ZabUPOBCZwRViF7FXL7pwY3jF
    8UPW7AzCzQt3XtJ2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peiiihhrohgshiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FUWiaFJx5qODn2aj7ZNIRDjVbjJey3f7IPxbgU0MWYNxHt56zGqI_Q>
    <xmx:FUWiaKFpTFBtf3-vXex_CrtfvkCx1SjUGOT11QDlgjs2dKx8iyDcLA>
    <xmx:FUWiaPqKc3NqSImmOqQA60ZDYbTJ_c30JVhgkqqJdf9OdB2_z98Rww>
    <xmx:FUWiaDR7G73X1aMTSFy-GLGCOzehZ40efSjtdqlvl6JN7f48Pqh2xw>
    <xmx:FUWiaCC4BBmNc1aKc-rWUOcYIFVUexVDHkbWTD-XdyURraP2YJt9gNTt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 177741EA0068; Sun, 17 Aug 2025 17:09:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APjY_5Ms4KDc
Date: Sun, 17 Aug 2025 23:09:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ron Ziroby Romero" <ziroby@gmail.com>, git@vger.kernel.org
Message-Id: <67621563-9441-4ae9-a23b-51af7d3ce666@app.fastmail.com>
In-Reply-To: 
 <CAGW8g7mV6az3ybYf3uzHYQTGLDwc34eebZnha1EQ3Sb6B8E-fQ@mail.gmail.com>
References: 
 <CAGW8g7mV6az3ybYf3uzHYQTGLDwc34eebZnha1EQ3Sb6B8E-fQ@mail.gmail.com>
Subject: Re: [RFE] Add JSON output to git log commands
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025, at 22:17, Ron Ziroby Romero wrote:
> I would like to add JSON output to the git log command.

Previously: https://lore.kernel.org/git/CAGW8g7=3D21pPAgCixjpayEvmw_ns-h=
cB4e59NP476TKtCRXHPXQ@mail.gmail.com/

> ...
> ## Design outline
>
> * Add a `PRETTY_JSON` constant.
> * Create a pretty-json.c file to output JSON log information
> * Modify pretty.c to call pretty-json to output JSON when the flag is =
set.
> * Use existing utility functions written in the existing source to
> output the JSON.

I=E2=80=99m guessing that the existing `json-writer.h` is relevant.

--=20
Kristoffer Haugsbakk

