Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFB17A5A4
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156286; cv=none; b=Jjhkh6M7TuLhodLN0T1dsSGU+f+OgyWCrL+rWqTFw1yLSlHZddzQoCiFIAKbfF8BCWyOFh7lNyCeKkmDC10Oyq9SbJteLIRFiokpKtJbcwiq1wzdEsEgm2tibo13Gl4kgOagdYQzyKA4wZ3titPNeIi/ONBqBpYM6kME2SaEE64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156286; c=relaxed/simple;
	bh=5QfZisG5AieXYtuqqMwXRrl+XW7W4G6qON3q7rRcYlo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tajmzNskpf0scbXEHJ52V+zVOWSBsq7Bz1XZuPhiCbyl0twuIKT2EzeTTQ9uZAkTDZQAbBIY/GRIZZp9Z+VZG9FlhhiieA8xAo9avBs8pw0vQBPDSV133dO01pURVkpV5PIA/4P1TPSsRWtSJy721rMuH5OFgYwiZ1ag7rIJHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MpURvC7X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N6yw6q0K; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MpURvC7X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N6yw6q0K"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C8CAE114009E;
	Mon,  2 Dec 2024 11:18:02 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 02 Dec 2024 11:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733156282;
	 x=1733242682; bh=iLr0s7SWF9kCJfGM6XnM1NsAyjuHPxUtXwH/s+y0MrQ=; b=
	MpURvC7XCj6DlBHRaMasIVZfTVghFHpWcFzlkNrLcu8tnQsQ2qHUTwvyjhC/5+BV
	jlN1U3vypRWFdkeGJ8XcnL1rWGlvQDYJ9vX63V2SC45rjsKfjpwbopp4MHLjDvP8
	Ra4TpG8tB4MByWQhGxeaK3RT4QslDigyAFIHyaQ9ZGyEPcJgXuZPo6ZZWS6cECsZ
	xGwsgB2yqQlU8xtgH6bQ/E2OWWeub/Jn94395XWDkfpNX0YvfoHRIdc8N36wHKCj
	2I8F0o1XKoNkIQmLpHOqn25GNdWCyl2B4ETxyTjrgUb6tit5tOu5zYLi3hPA47mY
	PuDCd3wmswn8ON2aMtxuvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733156282; x=
	1733242682; bh=iLr0s7SWF9kCJfGM6XnM1NsAyjuHPxUtXwH/s+y0MrQ=; b=N
	6yw6q0KSYUXA7gdpKv3EkxIhNiwDsONxo1LzhU2jqKs2On8FD6L96AvREpemQrhU
	PSEAWlgDA4ni5IzIUQeik/utJcQaSsS8VYSp6ZmcRLPBJ4gVinoOSf7Mc7gt2BU6
	j/RHtE+DZq0ooTtExRcmYMiDTuO1PuG9uRv2xvGbkqDycJ7bsDHBZBUE/w88FgZr
	yND5F+F//g1v5EXXJ6HlZ9bGcod+aFKuM/anSdzGFmCAlKdZ1aVQMyCDDyCOHOdR
	7jzqmFTIDmxkF5nF0NXhT/3VySHEUkV3H//OF1kr6AezGXrCqvSFxOZLd7IQzcTA
	8fXgGnBvijlSPBI5Ukeog==
X-ME-Sender: <xms:ut1NZ7yGP6JpI3ckkWoAj_Rl77DfJIBMfxSISUiMtMMgRHHvTz-2jyg>
    <xme:ut1NZzRiX624j6qrZzi1J_L5yYRNo-kLcgySKfUyEi3R2z65Rr839909m075BWkpS
    zolB1vREiDdKYvvcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    evkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeghfeutdeutddtiefg
    vdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:ut1NZ1XgJxs_71kcI3YWCb64uQ6T1ayjYBl8SpwXc6knrL1i4HYFHQ>
    <xmx:ut1NZ1hOxiwiDVqwty2PzsFihP8CXDsqYy4nOmrOiskx1Gd87juCEA>
    <xmx:ut1NZ9AvNgAKSwzW3A5-yx_RKioQ2rT7Juu93qlOwjGm7OUO_xuKSw>
    <xmx:ut1NZ-LXrbrvUBYgvbsrutWbKTQn0lJUB6F9PCfctveKf9Id65Ws1Q>
    <xmx:ut1NZwNniYRVtqwy_II1SA4I4urzgHazXNnKlmqyjSxNF9vXK_ECH3S9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 500C4780068; Mon,  2 Dec 2024 11:18:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Dec 2024 17:17:41 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <8752f4b3-db2e-4db5-bb1d-8b87cb6fadbd@app.fastmail.com>
In-Reply-To: <xmqqttbmkh8h.fsf@gitster.g>
References: <702d88e9-c62d-482c-a457-6d6642e8488e@app.fastmail.com>
 <xmqqttbmkh8h.fsf@gitster.g>
Subject: Re: gitrevisions: be more chatty about shell metacharacter gotchas?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 2, 2024, at 02:26, Junio C Hamano wrote:
> There already is a note about '*'; we can add another note about
> whitespace next to it, perhaps here.
>
>  Documentation/gitcli.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
> index 7c709324ba..0a67005fc6 100644
> --- c/Documentation/gitcli.txt
> +++ w/Documentation/gitcli.txt
> @@ -57,6 +57,16 @@ When writing a script that is expected to handle
> random user-input, it is
>  a good practice to make it explicit which arguments are which by
> placing
>  disambiguating `--` at appropriate places.
>
> + * Arguments, options, and option values given on the shell command
> +   line follow the usual shell syntax rules.  You'd need to quote
> +   your string with whitespace in it appropriately if you do not
> +   want it to be split by the shell, for example.
> ++
> +--------------------------------
> +$ git commit -m "my message with whitespace"
> +$ git show "HEAD^{/^my message with whitespace}"
> +--------------------------------
> +
>   * Many commands allow wildcards in paths, but you need to protect
>     them from getting globbed by the shell.  These two mean different
>     things:

This is a good addition. Including a couple of good examples.

-- 
Kristoffer Haugsbakk
