Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC45CC38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 10:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJ3KN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJ3KNy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 06:13:54 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F15D5F
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 03:13:52 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 63so10779584ybq.4
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycMutv14yS8B+jimSVRWnZ+1Op+WYRhlHNeWmyNy7x0=;
        b=mXerSJBTizc//+8PoSmUTyv+V+to1hKdkbTxJRGUFQlrdlcjkSfqwKWd9IUumtFG8J
         3hO8Zb53MC7VrolJXbdOJHIlApzRxHx6lkpJR6/grEnXhjITtIRSD/PDnfjgnazxJuW7
         YP8IjIPzI9zfDraa9+NkqErBm3wyPxJp+Tyrd5y/+yZbOhfspxGBMJvj4SY0ZLRr6xYS
         J3LVxjq0aOmN8YASKT8mk7U5LuH2ejDB+4FKF2c0Yv9XAzxVd6aVWeersu9H5yJVvQmo
         K7c3ctnvNMjyjzPWCBfAYcdcVDrGLWfrSq8jfq9F0TSEjhtZAvwPaEylDehuAW/EbJ4y
         JJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycMutv14yS8B+jimSVRWnZ+1Op+WYRhlHNeWmyNy7x0=;
        b=sQcDruYOiDekFqtI3Wqb8IDoWcYBh+8lbvwgjJntxNKeh9b//tO5DxJ7/R6Ptzcerc
         0vh0oX2FS191ozZB85YRwsg+n0/SMu2+1TiE3zbtNJ36N3c4GinQb7lGutT1oHiKPKiy
         z/YIu5FBJgLUIqw2zJ560ynCMvte/xtC30MJjWXLzE/q6Tas4dgiVwNqC2/8zIv47DkP
         OadXCSaN15f8JybWgCAqWU6JFyyPmZjAhBAORAF5l4VmJd9qOcXm8VQCZAXLtraRiHjK
         MrTkIdIYxTPSdfWLbdXhgcXvxwrt30/PU/hxLMTjJt+0YG0wTCDIu5a9Qju7AW+i93X6
         1hiQ==
X-Gm-Message-State: ACrzQf206I4cZiX3zQnKEY+VuzvmXYFnzHPP+gZKVfKP6fdYtLtxRnoP
        nbHrTtAvnEmIunNf4DyDOYIWYZt75fBiTZJnzCYRKB8UHdejCGkW
X-Google-Smtp-Source: AMsMyM4Ob6qiG+BiG5RScuLROVOJzMxpVSlCNTeBoWIoRqS5RLB/zAJIvJU5SfL3a/LHCJs2gFRz8v9leEFyGCz8TtQ=
X-Received: by 2002:a25:c842:0:b0:6cb:fbab:2d3a with SMTP id
 y63-20020a25c842000000b006cbfbab2d3amr7157147ybf.178.1667124831523; Sun, 30
 Oct 2022 03:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com>
 <CA+CkUQ_pqQomaA=MO78PsC0oA8GcE0dJ415fpjcLx6k5HNaDiw@mail.gmail.com>
In-Reply-To: <CA+CkUQ_pqQomaA=MO78PsC0oA8GcE0dJ415fpjcLx6k5HNaDiw@mail.gmail.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sun, 30 Oct 2022 13:13:40 +0300
Message-ID: <CA+PPyiHQgkaN66DWOuO9UaGqhx4Gcyou_hdMnVrD9AVFmreqpA@mail.gmail.com>
Subject: Re: [OUTREACHY V2] Unify ref-filter formats with other --pretty formats[proposal]
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Hariom for your comments.

> I would review the rest later.

Ok, thank you

>  It seems like you used my proposal as a template

I used your template.  Yeah in case there are things to add or remove,
I will do so.

Thank you so much for your comments, I am working on all of them. i
hope by the end of today I will finish


