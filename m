Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88572E7F2A
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016077; cv=none; b=VlYtrfkEZuCv8RE/eBtxvNZFEg26UY4QXo5Pl/hK2Sr8JGCwHWPKff+luv2iTROKsiQty7DRo4B2qh8qtWmvQzCq/jumQcbpw1pDJPmH0qSgBpR7qY1ksbetQ4WWFcTqx4jLh9OJ4U4Uphlev4LiwcRkwKXAJshe4Hr3G/TSbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016077; c=relaxed/simple;
	bh=VXUon1as6+0JgV1Ta0ke9QK3fbAv6gi7Egx1HbAqN30=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hZWhPWB/yxFo+pvv1fP8FQCxtMjn/CAmuLgXj7ykWqHVgxdOCPObuFNSZ+zLKpaf2IBU8mYrBs2wb1fWTJfB5g/fbBnEaH4ZsLSC9n85fNoUzq8TqdKz+wKHzFz6ya+sxzBjflSwBWxUVFLQzWaSzwl/KRZju1U+IH2uEGTkXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=PT9aXh4y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=shKwL67W; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="PT9aXh4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="shKwL67W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DBEADEC001C;
	Thu,  9 Oct 2025 09:21:13 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 09 Oct 2025 09:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760016073;
	 x=1760102473; bh=msApsahZ+gB0GthdpVsoG8spMIWOpPn3efqJW8QNDKE=; b=
	PT9aXh4y0WqSDIYaHewefZIUFPunydbUDne0y2pJesOc0/4sqwbC8VDemFDjUL8+
	B91YGPCASCkPDy1keVsbpy3Rv/O2xh+FfNypkIsErOHri7CVNA0MxvA6k2WG7ozW
	mPElnqmZiD3AvAIAcqM0DRYOPCxDRI1a9J3xcIsmUraZc5oIBpT9hzMzVzKGQZWj
	jhhZ2Wf/a3otTTa3qu7cCtxYzz2a92kklr5yJ4qJ2LABc3x4ZguFB1jyAvmT1sWI
	YYKHJnemI7zuGOPyLxNJyr+qcBD5YAr3xOUfBPx4NeoRvGeT0lHkS1l2qAvRx3vS
	oajyEcnldm903xta9V8DoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760016073; x=
	1760102473; bh=msApsahZ+gB0GthdpVsoG8spMIWOpPn3efqJW8QNDKE=; b=s
	hKwL67WqUGZTIKTlQ/7iLcA+vlcsFFc4amHf2Jw7TgI81G2X7lvf7g5BzFyph5Df
	z1+QUKtC+vTeuZz1xr7zEN/mCyVBUb9O88ZDerBDRzUTYgtDl9/W1TJre6dGoJub
	IRP5DkzKgJThdumewINNu79n4whzyESAJzwb4QC7ACVIGgrV0NVbXteSDaD66hXn
	WbFsDVIVGdbqL5TCUZTSW9KiLO9iobENYaJlZhsKnPaH6T+ocVG9wPFzFoT4EZYn
	N3xjx/SJ0L6NZsB9SjZIDIgwjwawnwCCO2iXuIiO6YW9HoKoKnl9wQ+WBO3h/p/v
	X/RqS3XUbk50kgmbsnPJw==
X-ME-Sender: <xms:ybbnaDo_Hp2H5Mh3laP9tbnZTOtBc53i1JAmaX-X79v7-BT6Lh5eRQ>
    <xme:ybbnaIfbtYM8BLQmXJtdG95rRxpgyMalIaZrzAtmq9V4aHjEu7GBP7s-V7hv1wF-w
    tR2AVb_G7u4TuvHS2OQ9G2f2x5YDKmXeJ09FG8rd7x5Axk_M8lorpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epfeeiieeggedtfeekjefgvdetjeffhfevuedutdetvdejgfegveffhfelgedvvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ybbnaETKZ5zOfL9mUGMFfB34dlZiuNlV5L9Vu6cQ04xgW9y83qtcDw>
    <xmx:ybbnaPlEuh9xigr-HGVor6Uf2RATb-oxodigzFSvfOIAM5R8oaFxig>
    <xmx:ybbnaMRJFA3mVZp16MECNCOswDL86tH9nlToFPvcT59yYwERSAMr8A>
    <xmx:ybbnaFPOLxMZfOhXIJZoSsGY2kJfMm6Pz-ssiwFkRoQdys-cWP0rMw>
    <xmx:ybbnaIU9rtwYaMN25bxKOFJc6Ujy7UBJ2K4SXCKK-2QD5WAKlxdQc61Z>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D4D27800DA; Thu,  9 Oct 2025 09:21:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Thu, 09 Oct 2025 09:20:53 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <d1bd63d4-3ac7-458c-86e0-a4f7aac300d9@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCsGtjcWBkjV0vsJHDCwiwt9eO2CsA1zFgwFiwJ-KLhew@mail.gmail.com>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <8df4c59c-4d27-4f36-a231-f7af32ddf149@app.fastmail.com>
 <51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com>
 <CALnO6CA29HA_FOQAJp_bkskKF-6Vy0_SKVL_OyJASByvKEZTqQ@mail.gmail.com>
 <1241cb86-9adf-4c52-87fb-028406ccd8f0@app.fastmail.com>
 <CALnO6CCsGtjcWBkjV0vsJHDCwiwt9eO2CsA1zFgwFiwJ-KLhew@mail.gmail.com>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> >> I think I'll see if I can figure out a way to mention this and at =
the
>> >> same time remove most of the rest of the references to the `.git`
>> >> directory when explaining references (which you talked about
>> >> further down), including packed refs.
>> >
>> > A colleague will be explaining reflog for an audience tomorrow, and
>> > decided to briefly explain refs, too=E2=80=94which tells me this is
>> > much-needed.
>> >
>> > For refs themselves, perhaps "git for-each-ref" is a reasonable pla=
ce
>> > to start? Since it tells you the refs you have and how to spell them
>> > explicitly regardless of how they are stored?
>>
>> Interesting, do you use git for-each-ref?
>> What do you use it for?
>
> Ah, yes, but primarily for scripting.
>
> What I should have clarified is that "the tool (I know of) to
> interrogate the refs you currently have is git-for-each-ref" (like how
> git-ls-remote is the tool to interrogate a remote's refs). It avoids
> the issues with assuming "tree .git/refs" or similar will capture the
> actual data.

Ah, that makes sense! I spent a little while trying to come up with
something that would give a "similar result" to running
`cat .git/<refname>` and I came up with this:

git for-each-ref <ref-name> --include-root-refs  --format=3D"%(refname) =
  %(if)%(symref)%(then)%(symref)%(else)%(objectname:short)%(end)"

I hoped to find a simple equivalent to that `cat` command
(kind of the equivalent of `git cat-file -p`) that would work with
other ref backends but couldn't find one.
