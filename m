Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9D72602
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765515024; cv=none; b=Sp/pdYrQVKGJHLtVG7dejlkz3ruPF3MIFS2nNg2wBB/oeL0VZyUCNVClMIxfUqChVsOn5oexpOMB02uoo+uUrZCcGqYfgEOjTR3opAFl/KzCajBOrdi7EzNDewDOXx/A/RksDUD58KgGYvWrlIx77RXpMcy22D3LF1z1uq4rv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765515024; c=relaxed/simple;
	bh=6WbTKsTRW42VZqc03vef7Qxzght9TRdOwYLxXifUvxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iVFx7DI1jc4G8BWgCS2OY2yycsIX2QZ0sSQo/M7f3dHeY4Gelo1jw3Jk5O+n4zMZVS37ZEARJ8XJYIunilNSB1eqcod/GmKC656/3UqV/PCQB5Zr0LKmxD8tsrguWXr3kqpZQx0S0RSJKsODWj4zfZi0bxS+lsYOvvRnD6YhNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PA5BpfW+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DaOw5GwQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PA5BpfW+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DaOw5GwQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41ABC14001EF;
	Thu, 11 Dec 2025 23:50:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 11 Dec 2025 23:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765515020; x=1765601420; bh=G/pn8MkNzJ
	o4GBHVII7ZjhsKEn8GlJSmkbqA+euxuQU=; b=PA5BpfW+Fq6HA7hNmmk50Ry8wL
	dsWMAYJV8SpS3iiBWs9zVwrUIldLsxKG4W/Blwo8eYjVSv2u0IM2d7EICKBAxKLW
	EVCtrlQ4tuzTQrHiW4eqjm36tSCQUKTYzcWKofTd8aUUbedr9Zp2+a3kmbYipTW/
	efuhfCkMSddwSBQibGJYEyyH7g82rXRIDNCyzw3uLbFcwAPKUlK9GxgdSqg/RBg3
	2l+TWiANaDMRAOGcgCWTMnIfe3AiUQbDzvR0MH0m4r2XBsUkrAJKEnZR/02wFvya
	yubjmWtJiAMcs80JdJwqT66VUssgbD+7qWEYWBKlrkzOJsXcxE5VqPnLGU8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765515020; x=1765601420; bh=G/pn8MkNzJo4GBHVII7ZjhsKEn8GlJSmkbq
	A+euxuQU=; b=DaOw5GwQEpe2U2ufNyi5lXSY/iPAVbWBRkQvT+EohSbTUNMz0hc
	nfAyI5/txin6o1mYPBjGoP9z1dj77xQZjztgfna9DWYSUt3zlOZyvCv0bPwhMVQD
	2lek7xUoFQfDGz2NgcasxKUSZ3aPqQg1pV+Qz05X7FgQ4UoH/R+Rbgll719KTY1M
	k3I09rX1cgxv+URfCLPwZvO5UWmlG8DRKAIz6UyvZ4UscAZjsHXiX6PtfGR13x6l
	BGrQkfmsO1Kc5mHJlJsPyDYw12hRcQ+erUy7nXmN6pr2a19f/v3/ubSkS3+k/f6L
	G+Ntv1DfB9nSn0l8sT/ccTm0tC7KZEEKf+A==
X-ME-Sender: <xms:DJ87aQPw-eCnK8ZPJvbdJAmNmYU6KophlhVPjR5iHC8SDGPXzF0hww>
    <xme:DJ87aebao-bUuXj4w4_BMIQz9h9iBgKGiW_lzpc6mh1MlIpO3DKjsjIVXP7kF-3Fd
    TzSAgRejYxUjSE2sBywLw7902s_ZWgCjajqiEOt_jWMWcizFAm5hA>
X-ME-Received: <xmr:DJ87aUrg9N71g2UHa5iFL5fzUAhUVLFyloMVya0PRDDSKPMeTNZG2qZJaAk7F38Ert0OSApb-ifcN4EsF4Plz7xjM5gtSKLWBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttd
    ehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DJ87aSZ_yMil6cQoEWWAnsaWUuynJ9HK-2G-ijoQbWGXDiMKhzoF-w>
    <xmx:DJ87acTCAzXXp-XioLGkIwmSTuWQX90h5XR_OdzBGUsSZ3qhYOkCGA>
    <xmx:DJ87aZ6G14LJwffnaj4o54GV5jQus59u-Z75EYPE9OoQ3lHClyZHzg>
    <xmx:DJ87aRxPMeQotP2iBKC9we5sFtfwYZhgDFmPdEnaagHA36pwAG6k3A>
    <xmx:DJ87aabgc0Pj2bECv6E1qQ24cD_CPjv389YtPbDbbMaZJVECrP4cwUn2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 23:50:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Make pull.c match the structural conventions
In-Reply-To: <20251212020930.11654-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 12 Dec 2025 07:39:30 +0530")
References: <20251212020930.11654-1-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 12 Dec 2025 13:50:18 +0900
Message-ID: <xmqqikeccnhx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> The builtin sources follow a predictable structure, and pull.c departs
> from that pattern by arranging its option table in a way that disrupts
> the expected flow of the file. The irregular placement makes the file
> harder to read, breaks the visual rhythm shared by other builtins, and
> forces readers to jump around to understand how options are handled.
> The lack of consistency makes pull.c feel like an outlier rather than
> a peer alongside the other commands.
>
> A consistent layout helps readers rely on established mental models,
> so bringing pull.c into alignment improves clarity and makes the file
> easier to navigate and maintain.
>
> Pull.c, become structured like the other builtin/*.c files, keeping the
> option definitions where the reader naturally expects them and restoring
> the uniformity of the builtin command layout.


The above is, what should we say, overhyped?  I do not know an
appropriate phrase, but there are subjective judgements without
backing it up with exactly which pattern the code "departs from".

In other words, too many adjectives, so little substance.

I expected something a lot more than a simple change that can be
summarized a lot more concisely, like

    Unless there are good reasons, it is customary to have the
    options[] array given to parseopt API in the function scope,
    not in the file scope.

    Make builtin/pull.c:cmd_pull() to follow that convention.

or something.
