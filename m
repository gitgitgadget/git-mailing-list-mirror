Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8F1A9F90
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291512; cv=none; b=YgRv/+yfxQ8OIfjINauujQeWwa75F1SzNYvduKUyXmvj61lcYznw5CXmgKqt15EUcFc7Q5BJLrEMld2/+HfH2SSggAEBcl3uhiqiXHbg9luFodeeJggoGb1o+jPvyem/StjClzDKJ+mYRnNBQaoK32ChNHDBizvMcnlhYwQO3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291512; c=relaxed/simple;
	bh=ogeluqOc11XpcNn1U3M63uXJa5P70y7P5wqC1KCRWA4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FGql5hq1EBkjdPHIc+B3q75TIbkQ2lfdY4UdclPujOCUVJxRqpX1AHIGBoCxIeiPp08X+WEuSVrYXqWVgcL7z2v5xfVfbha9ZUchYjNQK1PPSoTo9+/9FlY51BHdTwJ0Qq+kMHC83ggrmQapT0WC5urCWICLkqz9Cr6sxMTTGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=nB1e1heA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZutqSfCK; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="nB1e1heA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZutqSfCK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF7E37A00A3;
	Tue,  4 Nov 2025 16:25:08 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 04 Nov 2025 16:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762291508;
	 x=1762377908; bh=atTuZmAcOzyrM4rNjrTtdcYNmuVO+K82j+8M0h2x0aM=; b=
	nB1e1heAt1t29CnLavG+uAOWfuqhz7PdshKoFI30x7F+tORaIPwhRz+PHnSiVkkS
	Z4KCpI1r3IlXL9aPCPC6gblclfdkUTq41NxkQ5jOShOUTHMCUhlHpE0f3p2IINss
	2XeCK+Ma2nxFeWsL5EeVy9J+BTZBZRrKoYstfDtgv4qI4KI+/FVN6V4+3qosnjq0
	pstEp9LahNlGboxtstN7PwX+8nppotnoiDRktW8zVpzhhaFFxRabrXLRW+BFIcDc
	r88E7enbmIKDnSGXBmv/HN2BMXs4HW2dv7GWnA87/7TLvrZkJfE+otNwIYRF3kNL
	dq8HfIT2gNdZJLybZYqouw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762291508; x=
	1762377908; bh=atTuZmAcOzyrM4rNjrTtdcYNmuVO+K82j+8M0h2x0aM=; b=Z
	utqSfCKECHp9uYL7Kath8OenBbcsQVeElpR4S+Gohd4D/AQGh2gJ9YG+RBDhenXk
	j9Co5GSxljfMde9+hDd8NOwD1oN5rBZjbjm6VDf2odKf6aryxXgy4kpkUbzPWkCe
	HgjQj2gI7L2iHbEkrgi9xtQ+NFm71xR6XYtFj/FRZIR0+u3WoFYVt+4Slpj05Q7d
	UnguHVw9woT6TNso0BX9JZT5kXffQxxJNEgEUM4h4u51R5Oxo3p5q68GBD4fE5qj
	gohKaH71atKcIwQUN1jhTm4w3zzNTCYRUYF4oIS7ECO8Ti25N/UwGBk0tcO2GuPI
	bmeNOdrQrDQbb02Bj+Q7g==
X-ME-Sender: <xms:NG8KaSkJzP5P-Ux5w3jAKLWJA_ro5S42RU_VZx8Je0IkbURkamWp6w>
    <xme:NG8KaUqQdagSgqGSH6HxrIzbDYAlOYKmbaxbPe1HmBJdEoBMpiYxSuoVrBUaK3RKR
    sMUkVkOgieO8eh0XvQhuOH-7Lruqph1pJh7Q7AMC-kcwsgfttwee6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NG8KaYSi13QJ30KMYaMwkrkcqWvxmwCJDdzgTX9jUAcI2AN0C6ZPXQ>
    <xmx:NG8KafE5cKlJps4bBPIMqEAxb6HcElPtYzlSqaNuMjj58mopZKdCrw>
    <xmx:NG8KadEAeceKfFefHHurv124mryxbrd9EOn6vvEBCdgOTM0B9jylgg>
    <xmx:NG8KadQ9HTMLqoMorSpvOutVrx962pQqJBy9iEvw-d118t9UNx_7WA>
    <xmx:NG8KaX5ltBbQvizpBh9OJn-QrT9175wkWvIKJILnPHzw1_kQGu0jPMKj>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A9E47800DA; Tue,  4 Nov 2025 16:25:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Tue, 04 Nov 2025 16:24:48 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <5ac4f09e-927c-4125-adea-f7d5ed3d1caf@app.fastmail.com>
In-Reply-To: <xmqq346tpliw.fsf@gitster.g>
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
 <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
 <xmqqtszf2kro.fsf@gitster.g>
 <8b70796e-b5a4-4f70-8b27-c0ed80d1fc4d@app.fastmail.com>
 <xmqqpl9yshrr.fsf@gitster.g>
 <9ff9d97e-2fae-488c-990b-cb574fbe8c71@app.fastmail.com>
 <xmqq346tpliw.fsf@gitster.g>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Nov 4, 2025, at 3:53 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>> The problem with "A branch refers to a commit object (by its ID)." is
>
> Ah, I didn't mean to say "you must use exactly that phrase".
>
> But branch refers to a commit object, it does not refer to the name
> of a commit object.
>
> Perhaps "a branch ref records the object name of a commit object",
> would be better?  The untold implication of the phrasing is that
> anybody who reads what is recorded by that ref can then use the
> result to refer to (find) the commit object.
>
>> it introduces some more potential for confusion: it makes it
>> sound like there might be other ways to refer to a commit object
>> than by its ID.
>
> Yes, there are unbound number of ways to refer to a commit object.
>
>  $ git show-ref refs/heads/maint
>  bb5c624209fcaebd60b9572b2cc8c61086e39b57 refs/heads/maint
>
> The branch ref let you refer to a commit object by recording its
> commit object name bb5c6242, but for humans, it is much easier to
> refer to the same commit as "v2.51.2^{commit}", which is far more
> memorable.  Of course I can use master~32^2 to call the same commit
> object, which is less memorable gives us a hint that the tip of
> master fully contains that maintenance release.  What's more useful
> depends on how the name will be used, and the hexadecimal object
> names happen to be how refs record the objects they refer to.

I'm aware that there are other ways to refer to a commit other than its ID, but
as far as I know literally every other way to refer to a commit eventually ends
up going through the commit ID to retrieve the commit.

For example you could use `master^32`. but presumably what that does is
to find `master`, look up the commit ID for `master`, and then go through 32
parents until it finds the appropriate commit ID and then looks up the object
corresponding to that ID

I do not see the point of implying that the commit ID is not "special", or that
it's only one of many ways to find a commit because to me it seems very special,
since there is no way I know of to retrieve a commit that doesn't ultimately
end up using the commit ID at some point. (though that ID might not be encoded
in hexadecimal)
