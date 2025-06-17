Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBB1898E8
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201974; cv=none; b=tNkNWBG604meWp+cC7JIluQYaN3TaqhHdfxhrW1Ex4InVL6/92oVGpqkAfunHltzgKESW9vFlv/5ZsNP6A3sbK3VvDJOqsVHGI87nThXwFApMIX6vXnHTPhIHphoMPZFfcw35EUNvs7AQ9qdwKLHeu1YfS9jfC9byXpUspIfr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201974; c=relaxed/simple;
	bh=Csc64YAkvgbklMzHEsAQyCAeRVKgCFD6KMelygqOmZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QUdGPE9Q6ReV2BF+x/XayjMEY1oVlAuR9fzaa9X+C1VSxZhpD3jnK2KRKg2tJncOt224Zpz14HeS9XfZ8FItAWC7v35viRg7bt6w0qy/fqiIutput/bs+2eVNuROUVeY/3byLE3+mA1vbatqu+/niLywHb5Duj8QU/NPASREb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DCrhCmuN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bF50/kUg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DCrhCmuN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bF50/kUg"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CE7D213804C1;
	Tue, 17 Jun 2025 19:12:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Jun 2025 19:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750201970; x=1750288370; bh=65V03lUJ5T
	rJxT+GYfGu18cGfwysBKd6Tch6l9PAcX4=; b=DCrhCmuNidW0WsU4fT162euw5U
	hAyWyOm3FML1tsnesX4vnFiKeFZJf7Whb2g0rebUmOUZHOUj+OaWsrGihDICoN3Q
	rHcdO+xt6Q6E6+uzDn7s06jFZiFZGVQr8wjuBH+ZPkvBxLDSLPwmx3RVGAt3noMQ
	yWHYTV7YzsWfkKir395BPavRvROpqmVtO6NCYGp7iYXuCaD4ZHt63x+AM6/8moRe
	lnV4DRr5MOhMTQRoig+dZVnnmOECCn/y4KEWXhRRS8ZlcaDjl1P/MfkT+xX5czCG
	SdhkC1YFyD+KN+sv67fYHwGYAlgabX03sso517NoTfRZJ3GYP5WsS7Yiw2Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750201970; x=1750288370; bh=65V03lUJ5TrJxT+GYfGu18cGfwysBKd6Tch
	6l9PAcX4=; b=bF50/kUgccPcpeKRYdJ+zeruIGnj6Lj7x8igHh5yvjEsUP/wP28
	K30if7A1yrtiTHkC4AB6f7Z/PX79v22LIjh7sHfzbCC6C5Nu7NA8jlfJH9ZE09ne
	iXDFqjGYYz4lZsjPpUDHTTw4ugBf+97uQh5plNgj8wggdUbmny6z+Y+JNl78cKcD
	kcCEZiTQaRk76w/0sz6MeMgB6LDwZWrLz8QlCT81ZyBnkILCPHfMRmfuQcOy9VFB
	lVmAGPKZQpVGcPmbZ9IGDEotf8+DTc752gdchoUdPw1R5vaXpj1uG9/q4/oN1E4x
	AppyE4VWHbEjusB9GGxsoaXwJIgbTrYsqSw==
X-ME-Sender: <xms:cvZRaAc_ogaeXUxdv6x0S0kCZQid2tV3BWo7NmRwRFpivNmO6eI41Q>
    <xme:cvZRaCM8HwwBOaWkG4FeOUwMaTSfSt_51V-3tE3EfM-9b5MPIasad4T6qcdDyiSyK
    7-bRPz-Bml5Es-fdQ>
X-ME-Received: <xmr:cvZRaBhl-PrWLfwio1lO4dUBlHIemIZiv4E_gE10l3Q5ZGBJyXgmVtCN4Ot_F9Ck3lQ1icE0BCr01ozEQNKqWl5c7iezNzjQodpa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkh
    gvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:cvZRaF8Hmk0ZR1ycxTTdvnLqTrxYafiZpT160yEvIYvAgg7pP2jvrw>
    <xmx:cvZRaMtBDNcCqH_powBkdiWAH6s0gUCay1c_a39GOp9EAqCuB-RKsw>
    <xmx:cvZRaMEBX8Vuev3CpLhmjbKZUu8mIWnShjf4ojWVukZrtbc3O-y5bA>
    <xmx:cvZRaLO2kNMvxNtn9CF7C_O9KAwJ93RjfzW4JuOBKQyyuwY5fpPlxg>
    <xmx:cvZRaJSES_7PRtnK4RQe93unqTDYUiOThSec52e9IB-2Y2h9FZJSSbb_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 19:12:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Lidong Yan
 <yldhome2d2@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/6] submodule--helper: improve logic for fallback
 remote name
