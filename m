Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E1C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 10:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DBE235FA
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 10:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbgLRKNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 05:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733180AbgLRKNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 05:13:46 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25CFC0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 02:13:06 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id o5so407129oop.12
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 02:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7UbjpNH7qNp+Dsgw58c4XG8EIDasVTHBCl+6SZsDfXY=;
        b=BDT53SBa3H3ToRdYynkaWSd2+PdZ8jjcK+VqrG62ugnDM/QaChAumKSJnwJT+7++dw
         mOX3YAviBKbEBjqHaOmGO8/LoXQpCowcH4WYaagof7agPvyuM8VTq5LX2JGQwrkT2jEh
         BwIvNrzS0wXt1peIBS7ZWbeqWweMCM5edyYlYYaz8DysGXCI5G4dtRmYJqSuPDuPAV8H
         wA7EwOxFkNQdmCfH0ZX8N/UhNUgT9XQ5wsFjz0iuX2zdPKpSGa4Ztq57Cbn0ecIKPY84
         7jyo826v1Z4MTPO3GvWdvTJvlKHUnRjWxkoATbi0wPArAoZZYQFhg4hXmUzYZcifhux9
         zfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7UbjpNH7qNp+Dsgw58c4XG8EIDasVTHBCl+6SZsDfXY=;
        b=cD4YmRyJNUdAEnHnf0ti+xu6zWfWRCzU6YOi/u1N5KB5xrx9ebBVWDIcxiZoBRwXGe
         PC9j2DHccsLe1GqEjQu937UBYpmGSkn+/CYB86IXlH9iwnq249b5V6C8MuFqAHLW12SC
         IAYo2UaTqnDJA8eP7lmaM3WNbiK7RPc58DL6Swoqf9CBSzbFMncaZCgiY0VvT9kDwsnK
         6pVf6Z+WQvtcnBpgWgh6z7IZAySvXFRlQUAeoGqCAjzRPlsgRQQO3+MMKJwDsPxOc7Dz
         3q4b0xhdaXS8auyrNEMChnuZj694Kcn4tplTQd3Xo7sD746zU3CuwZqLaEaWbfM0YG5T
         VFRg==
X-Gm-Message-State: AOAM532mxMTypWPxRo/xYaGuw4X0ChK4MDDc+C+ohbJuza3keOU8xWtF
        5xm+5zQOka7iJyRzlG9y1pxG6UDDn9vxMuMhZb+8VsnAQ6SVJQ==
X-Google-Smtp-Source: ABdhPJxzO7t7l0B4ukk/wsHCruKtCDAC7AEqvhP9I6xw0l4jGTTuTepMXmG5JN3ph4zwjBR32NqJrR6iV87YjK55q5k=
X-Received: by 2002:a05:6820:381:: with SMTP id r1mr2185127ooj.73.1608286385861;
 Fri, 18 Dec 2020 02:13:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHjREB6+=ZT9B-XASAk7Hqt7qD5YhgROjDLCKoJR7cNyJDpDMw@mail.gmail.com>
 <CAP8UFD2AOaPC+7+qcJHQ4+Q5=dhY7ReNbRfJQ=HCS6=4bTPuVA@mail.gmail.com>
 <CAHjREB6ynLFW46C9s8D_nvUpavkugo7syegGuvCMdnfVNiZ+0Q@mail.gmail.com> <3bd5cef1-cda7-5118-07ac-a2f91cc80371@gmail.com>
In-Reply-To: <3bd5cef1-cda7-5118-07ac-a2f91cc80371@gmail.com>
From:   Sangeeta <sangunb09@gmail.com>
Date:   Fri, 18 Dec 2020 15:42:54 +0530
Message-ID: <CAHjREB7UonP7TPCd9dvXLX2ho+rJP07JM8nk33AYj9K=Mi7EYw@mail.gmail.com>
Subject: Re: [Outreachy] Blog Post Submission
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

Here's my second blog post on "everybody struggles".
https://sangu09.github.io/everybody-struggles/

Do give it a read let me know if you have any suggestions.

Thanks and Regards,
Sangeeta

On Fri, Dec 4, 2020 at 2:08 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi Sangeeta,
>
> On 03/12/20 4:27 pm, Sangeeta wrote:
> >
> > First of all thanks for the feedback! I have made the changes.
> >
> > Secondly, regarding the microproject, it is still under review and I
> > read that in the mail[1](What's cooking in Git)(you can search for
> > "untracked" in the mail), Junio states that it is left on some changes
> > which I have already made in patch 7[2]. What is stopping me to reply
> > to that mail is that I might not have answers to some of the questions
> > that Danh asked[3](Should this change applicable to diff-index,
> > diff-files and other plumbing commands?) because I don't know whether
> > that would be breaking changes or not. I tried to test it in my local
> > and I found everything was working fine as expected but I don't know
> > the reason for that nor do I know the reason for whether things should
> > break or not. >
>
> Thanks for checking. Don't hesitate to reply to Danh's e-mail with what
> you've done and what you're not certain about. It's a good way to move
> things forward. Also, you could try Cc-ing people who seem to have
> worked in the diff code recently. For instance using `git log` to see
> the people who've modified the diff.c and `wt-status.c` recently, I
> could observe that:
>
>      Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
>      Elijah Newren <newren@gmail.com>
>
>      Jeff King <peff@peff.net>
>
> are some contributes who might be able to provide you some inputs.
>
> > [1] https://lore.kernel.org/git/xmqqtut6qf7q.fsf@gitster.c.googlers.com=
/
> > [2] https://lore.kernel.org/git/20201110083900.88161-1-sangunb09@gmail.=
com/
> > [3] https://lore.kernel.org/git/X6rJWpuUHz1qHYZL@danh.dev/
> >
> > To give you a context of my changes, I have made
> > `--ignore-submodules=3Duntracked` the default for `git diff` when there
> > is no configuration variable or command-line option, to ensure that
> > the command doesn't give '-dirty' suffix to a submodule whose working
> > tree has untracked files. This was done to make it consistent with
> > `git describe`. For this, I had to make a global variable to check
> > whether ignoreSubmodules is set or not in the user config so that it
> > doesn't override that. Also to ensure that `git status` remains the
> > same, I have made `--ignore-submodules=3Dnone` the default for `git
> > status` so that the user doesn't end up deleting a submodule that has
> > uncommitted (untracked) files.
> >
>
> Also, thanks for the helpful summary!
>
> --
> Sivaraam
