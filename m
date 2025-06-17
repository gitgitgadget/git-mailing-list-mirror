Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D142236A73
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176908; cv=none; b=V84pfEgbUqzE/HWil+v96fU/ZAy/FL+JysA04mOJV7hQX7pKHiMdU/fULh2zqeKwPZCZj2k6WHabTJ/r1laaK/LEZCcuBFgJM6FNpkIPRRKdEl5GR00sEYKY8bMZQ0WogtRZz9tarQ9ofiibeqtHxQXMyJkFa1QiW3DZUeP1Vbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176908; c=relaxed/simple;
	bh=NhL/kCL36YF2bvrfQqmZIu0SRKs/uf5juY8jcRsbduA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMe4a3zO9dQWx6KxVIoZiixJ3zk3oa1xMBmxEN7m0L/icNMpaDnjnObdxM6dXWxpYAFbg2VhVdqcIx5XAgsR8JPXXMsDozUWEjBDmUV5IH+pyD/rYkCHD8zXenvK7+ix+BJfZK9WMa8qgJCekYCMF541lMhqOaJL24Cym+rzIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v/nnT2Mx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dwM8JxVz; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v/nnT2Mx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dwM8JxVz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 708B0254013A;
	Tue, 17 Jun 2025 12:15:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 17 Jun 2025 12:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750176904; x=1750263304; bh=T+AtZQ2xXz
	57jLxBInZ1ZJcQlISAeMPLD8iqmXaqnqY=; b=v/nnT2MxPnEPEIJL2TwDIn+cHz
	gaF3quT1sRASnD0EfmFvGxiJdvjn9YA72WyAKpqTTP9/ZK7tSBmDBlDI2hbjDIjc
	6RtwGGnQy6lgogvcuTzusOX4eIWreP5FK7IqzEhClXVDhS6UqsU37KJMzEbDMx1C
	tylKs1S+F1CKWQI73nw3MI05MY5DvHY1hNxOsUi7zgumn58fQ52BcPMabhqDOtV4
	vQQiliT70Yr6HIx/UCXq5XgvnIBVg6/zbLTJU9nAmv+zKEhua+xGhlvU8CYrUpvw
	6WFQ6D7nuoz+FA+HHbTzYVxX138zvbtLqvz+/xTbbZkoIr0TwcfJGcCKg5rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750176904; x=1750263304; bh=T+AtZQ2xXz57jLxBInZ1ZJcQlISAeMPLD8i
	qmXaqnqY=; b=dwM8JxVzxBhKkmGSiHXnTCSAe3db+m9r/LsfShsfI8GosWDcEfp
	1aTHIWSBkYSHg47VjipOsYrs5qGXpT4AOCrZKCJ0GP9sCX7R9/m12cap3gk1NAHp
	klbMuH8M3XE6St//I1mLdhTrlDZZXlPjskXwQAJszdg7W8uEDUTqX5exM7YDjmqh
	JFnUn4HyxpBse8pMy2lRrPWKCpRMyc9iaFx7K/dboP1EAuWDoV4tlfXTeT24rmad
	h3aGwjwJpFGIOwly6XwklpLUs44NLPsdgRWEagobKSdBItBymE6mD3pDhyiRLEfg
	RfJZZrlZ7B3VllQNXsUv6UqthyNYoKbMWPA==
X-ME-Sender: <xms:iJRRaE1GBsGSLpM5ax_zSJNUc8GQi9DwFLWj-58-wDWMovn0spRO7w>
    <xme:iJRRaPE4x68DFcSTiOD6YTXRF2Uwt4JHQtIff4EgGSxIofXCfRuc37gbAa5r_uFim
    0WLVg1nhfq3auqQlA>
