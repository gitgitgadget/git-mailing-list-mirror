Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B4ECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 20:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiIAUzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiIAUzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 16:55:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6111A37F92
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 13:55:35 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g9-20020a17090a290900b001fd59cc2c14so85401pjd.7
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date;
        bh=xBy0RyxY7ucF1byw53i2p0gDr5HB0Y8vQAGUeLhb4Nw=;
        b=khZw9QakNa/QIgyajxPUPd8PreKYoovpkFZaNu0ZWdwbzG5cVE6hkFODIgbkpHKbJK
         K9m7QkRwZZ5bpx5hRbIHn3bkLHJNsYGxCqxVoLIstBoLo3IHG+zmHfEzhhSLUKorcp2Q
         I+lBtm8qb1W6noE2JhMFUO8ayOZUNRNwMa6kPg0tPLrcUWNvRaW0GsZ0xkiLPtqBHAQn
         LYY22l2pG7TdgKjGlasx5Gn4+NZr+aTpbP6pKoJ6BzisrxGohWtVDsMBrV5f8H/r0oPJ
         lLfOL3ncOPKWmlWE0CE1ydjuHmQnK4bj4d3HrUgGvjNjBotgy0RNZuRf19Fvbvd6N8DW
         HWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=xBy0RyxY7ucF1byw53i2p0gDr5HB0Y8vQAGUeLhb4Nw=;
        b=2jah/fWOH0WwT8UYHK/LYS8Vd+Jq74OjKKyzDj+U699L4I6SDKLCpYcLZHBeljan8G
         HtN51C2Xg4kDgm2DM+TK/HiuSCVGm4J4tzJ/JGr19mKH9AiMM64EBlcMspcYJ2B3pP0k
         YS3EwTY8uImbrXSsvQ6/+dBv/NLKzKIiiwmb4MB/wOg8i9OdEOvFxsSGmCXwn/Zicpx2
         xUg9G6Jm2ASSd4wyuW0CgO0GTc7vg3fHC+7gdrVqv0hgXztrPC8ydn/N/x8jQ3sfkBK5
         ImpCXEX0a2h4p1vhKxuyOUeyH+f4Gp+ADakjzebSYT19gtIIskpFjnad6bDU7d2e+PYm
         PDgg==
X-Gm-Message-State: ACgBeo3Fe7NhnSswL+S7WgRieGpJ+96ESBgYac4yvkoay28XJ9eTrosf
        hlMD8fiPGO/c9mtFGDOp4XGFAlkyoxo77w==
X-Google-Smtp-Source: AA6agR7PCyzb5YVSvS+6AdXqgLMbW8L15LA/VifDyKx6jYzQK8K1cu0GvqexPs9lQ0GJmQL5ScS7GIZd89KfAw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:edc3:b0:172:8ae3:9778 with SMTP
 id q3-20020a170902edc300b001728ae39778mr31884883plk.72.1662065734205; Thu, 01
 Sep 2022 13:55:34 -0700 (PDT)
Date:   Thu, 01 Sep 2022 13:55:32 -0700
In-Reply-To: <patch-v4-31.33-a0d71b4e8bb-20220831T230519Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
 <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com> <patch-v4-31.33-a0d71b4e8bb-20220831T230519Z-avarab@gmail.com>
Message-ID: <kl6lzgfibyrf.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 31/33] submodule--helper: libify more "die" paths for module_update()
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

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> As noted in a preceding commit the get_default_remote_submodule() and
> remote_submodule_branch() functions would invoke die(), and thus leave
> update_submodule() only partially lib-ified. Let's address the former
> of those cases.
>
> Change the functions to return an int exit code (non-zero on failure),
> while leaving the get_default_remote() function for the callers that
> still want the die() semantics.
>
> This change addresses 1/2 of the "die" issue in these two lines in
> update_submodule():
>
> 	char *remote_name =3D get_default_remote_submodule(update_data->sm_path)=
;
> 	const char *branch =3D remote_submodule_branch(update_data->sm_path);
>
> We can safely remove the "!default_remote" case from sync_submodule(),
> because our get_default_remote_submodule() function now returns a
> die_message() on failure, so we can have it an dother callers check if

If I'm reading this correctly, s/an dother/and other ?

