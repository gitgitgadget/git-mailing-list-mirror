Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79DCC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA7B2071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGvgmtY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390823AbgEYU4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390802AbgEYU4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 16:56:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77FC061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 13:56:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f83so18492886qke.13
        for <git@vger.kernel.org>; Mon, 25 May 2020 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXU+YsSPgReGJZxWyT6QrWr4bAGUy8M/vrEElzXqzUM=;
        b=UGvgmtY/heEiPXWE9csZsGCjk545kmDCdslE0s92gYsOERxPKZxM3E3tagCUAbxa+d
         Mbx+w7WkMc/jDA7Lfj5CHbFibxj4+36HlvZKH/3nf/UQm3tdC2bmzvnPAFfiAK6ef1lc
         6vuoBg4RnutEnl7cjxsY4YAUmw5kooIh/vX0gWBJclV1+g96DMR8OwCyedqGuKfdprzK
         XJI1jVH2nvQsnaCIAg3pQdPoLKKfowZbkVPmdDcZtRozBGKBMWuwKmeBVmRHPS+Bsv0K
         Oqw/DolD8vWRy9HxttN/fXNu83WV8SB9DKTdXR8vNuozIBxhK7i/NqXAyluc4MTFF765
         YnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXU+YsSPgReGJZxWyT6QrWr4bAGUy8M/vrEElzXqzUM=;
        b=ASo2T/27P/S0yCt+hVhFWweTH5bqnt9dDbEf5P4nQIT1IlqZwwtBR8wwIQTWw8lHhR
         PRFX8xWHd1IA2hFJ1Dpt+v1GDMXR2v6hErCSqXoKx2wlJ/+d192gUXX+oWXoW5XuCG8R
         Abj2joYEq1J+zjA2SmZpy+opRn1MSAI16lxht7kJOkuDKgDSH7w15jZosH58rT0GC48u
         tS44Lyt3naOq3vESJDVcJBuWuUbCFA+vf4sW5jU5AWyLDd+PUGG8Uey52tDQ0y37RM7S
         rl/NX6wuh9HYb8bgjzAW7sDMUqw+0A8rJYNOmAdenYFz43U/8UtC0KgPSYAq+GQZUpH2
         OnDQ==
X-Gm-Message-State: AOAM533bGm7eVO114J7N37MmTwFN2H3xphow0vsvZHq3OpRUYzgZezaN
        wg41cJ8b6MFtptIMerOkmCBFAMwE7NMkqXwBPMmDZLc6
X-Google-Smtp-Source: ABdhPJwneFfIjwYWPvl6pOLw233xzwr45MURJ1q4/LPHiHu4o15iIiiSgI3g0ysI82FPRPsxadBBOHvNq4YVLI/QAY0=
X-Received: by 2002:a37:a89:: with SMTP id 131mr10933078qkk.92.1590440181278;
 Mon, 25 May 2020 13:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <fa1b8032906c6042a0e5851f803ec0427922a1a5.1589302255.git.gitgitgadget@gmail.com>
 <xmqq3684c096.fsf@gitster.c.googlers.com> <CAKiG+9VXk1vdMM1amQK6pnHcn9H_93-3fkqgK4nwKf=GtrDGyg@mail.gmail.com>
 <CAKiG+9Uz4YG=Hq9PRN8EhFF_agXNUPRnYjetY=ZNVRE6_VDAew@mail.gmail.com> <xmqqzh9vok90.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh9vok90.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 26 May 2020 02:26:10 +0530
Message-ID: <CAKiG+9UXa_1tfJ49gXGQCKTK5hqmVSAV2SqEc4iZCT54i18h6Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ci: modification of main.yml to use cmake for
 vs-build job
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 26, 2020 at 1:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>
> > 1) Relocating the CMake script to contrib/buildsystems from patch 01/xx.
> > 2) Parse the Makefile for sources from patch 01/xx.
> > 3) Reworded the commit messages you pointed out.
> > 4) Rebased the ST_BLOCKS_IN_STRUCT_STAT and ICONV_OMITS_BOM to patch
> > 01/xx to make the review process easier.
> > ...
> > No new features will be introduced in the script, to make the review
> > process easier.
>
> You did not answer <xmqqd077qnqc.fsf@gitster.c.googlers.com>,
> so I have to guess.

Sorry, was going to reply to that, but forgot about it along the way.

As for my reply to that for windows only support we do not need
a few of the checks namely:
1) HAVE_BSD_SYSCTL
2) ICONV_OMITS_BOM (because we are using GNU libiconv 1.16)

The functions checks (check_function_exists) is needed.
A few of the header checks are unnecessary(paths.h sys/sysinfo.h).

The difference in build between Linux platforms and Windows would
be 8-15 lines of code atmost . I see no point in the extra Linux stuff to be
a burden for the reviewers.

There is another way of just copying the configurations in config.mak.uname,
but this hurts the purpose of configuring in the first place.

>
> I am guessing that your answer would be that if we keep this series
> concentrate only on Windows support from the beginning and do not
> add support for any other platform at all, the scope and necessary
> effort to bring the patches in reviewable shape would be reduced
> dramatically.  And if that is the case, that would be great.
>
> In other words, I'd prefer not just "no new features", but "with
> much less features, now we do not even add support for Linux or
> macOS to the initial patch series".

macOS support is ways off, needs quite a bit of work.

In terms of Linux support apart from the function, header checks there
is nothing special
implemented here.

>
> But because I haven't heard the question answered, I cannot tell if
> that level of simplification is possible and if that is already what
> you did in (silent) response to my questions.
>
> > I have looked at the GIT-VERSION-GEN script and the logic it uses to
> > determine the version of git.
> > The logic is a bit complicated to be implemented in a  CMake script,
> > so I am skipping it for now.
>
> Regarding the generation of GIT-VERSION-FILE, I asked you why you
> need to hand-parse, instead of running the script itself, which is
> the way you generate the config-list.h file in the same patch, which
> is done with execute_process() to run generate-cmdlist.sh.
>
> You did not answer the question, either, so I have to guess.
>
> I am guessing that it was an oversight that you did not update the
> procedure to handle GIT-VERSION-FILE because you wrote the "let's
> string-find in the GIT-VERSION-GEN script" approach way before you
> wrote the other parts of the CMake thing, and with the experience
> and hindsight of having written command-list-h support, you now
> realize that running the script to ensure that you get the result
> consistent with folks who use Makefile would be much better.  After
> all, the logic being more complex than your CMake support can
> express shouldn't be an issue, if you just let the logic execute
> itself, no?
>

Yes, fair point.

Have executed GIT-VERSION-GEN, then parsed the GIT-VERSION-FILE for
version info.
Added it to the list of changes.

> But that is also merely my guess, so...
>
> > Any other changes I should make before I submit PATCH v3?
>
> ... at this point, it is too early for me to answer that question.

Thank You,
Sibi Siddharthan
