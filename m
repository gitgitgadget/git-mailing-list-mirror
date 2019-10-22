Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1471F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 17:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfJVR3B (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 13:29:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40491 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbfJVR3A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 13:29:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so16942775wmj.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YBgtLBoyqoigl5ZE4OqPb5jzlePkZ52zmD69/C9LOWs=;
        b=hh74Yeaaym0E/ROJk5vrEdHCyISOtYiwTCpc9VMHSgZmlMzbSn4vMsRhhhlcq2QWev
         paxbJ/XEE5tQYomANN6FNFk4qSyn1JOS5bvmBAIUta7W7tVL82/kFHabxub60C5ZnTgE
         Zkr/j7O9wrxnt/HGBn2Dp7Pj5o+GtfHsbCEj/GrNvMG5aiCEfdeWrFHmK3FQkmy6VHqb
         Mdwc7pZltv1dH0V/cFr0HuQhG6zFPZjZ1YYRjU2N+y4wsmZPTwl7PCmd5NMoFFutWrz7
         Qnq8yyOhh/iaRxzuTBgISXZ6QZ3aT+zizi+4HB++rQCCWzG/HVMMzLbUIYo4ilT448wg
         aD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YBgtLBoyqoigl5ZE4OqPb5jzlePkZ52zmD69/C9LOWs=;
        b=r8IdgBaNK2IeLN0jVnLfLfdvSvNMme5LsqwH2IGbp/9+iCxMnsu9/yfZt5EwvzvLJg
         HtvfwVqlWCf1LpJv1N8oAOL4SsYL4Y/+33iMQibNeDOMbL8EJdV91R6ltjy8XzRAMPSM
         pTpM6vM4vBLoMPvzHOWdASLo7my9Qi17CwuZyKrXX/aL4bBZ3+wPbd7AlQlRXZyRCx3B
         njXrScb/hl/DrgmlmhiArmEWKWIAmUaPliaNfwr2q948hP0mxbDGqu0M++ZQ2uEzvTYS
         iukSgr25zFNwl1glhrPFFE0p70EMJEHAvFjY2gv5QUucm1lh+rGQGCk+6Qe3exZ/ff+B
         F0FA==
X-Gm-Message-State: APjAAAXypiEVqANXzl2SCrQiI5y4i4X+rn7OSH4FkoF9o1zexEzuKE0y
        LuHxF6jg3j9ElSEMBfMdgPT4edVz
X-Google-Smtp-Source: APXvYqxYyvCrndTYDWDXcrQdP+aWnc4PvOomeXNZXuZzwTederDaZpJgsk3cuGHeaziDYgbd74jdiA==
X-Received: by 2002:a1c:5415:: with SMTP id i21mr234190wmb.120.1571765337021;
        Tue, 22 Oct 2019 10:28:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v128sm3948484wmb.14.2019.10.22.10.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 10:28:56 -0700 (PDT)
Message-Id: <pull.415.git.1571765335.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 17:28:54 +0000
Subject: [PATCH 0/1] [v2.24.0-rc0 BUG] fetch.writeCommitGraph fails on first fetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While dogfooding, Johannes found a bug in the fetch.writeCommitGraph config
behavior. While his example initially happened during a clone with
--recurse-submodules, we found that it is actually a problem with the first
fetch after a new clone and no existing commit-graph file:

$ git clone <url> test
$ cd test
$ git -c fetch.writeCommitGraph=true fetch origin
Computing commit graph generation numbers: 100% (12/12), done.
BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
Aborted (core dumped)

In the repo I had cloned, there were really 60 commits to scan, but only 12
were in the list to write when calling compute_generation_numbers(). A
commit in the list expects to see a parent, but that parent is not in the
list.

The details above are the start of the commit message for [PATCH 1/1]. I
tried to include as much detail as I could for how I investigated the
problem and why I think this is the right solution.

I would like help creating a test that demonstrates this problem. It does
not appear to trigger on the simplest examples. The simple example I used
for my testing was https://github.com/derrickstolee/numbers

Thanks, -Stolee

/cc johannes.schindelin@gmx.de, peff@peff.net

Derrick Stolee (1):
  commit-graph: fix writing first commit-graph during fetch

 commit-graph.c | 11 +++++++----
 commit-reach.c |  1 -
 object.h       |  3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-415%2Fderrickstolee%2Ffetch-first-write-fail-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-415/derrickstolee/fetch-first-write-fail-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/415
-- 
gitgitgadget
