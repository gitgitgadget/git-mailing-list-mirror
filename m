Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CDEC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1358B613DF
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFEPWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 11:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEPWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 11:22:37 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839DC061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 08:20:49 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so12092371otp.4
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2arq/D7pd7FsKvGlToOYMUSYSGVI7FkpqkmeHLCS1AI=;
        b=bDoF2sXcl+ghFZrESHxmGrIlHAxH1nIoX7wvRF6RU7Yhy7LGC5Va0xBihZPx+VXczG
         S8R9grUqAlZ4qmi5r7etQ8O4kBoriob62ANqY/93nun4Q4SncIjIDhRuSJzl5PFgQZs4
         lW9Hvayu2R0XCLCd8whlFcAg4GQtd6iL87BPxzLeC0nfNYFscRxfciIy4lpVaDJmiVKM
         C31RevSPRv8HpJQnzBoMAjUynTfKNgslmw7fsONVXkq1VIdVCy1QuSWK6Po5GqTDjhYW
         ZirKps3gL3TL+f87b9vAMFa+NXSjNazl1KCoiN+v6XlYx7ihf+pAWF7kIqIxFrc4+WuN
         OAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2arq/D7pd7FsKvGlToOYMUSYSGVI7FkpqkmeHLCS1AI=;
        b=XtSEyIKPseWCJczSD16G/cGJeZWMjYOoepCKHx943kGzZ3RqHEI0lI5cGjDsfKGnxY
         4vfkFmLCUNkoez+pDTidZCIyDllplalHeI2yigBJ1+9QG3KUPjvEsiHfgMtqaFu0607x
         V/puSxLGQj9uezy+U+VDOZNuB6x+GTqPKBeR+mhffgl876SqyTiLRVs3b+AMjGc19IMk
         tn3vN9x5SHFbbGBYLXnN3K6lp90X+Z5VNXcV8yXlA7as3t5WakrWZOUPRiUCYpn11zjT
         QUKNO7eO+8qfuUunc1kavXfiXCyX1vD1Z5uOnDu4SrwMGypqABy3bHI7FgTPiCDGnozn
         P3nQ==
X-Gm-Message-State: AOAM533kc5mVzk9bxceVLIkDbTx2KySuf74ZsIMX/1j08I9x6x2fgueI
        KyLBWhspn7YXksQZhNh5+bzeJ/62x3ZTiH+yoXs=
X-Google-Smtp-Source: ABdhPJyDJ3UrbGdJktAJLs711D42MsdW15XhWo55+tPHO+X53PMnBsv+6DHEvL8n8ZcvurWRxuv/6XutOhD/b+VH+gw=
X-Received: by 2002:a9d:a13:: with SMTP id 19mr7863000otg.131.1622906448831;
 Sat, 05 Jun 2021 08:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com> <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
In-Reply-To: <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 5 Jun 2021 20:50:37 +0530
Message-ID: <CA+CkUQ9f8kN=S8dU_zt=-uG1pcK8cE9CuhJdqR9oMwcguZ9FLg@mail.gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Jun 5, 2021 at 2:43 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -670,6 +674,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                         N_("print only branches of the object"), parse_opt_object_name),
>                 OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
>                 OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
> +               OPT_STRING(0, "rest", &format.rest, N_("rest"), N_("specify %(rest) contents")),
>                 OPT_END(),
>         };
>

Although it's not related to this patch. But I just noticed an unusual
extra space(s) before the first argument of `OPT_STRING()`. (above the
line you added)

> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -37,6 +37,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>
>                 OPT_GROUP(""),
>                 OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
> +               OPT_STRING(  0 , "rest", &format.rest, N_("rest"), N_("specify %(rest) contents")),
>                 OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
>                 OPT__COLOR(&format.use_color, N_("respect format colors")),
>                 OPT_REF_SORT(sorting_tail),

Here too in `OPT_INTEGER()` and `OPT_INTEGER()`.

Also, I don't think these extra space(s) are intended. So you don't
need to imitate them.

> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -481,6 +486,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>                 OPT_STRING(  0 , "format", &format.format, N_("format"),
>                            N_("format to use for the output")),
>                 OPT__COLOR(&format.use_color, N_("respect format colors")),
> +               OPT_STRING(0, "rest", &format.rest, N_("rest"), N_("specify %(rest) contents")),
>                 OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
>                 OPT_END()
>         };

Here too in the first line.

Thanks,
Hariom
