Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036B25485E
	for <git@vger.kernel.org>; Mon, 12 May 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053135; cv=none; b=Y6DlPnCl28fmUydzGDGl7Ra6SC1Jtr502oKaZYAieDcHLQ75ylkZ7aoOhLrxc751bOcyb7BJLpLVhmTodcN5HHJx+0JQohEc3TCh+ud8nNTHzMO0j9R76ta5U26T+UY68epugJbm3o8YJIdNOKK/CK+9qo6SYsN0xZsISLIO838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053135; c=relaxed/simple;
	bh=pFTDVqHbW/1siNKTlBYqblOqAWpC7cyr7WnqtdW3SMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fz3ctmQwKzbXpKZdKdXKqgTXKfWK08ejbNoiqBXH4864WgV2TxX7K1mIFziN1dqdSIYz2vJmvSviZjGvG4caWY+rh4ZC59D18bxHNR9HHKf4Ve2alo1e4E81HpnDCfer6unVR2tL0JQWCMZNtGvP600V6ylYegPfn2B3iw17fQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZlKMAIob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbpHd56Q; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZlKMAIob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbpHd56Q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EF082540078;
	Mon, 12 May 2025 08:32:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 08:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747053130; x=1747139530; bh=2lwpqdPC0+
	JdbzZukP1NEaAKPEhKGsCcGuhdk3CMw7Q=; b=ZlKMAIob1CL64EDMU/tc92sTyS
	kiQKiGjWIo0VyTEw6Ku0OcYV8CYOIiaJt6jhHH0nvr963l2sqIcShbG+zJ3T+Uuq
	btry1//8AYBF0WHW+koBgX4gOfE3nX117jAID37Qu8uKAeEqW+1u8yAl8ALwo0F/
	Iqs4w0DaUBXQR4FUC0Qr3rrCNszCcOvUoJjj40Y8kA+IiAOL308673wMysYXmijv
	5OF1wLpOqh4A5EEzSXiofyuhp0PUStNE/Ihin2OXqozQLuuWSrzzAKM0Ql4N56Gs
	Q+tW0aG+OJp/ix3X2+EpSVovt2PRYW8jpEkfsXouVkgu5U6p1Hnu++TTyElQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747053130; x=1747139530; bh=2lwpqdPC0+JdbzZukP1NEaAKPEhKGsCcGuh
	dk3CMw7Q=; b=bbpHd56QuQa+4qLevn5MHBV9vRTSCOqKagK/gOzLQ8zeIIv9hpL
	r9rcT3zuL1Tcm+rZHMxmZrTD61aWM6Y6amnstzKHPq7JqiZENi0GGfxeDjbssDi/
	EvO8PyQ1QboIfOGtATsc7EkWw7BdihbKHu3nED5OfnZh9JyBZSODu73YJ/gEXvWB
	OOlsI0Ro66E986eczJPeTIE1ztnIJTPAiZV3QD95LQOtmt9t4EuRhUg2TnBf2o3Y
	cSy4La6iG/B8r+kx4lYryDRYv9nZyKiwSNnr8LsfeFvDWGoHaM294vKRRJLGYKrI
	/IZnzY+NnH5oRT5zl5pcw1PJeoCvxFjk6NA==
X-ME-Sender: <xms:SeohaA9yMC5YKduBUkDBkraENLC4TPmwVdq-8XbCDeQkf3gEcU76zQ>
    <xme:SeohaIsm5KArvwKSk1dCWd4lYHnAelbNZ9djMd6yyocOLZAR-MwQuH3XXXrL7d632
    Dvrkcx6FT2UdNzwOw>
X-ME-Received: <xmr:SeohaGCjSYXAaqZkA7UtSaM2yRMAQOPbsqv4LEOzABjp8ugj1IdH6HOx6q7qIrxf6ohx4RDcnYMVe5MP4AMBDyZcSO_Y9Xfmo6JK4ho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:SeohaAc8hgogQvzFkk5uM2h2ng7RRiAlsJFRQGmZdm5aMN4IMG9xZg>
    <xmx:SuohaFOdzbnbDUiOgH1onyjxE7dpuQSkwFUgd28dr4Mn2R_BA6r3Ww>
    <xmx:SuohaKkqT1uVS6NsGE23fu7vKPqjdE2a7Dnaez9-cnqD3q0EAsVRNQ>
    <xmx:SuohaHuRclVtyaeQEg7XrTxZXxwj4iVE5yNU9QLVz_gtH-QNk2rtog>
    <xmx:SuohaAYOgiN_ZOV3q6PuF_4gc3W8UDInbc0roRela4OEZjSTIIOpEeZa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 08:32:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] submodule: prevent overwriting .gitmodules entry on
 path reuse
