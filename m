Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46AFC0A
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765423468; cv=none; b=bLx8TafrnYIS97LCIplTC0ml5hVDU9OxOttYCH/LTxLU+yXxxXcnZagKvtu+f0vN+XoemWPwREK/dXlOOAaHz3xTM6Cyb0F0J9TjQPxlfHHhMIknFQzT1fxsMzi4gtV8FPssfYOe+yYz+LdRVekoMh1DhRqAbDQBLeHEKaoX9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765423468; c=relaxed/simple;
	bh=7S4JUkkNyZaGTzOWnOf+zKs072iFMcqTgb87+DgC7ew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aFCG+rKD1/eiYHz/vmdYHSZ1DAC0wHgPK+vvJiNG2aWhiIqQWyz9ywl7aUVEVlWBUYVRxJzq8tGGBXMP3NMiulL3NeMss8mKvGSppmDeONtZoDAOJCtxtn2hgtOy74Pw6z9R9Ln3XqnmHIUgoTQ8744dZ1/yb4hzqKfl7YLrnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FzJ4j33Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VHPC7GMY; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FzJ4j33Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VHPC7GMY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 481D87A0088;
	Wed, 10 Dec 2025 22:24:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 10 Dec 2025 22:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765423466; x=1765509866; bh=g2YkrCdVvB
	77mVwwKjOogYFj/TKIOtWc3sFdyC18PDw=; b=FzJ4j33YMkY1GMT04qACHmkPZK
	Q9WuGeQJl1XCTIksZu8+ahI6/7oVAGLG9sEB1m6nQE5VKG8YmfwfzMyTZ0ux9ZTb
	2bpWeBb+gxn74SvM9GM2rC7paAhUAwe6FtNDn3OTX3XPvq+pXPm1SuPQwOT3Fwan
	6SVzn9PTM3AhEYP9nzgFhzTRP/wAoWTIPZcuPiUWaU28Gb8NgMClrq0JN5rRyvBS
	51u04r9n44ZvnBe+hzqxLOaRKQtlyal6DiAJF66E68QuudS8NtUuXLa0n+C68rjE
	OkJF5kCxmN//IjEB/KKxt7YqAVYzZRb5wUp+AX2Gy8InQKSNeXhN3zuNkB0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765423466; x=1765509866; bh=g2YkrCdVvB77mVwwKjOogYFj/TKIOtWc3sF
	dyC18PDw=; b=VHPC7GMYzjBQqeHt8MuYCBpZoequ5GSWLjClxEt/W8C0IEBfKGH
	s6lfqBAOGefjoStQvvQe6uKEPidt+5jo+X4cXvjUf07EWc7gw5U2Uffi74pDuJoa
	7d7ekQro0EAG6E7R9EUfpzZV2CpoFYPzgQPtej5HGlvSKjo6S04yIo3uf+4d7FSh
	0lGcL/ac6oMmxUR01/xvn0rftgpSfhjB/D2KU3bdC+waBnNKjAQW1E4FsirZ+Y+H
	evc0vu5oAIzzqTxPQxbUpXO5auD5ESxvrQNzUmMBRMEkRSx2Ukz4MkJxmwUHQvwr
	vX/hgFANlu2jzlEpcMkYyBE1VVr1PT1EkPQ==
X-ME-Sender: <xms:ajk6aUwowmghFHGHeuMv8ktBLxSd8tBoPLRiw0igv5Odh39RePauDg>
    <xme:ajk6aftnwcpuRV7rZKtkRdS_UCBC0_i-n_eH_4hsGC2xR1E8R-MZ5GFUqdCEXdW8d
    w32TRpsm3wkEeBgrDA7jLHzhdun_dZ7kPJqiASQeoOjuokVqCDN>
X-ME-Received: <xmr:ajk6aTvQptE3OgVj6LjRgWrB6LLOue6q4M_mXl4FB4RTkS4VZ_L1pcMSjq1v-IiSG1ZgmSfN9py8WWYtsX2pnQByzGwdhHZnvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkohhuthhsohhufhhlrghkihhsrdhsthgvfhgrnhhosh
    esphhrohhtohhnrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ajk6acMuSix-ksuBmDW6bJ0y25p_nutv2D49GFVoTZp_ZqMPkFQgMQ>
    <xmx:ajk6aZ2WviFZ6cdi-gJt-x3LxQJ9TtVxN-RogjSCPM4pdk0X3ymKDQ>
    <xmx:ajk6aQOwxKIVc_A0Fb0E2MhbIBsila_WZIP__EkXYLCdVPKbrP_Xkg>
    <xmx:ajk6aR2teE4QqM4V3rSV1e4RxaPrAfqTw8OoNZTCHG49clLlUCkgxg>
    <xmx:ajk6aWWe3Z8Had1PgJo_W5C7UAU1QyOmorAlAnZWRYI1LotmJ83j_oNx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 22:24:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with
 no commit history
In-Reply-To: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
	(Koutsouflakis Stefanos's message of "Wed, 10 Dec 2025 15:01:36
	+0000")
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
Date: Thu, 11 Dec 2025 12:24:24 +0900
Message-ID: <xmqqldj9g0pj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me> writes:

> When running "git reset --hard" in a repository where staged
> content has never been committed, the staged files are lost. This
> seems like a case where requiring --force could be helpful.

The thinking has always been "'--hard' means what it says!  HARD
removes things harder than other modes---there is need to add
'--force' to it".

So, I dunno.
