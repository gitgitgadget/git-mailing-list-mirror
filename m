Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019912BEC45
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580987; cv=none; b=BVw8WXjyL54mDSoeseHAZtVOB+jOlwvUrhVaUIvefDQfbk01JTqqo9KXQpXesnSsKnVi1X7EYe4ef3+BANwDQc0qQA1DdDdKzqBFDUOeOhRcj5t+E5u7Or8OiiM6HIHnuFTxyaPYfXLEhzYzeBznsQcq24cnAPBcjrf1j8resS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580987; c=relaxed/simple;
	bh=Y4PoiwYUZSHhbGIVkWUrheLlJ/G8aG9HqIHabDwuJHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eeNgLs5aqLMuEOaH/D1o9EWmo3AfjRAaoljxfI8aOcVGG3pvlkI/9Vcpx/VRLZ1y+k0yDM59Ki8H2p0CHI519fqkO6z/u/rtZq8cJ3t00FUzzyHhCpXfFHGMpq2SqtgFwu5JwDS/2OxJjoNMmPAgVOQg+LUagXotnlUJSmpIbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ycW2zZ9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2izk2Nu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ycW2zZ9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2izk2Nu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0280C1400217;
	Tue,  7 Apr 2026 12:56:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 12:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775580984; x=1775667384; bh=Y4PoiwYUZS
	HhbGIVkWUrheLlJ/G8aG9HqIHabDwuJHQ=; b=ycW2zZ9NcwvEghLUr04/vX+bwX
	gxucfe2YcjeTru2JuJ3LsO12z9Xjp/SchtlhPxqa39IkDuabnI8jhlaDUIbrNGqX
	kMXa9ccuTX8zYD2LeGd03NKTioIILZMqu1NJcqhVLWKcrQQ8k4N9Nvx1RYw/26+q
	GVbopyWJPIbgjHgOpGUqgqivI6XayBK1lw9xrJkYCFUcmqrAv7BINjR55LS+WtK7
	gW+xIzIa8yrJO7qrnA6xZJpWRgCfOed9KenNmTQ75HgsRyOikyPdfdZItjtrGyE6
	jOhWeATAmNilTxkJZZiCJh8n8sCNRZFDmZAd7B6TmhwUfoQtvuCXd8WjrUtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775580984; x=1775667384; bh=Y4PoiwYUZSHhbGIVkWUrheLlJ/G8aG9HqIH
	abDwuJHQ=; b=R2izk2NuOmaF28xF1rkdbp2ASLX3TI+vOAR/9xxDmRN8baSbLbE
	T79s88ErH3MkLMfX/WbCUiKOp4HU984q4cYI+XnfaqwTWNXRGEFqBSm32UTS5X3u
	svvikgM0/AS5yZURvHMKdFG/5mZaUyua8HeOueUv59D4Lfn+YRbN99U3FlYCNby9
	49Zn9OIdWAmBCVUcAe1kkiEj9dNXM7tS6EwMVhcIWKmdrK273Cu2GlWGOOHPkEjJ
	i4wBtkdsxQak4mR8XERt0sgRgG08/m8Teg6fSN1vmSyw8JviRDLEtHWu4jYTgmV9
	SCdHODhTc+NGtzPEbqHdjdWRYE9hnD1kMsg==
X-ME-Sender: <xms:ODfVadvK8UUPFsqTbV_bfhC6KB8kz5Qw3Q0rnFzb7y-uoAO1hhzuIQ>
    <xme:ODfVaVgcgX7Zok-W6XfvAH1QjOAZHFVKqtQeSqa_134vthF97icPmmul_2p77RoDz
    E_zFgjmLUi9Nyz8SKNaUcUnEAK36jlRHTITwrUPEMtqXWm7nzpjww>
X-ME-Received: <xmr:ODfVaW_fHOFlOmWnDh-L3nGuabp9Wvzsx0w7nCCFCYSKnVSVLURiruLg9hU6tXqdZ3bo6FMTwk2gBFPgrQvCg70AJE6APL0qig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvuddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:ODfVaQv6RXvVX5ZQDHuxFT-PL71SqBd2vK3pa4bsYO_OR_mV2KqmBg>
    <xmx:ODfVaSrn04_9EnW_5wFC-iuczYUmVeSJVpWtdm2OziKWTDBdBq5SWA>
    <xmx:ODfVacomWQbhT7LB8PdHGhnxpcI6lIu1nFi8bzKtBgP5ydD4oLEDxg>
    <xmx:ODfVaZZQyj3b_JN_kQxHAWlRxDNPSCr7nUMTDFVztEFDslWdDk-Vqw>
    <xmx:ODfVaUsXJSVFP_P19OyR_kW9je-W3pNrnJIOWHQLP8WH1v_BKm9fd_He>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 12:56:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 02/10] promisor-remote: pass config entry to
 all_fields_match() directly
In-Reply-To: <20260407115243.358642-3-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 7 Apr 2026 13:52:35 +0200")
References: <20260402070613.85934-1-christian.couder@gmail.com>
	<20260407115243.358642-1-christian.couder@gmail.com>
	<20260407115243.358642-3-christian.couder@gmail.com>
Date: Tue, 07 Apr 2026 09:56:22 -0700
Message-ID: <xmqqh5pm6761.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> This removes the hidden dependency on `advertised->name` inside
> all_fields_match(), which would be wrong if in the future
> auto-configured remotes are implemented, as the local config name may
> differ from the server's advertised name.

Interesting.

The caller, should_accept_remote(), still uses remote_name variable
that is an alias to advertised->name to find the config_entry to
pass down the callchain, so this step does not change the fact that
we are still using their name and not overriding it with our local
name, but hopefully we will see such a change on the caller's side
to allow us do so.

> While at it, let's also add a comment before all_fields_match() and
> match_field_against_config() to help understand how things work and
> help avoid similar issues.

Very well done.

