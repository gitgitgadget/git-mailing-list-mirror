Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4EAC43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 18:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359098AbiFVS5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiFVS5U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 14:57:20 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06AC167E9
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 11:57:18 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q102-20020a17090a17ef00b001ec706653e0so142503pja.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=2yWtCGWw0rr7+HyQ1+A3l53HLSK8k4u8tPLg43JaSx4=;
        b=kMexWRoGGcMN/e+7l0UMqgzai5uoFbl3Hs63oxBgM/cgqEeAH/lEmwbYc4Vuz5lXOD
         48WyUszc/S3kVzCxINGor3SiVqSS5KUilllEldsXIOj1EmKa9O52HgJpHSE/x7Fjz5P/
         VVTwsroFJ9QQ1H6Fta9sGHu+BoJQxER2gB6+tsVz8XiPSlPt/xL3CKOeMmhx/ZVZfsd/
         Ox8AS/hCx0sSOPJE7K6VF86FyR75sEOfNOH/+Q7mHKuRHsxtAXZQBWHfLzEGOJiCpv1L
         BftNSes2boapEvpHxrqfiYkN7sel2cCgQDUcd8SRv6pitkwH84lCMZmyv0iHlKVRGuZA
         i6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=2yWtCGWw0rr7+HyQ1+A3l53HLSK8k4u8tPLg43JaSx4=;
        b=wMcaioP0LxB3RbUpuol2kb1yGitKS2hdg/1bwGHB9955vZA81eFwF+GTFKSvwqqWs/
         zTYvscwwl2pnek9FBJlj/G7M4ilcaaJigAaEYPuL5nVzBIC5CQtd/As8/S/W6v+BsHUs
         305LgDzY/EWbeozB5TZt0FHnCu0k/TDSC14+sroJuG8ikS5wRP8dhmNMTUYeLerJHjWI
         R9A0YvC6LfemqKAn6LQcugkxGCLYTQgc+GzGGH62c4hux0cYtSVgRGrpUd3ZU0qQ1tEs
         JidnFjrSjiobdUXXnuctA4Dzgg0EKau1nOBpsKl+a8mKTDN/MRNQHV3pCdUiEIayiF/j
         UIBQ==
X-Gm-Message-State: AJIora+U32dB759SeIu1g98T5r/zOlvp+Xs62ZAX00ofuoCQiE/AcklJ
        0hAZ51C9C0rIIKz3lAVfyNjMYORtYiFyfQ==
X-Google-Smtp-Source: AGRyM1uC87aEK2YaPLYwRsLj9X6o6kIjV+gWH933QAlxMxfLYLA4zR8Fgq2wgpIft6DywobRV1OsH3Mnw2uymg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr39609pje.0.1655924238065; Wed, 22 Jun
 2022 11:57:18 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:57:16 -0700
In-Reply-To: <patch-v3-09.12-e251fc115e1-20220622T142012Z-avarab@gmail.com>
Message-Id: <kl6lzgi4il0z.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <patch-v3-09.12-e251fc115e1-20220622T142012Z-avarab@gmail.com>
Subject: Re: [PATCH v3 09/12] submodule--helper: understand --checkout,
 --merge and --rebase synonyms
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


