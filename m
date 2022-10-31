Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAB3ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 13:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJaNhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJaNhh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 09:37:37 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A4101E2
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:37:36 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3701a0681daso73263227b3.4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7jPVKbiHLzlaMmAjgxte2bmAxO6mxGofAj0a8H7FzQ=;
        b=qkNISWfTYCjA8hzcJ7qssa4iCh1QdYl7Sv07ApyzZ86EwwxZ8Q6pTIA0Aj+AezCCSr
         xd9scOxwWV0wTNvtXC0ZN8VXNjh1ntfyqwlr/E+60Jc4vX6lunERqPi+QYEZKEq1x4WV
         NGqko7HJRXbs1Wgxe3/dxri2HOSnW/S80LlEoCG2MDDz/HhGzqi5Cn07vaX0hneDTaO9
         cCyLLEYM+GpSecSFw8osHk6RU0oAkOXCEcVQ9iUTZxHa04laJZm49JzJ1A27L98Vv9uV
         kroHLFKWKjCtO3CyL+cLFLWXmX/ABX5HDljXumdxK2enCni5U6JtFPWRDAW2iynMFVgq
         ZEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7jPVKbiHLzlaMmAjgxte2bmAxO6mxGofAj0a8H7FzQ=;
        b=R4YksI+9hoVeNoBRPqOxpTv3pzMAz+l4fJcZFzQ34UazW1YfnqQDZVZPTaczHBjaqh
         RmamRsbHfdYldtA87DJ0elCR+QLa0BVmdcsTGw4pKXmUm9hbVf6mzJGZIyjY1vCOAY4X
         AfO6XFo+EftgX2ggYY5kVV1ZqxRy/O08ID0rh8qAlEFOiR5I+u9tBhuDZRqi6/GCajur
         3l4N6JgpFHVnNJGxlpsjQrFwbErDli/ImxG0P8YTRBn9jqs0RFztsAzMdE7aruRCnvJv
         sMUTtAD8xeYSqy6rYKSUYwvZVfFXSYaR9v0wDkegkQwL1tEnIJ/HntMdGQhpO0BCRV0p
         fSMA==
X-Gm-Message-State: ACrzQf1hAY8P9ZyGHH9JXKwukfj+mT6F93iYEtxAhrWrUzY0rn2JUSFE
        8UojtACuWNiwqUcEb4Om3//4hqX5zdJOqj9uhAungCKzHkVsO7yf4lU=
X-Google-Smtp-Source: AMsMyM5X3d24X/mLxvSdqwJRAIhE74mmP0howbQt3SXRWqZwad+u68XaUoF7p7utOLJl5RSjTOLqGLbt758VXjLYdVw=
X-Received: by 2002:a81:7444:0:b0:368:f790:eaa3 with SMTP id
 p65-20020a817444000000b00368f790eaa3mr13154687ywc.439.1667223455547; Mon, 31
 Oct 2022 06:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com>
 <CA+CkUQ_pqQomaA=MO78PsC0oA8GcE0dJ415fpjcLx6k5HNaDiw@mail.gmail.com> <CA+PPyiHQgkaN66DWOuO9UaGqhx4Gcyou_hdMnVrD9AVFmreqpA@mail.gmail.com>
In-Reply-To: <CA+PPyiHQgkaN66DWOuO9UaGqhx4Gcyou_hdMnVrD9AVFmreqpA@mail.gmail.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Mon, 31 Oct 2022 16:37:24 +0300
Message-ID: <CA+PPyiGvrmXoeZkaQKwwNU3SV+jZHatsC=FMhb9wX5-s0tNjTQ@mail.gmail.com>
Subject: Re: [OUTREACHY V2] Unify ref-filter formats with other --pretty formats[proposal]
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> maybe s/stopped from/stopped/

Can I know about how this format of writing works? I have similar
comments in the previous proposal, but I do not understand how this
works.

Thanks,
Wilberforce


