Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FDB46D569
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583502; cv=none; b=HgT/UAvoRS3Du9/mOG9/KoJ/Ue3s9UDVG7Lr21hyCAj8wmcV2ZYXdUSSph/1+UCYm2Wzm6uV6b7EwnfhCquMuuOid0JwTz1JTLBYE+C8RCveCuU6l/+a9/lwB5bQxgHX5MLKCjfWSQ4H17IM9C6XkPqAfVMlj7+9W4h3o611EwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583502; c=relaxed/simple;
	bh=k+GVV5tNXPpzev5stn/tetQbLhhKucOw741ZrtzRfeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsgrIGgbSSmoCZ8cziyXO3bLvLD4Mwc0FyhR3DulRLvuCke5nqZQcrj9mOhllNakzm527EJXzoIvtNJ0cQQ/I71wgjI4B//UhFpkkyttSxO/wAMz6QzozOBeVE/WpD5+UV31QyPQvKr4VBVi/Gk46PrGEybobrjbd4rHK70Q6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IWJDQQan; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AGXz05ZU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IWJDQQan";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AGXz05ZU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 14E4BEC00BE;
	Mon, 28 Sep 2026 04:18:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 04:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790583500; x=1790669900; bh=lbWBBeFZ5D
	lh9BhlTE21j0uWWKWMI1Yg6VCmoY+S8qQ=; b=IWJDQQand7ZHOIiNth3VatG0oU
	yH2pun6U+DefHzxDTVr0D8xO30B9xz8DRZanhPGpvtk5AQPnSRIzcnpU6UnsyJhD
	+Ub0hDysEb1Oy5nvkGwa/DJxa+3O+/8tWqBrCBI67AWZofu4yDGBGfgxeOZvEjtB
	FORGH2mAm+k1rqoIj7lHgUYnWrCywrPZKfzXW6RC3NFdmYvgT7w0BXR3Si8Ur6dz
	+kYmys+H1LMrVnur+rpNXBF5AN3CDRwWmkt8aQ24Ws2ScXnvXXhhhPEnq9qMbhmS
	IzsPt9bZLmbkUDf09M35orcIu4B3CMNx5z57QYHxw1x0wMR6M2KVWWyJTZlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790583500; x=1790669900; bh=lbWBBeFZ5Dlh9BhlTE21j0uWWKWMI1Yg6VC
	moY+S8qQ=; b=AGXz05ZUhyWuJq3ajseXkHorVLl7gv972WyIhyt4E4GYwFNx8ds
	g48Z8P3W4pd+CGBw/drHsOEQzSsTIbtRDfTgJvBERcXiL0Jb8MTrSUWeUhFY/lJA
	6vUh5I3E+wqzOOeAVJYK/y+C5SwmhlHs/34zFXomdwe2yBaEGW8y0TCKKZeUPhxi
	bUgUA5+kYcRpicyztLmYL0GsSp/cNrc5+WBASNhRantkFjML1HPVzYdi34hOUeBT
	8HhuNQKFowop9FeWyw9vV/Gta4OyDc6Jbi8GlI11yyc+m8uCU01BJdC+aqH7stvi
	KcXl80SC4pVbZqT0Z/eMmSbMi4lI7Am7wCA==
X-ME-Sender: <xms:yyK6asRu5I8aGhutAp24oGpPcs1FBlAqHoS9ngcKyxW56t1a8Yhx5Q>
    <xme:yyK6ajGxZHgVNWyDTw81Z8ssujaAqHLnYP9-XiMtF_oK1zLHnvdpmZKHmntWuvBKn
    8dInB7b4mRP9_RhJ1YdPgsmBWZtduD6Ug9uUZZT9hcCEJUjr960w9IT>
X-ME-Received: <xmr:yyK6ahFHs_cNWSS1b72DVVe--XL7_cd6hBMXz-fuxQzuqJNLscQJMQ>
X-ME-Proxy-Cause: dmFkZTEdPcIdPOgk1nY5Syf1Hp7CCk8pV+R6Xpvz1jWt0KM71IPmi6qAl/dWNl62Uxz0Ky
    nJC5eXvrEdhNE9blwaYYrA0oyuWq47LE9Axby5eJKtGYy5n9G2imicexemg4WkwCo8YIg3
    X0H6iqUYrxtUzsP4o2DgH3iIbysnGLZWjmhpUEjPDbcCfvf141m/tTl4Czyav2PRg6TU2/
    ZZZmpR6ApBC4mu8nMqGTlMtay1npzAN/Dy6CtvST8l8G5FuEM2Y7BEB3FhLFy7M+1N6J8O
    tUcF2tPZtseO3baVeM2b2BI7ZsbI7HtiaY+qPYAgoADoHShSpXQLIBgekf1D2vMgyuHkVC
    QlASFN3jTS0zd9kx2nqzvxS545zecwE+GKHgiHCFOkXFBTgkLgD9MMZcpqb8zsgUc2fMkT
    YpNN2XtUu3rj5Dg9zOfdCAB/KA1K2vneevvpkxof+4P0TTPad9YLo+7ks4Mf9oJeXL+jPI
    MFEufD5nJiJslS4TWEDPB9KVBB3QJW9/tkEPmA/3swE/KL4QglpwoQZingjm9O/sLwY2sv
    2sVai2lwJEsQ5kh7YxafmFM1ZNYgGdeYlHu1hYnk0rXfh4NxHqdAalEtGpwS4W9a6UMWX6
    crWTy/tPyNexLfWumPMyYAzC+lvwsMG/aPjSTozTRr4G3bazE6VZGuZMy1DQ
