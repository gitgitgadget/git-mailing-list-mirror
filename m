Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EC7C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 04:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiHCEhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiHCEhD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 00:37:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BDE5073D
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 21:37:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q12-20020a17090aa00c00b001f228eb8b84so504391pjp.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 21:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=iNQ4vkNaI1Iruq5iNxmBYHOslzoSIPSMoGCxvcSKqmg=;
        b=dGHnFub4yP46s/BRqGr+wBaBr0G+2rkwQbGdetKjVJWy0Z6imFMo4Ok0pd2XPpo9YU
         prrWv4y+7IJcj8VCQ9zNI0s1SHBEJ1IQlQ4GFuGN0soi+IntuK9mO69fAMTy1fEI1cLD
         a1Y2q/bP95MC08sCW/V0MF7kT/oxxX+62R+WkcYtOTcKI3FNWsmQdmUGDZ/PddrheAbI
         i8dNSBclyx0F+3v1uidn3nepSyVZvdnyWX4Q2IZTW8k0GgzHNh+xBk6UeEkI8wm4UzfH
         qO3Od9hhBdifXCzhbDWAXapPTySJTf6ysU0UfX7MVf/SNmHO1eJPVW2l21FR8QId2Vgz
         nLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=iNQ4vkNaI1Iruq5iNxmBYHOslzoSIPSMoGCxvcSKqmg=;
        b=ylv+O57FOES02vtzjadI/ubujCwlVbck1garhzhGhTSd6ghGoxO/k0KqTp59N+3V3l
         hCjVsAjN4xqQ4XgvCY3VkkQDKcimF73VX5xxCTs2YVOHUnfQ6oFr26nPPPBCqYC1TP7C
         kuGkEnuTw224uRuRkfn84pOuPryfD3vMoPMiLRkfRv7DCrm35YTwmwIGRxDjYA0XyeIh
         tZaWzenDZ12OyKLCFM8I1Ddg+4MSlIG+e8BXVSf6ik9ZJmWl5gDBy9DqMvmBAWDrZqUO
         PZoO2Oa0CcbUywXlN3QXrsC8VBuLCI2Cr0juQujumPjpGroDj3wT1YxdcOYSykcSgHoC
         hqIQ==
X-Gm-Message-State: ACgBeo18NQC6lpOUpB0uLSFT1Ivm9gptqeKBit8pZJxpc8s42kQsQHdA
        z1/PDnq12s1bev3GvxObsaR2QTEh1oE5WQ==
X-Google-Smtp-Source: AA6agR6HZLoAN8la6cNWJGLGE2A0YmICz4aq+T0LrkSs99he6SZKHD4hYBV0AHHT4Mri9Iyp1tcJEDNeJOCoLg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:4388:0:b0:41b:c071:d21f with SMTP id
 m8-20020a654388000000b0041bc071d21fmr15020196pgp.335.1659501421834; Tue, 02
 Aug 2022 21:37:01 -0700 (PDT)
Date:   Tue, 02 Aug 2022 21:37:00 -0700
In-Reply-To: <patch-v2-26.28-b48705c6cc0-20220802T154036Z-avarab@gmail.com>
Message-Id: <kl6lfsiet02b.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com> <patch-v2-26.28-b48705c6cc0-20220802T154036Z-avarab@gmail.com>
Subject: Re: [PATCH v2 26/28] submodule--helper: libify "must_die_on_failure"
 code paths
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

