Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70720B80B
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053685; cv=none; b=ep/Dxeh8VNb5DxbsqqNp4+3zz3XyRPalvgtF051KPpDjNHXL5I0gNtvPY7JBqpcNvQRXOORjaiSuidz5mMG8XnmC/xcU3v0Qy4Cyqr6GY7dlmpJT28BtdVkOF3o1L4mvohUGWGRx+ujqXkADbyuHv9E2Eyzi/9O4fwFQqbYRk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053685; c=relaxed/simple;
	bh=FXZZdPtj2OnaV5915prS+7P1253D7kYUvJGT1vSmFyY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EpW0PcUPv4opQpFH7G3DiHrOSgg9k0WVVuBQP0qQkTqjzP3Ta2O9fRJ6satHB1OHdbPiR5cGbGMUQxEZQJK2yn62FsBsIGSL75fXiTgpSk5Y5WLpEeJtsaT2dhtTkxxuUOfQqb0vYJGl1kAYuMUJxMRBmPvBtKRmFkFV7fR/jJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JXwap+vr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIZG8ef+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JXwap+vr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIZG8ef+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D1E7EC04AB;
	Fri, 27 Jun 2025 15:48:02 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 27 Jun 2025 15:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751053682;
	 x=1751140082; bh=6YFVyoNHEr9BSZDd2zgXPWwhvq/WLP3N34Vf20vTPNk=; b=
	JXwap+vriuDbzaKHZ3prmlOBfF5G9tYKT+RSjGFHSUa5WxM/oMg6BAKYVmfYfZ78
	YcMjPrBvlL0c36vIRU15x+DW3oKyEYQBXnE1swC1OFw/HQZbDj/F4XNHZCt3GijN
	UPKtvz2I02Bvagr6IE/oQMD7036itB8uSQN98BVfn1lZ62pdtobq7A2VtpTdozg5
	4wTUH7vN0j3vnjFdWS7LgV016yjBPmlBBCX3OeEbQphoua2smOOX/G2jej1iZNBC
	qCr7dt9qoRf+4KmB5i21hASCB1xznyyR4Alf3FBems7j5qKeyBzEK1cOk7CuJ/QR
	FFuuA6KY6BLISjxnFUS+vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751053682; x=
	1751140082; bh=6YFVyoNHEr9BSZDd2zgXPWwhvq/WLP3N34Vf20vTPNk=; b=J
	IZG8ef+E+8QFmADUixpQ068BbCR9Xagd7LbFQnr930TqTlTZJMEkKLpgB1Do5uRn
	bZG7ffx8si8HMhHojq3v9G6HHNUwGh4xQa4uy4FC0Jxqr5qmiHXdFLrFc33kQIJh
	GhVZILBljN6tXsGoa3c4Qd39SVGbacY9NDt39uM4i5lA4ZIcm21gPe3xAg4pqLsc
	JDVx3zz24fKWD8AmtQfuuUAhT3nKh0mjVCaRDqO3fTKubL7UN9yBA69BHGwPI0hM
	A2Pju/oI9Jy4wUE8S1eZqTWDcWDKXpyrXIN2sBO5cMkuRdoZy7CPA3HuzF/swJgW
	CBkuA1Kyg7aT0Iq94e3fA==
