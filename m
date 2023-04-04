Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E099C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 08:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjDDIcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 04:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjDDIcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 04:32:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF221A8
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 01:32:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a44so14307352ljr.10
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680597148;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pk6rZNkV1KlgO/YLTYU089XyMZPc6zRHJn+t+460SrY=;
        b=jIaToJDPxxJDg/3wJW4SrsgMSUZs7+i4cpxIZ/IZdW5+wHvwLJ/9SN6mH61Q+yA0pM
         U1HeEeq096mcKhL7SUi0YkN4l3rGsdQ29HOi+bq6Fj763e5Hgf58rreGeZ+LVKRFrsYw
         pJ15w4Aj7fDiUfGX2NojVZOacq2gtpTIwUCeetW6eR8mvBZNycPSCd/uH511T5I+qlz4
         pLDZudv1HqHuKuh8aJYV9Y+j2aqK7U0E17FFJTJ0dlEmG7OSlvBQs9V64KCkIIoy4vKj
         FEfcYWV8r0oHGPE21ubq4ISh5dKIcSHXku3iQugUmMPBFnHEc60Q/0zLp0i090ZVboSG
         7Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680597148;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk6rZNkV1KlgO/YLTYU089XyMZPc6zRHJn+t+460SrY=;
        b=szrKDGCbJ+1LMlNjxQEwP3HtvOwsBq1LoyMJBFK0o7UCrDCb/SIq5DZ3HoZhIlUGQV
         x/akPVr7tVsvm9bpL03pdH0i+D98e8HDduXlOJlzHV/o2RJhpmOLS7xhQKY2ljWyXqKk
         FX8p0LL+XRX2DVAsY5tPz99aR0ce3+xohc2FEhgcwDn0juqGvlkrA9lwrqPFykeOdEo2
         Qz4F33uktnccN7IL+xHBskz+sUhKCCvgzPMezXIMLyxsaRKrKTqA2cfb2CnuSuh6sBDm
         zltx+NE7ayQZNiCheXHtSTHVhvtAgep8FDSeEKcm7crafJSHhKYB4v81giZOzgl/Fssv
         ppyA==
X-Gm-Message-State: AAQBX9dgNd/xd5HXrhPaIukf0FX6MOBNUtryGpMNDZYNA+Y+0oEpaUqU
        8cSMihDp8aGcwXYjPEuPknHFE4v9DMDl64IsKiRfR5FLAuA=
X-Google-Smtp-Source: AKy350ZRMczUbi6AMJEOraIK4I6ACyzeXA2SsFRcSIoAXhkeX+Cj1V0x7G+tpdxUAVLR4zGWaiIihZ6YWAPrbMffklQ=
X-Received: by 2002:a2e:9d18:0:b0:29d:a0b4:aa55 with SMTP id
 t24-20020a2e9d18000000b0029da0b4aa55mr709171lji.10.1680597148211; Tue, 04 Apr
 2023 01:32:28 -0700 (PDT)
MIME-Version: 1.0
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Tue, 4 Apr 2023 14:02:16 +0530
Message-ID: <CADE8NaqxPo0K-tcjGzD_D+5rt_bFyGrKzMmmw3a46AuBX_=+Rw@mail.gmail.com>
Subject: [GSoC Proposal V2] Unify ref-filter formats with other pretty formats
To:     git@vger.kernel.org, christian.couder@gmail.com,
        hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone!
This is V2 of my proposal for GSoC 2023. I try to make the timeline a
little more precise and unambiguous, and add clear deliverables.

The proposal can be read at:

https://docs.google.com/document/d/e/2PACX-1vQB-LTb_pu6dISl-viI7K7lmA0dUgfg=
keCBnaUoLSWl6Rq7MMuQZOuQ4FAqIiXYri4V7qSa-jzCabK-/pub

Thanks a lot!



-- Unify ref-filter formats with other pretty formats --


