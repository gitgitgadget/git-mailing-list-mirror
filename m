Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601A40DFDE
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774723011; cv=none; b=T5hQ07bv/xO3WN/R8MwHCzRyI5nSqT+T3jU7DIY2Ql33LOm0nvybbS3Uf9h7znrkW2/qAIwlkuWZ+YJOXUlfLA2sVkl7uKeCM1TYU6oZaZRpFenAi69ydLF8AJKL3KCvB2q3CyVqD+862U5/3lPM9omdzhUoj1etv4vIYI3jveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774723011; c=relaxed/simple;
	bh=7KZYBHGvxWVbdzxhCpDmtoQCNCuvgzbeX/MGXG0HfxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z3OCWhK4lydiwLNyNhdi8SBHsSDj3I0u1cS4DTaVCE1mvWwY8g2/5hXqFXzfAeBdxlR+iPiNq0njIwLp08a1xodMuskcutDi4foYixErN0O83yHeMrCAYjC5ptk3hogKn7Fj5qpVWcjMrpWTgLDgecF0Ubd4MtDJkYRvmhpJpLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SEDhr3X6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4fvNKryc; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SEDhr3X6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4fvNKryc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E214E1D00175;
	Sat, 28 Mar 2026 14:36:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 28 Mar 2026 14:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774723008; x=1774809408; bh=U3aEjrfbJx
	MmjH5AJiasYGNYvyyu/UW/BLaC/6joFKg=; b=SEDhr3X64KslULm7XQmtBSfv31
	BqEKh59TsYKl07j3Qb/4ceLP+KXcV1l4Ae5S1J3/2j113hz7543JGAYS0zpfPuBy
	nnWa+vq5/BVRWSdn4ym69td4JC3h2UKd+05wUgwjxJ9UEtByH7xtQ+APV6/hHAJo
	xtdtcMSQh+cv29WKhV/vLU/raBy97V7wwlzbpgV99omsSczKx21TQIPspnQF9oDK
	caS/7FUdurssir68Am8j3F+iZYPr045x6Mb6LWI0wDuaq228/h4ipTpdQDJM6z+d
	IrKsYpi2/2fipUBxzgZTozlnwWEYSdDAeWXsDamwWcW5b7Qbxl3k+v1ZFAJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774723008; x=1774809408; bh=U3aEjrfbJxMmjH5AJiasYGNYvyyu/UW/BLa
	C/6joFKg=; b=4fvNKrycim9eYSxKOMrQUJgQOB7lYi3WxT2MCzdhben4FSp7Gd9
	wtOZqmEj6T2zUdu9C+e2fFPzLTjFvrU9ay6TfqtT5rNGUkn/TQG0+PUbIcN1WCMS
	KEgFRNrQStJei6MgmkolIkDXXy6zCtqji6DpnwiTBrf8zipNvGkL5Mifo1ja4CI+
	8aMXOoTs/Vmg1/v48aYOJq7oyyC3vTcP5Ya/ZzD6SYboq6dx4Hae4ORWFEqv7fRw
	yDNl01WRPa1YduHt7mEKvMtYct8AZRknCxZj3seCnFhSVC7GJVu+uVGdb9IIx5bD
	L4sTuMlw1NG+OrB8zu3ojT74BbUuMT2hpEQ==
X-ME-Sender: <xms:wB_IaUKM3zW-8Kl9m3V9jjh3nIQDvsEEiwu8xA0butpAdtt7sjG4LA>
    <xme:wB_IaTP_ct9_SxypUQz4rShiIlfZpsXhJL2oc7cvcyOc8J0tYwlMKXR7cBveIYAgB
    acrAdXixv4GrR6woXF3tSCC09Iq_Xtuzj-pY1WoKXVzJCMpxw9_rA>
