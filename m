Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F54EC433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 11:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380176AbiAULlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350189AbiAULlN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 06:41:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B643C061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:41:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u18so27708910edt.6
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lpkScMq+tIzWt0nbdMyIoNw7fx+XUi+C8wBf6+M5cXc=;
        b=HEGUyqFM9xXzjGlbQMg+g7r42mol3dg1oV62uvyxpmRbuwg1oTcAE2xDm1Xtk6PkSM
         Uz465mD4NtPtTufjvKDE3Lp/7HFhu8/+9I9du1+4ODS2rZ5NfVPRVm79VsVdNvFLfbs/
         o33EoRJxusoS1FntAf56vKeDEPC4xqPb5Nf/wkizF9hY0gkCIq2WleKe5Be8wTJ9mwIF
         5ntLnZD8t3+W0rdr5IvAcLQvAgFVVF8vVG1h0hUgG/9e/l0/L7EE2N5uldNdfG1RrjPo
         K+StQc47ni7QtmXUq18uy47ijmjf2whK6hWLm45fCoc8us4Q+o4MWb61q8laxUNdxx4T
         zfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lpkScMq+tIzWt0nbdMyIoNw7fx+XUi+C8wBf6+M5cXc=;
        b=c1TK+oDxfzU9eAMfvlWfYn1JwwsKwUcpLWTM4PI40/FxcIAZ8CLlF17+kYiC0QWjmJ
         16sVmVHwqxtkNSxFrJ7Y4YMJLA8rHvf98Bbz5XhJyAOn/y2Xn3PJZmQX4cbijNQh8vSl
         iVtCqyYWyxLCpOfJGOh3Hkkt+5+YyXHu2Uypg2YAfPGDzyghf20FnvViYgH+xfcw+KG/
         OgeAxNARorKLplnC6ngDuKu+fm3L+uIFGRsNxKfeAQMx2DiR1bTAV2HUNgeC2/zK5ipg
         HmoNuHTHNUDYUw690FBY14bcHF/MvBFmi5nfMYqks+g8ZTL4Be5qUFbQmOAfhByJ5ypD
         5GBA==
X-Gm-Message-State: AOAM533wqgJXrQQocNuSEOA9aBw75K5YnY3ShKu4CU0vIbMx3AjK5VVb
        Un4GLrh/BOL9Tn6HONG8MiahCQgIeuVdmQ==
X-Google-Smtp-Source: ABdhPJwrBwz6nletBQErEpMLjJjNoGm0JhNawiE3UsKLlubWvWbvpdzTm9N12mYGqCvD2IM1Z2JMYA==
X-Received: by 2002:a05:6402:5212:: with SMTP id s18mr3919061edd.359.1642765271439;
        Fri, 21 Jan 2022 03:41:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gv34sm1950495ejc.125.2022.01.21.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 03:41:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAsI2-0027Jg-Ce;
        Fri, 21 Jan 2022 12:41:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch,checkout: fix --track usage strings
Date:   Fri, 21 Jan 2022 12:27:33 +0100
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
 <220120.86zgnqli9v.gmgdl@evledraar.gmail.com> <xmqqbl06jlr6.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqbl06jlr6.fsf@gitster.g>
Message-ID: <220121.86ee51l3jd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> With that we'll now emit:
>>=20=20=20=20=20
>>     $ ./git add -h 2>&1|grep chmod
>>         --chmod[=3D](+|-)x      override the executable bit of the liste=
d files
>> ...
>> But the usage output stated that the "=3D" was mandatory before.
>
> I am not sure if it is healthy to be _that_ strict when interpreting
> the boilerplate elements in the output.  Between "git add -h" that
> gives
>
>     (1) git add --chmod( |=3D)(+|-)x
>     (2) git add --chmod=3D(+|-)x
>
> I would prefer the latter 10x as much as the former.  The choice
> "You can give either plus or minus" is very much what the reader
> must understand and it is worth reminding in the help.  Compared to
> that, "You can use the stuck form that is recommended by gitcli
> documentation when giving the argument to the --chmod option, or you
> can give the argument to the option as a separate command line
> argument", while technically correct, is not a choice that is worth
> cluttering the output and making it harder to read.
>
> To put it differently, the choice (+|-) is something the user needs
> to pick correctly to make what they want to happen happen.  On the
> other hand, the choice ( |=3D) is not.  As this is a boilerplate
> choice that is shared by any and all options that take an argument,
> once you are aware that stuck form is recommended but that separate
> form is also accepted, you'd see "git add --chmod=3Dblah" in the help
> and would not hesitate to type "git add --chmod blah".  And if you
> are not aware of the existence of the alternative, nothing is lost.
> You can type '=3D' and see what you want to see happen happen.
>
> Not cluttering the help text with an extra choice that the user does
> not have to make has a value.

