Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8E30749D
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779287; cv=none; b=WuLe4PHY2M8z2kuvCqSA0uuwWpSPPqZp0B5LUz4wOPAbZnWHd9xa6aFY6y//y6dvFLeu3aVuXZ0w6IWZe4vJ3cZBKmOf1KMlRVas1ZWE6hJldlZW9LfqS8gmpKk830D+Za1dABXpXTWVwAFXi9ldQ2Ne9u/2SNZDKpTZ1YGqyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779287; c=relaxed/simple;
	bh=IaVKuqhUzeB5JKoMnysbOSD+Km69L6UjjcFoiAo/60M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aFut5ckyfgfq7CWTFjuaxSa0zNygQ5BIrD9i+XD/MGmimWYxf/KwVtrtO067NaQ3rgRjABlzBF4l6EzaWkMFjwT2ktRqSozlAWeHZWIpy9oeaONZAKixjP8AZJ2ITeEp/hamAES5O1WUCI+fQUdbFA2oewblZtyjrakUvm19rBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FFnjocaJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTw6j6ra; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FFnjocaJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTw6j6ra"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F3A271D00065;
	Tue, 24 Jun 2025 11:34:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 24 Jun 2025 11:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750779284;
	 x=1750865684; bh=1zimPb9VP2F0Pp2HtXCX5sALppw8kn3esfh0c77uDXs=; b=
	FFnjocaJJxU48vqAEdfPDB/GpNh/uGGlL9sz4rYKR8Fo/dIy1TU88J4IcN1n7B5r
	JDcJiYd4lgoxmPXpqweZTkh72+6FqJHgyRPvLD1mjQ4lZNuGGvFRDh9kq+AsT6K0
	q2zO9nihe0iUhWLEIefvzKc4TJYhJAQJIRl1r+EKdqP/tvtUmSPSNzJ2WwyR51r1
	/7rr8zyaqg2gNz6zLZXCgXAnhlSwQsvsbIf8JgELyGhemF1mCdkE1DqLb5pb7QMW
	Ex7jboPK5/H1LoGBPERESOqyfxdYp36TKoa2p/Dbo073w/AQLCi5tu38UhnJilGh
	f31/Vf45pABGE+KdT7EOGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750779284; x=
	1750865684; bh=1zimPb9VP2F0Pp2HtXCX5sALppw8kn3esfh0c77uDXs=; b=d
	Tw6j6ra2IBpAuQ0nSqNDoDqc5FMacumiQJ1cPW+pDLdkCkHUaFH7WJmQDRkeitap
	VNDV25sSEM5zf8S/J0vhfDs8I7sSuGxqow7N4O2mr9HgcBTsR7zjqVVgu6H7bytr
	rjCjXNCeDHVjYzLcjLfiG6Bdo+H3Xpb7RVLtRl4YRahq1dLHLx0eH4hsAo6C67mw
	38z6MU83yK/oFb48Fgg48h1vu6Fk5nnAM/6xHoplAgy5e12Fs581A/r+VhfWRJFp
	nav3r8jxAuMyRZFLZd1VMFAqdJ+mmWR5P9lK9y6s+QOJYjHv650zATz2HVvQe+n2
	xdUKHqsO89KUG2rD4GezQ==
X-ME-Sender: <xms:lMVaaAmVR9aalDxjudPnOYq0WiqGU6liO56hCT3HnJu8jyvpghB-0Q>
    <xme:lMVaaP2mogbQ9Ngit2n9RazS3oJERIPDgLxOym9Aw4SSOB7MIIU5ZZQp5iP1d50HQ
    mWY08Z6n6s5n79lHg>
X-ME-Received: <xmr:lMVaaOq_5EO7Fv17kzbk1-z4cVLuIrwcg4MovgjJDCk8dEmtvhaSUHhmTFk1zkHra7pB0z3Qgqbm-9X6eBPsorjoppvf89JVC8Gix6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:lMVaaMlebYn4Lu4rXmnKs169oaKiAJ6E3A0ZbUJdLohP4oy63c5hmg>
    <xmx:lMVaaO21SbKHAjCiQCcKSnXjKUxuH7keH7zgoDiVzl0B2i4cfEHLvQ>
    <xmx:lMVaaDsAOOBCZoUtsJWzaIwMceLLuaSTh6uepOp-tslUA9Uu-sF-0w>
    <xmx:lMVaaKWsDptkC3eZ5GnFnqSGws_43cSE7MGyfFZl7FHkasDvXAEatA>
    <xmx:lMVaaChpDZyi1Z_MrCeBIS7Jfgv1iEEJdFWd7oaN1QsCQBj6497oW13O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 11:34:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>
Subject: Re: [PATCH 1/3] compat/posix.h: track SA_RESTART fallback
In-Reply-To: <2b5a58e53ac68e39a72e23bb40b386366ff03485.1750774122.git.gitgitgadget@gmail.com>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Tue, 24
	Jun 2025 14:08:40 +0000")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<2b5a58e53ac68e39a72e23bb40b386366ff03485.1750774122.git.gitgitgadget@gmail.com>
Date: Tue, 24 Jun 2025 08:34:43 -0700
Message-ID: <xmqq34bp2lws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Carlo Marcelo Arenas Belón via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
>
> Systems without SA_RESTART where using custom CFLAGS instead of
> the standard header file.

This is not a sentence, isn't it?  "where" -> "are"???  I dunno.

> Consolidate that, so it will be easier to use in a future commit.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  compat/posix.h   | 7 +++++++
>  config.mak.uname | 3 ---
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/compat/posix.h b/compat/posix.h
> index 067a00f33b83..2612a8515897 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -250,6 +250,13 @@ char *gitdirname(char *);
>  #define NAME_MAX 255
>  #endif
>  
> +/* On most systems <signal.h> would have given us this, but
> + * not on some systems (e.g. NonStop, QNX).
> + */
> +#ifndef SA_RESTART
> +#define SA_RESTART 0	/* disabled for sigaction() */
> +#endif

So not just on QNX and NonStop, we have SA_RESTART defined
everywhere.  I do not know offhand what the ramifications of this
change is, but we seem to use the symbol in places outside #ifdef
meaning that anybody other than QNX and NonStop that lack SA_RESTART
wouldn't have been able to build Git before this change, and now
they would be.  The resulting binary may not work for them at all
yet but that is not any worse than before.

>  typedef uintmax_t timestamp_t;
>  #define PRItime PRIuMAX
>  #define parse_timestamp strtoumax
> diff --git a/config.mak.uname b/config.mak.uname
> index b1c5c4d5e8ed..52160ef5cb07 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -654,8 +654,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  
>  	# Not detected (nor checked for) by './configure'.
> -	# We don't have SA_RESTART on NonStop, unfortunalety.
> -	COMPAT_CFLAGS += -DSA_RESTART=0
>  	# Apparently needed in compat/fnmatch/fnmatch.c.
>  	COMPAT_CFLAGS += -DHAVE_STRING_H=1
>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
> @@ -782,7 +780,6 @@ ifeq ($(uname_S),MINGW)
>          endif
>  endif
>  ifeq ($(uname_S),QNX)
> -	COMPAT_CFLAGS += -DSA_RESTART=0
>  	EXPAT_NEEDS_XMLPARSE_H = YesPlease
>  	HAVE_STRINGS_H = YesPlease
>  	NEEDS_SOCKET = YesPlease
