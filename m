Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3C1DEFD4
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639074; cv=none; b=e0nGO17bXIjAU2pGndiWbri+WyRitkkEHnZOkpC2ihF0fLfNFqwfPT4q0SKZs7DOIn+H7J3w6thu4437gCs5qG43XIQf4QbLxVKISvsShqkku4/RtU4FU6uJdBLb0X5PuBZOOyoJqePnfc+C3GQq0rtY4CfKDwZqksbjeHtb5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639074; c=relaxed/simple;
	bh=XT318qIMZ6MA26lTbQEcnqX6MLP/yfjsEQbyNhmw3vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NPeOG1097v6JbrUfD2WzFiyBoPKGhmUkW8Un92z1eIMdN998qoS+Zk00+9I6jLIUtQFjH2yLfqYwnr7FxXrf4Fo3kvIlO2tLuju7SKnlFnK7oSDMybT3QlJrXu8NPieZUlZyZHCcQlrMSO4KWa+ZvT5vRJ1Gqc4h3mbTRID+rQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jKAK0l2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3D3wwSKj; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jKAK0l2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3D3wwSKj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 177B425401A3;
	Mon, 10 Mar 2025 16:37:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 10 Mar 2025 16:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741639070; x=1741725470; bh=zdMAmEuVkA
	OFq7pZaRb0qaxa3gMPCg5rVaK3S7iOpqY=; b=jKAK0l2YigskG5+DrQsERB7j7z
	J/6DrLKMQzeqAO4W6ru23AVwofKf9vGdbs6HDTwo+vQ5E7Dxc0/1etqEZ2ImtL3R
	ttlnms1lR6MaNz1aGmAbcWw/yZAqf2Euolxg547trOlA5TidM1D8jSSrI50pMmFn
	9he3XJ2MbkIlM8FCO1r9kNPrTgkdukjF1bMGI3ZBlh8A+zm5rIz3kh5eSyGP7Zxf
	d33aEYMNUmDFQ/ouOGakOalxzcYhuz73v5AF7ySljUq3COcD+1SA33avIhD4H9Rh
	TQRf2NBWKlbZX9IVIsDPzQG42ch94M+M/vsYx36zWoZezDBXbMpokFNJRQVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741639070; x=1741725470; bh=zdMAmEuVkAOFq7pZaRb0qaxa3gMPCg5rVaK
	3S7iOpqY=; b=3D3wwSKjba9qPetaoRux8JRlLxB+P3ES7eIxWxNRv210xVVejMq
	vZ72rawFhBiHiDLwQYdJiS9dZXBVXHHUnnG4pSReqBE+sU4XcXZOSnIpk+0iBzpz
	hfx/qz8LMHyF9UiT/ioFXGUir/7VRJuE/Cn/HL6O5UP8mBbc383eGGU7xmwUvk7p
	SB8EUig/Rk0xy2HqrOSX3UYdGiG3BnmxQjtFSaC0e2wGfPjSSRh5eB/IJBsnNJzh
	o162rU2pkLoLxzMx7J0o76jVIY0Xx/oC+U/YasdGm6bWhRpq/+6LCcUH1brtu2tV
	dxAnb9RZZwQcZH0Gz3TVGQ9599kXKXNbGgg==
X-ME-Sender: <xms:nk3PZ6SbcTd4Fs43_Qhk-7DuiFUPpFhcpY1aU9b57XuCRnXJ2-hsZg>
    <xme:nk3PZ_y4WqiwvhfUkFWUqSGrLvE60J2wK2lZxjpXD34YhOopaLaYOqyBE-n6Ucrrf
    qAVgzBgQU2zXev1uA>
X-ME-Received: <xmr:nk3PZ32DgzgNOt84Z4G59zcN1zAP_4m9j34cLaN6WHdnNZ36khuHxUz6LLGJj24B8hoRtBOSLtUCYWbM2Gq00yWknBP4q11vMyQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:nk3PZ2C2QBrvxvYLk8DWt0KO2i9BOE6V5A35CDk2lLHSfK2Z-Qaa_g>
    <xmx:nk3PZzirK-7SySYAve5d8UWQt-G8NZpzhs1FNnKKTfaDuq2YJoBjYw>
    <xmx:nk3PZyrT8owrIZP6vpfQnFklgT71kX1YAL2mYKiZBAAxklbL1E3tYw>
    <xmx:nk3PZ2g2cba-wU-cRVXv2XMTblZxWn9MpA8uBQqyPK0XfDpyAx_YfA>
    <xmx:nk3PZ5ZZKHnl33_u1snftpK5mdJwrF0vAEUbI8oJ4TyHmOjrakikwAnm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:37:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
In-Reply-To: <20250310192829.661692-1-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 10 Mar 2025 14:28:25 -0500")
References: <20250310192829.661692-1-jltobler@gmail.com>
Date: Mon, 10 Mar 2025 13:37:48 -0700
Message-ID: <xmqq34fk7hb7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>         ?<oid> [SP <token>=<value>]... LF
>
> where values containing LF or SP are printed in a token specific fashion
> so that the resulting encoded value does not contain either of these two
> problematic bytes. For example, missing object paths are quoted in the C
> style so they contain LF or SP.

"so" -> "when"???

> To make machine parsing easier, this series introduces a NUL-delimited
> output mode for git-rev-list(1) via a `-z` option following a suggestion
> from Junio in a previous thread[1]. In this mode, instead of LF, each
> object is delimited with two NUL bytes and any object metadata is
> separated with a single NUL byte. Examples:
>
>         <oid> NUL NUL
>         <oid> [NUL <path>] NUL NUL

Why do we need double-NUL in the above two cases?

>         ?<oid> [NUL <token>=<value>]... NUL NUL

This one I understand; we could do without double-NUL and take the
lack of "=" in the token after NUL termination as the sign that the
previous record ended, though, to avoid double-NUL while keeping the
format extensible.

As this topic is designing essentially a new and machine parseable
format, we could even unify all three formats into one.  For example,
the format could be like this:

	<oid> NUL [<attr>=<value> NUL]...

where

 (1) A record ends when a new record begins.

 (2) The beginning of a new record is signaled by <oid> that is all
     hexadecimal and does not have any '=' in it.

 (3) The traditional "rev-list --objects" output that gives path in
     addition to the object name uses "path" as the <attr> name,
     i.e. such a record looks like "<oid> NUL path=<path> NUL".

 (4) The traditional "rev-list --missing" output loses the leading
     "?"; it is replaced by "missing" as the <attr> name, i.e. such
     a record may look like "<oid> NUL missing=yes NUL..." together
     with other "<token>=<value> NUL" pairs appended as needed at
     the end.

Hmm?
