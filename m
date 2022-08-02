Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9250C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 23:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiHBXaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 19:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHBXaP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 19:30:15 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8012D
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 16:30:11 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q30-20020a17090a17a100b001f31cc4ccfbso119227pja.9
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=LMo2iGjmVFGazbFfz4O30RA5kBztC5bxkogdLdXIF6I=;
        b=SPrscE1NYBpg5ZkFeahq8XWQd/UlWkZKC6smxAkxWYZmQG/m8BRRbGRSYjN/Tds7Ef
         le8sccz7TnlvD9T6wu1MFhefaHSU7jYqyzRN3/BWinPUch7GZEJR1X9FtBDYeqww+8Cg
         tpPAqmZ5i5Q0K1AWG16xQXj5nqzX9ZZcuVBDuwFrPggQGuSAQV0iOwURF1DB29Jcgwov
         HjGvt/YEISUO5pvkZ/s4aPEydGpwKV5CL6YtZloTulDnbES1LTuyclaQQBP2k8SKsK0F
         K/WuFO0BJuS9yW3EwHLq8dCo0EGDQa3jYQpPd2yoKrDRTjWvHwDPyl+XyG6DblDB3Hfq
         RVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=LMo2iGjmVFGazbFfz4O30RA5kBztC5bxkogdLdXIF6I=;
        b=fV3MFZRlVfZ5h7lbWp1mr4IC4gdC4q/kpkWEaazfUiazYaXUbrQCV/0v9TRG+Rs0qf
         lVDGkHf4Es64dWQrSGuJ2NAHPAbCq+9SJNqHPEQXWGk6rp636YkYMXKrzc0KoE1qpaqy
         i/SLrqoPL9pc0d5d0QNDPVSXWGjbYI/OmFN7hIPlry3M65rtTE2yjLf+o4oCiZD4ZrZ7
         VuHC3XbBn7OIQkp7s/pDswSF7CO+/TYN0LhCJmQ+lGDo3mFTroNhdvAB/G61mOGi+/vn
         C9Hd5b0z5POxtEQHrSJi2dK0Q8IGgX7OvGFaI4Xskb7SMHVIf/O11tJCQs7T1RIjg1ax
         ZW/Q==
X-Gm-Message-State: ACgBeo3iE1mQVwG3+MGSWeErodhCVXF1AZ1WbuEXwHkbpB+QYYXV58RZ
        7zTu3jnI2IIDvWsb1Zl/z2rxk/lLSrMowg==
X-Google-Smtp-Source: AA6agR4ph5CT7e+CaHQ5tPdW6PU/MYMMaQEkaTmrDuCzhwwhZHlveaLm81NvPrZVnjY7weFL9LP8e/wSeJDztw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:483:b0:16d:d6c7:6118 with SMTP id
 jj3-20020a170903048300b0016dd6c76118mr20967586plb.156.1659483010565; Tue, 02
 Aug 2022 16:30:10 -0700 (PDT)
Date:   Tue, 02 Aug 2022 16:30:09 -0700
In-Reply-To: <patch-v2-22.28-98c3e562c82-20220802T154036Z-avarab@gmail.com>
Message-Id: <kl6lles6te9q.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com> <patch-v2-22.28-98c3e562c82-20220802T154036Z-avarab@gmail.com>
Subject: Re: [PATCH v2 22/28] submodule--helper: move submodule_strategy_to_string()
 to only user
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

> Move the submodule_strategy_to_string() function added in
> 3604242f080 (submodule: port init from shell to C, 2016-04-15) to its
> only user.
>
> This function would return NULL on SM_UPDATE_UNSPECIFIED, so it wasn't
> safe to xstrdup() its return value in the general case, or to use it
> in a sprintf() format as the code removed in the preceding commit did.
>
> But its callers would never call it with either SM_UPDATE_UNSPECIFIED
> or SM_UPDATE_COMMAND. Let's move it to a "static" helper, and have its
> functionality reflect how it's used, and BUG() out on the rest.
>
> By doing this we can also stop needlessly xstrdup()-ing and free()-ing
> the memory for the config we're setting. We can instead always use
> constant strings. We can also use the *_tmp() variant of
> git_config_get_string().
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 29 ++++++++++++++++++++++++-----
>  submodule.c                 | 21 ---------------------
>  submodule.h                 |  1 -
>  3 files changed, 24 insertions(+), 27 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b49528e1ba9..d787c0fead4 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -413,12 +413,32 @@ struct init_cb {
>  };
>  #define INIT_CB_INIT { 0 }
> =20
> +static const char *submodule_strategy_to_string(enum submodule_update_ty=
pe type)
> +{
> +	switch (type) {
> +	case SM_UPDATE_CHECKOUT:
> +		return "checkout";
> +	case SM_UPDATE_MERGE:
> +		return "merge";
> +	case SM_UPDATE_REBASE:
> +		return "rebase";
> +	case SM_UPDATE_NONE:
> +		return "none";
> +	case SM_UPDATE_UNSPECIFIED:
> +	case SM_UPDATE_COMMAND:
> +		BUG("init_submodule() should handle type %d", type);
> +	default:
> +		BUG("unexpected update strategy type: %d", type);
> +	}
> +}
> +