> In preceding commits the codepaths around update_submodules() were
> changed from using exit() or die() to ferrying up a
> "must_die_on_failure" in the cases where we'd exit(), and in most
> cases where we'd die().
>
> We needed to do this this to ensure that we'd early exit or otherwise
> abort the update_submodules() processing before it was completed.
>
> Now that those preceding changes have shown that we've converted those
> paths, we can remove the remaining "ret =3D=3D 128" special-cases, leavin=
g
> the only such special-case in update_submodules(). I.e. we now know
> after having gone through the various codepaths that we were only
> returning 128 if we meant to early abort.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2b78fa7573f..79a11992d1c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2147,8 +2147,7 @@ static int fetch_in_submodule(const char *module_pa=
th, int depth, int quiet, str
>  	return run_command(&cp);
>  }
> =20
> -static int run_update_command(struct update_data *ud, int subforce,
> -			      int *must_die_on_failure)
> +static int run_update_command(struct update_data *ud, int subforce)
>  {
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	char *oid =3D oid_to_hex(&ud->oid);
> @@ -2211,8 +2210,6 @@ static int run_update_command(struct update_data *u=
d, int subforce,
>  			    ud->update_strategy.type);
>  		}
> =20
> -		if (ret =3D=3D 128)
> -			*must_die_on_failure =3D 1;
>  		return ret;
>  	}
> =20
> @@ -2244,8 +2241,7 @@ static int run_update_command(struct update_data *u=
d, int subforce,
>  	return 0;
>  }
> =20
> -static int run_update_procedure(struct update_data *ud,
> -				int *must_die_on_failure)
> +static int run_update_procedure(struct update_data *ud)
>  {
>  	int subforce =3D is_null_oid(&ud->suboid) || ud->force;
> =20
> @@ -2272,7 +2268,7 @@ static int run_update_procedure(struct update_data =
*ud,
>  			    ud->displaypath, oid_to_hex(&ud->oid));
>  	}
> =20
> -	return run_update_command(ud, subforce, must_die_on_failure);
> +	return run_update_command(ud, subforce);
>  }
> =20
>  static const char *remote_submodule_branch(const char *path)
> @@ -2408,8 +2404,7 @@ static void update_data_to_args(struct update_data =
*update_data, struct strvec *
>  				    "--no-single-branch");
>  }
> =20
> -static int update_submodule(struct update_data *update_data,
> -			    int *must_die_on_failure)
> +static int update_submodule(struct update_data *update_data)
>  {
>  	int ret;
> =20
> @@ -2454,11 +2449,9 @@ static int update_submodule(struct update_data *up=
date_data,
>  	}
> =20
>  	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->for=
ce) {
> -		ret =3D run_update_procedure(update_data, must_die_on_failure);
> -		if (*must_die_on_failure)
> -			return ret;
> +		ret =3D run_update_procedure(update_data);
>  		if (ret)
> -			return 1;
> +			return ret;
>  	}
> =20
>  	if (update_data->recursive) {
> @@ -2476,12 +2469,9 @@ static int update_submodule(struct update_data *up=
date_data,
> =20
>  		/* die() if child process die()'d */
>  		ret =3D run_command(&cp);
> -		if (!ret)
> -			return 0;
> -		die_message(_("Failed to recurse into submodule path '%s'"),
> -			    update_data->displaypath);
> -		if (ret =3D=3D 128)
> -			*must_die_on_failure =3D 1;
> +		if (ret)
> +			die_message(_("Failed to recurse into submodule path '%s'"),
> +				    update_data->displaypath);
>  		return ret;
>  	}
> =20
> @@ -2514,17 +2504,16 @@ static int update_submodules(struct update_data *=
update_data)
> =20
>  	for (i =3D 0; i < suc.update_clone_nr; i++) {
>  		struct update_clone_data ucd =3D suc.update_clone[i];
> -		int must_die_on_failure =3D 0;
>  		int code;
> =20
>  		oidcpy(&update_data->oid, &ucd.oid);
>  		update_data->just_cloned =3D ucd.just_cloned;
>  		update_data->sm_path =3D ucd.sub->path;
> =20
> -		code =3D update_submodule(update_data, &must_die_on_failure);
> +		code =3D update_submodule(update_data);
>  		if (code)
>  			ret =3D code;
> -		if (must_die_on_failure)
> +		if (code =3D=3D 128)
>  			goto cleanup;
>  		else if (code)
>  			ret =3D 1;

This hunk makes sense in the context of this patch, but

		if (code)
			ret =3D code;
		if (code =3D=3D 128)
			goto cleanup;
		else if (code)
			ret =3D 1;

reads a bit awkwardly. Maybe we could drop "code" altogether and just
have:

		if (ret =3D=3D 128)
			goto cleanup;
		else if (ret)
			ret =3D 1;

But I don't feel strongly either way.

> --=20
> 2.37.1.1233.ge8b09efaedc
