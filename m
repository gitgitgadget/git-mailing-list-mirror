Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309B1C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 03:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CFE22D5A
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 03:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbhAQDs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 22:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbhAQDs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 22:48:56 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B0DC061573
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 19:48:15 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id q25so12898448otn.10
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 19:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ocDHQEQqz0FHxanujdEtEMB8xmFzoVCJpyGghK3MliI=;
        b=LMJTAj3VlPRletgFhP4JZ2RFOt8xxlOeKjQAS1TwZ+v41uNXnfS94ZMui2y8xWUiDS
         0sjj88utG6CH+TXEwUkmpResUjpazBOcFuoCLuhY67uWA56R6b9zmtG3dDVP8WPkXX0I
         dg2yPBR+FuwVt+SH99drVVXEhuy6OBO7hiYOYRfQF5FdFR3nDbFznsLPwJDp2kVZrves
         G0UsFuUZ2ntHZcxAvElatlq5U/4+mqJNRYfDPNAnx7jDrH4RtQKIyje3TTaqJVzp4uIH
         T+thZMRbpBLFdrELmFIMLvXxp8n/cId6+reXAM+BRiduCrf6tEWusjn4a1BwzzPBnlFf
         VyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ocDHQEQqz0FHxanujdEtEMB8xmFzoVCJpyGghK3MliI=;
        b=YPQ0DdUNP5BuuJxGIjeiRo8U16yjoUyE3UR6j05DLHaa6JFUi0mPE3AzH46kUky7mT
         xgcSwPax5J1jUmEtSVKWEsLxzVF/zhfbS4IzsLIxu414dm6pkt5z7EquWL3VtXO3IekF
         kh2gpaBU8pUPdb+KPfLpPqjKBmPuNGrv5LiYTqsgECYGYbPD3G8pkANzWFBN+Q1klhTQ
         84fVN//9qlD5+gkX1eZROZQwUvqQbBMt5vcuqP/yJf0EClT7Npx9eTcnpllQadIP6FLo
         3AYG/Hz6i9vuSHzcHA0bT6V8sltgLHLaTHxzpih0OIdh4bzcDnwXQA3wCEauq2433eWS
         tXMQ==
X-Gm-Message-State: AOAM531B4uvqphhCCjgnAUGbEl1IO5GbIAz+zsmH3UhU68T+CZTBve3E
        UsRZVssZ99Gy+z5fRaKqYNkSb21jSLJVbHo2Bq8=
X-Google-Smtp-Source: ABdhPJzqawx37TzlbDUlUjlYkYJhiyL8iVJe57MvdXAK01Zo0A5hLTMoRG0khwY9qMg8DH6SVjK1VBogcDV4l6GUPlk=
X-Received: by 2002:a9d:816:: with SMTP id 22mr13635373oty.164.1610855293940;
 Sat, 16 Jan 2021 19:48:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
 <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com> <CAPig+cQBi7jdq64==U630Ht1YDcH+9komLNv-hZMnEhQ1Q-V9A@mail.gmail.com>
In-Reply-To: <CAPig+cQBi7jdq64==U630Ht1YDcH+9komLNv-hZMnEhQ1Q-V9A@mail.gmail.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Sun, 17 Jan 2021 11:49:41 +0800
Message-ID: <CAOLTT8QNhz4PrMhAt9y58n+-bEjeOE+xst8rzcg-x045Amw7iw@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files.c: add --dedup option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric,Thanks!
I have little confuse about I can use` test_when_finished "git switch maste=
r" `,
but I can't use` test_when_finished "git switch -" `,
why=EF=BC=9F

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8816=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=883:13=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, Jan 14, 2021 at 7:22 AM =E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGad=
get
> <gitgitgadget@gmail.com> wrote:
> > In order to provide users a better experience
> > when viewing information about files in the index
> > and the working tree, the `--dedup` option will suppress
> > some duplicate options under some conditions.
> > [...]
>
> I have a few very minor comments alongside Junio's review comments...
>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> > diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
> > @@ -0,0 +1,54 @@
> > +test_description=3D'git ls-files --dedup test.
> > +
> > +This test prepares the following in the cache:
> > +
> > +    a.txt       - a file(base)
> > +    a.txt      - a file(master)
> > +    a.txt       - a file(dev)
> > +    b.txt       - a file
> > +    delete.txt  - a file
> > +    expect1    - a file
> > +    expect2    - a file
> > +
> > +'
>
> This test script description is outdated now. Perhaps shorten it to:
>
>     test_description=3D'ls-files dedup tests'
>
> Or, it might be suitable to simply add the new test to the existing
> t3004-ls-files-basic.sh instead.
>
> > +test_expect_success 'setup' '
> > +       > a.txt &&
> > +       > b.txt &&
> > +       > delete.txt &&
> > +       cat >expect1<<-\EOF &&
>
> Style nits: no space after redirection operator and a space before
> redirection operator:
>
>     >a.txt &&
>     >b.txt &&
>     >delete.txt &&
>     cat >expect1 <<-\EOF &&
>
> > +       cat >expect2<<-EOF &&
>
> Nit: missing the backslash (and wrong spacing):
>
>     cat >expect2 <<-\EOF &&
>
> > +       echo a>a.txt &&
> > +       echo b>b.txt &&
>
> Style:
>
>     echo a >a.txt &&
>     echo b >b.txt &&
>
> > +       echo delete >delete.txt &&
> > +       git add a.txt b.txt delete.txt &&
> > +       git commit -m master:2 &&
> > +       git checkout HEAD~ &&
> > +       git switch -c dev &&
>
> If someone adds a new test after this test, then that new test will
> run in the "dev" branch, which might be unexpected or undesirable. It
> often is a good idea to ensure that tests do certain types of cleanup
> to avoid breaking subsequent tests. Here, it would be a good idea to
> ensure that the test switches back to the original branch when it
> finishes (regardless of whether it finishes successfully or
> unsuccessfully).
>
>     git switch -c dev &&
>     test_when_finished "git switch master" &&
>
> Or you could use `git switch -` if you don't want to hard-code the
> name "master" in the test (since there has been effort lately to
> remove that name from tests.
>
> > +       echo change >a.txt &&
> > +       git add a.txt &&
> > +       git commit -m dev:1 &&
> > +       test_must_fail git merge master &&
> > +       git ls-files -t --dedup >actual1 &&
> > +       test_cmp expect1 actual1 &&
> > +       rm delete.txt &&
> > +       git ls-files -d -m -t --dedup >actual2 &&
> > +       test_cmp expect2 actual2
>
> We usually don't bother giving temporary files unique names like
> "actual1" and "actual2" unless those files must exist at the same
> time. This is because unique names like this may confuse readers into
> wondering if there is some hidden interdependency between the files.
> In this case, the files don't need to exist at the same time, so it
> may be better simply to use the names "actual" and "expect", like
> this:
>
>     ...other stuff...
>     cat >expect <<-\EOF &&
>     ...
>     EOF
>     git ls-files -t --dedup >actual &&
>     test_cmp expect actual &&
>     rm delete.txt &&
>     cat >expect <<-\EOF &&
>     ...
>     EOF
>     git ls-files -d -m -t --dedup >actual &&
>     test_cmp expect actual
>
> (It also has the benefit that the "expect" content is closer to the
> place where it is actually used, which may make it a bit easier for a
> person reading the test to understand what is supposed to be
> produced.)
