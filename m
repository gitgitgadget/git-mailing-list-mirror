Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB93A380D
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907731; cv=none; b=OAG30hbhAQAlHDQSm4o2oemnUDY+cR57BmbUvJD/liKSEX/jeqPICLSed3jgg7mf/bD33VG/ODLH1Qys5LjPv20aAlh/Pqq+mSyNb4QcwUKN08NHt4PMQmfppWbAnJuhW5w4h/IU3PasJC9pR33JQLlGByeKdlA+4/nsA6lj1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907731; c=relaxed/simple;
	bh=KGWSNmP0rgN5ap5myJSsqn7he6DrtPK3u3p7+hc/7ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oStIIi4YDRQFQ6CmQLEKMZp3Uk0bdS1g8OfdnySn1Vxu5D7/yvR18U4FVsMgkMBXINleSejwBAX/C9GOoPWp0McileCsKcPU4FzWAz6y/l8PuGL+PRO/jB4xD2VTY7o2rmj+IJFRFFndn7rI21ospWhlFvaDCzlDWQFHd3fc7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=APZVzFLy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VxfkzdCn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="APZVzFLy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxfkzdCn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A8A58EC0252;
	Mon, 30 Mar 2026 17:55:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 17:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774907728;
	 x=1774994128; bh=R15GZdRRpVVJdd4ZTlqp5WDJZ8YejcBbYG53pD7OppE=; b=
	APZVzFLyWbCsiazH1zoqK38UfUgfPEDA5WAIFxJNCdlEruL4UV4/p+5ahon7c2o0
	RPxQ+ZJeCmYiF7P3XsWM9Mz2RrjFniVlNU8a/lAmV5tixsNYbmNvQqL+JWFJtKmO
	ZJqFj77AyP4bj7ycqo3Z7fSzNLoGKnyNQ0TixH/K82LujosaCXPicxZo2dd0wc+d
	b68nlFBlqVeji+CYfCZhKrqW0j6JVTFwc/nvl/1k5CiXXyEiELVC44kjF736J4sj
	Gn2SkVKXnwhRP7FKlIWriZdyUMabVbmxa3zGKUP2gNbiLChaTIDhi+pTglTQp5r7
	8FIiSUZE9qQxcj/13oWU/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774907728; x=
	1774994128; bh=R15GZdRRpVVJdd4ZTlqp5WDJZ8YejcBbYG53pD7OppE=; b=V
	xfkzdCnxZ0ihuK0LbeyH783Km+OryGoFQDHimKGOQ9HBx9g3FyP5Smhi6ZtrrXKu
	MFltMYXg3w+3a885zYPxgErAoyAuxhZlAWHhHvtfxmBqMkpLsQNwvq33mzoo/zYf
	ddpTw9oHRbw0TA56pqexgD7hby27wS+tmB8F063pJA8VckJQxnWd4t5mj+U6SSq7
	/FKCREiwe0cLiT0UspguT3vViRy2ep27MetZ8SEDXZrR8FAb7fMZe6tNo6oaHat3
	BpudGp/u1Oc8b5xrfI/IUHIWiJt4aR35xPEU5ilqqnDsG0PSFU1Bhp1jXVG/rj34
	GunL2imX3CToxGDKVWX+w==
X-ME-Sender: <xms:UPHKafFE0qwij2QkS6KW3kxVe6bgi4lL114HYT-zqy6UTCsLDxQdKQ>
    <xme:UPHKaenkcQovwy0nvI1rknRKayJOq9m75vI-z17E02ID4qGNsOMi3EEw-iTtyTvu0
    VUZgi76-AKfT5r0HTL3qE5W-Tb3MArQddhnxWQ6RdfBEJJH2ZeZZDo>
X-ME-Received: <xmr:UPHKaTapN8Z8Pi7p33Nyo1Scg_ooQ9cV3GUkHaTDkZDwPQ7R-0jKYxfGoC-6Ba_yzfoI8GFYkKqAbuu3j40EAaxz4bsHrmLaqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhgrtghkmhgrnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuh
    hssehutghlrgdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UPHKaTH-MMiBNX5uEXU3J233MwlKBGNqR92L2p86JJBms0th_-VaeA>
    <xmx:UPHKaUIVHVyOWMlLxWRLcsD5TMUKI9Kfedx_LwpKTw3acc-TVSj69A>
    <xmx:UPHKaeO4oIA10hi_ZJcz8emuFHT6ZTkmlCjgCrSmmze43tnKsrGrLA>
    <xmx:UPHKaUkGqel0cgH6hensbgZdVDLslvC-pZWIZL9-47mSPra_nUgFqA>
    <xmx:UPHKaUxaIIoN8LprPw_VyI75MgmoDPLfHH0Vi92nIjhzMwdLh6Z2yiHj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 17:55:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  christian.couder@gmail.com,  jackmanb@google.com,  Linus Arver
 <linus@ucla.edu>
Subject: Re: [PATCH 2/2] doc: interpret-trailers: explain key format
In-Reply-To: <doc_int-tr_not_rfc.535@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 30 Mar 2026
	23:11:33 +0200")
References: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
	<CV_doc_int-tr_key_format.533@msgid.xyz>
	<doc_int-tr_not_rfc.535@msgid.xyz>
Date: Mon, 30 Mar 2026 14:55:27 -0700
Message-ID: <xmqqh5px6kz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> A trailer key must consist of ASCII alphanumeric characters and
> hyphens *only*. Let’s document it explicitly instead of relying on
> readers being conservative and painting their trailers by numbers
> (by the documentation examples).

"paint"?  I am not sure what the latter half of the above paragraph
wants to say, even though I do agree that being explicit about the
allowed characters is a good idea.

> The previous commit for “key–value pairs” allows us to segue right into
> describing these lines as consisting of a key and a value, which is our
> opening to describing the key format.

And it is a good place to remedy the issue I raised for the previous
step as well ;-)

> Just like *trailer* we emphasize these two first standalone word
> mentions.

Again, I have no idea what "these two first standalone word" wants
to refer to.  It is not even clear to me if it refers to a single
thing, or two things---the verb "mentions" hints that the subject of
the sentence must be plural, but I cannot tell what two things you
are referring to.

> diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
> index e7c1f821619..92d9c95f9d2 100644
> --- a/Documentation/git-interpret-trailers.adoc
> +++ b/Documentation/git-interpret-trailers.adoc
> @@ -27,7 +27,10 @@ Signed-off-by: Alice <alice@example.com>
>  Signed-off-by: Bob <bob@example.com>
>  ------------------------------------------------
>  
> -the last two lines starting with `Signed-off-by` are trailers.
> +the last two lines starting with `Signed-off-by` are trailers. These two
> +trailers have the _key_ `Signed-off-by` and a _value_ (Alice and Bob).

Remedy the loss of "e-mail like" by ending the above sentence more like:

    ... and Bob), with a colon appended at the end of the key.

> +The key must consist of only ASCII alphanumeric characters and hyphens
> +(`-`). The hyphens serve as interword separators.

The first sentence is a very much welcome addition.  I however doubt
that the last sentence is necessary or beneficial, as "SignedOffBy"
is a perfectly fine key to be used for a trailer if a project
prefers (not this project, though).  I would not object to

    The hyphens can be used as inter-word separators.

or

    The hyphens can be used as inter-word separators, if you want.

but any expression that can be misinterpreted that the document
strongly suggests projects and communities to adopt the "hyphen as
inter-word separator" convention is not very welcome.

Thanks.
