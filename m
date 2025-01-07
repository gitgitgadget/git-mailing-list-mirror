Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620578F26
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736211212; cv=none; b=gYiwOMVLV2dL8Tc4DuYNWepn6W0eMdnTbCTRGERuvnSl/n/ijEBmOHOSr7QH1FAvv2lJndSRxVQ04jMHtNXzq82dmLTYiX76mxKk6X5kd+kfOTdUdHCRlAha72YHaqPJpOwRMsg3JIdKWSianvx7Jo2QSGabQzsHenfoMt9MVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736211212; c=relaxed/simple;
	bh=Sxu5RK8mi5m6YRVF6UHjmuQLWm9sAZUpq7Ex/8ZCeqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r49GgEZQEnH4SJdc61iX3pu2hklFF8Xr5yjWWB7WhtfwTouuC3UdhhwGq6Z+jIE/66slU0kmfxX+a6kIfG77BPdfG/ISqkbGRDXnX9c/oJw7jprfrr8riU9YoEHoukeDtqPFHvuYExJTQTfmgRQ8HpVKwFgnZqSC+X4Pf4FMYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0AQR7ygV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNfkzC3y; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0AQR7ygV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNfkzC3y"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E994125401C2;
	Mon,  6 Jan 2025 19:53:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 06 Jan 2025 19:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736211207; x=1736297607; bh=Qz/Wka8lqb
	d3eQaB6zxg5DlrKLl7zyVQDrhLc8jV9sc=; b=0AQR7ygVx84NuXP2jODpCTxqYh
	WYx/zLDndWGofJgfzRrvKPGOQsZXP94qxXIted7tmbF18e156vEtGf/+UUCkj488
	FI0aM7kT+t5Ncclmqh93TuoHySimhUOusT/rHkr5lYSkIgrFlUiJH2cIdYiZ0NiZ
	rNaQKxBEqKYG3aGTfadAm9B7biWJTLjp5bWLE9UHXw/5Td1a9t/rSsvXoDRJ9Us4
	qWDDD72AA0DqfYL97nfFFPRNIFhTgCZySqcMIFRuD05sa++PiEipSvUNlmvAb3/w
	p0J7eP0lp6FM9fsmWRh1Li/5Qv74oK5j9vlHo2CQJJPfGA+Kjdsip7x4Zksw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736211207; x=1736297607; bh=Qz/Wka8lqbd3eQaB6zxg5DlrKLl7zyVQDrh
	Lc8jV9sc=; b=cNfkzC3yAftLkOC7VOne2f0sTvY5Elzf2SNDjWVnSIBBOgVKq71
	cAm+UYiGBmabSfUncacE3o1+eDdw88Jt+u/15opWTG+bJeqLroi8+XUjl4noeUnN
	HXoni3PS12VlXLmorsVJsP44hJPi7v8TtK87UM/OaA47Jd7veR0OP4fswZWAflmP
	U867i6b40tmvcFvcAUDDE6qXIhrSlYWuPF4TcFzoybaqmuxUIkjOnN8kM1h8Feie
	S1syAUOC4OzsGP/haRGIkZc5+IXRMdcv8pA5aJIR77d1770vA8tTFi7rju3diP3r
	HuWssRjus2/R7OUqOGdd/a92417OTq2qp8Q==
X-ME-Sender: <xms:Bnt8Z451hdb41bkR7M-GUVaieOyJO_S5D_WIWM7RF0R8KtwWwdezZw>
    <xme:Bnt8Z569TgkUw5q4aVUbZuo5BFc6L29PrwZXbuwMkHDmsrJCmh365nDuuBdVWU1OQ
    V4PRV0ntdCQHjydwQ>
X-ME-Received: <xmr:Bnt8Z3cI632_GSoedJHAxFlxeZ7uNKtaVicJu13SxiZocHEH1akirtGQvwBBkqiKt6kM_ItQBA3bd3srbxrkied7m_fx3QLIxduu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopeigmhhqqhhfrhhmlehtiehuphdrfhhsfhesghhithhsthgvrhdrghdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepshhovghkkhhlvgesfhhrvggvnhgvthdruggvpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Bnt8Z9LwRAtRNhxMYnGqrHCtQEDyYH5ueMVj_tg4OwKQA4b6WN1rzg>
    <xmx:Bnt8Z8L5khZLt9mmVfYMizbk0MrdCYnFkLIcW-hnLNULqIx_TLzmKA>
    <xmx:Bnt8Z-w_t6T_iVPlftLwQnbfznRuC0hwtydnIh532GBC9VLoY9Tgtw>
    <xmx:Bnt8ZwLRoc3uXw8YPM4sxEbO7XN8DaF-A_K6HTtKyPSvG5diqhzwUw>
    <xmx:B3t8Z1rrehgsCThJBGOx0xAHHzGlncZMdW1TmP_tWlfqwGNq6r-RcsJD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 19:53:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: xmqqfrm9t6up.fsf@gitster.g,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  ps@pks.im,  =?utf-8?Q?S=C3=B6ren?= Krecker
 <soekkle@freenet.de>
Subject: Re: [PATCHv2 1/4] add-patch: Fix type missmatch rom msvc
In-Reply-To: <xmqqed1fwjt9.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 Jan 2025 16:26:26 -0800")
References: <20250106190855.3098-1-soekkle@freenet.de>
	<20250106190855.3098-2-soekkle@freenet.de>
	<Z3xxxbKtqyLmDAif@tapette.crustytoothpaste.net>
	<xmqqed1fwjt9.fsf@gitster.g>
Date: Mon, 06 Jan 2025 16:53:24 -0800
Message-ID: <xmqqa5c3wikb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> If we're using size_t, we can use %zu.  That's specified in C99 as the
>> appropriate formatting type for size_t, and we require C99 or C11 for
>> all systems.  We don't need to cast to uintmax_t.
>
> You and Documentation/CodingGuidelines contradict with each other
> here.

By this, I do not necessarily mean that we should stick to the past
tradition since d7d850e2 (CodingGuidelines: mention C99 features we
can't use, 2022-10-10), written back when MSVC was claiming to do
C99 without letting us use %z conversion.

What I meant was that if we are to update our stance against %z
conversion after re-evaluating the situation (and such time will
certainly come someday---I do not offhand know if it can be today),
we should update the documentation before or at least at the same
time we recommend its use to new people.

Thanks.