On Sun, Oct 30, 2022 at 1:13 PM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> Thanks Hariom for your comments.
>
> > I would review the rest later.
>
> Ok, thank you
>
> >  It seems like you used my proposal as a template
>
> I used your template.  Yeah in case there are things to add or remove,
> I will do so.
>
> Thank you so much for your comments, I am working on all of them. i
> hope by the end of today I will finish
>
>
> On Fri, Oct 28, 2022 at 11:05 AM Hariom verma <hariom18599@gmail.com> wro=
te:
> >
> > Hi,
> >
> > On Thu, Oct 27, 2022 at 5:28 PM NSENGIYUMVA WILBERFORCE
> > <nsengiyumvawilberforce@gmail.com> wrote:
> > >
> > > ##Proposed Project
> > >
> > > Abstract
> > >
> > > Git has an old problem of duplicated implementations of some logic.
> > > For example, Git had at least 4 different implementations to format
> > > command output for different commands. The foremost aim of this
> > > project is to simplify codebase by getting rid of duplication of a
> > > similar logic and, as a result, simplify adding new functionality.
> > > The current task is to reuse ref-filter formatting logic to minimize
> > > code duplication and to have one unified interface to extract all
> > > needed data from the object and to print it properly.
> > >
> > > ##Previous Work
> > >
> > > JayDeep Das(GSoC) tried to =E2=80=9Cadd a new atom =E2=80=98signature=
=E2=80=99=E2=80=9D. However, I
> > > have not been able to find his complete work in the public box, it
> > > seems his work was not complete. According to
> > > <https://github.com/JDeepD/git-1/commit/85ddfa4b33f2b6f05524e648e7165=
c722188093e>
> > > which was suggested at the outreachy website, it looks like he did no=
t
> > > complete writing the tests for the signature atom he was unifying.
> > > Maybe with the help of the mentors, I could plan to start from where
> > > he stopped from.
> >
> > maybe s/stopped from/stopped/
> >
> > You can elaborate a bit more on Jaydeep's work.
> > Like,
> > - What tests are missing?
> > - Any dificulties he faced during writing tests?
> >
> > Also, in my final report, I mentioned refactoring the signature logic
> > according to Junio's comment
> > (https://public-inbox.org/git/xmqqzh7jcqv7.fsf@gitster.c.googlers.com/)=
.
> > Does Jaydeep's patch respect Junio's comment? I think you can include
> > a bit about this too,
> >
> > > Hariom Verma contributed(https://harry-hov.github.io/blogs/posts/the-=
final-report)
> > > tremendously towards =E2=80=9CUnifying Git=E2=80=99s format languages=
=E2=80=9D during his 2020
> > > GSoC internship.
> >
> > s/Unifying Git=E2=80=99s format languages/Unifying ref-filter formats w=
ith
> > other --pretty formats/
> > s/during his 2020 GSoC internship/during GSoC'20/
> >
> > > Hariom finished most of the formatting options and
> > > this will help me build on his work.  His work looks smart and
> > > understandable thus adding on his work will be easy. And also his blo=
g
> > > is very fabulous, it=E2=80=99s a shooting point for me to start under=
standing
> > > the codebase very well.
> >
> > It looks more like praise to me. I'm glad you like my work and blogs.
> > But I would like to see some details here.
> > Like work is almost 2+ years old. What changed in pretty.* and
> > ref-filter.* since then?
> > Is my work still compatible with the latest changes?
> >
> > > Hariom mentions in his report that 30 % of the
> > > log related tests are failing, he also mentions that the cause of
> > > tests failure is because of the missing mailmap logic and mbox/email
> > > commit format.
> >
> > Okay. But see if you can gather more details about failing tests and
> > remaining work.
> >
> > > Hariom also says it does not handle unknown formatting
> > > options.
> >
> > what do you mean by "it" here?
> >
> > > I plan to start with his advice about the cause of the
> > > failure of these tests and then intuitively refactor them into
> > > something cool.
> >
> > I didn=E2=80=99t get the line "intuitively refactor them into something=
 cool".
> >
> > > ##Summary of remaining tasks by Hariom
> > >
> > > -Around 30% log related tests are failing
> > >
> > > -Teach pretty-lib.{c,h} to handle incorrect formatting option
> > >
> > > -Email/MBoxed commit format needs work
> > >
> > > ##Some useful mailing lists links from Hariom
> > >
> > > - https://public-inbox.org/git/pull.684.v4.git.1598046110.gitgitgadge=
t@gmail.com/
> > >
> > > - https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@g=
mail.com/
> > >
> > > - https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@g=
mail.com/
> > >
> >
> > Okay
> >
> > > Olga<olyatelezhnaya@gmail.com> has done great work in =E2=80=9CUnifyi=
ng Git=E2=80=99s
> > > format languages=E2=80=9D during Outreachy Round 15 and continued eve=
n after
> > > that [from 28-09-2017 to 04-04-2019]. Her work is mostly related to
> > > `cat-file` and `ref-filter`.
> > >
> > > She already did a pretty nice job in preparing ref-filter for more
> > > general usage of its formatting logic. It will give me the possibilit=
y
> > > to make the migration of pretty.c easier.
> >
> > ZheNing Hu continued the Olga's work during GSoC'21. You can tell a
> > bit more about that too.
> >
> > --
> >
> > I would review the rest later.
> >
> > It seems like you used my proposal as a template. Just want to let you
> > know, you are not restricted to using any particular template. Feel
> > free to add or remove any section you find relevant.
> >
> > Thanks,
> > Hariom
