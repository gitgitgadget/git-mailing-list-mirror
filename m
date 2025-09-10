Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E22D23B9
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535673; cv=none; b=KvXVDimR1YY0nB+51Z6LmxAQAZpmeCxaT7I+KAea0Xk1lANPTI9KepavLabKPWi83f6BwyKHeytm+imHPD/rOwIMccgGALtSjI3/FQa7adwxZ653nirETKv3ptfSG/yF8xeRZnPrx7JaZ2PTUDGrnGEMEUgsnKtwjRsa+tzPhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535673; c=relaxed/simple;
	bh=loEeC3EChYyZ5JwHdsqRT3uMCUNgZl9RjNUuw9HpzYU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UZWzG4zG6xhXGFc7VWGoKSlkm3l1Slr1S8h1kdhdihTg5fG4vKUOa9ZvrINkCfyYna+wv8ZGemzAaBQRII38FJ5sPbyjmBUoZrRSuBBx9//W9Rq3Hn4FnnVVf3kpOny0/Cl02oA5ON3YUsFX5ztwSd8aGPha4n/NbhX4k555+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lvolGoVg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=domIEDz1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lvolGoVg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="domIEDz1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F3887A017B;
	Wed, 10 Sep 2025 16:21:10 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 16:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757535670;
	 x=1757622070; bh=rQ8GqAZ5gvY1Xsvh5FDJ3aoEcn2WQPZMPlqYMYjQOTo=; b=
	lvolGoVgy4mrl1GnONZj9i6U56luyikQ2fVx+g/3iQpB8UKj6UIz/WiO+ha87aTl
	F4edlnLlXtWIO5sIaFyPZliU8o2+3UcuJ4PlGQ7tDVCo6U48LnmNRShq++Kdt1LU
	PWZs1Q9tZsoDu4QhXIVV9dNy9ERD+RZiZFgN1X1teJU3Gm3wd9gYZlvACtEP7FN0
	QbP6q88yXsFNXJuj1IEdEQx3jH8ONqqU3+FltCV2pFpLoZrhDhIH6XqamkS5gRl/
	sdE6uezBQkjA4PnytU9qNyltKrC2aokTCeB3w8e1izIuzvJa5xP0ACHQhQw+XUHA
	46YrlAu1kF6kthnUv3JpJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757535670; x=
	1757622070; bh=rQ8GqAZ5gvY1Xsvh5FDJ3aoEcn2WQPZMPlqYMYjQOTo=; b=d
	omIEDz1WSEQXS0+urcJXaet6fCo3RhupBMNkgz8XwCEjQWuwVgJxQ7jKuFXhcdFf
	/2Ws1i2nX3K6udLnnvZsSRZ9CzW3ap7maq6VSOomZqz0myOOv5iSdnAaxmdvxO2K
	kBiRSBr8sd3IjQLUiyovsHYsl+6VTSq3Wir1fqpaQMJ70e64/KRszLpgZ7UAyTSV
	KalYsv0xhY3oPPpGRlOr1Dp78TVDvOf1UNgkIjXliPyXTu/VJ7Gae60LE20c+CZ3
	1kfyh0cSt8oZG93tntz3BCjHwXhIlm/2R1tH3LCnAicx1d72cqbg+qmCqLEc7ATM
	1xABZnqS2jcUn3Fk0hN7A==
X-ME-Sender: <xms:td3BaEmFA1VWboZ_s15phcZxNSFv6prBW3xc2keXoGYEUKS5kmD6vWo>
    <xme:td3BaD1ygdEHE6AQPspIeZtCTxY9TIfdYPmnBpeCmsoJiM7mEL2L9k3Wed2fKxL_T
    nMZ8nuMhdyrGuX0Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefg
    ffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhrnhhivggu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghmfihilhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsth
    gvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:td3BaErL_u3g8o4cRnKgd30TRKWOcRPPx52f-QRQ_DUBPp3aKeLtkA>
    <xmx:td3BaAKh4xoxLN8qjheGoH9eV29fuf7ikCAV5Ev4HbZ5VtmglXWCyA>
    <xmx:td3BaIQrakox8bXA5m9pkGrQTUvATcwIhvuoLwuqSTndr0bBjEV3Uw>
    <xmx:td3BaAMtlnGOUwF6H95bU8X7MNY4zgB_Ar3Cz2eYeYwpo6n9MDrlkQ>
    <xmx:tt3BaN0n4TaqkNGnRWQBcUgKEb4asAxMupG2w-b3ykJ5aktjMGXxjc0->
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 724821EA0068; Wed, 10 Sep 2025 16:21:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5U96pOjIZkV
Date: Wed, 10 Sep 2025 22:18:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Rodrigo Damazio Bovendorp" <rdamazio@google.com>,
 "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "Aaron Schrab" <aaron@schrab.com>, "Jonathan Nieder" <jrnieder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Josh Steadmon" <steadmon@google.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Brandon Williams" <bmwill@google.com>
Message-Id: <867e9a54-9b49-41c5-bc65-7e50c21a939a@app.fastmail.com>
In-Reply-To: <20250908140117.262205-7-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-7-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2 06/10] submodule: encode gitdir paths to avoid conflicts
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025, at 16:01, Adrian Ratiu wrote:
> Based on previous work by Brandon & all [1].

nit: =E2=80=9C& al=E2=80=9D/=E2=80=9Cet al=E2=80=9D?

> Based on previous work by Brandon & all [1].
> ...
> Link: https://lore.kernel.org/git/20180807230637.247200-1-bmwill@googl=
e.com/ [1]

nit: This practice of appending or I guess prepending[1] the footnote
reference to a Link trailer isn=E2=80=99t commonly done.  It=E2=80=99s u=
sually
that regular

    [1]: <link>

Thing.

Trailers are almost always pointing to people identities.  Not links or
commits or other inanimate things.

=E2=80=A0 1: f62dcc7f30d (remote: remove branch->merge_name and fix
    branch_release(), 2025-06-23)

>[snip]

--=20
Kristoffer Haugsbakk
