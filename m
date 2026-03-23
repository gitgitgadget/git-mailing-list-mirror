Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C931A575
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774292052; cv=none; b=LpIlEf9nIGu7kUpfHFPztWnUT0miHmhvkXXb8/GRQsF9rn75mog7JdaE4cEkk8MVcCNKH3nVU5vHm8EuZRVmrqO0FeO05cXG0I+R3HEfFXQ5r+Sa5ZWaIlituYPGxcBgoa6UFXRIeAGOiY270ccAz5o3c7WEpINJEiLPiNEsgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774292052; c=relaxed/simple;
	bh=Hn+M3KI0JD+E33CjJKGt08F2I2kofRisTgznyInNyKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TMw2xbVhJYgtWROONK8JAXfPjDedhQyhMTGMX9In0yjnC7/iD4KoGX7V/FMg5RAlE2Oxwy9RJSSZQ+iEzMngz1pcJF48gmeQaMabUDv/4w29un/06N5qOAj1Bz2VqzSSYR18fK9NyER/kYkPwlmi8MRJVX/4Iq5w93HTWn3utVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IDqmLcBn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHDHrjtO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IDqmLcBn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHDHrjtO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 648D3EC01E2;
	Mon, 23 Mar 2026 14:54:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 23 Mar 2026 14:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774292050; x=1774378450; bh=nrr/XTf665
	W+ohZQBgMo70hHGWngz9V6u1zU0ICQF/k=; b=IDqmLcBngd62phHNVKrQjGi1z9
	KJ4VKZpFkkuKqazFzRrbWbFmi0RReTHExIiyfZdZH1OXR/xA5iMuOucq2Iv0hU1O
	g97DBtqFjUOACtdAbpE3LTLMiOR2ZASLtSU7dr3Dg+Lg93u8bkQP3p+W6ZtWlgnD
	Y20vNllAnLiUgjHniTi8V4vRXGgvni3L/W7O/qxYqJ0mizsGKl16fhRSH+aJspUi
	4WdGvdUR6IrqafDh+cRxtqOM4cHSWzCxvgT5/tiZUzZpYQE2kZfnmVmF88PTdTli
	GuwOLBaas8I0yCNGIo7/ojpT2sL6tH5sYJeznFBayZNMjl3lxABBw62Q56fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774292050; x=1774378450; bh=nrr/XTf665W+ohZQBgMo70hHGWngz9V6u1z
	U0ICQF/k=; b=YHDHrjtOpenLvMm+jXaAUbs8Zh7VsCmI/ot3ze1mLkCP9wRkyHT
	9kAnuZcqliorhPmfobnQh3N2CaiWknFoavnixGGkNSvC2JO8SNPEfe9lERkNcSBH
	7IiB/7V7z9PKKDcFpFOM4SU9+1NnhiNpP47iiCRwXTZ89V05tmd1qk6Dfk6EYni9
	b/xzRU1ZutcF2er1laZRzlMfVBRUfMbTgAtvOwLI2/F1XXP9u8I/DLNGlXgJEuDy
	OjY0i426JlLd+36fPcFpXrh2hAKRUYnuR15rskmCaL65STERdmiCREm3Ik6DTlKN
	ej325QG7JFWI7tslmq5lhEZ1Lc8OmhibaBA==
X-ME-Sender: <xms:UYzBaU7NouLRRI6ArIPOhcJka4e8zW6FaNSIuoF98ckik7v9k3728A>
    <xme:UYzBaU95FjqLN7opEozymjET-4XRdft1hzZK5KraiFy_P64KRdclcdBsFRXXwbA9r
    _QZIjR3DGD4wm9KbY4PywPGPPKzgcIhJ5vXlah4J4-UDKAZDtcX>
X-ME-Received: <xmr:UYzBaZpe79YhYB9HBkmOU7qEBH7RjnJVY1ovWwbAaOLcklV081MSJR0QsosoQc2qyaLpto8nvVPUr9Ahrob7OND89LJjQvpdJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfeiledvteekudehtdejteefhedvleduhffgffetuedvkeefvdevtdejffei
    vefgnecuffhomhgrihhnpehorhhsshhhrdhishdpvgigrghmphhlvgdrtghomhdpvghvih
    hlqdhhrggtkhgvrhdrnhgvthdphhgrtghkvghrrdhnvghtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtg
    homhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    tghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UYzBaVrBysmjOTVKOiXfG5dxt0DalOzung1Ew2QafrT6naoazkEM1w>
    <xmx:UYzBac29QYisWPDvT9imSwFb8cP9vl3Y5pArsqtxWgH7FSzkqewAPQ>
    <xmx:UYzBaTH8N7QVzBiQcfJKAInupZSvahoAJ2ejsJAW13MFKROTXvrFoA>
    <xmx:UYzBaXG3WYaBWQq9QgztAQEffSJ8JwNfNJwV4MtFR6zKbzw7pHYl-g>
    <xmx:UozBacKQYuzOEGbceYc3nEUhEZtKP2m5XWvoQlFhHPYwpVXO4BhpfnxX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 14:54:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 14/16] promisor-remote: trust known remotes matching
 acceptFromServerUrl
In-Reply-To: <20260323080520.887550-15-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 23 Mar 2026 09:05:17 +0100")
References: <20260323080520.887550-1-christian.couder@gmail.com>
	<20260323080520.887550-15-christian.couder@gmail.com>
Date: Mon, 23 Mar 2026 11:54:07 -0700
Message-ID: <xmqqzf3y4bsg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index b0fa43b839..6f5442cd65 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -51,6 +51,52 @@ promisor.acceptFromServer::
>  	to "fetch" and "clone" requests from the client. Name and URL
>  	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
>  
> +promisor.acceptFromServerUrl::
> +	A glob pattern to specify which URLs advertised by a server
> +	are considered trusted by the client. This option acts as an
> +	additive security whitelist that works in conjunction with
> +	`promisor.acceptFromServer`.

Between the first sentence and the second one, I think there needs
to be an explanation on what "trusted" means in this context.  Is it
trusted so that the URL can feed random configuration variable=value
pairs for the client to blindly apply?  Or is it trusted to do very
limited things that other remotes can do, and if so what are these
limited things?  Without knowing that, the end-users cannot assess
the security implications of setting this option.

I am guessing that the client would behave as if the existing
promisor.acceptFromServer configuration variable were set to "all"
when talking with a remote whose URL matches one of the patterns
listed?

By the way, some people may suggest "white" -> "allow".


> +1. Start with a secure protocol scheme, like `https://` or `ssh://`.

Is there a practical reason why people would want to use schemes
other than the above two?  This sounds like something a small amount
of code can easily enforce.

> +2. Only allow domain names or paths where you control and trust _ALL_
> +   the content.

Obviously.

> +3. Don't use globs (`*`) in the domain name. For example
> +   `https://cdn.example.com/*` is much safer than
> +   `https://*.example.com/*`, because the latter matches
> +   `https://evil-hacker.net/fake.example.com/repo`.

Is there a practical use case where allowing '*' to match anything
that contains a slash '/' is useful?

> +4. Make sure to have a `/` at the end of the domain name (or the end
> +   of specific directories). For example `https://cdn.example.com/*`
> +   is much safer than `https://cdn.example.com*`, because the latter
> +   matches `https://cdn.example.com.hacker.net/repo`.

Ditto.  The above two points sound like excuses to keep sloppy
asterisk matching logic.  Yes, retroactively tightening rules always
have risk to break existing deployments, but if existing code paths
of urlmatch do not have any good reason to allow '*' to match a
string that contains a slash '/', perhaps there is no fallout.

