Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F83C2D
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744844; cv=none; b=rSGab4SpIdlvCaFexJJKDemW0IucK1w1U8SaQCHNyvs4+ndZJG/vWx1ggrXwftN3R22mS5WeRLHPw4IAyKgqLtObwpsvIQpiSjbMyhcsBq20/qILGCmXstvnggyIU2b/Ils3Ir76jDvKrNpeAXWcUHcp6iy9tf6deamSqkTTv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744844; c=relaxed/simple;
	bh=Or1ebXFfQKQ9tYa9oH/Yf3H3g5CZWV00dmzVLV1Tt5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jpKa6EsaBN7OUpMgiBDCOpbAPJ1BFR6egk35R7zOOZRjXaaMarZjt7D+6sF6Dpsmlul46TyMLLnsBhKt3ty1uhB7R+Cw0A0DDxjWPgp+ex42Cw4cA0CBC37DZpuvqr1LewgsZrnxPQRLxRFlin5Y+1xQ9qGQgybJUacQ2AbkKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mO5C8YEC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=my1xONTS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mO5C8YEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="my1xONTS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 82BD81D000CB;
	Tue,  6 Jan 2026 19:14:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 19:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767744841;
	 x=1767831241; bh=Mh4HpubWgJeADx8gv5YXU6irtdm2RzaSUxi+z4NZhoI=; b=
	mO5C8YECkDgFqkTE0Jwz8C1Kotn6QwnmSy/H0rcUvJUU2OYwMMPu/85aONXnnHku
	R/7XHDr3rjtp9lE4jEWhbIUtPvR69aI4kJbZolSDbRTOwpSl/e+9YakcGkW+RGaB
	52tf/tStYFGHWJbw6l6Eq5cvRLhm8WwmAhO6rNEH5IKCu/jhk+IlTRbyUhJfsDNP
	W+v7gH+Ez/Az+tYzPltqryWuHlrFTU+/5ELu85hn7OCT759PxR9vE+LQwVa0TA6c
	FSg2sMuqGS43+dFeBf6h9WzDlLnFom2cJ/tBoDZseSMk9PIhwRnRGbNcWYQncTW6
	CmBkgzjq4vO/oEeaYpsCUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767744841; x=
	1767831241; bh=Mh4HpubWgJeADx8gv5YXU6irtdm2RzaSUxi+z4NZhoI=; b=m
	y1xONTSFKAx/EvK/1W6wTtQsTnZWcAkdtaM4BlBxbeqhefwtLbkjO+RwpVIOCACz
	+P3V1/m4P4uaFQXgioXwrw/YPVkxGp0oUfA3cdF04PYF0g9tyGDzTTT2MnqtmkHl
	o6NTWYXC6dMLyPy4sCUhcY9Q/fued1sG+/g8PaQPME8suCz6qZYpK61K00999b7C
	/Z06s/e67E3D/FPxKHn0ifTi1qP2dPfRczwCQ4EE/xdlrS2Ci4Uy2dyzq4JBVlcH
	hwa6WSYfLC4DGmzOLMJUx2WvbfAcX/Z7rKFYz11WZZqMQzkKEQr/9hEniw/b+90n
	2STFlvRyDpiaitNacX1VA==
X-ME-Sender: <xms:SaVdaRijx8TDTpLwUtjbFSfrEHPWNczFEygeIUqGbkd7dLORwbsamg>
    <xme:SaVdaa-2NF2j-yxo7a2gy31SfHimVFiEufjQI-ZF5DO6-jUrykiJwKYq_CQNnAsC2
    r5307kvaRAIPevzx3vmGZ5ke8VZbDXQIuaaZebLl4gRMGjBy6cTHDk>
X-ME-Received: <xmr:SaVdaVUyZ7j2nYX_dWH73VAxb8DbNR5YEJoFVIP11h9oPl6uGF43AxwYoW1121qSfkIlOZkErifh5sqLGCVfcdtq14aHUjs1LiWWup8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdduiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SaVdaWCCJmms_fEWYa7YWHJqRre39PbG45OK39sJ8THvqkL4WL697w>
    <xmx:SaVdaSG_DpgJ4JdeKaIhGMd1NWjljR94QdwtfqbNTmy-Zz9Rg0BF9Q>
    <xmx:SaVdaf7tNkbZvtHb3MOkaYS9NUp6CoW1GQg5tEFrC7sKqrfCN6rWwQ>
    <xmx:SaVdaQnCA13p-1aWu5mCJggZUXhMPPs4uWAvPRy8QGtpiMb_yq121A>
    <xmx:SaVdaaGnu-LtcSDuh1kzaPxZ2kZIujd7cQ4f22QbaZUtU-LluwhBMFdp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 19:14:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Abraham Samuel Adekunle
 <abrahamadekunle50@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [GSoC PATCH v6] add -p: show user's hunk decision when
 selecting hunks
In-Reply-To: <ADCF604A-A3F1-48B9-B29E-777CE7026EAA@gmail.com> (Ben Knoble's
	message of "Tue, 6 Jan 2026 14:01:31 -0500")
References: <54e48ac4-7151-4378-b95f-8f22279d6761@gmail.com>
	<ADCF604A-A3F1-48B9-B29E-777CE7026EAA@gmail.com>
Date: Wed, 07 Jan 2026 09:13:59 +0900
Message-ID: <xmqq7btujn3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> I like the idea of telling the user if the hunk is currently
>> selected but say "(previous decision: use)" makes the prompt
>> rather long (some of the prompts in the tests below are 80
>> characters long). I wonder if we can find a more compact
>> notation. "(currently selected)" is a bit shorter and takes us
>> under 80 characters but is still longer than I'd like - maybe
>> someone reading this will have a better suggestion.
>
> I haven’t looked carefully, so apologies if this is nonsense.
>
> What if the marker of current state were on a separate line before
> the prompt? That would allow more room, right?

Vertical screen real estate is also a limited resource.  Also, while
it is good if we let users know what the current selection status
is, I personally do not think the benefit outweighs the downside of
cluttering the prompt unless it is kept to the minimum.  So I very
much appreciate that Phillip raised this point.

Thanks.
