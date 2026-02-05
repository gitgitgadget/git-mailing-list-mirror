Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99673279DB3
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318714; cv=none; b=illsKUKQLkfr4LIxaAXNRWvVJnHiZVHdlI4VNpvsz2EHhH5w9PeNXRn+FLCjWrz+cumxtyGcvfkBv3UdciUWJ/WtYND1cDxQ/9RoBRjQNYu8Bhy5UHb9hN+gdzQ50hWng1w9rEb+f/+BBhQMnB/tXd6N9RmcpyuIxcYAxx66SuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318714; c=relaxed/simple;
	bh=O/9+qh5JT3l/ZmgDgfuwTni7x6tu6EVQnt0TlvXpMJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=osZ74c9lHBDpHubtL1tCDLtvgek7JfwNbzczkRXxKbk/4oEnLynr8Rfzon9UpLxxub/0wyg2b1nbPhSc8CqTg1Qk9lIRNtn44WpbOOKJTllVssebaVWWWT7d7Owo9kFEXG5JluoVh9spM7lYv8kW7aOtEZJdP0EOLYDGuRAFhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iqqR601Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjrqcP41; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iqqR601Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjrqcP41"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C6298EC00DE;
	Thu,  5 Feb 2026 14:11:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 05 Feb 2026 14:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770318713; x=1770405113; bh=115j4pUhiP
	Q8cS2sUKPk/ZC+L44A0ZMy65CAIJk3L/A=; b=iqqR601Z3anFbMzgLSmEIslgwq
	Z6WVKQHt28Y2NfSR5APOj+W10bL3dY9xEV3DzY1WbttbAnju+6isovdxfKOX1SPx
	rEL6Y3npi8LstACtdAY0ctiZAD+vpbecj4JxeK3QJf3J205q2I1JEBN9GZQWWUe4
	WYhHLclIFIyYQXeZU4EL2yQZh5k7S1JbfAXAIGxx9/QAuNRSVTLNbJineAcIGc2C
	eRiAtB1As75PkNL0PEiyCwsVn8unXFYhC32vpvAwybSTZ4DdZlWjhcLu6rdZy4T9
	H6F+HAxiZ/dzxNm9QhMxs0aF/BxRvRp9/iccD2iyN8rVghNBb6Rl0IwNsRcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770318713; x=1770405113; bh=115j4pUhiPQ8cS2sUKPk/ZC+L44A0ZMy65C
	AIJk3L/A=; b=PjrqcP41H0DSI8nxeC1xVvv9AFoGBbnXhBtvZX/XTAxZX0w6n00
	SplbOl5lf4UnuZXozpYQefDjp/X2THW2ENpgKS2b9DKUhBMEMkBXdd3fuedY+1vb
	l4i8qtYCIS4iyrd77cgjyUeUDXv/Ponjw9zHO7LXbKIvVifxVqsanjyR2UqCE3gG
	h0KlK1BdkuNTzjo+3OHCQrt7AFR80EuMU3fcgtT8BmA4VwszCC+Wp51a+rS+6QLC
	T5A742L+B21CeuhZOsSNzVaGGMARR+k/gqFmHHpqI1YnFzg1Z7PkIafLsXdUIoWS
	GCkbck2wwL3ecJrCzB0dfYwEJHXDHV91YPw==
X-ME-Sender: <xms:eeuEaQbOu9QZ-XAcd6rSK-w57y5At4qnvv-SLNZ3FxCl1rayIhmzzA>
    <xme:eeuEaSQDxYt3NYVrgN9RBKXFgleLOAIv6041nfNHFN8qqa9rcJq3YEbgNIPUcWzHJ
    KEzDNZdI00vK85n94xYJOGxtclzcNIJaJx385a9XPLegCvC0Bv4Cw>
X-ME-Received: <xmr:eeuEaTRB90PuBRyfimoWL9h60lBQE-NmeNKLajSYDVMzH1YzYKU3ryTSayF3Fm9Pxyfk-s3exdEXfzhi0hCXNeFd7g54F3o-IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggvvheshihtrghushgthhdruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghnuhgvlhdr
    lhgvrhgthhhnvghrsehquhgrnhhttghordgtohhmpdhrtghpthhtohephigrnhhnihhkrd
    htrghushgthhesqhhurghnthgtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:eeuEaWSlbM7Ws3eUiwQkKXs976BmBEdZafVBpZFgjeu4F_HTifxTzA>
    <xmx:eeuEaY4AIOb32zkNEV1zLnywgFmUd9gD-X7y_HOfuoggPhG6H3U7oA>
    <xmx:eeuEaS0qBGfpdwUgL-dk1g9yht7ZleubPQEh5XEwb9cJEUiLiarilg>
    <xmx:eeuEaTCrX9j8G6_UW2_A4i_7wE7Yt8UN8EXy-Boa6Zc_Jvq9T1cULg>
    <xmx:eeuEabu7mz4o9Qc-jqu6UYYEaQiTB09tcpgXUGBxRCDA0Pp44P6Jm4Rq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 14:11:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org,  Manuel Lerchner <manuel.lerchner@quantco.com>,
  Yannik Tausch <yannik.tausch@quantco.com>
Subject: Re: [DOC] merge-file: document that merge.conflictStyle requires a
 repository
In-Reply-To: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de> (Yannik
	Tausch's message of "Thu, 5 Feb 2026 16:06:04 +0100")
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
Date: Thu, 05 Feb 2026 11:11:51 -0800
Message-ID: <xmqq4invm2dk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yannik Tausch <dev@ytausch.de> writes:

> We noticed that `git merge-file` only respects the `merge.conflictStyle`
> configuration when run inside a repository. Outside a repository, the
> setting is ignored and only the `--diff3`/`--zdiff3` flags work.
>
> Looking at the history, this appears to be intentional since b541248467
> ("merge.conflictstyle: choose between merge and diff3 -m styles", 2008),
> which explicitly gates config reading on being inside a repository.
>
> This behavior surprised me, and I couldn't find it documented anywhere.
> Would a small documentation patch to git-merge-file.txt be welcome,
> noting that the config is only read when inside a repository?

Or even better, teach the command to read (limited set of)
configuration files.

By definition, you cannot read from per-repository configuration
file when working outside a repository, but these days we let our
commands read configuration from system and personal configuration
files, I think.  Back in 2008, it is understandable we couldn't.
