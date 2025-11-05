Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47634303A32
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360026; cv=none; b=nOsB9mtyeKQdR1ZtomFG6KWWFcXFe1ruZxvzD0Z3heLY2UZ6WBPOiM/0EsFdl8o9tTrAx3iPxCrU7X6pElqGvh1ouqS6TAagy6j7WncAhDEvKDAyEGtqKLS7fzaip7Ewjcy1CXfdbt/oA1hFj73w4Ov2je//Ulh0KmxvwrtCTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360026; c=relaxed/simple;
	bh=fDSY+4c6wo68Do6fjWj8ro1edhvOfBA9va97My1yHdU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DA84LOTV8QIk5kuL4Pnma3ct7ErH1hb6uuBGtlSk6grMVTplnB0T/XCBW+AWFw1083YtH2BuKSPUnLjyz+tqWn+/9Rv/06S/FBvlKRjAqKBJLGf99xJvHWi0w4HzXziBzIej9heCasS02dYxAQp9oZqXMM6xwmIf0usesVU4jgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=oaCgibBR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QKXd4y4S; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="oaCgibBR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QKXd4y4S"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 37EA81D00172;
	Wed,  5 Nov 2025 11:27:03 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 05 Nov 2025 11:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762360023;
	 x=1762446423; bh=vqREEl6xv+ID7zqIJjxb8xq2PVS/r1HxSP+3vsxEPqs=; b=
	oaCgibBREN9njZCpbVAqs5pM86IFN0EvzwwLzB7vDHBNNhVpnKmW+K4J8ZuVIx7J
	QQoy+fR2Uu1H54pFJ8foiSIIZuJ409JAaQ6iI+6fjH3LQdfFATpZ6jwTI+A+qRSb
	Pfg7jat3RGJ1/HV74a8G6PEwzTn5C7krhA1p57cwQjrgU0Mc2ZkX6rsHq84Y+sY6
	EUeOFl60zmcXGeiw4KkegeR+9Lr/M6sBDUnk4caGzwzMkn5C5/iK7PimmYEiKXXa
	lOhmFZCHMsYRI9mN+7koYQXeAUh/VZ+oOU4Iqe0zumdfJZRlmGGTnRfjChKO+xsA
	HnzoB3ll/+pZb1NRO9B7GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762360023; x=
	1762446423; bh=vqREEl6xv+ID7zqIJjxb8xq2PVS/r1HxSP+3vsxEPqs=; b=Q
	KXd4y4SNpu++2yXdYHJ+OWrRHpDL6Ta/893j7IgVJ0SSQFG5K2hxLE3UpctYcRnu
	uWyRpfGIrlBTtUc2LPaBZ0rCbtfH/7MIpQN9EYByrrzPxBxmmD+Xv+T3ttu+VtKE
	qX3Jl0v5IGiNIm45OzZQWNyGmghpx+tvX4I4Bg7JUJZ+hKinXNoY4XJSvmNvdwOz
	xCycYxERsDnFpb79/RP16I6gXJMSOBzz3EaHXGyWht1qAt3eA+3Dc7XAv8jp/j3R
	ZiYzA+MOCmsEQgbeIJaEQFOqcTHcQdUEDbAX81QLGTV/Nkjko0FJKMYSV+hTEbLn
	cPqPo46iJ+0wRrN9anjKA==
