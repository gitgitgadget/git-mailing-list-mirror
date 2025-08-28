Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2422F01
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756403290; cv=none; b=NQXb1xwfy+0+BW+KpBg6N14/wCedwcab/6xoQF3Kf/jlgHUKuMSnfc6fKR5taXTqgOvEiDwXQVSY1cPBiB1YfRkZl0EtVetZntMYeBvA7ApCIwyYIJglYn0AweZJTjw5iecok4mWpseRPlNB6rI+OI3x7oNCR//4sVq+TglUPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756403290; c=relaxed/simple;
	bh=eKG6GbFn3IWaHmuCzpgseV7BUrvMlEPcDZvzX+yBhxg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ulXaB1zX2r9O2gLXynZHOPpLanZAcRqRI94+Pe6kcz3Om6joZdWsH7jbWuMUsge6zdbVwPAGQ38L3n7Ski5ZG+8E3Y4GYdThXhfH+jp0shjLLH8MkLtqM6asZpCcXdV37vrT1FSZrV8g4n0LYFeVgKeuet0u5U4LZ+secT0rjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=OZP9cME0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9cMMdaZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="OZP9cME0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9cMMdaZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 52748EC0389;
	Thu, 28 Aug 2025 13:48:07 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 13:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756403287;
	 x=1756489687; bh=3tOPrE/zRnSzUiXzJy3+QTkLwvQOd5IErPixebbbQvw=; b=
	OZP9cME05c0UPmQfMAUZKOUZFcz5n0tT1yTvhmeGzvrdRl4chT4MAhCPtZFmHr26
	bOkYuj5UnMWLTtymgnRT7Uq7PDY29WSA5S7EffyKazHyDAh3sBi7KIaKS9GYixSe
	d8YrW8bOT3RoM9mZlcY7FQk83RTkrAalKVq2aQiQ44fz5GqB5EE1P6BQ+aJ9l5j2
	ted0P7GW3fZUJkLeaVLywGnZhk6Z50Xi2fzoDxtBFBdypA79exzOoFyhKET5M5y+
	kZEcozel27klMIZsxXSNvTkLldc2Z2Fw8H2gS8Mv8nXCt3DZ+yq1BEESA1UHzJAI
	s7gjh0cg8o122C7GX57ntA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756403287; x=
	1756489687; bh=3tOPrE/zRnSzUiXzJy3+QTkLwvQOd5IErPixebbbQvw=; b=T
	9cMMdaZnUb6MsoHy55U9srO5zhYqJYIbxy6sd+tUJMbomK/L5edbEJTMmG6ilTHP
	CjjL7OSkGsb6OfuePIFq2ULGImEmPtwRaj66j8N5vqcXjA5RuXHQaAyQ/OcG4ORn
	vkz8PZXlXDos6S9SyWqNVp8PcIGk5H19RBKkQc4W2trR0+TmclMx7npcDBLC/bL4
	c92kjK7c8UbQEFIpzf3Oqk5uO+Hij6uYxraGk8L14+ECmb1yVh1pS3Jb18AnbiFT
	J4e/gXBtB2KodEQ/QfgUuPmvQqHYGX00emDC3GcW/fI73/7jn4EaNK4Ity3Y+kdb
	tskTxkKLrfMVneiCsgCSg==
X-ME-Sender: <xms:V5awaLqh4fV3bvshn2pcVSA7y7P_3Tpx3sGsxBeLfeytLb1FFcb8Sw>
    <xme:V5awaFoUzROMCrBmzbi74VCB3jsmAi9x4nlvp7fKlPoiSIg1ID2qy-oKxZZoK5h4M
    Cd921d7tELs49-gFE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epveetleekueejheduieetiedtvdevgfdtgeeiueduueeghfevjeevueeggeduieejnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithdqshgtmhdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhn
    shdrtggrpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:V5awaKwLALA3vMh5Srs38E5qz_CFo1-v-9lRsMYETJyR78K1rrL6Sw>
    <xmx:V5awaNL7ck9w15FXjgzqL2YxfMqQQqHPZJnlychd8sWpFwBcr8adag>
    <xmx:V5awaJRlXW7ic09MfQOszO1PaI8AO5_rs-j5OEsqQx4kplhmTh5c1A>
    <xmx:V5awaNpBSlF7FEoEEKquzB9UoHMm026Qk5gbd7_qOTaXr76xB5GwSw>
    <xmx:V5awaIM2be6kGlZ4drP4E0KG9aa48YcqBfqPLcuUz1uNL7oFeLYbmjaZ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D08C7840CD; Thu, 28 Aug 2025 13:48:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUHFTxEbwLBk
Date: Thu, 28 Aug 2025 13:47:46 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <4d9caee9-973a-4d41-b6cf-d399a238942b@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCca2Yp7K16ShqUaZNN_POv106qyXfKq1aJMyXhA+EyCw@mail.gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <2fa98fb5cae78b8872d0b864ee246ba619ef631b.1756240823.git.gitgitgadget@gmail.com>
 <CALnO6CCca2Yp7K16ShqUaZNN_POv106qyXfKq1aJMyXhA+EyCw@mail.gmail.com>
Subject: Re: [PATCH 1/4] doc: git-push: update intro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Considering the glossary entry[1] is for "ref", not "reference", what about
>
> (a) linking to the glossary (is this possible?), and/or

I like this idea. Over on the HTML docs side
(https://github.com/git/git-scm.com/pull/2040)
I've been working on a way to show an interactive tooltip from the glossary when
people hover over "jargon" terms. The goal there is to make the glossary a lot
more discoverable.

Right now it only works for terms inside angle brackets (like `<ref>`), but
I've been thinking of adding a `linkgitglossary:` AsciiDoc macro or something
(similar to `linkgit:`) to link terms to specific glossary entries. It's hard
to tell what that should do in the terminal version of the man pages 
(maybe nothing!), but it could make the HTML versions a lot easier to use.
