Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1268AC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E720A20661
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0N5UgIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgEFIJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 04:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgEFIJo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 04:09:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3270C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 01:09:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nv1so593986ejb.0
        for <git@vger.kernel.org>; Wed, 06 May 2020 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJk41Q7BP7+rwuNPGpGfUUnjnkoydj7L6ziW1cSPlqk=;
        b=j0N5UgIzf1VFNf2gU0Znpzy0icUEzdoEN3ojAl5b/jKFlg5SVbJcmnN6Ou5IIlAT+Y
         z4XrQB3oJN+YvgcjNQnsIyP68VyJn8I42VNh2Di5SVcaRuOJ4dq2GOpgYbaf2HAnjrep
         kC1yqzYVMD+yC9iGz7/nZn8QtJ1+IIJ6EYNw+EvvNGYA55/mEmW3a/x8CnsA3Fo+LvsB
         L8TFd5DSXvY1/jUk4j+bEocxb7Yj5sBGvDaRuEMc2icMKE0lgAWvhBGre+hT+CPUgdoL
         bt8pUiXFQ8VyEgPIoDnVurQ2qOEKeA4fz6yz17SB6bm1+diJKOmuCFarquQhyC0zZiE2
         cQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJk41Q7BP7+rwuNPGpGfUUnjnkoydj7L6ziW1cSPlqk=;
        b=eNjIxDCmch0E0RWtaJla9eeYq0+iUYxHYiOf4/pY0E1qesUX0WIGGQJh2X5iy6+Ji4
         aSNNjZMwFVXQkkz/4hSizXEpdVCen4eSZ9+4pK2HOz700Am8ItCBNGnat+YBYtjKfT00
         ww1AAJbkDr6zYcdVTgGCQgg36g7ZIXZsFVq4yVvtvVHpIsUTGYzsfGVZFKkKyUiq8Q8n
         evxWoGpSEXcKDsqPnpdfv/5LBprsbf79Stgi0L7TA8e27Xvle9fOAXgs6/TNQB/NeId1
         KqHX8IZakN7aiUwBWEuspFbpLzQaWF6RsJwse6RS8rLXf9JEMWMXFNpFgzjcz5yI+qAR
         7SIg==
X-Gm-Message-State: AGi0PuZ008edphvckwxvwREr6zzhFmVkNvZxBeINSGu14O948gwI1zto
        uQvtquoTMXid56sQWhf+/Sg1scLAh0bG27t/Y4zZZL9Po3Y=
X-Google-Smtp-Source: APiQypLwLq+aYNKPDRkGxInvxMkrRB/GRZ4OS2Hh5DJUsIa+659/EXtjxNcFZAWIRxyoTaB2Rg4tViuqBNP4iHV1wNw=
X-Received: by 2002:a17:906:eb90:: with SMTP id mh16mr6303807ejb.201.1588752582495;
 Wed, 06 May 2020 01:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 6 May 2020 10:09:31 +0200
Message-ID: <CAP8UFD0o7WwibV8+cwYOO949BkBggSphi0zbgPUZsk6nfvYyHQ@mail.gmail.com>
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 6, 2020 at 9:37 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Convert submodule subcommand 'set-url' to a builtin. Port 'set-url'to

There is a space missing between "'set-url'" and "to".

> 'submodule--helper.c' and call the latter via 'git-submodule.sh'.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> Thank you Junio for the review! :)
> BTW, how detailed should the commit message be about the
> patch?

It looks good to me. Maybe it could more explicitely state that the
larger goal is to convert shell code in 'git-submodule.sh' to C code
in 'submodule--helper.c'. It can be guessed from the subject though.

>  builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 22 +--------------------
>  2 files changed, 40 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1a4b391c88..f50745a03f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2246,6 +2246,44 @@ static int module_config(int argc, const char **argv, const char *prefix)
>         usage_with_options(git_submodule_helper_usage, module_config_options);
>  }
>
> +static int module_set_url(int argc, const char **argv, const char *prefix)
> +{
> +       int quiet = 0;
> +       const char *newurl;
> +       const char *path;
> +       struct strbuf config_name = STRBUF_INIT;
> +
> +       struct option set_url_options[] = {
> +               OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
> +               OPT_END()
> +       };
> +
> +       const char *const usage[] = {
> +               N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, set_url_options,
> +                            usage, 0);
> +
> +       if (argc!=2) {

Please add space chars around "!=" like "argc != 2".

> +               usage_with_options(usage, set_url_options);
> +               return 1;
> +       }
> +
> +       path = argv[0];
> +       newurl = argv[1];
> +
> +       strbuf_addf(&config_name, "submodule.%s.url", path);
> +
> +       config_set_in_gitmodules_file_gently(config_name.buf, newurl);
> +       sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
> +
> +       strbuf_release(&config_name);

Nit: it might be a bit simpler to define config_name as a "char *",
and then use xstrfmt() and free() instead of strbuf_addf() and
strbuf_release().

> +       return 0;
> +}
