Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894A2C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 17:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjC3RVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjC3RVq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 13:21:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF13EB79
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 10:21:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so22706473pjt.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680196898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QnlLuFxwEJOMpiz8did1eySjD0O8qoWUpBhNtpyB4Jk=;
        b=fUb1qw6+6MUZ5ui8UvLQK6p4YJ7JVT+0/tZD3G4raKd113HPVqsV8ZbWrDxSIqCDVS
         O6Mi0j6S4HcL8P66qM46k5vrGTX4uI7VLoafnt2YCfBT9voiSX2y2/GlJA8HI8Imq9Pu
         xiAkwl0cuDVHYYmIQFoG0D44uRIywtnb1OGm2IDOCVfc5v0oMQ3dnZPPd24CrlnQbUuE
         OkuWIf9EblC04wWx7EwUkH0vwawvjPyvZRHwafg5UpSOScahsMMKl1LsKjYqveF1SgfY
         YKNvz5xUBKw+F3sTDIwfoL6EqUVWLxHnmdO+3Kgiq8gOYtyQR3gJPN8cRw8ZTERTF9xm
         ffpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnlLuFxwEJOMpiz8did1eySjD0O8qoWUpBhNtpyB4Jk=;
        b=2p2FWpbPf4ya68uv4gzy+iVopWduPCHlGXO5xS47irEDDozXy2EI+K3wZ1jU1bmEHe
         2K2PpQmO5CF8SyYR31f9HsPpIxrdIkTAUDdpjE/QSZXXE5ONxZcgTx6UyToL6AISrA0J
         Yu/yAhyRittjriSWfNF52gry2SRpxhJH5E2njuZzLGSntuWAEIMlpDUF6uUCrEheBth7
         lSrr1aSfFPcaHrxXNokglfS4ygRoaGuEdYGjgFJawbiD1mgxSoD+GvTL9Jd+nN3Sp2TO
         qlSa1Ybf5+z6wowjWvlLjfGdSW6trg1r8Jx+gXGgoNoO9LDZTQpjTGkJ+U2AbLEjpGpm
         AVMw==
X-Gm-Message-State: AAQBX9cmIfTkGEmKYVUBHbbLYc9eozpjlhqIDzxO10XVWAkZtnQlIiQH
        uE8JS7zihjEpiGZHRDigbmA+RpHlusRReg==
X-Google-Smtp-Source: AKy350a7Yll7jOV9Sa4HKYK72zdce8MgwXohC3u6EsNV5lWaVZPDTXirctL3dOGrTQpzCi3UmlXkLg==
X-Received: by 2002:a05:6a20:4ca4:b0:d9:4c19:fe69 with SMTP id fq36-20020a056a204ca400b000d94c19fe69mr7542167pzb.25.1680196898135;
        Thu, 30 Mar 2023 10:21:38 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.149.166])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78195000000b0062a54ce6b2bsm134257pfi.108.2023.03.30.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 10:21:19 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        five231003@gmail.com
Subject: [GSoC][Proposal] Unify ref-filter formats with other --pretty formats
Date:   Thu, 30 Mar 2023 22:50:52 +0530
Message-Id: <20230330172052.10680-1-five231003@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This proposal can also be read at
https://docs.google.com/document/d/1JBznA5n0WdWsbEskCeXxOnQuaa0urD89VtprxstLPzo/edit?usp=sharing

Unify ref-filter formats with other --pretty formats

Personal Info
=============
Full Name: Venkata Sai Sri Kousik Sanagavarapu
E-mail: five231003@gmail.com
Ph. No.: +91 6304308245
Alt. Ph. No.: +91 9704654555

Education: Vasavi College of Engineering, Hyderabad
Year: II / IV
Semester: IV / XIII
Degree: Bachelor of Engineering in
	    Electronics and Communication Engineering

Github: https://github.com/five-sh

Overview
========
Git has an old problem of duplicated implementations of some logic.
For example, Git has at least 4 different implementations to format
command output for different commands.

The goal of this project is to reduce these duplications and work
towards a single implementation to format command output. There is
more than one way to do this and there has been work done on this
by GSoC students and Outreachy interns before me.

The expected project size is 175 hours or 350 hours and the difficulty
level is medium.

