Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039C10F1
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769724; cv=none; b=sTuf8xtFQDkmCMS3SW09Tu9J5wEgR/IPMV3uAnecoknXcVCS9aszcf2ahD8PcEfKVMgA2mM6/MgUdalpjqW+wGztEOTSGAOoQRm27qRscKnESjpE0Hj5DDVu7+r6+NhBfJru1UhtWsEnJ2Zvp63SWLYIslsEc7pX+dFp0ckf0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769724; c=relaxed/simple;
	bh=kJeqvy0xPzqdmlLo8fPDmAwbauC9NkzDnmknLImQMMs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Lp3pSwmLcJWGIm9pxqR9f49eksxWLjl+jcytrevuswVBuxk/suVZZJZ/KhkE/ohT7+VxUkU4dy84bxja3wuqi2UZSONCKqAudwmSmr/hObC2MhjzqcIwC5cP2dd/c04IhPNSa6e9BLdAp/HHRb/O8UYLclcLKjB+/BQhJNgQ3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dhOsLSa6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EVwZ/YxS; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dhOsLSa6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EVwZ/YxS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 630D37A0A40;
	Tue, 29 Jul 2025 02:15:20 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 29 Jul 2025 02:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753769720;
	 x=1753856120; bh=DObUwuYvZncJlMm9ODcIrRP8O7/Rk38Jv9YGnPCUVKg=; b=
	dhOsLSa6VoF0RpGaOacapioWQKDjhYfHVXPLkkd1jO0pMUsFQ/p5jWbrpdxVcGQu
	R4p23oa3XevqPutkAcY6n3uqoIzFG3UsGGKmR05ehi2m7w2UtWYNqpmJd6OdzB/b
	7iumup9L/uUA42JvONSVaoqxsEFiM86XQ55Xj9JHRcwART9cl81eE0ADvTdg3CW4
	cgPsuScct9WB6OTCaH+n9MfUTdPXMbdbN1JhYakDrns+EM1ISXZwl8AHsLShP4wC
	5vVLTTKVmCsG8HBoV4u6MV3ZPX4Mni6OxCnfoT5kTrnwQFebcv8wsU06UYwQMPqA
	8AZqH+FtBG4yRg17wokzng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753769720; x=
	1753856120; bh=DObUwuYvZncJlMm9ODcIrRP8O7/Rk38Jv9YGnPCUVKg=; b=E
	VwZ/YxSZ47MCFHm28/EmWKEbxOWp25oa53+sCGJiKpRhDWg/tVkQ2P2QRRIuKIqG
	d7iFZd5/d1gg3agvLnJfLx8BrvvOuqj4lTd6o9xRu2BTVxGeqzLVeCbEIPCfAmP9
	KlFCm/wsxRYjI4ZTsttLEMsvgQQI9T5QTo6iN6BVhCUd/UFh1LEEXTkL6gnh1W6Q
	J2h6jqefs6IFx5LgZ2qoiU8K73JUQsNkzxTb5uw0RZ1/ZEc2c53oyeWzk5H0q5Z+
	y+3g3DMFAeFXiFWDpqbnl2ZgweUnvmGRWKUhV92G2a9GXN6K0UqaZJVCLI+GnFPP
	5BFPJ0QZs3alPvg3aE/YA==
X-ME-Sender: <xms:92aIaLzl6cSy_R7PSR7guNAVwj3LNVVkt4RHVOXU33kp-b79k69auYc>
    <xme:92aIaDTVQxVCvbIcTSY4StTOjSNG55P5mIV7St2FdDTW5RXkANIsg3neeWZ7KRszp
    mhnypGOBsiwqU3FVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggv
    rhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtg
    homhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:92aIaCC65Rj4ZSBGHjQxQ0NOQ_Kzk3QkVbPAByqc5g9IqbKrTOnWjw>
    <xmx:92aIaBuOx3xZScLLfuWMcWGRP8WjpPl5i2vKUjAzNTnyeMEJuSiJkg>
    <xmx:92aIaGfBP7YSr_tePMLAQuxWlsOp8_yEwhSObQv5rOp9koiBbf9oSQ>
    <xmx:92aIaG8znwBJeRCwggjcbQLPX53Tt978CebjNq2gdfBFWx5qwazcyw>
    <xmx:-GaIaO0qn_UGLcfG3eSc6xJZy0JmGtxeoABvLtbDzaIjr9HCMNuQttFQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CDEC91EA0066; Tue, 29 Jul 2025 02:15:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8ba4ad04096afbd9
Date: Tue, 29 Jul 2025 08:14:59 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Justin Tobler" <jltobler@gmail.com>, "Junio C Hamano" <gitster@pobox.com>,
 =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Toon Claes" <toon@iotcl.com>
Message-Id: <6cb4522b-43f0-4b0b-9dbf-4f10c8c94487@app.fastmail.com>
In-Reply-To: <6E84D571-CC02-45E6-9E58-DD918B45998E@gmail.com>
References: <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
 <6E84D571-CC02-45E6-9E58-DD918B45998E@gmail.com>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write new entries
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025, at 02:25, Ben Knoble wrote:
>> ...
>> Will show one entry since `branch` is the one-level ref `branch`, not
>> `refs/heads/branch`.  Now it looks like `write` truncated the reflog =
and
>> wrote a new reflog message (if you mistakenly think that `branch` is a
>> branch).
>
> This quirk of update-ref bit me the first few times I used it, too. I
> think it=E2=80=99s at least documented there though.

I do that with update-ref more than I care to commit^W admit.  But
that=E2=80=99s consistent with the command and well-documented.