In-Reply-To: <20250510054542.556401-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sat, 10 May 2025 11:15:42 +0530")
References: <20250510054542.556401-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 12 May 2025 05:32:08 -0700
Message-ID: <xmqqbjryxb5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> When a submodule is added at a path that previously hosted another submodule
> (e.g., 'child'), Git reuses the submodule name derived from the path and
> updates the corresponding entry in .gitmodules. This can silently overwrite
> existing configuration if the old submodule was only moved (e.g., to
> 'child_old') without renaming the submodule.
>
> This patch improves the `module_add()` logic by checking whether the
> submodule name already exists in the config but maps to a different path.

Quite sensible description of the problem and the proposed course of
improvement.

I do not think `--force` that allows the same name to be reused a
good idea at all, though.  We shouldn't encourage its use to resolve
such a case.  If what used to be called `child` now sits elsewhere,
perhaps because the tree structure was reorganized due to mass
renaming, but if it still is being used in the project, there is no
good reason to nuke the configuration recorded for that existing
module.

The module name used in .git/config is purely local so the user
should just give a new one a name that does not conflict, or even
better yet, perhaps the tool should pick a unique and nonconflicting
name automatically, no?

> In such a case, Git now errors out unless `--force` is specified, thus
> preventing accidental overwrites. To proceed safely, the user can provide
> a new name via `--name` or use `--force`.


>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  builtin/submodule--helper.c | 45 ++++++++++++++++++++++++++++---------
>  t/t7400-submodule-basic.sh  | 23 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 53da2116dd..0f98ef122b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -32,6 +32,8 @@
>  #include "advice.h"
>  #include "branch.h"
>  #include "list-objects-filter-options.h"
> +#include "wildmatch.h"
> +
>  
>  #define OPT_QUIET (1 << 0)
>  #define OPT_CACHED (1 << 1)
> @@ -3323,6 +3325,23 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
>  	return ret;
>  }
>  
> +static int submodule_active_matches_path(const char *path)
> +{
> +	const struct string_list *values;
> +	size_t i;
> +
> +	if (git_config_get_string_multi("submodule.active", &values))
> +		return 0;
> +
> +	for (i = 0; i < values->nr; i++) {
> +		const char *pat = values->items[i].string;
> +		if (!wildmatch(pat, path, 0))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static void configure_added_submodule(struct add_data *add_data)
>  {
>  	char *key;
> @@ -3370,17 +3389,7 @@ static void configure_added_submodule(struct add_data *add_data)
>  	 * is_submodule_active(), since that function needs to find
>  	 * out the value of "submodule.active" again anyway.
>  	 */
> -	if (!git_config_get("submodule.active")) {
> -		/*
> -		 * If the submodule being added isn't already covered by the
> -		 * current configured pathspec, set the submodule's active flag
> -		 */
> -		if (!is_submodule_active(the_repository, add_data->sm_path)) {
> -			key = xstrfmt("submodule.%s.active", add_data->sm_name);
> -			git_config_set_gently(key, "true");
> -			free(key);
> -		}
> -	} else {
> +	if (!submodule_active_matches_path(add_data->sm_path)) {
>  		key = xstrfmt("submodule.%s.active", add_data->sm_name);
>  		git_config_set_gently(key, "true");
>  		free(key);
> @@ -3443,6 +3452,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
>  	int force = 0, quiet = 0, progress = 0, dissociate = 0;
>  	struct add_data add_data = ADD_DATA_INIT;
>  	const char *ref_storage_format = NULL;
> +	const struct submodule *existing;
>  	char *to_free = NULL;
>  	struct option options[] = {
>  		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
> @@ -3546,6 +3556,19 @@ static int module_add(int argc, const char **argv, const char *prefix,
>  	if(!add_data.sm_name)
>  		add_data.sm_name = add_data.sm_path;
>  
> +	existing = submodule_from_name(the_repository,
> +					null_oid(the_hash_algo),
> +					add_data.sm_name);
> +
> +	if (existing && strcmp(existing->path, add_data.sm_path)) {
> +		if (!force) {
> +			die(_("submodule name '%s' already used for path '%s' "
> +			"(use --name to choose another or --force to overwrite)"),
> +			add_data.sm_name, existing->path);
> +		}
> +		add_data.sm_name = xstrfmt("%s.%s", add_data.sm_name, basename(add_data.sm_path));
> +	}
> +
>  	if (check_submodule_name(add_data.sm_name))
>  		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
>  
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index d6a501d453..5c3f471338 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.templateDir`' '
>  	)
>  '
>  
> +test_expect_success 'submodule add fails when name is reused' '
> +	git init test-submodule &&
> +	(
> +		cd test-submodule &&
> +		git commit --allow-empty -m "initial commit" &&
> +
> +		git init ../child-origin &&
> +		git -C ../child-origin commit --allow-empty -m "initial commit" &&
> +
> +		git submodule add ../child-origin child &&
> +		git commit -m "Add submodule child" &&
> +
> +		git mv child child_old &&
> +		git commit -m "Move child to child_old" &&
> +
> +		# Create another submodule repo
> +		git init ../child2-origin &&
> +		git -C ../child2-origin commit --allow-empty -m "initial commit" &&
> +
> +		test_must_fail git submodule add ../child2-origin child
> +	)
> +'
> +
>  test_done
