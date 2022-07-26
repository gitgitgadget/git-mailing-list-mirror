Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAE5C43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 01:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiGZBGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 21:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiGZBGk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 21:06:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E253D2656E
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:06:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z6-20020a056902054600b00670e3c8b43fso7723392ybs.23
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=13+ticgLr9ZRjpnfhTy+1V4pxSsTLu7lKnrVCyga8r8=;
        b=YrvOUZpdZIAQcZHQMvhRpLzuFKi0pUSy3nn7tCW/CJTiEoPpaQ4Po6XTMTI0xRpzoy
         ElLhuRkoSUaudxfw7bXC9yMXwTaxIeWV+gb73tQVb01zoFtBRaHAVJxtzHmjyyLXf4hm
         tQe4QSIqGpbgilSqoh6f9hXlKJLgH9Knh/pNKd30LCwaXqOCAEyjdH5D/ETxvrBIk0KV
         F9msJ986UKpt35zJK8qJk1QgeCgORUukeAc0TttD4J58d/TKWC/8avHoNVNeEcSYZfJV
         gjAJghw6A8Sq2Cy+pYaPrCTEfB2WLkLI4DMMa9AmCF+p9YK8zAdHLGSpKXLBLDuraTFP
         NA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=13+ticgLr9ZRjpnfhTy+1V4pxSsTLu7lKnrVCyga8r8=;
        b=4IKbq1czlVQa5h2bsq8EkZWnUgSbvsC8NzgmFP8BcmldC+ST/Ws/DMiMjH+isQy6Ra
         +sWIrQyrxXxwGp9xNjHpZyVeW6rXSd4PnTByWo3uWCbz5pQBptYfxezYRc5/Ay8zOfWn
         bjAmwjr9/ru6Bo+LTYo4dyPsk+dMfpa3Np96rSOLP7tbTiFwXuwW3GBxAHduYuAVj0xh
         NufyLfLqAQZNiX/MD+sASPids4SRoXyfO9/aHYdgcHCA4MHBO6cNclT8YY2DCCfF/Xi1
         XOsamkfAXIVsk0soFxYLkjgvWkqDnFN2WpG6yosjVRUTgGk5J57YCYMrLKJyda1P5U1x
         3s9Q==
X-Gm-Message-State: AJIora+zaEvl8NZIyUuOYN9RRWqf8/Of4hWoRAG/mtt4VcbPjKik/qY8
        WbphgH/IYtxLgG2pz/bP3Y8bIqwe03UbgQ==
X-Google-Smtp-Source: AGRyM1u6tL4RZFPXeqV/5/QQUjE4Tq50ehuJrnOb4IzpoG1LPl1hgX2wdzs/9y/VnQO+ttrVw8i6De7XJVWzZw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0d:d652:0:b0:31f:4443:968c with SMTP id
 y79-20020a0dd652000000b0031f4443968cmr1462994ywd.468.1658797599232; Mon, 25
 Jul 2022 18:06:39 -0700 (PDT)
Date:   Mon, 25 Jul 2022 18:06:37 -0700
In-Reply-To: <patch-v3-24.26-7551af195ad-20220721T191249Z-avarab@gmail.com>
Message-Id: <kl6lr128smw2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
 <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <patch-v3-24.26-7551af195ad-20220721T191249Z-avarab@gmail.com>
Subject: Re: [PATCH v3 24/26] submodule--helper: free rest of "displaypath" in
 "struct update_data"
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

> Fix a leak in code added in c51f8f94e5b (submodule--helper: run update
> procedures from C, 2021-08-24), we clobber the "displaypath" member of
> the passed-in "struct update_data" both so that die() messages in this
> update_submodule() function itself can use it, and for the
> run_update_procedure() called within this function.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b65665105e7..4e70a74357c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2551,10 +2551,11 @@ static int update_submodule(struct update_data *u=
pdate_data,
>  			    int *must_die_on_failure)
>  {
>  	int ret =3D 1;
> +	char *to_free, *restore =3D update_data->displaypath;
> =20
>  	ensure_core_worktree(update_data->sm_path);
> =20
> -	update_data->displaypath =3D get_submodule_displaypath(
> +	update_data->displaypath =3D to_free =3D get_submodule_displaypath(
>  		update_data->sm_path, update_data->prefix);
>
>  	determine_submodule_update_strategy(the_repository, update_data->just_c=
loned,
> @@ -2628,6 +2629,9 @@ static int update_submodule(struct update_data *upd=
ate_data,
> =20
>  	ret =3D 0;
>  cleanup:
> +	free(to_free);
> +	update_data->displaypath =3D restore;
> +
>  	return ret;
>  }

I'm not sure why we need to have "restore". We set
"update_data->displaypath" so that we can use it inside this function
(and its call chain), but we don't care about it outside of this call
chain at all.

If the goal is to avoid exposing a free()-d pointer, could we just do

   FREE_AND_NULL(update_data->displaypath);

instead?

> =20
> --=20
> 2.37.1.1095.g0bd6f54ba8a
