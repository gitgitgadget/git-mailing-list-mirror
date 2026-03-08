Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5EF31353C
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773000687; cv=none; b=C5csPK+GGe5xTYvrp9HlvVjZvSYN7xM7du2qJYC7emlJaiQFl9Ogwj+r4YTbBTzHczPd6Zysj6MbVFLQw/7QJvpzL2cOUp7IIVYUZg1BNYPaPjefpdFIyLdK58oMGga1Gvb7BqOjsGlLtEc/nCfazCrjPukuTYXEBm2C8W3a8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773000687; c=relaxed/simple;
	bh=nIbsquxKrczYJXv069deMbhRp9udP0w/M4FT8pZhLuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D1JtjPXynjPRyke742uwLuZTdkbS5EuCXyswS9bqvTTJs2uZs/pwZUp5q4xwjX5l+jMHMNfZZOEjgMKl4Gd2UckjtbWd9VGaOXrMVpFA19Xis3YZp/6OOsZHybkilG/mKgKUvnLikh5wP87aWMmBUUwy7SdaGpU90M2GfheoIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RXjy9oEt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dncz1iLZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RXjy9oEt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dncz1iLZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C041140002C;
	Sun,  8 Mar 2026 16:11:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 08 Mar 2026 16:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773000684; x=1773087084; bh=Rar28FtA9D
	6xxQCN4p/qV7rI9jWuhNvyWV/+VVKXwDM=; b=RXjy9oEtaIAGbq75DIEAxdWe7l
	adJ5muDbWEAIbvVvtr7QWNT35DTytUC1gZTEcEMr1Gitcvnxj1L8VS4LrhxMt4Ki
	8Ioy385pKaHFzUtcKgDc6IOJjgng2A1hKEz9rSEQq6xA1Em/JwNvA81OnIpW9doA
	PbgnekoE47zma6G3xGw2d8MGDX0H0OfbvzhokyIpXBVlgaiPWHU3qWnfVMpavx6n
	m2QWxrdQoggw+LZkScVVkxPZ/arqmISuedB0dPBk5wBufNhwZOQjlkWxiaIOdiQz
	SsLkzkT0SmXcf17Xyv1ZneAmvZaNH5VuRenQQX4zxY3go2Cp2RBdAEbjrAIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773000684; x=1773087084; bh=Rar28FtA9D6xxQCN4p/qV7rI9jWuhNvyWV/
	+VVKXwDM=; b=Dncz1iLZH4TFEzPYuvZm/GQEDqAvX9oewm/h1iN6u/Drs+kYFzM
	rKWkFtm3SrsjrVgc6ACwugo1WrucT338KGE67RFpjkCzpZZhOjHHvnJkoBeYeC85
	QYph+CWfeRMmR4nJ6sLdyk3heZ3T119GI2kGu31jfxa6xB43I5rhMAYWM/4JkUu5
	4+wFStnVei8CP9gKu7FC3vS9mR3CzVDRxVkjeGSR9FhTYMjSSiOXftiZ8U0lDpIT
	ng+S2WHVePfHIBcsXNp64ReO+XWstvhxHjsASrAtT762VdusmY6JZhhYG3OxIBTS
	57fXIn3+6pLEMElUK3PMOBPbi7eA1lY+7HQ==
X-ME-Sender: <xms:7Netacm9JrMc5WD3-2ID_HOncQtgoNM1YwutQRUXqvl4XZmGz502Vw>
    <xme:7NetaTRcHwvOgTPojDTwBfwLsZXzC3EGBu5apw_4TQMRdHzn5VBO9apOVSB1lAxL9
    M0hboyUed_crpiIzLbn9JOHRLLhgJwHoiV7jWmixyH-G1jndnhUBA>
X-ME-Received: <xmr:7NetaYACnzWdO_XvNcnzF5xAr7ovsjx4UT3QbTXO61ofCSUgrDjMM8gn3dUIw1S4xGE2XgMlF7ewM1Oc-NBndd9hPtSvRpo2yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeefleessggr
    rhhrohhithdrshhhpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7NetaSSUvef_JFEoSbvy8ogcvPA72fw4ZfubpnoLgIh62AKNyvB0bA>
    <xmx:7NetaermYTJxIi2Ksw6i1iwyADOHf7m78FWAeDP7bK_lXXMRCW_m-A>
    <xmx:7NetacwObz9OxGZOyh8E5NArGeHAy_boxOzJQ8w8e3EWQsjNs2FyUg>
    <xmx:7NetabKed8OedA9x-B5l2v-0l3wNqPadGVDXF4mcK_OIejufPRQdVA>
    <xmx:7NetaaN04RTkQnGrCkp4Czm8b4qvE82l8hiz_rzIvV6DA4SuRxVcSUKA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 16:11:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] parseopt: add subcommand autocorrection
In-Reply-To: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Sun, 8 Mar 2026 21:17:20 +0900")
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Sun, 08 Mar 2026 13:11:22 -0700
Message-ID: <xmqqo6ky9j4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> Git currently provides auto-correction for builtins and aliases, but
> lacks this functionality for subcommands parsed via the parse-options
> API. Subcommands are also commands, and typos will occur, too. Like:
>
> 	git remote add-rul
>
> So, this series introduces subcommand auto-correction.
>
> Currently, builtins with mandatory subcommands enable autocorrection by
> default. However, those using PARSE_OPT_SUBCOMMAND_OPTIONAL skip it to
> avoid treating valid unknown arguments as mistyped subcommands.

This is a bit confusing as it describes the behavior introduced by
this series rather than the state of the codebase before these
patches.  Since subcommand autocorrection doesn't exist yet, it
would be clearer to phrase this as describing your implementation
choices. Perhaps:

    By default, this implementation enables autocorrection for
    builtins with mandatory subcommands. However, for those using
    PARSE_OPT_SUBCOMMAND_OPTIONAL, autocorrection is skipped to
    avoid misinterpreting legitimate unknown arguments as mistyped
    subcommands.

or something, perhaps?