Pre GSoC
========
I first got into Git’s source code around October, 2022 and have been
going through code of topics that I found interesting whenever I had
some time away from my college work. The following are the patches that
I submitted, from earliest to the latest:

[PATCH] repository-version.txt: partialClone casing change
Status: merged into master
Commit: 29c550f0a
Merge Commit: 859899ddc (branch: ks/partialclone-casing)
Description:
This was my first patch to Git. I had found that the configuration
variable extensions.partialClone had a typo in the way it was documented,
while reading the documentation surrounding partial clones. Now that I
look at it again, it seems that the patch was kind of noisy because the
config variable would have still worked with no emphasis on the case but
I guess it’s good to have everything going in one pattern, for the sake
of documentation.

Mailing list:
https://lore.kernel.org/git/20221110160556.29557-1-five231003@gmail.com/

[RFC][PATCH] object.c: use has_object() instead of
		       repo_has_object_file()
Status: Peff and others took off from here
Description:
This again was kind of a search-and-replace type of patch. I wasn’t
really sure of the code and made this change as a result of the
comment surrounding repo_has_object_file() which says that this and
related functions are deprecated (hence the RFC). Peff reviewed the
patch and explained about this function and the use of it in the
particular case where I made the change, which was really helpful
and added to my knowledge. Peff also realized that there were changes
to be done to the logic of parse_object() (the function in which I
made the change) and submitted patches, which were in turn reviewed
by Ævar and he submitted changes in response to that.

I now think that I should have replied to the review and taken part
in the discussion, leading to me learning something more, but I was
so overwhelmed that I didn’t do it. I corrected this in my later patches.

Mailing list:
https://lore.kernel.org/git/20221116163956.1039137-1-five231003@gmail.com/

[PATCH] merge: use reverse_commit_list() for list reversal
(Microproject)
Status: Discontinued
Description:
This was a change I did to address the issue #1156 on gitgitgadget.
This was however not a correct change logic wise because the
reverse_commit_list() function modifies the list in-place (that is,
uses the elements of the original list to make the reversed list)
such a modification could break merge if we had multiple merge strategies.

Mailing list:
https://lore.kernel.org/git/20230202165137.118741-1-five231003@gmail.com/

[PATCH] commit: warn the usage of reverse_commit_list() helper
Status: Discontinued
Description:
This change was made based on the preceding patch but according to the
review it seems that such an addition to the comment was unnecessary
as the original comment was clear enough.

Mailing list:
https://lore.kernel.org/git/20230207150359.177641-1-five231003@gmail.com/

[PATCH v4] index-pack: remove fetch_if_missing=0
Status: Discontinued
Description:
This change strove to remove the use of fetch_if_missing in index-pack
by replacing has_object_file() with has_object() which does not
lazy-fetch when an object is missing in a partial clone. A test was
also added to make sure that this change did not lazy-fetch.

This patch was discontinued because it was decided as a result of
discussion that it would be better to check all the cases where
fetch_if_missing is set to 1 and make changes there so that we either
fetch efficiently or not fetch at all. By doing this, in the final
world-view, we can remove fetch_if_missing from index-pack as it
would be set to zero everywhere.

Mailing list:
https://lore.kernel.org/git/20230317175601.4250-1-five231003@gmail.com/

Proposed Project
================
Goal
====
The goal of this project is, as the title says, unifying ref-filter
formats with other pretty formats. It would be great to have a single
interface, which took care of all the formatting and not have different
logic to implement different formatting options. Quoting from the mailing
list discussion

https://lore.kernel.org/git/CAL21BmnU2aTT_8iqejurgKeHXk-kmmGK1tmXLcVh7G12rwRPOw@mail.gmail.com/

“For example, 'short' in pretty means 'commit %(objectname)%0aAuthor: %(author)'
in ref-filter”

Previous Work
=============
There has been much work done in the past in this area. It majorly comes
from previous Outreachy interns and GSoC students.

Olga Telezhnaia <olyatelezhnaya@gmail.com> did work in this area in the
fields of `cat-file` and `ref-filter` as a part of her Outreachy Internship
titled “Unifying Git’s format languages”. This work and also the work done
after that helped take ref-filter to a more general setting. She blogged
about her work here

