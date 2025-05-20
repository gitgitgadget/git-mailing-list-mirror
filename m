Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E440219A71
	for <git@vger.kernel.org>; Tue, 20 May 2025 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747778578; cv=none; b=KbrHOSgyIhiywrTmhDEPHUbDgAayGhr+Sasarq1RPg7XL6VkBUh9l9YxdnaszVtJFr3Z5MBfxOdhX4zNbP2lE7PniHiBV+HTJj7nQjP+Q9LPq741ojXzHoTQ9Cjx5TL0Ja4A/39M6c+0N5iL0EA2HO7ayWxwg2LILT4JvjCbJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747778578; c=relaxed/simple;
	bh=FJ1qnP1hXEvjTRS6D6Km3WMqTIODTpSRkp9sH90hrIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oEIpFuCKQIX64ju69+srN7jhQ2KwJe2sd8zCZN3gAIxO8glJdT/BlGHlQQn+YlB1KEJYIWDvQqjJ1HxWs+9HMvK9CQVFoUlFbyaMGxoMz7r1smgnvyK49/6Mz9GUDL+puvRGOmG57WLpyUJJKkDPwhewxmnDnVjteJPajq/wBss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N4oThCK/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g+TqqtnL; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N4oThCK/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g+TqqtnL"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 13E5011400E3;
	Tue, 20 May 2025 18:02:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 20 May 2025 18:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747778574; x=1747864974; bh=d+4oR6i1dq
	SHbSwegI77yAYYQJDC6cJpXlluUFAzyeA=; b=N4oThCK/Aia1dZC6yRohqwTyzO
	2+zCdWC59CRCmkIQIOa6RbItytE8oic6wtrTGDuvglmA53L9DK9WKzuAnd5MMrvk
	ogfSdJHjyCBol7OORSVnZ8J0YcggDk4aPmLth/F7Lk45qAz9wnPMy25AmIi9nSi9
	qj60tAk0Z7/96bTy7Z++DHaIhzhvj8UH686LRrR8/UY+EzT86kBWz0naL5CNj388
	oPUmEa50JgoWiYJ/Xt/mioAiEO+OATdGgIEbK4ZBcR8xIZ/qFfHEgaUd8Kb9VK2D
	wLP8vxWcD/1vuF3b/Q/NfjtL8MIL/4RMuD3mxCURhHWyUItaTXCMOY/x7uTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747778574; x=1747864974; bh=d+4oR6i1dqSHbSwegI77yAYYQJDC6cJpXll
	uUFAzyeA=; b=g+TqqtnLnqFhPv8IUeBGIWUGHJqxFcUq65SaMUWSEoYKPBbXG3b
	XRpT42yezBY7tf2rVWffC93Ypa+JOeCzWHynebr/6UuhXuy1SMjRgvmSb5LFqMYX
	ya/O+5mTFteI0SMczpGvjyJUfpsLwLJe0mLte76AAhyrwojYDLr6V6P7EAV7HPSW
	0O6+EXBxADiJBil5acrHQstxOmg41xG7H9Jxtus4W6/XRAR2UxGI8lomzGiiPzu1
	kMqpZgQP6MSiInzl2F+NpSXAiaIKfWCyf4yb9UciaLn4di57CzyK9r49dTsbnuUs
	NHswS/4c+Yp+XidrEIXaJ9TosB3Iu4z57Ig==
X-ME-Sender: <xms:DvwsaAu0DOCg7jVDEghWESgfy2LV7HtuzDBGN3aQdq3HMkhDoNREGA>
    <xme:DvwsaNemRJtLLkD2y-3IkbvD2OHUCZmwyciDwYJN7M6ydhX29dm9QXikZQffClIUx
    Wg5f8cNaBcIx3EK1g>
X-ME-Received: <xmr:DvwsaLyLtAFL4GlKgfE23f6-zTMimkNcXfs6M5OXzDNrXd-hC9a4xELRCW0blnyoq3O7i_teiPZOgANOQau24BUSEhG9I6MYNdBW6I8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddufeeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfet
    vdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrthhtthgsvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopeiirghihhgrnhesuh
    hnrhgvrghlrghsihgrrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DvwsaDPTnQ2JAUef1-UdDyzXkU-3bcj3ZqZv42E-knklry2JeE9fkA>
    <xmx:DvwsaA-DOsE2g49t9PupZpaXyyrLH2xdxhZzt1SJfUxnnJFlFZbB8A>
    <xmx:DvwsaLXjYyxuufGtXRnrbO4074rrzGsPS5tSjR_U6PKWacToqf9phg>
    <xmx:DvwsaJcjlvh5PeWGjq8A-hDVeHjC4ob3mF9TUVrO6ZpHqzcxQ6q_uQ>
    <xmx:DvwsaDWZhzwzoJDXKXmafOc7gDdcCGFDLHlGc76FWdVZGKe4V1ynPMTQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 18:02:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Muhammad Nuzaihan
 <zaihan@unrealasia.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: Small patch to add support for MPTCP on Linux
In-Reply-To: <202e1a66-72af-48f6-9b3b-7d7473db699e@kernel.org> (Matthieu
	Baerts's message of "Tue, 20 May 2025 22:34:56 +0200")
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
	<aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
	<BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
	<aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
	<4YPEWS.J5JRNETKLXF1@unrealasia.net>
	<a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com>
	<xmqqo6vokvpv.fsf@gitster.g>
	<7b3b8efa-4cc1-4547-b66a-c469626eac46@kernel.org>
	<xmqqfrgzjnhg.fsf@gitster.g>
	<202e1a66-72af-48f6-9b3b-7d7473db699e@kernel.org>
Date: Tue, 20 May 2025 15:02:52 -0700
Message-ID: <xmqqfrgzgctv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthieu Baerts <matttbe@kernel.org> writes:

> Sorry, I was not clear. I meant "introducing MPTCP in the Linux kernel
> couldn't impact other protocols in terms of memory allocated per socket
> buffer or performances by adding extra checks a bit everywhere for example".

Ah, OK.  What you meant is that the networking maintainers did not
allow you to affect the "normal" codepath when adding MPTCP support
to their subsystem.

Which is conservative and probably a good thing, I guess.

But that choice means each and every application need to opt-in,
which is cumbersome, inconvenient, and hampers adoption X-<.

> listening socket supporting MPTCP on the server side will return a
> "plain" TCP socket to the userspace during the accept() call. That's why
> we recommend enabling MPTCP on the server side by default if supported:
> the impact is minimal, and MPTCP is only used when requested by the
> clients -- which are usually the ones benefiting more from MPTCP
> features. That's in fact the current behaviour for apps written in Go:
> MPTCP is now enabled by default on the server side, and it is easy to
> enable it on the client side when needed.

That reminds me about one thing I forgot to ask.

The git:// protocol is the only one we have control over what to ask
to the socket() system call and the posted patch was about the
client side [*].

On the other end of the connection, even though you could use the
dedicatd "git daemon" process sitting and listening on a socket, my
understanding is it is more common to spawn it via inetd(8).  Does
it mean that the host needs to run inetd with MPTCP enabled?  I do
not know how common that is.

Thanks.

[Footnote]

* On the public Internet, hopefully nobody is using that protocol
  anymore, and instead using either https:// or ssh:// that gives
  better integrity assurances.