X-ME-Proxy: <xmx:yyK6ahSnClo4qaq3_YwTCWEWS8-I4eqfT3ZYqqVp2OT-Ap0kQ3iouA>
    <xmx:yyK6aiKSHVV86AGmwi9xTqt1JqDW9hJ9lnjLkRnGlt8JgLmL6huv6A>
    <xmx:yyK6asbIBwGuvlQwDFGHTh6d5z2H5sKfdjNXnY782cs1Faifpc4aTw>
    <xmx:yyK6ak88fiSwnQC7idfZ5Xr1Iajc6nwCBlDUjUb9wsVJF14ULJnRVg>
    <xmx:zCK6alNpc62OT_nM_4IpsPb4Fofm8sbJg0UIMeFpDB13uCQIrMoE0eKl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 04:18:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96455226 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 08:18:17 +0000 (UTC)
Date: Mon, 28 Sep 2026 10:18:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v4 1/2] rerere: wait for MERGE_RR.lock, and let the gc
 skip it
Message-ID: <aroixgCkqbmKErng@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v4.git.1789373061.gitgitgadget@gmail.com>
 <8a7a74d6aa359844a49593538ef6178cd1b02031.1789373061.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7a74d6aa359844a49593538ef6178cd1b02031.1789373061.git.gitgitgadget@gmail.com>

On Mon, Sep 14, 2026 at 08:04:20AM +0000, Thomas Bachem via GitGitGadget wrote:
> diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
> index 4e6ab9a27c..4df653367e 100644
> --- a/Documentation/git-rerere.adoc
> +++ b/Documentation/git-rerere.adoc
> @@ -70,7 +70,9 @@ occurred a long time ago.  By default, unresolved conflicts older
>  than 15 days and resolved conflicts older than 60
>  days are pruned.  These defaults are controlled via the
>  `gc.rerereUnresolved` and `gc.rerereResolved` configuration
> -variables respectively.
> +variables respectively.  If another process holds the rerere lock,
> +for example a merge or rebase that is recording a conflict, `gc`
> +does nothing and says so.

Do we maybe want to drop these examples? I don't feel like they add any
value.

> diff --git a/rerere.c b/rerere.c
> index 3d3bd0db16..7d44f3937c 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -33,6 +33,9 @@ static int rerere_enabled = -1;
>  /* automatically update cleanly resolved paths to the index */
>  static int rerere_autoupdate;
>  
> +/* how long to wait for MERGE_RR.lock, in milliseconds */
> +static int rerere_lock_timeout_ms = 1000;
> +
>  #define RR_HAS_POSTIMAGE 1
>  #define RR_HAS_PREIMAGE 2
>  struct rerere_dir {
> @@ -850,6 +853,8 @@ static void git_rerere_config(void)
>  {
>  	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
>  	repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
> +	repo_config_get_int(the_repository, "rerere.locktimeout",
> +			    &rerere_lock_timeout_ms);
>  	repo_config(the_repository, git_default_config, NULL);
>  }
>  
> @@ -882,12 +887,34 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
>  
>  	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
>  		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
> -	if (flags & RERERE_READONLY)
> +	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
> +		BUG("RERERE_READONLY takes no lock, so RERERE_NOWAIT does not apply");
> +	if (flags & RERERE_READONLY) {
>  		fd = 0;
> -	else
> -		fd = repo_hold_lock_file_for_update(r, &write_lock,
> -						    git_path_merge_rr(r),
> -						    LOCK_DIE_ON_ERROR);
> +	} else {
> +		const char *path = git_path_merge_rr(r);
> +		int lock_flags = LOCK_DIE_ON_ERROR;
> +		long timeout_ms = rerere_lock_timeout_ms;

Here you're using a `long` whereas `rerere_lock_timeout_ms` is an `int`.
Of course we'd ideally use a `long` consistently as that's also what
`repo_hold_lock_file_for_update_timeout()` accepts. But I guess the
reason you didn't is that we don't have `repo_config_get_long()`. So I
guess this is good enough for now.

> @@ -1211,7 +1238,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
>  	timestamp_t cutoff_resolve = now - 60 * 86400;
>  	struct strbuf buf = STRBUF_INIT;
>  
> -	if (setup_rerere(r, rr, 0) < 0)
> +	if (setup_rerere(r, rr, RERERE_NOWAIT) < 0)
>  		return;
>  
>  	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",

I'm not a 100% sold on this change. There's two different scenarios
under which we want to perform garbage collection:

  - As part of auto-maintenance, triggered by Git automatically. Here
    I'm fully aligned that it makes sense to just silently ignore the
    case where we couldn't acquire the lock, as auto-maintenance is done
    on a best-effort basis anyway.

  - As part of `git rerere gc`, which is invoked manually by the user.
    Here I'm less so, as the user has explicitly asked us to garbage
    collect. Sure, we print a warning now, but the exit code does not
    signal that we failed garbage collecting.

So I'd argue that we should discern those two use cases. I think that in
the second use case, we'd probably want to use a timeout and if we fail
to acquire the lock, we should make `git rerere gc` fail with a non-zero
exit code.

Patrick
