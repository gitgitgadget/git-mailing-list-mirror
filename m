Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FF1AF0BB
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737577929; cv=none; b=sAYYClgvlO6VQuuJ98ELl/VhJpA12G7o2pu15Hhkqt3tYf/PntxkfHrS/FYa4/rZXx+uAIqQPQOyIro55bl5Jv9TrSwWl83cuFlrU7IjFUIbyc5ZmlemYgrTLFYvSB5Un2na7IXxkpMAWZII0A9WHLSpzc5iXy21y21I+wZfdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737577929; c=relaxed/simple;
	bh=SsOW4Fwg8lXEzXzV6mMI//0xyY3axyT5gPf/EL1364k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UdUP4QxK2FnHRRX5rnPNK3/4qC4ga08wpw+L5YfOZoQ419KXLERbkDdR+8LL0MEhxKQ22XWBj9p14rMKnzUYzC3H77MdjUh8V9Py5NXfLt0IdxXe5O15cqNHM8h4xc4WLMM/LRAuBCzedVPas1OhSK4qhLo0fMbShaDegdzvxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OCoanlZ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1CtxhdRC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OCoanlZ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1CtxhdRC"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E88B41380061;
	Wed, 22 Jan 2025 15:32:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 22 Jan 2025 15:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737577926; x=1737664326; bh=HkJjiOm9bA
	9/8BYm7AiCL3dhhwSH7OFfIKaeWGaFAWw=; b=OCoanlZ6yL8ZesgbiQSjXypp6R
	vJFN10omP7uwG8ssimVKzOcKYClvNs9Gy//w//TkVcvmjSBFmAaNy+ASI1Fl0ify
	8TeydD7IFH7WV9wFOMWnOgDEql8lzwkQKJoadAufEhK0C0stUAb1aaXG/fZ8jMN3
	Y2wSkueR6I6qKrJbs4peTKV1/hViKsFOq2hzrZ1ukH7oVYEmq635Rxq1+ZYzkJ/5
	nUEfhI36BYdndAQ9/jK2rsThTz2Pe/nzro3KE1CF194OQ9mKn+gtW3IAv9xcbW2L
	HaZVbnJySQZgnmcs8Vw5znyJ1bK2zQQVjbTvvEjMMT09Yu2f5rrX3inH3x+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737577926; x=1737664326; bh=HkJjiOm9bA9/8BYm7AiCL3dhhwSH7OFfIKa
	eWGaFAWw=; b=1CtxhdRCjjMVnU41bbMPFKbvQbG0gYe8CJ5vPTx+q/ynoebc/kk
	C7UctWQkQdvL93vlDUimTDKXgw69+xTMzdH89SkF0umMVRvrbZ+9jEAZXU8ZRYZU
	1xjWO32pFapY6MetKv5fMwmWnYdxsQ/en4xZ+Af52PLO+n8gQ9W9rEf13Lg7zV2/
	wKg7RGww4sJlzijcDG5BarPXq92W+mfimEbNCQFr1YfFW/ErLN5LU/YhS3IcH7l7
	1ID/q9O3OxoPpHjgKfT8+FOKZG/044M3fDeCcyglt/LUjPqcQGANHESk0LAG41Bc
	PqYUArR6hrX4T+6dla246DfYcDCty6SNh2Q==
X-ME-Sender: <xms:xlWRZ1dBpbyVwwxyDsbw_KCdRxje8JuizvDk83fhgmXIzp5UySAodw>
    <xme:xlWRZzMYO8HQVUZZZomvb_8p6E7Ui2tUezp4ah_w6YVmKFgCVvQASbsjDO9qFFYYQ
    MT4sc8-pJiabkoWVw>
X-ME-Received: <xmr:xlWRZ-h3S97oJnSbHGc7Gi7gaSdp6x4Sb9wQA3HXm-_B5xGP4CORtQFid9PQzcl1FYUgOJnzwjc3y-u5P9mQ67G5kG1kGrpNG_yT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehrohgsvghrth
    drtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehrrghnuggrlhhlrdgsvg
    gtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:xlWRZ-_pn3LIX_mKP-WEO09zBoNp_TlAsplAYav0ouV2nRxZyDETeg>
    <xmx:xlWRZxsZ26BC9Lz7jeR2TGXH8icfgWhQgo1kfk5WIGDImWW0nWkXJA>
    <xmx:xlWRZ9GOomX8vbMbap1BZUjTasEPpKEPJhu7opsI69dYOwW0FFm43w>
    <xmx:xlWRZ4Mm0KtKbXVl4A0SsUMvY2pGF_qzp7SPLkn8n74P_zVJhBFoEg>
    <xmx:xlWRZy8Vt4_3_XKSkb6hTPXRG7BbE4z3sFthK_tyRAZEmoJONNA6ThZd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 15:32:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Robert
 Coup <robert.coup@koordinates.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v4 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <20250122-pks-remote-branches-deprecation-v4-5-5cbf5b28afd5@pks.im>
	(Patrick Steinhardt's message of "Wed, 22 Jan 2025 12:31:33 +0100")
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
	<20250122-pks-remote-branches-deprecation-v4-5-5cbf5b28afd5@pks.im>
Date: Wed, 22 Jan 2025 12:32:04 -0800
Message-ID: <xmqq1pwuwpx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +		  "If you cannot, please let us know you still use it by sending an\n"
> +		  "e-mail to <git@vger.kernel.org>."),
> +		type, remote->name, remote->name, remote->name);
> +}

I do not think we want to receive a piece of e-mail that says they
want us to know they still use it.  I do not mind seeing one that
says WHY they cannot switch, though.

If there is no objection, let me do

	"let us know you still" -> "let us know why you still"

on top.

I like the way this has been made into a helper function, without
causing sentence-logo that would have annoyed translators.

Thanks.  Will replace.

