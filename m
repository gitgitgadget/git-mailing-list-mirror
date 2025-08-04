Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709AD13C8FF
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323479; cv=none; b=K/96EpEtftc9TaVUajIwnUeoN2Oj2Wrr6wfLnY+5wsMTZFiW/FBzTfI5xg1QTmCg4uRcivIawy380dA7WF+EmD7CULnmpNHcl0Z2H92GQkV3ouZ91UsOnuY2U/5A4CmXJo4DwCZH4+sshmEpu8ioFRrHRNC7rzIJeUv3ILuarb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323479; c=relaxed/simple;
	bh=rMQowHroSdyQm0nmn5Eu6mtjkh9Otg32O89+6DJyR/k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RtNpHXyswIudPtNTpVm6FjstQ2y0y42gaWnyUru02zxT+1CNF9Hdpzx+zm4FOvTAtaUaXc9J4e6dxXXM/zCr3q9UGXVJ32cQPLwQjDGTdsNAm7JF2JOSIWZVvWKHE/p6MEeFpvDwCeLyUKejdhSTJ02Ed++lyLnamZOdMIUTfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IfE9okGc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fXUuLAgn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IfE9okGc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fXUuLAgn"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 80CB5EC0166;
	Mon,  4 Aug 2025 12:04:36 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 04 Aug 2025 12:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754323476;
	 x=1754409876; bh=rMQowHroSdyQm0nmn5Eu6mtjkh9Otg32O89+6DJyR/k=; b=
	IfE9okGc5OLq1JKenOqfpdV1k3T9uCcE3JNlxSImCc0HGidq04qKMZ3OUrpJXpeE
	ITX5KpidjWX7LyncESDWokODXot+m+WFaH6WoOf3Nz0ehROPggBe8yqrCMpacpV5
	rpRnCOepqYgiGMBZroExXfuS6T5fgu8KJ1ZndWPB9qRFkBYSqoMZMF/dN2p81TDn
	nF2PwDTcxZaQBwKu7beb3YIQBUGDrrw8FyG1XFuFFr8w2Kuya8kDpMevqWGDxAhJ
	pt+bP2PsxD5zcZ3SYe8FxMuqBFgA5f4zFCLMy53+N9EGsgd8DvDIcSoJIGfb933x
	i8IGU+BIwGYGqZWBMIBryQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754323476; x=
	1754409876; bh=rMQowHroSdyQm0nmn5Eu6mtjkh9Otg32O89+6DJyR/k=; b=f
	XUuLAgn5GhwZbjM+ZdLeojZWIs8r8AB/0hHgGMu07SKdvDzakRH5kUcjAr1rsdFu
	s/RF6q+CeytCXmGHd8lD3rqtHZPdX+aTwyRpX5gFaGihRxirzFUWx8JZ3PIC8Pia
	yjxjJltt8dgnDxeidgq6IpkeoOJkbb6OWMo0woJ1nXyI0NFnYrD855iTU5wtVf26
	+T4lkn8ddV8Dq2EqxVwB3LsUjZelU6XxkZoEJ/dDI+kdBRt8dQ1Pv5c6xx3MVlxX
	MT/iJb9oicZueUUHs1pCtdJWsuIpCX+GJne56Z+ZIJWDR0H2fHe1TfSlbFRF6KPT
	5LM6zDnfPa+/j+Lz+Mvrw==
X-ME-Sender: <xms:FNqQaEaHGQJ-9jszlKGLOA9mfGwJ-jZ8tkG2VY7j2Ggyl2s5bnTMb2s>
    <xme:FNqQaPaY5YR0W5n1XcnhXm-cmnQuyDHwOfWtiTmaAPH97JuJeomxOqBnnxwmDSxAE
    IM8WNO1hvjefQ-JbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehudfgvefgfefgffdvhfffvdevveegheehudetvdfgueffjeev
    jedugeevfedvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehkohhsthhigiessghsfigrphdrrhhupdhr
    tghpthhtohepghhithesfhhmohhrshgthhgvlhdruggvvhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FNqQaNhHUQ2Lzr9sw4r0EsvFBCapF0TwrP5IowmQtyvv_OvcO2IiAw>
    <xmx:FNqQaI4iqafn4Iagu2Gi_WB52qYoAMmcMACLqqIEUU_IoDLm9Wpkfg>
    <xmx:FNqQaKDLiGGcNEIvi_IQiFGiwU9p_m7zzqqna4LNiTBdsG_YYaKVkg>
    <xmx:FNqQaPZ8g1OquZvRG_iMcZc5FLuQ__oMwYXhd-YGreP55nZpe1g9Yw>
    <xmx:FNqQaEMJ30hNXMZFpa8UXWHoJZWyA23wSqPUT1eq7yHu4Ox0POQa4HDn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E60C11EA0068; Mon,  4 Aug 2025 12:04:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ta85374b9201c6e20
Date: Mon, 04 Aug 2025 18:04:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: FMorschel <git@fmorschel.dev>, git@vger.kernel.org
Cc: "Konstantin Khomoutov" <kostix@bswap.ru>
Message-Id: <ddc841ec-bc4b-4c01-a99e-9a65af3963bc@app.fastmail.com>
In-Reply-To: <917aa62f-5f2a-40d7-8fa5-f19a14926241@fmorschel.dev>
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev>
 <0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev>
 <2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
 <hi7t3qk7difgzip7syscarnf5ui5avnhmjxil4vzurwcfo7a6x@drccf7gibn72>
 <917aa62f-5f2a-40d7-8fa5-f19a14926241@fmorschel.dev>
Subject: Re: Feature Request: git mv --after (new flag)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025, at 17:53, FMorschel wrote:
> Wow, this seems to me a really weird design choice.
>
> Do you have any insight on to why is this?

https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl=
.org/

> And do you have any idea if this behaviour is tracked to change=20
> somewhere? Maybe by project config? Like, one project could opt-in for=20
> an actual "rename" history.

As a bystander: I=E2=80=99ve never seen anyone involved in this project
wanting to track renames as part of the commit.

PS: You need to keep the CC intact when replying on this list. :)
