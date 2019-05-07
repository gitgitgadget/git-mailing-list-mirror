Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26CA1F45F
	for <e@80x24.org>; Tue,  7 May 2019 11:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEGL7T (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 07:59:19 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33220 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfEGL7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 07:59:19 -0400
Received: by mail-it1-f195.google.com with SMTP id u16so12080648itc.0
        for <git@vger.kernel.org>; Tue, 07 May 2019 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TPQQE+DmcX6WvTi6Qp8jv/VR/DsbW1WZyh4m3gK6lQ=;
        b=lqorQoziAynvi7vTVwHrFH+kqNQ5sMmsoIADP9+/Dq+Jms4cHb4pFLybf2uO5jMdp6
         mbnJ0SKy6nB7Wtbr/Plx1mqNsYL5TKV0OvQSOUO+mcQ3XbRCNua2g4L5NdBTneYRODGu
         cjKhsEmhmEZ1BrkFta/iHltTM6WX7zyIhGPXtNAvcUyGwsd410z4Oz+i8e0OdAnGGXx/
         jgiZOBMXsQUUZJQYQnjaBJj2Ujcs9E6DKP+mxTnqvTH5nNQwA7PEu2UrbFn2D0o48+cO
         wbV20ajC5m+b+zAIDDeuupU0uWeE/fqqBOn5WnFbgl21+3erHEq+l358Xao++uEc80Cl
         teVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TPQQE+DmcX6WvTi6Qp8jv/VR/DsbW1WZyh4m3gK6lQ=;
        b=OPxGv8410ov294qt9WhZBsKfdZnEPkMPW0Hg7ae4FW5jLLJMR/CKJ63u63HBF9DLH/
         RGCPgKHDEdADdDuusFFGkj1DMR9moTbQuMgM+ubTqhK0/Bct8M/9P9OAQ7V3XqeLi0fm
         tnO4Khy7M7kS43kMUo7yWUA/H+a/5hj/dHKz4u6nflYV5Z7YA8z7li5J5iNRdu3mj6/q
         Jo6wqncoe8CoFA6j5yCpGyeLrrc9Twwsg7csmsu4sUrTAGdmy9e0eT/76VH+ifpOUqDD
         uldAgzSf/ntIWtfnPZVQh+SH5/hSyegjfGeakN7/mA0pc4ThbvPrrb+shySU1WyXgl9q
         PgkQ==
X-Gm-Message-State: APjAAAVZh+lG2tkWhk3iU6jd9X+T3vk5taHPsO4n8wtEDyG2tP+PXZUM
        jSVnGHBgIxxv2F9Vwx+CsLX0ClSyfJVfcQoZDko=
X-Google-Smtp-Source: APXvYqwrLmqEUecHVr+rYWYe7vO4ALEGmBAhTLEWpxYSudvD9KmwT5jPCPx5yuPeDwZb5321P7qoPes5UJd/UbUPoo8=
X-Received: by 2002:a24:478a:: with SMTP id t132mr21872601itb.123.1557230358026;
 Tue, 07 May 2019 04:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190422122250.15248-1-pclouds@gmail.com> <20190429100525.32045-1-pclouds@gmail.com>
 <xmqq1s1bnd4q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s1bnd4q.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 7 May 2019 18:58:51 +0700
Message-ID: <CACsJy8ARjTAWqB803WWSk15Y-66SWVPiz=+M7NEQezTPWbpJwA@mail.gmail.com>
Subject: Re: [PATCH v2] parse-options: don't emit "ambiguous option" for aliases
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 7, 2019 at 10:43 AM Junio C Hamano <gitster@pobox.com> wrote:
> -- >8 --
> Subject: t0040: protect lines that are indented by spaces
>
> This block is byte-for-byte identical expected output, that contains a
> few lines that are indented in many spaces, which makes "git diff --check"
> unhappy and will break the test when "git am --whitespace=fix" is
> allowed to "correct" them.
>
> Protect the left edge with a marker character, and strip it with
> sed, which is used as a standard way to deal with this issue in our
> test suite.
>
> Signed-off-by: Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * Of course, if the right-edge need to be protected, we can do so
>    as well.
>
>  t/t0040-parse-options.sh | 94 ++++++++++++++++++++++++------------------------
>  1 file changed, 47 insertions(+), 47 deletions(-)
>
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index cebc77fab0..26373b5b72 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -7,53 +7,53 @@ test_description='our own option parser'
>
>  . ./test-lib.sh
>
> -cat >expect <<\EOF
> -usage: test-tool parse-options <options>
> -
> -    A helper function for the parse-options API.
> -
> -    --yes                 get a boolean
> -    -D, --no-doubt        begins with 'no-'
> -    -B, --no-fear         be brave
> -    -b, --boolean         increment by one
> -    -4, --or4             bitwise-or boolean with ...0100
> -    --neg-or4             same as --no-or4
> -
> -    -i, --integer <n>     get a integer
> -    -j <n>                get a integer, too
> -    -m, --magnitude <n>   get a magnitude
> -    --set23               set integer to 23
> -    -L, --length <str>    get length of <str>
> -    -F, --file <file>     set file to <file>
> -
> -String options
> -    -s, --string <string>
> -                          get a string
> -    --string2 <str>       get another string
> -    --st <st>             get another string (pervert ordering)
> -    -o <str>              get another string
> -    --list <str>          add str to list
> -
> -Magic arguments
> -    --quux                means --quux
> -    -NUM                  set integer to NUM
> -    +                     same as -b
> -    --ambiguous           positive ambiguity
> -    --no-ambiguous        negative ambiguity
> -
> -Standard options
> -    --abbrev[=<n>]        use <n> digits to display SHA-1s
> -    -v, --verbose         be verbose
> -    -n, --dry-run         dry run
> -    -q, --quiet           be quiet
> -    --expect <string>     expected output in the variable dump
> -
> -Alias
> -    -A, --alias-source <string>
> -                          get a string
> -    -Z, --alias-target <string>
> -                          get a string
> -
> +sed -e 's/^|//' >expect <<\EOF

I think we already use qz_to_tab_space to protect leading spaces
(t1450) or trailing ones (t4205). It's less strict than this though.

Anyway, if you go with 's/^|//', maybe make it a helper function too
because I'm pretty sure we have more text like this in the test suite.

There's also the "tr -d Q" trick in t4038. But that's something to
clean up if someone really have free time.

> +|usage: test-tool parse-options <options>
> +|
> +|    A helper function for the parse-options API.
> +|
> +|    --yes                 get a boolean
> +|    -D, --no-doubt        begins with 'no-'
> +|    -B, --no-fear         be brave
> +|    -b, --boolean         increment by one
> +|    -4, --or4             bitwise-or boolean with ...0100
> +|    --neg-or4             same as --no-or4
> +|
> +|    -i, --integer <n>     get a integer
> +|    -j <n>                get a integer, too
> +|    -m, --magnitude <n>   get a magnitude
> +|    --set23               set integer to 23
> +|    -L, --length <str>    get length of <str>
> +|    -F, --file <file>     set file to <file>
> +|
> +|String options
> +|    -s, --string <string>
> +|                          get a string
> +|    --string2 <str>       get another string
> +|    --st <st>             get another string (pervert ordering)
> +|    -o <str>              get another string
> +|    --list <str>          add str to list
> +|
> +|Magic arguments
> +|    --quux                means --quux
> +|    -NUM                  set integer to NUM
> +|    +                     same as -b
> +|    --ambiguous           positive ambiguity
> +|    --no-ambiguous        negative ambiguity
> +|
> +|Standard options
> +|    --abbrev[=<n>]        use <n> digits to display SHA-1s
> +|    -v, --verbose         be verbose
> +|    -n, --dry-run         dry run
> +|    -q, --quiet           be quiet
> +|    --expect <string>     expected output in the variable dump
> +|
> +|Alias
> +|    -A, --alias-source <string>
> +|                          get a string
> +|    -Z, --alias-target <string>
> +|                          get a string
> +|
>  EOF
>
>  test_expect_success 'test help' '



-- 
Duy
