Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71198C32793
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 23:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiHWX1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 19:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHWX1K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 19:27:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B4E7CB5E
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 16:27:09 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id i16-20020a170902c95000b00172c39b3fb0so7966121pla.22
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 16:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=XnMrq55Vxsr8iqEE0SwEBgZVrX1kt4O0JARN7+1iuwg=;
        b=gXX9OBjsQusUkngqe68HZJ6AkKNlfUN9iK6mUR56Er+CzhxD8QnAE1xWp0kTAuCQWW
         L1rp84uFOXTWFw9LgnJ3qWQsu9oihAH72HLm81f/1hgvngKDbspDMIXDjl0BnvlVHbZu
         asLdcTHBJb9daA/mReq1hSF30H+RhA3pLuqskKlACcklzPJb+igHFYStPTe0SEVTZ9Cv
         ugI16XtOJwPE7AmkV0BwjYMHebXXs26qm3nHNVPTexWE9Cg3e4m1p48rLxezb+UE7O/g
         qHYJs9eNb6IJnrQDh1EIANcXy3EHmQhwOuRgw92JFicAQ90B584MHsVXD6QHKPDolHNn
         7EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=XnMrq55Vxsr8iqEE0SwEBgZVrX1kt4O0JARN7+1iuwg=;
        b=v+BLzulFySVYRKxLJyxkON7K55qjaL/gM82ZVbBxptM9pOhgIFOgpBt42TMiJTBjD9
         OfPlYYThL+fQoCArUmXM1jFD2PY8pGTdhUuK60MOAPkUN+4x/Fo8Y0SDYbQ9UuJ68hcH
         /AHdch3Zcj/MZhbmM/stWHgl/BykC4mVKpT5BOBbMDKi//kYaG8AZZdjHouiUAEALvEF
         jgiuP9FOajwPTSWC4n/L0ZjBzXOMMqPw7RGkT79F1ekmQfrUY+aN9+DA9aM07xozeNKK
         ku2uxOWERQmLW0nBaIIQZWG0e4RHTicT3KRWSyMSy2msD6iVa9dO4c1Lwm0J2bU7v6Un
         kTAg==
X-Gm-Message-State: ACgBeo1Xq9FRs4fX/VRzSPr3TMrvfJGXFQa3IwKLhAvKjGtACvWe5HSB
        oMCeotjnqaXI6qlH5eJNprCaxdfkFOkxhg==
X-Google-Smtp-Source: AA6agR7LkIR8IFBrhUnb9DODaOnKcXD0NTWVYu+rXy9n2mc2LlVAcZHg6BXTjc8fnBO7h5F+/9GnDopzyJEZXw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:130c:b0:535:ca9b:13e0 with SMTP
 id j12-20020a056a00130c00b00535ca9b13e0mr26785234pfu.55.1661297228319; Tue,
 23 Aug 2022 16:27:08 -0700 (PDT)
Date:   Tue, 23 Aug 2022 16:27:06 -0700
In-Reply-To: <patch-v3-28.32-6d9bccb34c3-20220821T130231Z-avarab@gmail.com>
Message-Id: <kl6lk06y4k39.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <patch-v3-28.32-6d9bccb34c3-20220821T130231Z-avarab@gmail.com>
Subject: Re: [PATCH v3 28/32] submodule--helper: libify "must_die_on_failure"
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

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Continue the libification of codepaths that previously relied on
> "must_die_on_failure". In these cases we've always been early aborting
> by calling die(), but as we know that these codpaths will properly

s/codpaths/codepaths :p

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
> leave converting it for a subsequent commit.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 851000ae30e..5f109d422ea 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2245,9 +2245,9 @@ static int run_update_procedure(struct update_data =
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
>  	}
> =20
>  	return run_update_command(ud, subforce);
> @@ -2291,13 +2291,14 @@ static const char *remote_submodule_branch(const =
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
> @@ -2315,6 +2316,8 @@ static void ensure_core_worktree(const char *path)
>  		free(abs_path);
>  		strbuf_release(&sb);
>  	}
> +
> +	return 0;
>  }
> =20
>  static const char *submodule_update_type_to_label(enum submodule_update_=
type type)
> @@ -2390,7 +2393,9 @@ static int update_submodule(struct update_data *upd=
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
> @@ -2406,8 +2411,8 @@ static int update_submodule(struct update_data *upd=
ate_data)
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
> @@ -2417,13 +2422,13 @@ static int update_submodule(struct update_data *u=
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
> 2.37.2.1279.g64dec4e13cf