-- Personal Information --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Name:                 Vinayak Dev
Email:                vinayakdev.sci@gmail.com
Github:               @vinayakdsci
Country of Residence: India
Ph no:                  +91-9119055909
Education:            Bachelor of Technology,
                            Computer Science and Engineering
                            University of Engineering and Technology, Roork=
ee.
Year/Semester:        2nd/IV


-- Overview/Synopsis --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Git has had the problem of different implementations to format command
outputs for different commands in the past. Through the efforts of the
community members and the past GSoC and Outreachy participants, much
of the formatting logic has been unified into ref-filter.c, allowing the
code base to get rid of duplicate implementations.

The current task of the project is to continue this effort and use the
formatting logic from ref-filter.c in pretty.c, to allow getting rid of
duplicate formatting logic.

Outreachy participant Olga Telezhnaya and GSoC participant Hariom Verma
provide a good insight into the logic and approach required for using
ref-filter formatting logic with other commands, like git cat-file, etc.
Olga also makes an attempt to generalize the formatting logic in
ref-filter.c to allow for migration to other commands easier.

Their blogs at [1] and [2] are a good starting point to understand the
structure and the history of the work on this idea.

Nsengiyumva Wilberforce also sent patches to the mailing list[3] where
he adds a new `signature` atom to ref-filter.c. He was unable to fulfill
the requirements for the Outreachy programme, but sent the patches
nonetheless. His work allows to get rid of the implementation of the
`signature` atom in pretty.c, moving it to ref-filter.c for better
unification of the logic with other commands.

Also, the discussion[4] on the mailing list, with a patch series
concerning pretty.c by Anders Waldenborg add and improve upon the
features of git's pretty-formatting, with insightful comments about the
process from the reviewers, Eric Sunshine, Junio C Hamano, and
Jeff King.

[1] https://medium.com/@olyatelezhnaya
[2] https://harry-hov.github.io/blogs/posts/
[3] https://lore.kernel.org/git/?q=3Df%3A+Nsengiyumva+Wilberforce
[4] https://lore.kernel.org/git/20181104152232.20671-1-anders@0x63.nu/T/#u


-- Before GSoC --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I joined the Git community in February 2023, and have since then been
hugely inspired by the efficient and strong workflow, and how the
members encourage newcomer's contributions, despite Git being such a
large scale and important project.

To understand the source code, I have referred to many sources, some of
them being the Reference Manual, Git Internals, Hacking Git, and the
Pro Git book by Scott Chacon, all of which provide a good and deep
insight into the working of a git, both on the level of the terminal
commands, and the source code. (including MyFirstObjectWalk)

I have submitted following patches to Git:

1. [PATCH] t9160: Change test -(d | f) to test_path_is_*
   Description: The patch was intended to be a microproject for Git for GSo=
C.
                It replaces the test -f and test -d commands in t/t9160
                to helper functions described in t/test-lib-functions.sh,
                which provide better diagnostic, and error messages.
   Status: Discontinued

2. [PATCH v3] apply: Change #define to enum and variable types from int to =
enum
   Description: The patch changed preprocessor constants defined in apply.c
                to enums, along with changing the types of variables to the
                respective enum types, to allow for easier debugging in cas=
e of
                errors (many debuggers support listing out the
constants, if they are enums).
   Status: WIP


-- Benefits to the Community --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Git is a great and big community, where people volunteer to maintain
one of the best and well-written codebase of all open-source projects.
I, too, aspire to be a permanent part of the community, and leave a
lasting effect on the developer community. Since I joined the mailing list,
I have loved the way people communicate and work together here.

So, I want remain a part of the Git community irrespective of if I am able
to make it as a GSoC contributor or not, as I am sure that Git will help
me become a better programmer, and a thinker in general.

This project is important as in my viewpoint removing duplicate logic
and unifying it helps improve the modularity of the code base, and make it
sleeker, which is one of the best qualities of the Git code base.
The project would help newcomers understand code easily, and remove scope
for error-prone or failing code, which often results from duplicate logic.


