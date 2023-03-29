Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A794C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 12:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjC2MXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjC2MXk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 08:23:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A0530ED
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 05:23:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so62452724ede.8
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680092616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzZGq9JpwMY7bZ/jjA0znUKAY05WaNekom4jbD/MBJQ=;
        b=NEY0S0MS7Ki2IKCr/0N8VO1pBMLnQUo5K3iyEq26vMrb9m+3EczuMSk0c4AWAcqtFm
         G1phHy463s2i49OC1lT16WSfBZsNF2EzGMfdH8HY+abFCVh0Y1+wSe4M5EJ6ksbx+IrU
         Jbtat9Po9f3lB3zh1Xkvkpr26zi/vE8RywT0PL/slpM3IxDo4WNB1a7p2GJKcTwmUQuY
         I7bZWtdXwfpi1NmwKat5yyRyqsbM7gjKOG85cFHHkA7GAsdbnttaS1AE6TyF7uvF8I/4
         7fkU7I5OX7NjhaB20m7QxKsHjiHAlmTw6JwfuKkwQ2tRU06jz22/T4HD+JA+96YSgOqV
         rnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680092616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzZGq9JpwMY7bZ/jjA0znUKAY05WaNekom4jbD/MBJQ=;
        b=INXKmXQiGOkT9IwjTvt94TlkKTvnGsDwQkf43aQF2TbMgZZT0aRSXMTsqi/i14uZ8G
         c2tbEJYMs7a0shEvAsmOlrF2/voRrB6jvWu2eNOOUEc1ziC2lD7e+zkK+Y38h+BXRTko
         KOcy/9kNWdVQ3kIijCwUpwuXxrAsqJj7a+JQ+JUYY1bNQjVlA6aDfX1U3SA92IsACwCE
         K4Y1TW7pXY7qV1d+amhHjcFU6HNldCG14IpHbia5ZE6PAQPguUjHltPmkgnDR9scFCbn
         ZjK0PNkbtUHJgGmzWiT/PnSBbP6mJY9rkxvGzgUbKPpAMeePxrYyvbpJL3Bpxt9bR4WZ
         tY8Q==
X-Gm-Message-State: AAQBX9c7vnim8UESvvA3qIQhEwh4KtNAMu+rRPxw9pGWzrbB1E9cZ/AT
        CVtITH3fyKs4zPMKew1RGv+Oqt7tnmADyaZMd5IrWwvZO616M2cz
X-Google-Smtp-Source: AKy350bqYItPpfUKylJCiGST97l66l1dnzXziNr/fijypNs5gXKfXPVks2jWkC8T6whddo5D6wd8tc+9NBe+qaEivFs=
X-Received: by 2002:a50:d68c:0:b0:4fb:80cf:898b with SMTP id
 r12-20020a50d68c000000b004fb80cf898bmr9048785edi.7.1680092615889; Wed, 29 Mar
 2023 05:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <4cb30507.79cd.18728e9ee58.Coremail.18994118902@163.com>
In-Reply-To: <4cb30507.79cd.18728e9ee58.Coremail.18994118902@163.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Wed, 29 Mar 2023 17:53:24 +0530
Message-ID: <CA+CkUQ_7BDmX73epbAaUsz3fXaNcHXR4H6xQ-nyGV81YAYRbcQ@mail.gmail.com>
Subject: Re: [GSOC] [PROPOSAL v1] Draft of proposal for "Unify ref-filter
 formats with other pretty formats"
To:     Zhang Yi <18994118902@163.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Tue, Mar 28, 2023 at 9:20=E2=80=AFPM Zhang Yi <18994118902@163.com> wrot=
e:
>
> Hi, there is a my first versoin of proposal for "Unify ref-filter formats=
 with other
> pretty formats". There may be many backwards. I'm ready for the correctio=
n.
>
> Thanks for your attention.
>
> * Unify ref-filter formats with other pretty formats
>
> * Personal Information
>
> Full name: Zhang Yi
>
> E-mail: 18994118902@163.com
> Tel: (+86)18994118902
>
> Education: Wuhan University of Technology (China)
> Major: Computer engineering
> Year: First-year postgraduate student
>
> Github: https://github.com/zhanyi22333

Okay.

> * Synopsis
>
> Git has at least four implements to format command output, which makes ch=
aos and
> hinder improvement of code quality.
>
> Aim to unify the different implementations to format output for different
> commands, we want to transform pretty into ref-filter formatting logic. A=
ccording
> In the present situation, I need to add more ref-filter atoms to replace
> pretty.
>
> In my mind, there are 6 steps logically:
> 1. Check and find a pretty atom which has no substitute in ref-filter.
> 2. Add reasonable test scripts and maybe documents in advance.
> 3. Build a ref-filter atom and its arguments to replace a pretty atom.
> 4. Make a translation between pretty formats and ref-filter arguments.
> 5. Modify the pretty code to ref-filter logic.
> 6. Recheck documents and run test scripts.

I would like to see more details here. Maybe you can explain every
step you mentioned in detail.
You can also include how much work has been done and what's left.

> * Benefits to Community
>
> I'm willing to stay around after the project. By that time, I will be in =
my
> second year without classes. And my tutor has an open mind about my reque=
st to
> invovle in an open source project by now. Consider the subjective and obj=
ective
> conditions, I think there is a high possibility that I will stay around.

