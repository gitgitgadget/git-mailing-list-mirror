Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9FB2C11E7
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313145; cv=none; b=r41/S1n9mPVifw9Eo+YjFQvirig13TqbCPJW2rzm8/rxjdW/AHaVkAXCue/VxWZTEgFHx91H/cggROCkmS649kQcs5vekWCo1J0HvzJJbzHwn9a/gSodt89ER/Og7P8GE3SSqXw7PoBmTuC/W2y30Bsfz4jkfVg6f3kxwzJ2n5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313145; c=relaxed/simple;
	bh=aZ9aOR9iUjl1OUoOvpW8ruumOhLBn3o6rAHwOSAju60=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UkvqIMt22+xBRGfwICxY3z7kFrvqXtXQTK35vxTXV+93I1AXJFNKTJSel9HPEp0zER+30lNA9TNhOXqgPTZtCpcUI68xiN2ktwGKZD4itSbpVnCRyXiYtDA533NgwQAclpYRjDQX4RJmenEkstAWSlvIwl86IHr3utccLZlJu98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cQY3Z+0A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MDuNrDno; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cQY3Z+0A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MDuNrDno"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BC631EC00EB;
	Thu,  5 Feb 2026 12:39:04 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 12:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770313144;
	 x=1770399544; bh=RdjPjiWK9xc7Tu0gNgGooz81bFxYqKiM5+vM/RoHjao=; b=
	cQY3Z+0AyLXsvPS4PwxOkC5pQ0y8ojIXiuxibPeuYTZ4NQWnJW/ximWzA65NuVYj
	oUOSg2JXCwDJteprWGb+1I1zMqfQFtVXw/WJWxyJE+lQwktBuTHd9M/weYiL9gqc
	YwhOGxjd0O7hWqCGWy4diN1Tyw/yIGSoL1At7DkjILxRgtgWcBfx8iZwz6CwlTcD
	2ZNZL19TP1XiKICO2028KqiGuq3Bpb/71+SPkUIe7yvhXF+OJdpee7bklG8hHu1A
	rAWmzZWAS3sCJ5eMccCDzpEAKONoPOjH+39SynijRwu+G9q1zVGQb478/n4jGe9f
	MkNy9HI+BlDCHYz5cb1Fqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770313144; x=
	1770399544; bh=RdjPjiWK9xc7Tu0gNgGooz81bFxYqKiM5+vM/RoHjao=; b=M
	DuNrDnoHHD08RAcuIvPS7Ga+1ijJgPEm8Nmb+3V5ANkC4OqidylSPpzrX3dWJYcU
	uOrmjhz3fe8J3UWRc2DcYKUYjhlCXmfGz2sUZ+5+o0/RaLDjK3hsmjUveSE7ZrDL
	+seqcdKR9MXBcm0Pn0enw2qPXTvwdHlj9oKC3G6uH8HVC9z85VrI/RUm4s5zfC+D
	xoCEhjZ5zoi02dqwhUy2N5MF3WsE0kvxQ6/EeujHYVOtZ4T33s4ijMMGq+9qw82y
	JQ/JnFnw0PwzIIgy/YDhOaR0B+fzbxx0d9tkz0qebuEsLbxINUGfDlVRIXqxET+k
	qv2m8ApJmKCZ3HjyNaUpA==
X-ME-Sender: <xms:uNWEaaWpNYFd4BeKnimu6CazhTUB6Rk0yvo4aGGiXQNwFNSsesb4E7E>
    <xme:uNWEaRZN7o8yQJG9g65S3jFQlWsV8GaXAkS8QdojqXuN2S4PT2DYgFA7NAQTRcQ-M
    xgaOrEuoUOmwQykeK5a_HuaiQccuOBZkrKifniu2jf67N-27TW6fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uNWEaX-trvXG0FifH9M3Q4euGP8E3pAnv7TQ1iQKBjjojwE-5UgRaQ>
    <xmx:uNWEaRgHdHclNWGPlTANo_FT6jofGEBeempxAldY4QzF8CPD6YdOtw>
    <xmx:uNWEaffKJyIe5L6-2f7W-av98ztRLLu1sgiz4gmiVVjGIHCFQTNpvA>
    <xmx:uNWEaQqjlecfNeaPQDAP6TgM1k5NL2OflTS6zGylSTqoamzdAW-FrQ>
    <xmx:uNWEaYyDvG6KFIjUCfQ2wAYjFWCtIhNapdN814Kyg55mwedKfXou-TMu>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 978931EA0070; Thu,  5 Feb 2026 12:39:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoWA6l5H5oi3
Date: Thu, 05 Feb 2026 18:38:44 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <1702a6b0-78a0-49e8-b3e0-a112c251c9ed@app.fastmail.com>
In-Reply-To: 
 <014e959cf4a4e19afe6becdb155f49d0f96739f8.1770214803.git.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <014e959cf4a4e19afe6becdb155f49d0f96739f8.1770214803.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 06/11] docs: add design doc for config-batch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 4, 2026, at 15:19, Derrick Stolee via GitGitGadget wrote:
>[snip]
> +Current commands
> +----------------
> +
> +See the documentation in linkgit::config-batch[1] for the latest set of

s/linkgit::config-batch[1]/linkgit:git-config-batch[1]/

> +available commands and their protocols.
> +
> +Future commands
> +---------------
> +
> +The following modes of `git config` are not currently available as
> commands
> +in `git config-batch`, but are planned for future integration:
> +
> +`git config list [--<scope>]`::
> +	Getting all values, regardless of config key, would require a
> +	multi-valued output similar to the `help` command. This tool will
> +	likely assume advanced options such as `--show-origin`.

What does it mean to assume options?

> +
> +`git config set [--<scope>] <key> <value>`::
> +	It will be desirable to set a config key at a given scope as a
> +	single value, replacing the current value at that scope, if it
> +	exists and is a single value. A `set` command could satisfy this
> +	purpose.
> +
> +`git config set --all [<value-pattern>|--fixed-value=<fixedvalue>]
> <key> <value>`::
> +	When replacing multiple values, it may be necessary to have a
> different
> +	output describing the places those values were set, so it may need to
> +	be implemented via a `set-all` command to differentiate from a `set`
> +	command.
> +
> +`git config unset <key>`::
> +
> +`git config unset --all [<value-pattern>|--fixed-value=<fixedvalue>]
> <key>`::
> +
> +`git config get --all --rexexp <key-pattern> [<value-options>]`::
> +
> +`--replace-all` option::
> +
> +`--type=<type>` option::
> --
> gitgitgadget
