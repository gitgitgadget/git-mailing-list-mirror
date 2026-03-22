Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564636B061
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774142563; cv=none; b=pkJIpC3R87eQ4SR3r7c7zp1klbFzKVLDQSxGbCRSm6gjd57gaEMgaVoWOfH7sSv6XAIwYaQjNfpr+T/oX5G+cTzkDpmU7VQ/5voPGgXmkaKDwgjwPtuwVdsuFlwwZD7nN627QxzdQM21SRPuGrRAQGUCjCdl2hKCxKFRQJkbtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774142563; c=relaxed/simple;
	bh=azDeDVTDb1CdlgtC0c0pha25dDOX/eidM2q9RPBBBNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ul6cjl5+NU0IFehuDrS6whyyqAFLAYZ3a/Ydkck8EtFZu2UnSwcCsWUbOX+UjV8EdStq4Cuq9Ox2u2hqF0CpebEsum+D3v4PMInCev+jY4YvAgnnJc7A7vfh8OqxOtR0EMtWeHXe3PUto0T5JiciJilDJLtA/QzElciyuRw5jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DMoKJHwj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FMSK9wuS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DMoKJHwj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FMSK9wuS"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E9D27A01D6;
	Sat, 21 Mar 2026 21:22:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 21 Mar 2026 21:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774142559; x=1774228959; bh=+TZrcNvAsO
	+nvjPl6YWXW7ElrkQfPTYE8ZI3Ue466EA=; b=DMoKJHwjVKHfLgi47exJjpdh/M
	Z8da5gUREftq0wUkbJFdi31Ec84UAAWn2X9hsV3WMuFSoSMX0V8+Iqd4mYfJotnF
	R/r/PhiCAPNKG2xcdt57TlWPG4HOIDFUFofISO6gfi6ofnChb1thSwd8poQFX6AW
	1s68pZq3133j699r/HU7dkQUleTjEePll0NfqlBDzgensCiVHKMcP4kk3JFeUi0r
	WOGROFsNEUErdiaYByT94hm67tAIuQwGCA4Xso5JTLVn8yRYnaP87RBZqEXYcRrT
	lWGOZBAcGztU0GoP3sA9dTP89iHV/Iah0ngU6E/jnSkkecNXvLd3effURzIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774142559; x=1774228959; bh=+TZrcNvAsO+nvjPl6YWXW7ElrkQfPTYE8ZI
	3Ue466EA=; b=FMSK9wuShuatSknNf2w+QEXaNfEbuOL+A1OejCyYTw6qa1+Ch+5
	WCjccjfZciFANPc3vd0IiiVwktp96dh476tTwIQegHACeSG6C/jILojkHsskk/vz
	63Dr5cCUQs4Ae8pzG807IrjjRp41AqeYQqE0iALakUW+6QK6A4aB6YO1pLYf2M4t
	RXaJkCTvGgboHlpp2Nk8hz67Sf0eRilifuGUfxHpHdKObFC+MuhKHSeS9rzmhrYH
	dtQV5aSxuY92JHav/agB7pa/rQy+DRLfOV0TgNgfcAv99Vuh6EUB5IQpmBCjBBwK
	rbJUCZLzMj5RvDscSbr6gsIEtlVw3V7x21A==
X-ME-Sender: <xms:X0S_ad18l3c0sxTJ6VKS0-8xUUqWx5FQN8yI_1DonnIs-9nyyIL2yQ>
    <xme:X0S_abF4mSp33Eco5PWT44fLLdSJScKBIzJlwZ338e8STpJCp1J1Dv3IujQw5sxlg
    KHrD5y0OtILuyKD_WyEb49_qswIXxF9pJBaWwDnx4rczm75nx9B>
X-ME-Received: <xmr:X0S_aS533TTS_rc9G5ZFZcSYJCIVAX3IfZX6to2QBOLgQ9LPsrb4AfoSEmazl7olASdH71-QryULVUIG_rivWRb9RMuzgFiVDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeggeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X0S_aZsg5xZxYnMLSyvAbYkUR9-xfgBFsfFp0CScq_YcBX0oOWngvQ>
    <xmx:X0S_ab5Z2Y3tlcZBszgm8iqg9g8tV8rY-_J8Lk9VaV0dHlXb746-5Q>
    <xmx:X0S_acU36nnrV3C8WWmnt_cc8VSltJcQWxYrvJWe7PTGTUtZEGSYaw>
    <xmx:X0S_aV_QWx4FnxOYMkw7K0X6ZtU4NrDhat8cf772gDRDrgfqEXIU_g>
    <xmx:X0S_aQNSp7DyCVg4TNbvw2ZQb_dMPF6BZejT9hLbp2GmwCwOXEzEam58>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 21:22:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
In-Reply-To: <20260321211828.GB736981@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 21 Mar 2026 17:18:28 -0400")
References: <xmqq341wnvbk.fsf@gitster.g> <xmqqcy0zii0s.fsf@gitster.g>
	<20260319233546.GA3632561@coredump.intra.peff.net>
	<3e387439-c066-4e45-b28b-43f77c8824d6@web.de>
	<20260321211828.GB736981@coredump.intra.peff.net>
Date: Sat, 21 Mar 2026 18:22:38 -0700
Message-ID: <xmqq5x6oac9t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Could the function be rewritten differently, or maybe even made a little
> simpler? Perhaps, but who cares? The function has been largely untouched
> for a decade and the behavior is fine. And there are a bunch of pitfalls
> that a rewrite risks falling into.

Well, my only interest in this codepath was to get rid of "if
(!sb->buf)" so that I can lift the special case in the Coccinelle
rule.  Nothing else.
