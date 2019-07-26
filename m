Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A471F462
	for <e@80x24.org>; Fri, 26 Jul 2019 22:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfGZWJf (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 18:09:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34911 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfGZWJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 18:09:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so19075548pgr.2
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ayhV7FnrKtxuz0wIX5ZohbXxl+NZVXkgHoJRmEUiHog=;
        b=GiQY9FXGNQxaeg/LzEvzB92XdfLlCEgpCkBO5fhGZTvRpdVTONcZ8Q0A317oGr7Z0L
         6f/cI4RtbWA+BvVF1HELd3C4DTbjHegfA6OKcZHbKOvDna8VE7/Wwr2bgM3ddif65+7T
         xkZ5mk002UBOmDu4ESVZ8sxprG/5P8i0Octnb004h4+9h4pP1s34Vn7tiq1f1cls9KLx
         LDLN9qMNLAj0m00lLlvdbVJjYDRQjV3+cKHuqsuE2wEpd3xvfbZVoKjUfrFh0SRccPrB
         2/53vIhmPZZmZVsOFVibAlIvVnzjtKCNinvQckJ9TVp5M/KYy2oy3EEkExdHfDHwc3j4
         bxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ayhV7FnrKtxuz0wIX5ZohbXxl+NZVXkgHoJRmEUiHog=;
        b=Ie7UU6/urRNAJjpJFgzS5T0pSbQLY7p5Oylu/4mRuc+XY2hD7uqrEPcFi2eFIyI04w
         /omsOopncLjbgLYnftts82MVU7fW0Aw1CHrH9OlPTVLqPEjge0lf15sypb8sgtDYqTof
         sRelJFLi9zUmvFEtw39efmTTR9rmfZGYfHBheFHy5y0NIguSvbUJSdVHOxez0a3DymKc
         c9tTxFoTlNczXkqxjMt08wKglbqH1rY4LFiVMJBTpxmHXpCf7cqGzGT3OvWlZ2Hdnhgs
         JQTPGciVJa2lITs9CTgnThApUhPaGsQC28KS8TnW9UbNaUHUJEF2ZzeYvLHxnH1s9Nd+
         2kSA==
X-Gm-Message-State: APjAAAWvn8/gfm4OFJ3t1vFEj2kE+W56Gty2DJ7hIH8LA8YjzLuZSuzP
        nMEPdygNFo5ACgKmtanniU0Z+A==
X-Google-Smtp-Source: APXvYqy6JhlKjPYKTUzFTmA4qnyKa0RqLM9W3C31hSsGlax5iGp8u0Vjm+pDwlewJD3MHMWlltF3BQ==
X-Received: by 2002:a62:1ac8:: with SMTP id a191mr24514117pfa.164.1564178973805;
        Fri, 26 Jul 2019 15:09:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id f27sm37181947pgm.60.2019.07.26.15.09.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 15:09:33 -0700 (PDT)
Date:   Fri, 26 Jul 2019 15:09:28 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, jrn@google.com
Subject: BUG() during criss-cross merge with directory rename and deleted file
Message-ID: <20190726220928.GG113966@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

As mentioned during the standup in #git-devel today, we encountered a
BUG() during certain circumstances of a criss-cross merge. Timing has
prevented me from getting the repro case together to send just yet, but
it appears that the issue is as follows:

 - During a merge in a repo with fairly complicated, merge-y history,
   the following BUG() is seen:
   "BUG: There are unmerged index entries:
    BUG: 2 baz/bar.txt
    BUG: merge-recursive.c:429: unmerged index entries in
    merge-recursive.c
    Aborted"
 - But when the user then runs `git status` (after clearing
   .git/index.lock) the directory is clean.
 - The repo does not contain a 'baz/bar.txt' (although 'baz/' exists).
 - In the repo's history a 'foo/bar.txt' can be found (that is the only
   'bar.txt' to ever exist in the project).

Digging further shows:

 - The merge had  multiple closest shared ancestors (criss-cross
   merge)
 - Directory 'foo/' was renamed on one side to 'baz/'...
 - ...and 'foo/bar.txt' was deleted on the other side.
 - When the virtual ancestor is generated, the directory rename can't be
   resolved and leaves a conflict.
 - The virtual ancestor being written to disk is in a conflicted state.
 - This causes the top-level merge to fail, printing the BUG() above
   which references a 'baz/bar.txt' that never really lived there.

Furthermore...

 - If merge.directoryrenames is set to any value besides "conflict", the
   merge succeeds (no BUG() generated).

This seems to have been introduced in 8c8e5bd6eb331d055aa7fa6345f6dcdadd658979
although I haven't bisected it yet.

It seems like the solution is to watch for whether we're making a
virtual ancestor during a recursive merge, and if so, to treat
merge.directoryrenames = "conflict" as "true" or "false" instead.

I plan to modify the tests added in 8c8e5bd6 to highlight this issue
(just haven't had time, and probably won't til next week), and send a
patch doing the special treatment on merge.directoryrenames.

Happy to hear other ideas folks have.

 - Emily
