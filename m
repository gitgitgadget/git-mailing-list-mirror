Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEBB1991B6
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759016968; cv=none; b=BaIe8WKoCP7t831ZqBVF969gDjiNnWytiY4bQQ6Xjhf1Yxx/SQFKGdWaBEfJ1cBOU7Obr0dxype/ByuFyDQWNRc9Zq1TuCKWgweslEJ1lBOVOel/rmqjMuUqXqz+Lqiu4/iItzFy7LMRPTEuvJIDq8VcEi/fAETLbYfEdmw9kmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759016968; c=relaxed/simple;
	bh=z7HI5nlcGPPJoRwNZ8etaJXB8UBjbhwDK/ktaWMpkKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qc/y/fPimWFT36x6fhOLd/aJ0cx2isOh9qmO0H0/0x+LVSj1RBM5mHK7Bom5EM36R/pKuUz6YAYZM5Z9Pp3DRnHvykhaXMrzovioTJ2xnZ2PqqpqxL4R01G8ngmdTTb7OI2a+/RRwmfp4pgtij0SNIGpwxXvQ5UEfkMjB4IdYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I3ap5tjj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vFisSQQE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I3ap5tjj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vFisSQQE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C2D12EC00A5;
	Sat, 27 Sep 2025 19:49:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 27 Sep 2025 19:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759016964; x=1759103364; bh=bRFOaP75Ec
	GnNWiCHDGSuC6YM/IvUAvZky5bO3CbLYE=; b=I3ap5tjj18RhqZK57mT3FGdKQT
	+GwjLo9knPlY6yLkmNHHcqdX9ND7XI35yxtKdMxrRshTsCM+x7H2xXCQQjIcwKJa
	/huw3qZnlaOHDq8Fkpg495LHmh8cNTJIEPv9/f0Z962fhYHHWMi1aBNCSV/fw8Hf
	lP5OSAlJbdGXKmUcbgP4xuRsuKJ7AF9hekLb8XHGOzbdkNun1Ps8mfgQrEq5+7Bu
	DSjVjhRTN/bvEkfsmQJOEdFz3JxYVYQz1gbmwTUhPp5WV9w07q1io1HblQJ1wtMQ
	UXXpYgfKKv8JBTAht79buaokbOEFy6/v0UUF9LrBqcsj7RZ0E8D7ZNdTt7kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759016964; x=1759103364; bh=bRFOaP75EcGnNWiCHDGSuC6YM/IvUAvZky5
	bO3CbLYE=; b=vFisSQQEZ19yVAKoLIz6dB3aOJVzPfHFQxcT7GDA1SNSTD3w+WT
	shaNFghTixqZMSLcyBSQCOSqz66nvxqS4TDc/EJieZWFYIIgv02uuktYBX4QGm95
	pbOY6Zg3ZKNR678kT6zcYvOBsezbG0xbr1qgllQbo/k65XQA+omj5160+g2bh9SK
	L604e34q0ixKP0I/4S2zip1/uQNP4wR8tMJSSHzX7vSA7UecBogUrj3XmHV0QRFC
	GY7VQU1v7rUUeyrC+SYhxOr/TasZmDlh3qe3xt/LTnhr2hCN88lC9LW2L7XNdYl+
	EdxBnvZYAjNj0+mREDfNHe3IkKHppS8sWRQ==
X-ME-Sender: <xms:BHjYaEdK75xhvFo94oXObpdL940qEwRcZcRNjEtQTazPKdDko5p8kg>
    <xme:BHjYaJ6rg9H9XvuvpdyuxcCKnTlGc3TyVDEk2NMV99q7zr4IF96Fw4WzcTUK246eo
    XPZF1IEmMVUu3SZ2XTV866CNkmn1TJZcfHEDJEVXIdS72E-tAc-6Bw>
X-ME-Received: <xmr:BHjYaPVgqwMrv0Eux07T3SXMXvB2UbvIunUxBWRMpZ3PGQF6D7jwCRFjnCw3S6P_0sNL1a4XzeI9FoSsjRyUp5DFyOjXf-DBQqXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BHjYaA7W3UQOO90_8GT53Y2AU06_gGTVyl-jiFjjkuP6az1a_5f2uQ>
    <xmx:BHjYaCqHIoAblovy1UwrniekQKFFl7K1nskBw-6pqPMrhnNrCbcSGQ>
    <xmx:BHjYaLlnCypzTdEDMNZpXlK_d1LzqtQf8P69_NRMVz7lB1EfTU4T8w>
    <xmx:BHjYaGPWn0DgEeNKnaKrB97wj5FUZzSSZZ947-ZyARk7-ay_zx2Eng>
    <xmx:BHjYaFisRqobznq4GYuW0rnQT9OoxfDkP0D0wo1S0Qx8SQteRUPssydO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 19:49:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v4 3/7] clang-format: exclude control macros from
 SpaceBeforeParens
In-Reply-To: <5g4ysjfqrjltnqr35xh4efhzmqmzpmut44pherfsjzqinfbpmo@6ax5lzob7sox>
	(Justin Tobler's message of "Sat, 27 Sep 2025 10:51:57 -0500")
References: <20250925232928.3846-1-jltobler@gmail.com>
	<20250927145049.723341-1-jltobler@gmail.com>
	<20250927145049.723341-4-jltobler@gmail.com>
	<xmqqv7l39a5c.fsf@gitster.g>
	<5g4ysjfqrjltnqr35xh4efhzmqmzpmut44pherfsjzqinfbpmo@6ax5lzob7sox>
Date: Sat, 27 Sep 2025 16:49:22 -0700
Message-ID: <xmqqzfaf78xp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>> Perhaps make it a separate topic and have it graduate sooner?
>
> I'll send this patch as a separate topic and can send another version of
> this series without this patch.

Nah, let's save one iteration by having me queue them on two
separate topics.  If you need update to the "repo" topic, you can
just send it as a series without this step.

Thanks.
