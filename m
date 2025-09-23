Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E6303CB2
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665433; cv=none; b=OGfQz4npXkGy+DNuXUkTOLlWXmpjmLcFwAy/OBLuq/a0x0uW6JV1dtnaLU/Jty/4usE54azV3NIKZv6u8SJHb2cWtCIP6TfxZtXk1lo9tdOkuByw7jdK67J+5U1lxF+tHIVnDqoBueSo7QsDTGEAN7P8iKFajRWrcf3S/dlSygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665433; c=relaxed/simple;
	bh=p4RGC24tGNeDmWC9I7be4G+OHmoDqUGltWxdyuy2SmU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s4W5hOTLpAH4JNhHs/kK2boeb/kZSE7WXNnEgssa3+DI2rmOViBLQ/UXjmWvzBqCnRnOhqj6rKa7EtxCFN/pdLPVQnNTPYRFSnr74f2+3Bc/HVtX5Q38z/OE1vkM7BB476CVYviuoJ3ZRB5ROh7QRaftzq3mU0R3mNbwwKuLaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=g7CVRHB5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bz0MqLpb; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="g7CVRHB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bz0MqLpb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 26D0E1D0032D;
	Tue, 23 Sep 2025 18:10:31 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 18:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758665431;
	 x=1758751831; bh=xU+C9jDgdS5GgtzVcK2oPfqWP7D8xzwFLejJIG/yM1I=; b=
	g7CVRHB5SManc26hUc1hsZ+CsSUMBUWAy4auZnnWFDlYdpGUQ0WjcFrppCW1Quxx
	3JoLtW/Zt5puZzM7UU1s+YWLXDn7FCHDEuouGOCYGmqc5runP0vqEOtbNUSyWY/N
	+MmlhG54DXgle9g7Ov1EVd1odDjQQ8KiIhW4onIWXUJ3XEK4wnGuL5FWsJyN2p6O
	cwbB6TgfA7XPsPlM2nbwzBzqj4zjHV32JTkbU4rJ3QABxMAIWTI0/4hBY9EfiOK1
	yila9IxVxrfY/cjfmR0QRXIYaX2kdlyTaaETY9lW/o0lI3aL+KY4yXOZfkS5Wrs5
	/10JQSIE38FCdhUTCurcKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758665431; x=
	1758751831; bh=xU+C9jDgdS5GgtzVcK2oPfqWP7D8xzwFLejJIG/yM1I=; b=B
	z0MqLpbaPAuMf+U43tt5L80dJwmmEVblYEvtb9NCYxgAdAJj9c1TrdDOM3plO+Q9
	rCP3Aa5AYouqz6o9mBMSOQWUf/sAnroMeefrBWkkyJh6+FZ5+dvPMi9IGKljGx/9
	el5wIe+PJhMn2KFbZPQ8YTvEpao7q4d9JtQcOL0/PJDVdgNZn/wp/TgwGjl++Bv/
	zFNNFm7W+bXGwTuuZ+OnzWmf6vbxH1RiqGeiRIeyl9+Kvyig8UjwH+3WnHUIUhzj
	me2kJIAXYFnL5xH4JWZXLjcq8Z+NnynAQlNsK4tsM6ECeDOX6HsFS2YncyhtXHqC
	n9mjTgQBJgFVNY8rOwDww==
X-ME-Sender: <xms:1hrTaNErWDADasXOW4K6_6FXs5qJwzb5dDOIBQRWaRL_8H1kUfrLDw>
    <xme:1hrTaJUuw9LXTUW4nJ4ArGzkaVWZJY31wJZ7xQLMA4lIBFGkPGi6pwW7E1PA-M35H
    Omt5oBY0iPVLBiIfA7wjgLc1nfpeyCbahXcnC3qiEneSDRbFfs9tWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedflfhulhhirgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhs
    rdgtrgeqnecuggftrfgrthhtvghrnhepgfevkeduveeivdevueehhfdvteeggfffudefge
    dutdekgedtledtvefhtddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepjhhulhhirgesjhhvnhhsrdgtrgdpnhgspghrtghpthhtohephe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1hrTaKz-q_6JbPupwZgM10UtupW4WGFQiwnI3ZrR6cn-BD8ymT09wQ>
    <xmx:1hrTaGutO_bxKWIRn4WWmQ5t_ksppGIC7RgNVJYvQSpCAwRgRsVkZA>
    <xmx:1hrTaND04eZwLaggaPla84xX4c_h2M-kMZfSzyA-ZgmYms7bUDAfXQ>
    <xmx:1hrTaIEDtNfw47lNc1-GyJPx9qCS8cmAknyTcLfcj-wm6fSA349b0g>
    <xmx:1hrTaC_wzdw6SNG8Vf3m_ByfVN7UnHTBmP7n5RHZZUYZxQP-cPNVAI2z>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C01E7780270; Tue, 23 Sep 2025 18:10:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APYrWJik5Pow
Date: Tue, 23 Sep 2025 18:10:09 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Jeff King" <peff@peff.net>
Message-Id: <2ddab74c-6d42-4ef4-b7b1-783f1631bdba@app.fastmail.com>
In-Reply-To: <xmqqa52komwf.fsf@gitster.g>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
 <pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>
 <xmqqa52komwf.fsf@gitster.g>
Subject: Re: [PATCH v2 0/2] doc: git-push: clarify section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> It is somewhat awkward to have two outstanding sets of patches to
> the same file under the same theme from the same author.  How would
> this relate to the other "git push documentation" topic?

I split this one out because they were logically separate and I was concerned that
together they were becoming unmanageable. 

Happy to re-combine them if you'd prefer.

> Thanks.
