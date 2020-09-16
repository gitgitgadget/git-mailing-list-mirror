Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5D1C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD742087D
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go4KxI9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIPCJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgIPCJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 22:09:15 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40345C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:09:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w16so6614927qkj.7
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LGc3l1cEvh2LPKc/Piy35x7V0rg0vXhM+E+F+cXOAo=;
        b=Go4KxI9CvlyFbwRBxIJthWzOfGHNKo/u9Zia2fl8N+OVozr4eUPe80h9bwNKnHVhZJ
         H6udYbjdJGSIrf4L2FpfWBaerrwABoLz3p3bEzkIFJs9XrsGTdDRY5/aEAnEzPnqr738
         Y4n0bfl1fnfhXOOoKpbTNfF2pRRpXOm7dhtt5c7tCvhRUtUuM8z7aSSjNT/FpFQWrpdT
         pTIZbpE/XjlPhRZvKiYr9tAT7DXdPKhXTWSmuxfkaXQ7B2fi2NW/TUA1m2SNuml4MpUn
         chV4/Q28+/HZ/iZT3XNxt3hl1VPVNZKE9hqaDgKj2PBvlZ1Rn4r9uP+UkUW716f1qS/a
         nazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LGc3l1cEvh2LPKc/Piy35x7V0rg0vXhM+E+F+cXOAo=;
        b=q7ojnuoq7ndTiaLP/fOot9mZJnGgkC05A1v9riuui4rzsmeN0n1UmRqpFh/K1213DX
         KUhqo1EIXNhPdlAZdH5PDh0JtUGXh/aNyWM6eWcM5J9M33K4ybBK/6suMB+YTv8K+pw3
         xMtMzE9C+26WLMSJHk41W4R3YzbHUpRIIFYO1MU4BW0hCtT8IiRXyxcLtB9twFvM2Gd+
         WOAU37w2gmy7PsB808S5ofNcp6sJoxHKSaVE/JW8gmKSDNllwUUrarmEde+ne8rMb6kM
         Ii+boXmPkVpgrgX0J5KnzHc4rAHUNg2EdMigS8o2L+IFchj9XlGzs9A7u7fs8EmoX2Yz
         GMmw==
X-Gm-Message-State: AOAM530eEDZi4J7INhK2S9+I4hGSCopqFtgqap2UjGdZEnqZacZO5/9S
        /XPWCbJ1FVG30Mg7NIdYiCX9D/1gfmJbLvTv
X-Google-Smtp-Source: ABdhPJxd19qoGSeVlIhkksGRatTsxUZ+aPBxDv5dWXxC/TRomadQUAb+xppXWgN/KJ1BHgzZo+XUYw==
X-Received: by 2002:ae9:eb57:: with SMTP id b84mr21128529qkg.450.1600222153074;
        Tue, 15 Sep 2020 19:09:13 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id k52sm19380373qtc.56.2020.09.15.19.09.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 19:09:12 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/3] git branch: allow combining merged and no-merged filters
Date:   Tue, 15 Sep 2020 22:08:37 -0400
Message-Id: <20200916020840.84892-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200913193140.66906-1-alipman88@gmail.com>
References: <20200913193140.66906-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, Eric & Junio.

Eric -

> I didn't examine it too closely, so this may be a silly question, but
> is there a reason to start from scratch (by deleting all the branches)
> rather than simply using or extending the existing branches like the
> other tests do?

I went back and forth on this. There were a couple reasons I leaned
towards starting fresh - I found branch names like feature_a &
feature_b more illustrative, and I didn't want readers to have to
scroll up further to find where branches came from.

But, with the tests re-ordered so "branch --merged with --verbose"
comes last (which adds new branches that might otherwise clutter up
the output of my new tests), I'm happy with using the existing test
setup - rewritten accordingly.

> It's a bit concerning to see output from porcelain git-branch being
> fed to 'grep' and 'xargs'. More typically, you would instead rely upon
> the (stable) output of a plumbing command...

Thanks, useful knowledge for future contributions.

> We normally avoid repeating in the commit message what the patch
> itself already says. The first paragraph alone (without the example
> text) would be plenty sufficient. (Not itself worth a re-roll,
> though.)

Got it, removed.

> Missing sign-off.

Whoops, fixed.

> This is repeated nearly verbatim in the other two documentation pages.
> It makes one wonder if it can be generalized and placed in its own
> file which is included in the other documents via
> `include::contains.txt[]`. Perhaps like this:
> 
>     When combining multiple `--contains` and `--no-contains` filters,
>     `git branch` shows references containing at least one of the named
>     `--contains` commits and none of the named `--no-contains`
>     commits.
> 
> But perhaps that's too generic?

Cool, I hadn't realized we could embed snippets like that. Slightly
generic, but I have no strong opinion either way. Going with the
passive wording provided by Junio.

(Looking at AsciiDoc's documentation, I think we could also set a
:command-name: variable to insert some dynamic content into an
include:: file.)

> This sort of implementation detail is readily discoverable by reading
> the patch itself, and since there is no complexity about it which
> requires extensive explanation, we'd normally leave it out of the
> commit message.

Removed.

> This revised test doesn't seem to have all that much value since this
> combination is checked by new tests added elsewhere by the patch.

Agreed, dropped.

> Would it make sense to also test multiple --merged and multiple
> --no-merged? (Genuine question, not a demand to add more tests.)

I don't see a reason to. The --merged and --no-merged filters are
applied in separate passes, so I feel it's sufficient to test them
independently. (When doing my own QA testing, I did combine multiple
merged & multiple no-merged, multiple contains & multiple no-contains,
merged/no-merged & contains/no-contains, etc.)

On the other hand, extra test cases could help prevent regressions
should someone significantly refactor ref-filter.c. If anyone has a
preference to add more tests, I'm happy to oblige.

> I think you forgot s/incompatible/compatible/ in the test title (which
> you changed in the other cases).

Thanks, fixed.

Junio -

> I do not mind making the 0/1 a symbolic constant between
> do_merge_filter() and filter_refs() for enhanced readability,
> though.

If I understand the convention, the constant names should be prefixed
with DO_MERGE_FILTER. I suggest DO_MERGE_FILTER_REACHABLE and
DO_MERGE_FILTER_UNREACHABLE. Happy to re-roll if others have a
different preference - or feel free to edit.)

Aaron Lipman (3):
  t3201: test multiple branch filter combinations
  Doc: cover multiple contains/no-contains filters
  ref-filter: allow merged and no-merged filters

 Documentation/filters.txt          |  7 +++
 Documentation/git-branch.txt       | 10 ++--
 Documentation/git-for-each-ref.txt | 13 ++++--
 Documentation/git-tag.txt          | 11 +++--
 builtin/branch.c                   |  6 +--
 builtin/for-each-ref.c             |  2 +-
 builtin/tag.c                      |  8 ++--
 ref-filter.c                       | 64 ++++++++++++++------------
 ref-filter.h                       | 12 ++---
 t/t3200-branch.sh                  |  4 --
 t/t3201-branch-contains.sh         | 74 +++++++++++++++++++++++++-----
 t/t6302-for-each-ref-filter.sh     |  4 +-
 t/t7004-tag.sh                     |  4 +-
 13 files changed, 143 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/filters.txt

-- 
2.24.3 (Apple Git-128)