https://medium.com/@olyatelezhnaya


Hariom Verma <hariom18599@gmail.com> did work in this area as his GSoC
project titled “Unify ref-filter formats with other --pretty formats”.
This is the major work done in this area and the final report can be
read at

https://harry-hov.github.io/blogs/posts/the-final-report

This work is very useful as this serves as a kind of documentation
and starting point to work towards the goal.

ZheNing Hu <adlternative@gmail.com> has done major work under his GSoC
project titled “Use ref-filter formats in git cat-file” in the area of
git cat-file, but more relevant to this project are the changes done to
ref-filter. This work was a continuation of Olga’s work and made some
changes to ref-filter logic. His final report can be read here

https://github.com/adlternative/adlternative.github.io/blob/gh-pages/blogs/gsoc/GSOC-Git-Final-Blog.md

Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com> did work in
this area as a part of his Outreachy Internship titled “Unify ref-filter
formats with other --pretty formats”. He got rid of the duplicate
implementation of the `signature` atom logic. This work can be read here

https://lore.kernel.org/git/20230311210607.64927-1-nsengiyumvawilberforce@gmail.com/

Difficulties
============
A major difficulty is backward compatibility, so any changes made to
remove the duplicated logic would need to be done so very carefully.
Any new tests added must also be very precise so as to efficiently
test the changes that are made.

There are also minor difficulties, such as the older tests failing
because of the changes made, so the work will have to be in such a way
that those tests are successful and the duplicated logic is refactored.

The Plan
========
I think Hariom’s final report of his GSoC project is a good starting
point for working on the project. The report lists the work which is
left in the “WHATS LEFT?” section, so I think the first issue to work
on would be to look into why “Around 30% of the log tests are failing”
and to work in the area of mbox/email formatting for commits. Work can
also be done to make pretty handle unknown formatting options.

From here, I can work on the remaining portion of the formats and can
remove the duplicated logic wherever possible, also writing tests to
ensure that everything works.

I can take the approach similar to what Hariom did before this.

Estimated Timeline
==================

Misc
April 5 to May 3
- Continue to work on git and get more familiar with the code.

- Find and fix stuff.

- Work on stuff that interests me.

Community Bonding
May 4 to May 28
- Get myself familiar with the code of ref-filter.{c, h} and
  pretty.{c, h}.

- Communicate with my mentors about the approaches that can
  be taken to get to the goal.

- Working on Hariom’s branches (mentioned in his final report)
  and making changes on top of them.

Coding Phase I
May 29 to July 14
- Convert formatting options to reuse ref-filter formatting logic.

- Update existing tests and add new tests.

- Update documentation.

Coding Phase II
July 14 to August 21
- Further convert formatting options to reuse ref-filter formatting
  logic and teach pretty to handle them.

- Update existing tests and add new tests.

- Update documentation.

Final Coding Phase
August 21 to August 28
- Wrap up and fix bugs (if any).

- Update about the remaining stuff (if any).

- Make a final report outlining future work.

Blogging about Git
==================
I think blogging is one of the important parts of any project. It
helps other people understand what one is doing and helps the person
get to a better understanding of their work. I will blog about the
project every week, the blogs can be read at

https://five-sh.github.io/

Availability
============
I will be having my semester mostly throughout the summer and so will
be able to work 35-40 hours per week. I will always be able to dedicate
more time towards the project on the weekends.

I will be in contact through my email and my phone.

I am also open to calls and online meets.

Post GSoC
=========
I love being a part of the Git community. The whole process of getting
to work on git’s code, submitting patches and getting reviews is a new
and great experience for me. I plan to continue in the community after
GSoC too and will continue contributing to git and will continue learning
from all of you.

I am also open to co-mentoring or mentoring if ever given the chance.

I also am very interested in partial clones and I hope to work in that
area.

Closing (optional)
==================
Ever since I first got into git’s code and its community back in 2022,
it has evolved into a very unique and great experience for me. I have
learned so much in the past few months and will continue to do so from
all of you here at git.

Hariom's proposal has been a great resource in writing this proposal.

Thanks & Regards,
Kousik Sanagavarapu
