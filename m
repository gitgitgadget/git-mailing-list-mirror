Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A1346A14
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838996; cv=none; b=AEuG0F/neDinA47s6D8CRl/660LWYS6qC3lt71xBmtJBu4V2L4KuT7JnbCp+GMnPOd0R8xGBGhYyk14+YA2p0fkDKS/Ohu9WqxBaZtIBXzcfZQmRwMDO694H4dqVnIGOa593cj+NJolXigw3AKW6jkPbAlJOt5xjzcu2vVvlXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838996; c=relaxed/simple;
	bh=5XuaLjtpqxAZd8dKoHGok8H+A+n/ExmUUNSteKQY0NI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HnTVT3Je6imfJOXYZ93iVzM0Bq480A+iJZKTME2q3LLueC2XbDry9BAGs/CqT9zlDJ25FULhwSKDgDbky817ezaBaoDA19Nrmqli+xsDxrsKnFXXtdkYGj4kOAz7whIlss1HKJH/mhdXGJjzH7yVN7djQ6v1K5W+NvsnK85sKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pNMV6TVg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ajUFIQR9; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pNMV6TVg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ajUFIQR9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D5F75EC0567;
	Mon, 23 Feb 2026 04:29:53 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 04:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771838993;
	 x=1771925393; bh=3nJR7RSuxIju7Ro6fpXK8WO4Pzf+jh8ek4WPfg63EWk=; b=
	pNMV6TVgANhmrLDOpHL6ksIFkEg7TvY9y2d0tVvx+m8neN7DZz5SH6MizlrQxsy9
	QkviEDShlU428fgTsPjTajKXavXEGh7Huu7fXiroRMxCUPwzePvbiTYm3lNGJsQ2
	Y0SFvv+brcjC4p8tkpScdHtZUgytEhyCRQPHaRnQ21XZ71N2edgna8Vzxjd6PE0L
	XM72SIDYFaYVc+lB91xkwhw3nszGUI2jMQ/32y6aCjPnFpL1bwGtqKF2zLsNAz2z
	go2PJV8vCLLLIVisOuRCRV3O7OUsR+ck4LDKs/KFPOc6IkM9oGHgw5x/eLA79gEP
	pjvkiw6iO0ncXLB2C442iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771838993; x=
	1771925393; bh=3nJR7RSuxIju7Ro6fpXK8WO4Pzf+jh8ek4WPfg63EWk=; b=a
	jUFIQR9QTnpVBdC1XOFYZdLALrvMHPph8UuELh8DaRTgX6zvsFvuvJesiC05YjrS
	M5H43IuNbGMgaUWeWZ9vyGT8YzrCsO3exjQudx2OxsIg9mh9ab4chsu0mSMc9bvq
	b3bH38Gf/EYpirLE+45kLQXJnTTJy0HvmD+rzBBPeanDXuIZcUkSXodwNECfSQJv
	6mgV+Jy3c6CoYHvrIO3D7reTeQYlz5X30Hnvov/Of8IsPQCUyyakk0IFWTYK3wrF
	cjkjqKqFmouLyuRfqBelZL823ANbxbuvg6hcq9UpC+bdx/Mjab6RmIuEpFcTzBbA
	vFq/lezLOiDyTSfuXX9Kw==
X-ME-Sender: <xms:ER6caaGbeh4HUmqSPyi6ahR0m5hv5vH3lsZJDuOOsaZuyiHFFplzZIM>
    <xme:ER6caWK9ARR7wPuT_Rtv9UF5AzMl92tKOBu_4chluLNQSh2D70t43YmonxKWAsj5B
    CczwmJz2FJ3cLMn24CNz0QkcRqoMtHt_iyePDjhGe_eIqznZ3diJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeikeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ER6cafwns0NuFEV4cq6m2RC8MHumlfl9zai_QFm9k5h5wvTANnXx8w>
    <xmx:ER6caQnecRF67UjPqQNX3LJSljmWsDcrjdHMQ9Fd4zkW47XMn79gGA>
    <xmx:ER6caQlvuZ_VYmwlcyg2VJaOXTGxJwIeY_ZMdzdHXbFAbLy21X9gcw>
    <xmx:ER6caax7MlWlidbjbJsVhog9ksG-BOXdpetNgRqoefeBKZY_D_w5HQ>
    <xmx:ER6cafjKHs5ubQkRQsD59nSUPi3Uvva7oZoP1w_RebQ-SgIe4KMaHMvt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 78F001EA006B; Mon, 23 Feb 2026 04:29:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdFosU1OfSzV
Date: Mon, 23 Feb 2026 10:29:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jonatan Holmgren" <jonatan@jontes.page>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <112cccfd-ee04-4c23-bc5e-fd269ebc6c1f@app.fastmail.com>
In-Reply-To: <20260210183110.1151072-3-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260210183110.1151072-1-jonatan@jontes.page>
 <20260210183110.1151072-3-jonatan@jontes.page>
Subject: Re: [PATCH v2 2/2] alias: support non-alphanumeric names via subsection syntax
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026, at 19:31, Jonatan Holmgren wrote:
> [snip]
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
> ---
>  Documentation/config/alias.adoc | 44 +++++++++++++++++++++-----
>  alias.c                         | 45 ++++++++++++++++++++++-----
>  help.c                          | 12 +++++--
>  t/t0014-alias.sh                | 55 +++++++++++++++++++++++++++++++++
>  4 files changed, 137 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/config/alias.adoc
> b/Documentation/config/alias.adoc
> index 80ce17d2de..17a548cd64 100644
> --- a/Documentation/config/alias.adoc
> +++ b/Documentation/config/alias.adoc
>[snip]
> +# With subsection (allows UTF-8 and special characters)
> +[alias "h=C3=A4mta"]
> +    command =3D fetch
> +[alias "g=C3=B6mma"]
> +    command =3D stash
> +----
> ++
> +E.g. after defining `alias.last =3D cat-file commit HEAD`, the invoca=
tion
> +`git last` is equivalent to `git cat-file commit HEAD`. To avoid
> +confusion and troubles with script usage, aliases that
> +hide existing Git commands are ignored except for deprecated
> +commands.  Arguments are split by
> +spaces, the usual shell quoting and escaping are supported.
> +A quote pair or a backslash can be used to quote them.
>  +
>  Note that the first word of an alias does not necessarily have to be a

The HTML output shows the list continuation character (+).

    + Note that the first word of an alias does not ...

>  command. It can be a command-line option that will be passed into the

And there are two more outside this context which I suspect are knock-on=
s?

    + If the alias expansion is prefixed ..

    ...

    + * Shell commands will be executed ...

See `Documentation/doc-diff master next`.

=E2=80=A2 master: 7c02d39f (The 6th batch, 2026-02-20)
=E2=80=A2 next: 4a7958ca (Sync with 'master', 2026-02-20)

> diff --git a/alias.c b/alias.c
>[snip]