-- Previous Work --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
GSoC candidate Hariom Verma and Outreachy student Olga Telezhnaya
did important work in the direction of unifying formatting
logic into ref-filter.c and removing duplicate implementations in
other commands. Most importantly, Hariom's work, where he tries to
create a transition table(pretty-lib.c) between pretty.c and
ref-filter.c is important and highly relevant to this project.
It provides a good starting point and gives an insight into the code
in pretty.c and ref-filter.c.

His blogs(mentioned above) provide an insight into the way of thinking
he adopts, as he implements the logic. This helps to understand the
way of thinking of another person, which again provides knowledge.

Olga's work is important as it describes how the student might face
difficulties, especially during bug fixing. This makes me confident
and less hesitant to ask on the mailing list and to the mentors.
Also, she describes how she generalises the logic of ref-filter.c
to allow for better integration to other commands, like git cat-file.
The blog posts also emphasise the need for comfort with a debugger like
GDB, but that is alright.

Hariom has clearly described, and given a link to his commits[5], how
he adds new formatting specifiers in pretty-formatting.


[5] https://github.com/harry-hov/git/tree/pretty-lib-2.0.0


-- Proposed Work --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
As Christian Couder mentions on the mailing list, one of the most
important parts, while removing duplicate logic in pretty.c is to ensure
that ref-filter.c has to support all the atoms that pretty-formats have.

This is in accordance with the work of Nsengiyumva Wilberforce,
who outside of Outreachy has sent patches to implement the `signature`
atom in ref-filter.c. This patch-series is therefore an important
reference for much of the work in this project.

Therefore the target/proposed work is to implement at least some of the
atoms supported by pretty-formats into ref-filter.c, and then clean up
the duplicate logic. This should provide a neat and clean way of working
when applied incrementally.


-- Deliverables --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

*   Support for atoms in pretty.c moved to ref-filter.c
*   Removal of  duplicate logic in pretty.c
*   Teach pretty,c to take formatting logic from ref-filter.c
*   Proper documentation for the new changes
*   No new breakages introduced in the code-base


-- Timeline --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
April 5 - May 4 -
Keep contributing small but meaningful patches,
as this is the best way to get comfortable with
and gain more familiarity with Git=E2=80=99s source, especially
ref-filter.{c,h} and pretty,{c,h}

May 4 - May 28 -
Look for atoms in pretty.c that are unsupported in
ref-filter. This is important, as atoms must be supported
before the formatting logic is re-written in ref-filter.c
Read and understand the documentation and previous
work and related commits in the history of Git.

May 29 - July 13 -
Add support for and implement atoms from pretty.c
to ref-filter.c. Write new tests to ensure that logic is
not broken. Ensure that all old tests pass.

July 14 - August 21-
Implement duplicate formatting logic from pretty,c in
ref-filter.c, now that atoms are supported.
Update documentation related to the changes, and
write new tests, while again still ensuring that none of
the old tests fail.

August 22 - 28
Clean up any mess in the codebase, if present.
Remove redundant/unneeded code and format the
code to make it more readable and easier to understand.


-- Blogging --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Like many participants on this mailing list, and programmers in general
I also find the idea of blogging about new topics and recent findings
to be an extremely enriching process. However, till now, I was just
playing with the idea of starting a blog, but now I am confident enough
to go ahead and start one. I intend to host it on github[6], and post
new information and updates about my progress regularly(weekly seems best).
Many people I know have progressed incredibly through blogging and sharing,
and I take huge inspiration from that.

[6] https://vinayakdsci.github.io/

-- Closing --
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Becoming a contributor to Git has been extremely meaningful to me.
It is the first real software that I have actually been a part of,
and interacting with people in the Git community has been a great and
memorable time. I hope to keep contributing actively, and remain a part
of the community as long as I can, maybe forever!

Thanks a lot!
Vinayak