X-ME-Received: <xmr:wB_Iaa44z4XtzFeU9qLKDqbuB0zo2DOBjx7uIghc4W9WS10xZJfez9tIlYtrf9jvP-HeDdoDSDbJq_TOhciCmP1GbUEaQo6Ejw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeefledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefud
    esghhmrghilhdrtghomhdprhgtphhtthhopehjrgihvghshhgurghgrgelleesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wB_Iad6TeL9GwGR5MM1aW0AZiUTbFYBShVvA92f7MATCevbJt5gVpg>
    <xmx:wB_IaQH4FtjfP87cpkBfwB_bC1vKCEJ4MTt-dYOdA_WdRNi2SpPPeg>
    <xmx:wB_IaVV8PATRv3hSmX9XU3BUClcvEUQ9TthCdOK6qrWvKXmdaTHGXw>
    <xmx:wB_IacWelPzPBFqU4N9rLCNYQ87pFY_JyGDaBjN3Fm4GQhb12UuZrw>
    <xmx:wB_IaZf9LoYEFQVoUbPrTUr4PrtmTMcZ2HfGIARQzE7YZykRvGvluOsz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Mar 2026 14:36:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Siddharth Asthana <siddharthasthana31@gmail.com>,  Jayesh Daga
 <jayeshdaga99@gmail.com>
Subject: Re: [PATCH v2] read-cache: use istate->repo for trace2 logging
In-Reply-To: <pull.2253.v2.git.git.1774682046750.gitgitgadget@gmail.com>
	(Jayesh Daga via GitGitGadget's message of "Sat, 28 Mar 2026 07:14:06
	+0000")
References: <pull.2253.git.git.1774606086325.gitgitgadget@gmail.com>
	<pull.2253.v2.git.git.1774682046750.gitgitgadget@gmail.com>
Date: Sat, 28 Mar 2026 11:36:46 -0700
Message-ID: <xmqqy0jbhkch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jayesh Daga <jayeshdaga99@gmail.com>
>
> trace2_data_intmax() calls in do_read_index() currently use the
> global 'the_repository' instance, even though the index_state
> already carries an explicit repository pointer (istate->repo).

Drop "currently".  The canonical order in log messages in this
project is to describe the current state of the relevant part of the
codebase in present tense, pulling attention of readers to what the
author finds problematic, and propose a solution.  And finally give
orders to somebody sitting in front of the keyboard to make the
change.

> index_state instances are initialized via INDEX_STATE_INIT(r),
> which sets istate->repo. Using the_repository here is therefore
> redundant and obscures the actual repository context associated
> with the index being read.

Even worse, it could do a wrong thing, so saying "redundant" here
somewhat misses the point.

> In particular, using the global repository can lead to misleading
> trace2 output in scenarios where multiple repository instances are
> in use (such as tests or future refactoring toward better library
> boundaries), as events may be attributed to the wrong repository.

Exactly.

> diff --git a/read-cache.c b/read-cache.c
> index 5049f9baca..46ffb49cab 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2206,6 +2206,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  	size_t extension_offset = 0;
>  	int nr_threads, cpus;
>  	struct index_entry_offset_table *ieot = NULL;
> +	struct repository *r;
>  
>  	if (istate->initialized)
>  		return istate->cache_nr;
> @@ -2309,13 +2310,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  	}
>  	munmap((void *)mmap, mmap_size);
>  
> -	/*
> -	 * TODO trace2: replace "the_repository" with the actual repo instance
> -	 * that is associated with the given "istate".
> -	 */
> -	trace2_data_intmax("index", the_repository, "read/version",
> +	r=istate->repo;

Have SP on both sides of an assignment operator '=', i.e.

	r = istate->repo;

> +	if (!r)
> +	    BUG("istate->repo is NULL in do_read_index");
> +	trace2_data_intmax("index", r, "read/version",
>  			   istate->version);
> -	trace2_data_intmax("index", the_repository, "read/cache_nr",
> +	trace2_data_intmax("index", r, "read/cache_nr",
>  			   istate->cache_nr);

Or you can do without an intermediate variable 'r'.  Replacing
"the_repository" with "istate->repo" would make the resulting line
shorter already, and more importantly, readers do not have to
remember that 'r' is an alias for 'istate->repo' while reading the
code.

Thanks.


