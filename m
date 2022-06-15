Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE7C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 16:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbiFOQwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243443AbiFOQwL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 12:52:11 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C658848E5D
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 09:52:10 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q12-20020a056a0002ac00b0051bb2e66c91so5428600pfs.4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=4GodK1loLWTy5ktJpNCVYVAbu/SbbZMzk5GAlfXnGRg=;
        b=VO5Ol3zXvNV6PZvFdDrFLWvC+8vvfytl8o6h7eCgh2PY+tjDoKR68BV3Ns18REJv5g
         ukDMcenlX3GV2HA+lqv2XUTgx7+9eKRBo27de5T0UkNN/HQVv+GvK9UzxeF+HVlk0l6C
         wrftlg0b3aUoYFxAl3uxD2R8RK8suBHd5FGaK5yuisO5KbALMt+OIwW6UUa0okk3RJ0j
         xAj4Qd2TgB2hQf8ANx2h/gaDgm1Sk/CfrS2Ua3+l+lG9eUAyHVmG0enNSceOpNoWYAnC
         cKt0C53/fiCj4FKOryEn7bZHmyo+pZkL4lTu1XvYUhWfw9ezI6YpRcDWgXRQogGHng3p
         xuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=4GodK1loLWTy5ktJpNCVYVAbu/SbbZMzk5GAlfXnGRg=;
        b=JxFGeA6ApWbDN8MmHCDyDfUXmeJGguI7MIrYYITRURVzBtOJ+gPtHDm5LXwuhXnT69
         GRttcfcvFIxUu+fUCU3iEZao9eVubcI3mtA07kQc0xNlbXrfUGLwj+kbj9f/DHRnBLpF
         O7DOz7GzimsQCT0n2rue8ebiYnhTSDaqsFD6eDChxW1vATfAntDacc2IpH1LR4Qk+LRd
         Yc1507q/T+juxZlDReJvauKsfwVASGwUMjVOxqQb+p48pZnzInX+Ivga9LHO2ZW1cEO9
         i/7xbqQJ9qNMNc0WncEJ4r5d0Z3GS5LlQEGKK0TRJZHdCCCh6EuRfnPtp47gMypUMtlM
         1Bfw==
X-Gm-Message-State: AJIora9t3+kIBvdwzMw3m6r5UuWthN7e8u32hAJRgmoyOXUs461tLN4/
        I6de7kSuyKSWUfAEs7Jwi+DWYGBmIr2kwA==
X-Google-Smtp-Source: AGRyM1uVR/Wcwgce42HS3pHdOtOUvKihS9H8cUr/Z0jQfQ/GQZUJj70DWmC0J8e0uA5AyQ+GplvYG/juZ99sqA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id
 s2-20020a17090a1c0200b001e00df731f2mr11492228pjs.222.1655311930232; Wed, 15
 Jun 2022 09:52:10 -0700 (PDT)
