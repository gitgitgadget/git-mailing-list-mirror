Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6D21771F
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364971; cv=none; b=YpH258xBux7efYzZzh3MlIe7fzzRENTW6elE0eN99xX4cnipzOT3FxGpj8+/C72jIoFOVrvCgBKGPCFC8/drToLN+h+EqEqpDSo1utsP7UgSIS+Sh9PTYvnDUiRBPmCQoIJb9b907kyqjdcCo8M30PFJFerOOxMSq5UReqpvw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364971; c=relaxed/simple;
	bh=hRDDW+urFsWTyDt5aaq/tUw+BK2rOU9eqx0+Hw834oo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ye6h+InuOFsYw5EuhsLqB954W9+Syr/jrWjkBk9CUtIDsCmXDHCFYGKtig3my+eN81b3eMcnROG+eS+0iBqzbz8iVMhyWAqc0tg43hlvKJ/MIvNeV6JMkGkUiRlGmUer0c6yJg0/ltoIlf1y4fkOSkUptH2OlaFGyW6e0vkJg70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qzo0mjUB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q4Us164X; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qzo0mjUB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q4Us164X"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 202A47A0048;
	Tue,  1 Jul 2025 06:16:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 06:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751364965;
	 x=1751451365; bh=hRDDW+urFsWTyDt5aaq/tUw+BK2rOU9eqx0+Hw834oo=; b=
	qzo0mjUBchs4tZUc1Xcv4lctKoofFAYTm/OXLN2s4xjAeigq2lzutkF6O0/ql07e
	o5ZDYosZm/y6QZnhuL/hF5c9w2/iTfBWkYC7hD4V8DRHxxE+wkScwjFa3obRsPS/
	zJQhA50OQumBgr7GKe2WcoU9fQqbXXS+rN+HPJ2U3NNTBhjJX3MjVlWvwYAB0gI2
	H92MtaJD/309X71W8ddG/Cfsdbd0aOF9c5eSm7V1Anrfv+H+QJVycAzWrZfpDQnC
	fPU8LIvIRmZYrJt5FJHD7ARDtTH+qo5pTGMrqMACo5pzxkxWdbvYf+AjgqYQKIGL
	Xnnvgdb7K7VfvcwclrJfGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751364965; x=
	1751451365; bh=hRDDW+urFsWTyDt5aaq/tUw+BK2rOU9eqx0+Hw834oo=; b=Q
	4Us164XJHipuz7een7WNbTGDbwslhE1LiODn0akKjY5yrGUU8KMFCTV0FRKQMwxk
	IIUZE09FjFr3uwbVrKr6vj57XINb7IxKH+BGfGOsOc16KKkRL9GoGGGrXkBchVxr
	/a/m7IQYi5v+Mm4IXPHBY01kYayMdVz28q6wBjqGGRcA3I/twbLeFi9OCaaEhj1c
	4naxNCbpI4DItgwa18Yi/7vOvYYMiFCrhwtJie5oz7z71BgZJFiXLC99nTDwGwmz
	ZKxG8p4MbCz4pgySzgaX3DkP/bEAHcUHC4dR5NZVYhOZO9ArQ9VLbKyH4irjXLkJ
	FpyPqv8wZZ6S2+L4HqHeA==
X-ME-Sender: <xms:ZbVjaHh0ulqQ_paqLi8H9wfXyeRq1arhrjZVZJHrAFjTF7ESYwu1vqU>
    <xme:ZbVjaECDndxxJnYw-odFX9YG4is4Q0OU1EUo50viZJh11A2DRD8rN3nkasC0TWNq-
    MPJA5Uk3Gw495m-zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZbVjaHG6XOkwVbNNBTSbLW58te2B8DzquLDC3EjiDP3EoS7E_oEdNA>
    <xmx:ZbVjaERUDM8Od0VNfNDnLUnjK0qU2U8OGhv0C-PaJQdiUkqTZxx9vA>
    <xmx:ZbVjaEy96B5AB7uphtmy-TILbHSnJXBxWvC86PODkDWzb4GLSZEjSw>
    <xmx:ZbVjaK59IS5pxN-ZiG14Hbyc00hclj2acMIMFxZF_NwWEo25PSluow>
    <xmx:ZbVjaMVsGffk_tAemVWrTQPPZOUTU_DGS6IkH_6IUkWp38OurH0Jj2m8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A85EF1EA0066; Tue,  1 Jul 2025 06:16:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tec469262b87623db
Date: Tue, 01 Jul 2025 12:15:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <adeb38ed-fdd3-4261-9c5a-901813b102e2@app.fastmail.com>
In-Reply-To: <aGOx3C7-9NNi7h8Z@pks.im>
References: <cover.1751310455.git.code@khaugsbakk.name>
 <aGOx3C7-9NNi7h8Z@pks.im>
Subject: Re: [PATCH 0/5] doc: config: update for the ps/config-subcommands series
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025, at 12:01, Patrick Steinhardt wrote:
> Except for the issues mentioned by Eric and Junio the changes look
> sensible to me. Thanks for improving these docs!

Thanks. I=E2=80=99ll add your Acks to the changes.
