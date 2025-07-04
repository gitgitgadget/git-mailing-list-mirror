Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B1199FBA
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751661806; cv=none; b=Q8RkuMZkgpbI2BS5QFY0DU8kdoJQJ7mVkOG2rd5ZhJwTQN1dkhuQ61QsuY6vkU0CiIzSSnlzW1lnOPKGdZDL7srAoZmckhm4DKtE9TULvtYVJD9pTrY0So/Z5tvEvvOK25J9KfsKaDeAyXD+sr+xUNTBJ18f9Rs2yb9gZUZtSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751661806; c=relaxed/simple;
	bh=wQSHHjIZvTd2QO2hC5U5rsdcfjb5Uvu/A6qg3hoQxn0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OpfWNcrANw1ieSEluE7DcbnNkOjDL4P/v24NdhaK73QtbR2K92NzTLO8CsD8H4HFG6ZWYWut3H4c2KgasX/pfG18bF62//aMHtrfl278DOknCEDF7rteJH8WXt+oPSeQXOlSWeluG7k2GBAsiwsDP1ROZaOiB5ATju4vqnLlPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oqM88p/y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kpy0RB4X; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oqM88p/y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kpy0RB4X"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F49BEC0B64;
	Fri,  4 Jul 2025 16:43:23 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 04 Jul 2025 16:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751661803;
	 x=1751748203; bh=szBSldWoNfy2GS4Z31hMZhKElDdtz1PcnspmJ2SW61U=; b=
	oqM88p/ye9d+jaS46PSovQfVOa/PJru091zK+iBg90BhwNrrx785OAM3/xPDLGnY
	SXvA1uHuMR6/XhvvnrGtItwX/q6PQhriGH1QBymFiO2BPW7Td5QmbjNDsdkqWElC
	N59zhYhiOvVr3BW4nZKBUj8mHYoTJAM3ZTHMcYwfc8hQEesGI2OHl18Brb4qtXrb
	68GGMFrR/PcTo99Yk6q7uRbO5s169ZeRoqUHXVWiI8HrTDSc/bt4x9/VHdMbmb48
	W41e/JaKc1hYgXF2zdxGJqxqFqcyFAPVON3t+U6HGvioPisXN9eluLGWyTwmwQGJ
	TsHjJbgHApBJuUxiJUKr5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751661803; x=
	1751748203; bh=szBSldWoNfy2GS4Z31hMZhKElDdtz1PcnspmJ2SW61U=; b=K
	py0RB4XiQyWts0+uvYk5Ugl0ClJAKTG4ixNWHtBlmpCixTmnTQHPzVGEVtFo+pCH
	u9VtbXuE8dD+AE9BZVd/Kp4sssz+TYvXt4iA9yW3qxim2E3xe4Zx8JyrTHcP2qOH
	lncOod+Ob4GDvBftmmXePLZKQFroNb/I/JLZL9OQJ/hkIz9mpbi6m8fUo2EXO/Wa
	He2tu4gNechnjSKxFRAbXv/Qsask2vbJmjnUZp3BnMyptxCWT42MrrzyBzWVmGhU
	PbsfrpdlUBSyw5wy9KGHkqGDYURFcL+VJmkEAXe2aC2a9hegCBTikhhqs8Nr1YJa
	2sNhy0b1AQm7d7KoMF/cg==
X-ME-Sender: <xms:6zxoaOyVArp-KJAhtFltDU21WlNI9HSsc4_Dh6O9-9Ty2wVZKrLL0JU>
    <xme:6zxoaKT5UauJUdHNHSwapMn_Ke2hn6ZBgHHzAIyovyF3mROClKKRElMNxYGBf0ep9
    Gb5OB5_m7QT1QFBPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6zxoaAX7wOrqICtA9BibzWjk9DE_aJpAZmgrHbIa9AZ9MEAqrjMhwQ>
    <xmx:6zxoaEjLMFmvpGtkYCpFSs-1_TkcEPP-GGy72qCKjCo3tmKut3H6mQ>
    <xmx:6zxoaAACDePSFnKMp-94DcrL-vHbNv4GJEjRAgVd2Rx1ZBDG9reEiQ>
    <xmx:6zxoaFJ2PLVNXkBxRot4-R6ZJYIGT3RB_hH3jP8T51Qck8T4vkBJXQ>
    <xmx:6zxoaDh1Ssxlt8tqkPaFRy6hj9QGNzOikaWxQZGS2RFEGI7X88qL7ESl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5FE591EA0066; Fri,  4 Jul 2025 16:43:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6a27cb3eb86664ec
Date: Fri, 04 Jul 2025 22:43:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <bc18712a-8f72-4827-b47f-afac69ea6fa0@app.fastmail.com>
In-Reply-To: 
 <d54e297567ac8f3009daa8fdf3de158338b2b700.1749373787.git.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
 <d54e297567ac8f3009daa8fdf3de158338b2b700.1749373787.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 7/9] doc: git-log: convert pretty formats to new doc format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025, at 11:09, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> - Use _<placeholder>_ instead of <placeholder> in the description
> - Use `backticks` for keywords and more complex option
> descriptions. The new rendering engine will apply synopsis rules to
> these spans.
>
> For all the formats in the form of %(foo), the formatting needs to be
> heavier because we not want the parentheses to be rendered as syntax
> elements,but as keywords, i.e. we need to circumvent the syntax highli=
ghting

nit: s/elements,but/elements, but/

> -** 'prefix=3D<value>': Shown before the list of ref names.  Defaults =
to
> "{nbsp}`(`".
> -** 'suffix=3D<value>': Shown after the list of ref names.  Defaults to
> "`)`".
> -** 'separator=3D<value>': Shown between ref names.  Defaults to
> "`,`{nbsp}".
> -** 'pointer=3D<value>': Shown between HEAD and the branch it points t=
o,
> if any.
> -		      Defaults to "{nbsp}`->`{nbsp}".
> -** 'tag=3D<value>': Shown before tag names. Defaults to "`tag:`{nbsp}=
".
> +** `prefix=3D<value>`: Shown before the list of ref names.  Defaults =
to
> "{nbsp}+(+".
> +** `suffix=3D<value>`: Shown after the list of ref names.  Defaults to
> "+)+".
> +** `separator=3D<value>`: Shown between ref names.  Defaults to
> "+,+{nbsp}".
> +** `pointer=3D<value>`: Shown between HEAD and the branch it points t=
o,
> if any.
> +		      Defaults to "{nbsp}+->+{nbsp}".

`+->+` gets rendered as `+=E2=86=92+` in the HTMl output.
`Documentation/doc-diff` shows the same.

Has using `=E2=90=A3` to denote SP in verbatim code blocks been consider=
ed
by anyone?

> +** `tag=3D<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}=
".
>
>  +
>  For example, to produce decorations with no wrapping
>  or tag annotations, and spaces as separators:
>  +
> -`%(decorate:prefix=3D,suffix=3D,tag=3D,separator=3D )`
> +++%(decorate:prefix=3D,suffix=3D,tag=3D,separator=3D )++
