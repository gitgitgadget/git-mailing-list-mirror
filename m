Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A0231830
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833456; cv=none; b=kT187zX5VX416ZZ5t6i0tRI6c6jvhvg/PVPXlrkcYOWrgVwTAj6WH8xHbRmMPxK1sBF+Qy4xyNBIGHKemgoKyJIrzfzp896EDIs1nRBmtpXqxMwUQb5/dK19Ll2Rp6q8T6YBwi4jkYuk6FCmuoPcLHyFE83QfnkB2v/PhlDJcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833456; c=relaxed/simple;
	bh=562E+LBvSXbK+auNpkKlnYzOy8S9+f6z+IHU9i8fvS8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aenHw1zny85MuuRSrJJXtYOrR2FZDQr0XmWKS2kvfq4kLtTuoFvPscRHMsyZn5eI/iSXYd0BczMDPqRV6T6plYU9a+8/fQ4qLYhSLvEdUzxCksp9wA2YjPGUzLr/B8+vDvvTeX+EP+3rjbeR1+fvs5b8CdC38hjcD5OGYSnKYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=t9ySCBjT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=altlevFR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="t9ySCBjT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="altlevFR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 72CBE7A0089;
	Thu, 25 Sep 2025 16:50:53 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 25 Sep 2025 16:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758833453;
	 x=1758919853; bh=QCDJ9iKYrs5WHPAAEU9NfsYBRAdLBovNGbsCZGdod8o=; b=
	t9ySCBjTzoeOZhdAc71uNQ9F9wQtYLe0XNjhbRG1DgQ2FKyQa4XGnNUeYvXtUHLy
	BKRHWEUfrzzxPQF9KaRBduPBPt1g/9LynzbFYmW7qwy+2oZ64fLQzblbFLkmtP3o
	4pt1LMlNoWqWrez4MUSUFlPXTezyBVjxBgEZTs3WS6tUqeVQxPoYaS6EedtZXAMw
	YM5Q7JJeIBEIhl1Cdm2kdjrCI9Wldl5cDcw7uO42CdpAqhAkkURwOE22Kad/gz/d
	tAZ0+8Jxk5/N6n4xK+M3T8qKZC6SgEKn/r5Jc1LXKhadMNPIvXr/WGCUf3Z1Ib8G
	UuqWKfglKzGAcI7iGon0fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758833453; x=
	1758919853; bh=QCDJ9iKYrs5WHPAAEU9NfsYBRAdLBovNGbsCZGdod8o=; b=a
	ltlevFRIP99yRKGNjvEzRVtBKpQjMfiFnaQiiE1Ye3Fcp/uuQsqCQUp8yFaqG24T
	uozdaI9vpeA6vvuSMVuI3ggDYfwwj4F7v4h5Wh7vXk/9nqk0+xCpQnKs1rk7bTB4
	oPqBQJYbLg7wmvG1b3/lAosf/EzmL/i3BLVzUt5YeTlAa+BQ7hRSXUhO62FR7NYd
	aUcTOQtFHqGSYqSXfbLe03MT7El3c6714gEgPcr1nkmPOpPPHlke5P1CIIkX9+9K
	kkXrcSu7X4wfr7h9oR8xwOGvry0XX2fNLE5eIypFlrpjcstci9+aLRmKajnBVeEg
	xZNc2r+O6pxmTNEuiEw7g==
X-ME-Sender: <xms:LavVaCQiMhetY9BdaUBB8B6qqK1kjDlk67bg9DE-somZjIiFivZjqg>
    <xme:LavVaCm1w3decpTzZm8vofAUdXaC3_XlOOSQSyM2o-ZUt5dSDGLE1Vqx1kk7svDNn
    R7eXeV4UwrwhNXzGP2IVVWc3BiORzKxPle3BWI1njNpBqKU8xJKO2U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:LavVaBWXHQlXv1fBQx7ee51e9R3TJ67cftPHfFprj60PD9wIVXYSPA>
    <xmx:LavVaDFcU3oOPSqSaqr1QShqceTjmR6AHrddmNw7y7R7nNQPmAczHw>
    <xmx:LavVaNcDlKq0XdU7s8Qi1yp5IumCs8pDTs_8NBMo5Wvjt680LvuEOQ>
    <xmx:LavVaEImqZxf0X7TI7N3_6qQX8zNaewd7oqinqxWJHYgiNRTvFjcvQ>
    <xmx:LavVaNrEhtILOt7aAunm_EA30oiKxX2oYXp7d6aid00dCTRPRchYUINe>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 01A3578026F; Thu, 25 Sep 2025 16:50:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALMQnK0r4jnk
Date: Thu, 25 Sep 2025 16:50:32 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
In-Reply-To: <xmqqqzvvk4bj.fsf@gitster.g>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
 <xmqqqzvvk4bj.fsf@gitster.g>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Sep 24, 2025, at 4:01 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> -When the command line does not specify what to push with `<refspec>...`
>> -arguments or `--all`, `--mirror`, `--tags` options, the command finds
>> -the default `<refspec>` by consulting `remote.*.push` configuration,
>> -and if it is not found, honors `push.default` configuration to decide
>> -what to push (See linkgit:git-config[1] for the meaning of `push.default`).
>> -
>> -When neither the command-line nor the configuration specifies what to
>> -push, the default behavior is used, which corresponds to the `simple`
>> -value for `push.default`: the current branch is pushed to the
>> -corresponding upstream branch, but as a safety measure, the push is
>> -aborted if the upstream branch does not have the same name as the
>> -local one.
>
> That's a lot of text, and ...
>
>> +To decide which branches, tags, or other refs to push, Git uses
>> +(in order of precedence):
>> +
>> +1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
>> +   or the `--all`, `--mirror`, or `--tags` options
>> +2. The `remote.*.push` configuration for the repository being pushed to
>> +3. The `push.default` configuration. The default is `push.default=simple`,
>> +   which will push to a branch with the same name as the current branch.
>> +   See the CONFIGURATION section below for more on `push.default`.
>
> .. the above gives us vastly more pleasant readability improvement.
> Nice.
>
> I do not know if you want to do anything to the lack of any
> punctuation at the end of sentences 1. and 2. (I would have written
> ';' if I were writing this myself).
>
>> +As a safety measure, `git push` may fail if you haven't set an upstream
>> +for the current branch, depending on what `push.default` is set to.
>> +See the UPSTREAM BRANCHES section below for more on how to set and
>> +use upstreams.
>
> This feels a bit out of place, as the safety measure, as I
> understand it, is only relevant in 3. and only when push.default is
> set to "simple".  If we are referring the user to the configuration
> section, then it may be a better place to say that the "simple"
> setting requires you to integrate with the branch with the same name.

That makes sense. My goal here is really to communicate that you may need
to set an upstream for `git push` to work, since it hasn't been mentioned yet
that the upstream branch might be involved in deciding what remote branch
to push to, and it comes up pretty often when using the command.
Perhaps this instead:

"Depending on the value of `push.default`, git push` may fail if the current
branch doesn't have a configured upstream branch.
See the UPSTREAM BRANCHES section below for more on how to set and
use upstreams."

> Thanks.
