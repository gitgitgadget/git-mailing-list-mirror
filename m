Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29529A9E9
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274729; cv=none; b=TAJCCPIWm1F9uwGxeHUjtyV1676GIuzi8rw1vNU1mAawR5HI9+EO7MsPcp1UuETq6s3lDb/TGb32Hsd92LAz1LOrPWKB4UGu/emTDp6pZI1Dz9i+XoUwjpBJnc87F9vBE+Fx8ic1OK04Mtp7CHggXn9gjcO5X4V8y9i8cof/als=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274729; c=relaxed/simple;
	bh=PinW++qrvi9b+Fy477jTtVb0qRblKiQtS6kQGPyPii4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hatMPUCWAXSZXkbdNGkrxvS8uIHdBhjli/Jph7VW9AaHpg2DCPEM+szth2UZB21Zcnd5uqkxI2KK4P/YNfp3kliadq+6y+Kpa9ZkPimAzde8ocCqNJ/T+ZRc9yfb1eyckZtbMvm6+ACPGsGXUFSv87JGYOQwIsxXh823hh94pDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MjRoyT9+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IlpDaN2Y; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MjRoyT9+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IlpDaN2Y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E16F91D00146;
	Fri, 15 Aug 2025 12:18:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 15 Aug 2025 12:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755274726; x=1755361126; bh=QwZ2lJKeOC
	quNyMLiUw1s21TwBZeOzAc5a+JaHNpwy8=; b=MjRoyT9+1eyOFvwdnIcEVCVtBQ
	IJNLQPbmvfgKMU9WYWrakTSUIbDv2hZv9FwJmoESis5l3R/FGG+w/tuKjxqxq+SG
	rAD/qYwVyHhenrJ9Isy7zI0NvxHOgi8SZl0hW3XRRj3Jm79kytwGaTuWoM3G87Gw
	PbNXqYBF12iUIPN6qr5gYJqM6vXqmDIVLTquFFaw5PSgwQnrNcVT8dA/18CVInH+
	bnpxW2SkvOl/CwTCtJdUYqfqIe95B6w89auQfzrN9CkyL8EbB+u2esoV1aNzHT1u
	i/PEko5AaTZz1GHS5Hr3900RXVPTkwtiVLVcUJrmpxDb7hNqXm3vFrcAKr6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755274726; x=1755361126; bh=QwZ2lJKeOCquNyMLiUw1s21TwBZeOzAc5a+
	JaHNpwy8=; b=IlpDaN2YdzysF2RlKPM5+6fHM23M3pJs43XfepH6Q3rllqXUZ20
	mJZpzZCH8rYfr6YzoJk5iJ5WWQrNh54xmtRhboxluqXlpDh+3EuZLdoxFr3x5wJn
	JGRx8QktQIX0VsV7itfnPIYgTMGw27EkoQ6NHBspyPCsmTAp9qozh3uMIBRtyX0r
	/8W4G2P/NVo8i/5N4/nfWtMA0pxaAf2Em5WsUhrTMKgc6p3oCuunoy7Qb9O8cUAX
	nuaKAi08rBzzPvbWNAA49TUYHfg17Lij35RBb4afzohDI/a1XmoulIXV4pUIcXEP
	PtVGZlUo7cF81Cuuzv7sbLt58p1Zn26Czhg==
X-ME-Sender: <xms:5l2faEazLS5g4jWNhzzSEows8MErV-_BfhMycD4RlOTRGas8GKggvQ>
    <xme:5l2faK7LIFQymWDevUZ9F-Si6XtIyZ8GwfInGkzEAvSeuiFgD2skC92OKRTHTUxpZ
    KAUE9CCt3_VZoLBTg>
X-ME-Received: <xmr:5l2faFY3_nbYwEP8fkcUKnhVhLoCjSD3Xm1xIBiITi_-CO1XDtaEXaE6Nx1Qa9Y2pfPeAS3sI-SVRIV84nl97FhjAjocjoZk-lpExps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeggedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5l2faJiQUtxRiNhNxmbNzxgVgZS-QVTwPIuOb6H2IcGWSaXnDjSSeA>
    <xmx:5l2faG96LB2z4S78NtF0p-BzJMFVYnqxO9NUHwlU8i2-2_e54APCfQ>
    <xmx:5l2faEojfdg7elhepvWngcTUu-Jb8CdnpVJdgkWUWA-2Amxeqgdehg>
    <xmx:5l2faOXDpUbEC6R5Z6iQo7c_ieDQwtSeZTp1mPz8ea24VhlyrXYnrw>
    <xmx:5l2faIc6_DtwzHpB1cF11sr3vtwcZjPfgddTrUG29xHlgLxoZ4gnM85e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 12:18:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH v2] bugreport: use quoted line prefixes
In-Reply-To: <52a6177e706d8653251c61bc660f10b703ea6a9e.1755256099.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 15 Aug 2025
	13:10:15 +0200")
References: <20210723175950.64955-1-felipe.contreras@gmail.com>
	<52a6177e706d8653251c61bc660f10b703ea6a9e.1755256099.git.code@khaugsbakk.name>
Date: Fri, 15 Aug 2025 09:18:44 -0700
Message-ID: <xmqq5xeosgm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Quoted line prefixes make it easier to distinguish between the questions
> and the answers, both for the reporter and for the readers.

This may improve things a bit, but the #1 thing that made the
reports most hard to read for me, while reading bugreport output
posted here over time, is lack of a blank line between each question
and its answer (and the tail end of an answer and the beginning of
the next question).

I wonder if there are things we can do to encourage reporters to
leave blank lines around what they write?

> -"Thank you for filling out a Git bug report!\n"
> -"Please answer the following questions to help us understand your issue.\n"
> +"> Thank you for filling out a Git bug report!\n"
> +"> Please answer the following questions to help us understand your issue.\n"
>  "\n"

I do not see a need to quote the above.  Nobody will write in this
space between the above introductory text and the first question
below.

> -"What did you do before the bug happened? (Steps to reproduce your issue)\n"
> +"> What did you do before the bug happened? (Steps to reproduce your issue)\n"
>  "\n"

Here is one blank line between this question and the next question.
If the reporter typed on that blank line, we end up with an
uninterrupted sequence of questions and answers.

I wonder if it helps if we did:

 - Give more blank lines upfront, like three lines, making it

	> We ask you a question here...



	> We ask you another question here...

 - Give a stronger prompt to guide them where to write their answer.

	Q1. We ask you a question here...

	A1.

	Q2. We ask you another question here...

I suspec that the latter might result in what we want, without
annoying the repoter too much.  We could also do

	> We ask you a question here ...

        (please write your answer here)

	> We ask you another question here ...

but that would make them remove that place-holding prompt, which
would be annoying, and at the same time, tempt them to remove the
blank lines around it.  The fewer things we make them remove, the
better chance we have to achieve what we want, I think.

Thanks.