X-ME-Sender: <xms:1noLaTjVSBLr-soDR7TH0x2-bgsg4s_ALToE71wsgMz45dd1G_GCwA>
    <xme:1noLaa3swTOnYW4h7EGUvtUKmoZ2Auub9UNUpgOldnQdIZWfsiJ8ZM_rThJ5bf-_u
    K7_3FET47HyN47irRh0QlTj4Bym4a7WvCkF8b38DHDh0w_k_irlnwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epheeiueffleekgedtfffhhffggeeifefgffelfefgleekudefieffkeejgeefueegnecu
    ffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdifihiirghrugiiihhnvghsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhi
    rgesjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1noLafNk02ZQmcZ07yLdPcMmINzXB0TNSLifm2yYHeJI_jnfo24Upw>
    <xmx:1noLaTS9pWKQO5lfYun7iHmoPA47pz4ODgBGwRy5LSDmdrzWLH85Rw>
    <xmx:1noLaVgW9NJBwJFrN_8d_433r2f6mPNwvvbA8ou5PdiAO3bU8WTd9Q>
    <xmx:1noLaU-yUJZYOw3OqXiLEIFRkge3y9iNSt1plIkuY9nHgT0LBGx3FA>
    <xmx:13oLaYF6kiXssHnA8mV1Gqvc67u0PXvEywpTOcrxf72vyuZwGqmHSD8c>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 83E5F7800DA; Wed,  5 Nov 2025 11:27:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Wed, 05 Nov 2025 11:26:42 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <7217ae44-5ad5-468c-b76b-c485247fb2f4@app.fastmail.com>
In-Reply-To: <7E8706EF-6C15-43AD-A847-5C896D9235AA@gmail.com>
References: <c268c98d-0a8d-48fe-99dd-b4a2fdcd0fb9@app.fastmail.com>
 <7E8706EF-6C15-43AD-A847-5C896D9235AA@gmail.com>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Nov 4, 2025, at 10:21 PM, Ben Knoble wrote:
>> Le 4 nov. 2025 =C3=A0 19:02, Julia Evans <julia@jvns.ca> a =C3=A9crit=
 :
>>=20
>> =EF=BB=BF
>>=20
>>> On Tue, Nov 4, 2025, at 6:45 PM, Junio C Hamano wrote:
>>> "Julia Evans" <julia@jvns.ca> writes:
>>>> I do not see the point of implying that the commit ID is not "speci=
al", or that
>>>> it's only one of many ways to find a commit because to me it seems =
very special,
>>>> since there is no way I know of to retrieve a commit that doesn't u=
ltimately
>>>> end up using the commit ID at some point. (though that ID might not=
 be encoded
>>>> in hexadecimal)
>>> That is not what I am trying to say.  The hexadecimal name is the
>>> most neutral way to refer to a commit object, and in that sense it
>>> is special.  It is the way ref subsystem uses to record the name of
>>> objects, and that makes it special enough.
>>> But that does not mean that the name _is_ the object.  The
>>> hexadecimal name is a way you use to name the object, but is not the
>>> object itself, and the special-ness of that name does not change it.
>>=20
>> Okay. I still do not understand at all why this is so important to you
>> (for the reasons I mentioned before) but I'll see if there's anything=
 I can do.
>
> Perhaps one way to look at is, what diagram would I draw given=20
> different textual explanations?
>
> The diagram we _want_ folks to draw (?) is the one where a branch=20
> points at a commit [a circle, perhaps], which points to a tree=20
> [triangle] and recursively blobs [squares], like I=E2=80=99ve seen Sto=
lee draw=20
> for GitHub blogs.
>
> We might also want folks to label the arrows with names, or not.
>
> One way to interpret the =E2=80=9Cbranch refers to a commit ID=E2=80=9D=
 might be to=20
> draw a diagram where the branch points to an ID label, and to find the=20
> circle you have to separately consult a different part of the diagram.

Yes, the most common type of Git diagram I see is something like this:
https://git-scm.com/book/en/v2/images/head-to-master.png
which only includes references, commits, and HEAD.=20

That's the diagram I have in mind when writing this text, and I think it=
's
a useful and accurate diagram to keep in mind, and it's one that you see
very often when using Git tools, including in `git log --graph`. (it's n=
ot
a _complete_ diagram of every type of object, but diagrams do not need t=
o be
complete to be accurate)

I personally would not use a graph diagram to explain how commits relate=
 to
trees and blobs (normally I use `git cat-file -p` instead, like I did in=
 this
`gitdatamodel` document. You can see this comic for a "visual" example o=
f how
I've approached discussing trees and blobs in the past with `git cat-fil=
e -p`
https://wizardzines.com/comics/explore-a-commit/).

> Both seem useful to me, though as the former has fewer moving pieces=20
> might be better for the model this document describes? I dunno.
