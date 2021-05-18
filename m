Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72506C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46771600D4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhEROdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhEROdu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:33:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D41C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:32:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id di13so11475980edb.2
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WudKHhg6GWM0Kr1ce1XuiMjkLX7+Jds8+l9duIyIHw4=;
        b=B3lIa+Yv3l36gsWRyvTkF0oNGlMDR1/NWSeAnXNDcl8Pa7lQgOWJbqpiQ3pL04BEoG
         BhKYx7D3ZlUPI+5oqEvqOTBBuQyuC+LB/VoI3m79dWfR5GqOAIV0zSVA2kVkWd2dK7kr
         E2CtmJqLXFLuaRkd/eAqZL4GlhLXy56jkH9oB6dV1h9R2Hxwf8xpHJITigjW7osV6Dr0
         qktwpbTvDWQqRuZx05kWEzeKSonrdxNlGuFqzq+LZcuOUrxBQsDYhZ6cccn6wo9KsfbO
         jYAorAom1Itbs25i6Vy54Mh+8K2Rk8/TGuSUuRpuvqN2UeetTWkvf0Z+Q8ssvAU0J2V0
         HxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WudKHhg6GWM0Kr1ce1XuiMjkLX7+Jds8+l9duIyIHw4=;
        b=O07YJ/sDaBka7UzxK/ByC8fmt+FmCk2GKcrc++/4+9fcZaVUjVhaeQIjODjSakq06t
         SwZ44Cjok1xq2lUKxyZImqWRqlzvFIr859Xxv3SlmU8pSJacXJltvCb6HdllTdBKe365
         6lWzDJFv3BgB29mAUX91KZZo8ImWS2ylI1mn5ftRWzmxaCAB7K/DykG4AgCDiQnCxh1g
         Q8zizO1HOplqyvuu20dga/iBhIij0axmPJu7lWcdUOb1gwyFymFCsRmFabW4bJDO0Xxo
         UYQ2YrowFbVOC3GTWXi54qZ3B66XBbq2Kmw33zyT0BBdo+FRZn4c7tRujokzlTyddiEJ
         CuJw==
X-Gm-Message-State: AOAM530doWjrOcSkrOfwKQ4TY9/Pkc3svhqv549ucHT4HKR23F4n0PSf
        ru6nGYRTM8mpRC2k46Tfn2zThOvbI74ePbEzfSeyLLhgZ5GPxA==
X-Google-Smtp-Source: ABdhPJxrQeid+mii42uc05q0aUukoEYsM8+XV+BDbA9mT94rO0XUHgRjaA2kYisYxTKIBpIlrnjFDP8AfMQlWZdstv4=
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr7302524edc.362.1621348349391;
 Tue, 18 May 2021 07:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
In-Reply-To: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 18 May 2021 16:32:18 +0200
Message-ID: <CAP8UFD0qQg9vfuDvjrc5amnw8w7NFBLEaJUwEksV08HBdFJ7LA@mail.gmail.com>
Subject: Re: [GSoC] Hello Git
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jiang Xin <worldhello.net@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing,

On Tue, May 18, 2021 at 8:40 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Hello=EF=BC=8CGit!
>
> ### Self introduction
>
> I'm ZheNing Hu, I am very lucky to participate in the GSoC
> git project this year. Many people in the git community already
> have given me a lot of help in the past few months.
> Junio, Christian, Peff, Eric, Denton..., it's great to get along with
> you guys! Your review and guidance have greatly benefited
> my growth.

We are very happy with your application to the GSoC with us, and with
your work so far!

> In these days before GSoC, I learned some simple command
> implementation and data structures of git, learned strict coding
> standards and learned how to test, More importantly, I learned how
> to communicate with these kind-hearted reviewers.
>
> Of course, there are still many difficulties for me:
> * My poor English sometimes can=E2=80=99t express the meaning clearly.
> * The Git architecture is very large, even a small command may
> require very complex logic to implement, I often feel very difficult
> to find clues.
>
> Therefore, during GSoC, I hope to overcome these difficulties and
> learn more in-depth knowledge in git.

Sure!

> ### How to complete my GSoC project
>
> I don=E2=80=99t want to be rejected by Git after I have completed a lot o=
f
> content, as Olga once did, Therefore, I think it is best to move in
> the right direction step by step under everyone's supervision.

Sometimes it's very difficult to know in advance what will work well
enough to be accepted. And if something doesn't work well enough we
can still learn from that, and sometimes use it as a base to implement
something better.

> Current condition:
> 1. In order to use a unified interface containing both short-named
> and full-named atoms, inspired by the short name option and long name
> option of "OPT_*" in `parse-options.h`,  I thought I should add a new sho=
rt
> name atom to `struct valid_atom` for expansion in `ref-filter.c`, In [1]:
> Junio thinks that `--format` with two-letters short atoms should not be
> implemented in `ref-filter.c` and provided for the `for-each-ref` family.
> Instead, let the "log" family learn the full-named atom. To ensure the
> consistency of `log --format` and `for-each-ref --format`.

Yeah.

> But for now,
> It seems that the parsing of full-named atoms in `pretty.c` is not very e=
legant.
> E.g.
>
>    if (skip_prefix(placeholder, "(describe", &arg)) {
>    ...
>    }
>
>        if (skip_prefix(placeholder, "(trailers", &arg)) {
>    ...
>    }
>
> We should have an atom table like `valid_atom` in `ref-filter.c`,
> but this is missing in `pretty.c`. So how do we complete the
> unification of the two types of atoms now?

Yeah, unifying pretty.c and ref-filter.c was the purpose of Hariom's
GSoC last year, and there is still work to do on this, but you might
want to focus on the format code used by git cat-file first, as that's
what your project is about.

> 2. "50cfe1f([GSOC] ref-filter: introduce enum atom_type)" has
> been merged into the `next` branch, should we focus on the
> performance optimization of `ref-filter.c`? Finally, we can build a
> `format_cat_file_item()` similar to `format_ref_array_item()`,
> which should not be difficult. And we have to make sure that the
> performance of `cat-file --batch` is not lower than before.

I wonder if format_ref_array_item() could not just be used by
batch_object_write() like Olga did it in:

https://github.com/git/git/pull/568/commits/f911b342ae6503dc9f6f8e3c7df316a=
a45d97bdf

> ### The connection between Git and the file system
>
> I am currently studying operating system course, git as a
> file system on top of the file system.
> There are many differences and similarities with ordinary
> file systems. I am very curious about this knowledge, do
> not know if there are any relevant reading materials?

You might be interested in https://ostreedev.github.io/ostree/

Best,
Christian.
