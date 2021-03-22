Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FA7C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 07:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F53B61973
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 07:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVHoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCVHnu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 03:43:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F861C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 00:43:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt15so10100975ejb.12
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Xkk6hM6dQAARh0Zb+g43awdXeB2uGlYtRdy0UsBAks=;
        b=DX49IBp2U6s1ftY1n2+fPz992rQg5X5Oi/jCu9GI5UdX6oBB0pwQS0ksOCNlcLpUG2
         15V5s0hG227jENJtbSUBQBjrz7hrEXnBX+H5Fha3eQMUI9luSQRR5zoIztMGGJ42dlUx
         jRBNr2R0ddGTspKcEY46Oldie0OLl3mwDvyxUe5E5PsPbyRgoGD5iyWGwLbfEa80HRov
         CAeOmoIOfR79NbC9PPI7G5cbSw1gkyhqS3k8ZfxHHpaoFKk2wjU8XZ3Za5ckSHNTad1L
         RoDodpIWvsQKabW91wjTu4hvZ4O9MRs0NKjLNTCwRx3nqLVQgVaIX1xdWIoxO01ffEke
         n5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Xkk6hM6dQAARh0Zb+g43awdXeB2uGlYtRdy0UsBAks=;
        b=aLERFbXJbDOpoe1EYwNyNRPu73iXFkQvX/PwGAxz7ptmlnpcpFON2ga1eYZU+FK435
         9E736vYxSRiIfKgu7d/euLdNhLTX/2wzO2FMgHl6wj7PkTIOFIfxYF4zgSAw7S6bkTIn
         fD/X4LyXY9u20FXzJ4Oq7Zgx3W9umeIFzRXoU5bTFMuNUEL839IDWx7pBvg7Et6VHs2j
         umBCA3Gu+TOV0evegQqeGbaRBYbaOR+Z618TWx7w+/3DOZ7o6gAvhw5eBSpXrs/GWDt+
         YF3U72Wmy/qC6oB9xRS5YjEhGcsfy8nJ5Ef1m787lt5JaAe7CFftshfKOrQx/rmx53H8
         CdAw==
X-Gm-Message-State: AOAM533oD1hfYsDygOnU4VaCF6aayKGrfrYTW4Tn2Z9u682BpiuxCIAO
        nUQsua8RzdBfqLWZmAUGVE/H7cbp3l3rFwyXbQI=
X-Google-Smtp-Source: ABdhPJxDRfBK9QxR6G6HcTDKa/E82FM8rRgEVvfRFdkPWK/YdFUiZj39sQ/Ch3YGjDBMEocjvGJjQ8U/l0JNukylhu0=
X-Received: by 2002:a17:906:86c6:: with SMTP id j6mr17213290ejy.197.1616399028593;
 Mon, 22 Mar 2021 00:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com> <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 22 Mar 2021 08:43:37 +0100
Message-ID: <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 5:24 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Historically, Git has supported the 'Signed-off-by' commit trailer
> using the '--signoff' and the '-s' option from the command line.
> But users may need to provide other trailer information from the
> command line such as "Helped-by", "Reported-by", "Mentored-by",
>
> Now implement a new `--trailer <token>[(=|:)<value>]` option to pass
> other trailers to `interpret-trailers` and insert them into commit
> messages.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> Reported-by:

Why is there this "Reported-by:" trailer with an empty value? If you
are looking to add trailers to this commit message, you might want to
add them before your "Signed-off-by".

> ---
>     [GSOC] commit: add --trailer option
>
>     Now maintainers or developers can also use commit
>     --trailer="Signed-off-by:commiter<email>" from the command line to
>     provide trailers to commit messages. This solution may be more
>     generalized than v1.

It's not a big deal as this is not going into the commit message, but
at this point (v13) you might want to tell explicitly what solution v1
implemented, instead of referring to it.

>      @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '>       + sed -e "1,/^\$/d" commit.msg >actual &&
>       + test_cmp expected actual
>       +'
>      ++
>      ++test_expect_success 'commit --trailer with -c and command' '
>      ++ trailer_commit_base &&
>      ++ cat >expected <<-\EOF &&
>      ++ hello
>      ++
>      ++ Signed-off-by: C O Mitter <committer@example.com>
>      ++ Signed-off-by: C1 E1
>      ++ Helped-by: C2 E2
>      ++ Mentored-by: C4 E4
>      ++ Reported-by: A U Thor <author@example.com>
>      ++ EOF
>      ++ git -c trailer.report.key="Reported-by: " \
>      ++         -c trailer.report.ifexists="replace" \
>      ++         -c trailer.report.command="git log --author=\"\$ARG\" -1 \
>      ++         --format=\"format:%aN <%aE>\"" \
>      ++         commit --trailer "report = author" --amend &&
>      ++ git cat-file commit HEAD >commit.msg &&
>      ++ sed -e "1,/^\$/d" commit.msg >actual &&
>      ++ test_cmp expected actual
>      ++'

Nice that you have added such a test!
