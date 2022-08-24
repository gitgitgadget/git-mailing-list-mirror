Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA21C32793
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 00:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiHXAMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 20:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiHXAML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 20:12:11 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBFA7CAA8
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 17:12:11 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id a12-20020a65604c000000b0042a8c1cc701so3780918pgp.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 17:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=ofYqosY0Pam8rSIiAbUP3GAsFzWygz1IQtHljfbL4Lg=;
        b=exQUxlNAHRIY1Wr3ah/Ad9jiweE0Ndjt/Ph2yNMbAIyCO1jtMvdi3/hXxIezgyTcd5
         dFJtA0W4HHEma/+9yItKhKpBmvA2b1mRM+vtKXO4I22wrvleK7MmQGSS7htEi7GzdY7r
         zP/Eeu0uTVcsU+bwTVllAV03AJ8IXp7p6H/BSfQuVtqyy7jGmHVE/eFzcpuMrb+n3xqQ
         zn0px80g6fxUvNYVTeie9uc7pCa3bIwkaEFpzu9/Ua9HevppNa8KD6zaL7DizKVU4gR0
         Ra9CnNn/aqX938W55/fY7LjwJgGmYixafJk2YuVgWJo4BIAPduSJgaotYGpBiYJAjeiA
         EClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=ofYqosY0Pam8rSIiAbUP3GAsFzWygz1IQtHljfbL4Lg=;
        b=R/kfQ+zqvjbrAUmHz5UUOUEsNNux2nhZL71WsIquM0Xra58SBCngGHgFEdQsaqIM6f
         5C9lIQT3gCQu+XW8FXcjsAZY79xyKlE+PwrnJahUa6D4Llqc5CBNgoU6qMTkl7fbZzuP
         IAV/JPIByIXFOGII4YD/vMhQ3eDM+8kGTfM49bSWeL59SuF/DSfFzqxon54q7PTjmqmC
         kk1LP9U3GbPliRvykOUKdBPR1dqKuqIXgtSEMGJjoTf72FBKF0cgHZw7yEDcSSfbKidy
         l4RYqCrufFIlzGIkAzBWewr4vr5Cv9+QvbEybDUAhTXfJ+Sp50cUg1iQgN2Q8MxiPEON
         fKqA==
X-Gm-Message-State: ACgBeo1B8xbMwdYl12G0kA3zhWr45fs43EIkSPxSJE8l/uiBRnioiFKM
        uhDV/6xKlrkZRJYojxzvwK8U+APy8OWLyQ==
X-Google-Smtp-Source: AA6agR5DEM1Fjvd4sAn4lh49bp70l0lLPoVIL+Jf6chqZSrwfwNE7Zvun5v0grcmxjFSbQgCGZimQpyAbS5xOA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:b53:b0:537:7f7:63a7 with SMTP id
 p19-20020a056a000b5300b0053707f763a7mr4181406pfo.2.1661299930753; Tue, 23 Aug
 2022 17:12:10 -0700 (PDT)
Date:   Tue, 23 Aug 2022 17:12:08 -0700
In-Reply-To: <patch-v3-31.32-1694ccfe882-20220821T130231Z-avarab@gmail.com>
Message-Id: <kl6la67u4i07.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <patch-v3-31.32-1694ccfe882-20220821T130231Z-avarab@gmail.com>
Subject: Re: [PATCH v3 31/32] submodule--helper: libify even more "die" paths
 for module_update()
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

> As noted in a preceding commit the get_default_remote_submodule() and
> remote_submodule_branch() functions would invoke die(), and thus leave
> update_submodule() only partially lib-ified. We've addressed the
> former of those in a preceding commit, let's now address the latter.
>
> In addition to lib-ifying the function this fixes a potential (but
> obscure) segfault introduced by a logic error in
> 1012a5cbc3f (submodule--helper run-update-procedure: learn --remote,
> 2022-03-04):

Ah, good catch.

>
> We were assuming that remote_submodule_branch() would always return
> on-NULL, but if the submodule_from_path() call in that function fails

s/on-NULL/non-NULL I assume?

> we'll return NULL. See its introduction in
> 92bbe7ccf1f (submodule--helper: add remote-branch helper, 2016-08-03).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 41 ++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 9e4069b36cb..65909255760 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2267,42 +2267,49 @@ static int run_update_procedure(struct update_dat=
a *ud)
>  	return run_update_command(ud, subforce);
>  }
> =20
> -static const char *remote_submodule_branch(const char *path)
> +static int remote_submodule_branch(const char *path, const char **branch=
)
>  {
>  	const struct submodule *sub;
> -	const char *branch =3D NULL;
>  	char *key;
> +	*branch =3D NULL;
> =20
>  	sub =3D submodule_from_path(the_repository, null_oid(), path);
>  	if (!sub)
> -		return NULL;
> +		return die_message(_("could not initialize submodule at path '%s'"),
> +				   path);
> =20
>  	key =3D xstrfmt("submodule.%s.branch", sub->name);
> -	if (repo_config_get_string_tmp(the_repository, key, &branch))
> -		branch =3D sub->branch;
> +	if (repo_config_get_string_tmp(the_repository, key, branch))
> +		*branch =3D sub->branch;
>  	free(key);
> =20
> -	if (!branch)
> -		return "HEAD";
> +	if (!*branch) {
> +		*branch =3D "HEAD";
> +		return 0;
> +	}
> =20
> -	if (!strcmp(branch, ".")) {
> +	if (!strcmp(*branch, ".")) {
>  		const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
> =20
>  		if (!refname)
> -			die(_("No such ref: %s"), "HEAD");
> +			return die_message(_("No such ref: %s"), "HEAD");
> =20
>  		/* detached HEAD */
>  		if (!strcmp(refname, "HEAD"))
> -			die(_("Submodule (%s) branch configured to inherit "
> -			      "branch from superproject, but the superproject "
> -			      "is not on any branch"), sub->name);
> +			return die_message(_("Submodule (%s) branch configured to inherit "
> +					     "branch from superproject, but the superproject "
> +					     "is not on any branch"), sub->name);
> =20
>  		if (!skip_prefix(refname, "refs/heads/", &refname))
> -			die(_("Expecting a full ref name, got %s"), refname);
> -		return refname;
> +			return die_message(_("Expecting a full ref name, got %s"),
> +					   refname);
> +
> +		*branch =3D refname;
> +		return 0;
>  	}
> =20
> -	return branch;
> +	/* Our "branch" is coming from repo_config_get_string_tmp() */
> +	return 0;
>  }
> =20
>  static int ensure_core_worktree(const char *path)
> @@ -2437,7 +2444,9 @@ static int update_submodule(struct update_data *upd=
ate_data)
>  		code =3D get_default_remote_submodule(update_data->sm_path, &remote_na=
me);
>  		if (code)
>  			return code;
> -		branch =3D remote_submodule_branch(update_data->sm_path);
> +		code =3D remote_submodule_branch(update_data->sm_path, &branch);
> +		if (code)
> +			return code;
>  		remote_ref =3D xstrfmt("refs/remotes/%s/%s", remote_name, branch);
This line is the one that would segfault, I assume?

Looks good.
> =20
>  		if (!update_data->nofetch) {
> --=20
> 2.37.2.1279.g64dec4e13cf
