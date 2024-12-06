Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24A20103B
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487973; cv=none; b=rDM38xjfj+o6mu5d4DteV8xhGHmHQI3HApDx/28EK1F99l9uRRjxh+VYfoi0p2QY1HxfPL5Lxh/QbEWC+HAuYG8Hf1gdA4yGPCUJu7VmEZ5+F5GaQ/nb5qbpgliuortikwA4bZu17iNtSYw6g1cOKh0Ef082TwkcalOaq5hGHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487973; c=relaxed/simple;
	bh=e9hHtSwtMAkNonw0KLlNYrt69CB+NEdqOeSTv5k66lI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vE97013pGloRgmVKwSd4YGsK5dmXDAx2TF3xIG2zqW+Q+Fx7O0XF6mPXfENVUxuX5rhiNOnwWNNlTLfXC9VcqdehZTfEbl1KVQy4WKNxtkbZBEk8dX24d8X+ZRbZhi4gKcAGsqBYcg6M3ihu4wuWcbNqs9D2rAvt3APtOUhNdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bwAl8tkY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yUyErCQS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bwAl8tkY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yUyErCQS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89093114012E;
	Fri,  6 Dec 2024 07:26:10 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 07:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733487970;
	 x=1733574370; bh=lUfKx/X9jNuC2Uv8FtUdxhyiE4yJiZ5n1NHKmLaHfU0=; b=
	bwAl8tkYgEk+GpuxiWHxItj20mCyXctkb+oHmcWuac8p+pembc/e3plszwRCf2On
	owl6eUCs4ICSrmCHUYy8/K6w2dd86c/MwKp4SQAruna/Qd3uP9AI1htzeaGcw78l
	gGxzHnxDLQmBHnyfWCsiGELHznD8R0A2YZ8cGNBokAEOCgPe2s6KB0+Fv1DJbR5B
	q4gtoyFVOBeL5UhEylMtre8qD7QA8j3JFuI9f7DCiQh+ODgwaQVe4ukQddkRwKoL
	zNcPfQrK5D2b2EJgi0UGbB3CJoiZ+XGqS35Azn7eLgUe44WNNCLgS5b49cXprV58
	fAcsd0f4/lJ3oFo5eEYrsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733487970; x=
	1733574370; bh=lUfKx/X9jNuC2Uv8FtUdxhyiE4yJiZ5n1NHKmLaHfU0=; b=y
	UyErCQSpl2zfu87bH6rS5KFE3/EvDTHhPg4Q2ioyC7aejtRa9xuPv6haVHkOO91W
	9eOMvs2k4QaGUnkSPNFWjjXmWwiTi4QHRegcS4qyqDQgeHYFevEyMfgW+TV//m+x
	Qio1019gAjX6TWH6XQz8uMzoVvJo3znAcfZvIornyxb/SaJm0FqQoyT09JwivaTg
	hnLjXFdRHbg/5pVB7w1JHP8nh339osGdE0skIax7Ejlgh6fZiB5T4IP/59wGaIig
	Uxk9ACUmK2m/PJGiM/09CixX363JfYJr79KxA94mGV0mYfSrcVbPE8QPcJUkPJ9f
	vJeDGrLi26BFDOtgF6U5w==
X-ME-Sender: <xms:Yu1SZ9rdwalAutERiFFOeNE9kvHQHGnnbxPLj3uwdVlRfowF651Pn6E>
    <xme:Yu1SZ_pty03aVjkF2yNZQtq3OHTSlJMlIsfnF1iAaYWvdhQKzfSTioZrE9-5PMwqy
    O1OpwPSxkSmKafhCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigfefke
    dugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegrrghrnhhisehvrghlohhhrghi
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Yu1SZ6PHRAoTOBcmBPEuzZhxOof4ZdijbEyGE_wfHsFZSoSFN8M5eg>
    <xmx:Yu1SZ47ezNO_sH4kw5KJrP987jL0L7adnH8wpUWcWgfQAJ0jbW3TcQ>
    <xmx:Yu1SZ84aWsnVoHVNplWnyRLYG-h6T6yR3BkDEM3Y30VjztYYQTX3ZQ>
    <xmx:Yu1SZwgaQYr8dfrlfgRJ09nUJvGZ5LnXruGCudXcQjB4JNLHghNgOQ>
    <xmx:Yu1SZ30VCQXQM78Lwoj_5ZxjO5YM2ed6kw5sO0TKCzO--ffvWFzEwlR5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3AE1E780068; Fri,  6 Dec 2024 07:26:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 13:25:49 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org,
 "Aarni Koskela" <aarni@valohai.com>, "Jeff King" <peff@peff.net>
Message-Id: <cfc7adaa-ccf3-4f27-807c-2eed70e56aa8@app.fastmail.com>
In-Reply-To: <xmqqcyi5vxbj.fsf@gitster.g>
References: 
 <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
 <9c7b9090-8cf2-4095-8e86-2c85b6fe407f@app.fastmail.com>
 <xmqqcyi5vxbj.fsf@gitster.g>
Subject: Re: [PATCH] object-name: fix reversed ordering with magic pathspecs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024, at 12:57, Junio C Hamano wrote:
> [snip]
>     Recently it was reported [*1*] that "look for the youngest
>     reachable commit with log message that match the given pattern"
>     syntax (e.g. :/myMessagePattern, or HEAD^{/myMessagePattern})

But these are slightly different since `:/` searches in all refs.
They are only equivalent (i.e. with Patrick=E2=80=99s fix) when you have
just made a commit (like in Patrick=E2=80=99s test).

And the longer syntax doesn=E2=80=99t seem to be affected by any regress=
ions.
In this repo:

    $ # wrong
    $ git log --format=3Dreference -1 :/Merge
    3857284f7b8 (Merge refs/heads/master from ., 2005-08-24)
    $ # correct (looks correct)
    $ git log --format=3Dreference -1 HEAD^{/Merge}
    4a611ee7ebd (Merge branch 'kn/ref-transaction-hook-with-reflog', 202=
4-11-27)

>     started to show older commit.
