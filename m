Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF6CC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 01:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1283820661
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 01:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HktNrTsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgBFBdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 20:33:08 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36015 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbgBFBdI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 20:33:08 -0500
Received: by mail-ot1-f48.google.com with SMTP id j20so3994746otq.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 17:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUcQc2lc+zJAvq1g3yGr2CW813ZY/WznYqFhcdpM/Zk=;
        b=HktNrTsDduZ5m05Bn+OQeRgTVSx7tjj5rwAlW754Mz+uFSNG2xRAWaj5o91pWw24pg
         5psoKbLZqNC8NqAJQscz/SNHYCnfzigVZQsAR1bHu8OyhvTuldNf5eQ2brDNWdpvFmYy
         n4dh7MTYmhumo7APNE/slo58KMpOt1YOYZ91DVLfHOlAzjC1/4TdEwKJ/MD4shU61V4i
         GoHejt1Ydf/zxg+PA16yGfYEWQiCRGzStkkP4iOxu0cLZIxn3gPdYOG4ZWpsKxWq731d
         9PfLLF26pHPZU0Cr8rruf45P18bAqsYrrE7yLQbBjF7EZwtUX8GBJyP16a73UL2fzlyf
         ofrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUcQc2lc+zJAvq1g3yGr2CW813ZY/WznYqFhcdpM/Zk=;
        b=p7IjdzdAMKgHtx986XXf74TU5q2vTw6OzdFUME9MNwJazmWSGkr1pQ23ydLIU6SdfY
         2C6a9ef1wMRDEt7GeB96RELCHOt6Mmqx4pA3ATy0djZspJQwu4rfhNF49SUFYiMhO6M4
         7UWa06Jw3uEbzUCHkNt/Xv9aotzQn8zw5yUKCaiKfNkXR6MfBiFfVzgvfsGTOP1rWubi
         MleXfb1W+sISmkImTOZuSvVGUkQmhrPyJQ4ARuGHE2Mn5swK+NSZWB91RP212Kius5ze
         HMadhdHoF8Rc8JZ5Y5qBfw39hAITYnJnztWn5RX7hMJoxO1L++SuGSv5GjiDML0ix1MC
         X5Jw==
X-Gm-Message-State: APjAAAV8c1lRisTKNwaockKihaPx1gunJBGh+zX69OPfJCeLH7f+VcDu
        axE5XqRey26CFv9YvtiCByG5ELEjbHzpxGr3UA/Rtg==
X-Google-Smtp-Source: APXvYqzFo+WhJkMPC4/8e/kWHwEyTKeO57FfjG4IDZ8+/9q8WDBfKdz1qWkrelwIl62OACZCUROs4ll6pKqcYyfrDNw=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr27589800otq.112.1580952787896;
 Wed, 05 Feb 2020 17:33:07 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Feb 2020 17:32:56 -0800
Message-ID: <CABPp-BF0SO92wxY-dM14Vxv6BGA5=T=CicdwbiaZ7c9w6-j2jQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 5, 2020 at 3:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> * en/fill-directory-exponential (2020-01-31) 6 commits
>  - t7063: blindly accept diffs
>  - dir: replace exponential algorithm with a linear one
>  - dir: refactor treat_directory to clarify control flow
>  - dir: fix confusion based on variable tense
>  - dir: fix broken comment
>  - dir: consolidate treat_path() and treat_one_path()
>  (this branch uses en/fill-directory-fixes-more.)
>
>  The directory traversal code had redundant recursive calls which
>  made its performance characteristics exponential wrt the depth of
>  the tree, which was corrected.
>
>  Still RFC?
>  cf. <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>

Yes, definitely.  (At least) Two things before it's ready to advance:
  1) Either the last commit needs to be squashed down, or if it's
wrong, the code modified to handle the untracked-cache bits correctly.
I'm hoping someone who's familiar with the untracked-cache (or even
the index format) can sanity check this piece or even just provide a
pointer or two about its purpose, design, etc.
  2) This is a somewhat significant change to how fill_directory()
works, and it's very hard to be confident that nothing is broken by
it.  See the commit message of the second to last commit.  I would
really appreciate another pair of eyes.

If no one responds within a week or so with pointers on the
untracked-cache, then I'll dig back in and try to figure out what I
can.  I'm not sure if anyone will review the general fill_directory()
stuff; we may just have to bite the bullet at some point by merging it
and then watch out for problems.  I'll at least look over it all once
again when I look at the untracked-cache stuff before submitting the
next re-roll.


> * en/rebase-backend (2020-01-17) 19 commits
>  - rebase: change the default backend from "am" to "merge"
>  - rebase: make the backend configurable via config setting
>  - rebase tests: repeat some tests using the merge backend instead of am
>  - rebase tests: mark tests specific to the am-backend with --am
>  - rebase: drop '-i' from the reflog for interactive-based rebases
>  - git-prompt: change the prompt for interactive-based rebases
>  - rebase: add an --am option
>  - rebase: move incompatibility checks between backend options a bit earlier
>  - git-rebase.txt: add more details about behavioral differences of backends
>  - rebase: allow more types of rebases to fast-forward
>  - t3432: make these tests work with either am or merge backends
>  - rebase: fix handling of restrict_revision
>  - rebase: make sure to pass along the quiet flag to the sequencer
>  - rebase, sequencer: remove the broken GIT_QUIET handling
>  - t3406: simplify an already simple test
>  - rebase (interactive-backend): fix handling of commits that become empty
>  - rebase (interactive-backend): make --keep-empty the default
>  - t3404: directly test the behavior of interest
>  - git-rebase.txt: update description of --allow-empty-message
>
>  "git rebase" has learned to use the sequencer backend by default,
>  while allowing "--am" option to go back to the traditional "am"
>  backend.
>
>  Waiting for reviews and/or Acks.
>  cf. <CABPp-BHONuRyt8VJqRuoCF2rGYZ5EhH9KJXQZ3NO69rYwA5J3g@mail.gmail.com>

I would like to give Phillip a bit more time for a final review since
he said he'd try to review v4, but it's also been a few weeks and I
don't want to delay indefinitely.  So if he hasn't responded by your
next "What's cooking", I'll probably ask that we just merge it down to
next at that time.
