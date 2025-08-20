Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31032C11EC
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676386; cv=none; b=bYWDbyu7y3BHjTgyBEAzkWB29LBggUg3RUA82YlN63Hfkdl5oQ02/B6KnK86tlQK3oDy1lkTAFZ+Oe6BnVSZxdFEYtaPzz+VxwSrJMiAFI9H1KkSBEPDUNGZ4a6DgFEsMotDMUClPflepwpclDREdWgfKjmzFB3JTubJRGD1fao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676386; c=relaxed/simple;
	bh=UzN2FpZ6FrdpaOnGaz1MBYLlwDOH4eVCkwo9gtg/pXk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b3tRD4PtFDrto753sv0X6HG8uJTb7wLrWHr5J06J8AnjExHBo9tCAiM4tIg46aYj9wozSA35lhW0Eoqdm0RX/F1WmYhN5sDsBeiyumX08OEBydC1A7G313pqtugvOKHvTJiOm3brQIHxFwkJKwhgWtA424vbP1x8A6f8DtgnHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tkx3M96Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K0lAi9s8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tkx3M96Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K0lAi9s8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 03342EC05D4;
	Wed, 20 Aug 2025 03:53:03 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 03:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755676383;
	 x=1755762783; bh=h+As+eYBmaDDxWH7AvSUE8XJ1mimcX/hqrF2LSjJYvE=; b=
	Tkx3M96YNkTu0Au0yAccU3dLdj+klhGc2/eNYw+mGlWwA2cVy2VhCkoBglWQevWn
	51z8GAz2v49XWPaD4st3LJ74MeXBkjkyWuD6oZWMz1mDpVYA2lRwg8VLoKa7Tqrj
	3bC5tT2XabO0FxlNhtDM1DeIljfd1ioalKKkPXWi9r/IFiehK3sXr0DqXKTQlQKJ
	+lkaPHXm4a9CrJfhqshVCnP7gAUerG7cfjJXvRuvWZcCsEZlgaD/kOGIksSCYhFv
	y8TWS2fqQAljm3oKFiEzt9BS8RQ8taG2ola4bIaaj2RDsBmNjFwqZgbuHUrU+XSS
	tq1m4cBCV2hPHt36B0WSzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755676383; x=1755762783; bh=h
	+As+eYBmaDDxWH7AvSUE8XJ1mimcX/hqrF2LSjJYvE=; b=K0lAi9s8i3bvSTdPp
	6aYQhDvt17/+oDTARFRkzkrcvklmq6MGuL6h+ElTn9e/Xc3CsiaMKg4pDaTkkiN8
	6N8SQDFcCtH2CkLA4L3sNwG9g+q9GWTnv6ArsVDRs2JQbXfdBKJaVTB8IGizMfjO
	TwkuFiHSbxhmwxtXC+xJbJwM24lmR+79rlGGK267obaLWIcEMoixWsSX1ZqyypZ9
	U/MoIAQXUsV4sNKEYC08d1CxJSanl/65pKGWtJUmZzKIXkpPBBV3e3ds/T/Sc4Fy
	uIVH/Ao8dQ3C0Pua/ZUtZ1At23M3Kd8Jxqytk4i3kukXydO0amTq6vlC7CkjnQeL
	gWpgw==
X-ME-Sender: <xms:3n6laBwRUpPUNjxnYdsxpD5lEyt2fpDIxzha2wMzjs767hpTDvV02QA>
    <xme:3n6laBSNFssVewTFFHCsqC68M0RcGFzBqe19MyNDVC115JsRJf-xxfUc7qn50otSP
    ghd7zmtu3QgeolPAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishdrjhhuughkihhnshdqfhhishhh
    vghrseguohhnohhrshgthhhoohhsvgdrohhrghdprhgtphhtthhopehrshgsvggtkhgvrh
    esnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:3n6laH4IeZ03bwAa8Q0aGKW59VcT9RbW9qSMcluV5FbllpgOywDJng>
    <xmx:3n6laDxNs0wB-0MJBAgi7kM-cUjK4-PqKB0zbzmyVC4nreDZzMab_w>
    <xmx:3n6laLZLnQV-CKceBX2MEmGfNFsPG7J1eJy3L_0y405fOO_zNdkcYw>
    <xmx:3n6laFTKmcMPFHpzVp7K0DbhX4uODtBHfvXciVPpq3H3gbwQcSWzYg>
    <xmx:3n6laLHkXMPJatu_TuRNsSdXH3Id2nPPfo2BkvawUBCRPbSnv-9sLBt9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A05D21EA0066; Wed, 20 Aug 2025 03:53:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATa01O-RMF1w
Date: Wed, 20 Aug 2025 09:52:35 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: rsbecker <rsbecker@nexbridge.com>,
 "'Chris Judkins-Fisher'" <chris.judkins-fisher@donorschoose.org>,
 git@vger.kernel.org
Message-Id: <37da14fb-fead-448b-b6a0-853c9fbea653@app.fastmail.com>
In-Reply-To: <011801dc114b$f38bb130$daa31390$@nexbridge.com>
References: 
 <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
 <011801dc114b$f38bb130$daa31390$@nexbridge.com>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025, at 22:57, rsbecker@nexbridge.com wrote:
> On August 19, 2025 1:51 PM, Chris Judkins-Fisher wrote:
>>I still use git whatchanged
>
> I did too. However, now that git log --since has basically the same
> functionality,
> Perhaps setting up a git alias might do the trick for you:
>
> git config --global alias.whatchanged 'log'
>
> so
>
> git whatchanged --since=3D"2 week"
>
> or something like that should continue to work after the command is
> removed.

You can=E2=80=99t alias core commands.  So this will fail in the reporte=
d way
before Git 3.0.  Then from that point out it will work as an alias.

--=20
Kristoffer Haugsbakk