s/invovle/involve
s/Consider/Considering

> Particularly, I wish to be a co-mentor if I have the ability. There may b=
e some
> difficulties. But what I learn from my finite experience is that you shou=
ld not
> refuse something positive just because of the difficulties in the mind. T=
he
> fresh new job may be difficult, but it can show me the possibilities of t=
he
> world, which means change my mind.
>
> What's more, I tried to persuade a schoolmate who I think is kind of obse=
ssed
> with technology to take part in an open source community for both self-gr=
owth and
> companion. And I failed, because he thinks it is hard.  It's always hard =
to
> change Others' deep-rooted ideas by word. But I think the actions speak l=
ouder
> than words. Maybe after the project, I can change the minds of people aro=
und me
> about joining an open source community. There may be no visual benefits t=
o the
> community of git but should be beneficial to the whole open source commun=
ity.

s/community of git/Git Community

> * Microproject
>
> t9700: modernize test scripts [1]
>
> The microproject patches have been merged. The merge info is as below:
>
> commit 8760a2b3c63478e8766b7ff45d798bd1be47f52d
> Merge: a2d2b5229e 509d3f5103
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Tue Feb 28 16:38:47 2023 -0800
>
>     Merge branch 'zy/t9700-style'
>
>     Test style fixes.
>
>     * zy/t9700-style:
>       t9700: modernize test scripts

Great.

> * Plan
>
> ** Deliverables
>
> 1. Documents.
> 2. Test scripts.
> 3. Modified ref-filter.
>    3.1.  New atom and arguments
>    3.2. New functions like foo_atom_parser, grab_foo
>    3.3. modified functions like grab_values and static struct.
> 4. Modified pretty which is plugged in by ref-filter.
>
> ** Timeline and feasibility
>
> It seems impossible for me to estimate the time consumed. The idea page [=
2]
> shows the expected time is between 175 hours and 350 hours. So I checked =
the
> timeline of GSOC, It shows that the official code time starts from 05-29 =
to
> 08-28 and can be extended to 11-06. After that I check my class schedule.
> The conclusion is as below:
>
> 1. now~06-05: around 2~3 classes every week. It is easy to cover the time
> project needs.
> 2. 06-05~06-30: There are many classes on workdays. Hope I can take class=
es with
> flexibility.
> 3.  After 06-30: This semester is finished.
>
> I think it is a bit time-limited if I follow the official timeline. It se=
ems
> necessary to do some work in advance.

Can you merge "Deliverables" and "Timeline"?
Please make a detailed timeline. It can be weekly or monthly depending on y=
ou.

> * Related work
>
> The blog by Hariom Verma shows the outline of the work.[3]
>
> This proposal draft benefits from Nsengiyumva Wilberforce=E2=80=99s recen=
t work [4]
> much. Thanks.

Maybe it's a good idea to include what you grasped from related work.
A brief synopsis?

> * Biograhical information
>
> It is always funny to recall that I first learned about Linux in a stimul=
ated
> hacker game in my fresh year in college. After that, I tried to teach mys=
elf
> Linux and started to know open source projects. Overcome many difficultie=
s and I
> finally know something shallow about Linux. As a side effect, I am more
> enthusiastic and better at programming compared with my schoolmates. But =
the
> period of stagnation came, I began to write some meaningless projects for=
 school
> tasks and repeated myself without progress. The best out of the worst, I =
touched
> excellent open source software during the time, such as vim, emacs, visua=
l
> studio code, Qt, VLC and, of course, git. Near the end of my junior year,=
 I read
> an article about learning by contributing to an open source project by a =
geek
> in the community of emacs. Almost at the same time, I knew the GSOC and p=
referred
> to take part in git. But it was near the start date of my plan for postgr=
aduate
> qualifying examination. So I just postponed the stuff for GSOC.  Luckily,=
 I
> passed the examination. After I got used to life as a postgraduate studen=
t, I
> felt the motivation to progress again. Then I tried to contribute for git=
. Now I
> just finish a micro project, which seems trivial. But it really let me ha=
ve a
> deeper understanding of open source and free software and more motivation=
 to
> contribute. I hope I can stay a long time here before being involved with=
 other
> interesting projects since the quality is more important than the quantit=
y.
> I know it seems a bit stubborn to believe that contributing will lead to
> progress, which is also influenced by my learning attitude. But without a=
ction,
> I can not verify the belief.  Sooat least I will try to contribute for on=
e year.
> After that, I hope I can have a better understanding.
>
> Sorry, the above text may be messing. In short, I will try to contribute =
for
> git for at least one year.
>
> * Closing remarks
>
> Thanks for Christian Couder's help.
>
> [1] https://lore.kernel.org/git/20230222040745.1511205-1-18994118902@163.=
com/
> [2] https://git.github.io/SoC-2023-Ideas/
> [3] https://harry-hov.github.io/blogs/posts/the-final-report
> [4] https://lore.kernel.org/git/pull.1452.git.1672102523902.gitgitgadget@=
gmail.com/

Thank you for your proposal. I left a few comments.

Regards,
Hariom
