Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E217993
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359864; cv=none; b=Kv0pSkbi1fEGLo2+Z87r/vlWkMrAF3PQxs0q3+2wLBljmvA3gW0ItW4Z0ykYUJgbVP1RGB2d1a4f2v6/KsSmDtWqTx5o/KKeXcZLSyTkEqaGjUjQTX7t+Xf9pyhemOXLTZqp0aacEUyv87oKMBeSDMQaJlZDx6si6a/0lZP9aro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359864; c=relaxed/simple;
	bh=I7izJLzXtSiET4cgK7OvSgzGGMaENrHy5/o33zPIqeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUGp/qTtx6jP8M9WxWXPUgWESQ0BoVIRWv8muKbKD85WX9KPoZdZ7rGWSKgcZR/XH1DtRcdnKLB5m8LZ08EeLryRGsd8/404dFMTs42iW5D/O4OYm1hab9F0YD7ZmxtNa/ehcWtJYJ57pQgr5i985BCQGDHRaGtlr6EpUvBymC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ySEIjCae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PSTEUPVv; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ySEIjCae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PSTEUPVv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50E7A7A0054;
	Tue, 17 Feb 2026 15:24:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 15:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771359862; x=1771446262; bh=yFGcr2J/W3
	hdgnhVRSmJLmYEko/uhjENYhdYrNW2nGM=; b=ySEIjCaeYb15LsH2HV4svaHpf2
	MKCospgCSKh3MWisIXyuUMwTJ1oq9M/wDRqcqRcFmkjV04EECKIsKBEwSb7yyfX8
	uZ7V//Lgemk2NIHcZLMVR11BGYRYxabUo8akV+njTgVSPYP8Tu8BYIemD7yz4BeP
	npzwmcPfUQvweZQfvRJAN/JVZMhx2bP5qdkbDl+rHdYGKv3iXPRxlvMIlBPYIqMk
	ZGOXizu40B1eNemCKpN921IcAbZCw7qo+MjcrY16xvrHAQBtMM6C6P3rywmDHOnm
	DE7ys+WxtSGhjKYrB6KcotNfdBxneO18j/CIvjbz3a09uNO0XL1QQkeRWehQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771359862; x=1771446262; bh=yFGcr2J/W3hdgnhVRSmJLmYEko/uhjENYhd
	YrNW2nGM=; b=PSTEUPVv+xOQbQIpHRnTzxYJijjs9m09S5vD5A/cwUbLliUGGMd
	ANGObjAYz8+EWPy6Y8tH0auDz0UBPnRBIrRkWLgaLCSAG++01YrUdrcPH5XCj3Yp
	Zta/Gg/uM8SIOlYVSfTFfDZPOXb+O2ZPnLZGMrBJKm6jJvbJV3joIaTCtnvp6aOE
	/XM8ZmTbB+/LUsoZnQ5kQJee0cn2x2BjZlEqQMTa+E1APr4MMIj8kxfvPErENTtz
	1u0DjGIR5MBhJR419ZPyhSF8DVIuNtFnvMEFaOb+Q0NGb8oXU81ceLxYDuEF4JJY
	EKaw3tY6AUx5Wlf8p3RW6A7ORZO/3PnEUZg==
X-ME-Sender: <xms:dc6UadI5LM_2dl8ksq6gX97A1yeZTVswtHMUNIQBtfVGO2mtpeA2Kg>
    <xme:dc6UaZ4Z1cHAazPs1Av4W4nGa2fVsFfxrqIWjmZ4xuEYuuDmJnzOwtIqnG33Mpyex
    JrQZulPnYjt-zycQF3o0L-DcT5OdYaz9mWoGQvy79i3033F4KWL6FQ>
X-ME-Received: <xmr:dc6UaR37ly2EJVuMbl2QSt4gW4Julu_LGbzBb8216HHfqYBEi4Go37LdbGkLWAwu8fwlNnVJBdyfvvL-UQeXwlCdDKkCCnB-vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dc6UafdvFqh6SGznjEWll1o-hUEUQqr2ElKt0Wi16YZlp-glwA74Ww>
    <xmx:dc6UaXeapyLvvTvDXE4duOHbyNCEtvfFsk6Pl6AksF1Lul4VlbhWew>
    <xmx:dc6UaayKG9nuEJF5-9KfCghyhq9LAeXyK8v4r0QRIerlgyqzHnQWuQ>
    <xmx:dc6UaW8BkLytL8UiD44WlMzPValDTFgMM64Iqnog-60FHO7qCO41KA>
    <xmx:ds6UacGJWjf9t5UXxszaI2ZMBBFxIA1Ad9-Z6sz5RlcRUTCI3eC5YQVJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 15:24:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Evan Martin <evan.martin@gmail.com>
Subject: Re: [PATCH v4] meson: regenerate config-list.h when Documentation
 changes
In-Reply-To: <CALnO6CAGfd2orSzjvxfAYx=xBnB=QdOwT-f5g0pQrcxO_19BGQ@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 17 Feb 2026 08:28:10 -0500")
References: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
	<9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
	<aZQSf9yaNa693IFF@pks.im>
	<CALnO6CAGfd2orSzjvxfAYx=xBnB=QdOwT-f5g0pQrcxO_19BGQ@mail.gmail.com>
Date: Tue, 17 Feb 2026 12:24:19 -0800
Message-ID: <xmqq4infazkc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

>> > +     for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
>> > +             "$SOURCE_DIR"/Documentation/config/*.adoc
>> > +     do
>> > +             printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/g')"
>>
>> Tiny nit: can't we simplify this to "$(echo "$doc" | sed ...)"?
>
> Given how unportable echo is [1], I'd prefer to keep printf.
>
> [1]: https://github.com/benknoble/echocho, for one. If the doc started
> with "-e" for example the results might be unreliable.

To cause trouble, wouldn't it be necessary for "$doc" to be exactly
"-e", not "started with"?

And when does $SOURCE_DIR begin with "-e" anyway?  It sounds more or
less academic irrelevancy.

Whatn I am more curious about is the "#"s and spaces being the only
bytes that needs quoting.  As SOURCE_DIR pretty much under end-user's
control (otherwise you wouldn't be worried about it starting with -e),
wouldn't we have other problematic bytes we need to worry about?

