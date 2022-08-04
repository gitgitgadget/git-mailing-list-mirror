Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5219BC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 18:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiHDSEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHDSEc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 14:04:32 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5141EC4B
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 11:04:32 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 92-20020a17090a09e500b001d917022847so187414pjo.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=nnSfI8SzVqqumR6wDsDZTDy63vNYkSxOW4W2IPHF1Qo=;
        b=igTTwm1csVy4ROKMWWr14oCaslXsGVpDoILKXmLHG73Nta04rjMkQPBtewD5HnpWt5
         CIgFYvJLl0ao+O6z2aq6TMpyMFANS4OfBrXffAny0eWJbMmP1RQCxvElP6raOQmzK4Wq
         4CRJ3Jevt/E4Xacdc0WZ1Am4Sr1dsydsAImH1mYksvi6rMISWzhHaoUrwuZvLxQP3TvE
         R4Ik8WAjtjWTPXrMj/HkejiZUjGg3me+Ido34DrouS1LxIdfrgqEOYZyfelgZDr4ci7N
         Z3nqKsYC7Sl86v55kUQKJzSM8UbJZjhcOo8EBPfhJLhANkdoSO6vfXSx4ZGup3OmaIX1
         tbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=nnSfI8SzVqqumR6wDsDZTDy63vNYkSxOW4W2IPHF1Qo=;
        b=ut81Tnd+7r/GwE+9kM8ZKmAzlZqBDetAr+euDcVmcXnpA3LGbEfDahYlOqF/dc90BY
         PcJqSBq/bFo08LbGpOuLIAkcxBWIuL4rXO5ZfjqrRZdPc10xUASoF7ECYf/piI2fwRoY
         s2twe8z/kru4wQNRFfvHn/LMA2zIUz0uEfFvDRX2Ovx4kUvOUA63aA2YyeRZ9DBxipYF
         v3v7/4fJMQhX7dP4xl/aMAlo5C4X/AVOqXR9hN/5/FGUsF7ZnEMn3D6gf8QQKdHXRGVM
         cUzacdpmyw5Z8SDBorT58lq0iTaNnFseXdIskXQI45CNhRztK8qCMUZ7GFZe0TpHRiX1
         QNgg==
X-Gm-Message-State: ACgBeo1AjY2NCw7OiA9pn7/mNEjTI58pgnEQJF7IqBwI/s4jC+7fZnCj
        qSMBZ/orpy0merqQCBnBtWBxzxg+QxlOhw==
X-Google-Smtp-Source: AA6agR7FsVQrtIKdhr1Ma5T7iZtN2j1pKtf4jTLuwiqLImFkIu+XVsKM84g5dQtgGDDXUa1SIDuOBCzHNp+OlQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:ba49:0:b0:41c:2713:3984 with SMTP id
 l9-20020a63ba49000000b0041c27133984mr2491390pgu.468.1659636271591; Thu, 04
 Aug 2022 11:04:31 -0700 (PDT)
Date:   Thu, 04 Aug 2022 11:04:30 -0700
In-Reply-To: <patch-v5-16.17-8f150a81507-20220802T155002Z-avarab@gmail.com>
Message-Id: <kl6l5yj7ubpt.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
 <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <patch-v5-16.17-8f150a81507-20220802T155002Z-avarab@gmail.com>
Subject: Re: [PATCH v5 16/17] submodule--helper: free rest of "displaypath" in
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
> To make managing that clobbering easier let's wrap the
> update_submodule() in a new update_submodule_outer() function, which
> will do the clobbering and free(to_free) dance for us.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 79eca6c439b..cc8f42ae6df 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2482,13 +2482,6 @@ static int update_submodule(struct update_data *up=
date_data)
>  {
>  	int ret;
> =20
> -	ret =3D ensure_core_worktree(update_data->sm_path);
> -	if (ret)
> -		return ret;
> -
> -	update_data->displaypath =3D get_submodule_displaypath(
> -		update_data->sm_path, update_data->prefix);
> -
>  	ret =3D determine_submodule_update_strategy(the_repository,
>  						  update_data->just_cloned,
>  						  update_data->sm_path,
> @@ -2554,6 +2547,24 @@ static int update_submodule(struct update_data *up=
date_data)
>  	return 0;
>  }
> =20
> +static int update_submodule_outer(struct update_data *update_data)
> +{
> +	char *to_free, *restore =3D update_data->displaypath;
> +	int ret;
> +
> +	ensure_core_worktree(update_data->sm_path);
> +
> +	update_data->displaypath =3D to_free =3D get_submodule_displaypath(
> +		update_data->sm_path, update_data->prefix);
> +
> +	ret =3D update_submodule(update_data);
> +
> +	free(to_free);
> +	update_data->displaypath =3D restore;
> +
> +	return ret;
> +}
> +

I haven't tested the alternatives yet, but on first glance using this
*_outer() pattern here seems like overkill. At least two things I can
think of are:

a) Free .displaypath using the "goto cleanup" pattern like we did
   elsewhere

...

>  static int update_submodules(struct update_data *update_data)
>  {
>  	int i, ret =3D 0;
> @@ -2586,7 +2597,7 @@ static int update_submodules(struct update_data *up=
date_data)
>  		update_data->just_cloned =3D ucd.just_cloned;
>  		update_data->sm_path =3D ucd.sub->path;
> =20
> -		code =3D update_submodule(update_data);
> +		code =3D update_submodule_outer(update_data);
>  		if (code)
>  			ret =3D code;
>  		if (code =3D=3D 128)

b) Assign and FREE_AND_NULL() update_data->displaypath here since this
   is the only caller and it already does some prep work in this hunk.

I started testing, but then realized that we don't have a
TEST_PASSES_SANITIZE_LEAK=3Dtrue for this patch, so I'll spend some more
time testing whether these alternatives even work and I'll get back to
you later.

> --=20
> 2.37.1.1233.ge8b09efaedc
