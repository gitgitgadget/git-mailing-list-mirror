Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC79277029
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861051; cv=none; b=nHFiW/ZvGlgWSuutIumtnm1aJ/5WVqY5EHzo735VJUO3+25NwuXDhP2NBc3JRwiJXL1EwAPn3sU0J6drDA/BlZscnxyprUnk2QxFBrdXCk4yOBXgHe1wv4XrLau1Mgt2lj2f/ZAKU/hr/0N0ryD0q6MF2V+4I2cDdXBEPv7829w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861051; c=relaxed/simple;
	bh=sC4kxDuGuZuZAclKKTjMl9CQh1Y7nYhU4Xo2pXKhRjk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KPeItHcAjHH1tFfRiyg7wqpOVozYC5rRyO8b8oaeG2cSyM3xMWDaiCzqHxeEMJTDUnTFycpkoDsSOHwRcg6B5oNtM7+d7WqXUJaEuVJY+cFaGWaFj8pQVNNy9iSRhWq4ci1RLaqTiTE5I74YggnS+guIX+Zg20DX2eWeHU33f7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=D9LLRsJM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t6UhPSeg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="D9LLRsJM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t6UhPSeg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD5EC1400226;
	Mon, 23 Feb 2026 10:37:29 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 10:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771861049;
	 x=1771947449; bh=6+HLstZl3nOuQFbg5a/DQf7+Kven3dJ7uqHMUwls4Vs=; b=
	D9LLRsJM37rzv1wmNYuNtcjS7O0OvFIRQC3R/CaiDj52h3EzZgLw3rZ9BsNY6m52
	NJu7AibCr43jazd6q/6TsqfCEV4QQ5q9G9Y/V4tyTdyYqsyND5GAVzqAjes13/9e
	t7zYECElaBWT8+nPa3FZjW5xvoiYe9BtCJN8NYgPHfwvxkjgnE0nY5+w7V9dxLm4
	zw35jf8CeAZEuis0OO6GM+ufndtvVs/JZ6fwd+imMr1ihZZf+kP3geQVUa/Rpmi6
	wY9co8uI7fKvd8xzxvvmOP40H5+IaFf/+TVlUHu0S7MNkAIa7KKmLVoAdFlPVOOu
	pr6FCXJ/2hdsETAUPeiCEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771861049; x=
	1771947449; bh=6+HLstZl3nOuQFbg5a/DQf7+Kven3dJ7uqHMUwls4Vs=; b=t
	6UhPSegIKiCWOVw/XUQVeZ4qPXJ0rCKFeJizP0V4CNjdBvePCTVLMTPSza41n9vl
	HyZSSxJeDVwl4LMBffhb5J2UkOhyDJg5hISGAQwBlQIzlycf6hN5rudZtqRi4tiI
	YXURjiv42kLpgqm4sszN+yrUKIv7+K3b1t4l/g1wJVTSpWUGVl1jRNYINt5U2VzG
	VReAzHCR/n1Xtn4N11lPg8QZszhBVd8dyvBzDzYkFS/reHibk8e1bmQKemYhYHeX
	LulKJMSvar7zCvyLfMnN4QXlf8bDa/A1QY+Sip+B9wIedl3sSNF49Si0HCbeAtv/
	uyuQ7R7nQyf6hs684bcDA==
X-ME-Sender: <xms:OXScaYaMh78B9P1TwfspjkV7ean4oozUZd-Kt4GNFtEwPb91kwVmAjk>
    <xme:OXScaeMMDvC6qFyFVfY1W-Bm7DKf1UBjKvBD7yS4ko5A0D1nnSJfOSK2cRM_fqk_M
    KXLYM_aVD8h6wUWmgL-HWerSjzvzdMBU425cOImPKzlMkiAP8N-FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeej
    keelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:OXScaS1HjERyyDyV6hoq4DX0GI0o4MuKktpqFcnN2-nAIFIO700o7A>
    <xmx:OXScac0_88NC-eHm_5DJpM4f6eji32z38klo-vhIi22Jt0r-QQzArg>
    <xmx:OXScad_TQfsElUSpXZLcEheIsc1kl5Jsb5SFhl-nYtyl09gDnEZU4A>
    <xmx:OXScaR0Rh92FgOv4ft9lh5IkwqJnh8ennu0JY56xTi_t2LCFbeKztg>
    <xmx:OXScaTptTSqTi_DT97t6kKGBerArDh4HIXy7KNFGft9-Zi8PoeVpIKGQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 874631EA006C; Mon, 23 Feb 2026 10:37:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyBpWkmyGh1o
Date: Mon, 23 Feb 2026 16:37:09 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>
Message-Id: <aeb2f6ac-0a1a-428e-97b4-4329452d464b@app.fastmail.com>
In-Reply-To: <xmqqbjhfpk6c.fsf@gitster.g>
References: <xmqqbjhfpk6c.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Feb 2026, #08)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026, at 16:13, Junio C Hamano wrote:
> * kh/format-patch-noprefix-is-boolean (2026-02-18) 2 commits
>  - doc: diff-options.adoc: show format.noprefix for format-patch
>  - format-patch: make format.noprefix a boolean
>
>  The configuration variable format.noprefix did not behave as a
>  proper boolean variable, which has now been fixed and documented.
>
>  Will merge to 'next'?
>  cf. <xmqqy0ko626g.fsf@gitster.g>
>  source: <CV_format.noprefix_boolean.39c@msgid.xyz>

I=E2=80=99ll make a new version.
