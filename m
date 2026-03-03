Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C3332EBB
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531085; cv=none; b=XfznCFrqp5OuMEkm0BzFDVPpNJnbEc7JcVt3IkmBXIMX8RwC6i1lpWdbWvs4nDAnhGPT3HTBoFLL7sHe/bDk1mQ6h1FcKkP4c9Twf4+GG3rTLJuUOVEqR+WIKh4YZEecIf0H+3/HNz+FInuXyrCNspaV8HkqByipqSGBndEaf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531085; c=relaxed/simple;
	bh=/tVhURRoF/WtSLpoGpJPq+M1SRp5/knX2Q9l1bQPvCQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LuD3c2FdUADFXCQiG9kWA2VlQbWLmjE1MKKrJKHbK32WSGZV+qY+YDnR82MMGNw+Ce5VEo2jxS03ps47k2te28aJaYJQXw5kmWo6pZf8bcQmej5WY5kP7cGo666Lq2COZCv326d6J4HgAo/orZhooTJRrE+yk0l2ADlowcVd/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mc3D0G69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EID5rmrs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mc3D0G69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EID5rmrs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 584467A002B;
	Tue,  3 Mar 2026 04:44:43 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Mar 2026 04:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772531083;
	 x=1772617483; bh=P8dlf8LbTul0Aa+z2Fj2kt/LIq92fYFVTcvV20vR3VM=; b=
	mc3D0G69it6tngrbJBxCnIYneJ4cNUfMx5sjlL6sIDFNRJ/ZAGov+98VwvnUN5GA
	D2QAIPU+J10eM5Q8kBmrGF7ZInFkzmf39I4uF1RY6t5frUy5CpmGsjFGaU1+VKek
	Yoj3sYzUDa07bt7Eibc1A/T9JnSpRxlLmRN9Xs60XB3zHBzn5y1HxOv8uHO0P8+q
	SQFKTYfpv0mti+cvrLZ3NLuC+Fx5S9u7ur4HOl3fJK6GP5LqVp081tsVHT/nmM3g
	ZaCHjARaGuVFfLMND/TAritruFS/ppgnLag0JTYS+hQ+x8QoRpmHb5RdUwZTP9yx
	lfigZcjYH3jB8yNNPFHxYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772531083; x=
	1772617483; bh=P8dlf8LbTul0Aa+z2Fj2kt/LIq92fYFVTcvV20vR3VM=; b=E
	ID5rmrsiuMa5mU62TnPd+7573ck6DxG+DHMq5BjT/uD0wlshTRyZAKG9DDZDFFNK
	E7jh7oIPPhSTivLuw6IiAXhpjxpDp5RryBT2GihRi1XDtrRdY6gS3DAkWIb8IvaJ
	D8wd1d/qKCrGJOp+o3uoNh0ftPsSpIaUzPP2DDtwKEKqflSphX4HekOLToiDjcqc
	aYGTAZjN++03vOBeUW+MgS5r34Si5Ba47kxPSwxhbcUvFJ8c0OShYMhaf8E199dz
	CAfL+STnRO/1T/FsJI5WzxO9S+nfEFfxScu0Sfk5Yj00eJDA1RCt+9UeA28ECUui
	SDnb/sG7JXnzFPfQNZCLA==
X-ME-Sender: <xms:i62maYoQuX2a808mvFUzCBK9VEfzI61xGCdLqxbxKQ_ugVwZfcz7VWQ>
    <xme:i62maZfabpPz7doVzD-oELC8cm6TRyhoLI4d7hTwgNFHU9WX8LvpJ6CZjusms22jz
    I2TGRmd56bb5VCtLQMXF7fYO3fGCUtF7lkoiltwCUJ5sZBNo9i_goE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:i62maYUpeBzJvWnmgJ15hN2pbvKBvdUFzzfHYCf-oIYqpbndFO5V1A>
    <xmx:i62maV6bAJUeN3O46QSoNA2IGA_3QdZc1z3K-EJSxGOKVe3VBBUiCw>
    <xmx:i62maTpq9iE0wlM4EVcr1W8B7ACtmpQOr4GPJn-pLFFsMZSsnIAvXQ>
    <xmx:i62maYl1A6Irdd5ACbBegWwCMSVkSt3Cqc3XatQ56ZuFHUOjqayl7w>
    <xmx:i62maR3MUXUrdp7GPCzNBArB1UlgxgOhEMr1lNDvPy0mZCAJVRZJWkEz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E93B81EA006B; Tue,  3 Mar 2026 04:44:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEXdV5rI5xcc
Date: Tue, 03 Mar 2026 10:41:57 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jonatan Holmgren" <jonatan@jontes.page>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <7dc9d03d-61e1-4bd9-8998-0423214d1ffe@app.fastmail.com>
In-Reply-To: <20260226205339.1535482-2-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260226205339.1535482-1-jonatan@jontes.page>
 <20260226205339.1535482-2-jonatan@jontes.page>
Subject: Re: [PATCH v2 1/3] doc: fix list continuation in alias subsection example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 26, 2026, at 21:53, Jonatan Holmgren wrote:
> The example showing the equivalence between alias.last and
> alias.last.command was missing the list continuation marks (+
> between the shell session block and the following prose, leaving
> the paragraph detached from the list item in the rendered output.
>
> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
> ---
>  Documentation/config/alias.adoc | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
> index 115fdbb1e3..26949a0ccb 100644
> --- a/Documentation/config/alias.adoc
> +++ b/Documentation/config/alias.adoc
> @@ -30,13 +30,14 @@ Examples:
>  ----
>  +
>  With a Git alias defined, e.g.,
> -
> ++
>      $ git config --global alias.last "cat-file commit HEAD"
>      # Which is equivalent to
>      $ git config --global alias.last.command "cat-file commit HEAD"
> ++
> +`git last` is equivalent to `git cat-file commit HEAD`.
>

Missing list continuation.

> -`git last` is equivalent to `git cat-file commit HEAD`. To avoid
> -confusion and troubles with script usage, aliases that
> +To avoid confusion and troubles with script usage, aliases that
>  hide existing Git commands are ignored except for deprecated
>  commands.  Arguments are split by
>  spaces, the usual shell quoting and escaping are supported.
> --
> 2.53.0
