Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113691FDE26
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780197; cv=none; b=MOY5nx+R4k7citAUhxw8YO49xjxiPIGWOXtYpyVi8r9LjtxfleZAE5mPMODXruTvI5QwgjWyPUie6gc7QUGMY6ZuLCW4UOGY7UyOOVWRDQ4JKtVoCo5qF0lyrJsA8p9neF0M1vLK2qgRf246iVVjywRXOB3ofZUPXGGf2G04Hzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780197; c=relaxed/simple;
	bh=EEfiaM96IQ6BZ/UQ5NwI9ZYM4/oHTzA6qyx+Xs2Agt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMTC5i9GQZl5yCPGz32Ln03QHbks/hdtqOnmZ14SpBRciI8ajsnkjjXYnJQ/2hyxHpcSOeeTQTw+uYgjw83LjZENI93b9/lNYJC0fG9GIsrDJKQ9qVlqqtJ4817aTA7UCC73EB1k7TjXEcesrTvtT9p4gcM1FDGZ+vmNzPL7Geo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GKv4zT4Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFo97/DL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GKv4zT4Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFo97/DL"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 108B813801A7;
	Wed,  5 Feb 2025 13:29:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 05 Feb 2025 13:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738780195; x=1738866595; bh=EEfiaM96IQ
	6BZ/UQ5NwI9ZYM4/oHTzA6qyx+Xs2Agt0=; b=GKv4zT4QOA7K6shMrKF5rjxVOO
	YCRb1qN/vHzPjkrlhT2Mw7L2yLfkD/UWOfY/b2peRmZUkQUB6JsBdpUolhb1UuNl
	jJ9FEwtde/ds7aWYQyGo2ju1xALzk3bELwL51bn2fNl/c1/ywTMmKO9YMjR5z+4+
	f/9a16M593N0vszrcdsA1aal8tK+vGNLST9LcoQ97YeRUYEsLwb+EOEoF2Y1Wb+K
	urERWVOxREvYyC1rkKIxltiKqs56m/SCCOdEwkECZ2Z2Dh2iiRLz5jlxc1txo6YY
	nBMmcd0h4XlWjnV/98v9ZVv0rnAMH2rkT3Eooo66uOyJuYy5xXLzRDAo5L7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738780195; x=1738866595; bh=EEfiaM96IQ6BZ/UQ5NwI9ZYM4/oHTzA6qyx
	+Xs2Agt0=; b=MFo97/DLWCJ642aETTlCr15mmB4NEJnURWK9v12zISJnBmyqbis
	m01SJxCkK0WUvvhrKZQchcZpt39yKbkt0ZcJI8odQBekbOzZlLcELlRq4bUZvfe4
	ZgvwVvkK+njIECWCb/4fMdvtVpJkBGbNCZ/RyXl/ZnzWkSyOFpeKbu0xBaRRSb5W
	riU4/qLWlYTC4yID5NsF5LCyFS5+YflQThiV/re4E8vR1hboDGzZ/lmfboUU6qPg
	HQQMgqeWrB8DYI4S+a4CIdHDiOcWDe96PibN/dqv07NhTz2XqUP4emL0tEDmmR7w
	AdNbeBvbyodLNBqnCi7qWevv+e7wk1jWKhw==
X-ME-Sender: <xms:Iq6jZwx29DRcnFZNp4IFyPBQoszSAR3bOyBBbGcbzXc2bspXOV5tBQ>
    <xme:Iq6jZ0QnK7ER33rP-04bDViLAHgU0mZ85sRGAdMPilcupSnQ6fO7pCP4wqua9DLep
    fTDpIV4NCxtA7apsw>
X-ME-Received: <xmr:Iq6jZyUot1ZMHRC_pMuhbfTK9-3-FXCAPfX3WEtbp-MRhx1r-N_MvQpNvOfWLsoosix4qaeMN64h-s2aIeQy5wya5gIH4BhvFO_t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Iq6jZ-jBDNdmDRFei_EvSNW-WO05QbX3pAB73WqB8PzBsd4gHhrBew>
    <xmx:Iq6jZyDEyDQnByRA5k0ZSpItjtm_07KZygZVXzt8SkaxOVQy6OUc7g>
    <xmx:Iq6jZ_LdFuhEKkLZMTti-jStK-dqMXFbfItdyo_VHWNAsWI_Fnl4cw>
    <xmx:Iq6jZ5B92UZp9Y2eZIK8Hf-gTbbcUWJC4LoGGFjH9wgKqzVXtKCUGg>
    <xmx:I66jZ54OVatKpZuwpytKQ-eDdZJAAP9MZpnWpUeNBR733d7ar7lb-rCd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 13:29:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v4 0/2] rev-list: print additional missing object
 information
In-Reply-To: <4peozlz56kmdhziyq6uhsvm4t7atmwtbl7divyuqqb4l64wgom@z3adjdx7v5x2>
	(Justin Tobler's message of "Wed, 5 Feb 2025 11:17:32 -0600")
References: <20250201201658.11562-1-jltobler@gmail.com>
	<20250205004147.887106-1-jltobler@gmail.com>
	<xmqq5xlor0la.fsf@gitster.g>
	<4peozlz56kmdhziyq6uhsvm4t7atmwtbl7divyuqqb4l64wgom@z3adjdx7v5x2>
Date: Wed, 05 Feb 2025 10:29:53 -0800
Message-ID: <xmqqpljwnt26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> wouldn't be sufficient to determine where each record would end. Using
> two NUL bytes next to each other to mark the end of a record would work
> though.

I think we already use that convention elsewhere, and that is why I
brought it up as a potential approach to take.

