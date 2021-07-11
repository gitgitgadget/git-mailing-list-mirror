Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2414EC07E95
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F363661220
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 00:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhGKAbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 20:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhGKAbl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 20:31:41 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A6C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:28:54 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so14061724otq.11
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bVuOaLzlsEciU3iSSv0Ebj1lprhf2FSPQqQmLw+yPd8=;
        b=XXId7m9vY80D20ulG8k8Qe8noUP8jhIrNBgFBFtag3j6FeKKuiQJUpmkWTyDqDeyPZ
         iDgQFGErAhMEDEoo1fF4W2JxbCp2owt3IHARAbJ+ZuhQeK6PgGaJWE9e/MapHjjps6wJ
         33wKFCGDdyaDn39RtH4YDm30gIoeuXNkFmQONrSHolWZIBAma9OvW62E85hZA4BRENso
         FtQHagz+pzQ1Dw44rFAPQqNvgO683S57m/doIMPMNB3txzp3AeW92D0HajtwtmVr1EU4
         dq1Suqil1IKWUHgkpJut8LNPDxA+zetzBxmHnbHgYL79Zl04w1J/RbiicrYU6BU6j+jW
         9J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bVuOaLzlsEciU3iSSv0Ebj1lprhf2FSPQqQmLw+yPd8=;
        b=GzNkCWgT+qQNdN76vdyNLbCfq7u05YEwkKsgj7Dk1IL7Ns4iRDxnkExA4JV2HGUftC
         5bT+hJKx8UNRhn+32Z8seCIU0juNUl1yr5I0RilPyZQZBrb+Yszt33dUrranKwzQoROv
         alr8MHFq/KleJDWqgyDdD8VDeo/vDQmGZ05L4WGuYdarwT4mmW4C144SuO1laqzOB7UK
         dx/zMU6TWEsmAC1X9WU9DYgDupGxwtazHKU+fzuHHgLuI9M1w/Ya6MhB7ubRPyOgkdfW
         vE6jrcppQhi1VzeYg9jcIyGeH320NCvL0rsFPI7Xzp0PT9uGgva7V/eA0sAVOYI9rv8V
         +IQQ==
X-Gm-Message-State: AOAM533k31oS0RBHcbBUSUuD9Tah8hwYMhpRYG7u+HmNAhVE+LuJ/QbT
        UCvXdLgLNMMAWzErY+7vmxkg9nXkzN4OgOgFG6BRjSaPcF80xw==
X-Google-Smtp-Source: ABdhPJxzdX0QcFukOAKegGM+t7IZegYpZe2g6x39QEzWX/X1+SHQvwbRf/mLuoCCZf22mDyTn81Jx86/u7boSilzLnU=
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr31521648otp.316.1625963334147;
 Sat, 10 Jul 2021 17:28:54 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 10 Jul 2021 17:28:43 -0700
Message-ID: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
Subject: [RFC] Bump {diff,merge}.renameLimit ?
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[CC'ing folks I've seen comment on these limits.]

Hi everyone,

I'm considering bumping {diff,merge}.renameLimit, which control the
quadratic portion of rename/copy detection.  Should they be bumped?
If so, moderately higher, or much higher?

I lean towards a moderate bump for diff.renameLimit, and preferably
more than just a moderate bump for merge.renameLimit.  I have
calculations for what "moderate" translates to, based on a number of
assumptions.  But there's several reasons to break with past
guideposts for how these limits were picked.  See below for various
arguments in each of the directions.

So...thoughts?

Thanks,
Elijah


==> Arguments for bumping MUCH higher:

* Linus said the real reason for the renameLimit was excessive memory
  usage (not perf)[1].  But Junio dropped the memory requirements to
  linear in commit 6d24ad971c81 (Optimize rename detection for a huge
  diff, 2008-01-29)

* Linus oft recommends setting diff.renameLimit=0 [2,3,4,5,6,7,8,9,10,11]
  (which maps to 32767 [12]).

* My colleagues happily raised merge.renameLimit beyond 32767 when the
  artificial cap was removed.  10 minute waits were annoying, but much
  less so than having to manually cherry-pick commits (especially given
  the risk of getting it wrong).[13]