This function is meant to convert from an update strategy back to the
string that the user actually provided in their gitconfig.

The change in behavior makes this function BUG() out on types that
aren't "magic" tokens, i.e. "UNSPECIFIED" (which is obviously not
expressible) and "COMMAND" (which allows users to specify an arbitrary
command using "!", like "!cat"). It shouldn't be difficult to teach
callers to handle "COMMAND", so this seems like an ok change, though I
think we should probably amend the function name to
submodule_update_type_to_string() and change the UNSPECIFIED and COMMAND
arms to something like BUG("type %d has no corresponding string").

I'm not so convinced that this function should be static, though. I
think it's more natural for submodule_update_type_to_string() to have
the same visibility as enum submodule_update_type. Today, we only have
one other caller who uses this enum, and it doesn't even need this
_to_string() fn (fsck.c calls parse_submodule_update_type() and doesn't
need _to_string() because it has the raw config values). But it feels a
bit inevitable that this will get moved back to submodule.h.

>  static void init_submodule(const char *path, const char *prefix,
>  			   unsigned int flags)
>  {
>  	const struct submodule *sub;
>  	struct strbuf sb =3D STRBUF_INIT;
> -	char *upd =3D NULL, *url =3D NULL, *displaypath;
> +	const char *upd;
> +	char *url =3D NULL, *displaypath;
> =20
>  	displaypath =3D get_submodule_displaypath(path, prefix);
> =20
> @@ -474,14 +494,14 @@ static void init_submodule(const char *path, const =
char *prefix,
> =20
>  	/* Copy "update" setting when it is not set yet */
>  	strbuf_addf(&sb, "submodule.%s.update", sub->name);
> -	if (git_config_get_string(sb.buf, &upd) &&
> +	if (git_config_get_string_tmp(sb.buf, &upd) &&
>  	    sub->update_strategy.type !=3D SM_UPDATE_UNSPECIFIED) {
>  		if (sub->update_strategy.type =3D=3D SM_UPDATE_COMMAND) {
>  			fprintf(stderr, _("warning: command update mode suggested for submodu=
le '%s'\n"),
>  				sub->name);
> -			upd =3D xstrdup("none");
> +			upd =3D "none";
>  		} else {
> -			upd =3D xstrdup(submodule_strategy_to_string(&sub->update_strategy));
> +			upd =3D submodule_strategy_to_string(sub->update_strategy.type);
>  		}
> =20
>  		if (git_config_set_gently(sb.buf, upd))
> @@ -490,7 +510,6 @@ static void init_submodule(const char *path, const ch=
ar *prefix,
>  	strbuf_release(&sb);
>  	free(displaypath);
>  	free(url);
> -	free(upd);
>  }
> =20
>  static void init_submodule_cb(const struct cache_entry *list_item, void =
*cb_data)
> diff --git a/submodule.c b/submodule.c
> index 3fa5db3ecdf..e297d94d17f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -415,27 +415,6 @@ int parse_submodule_update_strategy(const char *valu=
e,
>  	return 0;
>  }
> =20
> -const char *submodule_strategy_to_string(const struct submodule_update_s=
trategy *s)
> -{
> -	struct strbuf sb =3D STRBUF_INIT;
> -	switch (s->type) {
> -	case SM_UPDATE_CHECKOUT:
> -		return "checkout";
> -	case SM_UPDATE_MERGE:
> -		return "merge";
> -	case SM_UPDATE_REBASE:
> -		return "rebase";
> -	case SM_UPDATE_NONE:
> -		return "none";
> -	case SM_UPDATE_UNSPECIFIED:
> -		return NULL;
> -	case SM_UPDATE_COMMAND:
> -		strbuf_addf(&sb, "!%s", s->command);
> -		return strbuf_detach(&sb, NULL);
> -	}
> -	return NULL;
> -}
> -

The rest of the changes look good. An alternative would be to _always_
return a non-const char * (e.g. return xstrdup("none")) and expect the
caller to free it, but that feels like bending over backwards to
accomodate xstrfmt("!%s").

>  void handle_ignore_submodules_arg(struct diff_options *diffopt,
>  				  const char *arg)
>  {
> diff --git a/submodule.h b/submodule.h
> index bfaa9da1868..949f67b8031 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -72,7 +72,6 @@ void die_path_inside_submodule(struct index_state *ista=
te,
>  enum submodule_update_type parse_submodule_update_type(const char *value=
);
>  int parse_submodule_update_strategy(const char *value,
>  				    struct submodule_update_strategy *dst);
> -const char *submodule_strategy_to_string(const struct submodule_update_s=
trategy *s);
>  void handle_ignore_submodules_arg(struct diff_options *, const char *);
>  void show_submodule_diff_summary(struct diff_options *o, const char *pat=
h,
>  			    struct object_id *one, struct object_id *two,
> --=20
> 2.37.1.1233.ge8b09efaedc