On Fri, Oct 28, 2022 at 11:05 AM Hariom verma <hariom18599@gmail.com> wrote=
:
>
> Hi,
>
> On Thu, Oct 27, 2022 at 5:28 PM NSENGIYUMVA WILBERFORCE
> <nsengiyumvawilberforce@gmail.com> wrote:
> >
> > ##Proposed Project
> >
> > Abstract
> >
> > Git has an old problem of duplicated implementations of some logic.
> > For example, Git had at least 4 different implementations to format
> > command output for different commands. The foremost aim of this
> > project is to simplify codebase by getting rid of duplication of a
> > similar logic and, as a result, simplify adding new functionality.
> > The current task is to reuse ref-filter formatting logic to minimize
> > code duplication and to have one unified interface to extract all
> > needed data from the object and to print it properly.
> >
> > ##Previous Work
> >
> > JayDeep Das(GSoC) tried to =E2=80=9Cadd a new atom =E2=80=98signature=
=E2=80=99=E2=80=9D. However, I
> > have not been able to find his complete work in the public box, it
> > seems his work was not complete. According to
> > <https://github.com/JDeepD/git-1/commit/85ddfa4b33f2b6f05524e648e7165c7=
22188093e>
> > which was suggested at the outreachy website, it looks like he did not
> > complete writing the tests for the signature atom he was unifying.
> > Maybe with the help of the mentors, I could plan to start from where
> > he stopped from.
>
> maybe s/stopped from/stopped/
>
> You can elaborate a bit more on Jaydeep's work.
> Like,
> - What tests are missing?
> - Any dificulties he faced during writing tests?
>
> Also, in my final report, I mentioned refactoring the signature logic
> according to Junio's comment
> (https://public-inbox.org/git/xmqqzh7jcqv7.fsf@gitster.c.googlers.com/).
> Does Jaydeep's patch respect Junio's comment? I think you can include
> a bit about this too,
>
> > Hariom Verma contributed(https://harry-hov.github.io/blogs/posts/the-fi=
nal-report)
> > tremendously towards =E2=80=9CUnifying Git=E2=80=99s format languages=
=E2=80=9D during his 2020
> > GSoC internship.
>
> s/Unifying Git=E2=80=99s format languages/Unifying ref-filter formats wit=
h
> other --pretty formats/
> s/during his 2020 GSoC internship/during GSoC'20/
>
> > Hariom finished most of the formatting options and
> > this will help me build on his work.  His work looks smart and
> > understandable thus adding on his work will be easy. And also his blog
> > is very fabulous, it=E2=80=99s a shooting point for me to start underst=
anding
> > the codebase very well.
>
> It looks more like praise to me. I'm glad you like my work and blogs.
> But I would like to see some details here.
> Like work is almost 2+ years old. What changed in pretty.* and
> ref-filter.* since then?
> Is my work still compatible with the latest changes?
>
> > Hariom mentions in his report that 30 % of the
> > log related tests are failing, he also mentions that the cause of
> > tests failure is because of the missing mailmap logic and mbox/email
> > commit format.
>
> Okay. But see if you can gather more details about failing tests and
> remaining work.
>
> > Hariom also says it does not handle unknown formatting
> > options.
>
> what do you mean by "it" here?
>
> > I plan to start with his advice about the cause of the
> > failure of these tests and then intuitively refactor them into
> > something cool.
>
> I didn=E2=80=99t get the line "intuitively refactor them into something c=
ool".
>
> > ##Summary of remaining tasks by Hariom
> >
> > -Around 30% log related tests are failing
> >
> > -Teach pretty-lib.{c,h} to handle incorrect formatting option
> >
> > -Email/MBoxed commit format needs work
> >
> > ##Some useful mailing lists links from Hariom
> >
> > - https://public-inbox.org/git/pull.684.v4.git.1598046110.gitgitgadget@=
gmail.com/
> >
> > - https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gma=
il.com/
> >
> > - https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gma=
il.com/
> >
>
> Okay
>
> > Olga<olyatelezhnaya@gmail.com> has done great work in =E2=80=9CUnifying=
 Git=E2=80=99s
> > format languages=E2=80=9D during Outreachy Round 15 and continued even =
after
> > that [from 28-09-2017 to 04-04-2019]. Her work is mostly related to
> > `cat-file` and `ref-filter`.
> >
> > She already did a pretty nice job in preparing ref-filter for more
> > general usage of its formatting logic. It will give me the possibility
> > to make the migration of pretty.c easier.
>
> ZheNing Hu continued the Olga's work during GSoC'21. You can tell a
> bit more about that too.
>
> --
>
> I would review the rest later.
>
> It seems like you used my proposal as a template. Just want to let you
> know, you are not restricted to using any particular template. Feel
> free to add or remove any section you find relevant.
>
> Thanks,
> Hariom