> the exit code should be non-zero instead.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 58 +++++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index dfd71f0f2b2..9de3a3c921a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -31,48 +31,57 @@
>  typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
>  				  void *cb_data);
> =20
> -static char *repo_get_default_remote(struct repository *repo)
> +static int repo_get_default_remote(struct repository *repo, char **defau=
lt_remote)
>  {
> -	char *dest =3D NULL, *ret;
> +	char *dest =3D NULL;
>  	struct strbuf sb =3D STRBUF_INIT;
>  	struct ref_store *store =3D get_main_ref_store(repo);
>  	const char *refname =3D refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
>  						      NULL);
> =20
>  	if (!refname)
> -		die(_("No such ref: %s"), "HEAD");
> +		return die_message(_("No such ref: %s"), "HEAD");
> =20
>  	/* detached HEAD */
> -	if (!strcmp(refname, "HEAD"))
> -		return xstrdup("origin");
> +	if (!strcmp(refname, "HEAD")) {
> +		*default_remote =3D xstrdup("origin");
> +		return 0;
> +	}
> =20
>  	if (!skip_prefix(refname, "refs/heads/", &refname))
> -		die(_("Expecting a full ref name, got %s"), refname);
> +		return die_message(_("Expecting a full ref name, got %s"),
> +				   refname);
> =20
>  	strbuf_addf(&sb, "branch.%s.remote", refname);
>  	if (repo_config_get_string(repo, sb.buf, &dest))
> -		ret =3D xstrdup("origin");
> +		*default_remote =3D xstrdup("origin");
>  	else
> -		ret =3D dest;
> +		*default_remote =3D dest;
> =20
>  	strbuf_release(&sb);
> -	return ret;
> +	return 0;
>  }
> =20
> -static char *get_default_remote_submodule(const char *module_path)
> +static int get_default_remote_submodule(const char *module_path, char **=
default_remote)
>  {
>  	struct repository subrepo;
> =20
>  	if (repo_submodule_init(&subrepo, the_repository, module_path,
>  				null_oid()) < 0)
> -		die(_("could not get a repository handle for submodule '%s'"),
> -		    module_path);
> -	return repo_get_default_remote(&subrepo);
> +		return die_message(_("could not get a repository handle for submodule =
'%s'"),
> +				   module_path);
> +	return repo_get_default_remote(&subrepo, default_remote);
>  }
> =20
>  static char *get_default_remote(void)
>  {
> -	return repo_get_default_remote(the_repository);
> +	char *default_remote;
> +	int code =3D repo_get_default_remote(the_repository, &default_remote);
> +
> +	if (code)
> +		exit(code);
> +
> +	return default_remote;
>  }
> =20
>  static char *resolve_relative_url(const char *rel_url, const char *up_pa=
th, int quiet)
> @@ -1159,6 +1168,7 @@ static void sync_submodule(const char *path, const =
char *prefix,
>  	char *sub_origin_url, *super_config_url, *displaypath, *default_remote;
>  	struct strbuf sb =3D STRBUF_INIT;
>  	char *sub_config_path =3D NULL;
> +	int code;
> =20
>  	if (!is_submodule_active(the_repository, path))
>  		return;
> @@ -1198,10 +1208,9 @@ static void sync_submodule(const char *path, const=
 char *prefix,
>  		goto cleanup;
> =20
>  	strbuf_reset(&sb);
> -	default_remote =3D get_default_remote_submodule(path);
> -	if (!default_remote)
> -		die(_("failed to get the default remote for submodule '%s'"),
> -		      path);
> +	code =3D get_default_remote_submodule(path, &default_remote);
> +	if (code)
> +		exit(code);
> =20
>  	remote_key =3D xstrfmt("remote.%s.url", default_remote);
>  	free(default_remote);
> @@ -2422,9 +2431,16 @@ static int update_submodule(struct update_data *up=
date_data)
>  				   update_data->displaypath);
> =20
>  	if (update_data->remote) {
> -		char *remote_name =3D get_default_remote_submodule(update_data->sm_pat=
h);
> -		const char *branch =3D remote_submodule_branch(update_data->sm_path);
> -		char *remote_ref =3D xstrfmt("refs/remotes/%s/%s", remote_name, branch=
);
> +		char *remote_name;
> +		const char *branch;
> +		char *remote_ref;
> +		int code;
> +
> +		code =3D get_default_remote_submodule(update_data->sm_path, &remote_na=
me);
> +		if (code)
> +			return code;
> +		branch =3D remote_submodule_branch(update_data->sm_path);
> +		remote_ref =3D xstrfmt("refs/remotes/%s/%s", remote_name, branch);
> =20
>  		if (!update_data->nofetch) {
>  			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
> --=20
> 2.37.3.1420.g76f8a3d556c
