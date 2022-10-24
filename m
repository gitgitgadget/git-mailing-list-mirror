Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8253AC38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 22:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiJXWor (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 18:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiJXWo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 18:44:26 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0003B70F
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 14:06:58 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 185so1846270ybc.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5c93IRdVKkpeUWCykR9dSLzTiXgqmsvRI3zWzemCvE=;
        b=Hh88EDvmwvYT5Dc+RMyV6PKlZujbVDJxLlF3GH0+ZcAFN9SUi60g+eEflyCHq7I9cq
         tXgSZl5gPNgTbWSRUQmAidKpSj3TIi6CUqyilCmtklBZ93EVlFX7II68LCX21RrGanYl
         4yGKxoOvUXkGiQfoehpPfsuYT304eFqR9jx+lEj7pcU0p09xs/fI5PY3xtwps19Z7EDM
         SmkYop6uUfpSV5AMHWKotlXqYxyYw9m4yHuha1f9itssWlkkZsw1Z9ODE7q5tmfqSLb4
         WLaH8cfngM0PKdT6ITGCoCQKSkUiEqzU0H2hor0XSHsewTA70yirenc9AgLKOflJV820
         hZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5c93IRdVKkpeUWCykR9dSLzTiXgqmsvRI3zWzemCvE=;
        b=HPKT4lxbI+LlRkasNuyaj23JDm325r5klniTkBpWokSmXYUC3rq8wqXx8gFK1I1JeZ
         J0vYBxaGeXEmbc7V7CvEA0mbn0js/9GVwCm9eWV8x8KWR1w49xVSgrsGzrp8f0G5QDFf
         boWV9aRjomaezcGdzWHILVRM/9MC8TOy27Gp31xae/5NQar2571pV2BL74L6V1wKAHRG
         jqvy/gCFSngCNrRsgwiQetx/Zsts8QN7rD9leHg6l6vPxRc3FS3qtbWc7iKhyrhO4RLO
         LCQ7pfBIMHCEH9y8vws1E9vjFERMlAqLpQvekNyoEj27rqQ27Z9PzrC68o51ocdl3P2p
         uIew==
X-Gm-Message-State: ACrzQf2flRl0IgIqViZrUkFkxdL2FasMhwGrDQqSjm0pVdrCCIlGVjkW
        53EEmsXp1iXE0ZIcGsytO3UwMvwKRcaEoj+DFsTE23M8GgQ=
X-Google-Smtp-Source: AMsMyM4zGxseDOOo5tCg7Qzr63W4cAQkiDruLVlvq/1qQFwapy7CKqrdp0arpYVfru7LrZQydeXl8SFFH0+EBRGCNmU=
X-Received: by 2002:a25:2fc8:0:b0:6bf:7267:3114 with SMTP id
 v191-20020a252fc8000000b006bf72673114mr29936170ybv.447.1666645237504; Mon, 24
 Oct 2022 14:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiGtoO4HYA+Z8_te5d0oBLYAxcXeZdTH17AJYaoZ32ObfQ@mail.gmail.com>
In-Reply-To: <CA+PPyiGtoO4HYA+Z8_te5d0oBLYAxcXeZdTH17AJYaoZ32ObfQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 24 Oct 2022 23:00:26 +0200
Message-ID: <CAP8UFD0J_vWkMjZAm3=LeS3KvZ3xzpkFXRWHLisuN7AbUui+BQ@mail.gmail.com>
Subject: Re: [OUTREACHY] Unify ref-filter formats with other --pretty
 formats[Draft proposal]
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wilberforce,

On Sat, Oct 22, 2022 at 1:43 PM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> Hi team,
> I would like to have reviews on my
>
> Google Docs link:https://docs.google.com/document/d/1Kdx8DVWF3c5pwV5-A8Z4=
n-SoRHlMDncI1gNeGCiLNsE/edit?usp=3Dsharing

Thanks for sending us a draft proposal!

> Microproject
>
> When I was browsing the outreachy projects on outreachy website, I was
> super excited about Git because I use it in most of my college work.
> At first, it was intimidating for me to introduce myself to the
> community. But I am glad I took a step. I am glad that I completed my
> microproject and the whole process gave me confidence on how to submit
> patches, communicate with the community members and interestingly, it
> was a big learning process for me.  The following are the details
> about my microproject with public-inbox links to different versions.
>
> Mailing List for the microproject:
> https://lore.kernel.org/git/pull.1362.v4.git.git.1665772130030.gitgitgadg=
et@gmail.com/
>
> Github:  https://github.com/git/git/pull/1362
>
> Status: next

Thanks for your work on this!

> Proposed Project
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
> Previous Work
>
> Hariom Verma contributed(final report) tremendously towards =E2=80=9CUnif=
ying
> Git=E2=80=99s format languages=E2=80=9D during his 2020 GSoC internship. =
Hariom
> finished most of the formatting options and this will help me build on
> his work.  His work looks smart and understandable thus adding on his
> work will be easy. And also his blog is very fabulous, it=E2=80=99s a sho=
oting
> point for me to start understanding the codebase very well. Hariom
> mentions in his report that 30 % of the log related tests are failing,
> he also mentions that the cause of tests failure is because of the
> missing mailmap logic and mbox/email commit format. Hariom also says
> it does not handle unknown formatting options. I plan to start with
> his advice about the cause of the failure of these tests and then
> intuitively refactor them into something cool.
>
> Summary of remaining tasks by Hariom
>
> -Around 30% log related tests are failing
>
> -Teach pretty-lib.{c,h} to handle incorrect formatting option
>
> -Email/MBoxed commit format needs work
>
> Some useful mailing lists links from Hariom

It looks like the links don't appear on the text version that you sent.

> Improvements to ref-filter
> Fix trailers atom bugs and improved tests
>
> Unify trailer logic for pretty.{c,h} and ref-filter.{c, h}
>
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

There might be a bit of work by a recent GSoC student too.

> The Plan
>
> My task is to look at how pretty formats are different from ref-filter
> formats. When some format is supported by the pretty formats but not
> by the ref-filter formats, and should prepare some patches to support
> the ref-filter format. I will basically build on Hariom=E2=80=99s previou=
s
> work
>
> Step 1:List down all the formats supported by the pretty format but
> are not supported by the ref-filter format

How long do you think it would take? If it's not too long you might
want to do that now, so that perhaps you can better estimate how much
work is left.

> Step 2:Read through different patches related pretty and ref-filter

Maybe s/related/related to/

> formats submitted by different contributors to get a solid and a
> thorough understanding of the pretty and ref-filter formats.
>
> Step 3:Understanding an implementation of one or two pretty formats,

s/Understanding/Understand/

> and then look at how it was implemented in ref-filter format. This is
> going to give me direction to refactor the remaining pretty formats
>
> Step 4(possible approach): Pick one format option at a time and
> convert it to use ref-filter option format

Ok.

> Estimated Timeline
>
> Time Period
>
>
>
> period: December 5,2022 - January 2, 2023
> Community bonding
> tasks
> -understanding all the logic of pretty.* and ref-filter.*
>
> (what functions are used and how all formatting process is going)
>
> -Working with mentors and identifying the best candidates to be converted=
 first.
>
> -Converting a couple of formatting options to reuse ref-filter formatting=
 logic.
>
> -Update Documentation.

Updating the documentation is usually part of the patches that are
sent. So I don't think you need to make it a separate point.

> period: December 25, 2022
>
> Christmas celebrations: Join my parents for celebrations
>
> period: January 1, 2023:
> New year=E2=80=99s day holiday:Join my parents for celebrations
>
> period: January 3 - February 3, 2023
> Coding Phase 1
> tasks
>
> -Add on Hariom=E2=80=99s work:Converting more formatting options to reuse
> ref-filter formatting logic.
>
> -Finish his incomplete work
>
> -Update Documentation.
>
> -Possibly look at Olga=E2=80=99s work
>
> period: January 18, 2023: Cake cutting with my  friends
> My Birthday:cake cutting
>
> period:From January 6 - January 18, 2023:
> Semester Exams: I will be working for a few hours per day and always
> be available to reply to any communication
>
> period:February 3 - March 3, 2023
> Coding Phase 2
> tasks
> -Final touch-ups and bug fixes(if any)
>
> -Update Documentation
>
> -Wrapping up.

Ok.

> Blogging about Git
>
> I do love writing a lot however much I have not taken time to put out
> my personal opinions and thinking. Being an avid reader, I think it=E2=80=
=99s
> now my time to start letting other people read what I write, to let
> people know what I think, what I am doing with my life. And guess
> what, I am super excited to start with Git.

Great!

> Availability
>
> I can easily devote 50 hours per week since my college just requires
> 15 hours per week. I plan even to work more extra hours for my
> internship tasks when time allows.

I don't think Outreachy requires 50 hours of work per week. That seems
a bit too much if you also attend college.

> Post Outreachy
>
> Apart from being an Outreachy intern, I plan to remain a member of git
> community even after my internship, because I believe there is more
> today even after the Outreachy internship

I am not sure I properly understand this last sentence.

> Here are some other things I=E2=80=99d like to do beyond Outreachy
>
> Mentor other students
>
> Doing code reviews for other contributors
>
> May be complete the work that I will have left pending after my internshi=
p
>
> Keep learning from all of you...

Great!

> Experience with Open Source
>
> I have little  experience with open source, so I hope to learn a lot
> through my internship with Git from you all.
>
> Motivation
>
> Git being a world=E2=80=99s best developer version control system, I feel
> overjoyed that even my little first patch was accepted. The community
> is very welcoming, the people there answer questions very first and
> this turns everything overwhelming to a simple process
>
> Closing remarks (Optional)
>
> I am a consistent and passionate learner. Even if solving a problem
> may look tricky to me, I just give it all my 100% time and think of
> 1000s of ways to approach it. I know I do not have the required
> expertise to begin working with a skilled team like Git but I believe
> in learning slowly by slowly until I will make it to the peak.
>
> I hope you consider and give me a chance to work with git. It=E2=80=99s a
> great hope I have that this opportunity is bringing me closer to my
> dreams. Thanks for your consideration.

Great, thanks!
Christian.