==> Arguments for bumping MODERATELY higher:

* We have bumped the limits twice before (in 2008 and 2011), both times
  stating performance as the limiting factor.  Processors are faster
  today than then.[14,15]

* Peff's computations for performance in the last two bumps used "the
  average size of a file in the linux-2.6 repository"[16], for which I
  assume average==mean, but the file selected was actually ~2x larger
  than the mean file size according to my calculations[17].

* I think the median file size is a better predictor of rename
  performance than mean file size, and median file size is ~2.5x smaller
  than the mean[18].


==> Arguments for not bumping either limit:

* The feedback about the limit is better today than when we last changed
  the limits, and folks can configure a higher limit relatively easily.
  Many already have.

* This issue won't come up nearly as much any more once we switch the
  default merge backend to ort, due to my performance work[19] (many
  renames can be outright skipped without affecting merge quality, and
  many others can be detected in linear time -- the cherry-picks that
  used to require merge.renameLimit=48941 and took 10 minutes can now
  complete in less than a second with the default merge.renameLimit of
  1000.)

* It'd take too long to read all the footnotes in this email, so screw
  it.  :-)


==> Footnotes:

[1] https://lore.kernel.org/git/AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com/

[2] https://lore.kernel.org/git/alpine.LFD.0.999.0710161030430.6887@woody.linux-foundation.org/
 2007-10-16
[3] https://lore.kernel.org/git/alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org/
 2008-11-03
[4] https://lore.kernel.org/git/AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com/
 2011-02-18
[5] https://lore.kernel.org/lkml/alpine.LFD.0.999.0710111944120.6887@woody.linux-foundation.org/
 2007-10-11
[6] https://lore.kernel.org/lkml/alpine.LFD.1.10.0808052157400.15995@nehalem.linux-foundation.org/
 2008-08-05
[7] https://lore.kernel.org/lkml/alpine.LFD.2.01.0909160813400.4950@localhost.localdomain/
  2009-09-16
[8] https://lore.kernel.org/lkml/CA+55aFw1GVvszqoC_f0RAvG5t1xj0CSYLhLU=y0gQ+_54Gsomw@mail.gmail.com/
 2011-10-25
[9] https://lore.kernel.org/lkml/CA+55aFyWefZ1jJLMJKXhy0Qif-iBmjG6n-evcbvkbWS5mDrs0g@mail.gmail.com/
 2015-02-16
[10] https://lore.kernel.org/lkml/CA+55aFxODGv7-AvnqFmxrXBcS2w0XzHuZ7UuRi3EMQz4-oeLJA@mail.gmail.com/
 2018-04-11
[11] https://lore.kernel.org/lkml/CAHk-=wg=CTtNrxPeFzkDw053dY3urchiyxevHnUXHhTGbK=9OQ@mail.gmail.com/
 2020-06-03

[12] 89973554b52c (diffcore-rename: make diff-tree -l0 mean -l<large>,
     2017-11-29)

[13] https://lore.kernel.org/git/20171110173956.25105-3-newren@gmail.com/

[14] 50705915eae8 (bump rename limit defaults, 2008-04-30)
[15] 92c57e5c1d29 (bump rename limit defaults (again), 2011-02-19)

[16] https://lore.kernel.org/git/20080211113516.GB6344@coredump.intra.peff.net/

[17] Calculated and compared as follows (num files, mean size, size Peff used):
  $ git ls-tree -rl v2.6.25 | wc -l
  23810
  $ git ls-tree -rl v2.6.25 | awk '{sum += $4} END{print sum/23810}'
  11150.3
  $ git show v2.6.25:arch/m68k/Kconfig | wc -c
  20977

[18] Calculated as 4198 as follows (note: 11905 = 23810/2):
  $ git ls-tree -rl v2.6.25 | sort -n -k 4 | head -n 11905 | tail -n 1
  100644 blob 29510dc515109ad5dd8a16b5936f1f6086ae417c    4198
Documentation/lguest/lguest.txt

[19] See "Overall Results" from https://github.com/gitgitgadget/git/pull/990
