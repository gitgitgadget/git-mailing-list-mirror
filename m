Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B591C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 00:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB7322C9E
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 00:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbhASAtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 19:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbhASAtk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 19:49:40 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C5C061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 16:49:00 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y4so14383942ybn.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 16:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gpWROuBRKfjyUJAXLyjEgjM9SrGMSt/Svw7LFKStwKw=;
        b=ZRJ5kZczK5VGQYZJt/g8JeC1qFJZQmHxyRYDuGdn6NezYGufq1qV1dpFFe9bw4onPg
         dRyLjrtNyRn9pPbzzJxJZYm7Wa1sIIidLCoaOCBlsg4Kql6SR5V+a8Dbjm6+uZrkaG3W
         dmCIK2GmFLkRrR+xIKX/zkCv1ptkBueajTD52lNIn6SX95iPWjZwxytROppmNIcYdqFM
         ZVXfwH9p5/mWH70aFBNcYHublQuN5pmOOIgSVuaw10wJhwQV7UrvvMIOqFDWsem/h+ko
         ue96kldk80ZE4tYmLb5AqbXtIdPuUzxyXFfL2ca4qWwK27av9GN45qADYzbwbpWEG+qm
         OIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gpWROuBRKfjyUJAXLyjEgjM9SrGMSt/Svw7LFKStwKw=;
        b=JcIwW5yDuVINzw0qJ4UNkAmrAR26xhdqNslpyLGtQhtpVDCc9HOE59hbx2Kgp7ZPlk
         x1wJx02sS5GNZw1Qtj4MBr3YaEeopypVmIlbF1flXMzTGNUdslE9gbd3l/hsSfrJPOmD
         z1mh8JDj4WO8YeclwFTL/6N8SrbvNaayW3LigtYfK0F2/bQ6PiWVmj7f49ZlFPAXNJgQ
         kYr9nbXtPNlXzLwve3JhvL8ByOPMMYv1wlyZTwDLiKBr4/ivOKVm+W577XN0KpWEfGm2
         bfyw+uwsTN9gTsHSYN+Am5S0iEjprdGRzRkBkZFaZeOomZ1Wtt9Y29l97/+vCLHTxG5w
         1T+w==
X-Gm-Message-State: AOAM533Df6hWgd5N5pWy68ATXSR/zDqhKSoesupnNpiFNl0FKkcd5rnh
        9liS62p0M5PVKRu/XfNyiIIMyQXFzcf/inP4JaE=
X-Google-Smtp-Source: ABdhPJyn2M2Q8VjYghdDC3nWLYFe1VcD/YltGAYr7zdTuM8jAw0QLUNvudVDfI8Hbtt5Wj6cHxJXNHwHEeJTwkbYOow=
X-Received: by 2002:a25:5:: with SMTP id 5mr2436611yba.478.1611017339498; Mon,
 18 Jan 2021 16:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20210117222151.GY8396@szeder.dev> <20210118133011.15331-1-worldhello.net@gmail.com>
 <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
In-Reply-To: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 19 Jan 2021 08:48:48 +0800
Message-ID: <CANYiYbF4gv0x78SX=TbQKP+GwUVCCRpNob+riRs5wPiFKcsSsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] t5411: remove file after use to prevent overwriting
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> =E4=BA=8E2021=E5=B9=B41=E6=9C=8819=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=882:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Am 18.01.21 um 14:30 schrieb Jiang Xin:
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > SZEDER reported that t5411 failed in Travis CI's s390x environment a
> > couple of times, and could be reproduced with '--stress' test on this
> > specific environment.  The test failure messages might look like this:
> >
> >     + test_cmp expect actual
> >     --- expect      2021-01-17 21:55:23.430750004 +0000
> >     +++ actual      2021-01-17 21:55:23.430750004 +0000
> >     @@ -1 +1 @@
> >     -<COMMIT-A> refs/heads/main
> >     +<COMMIT-A> refs/heads/maifatal: the remote end hung up unexpectedl=
y
> >     error: last command exited with $?=3D1
> >     not ok 86 - proc-receive: not support push options (builtin protoco=
l)
> >
> > The file 'actual' is filtered from the file 'out' which contains result
> > of 'git show-ref' command.  Due to the error messages from other proces=
s
> > is written into the file 'out' accidentally, t5411 failed.  SZEDER find=
s
> > the root cause of this issue:
> >
> >  - 'git push' is executed with its standard output and error redirected
> >    to the file 'out'.
> >
> >  - 'git push' executes 'git receive-pack' internally, which inherits
> >    the open file descriptors, so its output and error goes into that
> >    same 'out' file.
> >
> >  - 'git push' ends without waiting for the close of 'git-receive-pack'
> >    for some cases, and the file 'out' is reused for test of
> >    'git show-ref' afterwards.
> >
> >  - A mixture of the output of 'git show-ref' abd 'git receive-pack'
> >    leads to this issue.
> >
> > To resolve this issue, we can remove the file 'out' after use.  The
> > long-running 'git receive-pack' will not redirect its output to the new
> > created 'out' file which has a different file descriptor.
>
> On Windows, removing an open file is not possible and this...
>
> > diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000=
-standard-git-push.sh
> > index 47b058af7e..694d8e8dc2 100644
> > --- a/t/t5411/test-0000-standard-git-push.sh
> > +++ b/t/t5411/test-0000-standard-git-push.sh
> > @@ -40,6 +40,8 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
> >               -e "/^To / { p; }" \
> >               -e "/^ ! / { p; }" \
> >               <out >actual &&
> > +     # Prevent accidential changes by the internal "receive-pack" proc=
ess.
> > +     rm out &&
>
> ... would fail.

Thank you for reminding. It seems that the only way is to use a
different output file name.

> That said, your next patch removes a lot of uses of the 'out' file
> against which this 'rm out' should protect. Doesn't this make this patch
> unnecessary?

The other test cases also write to the same "out" file, so the issue
still needs to be fixed.

--
Jiang Xin
