Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F64C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 20:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CADD6115C
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 20:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhDIUTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 16:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIUTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 16:19:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4683EC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 13:19:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sd23so1909809ejb.12
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chd/n2t5SxiEzeIanz0qUgqbudhYJNSF1lM1yLJrFrY=;
        b=WZqRBRHSqkTm5s4q5kHhLeAxlhR2Q/xTpCYFIJdV4X1qUXQbFEkPhqHguQkasRjHrM
         N4VZmzqdP0lWodtPHEuGifzAge8mPEib9R+AWiflE1n22VZaBJVwD95JHlTOtDOk5XC1
         xGh4IAvmTToxMKDIfsNkPfjRMBQV1NjwN5s6zM3cnWMCfdMr3zWFD5w8+tdQ40ojAkc/
         Nvau9ip8t2CAxWlu3YQkW+uIY9DVJq3BaiqSSQA6quikm4N0Jet9TOhiFyOaXRfs82wi
         DG5C42fFhxLg91UC1o5lZxHvExtlvu5iW82slBGadzpW5tB/LPHubI/OlGoYhxxZorbC
         YAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chd/n2t5SxiEzeIanz0qUgqbudhYJNSF1lM1yLJrFrY=;
        b=Cv4JGlau7MLvxqm/ZyIF8Q+RLqbQYpA8g/AvwpbsN/16mNS3tdEro46HAhLDDq2lCx
         B0TixwmcaMvid6l3BH0/WhRBmJRh1lcJYfSDtm0xUbKohgGeRev3WQQgXmbkCTSc1zNA
         d2t52zm2yReX9QEwMRKCFxF7ywocDhNvFcu39Xw+HqZwDiIjGelgM3JEWD/nLv6Ka0Me
         7cTnvdTxwqVdGrufQguE4+Zgi0XNcL64AAB8r5TiKFvOaN6LrvQaveB4Z8Rv5fX+xHWN
         BhXI85md4E9poTp1OKAhi9rC2QSHtegB7/rp31GIl7cwMCCVlPRaCir+mb3mpbSIL8nZ
         ObDw==
X-Gm-Message-State: AOAM533MX/88KhJWldlOudhlLasKl9narvkfP/8d3bFvkRxYVNA4a2O5
        Q2krf/hcDyN6u7uzaETZzdRB6rHGmSLIBjX5EaE=
X-Google-Smtp-Source: ABdhPJy3RDXl2psY/MBisTCw2GCual7ExXChl919JdTrHi3g+x0aoHSXJKdNgo7hZoR3BGI2WiD0kN3rgN9e029NLgA=
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr17835106ejt.216.1617999548840;
 Fri, 09 Apr 2021 13:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
 <pull.913.v8.git.1617975462.gitgitgadget@gmail.com> <3dc8983a47020fb417bb8c6c3d835e609b13c155.1617975462.git.gitgitgadget@gmail.com>
In-Reply-To: <3dc8983a47020fb417bb8c6c3d835e609b13c155.1617975462.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 9 Apr 2021 22:18:57 +0200
Message-ID: <CAP8UFD2A+9eaMGdK9cCfz9Kmz9w-bgiV6x7=X2Y-hmSNAuAV=Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] [GSOC] trailer: add new .cmd config option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 9, 2021 at 3:37 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> The `trailer.<token>.command` configuration variable
> specifies a command (run via the shell, so it does not have
> to be a single name of or path to the command, but can be a

s/of or/or/

> shell script), and the first occurrence of substring $ARG is
> replaced with the value given to the `interpret-trailer`
> command for the token.  This has two downsides:

Maybe: s/for the token/for the token in a '--trailer <token>=<value>' argument/

> * The use of $ARG in the mechanism misleads the users that
> the value is passed in the shell variable, and tempt them
> to use $ARG more than once, but that would not work, as
> the second and subsequent $ARG are not replaced.
>
> * Because $ARG is textually replaced without regard to the
> shell language syntax, even '$ARG' (inside a single-quote
> pair), which a user would expect to stay intact, would be
> replaced, and worse, if the value had an unmatched single
> quote (imagine a name like "O'Connor", substituted into
> NAME='$ARG' to make it NAME='O'Connor'), it would result in
> a broken command that is not syntactically correct (or
> worse).
>
> Introduce a new `trailer.<token>.cmd` configuration that
> takes higher precedence to deprecate and eventually remove
> `trailer.<token>.command`, which passes the value as an
> argument to the command.  Instead of "$ARG", users can
> refer to the value as positional argument, $1, in their
> scripts.

Good!

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-interpret-trailers.txt | 90 ++++++++++++++++++++----
>  t/t7513-interpret-trailers.sh            | 84 ++++++++++++++++++++++
>  trailer.c                                | 37 +++++++---
>  3 files changed, 187 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 3e5aa3a65ae9..1a874a93f49b 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -236,21 +236,38 @@ trailer.<token>.command::
>         be called to automatically add or modify a trailer with the
>         specified <token>.
>  +
> -When this option is specified, the behavior is as if a special
> -'--trailer <token>=<value>' argument was added at the beginning of
> -the "git interpret-trailers" command, where <value> is taken to be the
> -standard output of the specified command with any leading and trailing
> -whitespace trimmed off.
> +When this option is specified, the first occurrence of substring $ARG is
> +replaced with the value given to the `interpret-trailer` command for the
> +same token. It passes the value through `$ARG`, otherwise this option behaves
> +in the same way as 'trailer.<token>.cmd'.

Actually I think that we should say first that this behaves in the
same way as the 'trailer.<token>.cmd'.

And this should also replace the first paragraph in the description of
'trailer.<token>.command', not just the second one.

Maybe:

"This option behaves in the same way as 'trailer.<token>.cmd', except
that it doesn't pass anything as argument to the specified command.
Instead the first occurrence of substring $ARG is replaced by the
value that would be passed as argument."

> +The 'trailer.<token>.command' option has been deprecated due to the fact

s/deprecated/deprecated in favor of 'trailer.<token>.cmd'/

> +that $ARG in the user's command can only be replaced once and that the

s/can only be/is only/

> +original way of replacing $ARG was not safe.

s/was/is/

> Now the preferred option is 'trailer.<token>.cmd', which uses a positional argument to pass the value.

I think we can remove this sentence especially if we say "deprecated
in favor of 'trailer.<token>.cmd'" above.

> -The first occurrence of substring `$ARG` will be replaced with the
> -<value> part of an existing trailer with the same <token>, if any,
> -before the command is launched.
> +When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are given
> +for the same <token>, 'trailer.<token>.cmd' is used and
> +'trailer.<token>.command' is ignored.

Ok.

> +trailer.<token>.cmd::

I think we should base the description of this option on what I
suggest in patch 1/2. So let's agree on patch 1/2 before discussing
this.