As you noted in your cover letter, this version of 09-10/12 is a lot
cleaner and more obviously correct.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Understand --checkout, --merge and --rebase synonyms for
> --update=3D{checkout,merge,rebase}, as well as the short options that
> 'git submodule' itself understands.
>
> This removes a difference between the CLI API of "git submodule" and
> "git submodule--helper", making it easier to make the latter an alias
> for the former. See 48308681b07 (git submodule update: have a
> dedicated helper for cloning, 2016-02-29) for the initial addition of
> --update.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 30 ++++++++++++++++++++++++++++++
>  git-submodule.sh            | 14 +++++++++-----
>  2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 6af09d78d4b..928b7a948b2 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2405,6 +2405,23 @@ static void ensure_core_worktree(const char *path)
>  	}
>  }
> =20
> +static const char *submodule_update_type_to_label(enum submodule_update_=
type type)
> +{
> +	switch (type) {
> +	case SM_UPDATE_CHECKOUT:
> +		return "checkout";
> +	case SM_UPDATE_MERGE:
> +		return "merge";
> +	case SM_UPDATE_REBASE:
> +		return "rebase";
> +	case SM_UPDATE_UNSPECIFIED:
> +	case SM_UPDATE_NONE:
> +	case SM_UPDATE_COMMAND:
> +		break;
> +	}
> +	BUG("unreachable with type %d", type);
> +}
> +
>  static void update_data_to_args(struct update_data *update_data, struct =
strvec *args)
>  {
>  	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
> @@ -2583,6 +2600,7 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>  	struct update_data opt =3D UPDATE_DATA_INIT;
>  	struct list_objects_filter_options filter_options;
>  	int ret;
> +	enum submodule_update_type update_type =3D SM_UPDATE_UNSPECIFIED;
> =20
>  	struct option module_update_options[] =3D {
>  		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
> @@ -2604,6 +2622,15 @@ static int module_update(int argc, const char **ar=
gv, const char *prefix)
>  		OPT_STRING(0, "update", &opt.update_default,
>  			   N_("string"),
>  			   N_("rebase, merge, checkout or none")),
> +		OPT_SET_INT(0, "checkout", &update_type,
> +			N_("use the 'checkout' update strategy (default)"),
> +			SM_UPDATE_CHECKOUT),
> +		OPT_SET_INT('m', "merge", &update_type,
> +			N_("use the 'merge' update strategy"),
> +			SM_UPDATE_MERGE),
> +		OPT_SET_INT('r', "rebase", &update_type,
> +			N_("use the 'rebase' update strategy"),
> +			SM_UPDATE_REBASE),
>  		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
>  			   N_("reference repository")),
>  		OPT_BOOL(0, "dissociate", &opt.dissociate,
> @@ -2653,6 +2680,9 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>=20
>   opt.filter_options =3D &filter_options;
>=20
> +	if (update_type !=3D SM_UPDATE_UNSPECIFIED)
> +		opt.update_default =3D submodule_update_type_to_label(update_type);
> +
>   if (opt.update_default)
>     if (parse_submodule_update_strategy(opt.update_default,
>                 &opt.update_strategy) < 0)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 1c1dc320922..7fc7119fb21 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -40,7 +40,9 @@ require_init=3D
>  files=3D
>  remote=3D
>  nofetch=3D
> -update=3D
> +rebase=3D
> +merge=3D
> +checkout=3D
>  custom_name=3D
>  depth=3D
>  progress=3D
> @@ -260,7 +262,7 @@ cmd_update()
>       force=3D$1
>       ;;
>     -r|--rebase)
> -			update=3D"rebase"
> +			rebase=3D1
>       ;;
>     --reference)
>       case "$2" in '') usage ;; esac
> @@ -274,13 +276,13 @@ cmd_update()
>       dissociate=3D1
>       ;;
>     -m|--merge)
> -			update=3D"merge"
> +			merge=3D1
>       ;;
>     --recursive)
>       recursive=3D1
>       ;;
>     --checkout)
> -			update=3D"checkout"
> +			checkout=3D1
>       ;;
>     --recommend-shallow)
>       recommend_shallow=3D"--recommend-shallow"
> @@ -341,7 +343,9 @@ cmd_update()
>     ${init:+--init} \
>     ${nofetch:+--no-fetch} \
>     ${wt_prefix:+--prefix "$wt_prefix"} \
> -		${update:+--update "$update"} \
> +		${rebase:+--rebase} \
> +		${merge:+--merge} \
> +		${checkout:+--checkout} \
>     ${reference:+"$reference"} \
>     ${dissociate:+"--dissociate"} \
>     ${depth:+"$depth"} \

A small inelegance is that a user could theoretically pass both
"--update=3D{checkout,rebase,merge}" and "--{checkout,rebase,merge}",
where one option ends of clobbering the other (Is it last one wins?).

Ideally we'd check for this kind of invalid usage and die, but maybe
it's not worth the effort since we fix this in the next patch already?

This wouldn't happen if we squashed 09-10/12 together like I initially
suggested, but then the patches would no longer be as obviously correct.

Neither seems obviously better than the other, so I'm ok with this
either way.