X-ME-Received: <xmr:iJRRaM4ciEh4eNGhJEmz4u8aDnpuGd6E1IgkjW3xxwRfR8aWqFs4o0IQKa1jnz5p6QkXoHqCr221pPJ3URA5X66ma_RPiaXqfbGq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvg
    hkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iJRRaN3DoKK5YqQOwvl0k4_uJUTWTUogLfAEmy3AUOYTC8x4tAgfxQ>
    <xmx:iJRRaHG3ayDh8I0mo_iE2IkVaG0QsmAOlcOHPY_Xknt8t30GhWsWNg>
    <xmx:iJRRaG89vy93elnzzngarJNXf6IyXNAz9UJ2Yeolmj1o02sXcSU8IQ>
    <xmx:iJRRaMlzkHwhVJx1b0-h08NSzFl4vQ187jExmgkoMEI1UchHZ3LaLA>
    <xmx:iJRRaOXG4tMg017i9JKzDrcYFgtmbSWXbKjUUhon1BNSnIfx3ojoFZuZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 12:15:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH v4 1/3] environment: move access to
 "core.sparsecheckout" into repo_settings
In-Reply-To: <e221c68ab52e995adbb175dc4a09f6c3dfeaf7c8.1750157825.git.ayu.chandekar@gmail.com>
	(Ayush Chandekar's message of "Tue, 17 Jun 2025 17:36:34 +0530")
References: <cover.1750157825.git.ayu.chandekar@gmail.com>
	<e221c68ab52e995adbb175dc4a09f6c3dfeaf7c8.1750157825.git.ayu.chandekar@gmail.com>
Date: Tue, 17 Jun 2025 09:15:02 -0700
Message-ID: <xmqqzfe6uyyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index fa82ad2f6f..bf9e56bff3 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -1,6 +1,3 @@
> -/* We need this macro to access core_apply_sparse_checkout */
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "builtin.h"
>  #include "git-compat-util.h"
>  #include "config.h"
> @@ -137,9 +134,9 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  			     0);
>  
>  	repo_config(repo, git_default_config, NULL);
> -
> +	prepare_repo_settings(repo);

At this point, because show_usage_with_options_if_asked() has
already been called and returned, we know repo is not NULL, since
the only time git.c:run_builtin() calls us with repo==NULL is when
there is "-h" with nothing else on the command line and that causes
show_usage_with_options_if_asked() to emit usage and exit.

OK.

>  	if (ctx.sparse < 0)
> -		ctx.sparse = core_apply_sparse_checkout;
> +		ctx.sparse = repo->settings.sparse_checkout;

This is safe for the same reason.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 91b9cd0d16..1bc9c1bada 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -621,7 +621,7 @@ static int git_sparse_checkout_init(const char *repo)
>  	 * We must apply the setting in the current process
>  	 * for the later checkout to use the sparse-checkout file.
>  	 */
> -	core_apply_sparse_checkout = 1;
> +	the_repository->settings.sparse_checkout = 1;

Have anybody called prepare_repo_settings() on the repository yet?
What will prevent another call to the function from overwriting this
value later?

> diff --git a/builtin/mv.c b/builtin/mv.c
> index 07548fe96a..1e9f4d3eba 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -572,7 +572,7 @@ int cmd_mv(int argc,
>  		rename_index_entry_at(the_repository->index, pos, dst);
>  
>  		if (ignore_sparse &&
> -		    core_apply_sparse_checkout &&
> +		    the_repository->settings.sparse_checkout &&
>  		    core_sparse_checkout_cone) {

Have anybody called prepare_repo_settings() on the repository yet
before the control comes here?

The guarantee of the original code being correct relied on the fact
that git_default_core_config() was called way before these places so
the global variable has been already initialized correctly.

The .sparse_checkout member is read in prepare_repo_settings() in
your new code; in order to give the correctness guarantee, there
needs to be some way to make sure prepare_repo_settings() has
already been called on the_repository before these places.

The same comment applies to all the code paths that access
the_repository->settings.sparse_checkout member instead of the
global.  As the source of their correctness guarantee is quite
different, a mechanical replacement from global to a struct member
is not sufficient.