X-ME-Sender: <xms:cvVeaAT41UuTLooawRQCZ8Be2smZ5eD2IU8pqLai7g8I1Dn0F_34_Hk>
    <xme:cvVeaNxNlOq70qElQBBHIzHlm3S-vGkpFSHdyHwzkWl5sajY0K39eFLSgtBcv6olW
    bSF_KSpW4wx4P2LXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehudfgvefgfefgffdvhfffvdevveegheehudetvdfgueffjeevjedu
    geevfedvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehnsggvnhhithgviihlsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cvVeaN0mSaX7FcrnzeMG0I7G38HreRLAwjMjoRDl4vM77nHVFriTCQ>
    <xmx:cvVeaECGr9ci53W1BiSA7RBHIEFtaaNSwZAukEJkTtVbB9dnm3sYTQ>
    <xmx:cvVeaJhtnQf9UVMw-MX0uM1c5Y5glihLCs7qwfbijy8RVCrk-LZHdg>
    <xmx:cvVeaArWhAemvXRX8Y3QHglasDkEYBzJFbQG1Mr8WbwJ_8pakTHFYA>
    <xmx:cvVeaFBlTMLdGauHVO_-_Y5ZXi5Gq2Xoazu455z88pqpGxeicDXcIWqz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 283971EA0068; Fri, 27 Jun 2025 15:48:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T53ebb176af89f275
Date: Fri, 27 Jun 2025 21:47:40 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Nelson_Ben=C3=ADtez_Le=C3=B3n?= <nbenitezl@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>
Message-Id: <a3cd775d-99fa-49de-881b-1e8f178f9102@app.fastmail.com>
In-Reply-To: 
 <CAAUd64333fEMHAaNW=-CkfUMN4HDFF2v==HdO0OFnOgm+W+Jog@mail.gmail.com>
References: 
 <CAAUd64333fEMHAaNW=-CkfUMN4HDFF2v==HdO0OFnOgm+W+Jog@mail.gmail.com>
Subject: Re: [PATCH] completion: new config var to use --sort in for-each-ref
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Previously when completing refs eg. "git checkout <TAB>"
> all refs were alphabetically ordered, this was an
> implicit ordering and could not be changed.

Style-wise, the commit message is supposed to discuss the current
behavior (without the patch) in the present tense and what this patch
does in the imperative mood.  Like you are commanding the code to
change.[1]  Something like:

    When completing refs, e.g. "git checkout <TAB>", all refs are
    alphabetically ordered; this is an implicit ordering and cannot be
    changed.

This also gels with the general pattern of:

1. Introduce the current behavior
2. The problem it causes (maybe merged with (1))
3. What to do to fix it

> Previously when completing refs eg. "git checkout <TAB>"

s/eg./e.g./

Maybe also some commas like

    ..., e.g. "git checkout <TAB>", ...

Or maybe it should be =E2=80=9Ci.e.=E2=80=9D?

> This commit adds a new config var to allow setting
> a custom ordering, the conf value will be used
> for the --sort=3D<val> of for-each-ref.
>
> When a custom ordering is not set then alphabetical
> default is kept, but this time is explicit as we
> pass --sort=3D'refname'
>
> This commit also adds '-o nosort' to 'complete'
> to disable its default alphabetical ordering so
> our custom ordering prevails.

Super nitpick: the paragraphs could be wrapped closer to 72 characters/
columns.[2][3]  This alternative (slightly modified) is closer
to that yet not very uneven, still.

    Previously when completing refs eg. "git checkout <TAB>" all refs
    were alphabetically ordered, this was an implicit ordering and could
    not be changed.

    This commit adds a new config var to allow setting a custom ordering,
    the conf value will be used for the --sort=3D<val> of for-each-ref.

    When a custom ordering is not set then alphabetical default is kept,
    but this time is explicit as we pass --sort=3D'refname'

    This commit also adds '-o nosort' to 'complete' to disable its defau=
lt
    alphabetical ordering so our custom ordering prevails.

> This commit also adds '-o nosort' to 'complete'

=E2=80=9CThis commit=E2=80=9D should be replaced with just the imperativ=
e style
=E2=80=9CAlso add=E2=80=9D.[1]

=E2=80=A0 1: See Documentation/SubmittingPatches, =E2=80=9Cimperative-mo=
od=E2=80=9D
=F0=9F=94=97 2: https://lore.kernel.org/git/CAPig+cT1VfY8QiUvrrV3-obTBP1=
439b6iwaebJtGwML5MScnQA@mail.gmail.com/

--=20
cheers=20

Kristoffer Haugsbakk
