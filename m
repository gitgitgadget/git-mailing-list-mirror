Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E578C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 09:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345829AbiCUJVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbiCUJVs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 05:21:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B5FF3FB0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:20:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a8so28514019ejc.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zgigQwF4laGdGe4CnrQjde40M7e1pKNl/ozceZRFObg=;
        b=Qn4Aj+oeJFMDm0GsgbAOGbh6xXI9/iau6pgfE1p17MLVEm3Id8WQ0h+rb/RZUvZ4fF
         y4PY9pvgKxxB6zDa1FqZSSOvVGM3IgsvLpAbjurBjkGAzC1oxdqGJHdKsAzEGcaHgdD7
         Ff1HZyApoAyFr0IM8FCRTc3ZU9vQA2Dkv6qIMBIijqW1R6ix87KEjAHbY5skrpbLIi+F
         FcoGQ+3wO/7SsOh17UeybzmFuL6JYTNGOITRO07f+DymNi7BaVN9IINtrvx0vsydWIpE
         M7hlMGXb5jFYv7gSaDeoY02G1VJtGrXXy0XUHdGN0cjplSA8zcuij38WUojxdnaQ6Gjc
         x1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zgigQwF4laGdGe4CnrQjde40M7e1pKNl/ozceZRFObg=;
        b=Gb3dLdpOJI4dj6cD6IJWPmVcGPe5to4+bub4t5IjRkE6V8grjhLaKeVbZq4p/h9Wdr
         uYiwPSrX4pvmyeswDL9L/NQbLKs8sOpX+nbL0ZaP0y0ZYc7kEAVsELOM7daMHtbPxN+P
         MX5StWLuc6I4SSBqNumPgqLr08ucp3y3ADA6ZvbnI3yEAr5TubtHpMEodWVNgPw8gYsc
         84vurfJnZZm15ACucKK87qWgO8igmiB1rNE+Hbemoav9h6twDWfLKDuzZ9h5IpdSUgST
         hdWkClljdH/FAPggRptY7ZmaD7srzboqTjIGDj+1cvZfdBmRGOoU1TWzW2lfXlPIgGY5
         nZYQ==
X-Gm-Message-State: AOAM530yLY0696cT95tXyVugCCgwTvlYs1V4pJCzAuLjCatI4T/K+1pq
        u7p8uB+n3i2MSefbp0Ixxyw=
X-Google-Smtp-Source: ABdhPJx07iad/QH3PG9taVsuQ3SSsh8A56cz8OWaxktU6T/UqsDpDqSHTg7WPNsE1o9kloujK1t0aA==
X-Received: by 2002:a17:907:728b:b0:6df:8f3b:28ae with SMTP id dt11-20020a170907728b00b006df8f3b28aemr18481978ejc.336.1647854421070;
        Mon, 21 Mar 2022 02:20:21 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gt34-20020a1709072da200b006df6bb3db69sm6760482ejc.158.2022.03.21.02.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 02:20:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWED5-0007JW-Oz;
        Mon, 21 Mar 2022 10:20:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v13 15/16] ls-tree: remove FIELD_*, just use MODE_*
Date:   Mon, 21 Mar 2022 10:15:35 +0100
References: <cover.1647846935.git.dyroneteng@gmail.com>
 <b8afca193ad7edd64612595742929f245cc340f3.1647846935.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <b8afca193ad7edd64612595742929f245cc340f3.1647846935.git.dyroneteng@gmail.com>
Message-ID: <220321.86a6djd5m4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Teng Long wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> When we're picking where we should go in the optimized "show_tree"
> path there's no reason for why we need to convert our "cmdmode" of
> e.g. MODE_LONG into a FIELD_LONG_DEFAULT. Instead we can simply do
> those checks in the show_tree() function itself.
>
> Let's also make this code more future-proof by unrolling the hardcoded
> strmp() if/else if chain into something that checks a new "static
> struct" providing a bidirectional mapping between optimized formats
> and the ls_tree_cmdmode.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>

For this & any other changes I suggested which amend code introduced
earlier in the series: Let's just fix that up into the respective
commits, if you agree this is a good direction that is.

I.e. if it's good to do Y let's not first do X and then change it to Y,
we can just start with Y.

Maybe that means none of these fix-up commitsa are left at the end, and
that's OK.

> ---
>  builtin/ls-tree.c | 98 ++++++++++++++++++++++-------------------------
>  1 file changed, 46 insertions(+), 52 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index a271941540..3e756b5eee 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -23,25 +23,13 @@ static int ls_options;
>  static struct pathspec pathspec;
>  static int chomp_prefix;
>  static const char *ls_tree_prefix;
> -#define FIELD_PATH_NAME 1
> -#define FIELD_SIZE (1 << 1)
> -#define FIELD_OBJECT_NAME (1 << 2)
> -#define FIELD_TYPE (1 << 3)
> -#define FIELD_MODE (1 << 4)
> -#define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default=
 */
> -#define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)

I.e. this whole thing.

>  static const char *format;
> -static const char *default_format =3D "%(objectmode) %(objecttype) %(obj=
ectname)%x09%(path)";
> -static const char *long_format =3D "%(objectmode) %(objecttype) %(object=
name) %(objectsize:padded)%x09%(path)";
> -static const char *name_only_format =3D "%(path)";
> -static const char *object_only_format =3D "%(objectname)";

And turning this into a loop can go with the initial --format change.

> [...]

All the changes below seemed related...