I.e. if we're not going for pedantic accuracy you'd prefer the below
diff instead?

I.e. when an option doesn't take an optional argument we're going out of
our way to say that you can omit the "=3D", but we can instead just
include it and have the the explanation in gitcli(7) about when "=3D" is
optional suffice.

Also, with the sh completion if you do "git add --chm<TAB>" it expands
it to "git add --chmod=3D", i.e. the cursor is left after the "=3D" that's
not shown in the "git add -h". So always including it would be
consistent with that.
=20=20=20=20
    diff --git a/parse-options.c b/parse-options.c
    index a8283037be9..75c345bb738 100644
    --- a/parse-options.c
    +++ b/parse-options.c
    @@ -916,7 +916,7 @@ static int usage_argh(const struct option *opts, FI=
LE *outfile)
                    else
                            s =3D literal ? "[%s]" : "[<%s>]";
            else
    -               s =3D literal ? " %s" : " <%s>";
    +               s =3D literal ? "=3D%s" : "=3D<%s>";
            return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _(=
"..."));
     }
=20=20=20=20=20
Just this patch will make getopts test fail, because we'll need
e.g. this test_cmp adjusted:
=20=20=20=20
    + diff -u expect output
    --- expect      2022-01-21 11:31:17.395492260 +0000
    +++ output      2022-01-21 11:31:17.395492260 +0000
    @@ -5,7 +5,7 @@
=20=20=20=20=20
         -h, --help            show the help
         --foo                 some nifty option --foo
    -    --bar ...             some cool option --bar with an argument
    +    --bar=3D...             some cool option --bar with an argument
         -b, --baz             a short and long option
=20=20=20=20=20
     An option group Header
    @@ -13,20 +13,20 @@
         -d, --data[=3D...]      short and long option with an optional arg=
ument
=20=20=20=20=20
     Argument hints
    -    -B <arg>              short option required argument
    -    --bar2 <arg>          long option required argument
    -    -e, --fuz <with-space>
    +    -B=3D<arg>              short option required argument
    +    --bar2=3D<arg>          long option required argument
    +    -e, --fuz=3D<with-space>
                               short and long option required argument
         -s[<some>]            short option optional argument
         --long[=3D<data>]       long option optional argument
         -g, --fluf[=3D<path>]   short and long option optional argument
    -    --longest <very-long-argument-hint>
    +    --longest=3D<very-long-argument-hint>
                               a very long argument hint
    -    --pair <key=3Dvalue>    with an equals sign in the hint
    +    --pair=3D<key=3Dvalue>    with an equals sign in the hint
         --aswitch             help te=3Dt contains? fl*g characters!`
    -    --bswitch <hint>      hint has trailing tab character
    +    --bswitch=3D<hint>      hint has trailing tab character
         --cswitch             switch has trailing tab character
    -    --short-hint <a>      with a one symbol hint
    +    --short-hint=3D<a>      with a one symbol hint

It's arguably a bit odd to see the "=3D" for those that have
!opts->long_name, but on the other hand I can't think of a reason other
than it looking unusual to me for why we wouldn't include the "=3D" there
for consistency.

It's odd that we don't have the short options in --git-completion-helper
at all, so "git am -C<tab>" isn't completed", but looking at
show_gitcomp() we'd need some further adjusting to make that work.
