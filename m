Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B14BC32793
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 00:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiHXAH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 20:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiHXAHx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 20:07:53 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0108491F2
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 17:07:52 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id f8-20020aa79d88000000b0053641810e97so4159889pfq.9
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 17:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=0q691PA29Gdom6ihQrwpY8EsgYq9K5XLM4wesHykw0M=;
        b=hvtrMRLUIvmDuNdk+CpymROUeediIUTvPs6U2YXv1DMW7rL9SYQi6n6s0ukfc9b4FD
         wnIEiEPdS4aDTr2oJE3WjV5DwJssnFzjE+d7L6wE7RmhvkDvMcQeX3+PeAOugJEsNd7u
         YshDSabKxGL+YqoE1IH4pniN3RTCZ5+1gg5t03UEz+Y6yCeIgxDXlTKnpGUONhZ2pJYJ
         uJ3kQrR+RkUKmbqS18H4ida3RZaFFu5S29oM+qq6JrfK7ZmkOvil81IFmfoH5TxmNJXY
         ce2P32SJtgiE9zmD7XCiu+XoxJm6uYcvUWxwEve1ya7rF24uiZ1cqAY7vAhRQzxjdyW6
         XQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=0q691PA29Gdom6ihQrwpY8EsgYq9K5XLM4wesHykw0M=;
        b=ABRpGIc9n0RAgXFDVLAppODvMFQDRmqb5ld33Fz51QBXe5hSUtS67kgLlGe+D3TS8Y
         6lkG3c1KVSGDT81Ce9WwZcIob6ySl2DxAvQTk4qrRBT1Cl0mzBlKFR6RA7Gv2DT5skE/
         jfd2w84ge1YIHZDJXPSLLmNZ88ODJj9+fdXJrhYbH9TfnHEgAWdquBUkKBeX95taKtsT
         afqZBezRUxHPjQJqTAtPBdPTkPogUeGqacURtyQv/+aXoe+z79Jsh07AJr6AUrG6X3G9
         RVhi6RThGXhgW/EahcU82FXYjUa+TIUdMSIb3muw2Kf3K107BpNWsnMtEu1dglH4zfMP
         PHvg==
X-Gm-Message-State: ACgBeo2krPpqPTfY9pakVqFUgzLP30lC0vwIXaFY51G2W/jaKcAcUKpS
        Qu0SOTRqnYV2FaEPnEscisTYY3JYB7akjw==
X-Google-Smtp-Source: AA6agR40ZlEK/vxUYpQ/uwIwJcO5l/SEgsAFS8HFq2R5oEkdxW7PfVVWZvuu9ZshtWurfVeYLA26i14VFMGaPw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:1d86:0:b0:52d:9df0:2151 with SMTP id
 d128-20020a621d86000000b0052d9df02151mr27072181pfd.33.1661299672266; Tue, 23
 Aug 2022 17:07:52 -0700 (PDT)
Date:   Tue, 23 Aug 2022 17:07:50 -0700
In-Reply-To: <patch-v3-30.32-15c2490a978-20220821T130231Z-avarab@gmail.com>
Message-Id: <kl6lczcq4i7d.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <patch-v3-30.32-15c2490a978-20220821T130231Z-avarab@gmail.com>
Subject: Re: [PATCH v3 30/32] submodule--helper: libify more "die" paths for module_update()
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
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 58 +++++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 88fc01320f3..9e4069b36cb 100644
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

If we fail to look up the default remote for the branch, we assume it is
"origin", otherwise, it is the default remote. So in the preimage this
function would never return NULL, right? This matters in
sync_submodule()..

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

repo_* usually denotes a difference between "the_repository" and "struct
repository", so I don't really like having [repo_]get_default_remote()
die/return differently. But it makes some sense to special case
"the_repository" since it is the top level, so if it fails, something is
very wrong. So on the whole, I'm ok with doing this to avoid disrupting
other callers.

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

In the preimage, we used to check that default_remote is not NULL, but
we don't check this any more. As we noted earlier, default_remote could
never be NULL (because we used to die() on failure), so I think we never
needed this check and it's ok to drop it.

Is this the same reasoning you had?

