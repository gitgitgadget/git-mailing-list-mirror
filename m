Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2E81FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 10:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168722AbdDXKmL (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 06:42:11 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37948 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167156AbdDXKmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 06:42:09 -0400
Received: by mail-it0-f48.google.com with SMTP id e132so50700566ite.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vrFg9rt/nd7E41UFkgchreYzWIh/XGM4PXu9gUprgiU=;
        b=bfFBoDYY8nE+CrNsp5c8BUS9H7sPW2D5sQnmnws9ZdRd7v16E4iJkEsExLkpH37qju
         m+pbnB7X7BIywrzO8ox94xtvn7enmXb/CS/pXvGO9JiQ1LZlXiXw5a5VaIr8QbKK5uv/
         9cdRi9zgVePJbIeyVZ7yI3y2rs2B0xNRDEWicgW3NJCMJIxmi8MhTVITlcK+eY9Ai+3d
         Zq9yCudgH8zAURGcxuwE+785K5HoS4pkOq3adeyCWcx6hfAAbbha7fMEzecx3WZyAxjC
         LwR/XU5AbPDTqXNeW8OgGH+Wy6z/wkZCRas4Y+ij8VxH7Y9D7jAp0NNdAn7KM3Vzjg/5
         KNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vrFg9rt/nd7E41UFkgchreYzWIh/XGM4PXu9gUprgiU=;
        b=pKAj6QA35dxpCtuM13LTl2TNbOds+V9Qxvwn2ZVFJ4Jje+yVzYXDERikYeJ/ZroB/B
         U1EC29h4nfS7aT0CWtmh59QVjAk1NYa40gj13B252nhspSMGLoZ0jtnWeu9PVTdRBuZm
         PXjogrSvCk0x/XkrhyVqZViZ/0qETZJ2fNYr3hz1Z+MlE6Z2OzQWz9A/2JYvYnyfP0Yy
         61RyYAkdeFdUdllRQzAu7eIL14p1oPx21mps8zemmUDEZ6f7halE/Cc3HmQsFcmYOdTM
         ncyHuhZf1er0jYG1e89+tZymc46+/5re1PrIFFp4CU/9/rxY508vVvLMk+E46zw9mwIW
         hGlg==
X-Gm-Message-State: AN3rC/5oJ3vTmZ5h+QELLjMCzqZUDl/rsB+tmYLvJDIR53j5ATlpgTDR
        dX2EUYBneU2d2M5Obc15o5UCOJxUIg==
X-Received: by 10.202.86.18 with SMTP id k18mr13047965oib.175.1493030404285;
 Mon, 24 Apr 2017 03:40:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 24 Apr 2017 03:39:33 -0700 (PDT)
In-Reply-To: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
References: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Apr 2017 17:39:33 +0700
Message-ID: <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
Subject: Re: [PATCH] cache-tree: reject entries with null sha1
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2017 at 1:46 AM, Jeff King <peff@peff.net> wrote:
> We generally disallow null sha1s from entering the index,
> due to 4337b5856 (do not write null sha1s to on-disk index,
> 2012-07-28). However, we loosened that in 83bd7437c
> (write_index: optionally allow broken null sha1s,
> 2013-08-27) so that tools like filter-branch could be used
> to repair broken history.

Uh oh.. cache-tree.

> However, we should make sure that these broken entries do
> not get propagated into new trees. For most entries, we'd
> catch them with the missing-object check (since presumably
> the null sha1 does not exist in our object database). But
> gitlink entries do not need reachability, so we may blindly
> copy the entry into a bogus tree.

Phew.. not another bug of mine :D

> When merged to pu, this fixes the existing test breakage in t7009 when
> GIT_TEST_SPLIT_INDEX is used (because the split index didn't rewrite the
> whole index, "git rm --cached" didn't always barf).

Latest 'pu' has your patch, but t7009 still fails on me (with "invalid
object" error), more on this later..

> But I think it's worth doing on its own merits, as demonstrated by the new tests.

Agreed. The patch looks correct.

Just checking, since cache-tree helps speed up many operations,
dropping cache-tree can have some performance implication. But this
must be an error case (null sha1) and we will not run into it often to
worry about unnecessary dropping, correct?

> The one thing I haven't figured out it is why the new test in t7009
> fails with the split-index. And even more curiously, the new tests in
> t1601 _don't_ fail with it, even if I instrument the fake index to have
> more entries (making it more likely to split).

back to t7009 failure. I'll see if I can look more into this this
weekend. If split-index somehow produces these null sha1, then I
probably have a problem.

Thanks for looking at it anyway. One bug down. Thousands to go...

BTW, I ran t7009 with valgrind and it reported this. Is it something
we should be worried about? I vaguely recall you're doing something
with prio-queue...

==4246== Source and destination overlap in memcpy(0x5952990, 0x5952990, 16)
==4246==    at 0x4C2EACD: memcpy@@GLIBC_2.14 (in
/usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==4246==    by 0x545D05: swap (prio-queue.c:15)
==4246==    by 0x545D72: prio_queue_reverse (prio-queue.c:25)
==4246==    by 0x4CBC0C: sort_in_topological_order (commit.c:723)
==4246==    by 0x574C97: prepare_revision_walk (revision.c:2858)
==4246==    by 0x48A2BA: cmd_rev_list (rev-list.c:385)
==4246==    by 0x405A6F: run_builtin (git.c:371)
==4246==    by 0x405CDC: handle_builtin (git.c:572)
==4246==    by 0x405E51: run_argv (git.c:624)
==4246==    by 0x405FF3: cmd_main (git.c:701)
==4246==    by 0x4A48CE: main (common-main.c:43)
-- 
Duy
