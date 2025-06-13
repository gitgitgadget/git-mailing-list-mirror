Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA5275AE2
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816616; cv=none; b=nZ3KdpOPaC6VwYEzTJL/HtSB5wIWNMzrIdKgLeJ4pDyyXH0JF8mFBOFL32EWREDi7ck35ok2+I4at1lHWqs12zXDTcR3m2JmuGZo3lJRIiqzqw9KB5InwXZU8RtH30B1TAjJth+X7efpilfvkJ+7zLnYE+pzq6cHWqnk0bzzWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816616; c=relaxed/simple;
	bh=9wKhG2A38Y52VdzwCc+uuzr7Lw4jHLDsQs9J1uqoTcg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IOBT3Tdf9V4Qto1jLcgaRoufAyK+niBPMLyScvKX3XLBKKXOgWepe+iAIaEQa4U0FwUzH+pPL5O4Zg+EnyOZTT3ibbsg1gC9GwK8XJYjcKZQ73pr6TB6puMP2fXDuKPJdbbfnI460mrO9jkjDpifO6K9XTh7vYB/KjfGKls20Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ExuCqlSN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJtSfj4+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ExuCqlSN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJtSfj4+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D24601140178;
	Fri, 13 Jun 2025 08:10:13 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 13 Jun 2025 08:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749816613;
	 x=1749903013; bh=CNxplb2HtKmbR06aMKBc7PUYtL6TQNGXjOZCmE8zLTU=; b=
	ExuCqlSNEyMkmc813TvPOprEsnfl8gfia/DYm0LHhcsXana/mTxt5GgOVYknRiKb
	a4JWkO7EAJpCpA9F2/OMTqsOLyOql+dH9jwzzppwlCsb091F8yPiszBd0Jgq+hnR
	GdDQdqIy2FYl0PZKMcweqeRbwTet600o09SRY7awI1s41y61NCiT2HkBptl6JTb/
	euev/eJ3Y6fcshlBzhyG5fLk25buF5Z1emlSqrp5Hzw0lpFp/1rRHmS0k7E5HeSB
	sh0cDaGgJU8sXqAguaRwrKq8WgUJcGy82+GHrEjVPAtZZjR0kQzxBxdJmhjp+s5w
	djIh55ztVfx08oZ5UULdxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1749816613; x=1749903013; bh=C
	Nxplb2HtKmbR06aMKBc7PUYtL6TQNGXjOZCmE8zLTU=; b=aJtSfj4+9drjlSagi
	OYfyXHez+zFnGOi315MfhahNDWB/3aINDF4OL3ddTkJY2D3/wNVmlPUK5vLkgHCa
	2BrPa9s/cDugKSNgQpXXNRuqazRPKLc9xNhtvhxl+vxH7btl05cFcmHNjCr+eaMY
	8vdMUwNpezGwYk6sF/YXoMXMWUjMRxm30rnQRTTRdR8QnC2sBm0gLdb4WCh1GHLT
	NAsUy84IVQrcHbyENuTgu53bJy6Qqf0o8bYj83/ujXAzQ0gqlg9CCDRR0l+0bBp6
	Kzse8LFMuK0efuBYScu1iirya2i3+nksuwVemSsV/semfncUuumUGqCVBqMZoYeF
	QhFFQ==
X-ME-Sender: <xms:JRVMaHqHOCV_i-whK_QaSuERL7fZ37MyX36bzzR8qwPT95lYYxtgTb8>
    <xme:JRVMaBpnN5vo4-E97F9z-90jtbsEs2vfywiGTHNJkXB9pdKYeaPv_K-DZZdrSmXN7
    wCYqSRjTtBIlqPOtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudelhfefkeehtefg
    geefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JRVMaEOakGzIWK7ZqMCwfjp5aGw2_7wORIxf7XRb2fAye93SsrHioA>
    <xmx:JRVMaK5M0bgeTmHbk4YVq0ywiAfvcAKDVaE7l6vvLTitDpUorqTW0g>
    <xmx:JRVMaG6-rYwxComY5oozx9V_jQnKmv7oq-mjjdn0aYPFfk3qjQBGQQ>
    <xmx:JRVMaCiFX3EsX179hFYOPNSvBEgM-kq5zwhZy1_hTGoLCFu2UeM9mQ>
    <xmx:JRVMaDS6ClmhaNXOBLLsobXXFYvdawEg747mFXaTx4oedhULNEzlYm5w>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 90A651EA0064; Fri, 13 Jun 2025 08:10:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T405497cec795f91f
Date: Fri, 13 Jun 2025 14:09:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <deb4951a-5d1b-416d-bcad-5d675d8155cc@app.fastmail.com>
In-Reply-To: <20250612222537.2426059-3-gitster@pobox.com>
References: <20250612222537.2426059-1-gitster@pobox.com>
 <20250612222537.2426059-3-gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] merge/pull: extend merge.stat configuration variable to
 cover --compact-summary
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025, at 00:25, Junio C Hamano wrote:
> Extend it to be "Boolean or text", that takes false, true, or
> "compact", with the last one triggering the --compact-summary
> option introduced earlier.

Would it make sense to make `diffstat` an alias for `true`?  I=E2=80=99m=
 not
sure since you need to keep `true` anyway so you still have that
historical artifact (?)[1] of `true` meaning `diffstat`.

=E2=80=A0 1: In the sense of what was added first

Also

> "compact", with the last one triggering the --compact-summary
> option introduced earlier.

So `merge.stat` can be used instead of `--compact-summary`.  But now the
option does not mention `merge.stat`?

>  `merge.stat`::
> -	Whether to print the diffstat between `ORIG_HEAD` and the merge resu=
lt
> -	at the end of the merge.  True by default.
> +	What, if anything, to print between `ORIG_HEAD` and the merge result
> +	at the end of the merge.  Possible values are:
> ++
> +--
> +`false`;; Show nothing.
> +`true`;; Show `git diff --diffstat ORIG_HEAD`.
> +`compact`;; Show `git diff --compact-summary ORIG_HEAD`.

I can=E2=80=99t run `git diff --diffstat ORIG_HEAD`.  `--diffstat` is not
an option.

> +If this variable is left unspecified, it defaults to `true`.

I think this is simpler:

    Defaults to `true`.

There=E2=80=99s also several places in this doc which uses something sim=
ilar
judging by a search for =E2=80=9Cdefaults to=E2=80=9D.  Only exception is
`merge.renameLimit`:

    If not specified, defaults to
