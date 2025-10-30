Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C735972
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834423; cv=none; b=M1zvJcJsLgY/rrOTrzCaU7qdEJMT64CyMqK7r1BmUrmHWzK0gTl77nLzw2Y047oLaDdne1h7DxF5EQXz3a3RJLFDNJdZYZMnr4G3TQERvS1PL6PPuVQbLWtb6L5sU5IH8weiSoyVTA2G8tC92+larApMA74fcSiT/EV7yCczEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834423; c=relaxed/simple;
	bh=rZcERrRNurb8BevFg8jLZO8YPXwZhDGgO2FctupMzYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IMVLkyfPyURyVodwPfJASk/ll4dKwwL39Bfh/7N+GqMDsofZxBsiRZsn29lcZyRuijXZj65frvzUYAF1Ma/vPImaPu/o73Yk2TtHJQ7g/pXsedD/dSyovD39qk++7ypgzB+Ne6fjDIxRiLQ50SHlfZtV0XjRwFoUsAia1zD2Y9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nbhiIXy5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqowVXzL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nbhiIXy5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqowVXzL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B575014001FD;
	Thu, 30 Oct 2025 10:27:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 10:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761834420; x=1761920820; bh=lrN4Re2jcd
	/gwcDJ6X+vo8Ny3i9sC4CjfmlaDxAtIiI=; b=nbhiIXy5aQaf+V7JIjcum5sJDg
	QVafR19VyjUOa0JCEjF2DjIORK9XKNGqNYZrKJZpzHf8hDtAlPsmQ7HGrqusTx56
	OubvE+264JB0EVxlN4uOOBt6x4QocsKnu/D6/zIJEpyzl8AT/VSA3H6pp8DlDgAE
	5m95u0J5TbZGJ5UALOfMxeYvwHElx608Sl93Mxv+ElFa1LocYR2OTuBGqOYGnkWO
	sX47djvP+3zYngqwT237TG2VosCglzet1X3cgEEqppmJWcpW3BE45NBrZRV2VRa1
	ssB1xRTtWrmHG+vUOdjSNQW7EckHVtoc8eb6yV/11CYcBSE0TrwXl7bg+xeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761834420; x=1761920820; bh=lrN4Re2jcd/gwcDJ6X+vo8Ny3i9sC4Cjfml
	aDxAtIiI=; b=eqowVXzLzfnPxmJiB7OvAgU4wU+r+ijeJ5C93Bc6IWTYyUysxj5
	LxdnadCrWUmyoOEMz5eYYTaS8uyV4H2XUoi4KtUclbCesxKNOTm4Xi+Z28EUC91I
	C6b3Qj33gJlnxpMJhMK0/P4OQliY035YwkgjS+C7hsbeVVgLsaqrQ/t6bAvtVZ5o
	VkUVe3GCUQbB/BHpK9cwF3quh+9uqjqRNFixBFSpEf1CKjNKxnP4nomQurveyeMK
	Sng0LdOxnldZnQ2YULRKXVR9W0sS2opRQ3qCHu+cLyuVxFMMIXFpRYxTXbrbY6HF
	urNObHOQLZDG29JhBKRrEZRpnf4DfBGVufg==
X-ME-Sender: <xms:tHUDaURHdD5ENurvhRkI_WnTXB4f-HABZPekkNssT5GJDsda89BaXw>
    <xme:tHUDaQ1rokiO1i25qkEr1tBY3fZmSLcPmIRBrh943Ks0dUqJLI8okQtleO53NPhnE
    -GOsGCe7GXS-2xrozcYMy4OoM1FQVzsTXvULGumnpBHEHLp5Ni8Qg>
X-ME-Received: <xmr:tHUDaYAA3mKpV0topRv6S1jn5hQXxYSmTDZ9DyWHpJAKAQ0fmRt4VCQ-Kf-aIHj7mWPb25qtwRxI_aF3OGk9TzZLllKyOGL1c1Af>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeikeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tHUDaUhU4nddobAPTxgip5ktKf5SFtRyRGw1QdTSvN2-nqmS2avhLA>
    <xmx:tHUDaSMhta2lEeLoOMLFKZx8kCiMAuWAFM74vRrOZDdfMPZjkQDavw>
    <xmx:tHUDac-L4HhCYrsLBBjFNQ60N-BjQdcdUdpLFoCRcQEndLBQrv2Zyg>
    <xmx:tHUDabfRzhxLn774NqgKa4cEv_XIOl7NpKrf_1mMCt0lMiyMUoDMGg>
    <xmx:tHUDafRiglA2qCqAf6ucdcKpXlxZcXAngTR55d5FErQau5nwOiG39yf2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 10:26:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 00/10] Xdiff cleanup part2
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Wed, 29 Oct 2025 22:19:38
	+0000")
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
Date: Thu, 30 Oct 2025 07:26:58 -0700
Message-ID: <xmqqcy6479e5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Added documentation about unambiguous types and FFI

Nicely written; a few footnote entries may be a bit too strict,
misleading, and may need rephrasing, though.  For example, we may
want to be suspicious when we see code that uses ssize_t as if it is
half the size_t plus error indication, it does not immediately mean
that the type "should not be used in Git". It is perfectly sensible
to assign to or compare with returned value from write(2), for
example.

Will queue.  Thanks.

