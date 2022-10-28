Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F79C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 08:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ1IGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1IF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 04:05:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8946FA38
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 01:05:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f27so11192094eje.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHDCHNDQa20azICr9oGaLJwptMpVckrxIYdjmwGpHZQ=;
        b=EYoMkmjeZWsNqL0Oc+hUGgrrxQbRoXgRrjQL6ldl/kAjIad3DHT90HrFcgoYSMQhNj
         0TMJpfkgYv02g1wyaX3SUM8rh1voLXxGxwSgrP+2+4+nICBJJ5LqzJacSh4it88mUn3b
         ThwseI9MYtyR+97DoczCaTElqdLpMh0cldQnR7u8RG0nnQFStGfNZZt7GBuMaC2iuV0P
         r3yWRKXSQMqVkKQq6e0lJD5hVYLmDIBFJklK5VTRh5PVLAh9qSmbYNrkhjZisE1T4G9c
         jv/jMi9tzd3OmAjm7K+Y/VhsIW4adWKiw8zdJv/UhX0KHQyi4nFr74GkOepwc3st0WZl
         /LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHDCHNDQa20azICr9oGaLJwptMpVckrxIYdjmwGpHZQ=;
        b=oUJk6s12NCCLPkgHA6khheNnmHbvuzCkK81paMW0FE55mD/Udw92Gt0l6d1ENZgoMB
         B7L8Cr4MV6acezorInVmxb6kMS9g74kQYap2Z+B8+g4ijCeD183o5PBK5XBIEztWsrCn
         zRwtjbhRq8wgvAA2KbDFq/iUVsewUbmGD4l/HwnB47lfuUEosyeg31J46MPU6ahr7Z2t
         HuoHdR+VJhZ3pftJz/T4kT+erHc25yozfgoDiD5uRh3JbAPa+wb+4bc6MeEKkKfoVCXb
         n7vSp6waEdeRLt2J4nbSWUUf7mR36dxMaZPzI4RA8xIAzoQd6snXM1rOXKZn9gTACmnI
         4DhA==
X-Gm-Message-State: ACrzQf1sjcC3mFUeEMJjRkPkPpZzOyXDO8uLb75eDXesO7QPzHO8BZym
        22GXrkpl5yLgpe0xUb68qkpmrleVM0V3tNECWQY=
X-Google-Smtp-Source: AMsMyM5+CJFyYhWqXAjfWbN+R7yz9Hqx2eGd2gFS2/dNVpUlv86D8F/PZFTHOzR759GQ29EgTjswP9/q1E7XYx9VOxM=
X-Received: by 2002:a17:906:b08d:b0:782:d526:3e36 with SMTP id
 x13-20020a170906b08d00b00782d5263e36mr45977400ejy.358.1666944355560; Fri, 28
 Oct 2022 01:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com>
In-Reply-To: <CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 28 Oct 2022 13:35:44 +0530
Message-ID: <CA+CkUQ_pqQomaA=MO78PsC0oA8GcE0dJ415fpjcLx6k5HNaDiw@mail.gmail.com>
Subject: Re: [OUTREACHY V2] Unify ref-filter formats with other --pretty formats[proposal]
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Oct 27, 2022 at 5:28 PM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> ##Proposed Project
>
> Abstract
>
> Git has an old problem of duplicated implementations of some logic.
> For example, Git had at least 4 different implementations to format
> command output for different commands. The foremost aim of this
> project is to simplify codebase by getting rid of duplication of a
> similar logic and, as a result, simplify adding new functionality.
> The current task is to reuse ref-filter formatting logic to minimize
> code duplication and to have one unified interface to extract all
> needed data from the object and to print it properly.
>
> ##Previous Work
>
> JayDeep Das(GSoC) tried to =E2=80=9Cadd a new atom =E2=80=98signature=E2=
=80=99=E2=80=9D. However, I
> have not been able to find his complete work in the public box, it
> seems his work was not complete. According to
> <https://github.com/JDeepD/git-1/commit/85ddfa4b33f2b6f05524e648e7165c722=
188093e>
> which was suggested at the outreachy website, it looks like he did not
> complete writing the tests for the signature atom he was unifying.
> Maybe with the help of the mentors, I could plan to start from where
> he stopped from.

maybe s/stopped from/stopped/

You can elaborate a bit more on Jaydeep's work.
Like,
- What tests are missing?
- Any dificulties he faced during writing tests?

Also, in my final report, I mentioned refactoring the signature logic
according to Junio's comment
(https://public-inbox.org/git/xmqqzh7jcqv7.fsf@gitster.c.googlers.com/).
Does Jaydeep's patch respect Junio's comment? I think you can include
a bit about this too,

> Hariom Verma contributed(https://harry-hov.github.io/blogs/posts/the-fina=
l-report)
> tremendously towards =E2=80=9CUnifying Git=E2=80=99s format languages=E2=
=80=9D during his 2020
> GSoC internship.

s/Unifying Git=E2=80=99s format languages/Unifying ref-filter formats with
other --pretty formats/
s/during his 2020 GSoC internship/during GSoC'20/

> Hariom finished most of the formatting options and
> this will help me build on his work.  His work looks smart and
> understandable thus adding on his work will be easy. And also his blog
> is very fabulous, it=E2=80=99s a shooting point for me to start understan=
ding
> the codebase very well.

It looks more like praise to me. I'm glad you like my work and blogs.
But I would like to see some details here.
Like work is almost 2+ years old. What changed in pretty.* and
ref-filter.* since then?
Is my work still compatible with the latest changes?

> Hariom mentions in his report that 30 % of the
> log related tests are failing, he also mentions that the cause of
> tests failure is because of the missing mailmap logic and mbox/email
> commit format.

Okay. But see if you can gather more details about failing tests and
remaining work.

> Hariom also says it does not handle unknown formatting
> options.

what do you mean by "it" here?

> I plan to start with his advice about the cause of the
> failure of these tests and then intuitively refactor them into
> something cool.

I didn=E2=80=99t get the line "intuitively refactor them into something coo=
l".

> ##Summary of remaining tasks by Hariom
>
> -Around 30% log related tests are failing
>
> -Teach pretty-lib.{c,h} to handle incorrect formatting option
>
> -Email/MBoxed commit format needs work
>
> ##Some useful mailing lists links from Hariom
>
> - https://public-inbox.org/git/pull.684.v4.git.1598046110.gitgitgadget@gm=
ail.com/
>
> - https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gmail=
.com/
>
> - https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gmail=
.com/
>

Okay

> Olga<olyatelezhnaya@gmail.com> has done great work in =E2=80=9CUnifying G=
it=E2=80=99s
> format languages=E2=80=9D during Outreachy Round 15 and continued even af=
ter
> that [from 28-09-2017 to 04-04-2019]. Her work is mostly related to
> `cat-file` and `ref-filter`.
>
> She already did a pretty nice job in preparing ref-filter for more
> general usage of its formatting logic. It will give me the possibility
> to make the migration of pretty.c easier.

ZheNing Hu continued the Olga's work during GSoC'21. You can tell a
bit more about that too.

--=20

I would review the rest later.

It seems like you used my proposal as a template. Just want to let you
know, you are not restricted to using any particular template. Feel
free to add or remove any section you find relevant.

Thanks,
Hariom