Date:   Wed, 15 Jun 2022 09:52:01 -0700
In-Reply-To: <patch-v2-10.12-ac00a9599de-20220613T220150Z-avarab@gmail.com>
Message-Id: <kl6l8rpx6f9q.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <patch-v2-10.12-ac00a9599de-20220613T220150Z-avarab@gmail.com>
Subject: Re: [PATCH v2 10/12] submodule--helper: eliminate internal "--update" option
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> Follow-up on the preceding commit which taught "git submodule--helper
> update" to understand "--merge", "--checkout" and "--rebase" and use
> those options instead of "--update=3D(rebase|merge|checkout|none)" when
> the command invokes itself.
>
> Unlike the preceding change this isn't strictly necessary to
> eventually change "git-submodule.sh" so that it invokes "git
> submodule--helper update" directly, but let's remove this
> inconsistency in the command-line interface. We shouldn't need to
> carry special synonyms for existing options in "git submodule--helper"
> when that command can use the primary documented names instead.
>
> But, as seen in the post-image this makes the control flow within
> "builtin/submodule--helper.c" simpler, we can now write directly to
> the "update_default" member of "struct update_data" when parsing the
> options in "module_update()".
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 42 ++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 57f0237af23..65cf4b915df 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1818,7 +1818,7 @@ static int module_clone(int argc, const char **argv=
, const char *prefix)
>  static void determine_submodule_update_strategy(struct repository *r,
>  						int just_cloned,
>  						const char *path,
> -						const char *update,
> +						enum submodule_update_type update,
>  						struct submodule_update_strategy *out)
>  {
>  	const struct submodule *sub =3D submodule_from_path(r, null_oid(), path=
);
> @@ -1828,9 +1828,7 @@ static void determine_submodule_update_strategy(str=
uct repository *r,
>  	key =3D xstrfmt("submodule.%s.update", sub->name);
> =20
>  	if (update) {
> -		if (parse_submodule_update_strategy(update, out) < 0)
> -			die(_("Invalid update mode '%s' for submodule path '%s'"),
> -				update, path);
> +		out->type =3D update;
>  	} else if (!repo_config_get_string_tmp(r, key, &val)) {
>  		if (parse_submodule_update_strategy(val, out) < 0)
>  			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
> @@ -1882,7 +1880,7 @@ struct update_data {
>  	const char *prefix;
>  	const char *recursive_prefix;
>  	const char *displaypath;
> -	const char *update_default;
> +	enum submodule_update_type update_default;
>  	struct object_id suboid;
>  	struct string_list references;
>  	struct submodule_update_strategy update_strategy;
> @@ -2406,6 +2404,8 @@ static void ensure_core_worktree(const char *path)
> =20
>  static void update_data_to_args(struct update_data *update_data, struct =
strvec *args)
>  {
> +	enum submodule_update_type ud =3D update_data->update_default;
> +
>  	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
>  	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
>  	if (update_data->recursive_prefix)
> @@ -2429,8 +2429,15 @@ static void update_data_to_args(struct update_data=
 *update_data, struct strvec *
>  		strvec_push(args, "--require-init");
>  	if (update_data->depth)
>  		strvec_pushf(args, "--depth=3D%d", update_data->depth);
> -	if (update_data->update_default)
> -		strvec_pushl(args, "--update", update_data->update_default, NULL);
> +	if (ud =3D=3D SM_UPDATE_MERGE)
> +		strvec_push(args, "--merge");
> +	else if (ud =3D=3D SM_UPDATE_CHECKOUT)
> +		strvec_push(args, "--checkout");
> +	else if (ud =3D=3D SM_UPDATE_REBASE)
> +		strvec_push(args, "--rebase");
> +	else if (ud !=3D SM_UPDATE_UNSPECIFIED)
> +		BUG("cannot convert update_default=3D%d to args", ud);
> +
>  	if (update_data->references.nr) {
>  		struct string_list_item *item;
>  		for_each_string_list_item(item, &update_data->references)

Everything up to here looks familiar ;)

> @@ -2582,7 +2589,6 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>  	struct update_data opt =3D UPDATE_DATA_INIT;
>  	struct list_objects_filter_options filter_options;
>  	int ret;
> -	enum submodule_update_type update_type =3D SM_UPDATE_UNSPECIFIED;
> =20
>  	struct option module_update_options[] =3D {
>  		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
> @@ -2601,16 +2607,13 @@ static int module_update(int argc, const char **a=
rgv, const char *prefix)
>  			   N_("path"),
>  			   N_("path into the working tree, across nested "
>  			      "submodule boundaries")),
> -		OPT_STRING(0, "update", &opt.update_default,
> -			   N_("string"),
> -			   N_("rebase, merge, checkout or none")),
> -		OPT_SET_INT(0, "checkout", &update_type,
> +		OPT_SET_INT(0, "checkout", &opt.update_default,
>  			N_("use the 'checkout' update strategy (default)"),
>  			SM_UPDATE_CHECKOUT),
> -		OPT_SET_INT('m', "merge", &update_type,
> +		OPT_SET_INT('m', "merge", &opt.update_default,
>  			N_("use the 'merge' update strategy"),
>  			SM_UPDATE_MERGE),
> -		OPT_SET_INT('r', "rebase", &update_type,
> +		OPT_SET_INT('r', "rebase", &opt.update_default,
>  			N_("use the 'rebase' update strategy"),
>  			SM_UPDATE_REBASE),
>  		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
> @@ -2662,17 +2665,8 @@ static int module_update(int argc, const char **ar=
gv, const char *prefix)
> =20
>  	opt.filter_options =3D &filter_options;
> =20
> -	if (update_type =3D=3D SM_UPDATE_CHECKOUT)
> -		opt.update_default =3D "checkout";
> -	else if (update_type =3D=3D SM_UPDATE_MERGE)
> -		opt.update_default =3D "merge";
> -	else if (update_type =3D=3D SM_UPDATE_REBASE)
> -		opt.update_default =3D "rebase";
> -
>  	if (opt.update_default)
> -		if (parse_submodule_update_strategy(opt.update_default,
> -						    &opt.update_strategy) < 0)
> -			die(_("bad value for update parameter"));
> +		opt.update_strategy.type =3D opt.update_default;

Here we're undoing the changes in the previous patch. I guess there's a
readability benefit to having them separate, but I think both patches
are simple enough that we can combine into one (with you as the author
:).)