In-Reply-To: <20250617-jk-submodule-helper-use-url-v2-4-04cbb003177d@gmail.com>
	(Jacob Keller's message of "Tue, 17 Jun 2025 14:30:44 -0700")
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
	<20250617-jk-submodule-helper-use-url-v2-4-04cbb003177d@gmail.com>
Date: Tue, 17 Jun 2025 16:12:48 -0700
Message-ID: <xmqqv7out11r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The repo_get_default_remote() function in submodule--helper currently
> tries to figure out the proper remote name to use for a submodule based
> on a few factors.
>
> First, it tries to find the remote for the currently checked out branch.
> This works if the submodule is configured to checkout to a branch
> instead of a detached HEAD state.
>
> In the detached HEAD state, the code calls back to using "origin", on

"calls back" -> "falls back".

> the assumption that this is the default remote name. Some users may
> change this, such as by setting clone.defaultRemoteName, or by changing
> the remote name manually within the submodule repository.
>
> As a first step to improving this situation, refactor to reuse the logic
> from remotes_remote_for_branch(). This function uses the remote from the
> branch if it has one. If it doesn't then it checks to see if there is
> exactly one remote. It uses this remote first before attempting to fall
> back to "origin".

Designed wtih good taste.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 9e8cdfe1b2a8c2985d9c1b8ad6f1b0d1f9401714..4aa237033a526fca29cce2926419462179d40ee3 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -41,61 +41,25 @@
>  typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
>  				  void *cb_data);
>  
> -static int repo_get_default_remote(struct repository *repo, char **default_remote)
> -{
> -	char *dest = NULL;
> -	struct strbuf sb = STRBUF_INIT;
> -	struct ref_store *store = get_main_ref_store(repo);
> -	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
> -						      NULL);
> -
> -	if (!refname)
> -		return die_message(_("No such ref: %s"), "HEAD");
> -
> -	/* detached HEAD */
> -	if (!strcmp(refname, "HEAD")) {
> -		*default_remote = xstrdup("origin");
> -		return 0;
> -	}
> -
> -	if (!skip_prefix(refname, "refs/heads/", &refname))
> -		return die_message(_("Expecting a full ref name, got %s"),
> -				   refname);
> -
> -	strbuf_addf(&sb, "branch.%s.remote", refname);
> -	if (repo_config_get_string(repo, sb.buf, &dest))
> -		*default_remote = xstrdup("origin");
> -	else
> -		*default_remote = dest;
> -
> -	strbuf_release(&sb);
> -	return 0;
> -}

We will lose two callers of this function, so we can safely remove
it.

>  static int get_default_remote_submodule(const char *module_path, char **default_remote)
>  static char *get_default_remote(void)

These callers that used to call the removed helper now call
repo_default_remote() instread.  Good.


> diff --git a/remote.c b/remote.c
> index b3a9881a6eacf90bee71d6760858b37d68263502..94b31f4c23057a247a968fc0ebe2e5170e99614d 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1767,20 +1767,35 @@ static void set_merge(struct repository *repo, struct branch *ret)
>  	}
>  }
>  
> -struct branch *branch_get(const char *name)
> +static struct branch *repo_branch_get(struct repository *repo, const char *name)
>  {
>  	struct branch *ret;
>  
> -	read_config(the_repository, 0);
> +	read_config(repo, 0);
>  	if (!name || !*name || !strcmp(name, "HEAD"))
> -		ret = the_repository->remote_state->current_branch;
> +		ret = repo->remote_state->current_branch;
>  	else
> -		ret = make_branch(the_repository->remote_state, name,
> +		ret = make_branch(repo->remote_state, name,
>  				  strlen(name));
> -	set_merge(the_repository, ret);
> +	set_merge(repo, ret);
>  	return ret;
>  }
>  
> +struct branch *branch_get(const char *name)
> +{
> +	return repo_branch_get(the_repository, name);
> +}

Nice to see how the dependency to the_repository is lifted for new
callers while retaining the same interface for existing ones.

> +const char *repo_default_remote(struct repository *repo)
> +{
> +	struct branch *branch;
> +
> +	read_config(repo, 0);
> +	branch = repo_branch_get(repo, "HEAD");
> +
> +	return remotes_remote_for_branch(repo->remote_state, branch, NULL);
> +}

OK.  read_config() is a safe no-op if repo has already been
initialized, so this would give us what we want.  Nicely done.

