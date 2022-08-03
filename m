Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973E2C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 04:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiHCEcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEca (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 00:32:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7656BB6
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 21:32:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c11-20020a170902d48b00b0016f093907e0so1667831plg.20
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=eG11+M5Hg/EaLmueaI5L7dezT38Pcn6AAl1d5MvCRNY=;
        b=nfysAsIAfWd0OvqDjIUdbm/Rb6QxfiANeijCbo/M++knBIHSfYwTMvUyzDMFz1NiNF
         JZ2hcfLSA3gJqLJGSvpp5CeEd1xpOQOJDrpY9ChazMMdTpXWFrSsDKkX02PJ7SHnVz8H
         e6JbJasIk5tFkwnKDX217/uiTGwKwuwQjxHkkX6DLwIUdqPQpJQqovG6xlIB0CaMFWzY
         rFKGvQiY+xfnEQqoGM+t65I+siqyXwwRP7qhAbmjlhR4LEM3EYK8eK87nhv19lDFYrB8
         X14bN3kmogXGojOBxaFb7vNwZsmj6giJgXaS9VnUWfCp46CvM+P0OUjUT+WXi1xl3CyW
         ar6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=eG11+M5Hg/EaLmueaI5L7dezT38Pcn6AAl1d5MvCRNY=;
        b=nR5iV02mu3+HAE0h+/bWjPN4c3Y9M0Gy8T7FCudkfaN38bHxNJAjk/hxygZwaWDgBY
         7NuVG1+L3vWvJGiLp2MdU4DrIeOI048z9auwcPzymQzXbahYPuurudpvp+Voe7LJwWD/
         diXNSusjwTY0/Rw4/n2ajigIUK7XeMA/2yLygw7p+3S8rjs9xbgBlUimnAdRNKl+lxFj
         90+js2LxM1BZ12CA0htVfcXHMj2+q7u6rlquH/ec9rf10L511eYddx+j/9Wu7qmOGKq6
         UcY7Wiyajoz50AcYTApCx/p4YhCEtBZv5luj+eL/o6a7s94//WRsBMXVy/bBpW4tygHP
         2UMw==
X-Gm-Message-State: ACgBeo3CdUH5dB+WSk3kymBWqqbjP6qPlMo0r26jO/S1n1+tnVjhSH/I
        wVt8fb1g9s01ZX9/wS4jkyLLdu69l3OkIw==
X-Google-Smtp-Source: AA6agR5AtuUvwrImDE0K8Rsgj0TwYv5CJPxDXPlX2vFFphbQCpjqaCHesyTOsgtguv+7Ikbt9cLUSA2Zj5PSrQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e353:b0:16d:c10a:651a with SMTP
 id p19-20020a170902e35300b0016dc10a651amr24497560plc.146.1659501149578; Tue,
 02 Aug 2022 21:32:29 -0700 (PDT)
Date:   Tue, 02 Aug 2022 21:32:21 -0700
In-Reply-To: <patch-v2-27.28-93cd1ccde54-20220802T154036Z-avarab@gmail.com>
Message-Id: <kl6lilnat0a2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com> <patch-v2-27.28-93cd1ccde54-20220802T154036Z-avarab@gmail.com>
Subject: Re: [PATCH v2 27/28] submodule--helper: libify "must_die_on_failure"
 code paths (for die)
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Patches 19-20 and 22-27 are pretty much "show your work" for the same
libification, so I'll comment on them together.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Continue the libification of codepaths that previously relied on
> "must_die_on_failure". In these cases we've always been early aborting
> by calling die(), but as we know that these codpaths will properly
> handle return codes of 128 to mean an early abort let's have them use
> die_message() instead.
>
> This still isn't a complete migration away from die() for these
> codepaths, in particular this code in update_submodule() will still call =
die() in some cases:
>
> 	char *remote_name =3D get_default_remote_submodule(update_data->sm_path)=
;
> 	const char *branch =3D remote_submodule_branch(update_data->sm_path);
>
> But as that code is used by other callers than the "update" code let's
> leave converting it for now.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 79a11992d1c..4f7ece6fb05 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2263,9 +2263,9 @@ static int run_update_procedure(struct update_data =
*ud)
>  		 */
>  		if (!is_tip_reachable(ud->sm_path, &ud->oid) &&
>  		    fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
> -			die(_("Fetched in submodule path '%s', but it did not "
> -			      "contain %s. Direct fetching of that commit failed."),
> -			    ud->displaypath, oid_to_hex(&ud->oid));
> +			return die_message(_("Fetched in submodule path '%s', but it did not =
"
> +					     "contain %s. Direct fetching of that commit failed."),
> +					   ud->displaypath, oid_to_hex(&ud->oid));

Two things I really like about these changes:

- The intermediate return values are opaque, and we always return on
  error. As a result, the code looks quite uniform (instead of e.g.
  mixing return and exit()).
- The "return die_message()" pattern is pretty elegant and it's used
  often enough that there's no doubt that it's pretty clear that
  intermediate functions can and will return 128 to signify that we want
  the process to die.

So these look great to me :)

>  	}
> =20
>  	return run_update_command(ud, subforce);
> @@ -2309,13 +2309,14 @@ static const char *remote_submodule_branch(const =
char *path)
>  	return branch;
>  }
> =20
> -static void ensure_core_worktree(const char *path)
> +static int ensure_core_worktree(const char *path)
>  {
>  	const char *cw;
>  	struct repository subrepo;
> =20
>  	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
> -		die(_("could not get a repository handle for submodule '%s'"), path);
> +		return die_message(_("could not get a repository handle for submodule =
'%s'"),
> +				   path);
> =20
>  	if (!repo_config_get_string_tmp(&subrepo, "core.worktree", &cw)) {
>  		char *cfg_file, *abs_path;
> @@ -2333,6 +2334,8 @@ static void ensure_core_worktree(const char *path)
>  		free(abs_path);
>  		strbuf_release(&sb);
>  	}
> +
> +	return 0;
>  }
> =20
>  static const char *submodule_update_type_to_label(enum submodule_update_=
type type)
> @@ -2408,7 +2411,9 @@ static int update_submodule(struct update_data *upd=
ate_data)
>  {
>  	int ret;
> =20
> -	ensure_core_worktree(update_data->sm_path);
> +	ret =3D ensure_core_worktree(update_data->sm_path);
> +	if (ret)
> +		return ret;
> =20
>  	update_data->displaypath =3D get_submodule_displaypath(
>  		update_data->sm_path, update_data->prefix);
> @@ -2418,16 +2423,14 @@ static int update_submodule(struct update_data *u=
pdate_data)
>  						  update_data->sm_path,
>  						  update_data->update_default,
>  						  &update_data->update_strategy);
> -	if (ret) {
> -		*must_die_on_failure =3D 1;
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	if (update_data->just_cloned)
>  		oidcpy(&update_data->suboid, null_oid());
>  	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data=
->suboid))
> -		die(_("Unable to find current revision in submodule path '%s'"),
> -			update_data->displaypath);
> +		return die_message(_("Unable to find current revision in submodule pat=
h '%s'"),
> +				   update_data->displaypath);
> =20
>  	if (update_data->remote) {
>  		char *remote_name =3D get_default_remote_submodule(update_data->sm_pat=
h);
> @@ -2437,13 +2440,13 @@ static int update_submodule(struct update_data *u=
pdate_data)
>  		if (!update_data->nofetch) {
>  			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
>  					      0, NULL))
> -				die(_("Unable to fetch in submodule path '%s'"),
> -				    update_data->sm_path);
> +				return die_message(_("Unable to fetch in submodule path '%s'"),
> +						   update_data->sm_path);
>  		}
> =20
>  		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data=
->oid))
> -			die(_("Unable to find %s revision in submodule path '%s'"),
> -			    remote_ref, update_data->sm_path);
> +			return die_message(_("Unable to find %s revision in submodule path '%=
s'"),
> +					   remote_ref, update_data->sm_path);
> =20
>  		free(remote_ref);
>  	}
> --=20
> 2.37.1.1233.ge8b09efaedc
