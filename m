Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE03AC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 04:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7940A2063A
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 04:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uycfl/1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgDCEfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:35:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42448 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgDCEfY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 00:35:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so6881971wrx.9
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 21:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=a5XESkfm8TOJIT8kj+gPOrqNfaI0ND5MjW2eJKQf/Ag=;
        b=uycfl/1ewhTdUVlgT2jd794T4mVN5V16LnQSAJzve5W/1ENrek16PDDZe1KWE8vuy4
         M9sGEduoYIQMTD6N8KU3cyz8QFj73v7cBU0rMfBBoOy1pcKyKEnGfkJ/RW7X21IhL02N
         oqGfqokKixgiwU6OoDpmfKCKCZzvyWLiwY9cDCXtq805rCFFukVM392t+I+QpssPf0Fu
         KWa1PN9p0gnNiHF9xQHy5PRzdz8bynwkKwyrCHLeCDdyEqhBvTQYIu54ujbYd2EqRDjX
         qtgLFPMB/zFdmu/7XPlWaTEnT7vDmXZVh9SnEy41GL1iDgHxasSxjc6LADEQF9B41HHc
         SU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a5XESkfm8TOJIT8kj+gPOrqNfaI0ND5MjW2eJKQf/Ag=;
        b=HUHOL1yN+YZlaNWGjJLEWxPja5tL+1vBebTA4Cj2fIjwr1n17vhkxzArz+tXXx2ZU6
         EIXqWBm3A4FCfQr2DSn0t7BpYH20UDwXyBA1mlAX8GxyNtCIQ47MhRBICfF7Ub6xAaR9
         hkSx4BqVxoH7sFsbyiPf4++Ax1MHAspThovecRhDvmZY10gbPRLuRT9+V0WTKeKol/vN
         59tGI8eooeXckUdhrRYChQfA0ThhSwCjSpqddvFJziXg0NrG3BPe/T/XTKylYm56AgLE
         A/8ILEu/GZkBPnO8tP+urXcIQ4ZWfWeIrB/o7aKd3NbttJ2vC29NSo3L/pfBIZB5XXYY
         za6A==
X-Gm-Message-State: AGi0PuZzOcmx9pvB3rUWbCfMMRRPtWBtsipfQoUWIqsebg+oYqZBPHjD
        Ck2DDg6pNrrWu3raiKM2wCn6FQRx
X-Google-Smtp-Source: APiQypKJA4lxkP7KhYq81a6ZeIXfrkwRdapPI0sKsYkftHwyMuuydMDSzVi1IGiwK+hbyxQXan+5SA==
X-Received: by 2002:adf:8164:: with SMTP id 91mr6630311wrm.422.1585888522249;
        Thu, 02 Apr 2020 21:35:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm10493891wru.68.2020.04.02.21.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 21:35:21 -0700 (PDT)
Message-Id: <pull.749.git.git.1585888520572.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 04:35:20 +0000
Subject: [PATCH] git-rebase.txt: add another hook to the hooks section, and
 explain more
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, emilyshaffer@google.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

For more discussion about these hooks, their history relative to rebase,
and logical consistency between different types of operations, see
  https://lore.kernel.org/git/CABPp-BG0bFKUage5cN_2yr2DkmS04W2Z9Pg5WcROqHznV3XBdw@mail.gmail.com/
and the links to some threads referenced therein.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    git-rebase.txt: add another hook to the hooks section, and explain more
    
    I'm particularly interested in opinions on the last sentence added to
    the manpage, which is based on the thread mentioned in the commit
    message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-749%2Fnewren%2Frebase-and-hooks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-749/newren/rebase-and-hooks-v1
Pull-Request: https://github.com/git/git/pull/749

 Documentation/git-rebase.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607f..5c518ca0ccf 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -684,9 +684,15 @@ Hooks
 ~~~~~
 
 The apply backend has not traditionally called the post-commit hook,
-while the merge backend has.  However, this was by accident of
-implementation rather than by design.  Both backends should have the
-same behavior, though it is not clear which one is correct.
+while the merge backend has.  In contrast, the apply backend has
+traditionally called the post-checkout hook while the merge backend
+has not.  However, the calling of these hooks in both cases was by
+accident of implementation rather than by design (both backends were
+originally implemented as shell scripts and happened to invoke other
+commands like 'git checkout' or 'git commit' that would call the
+hooks).  Both backends should have the same behavior, though it is not
+entirely clear which, if any, is correct.  We will likely remove both
+of these hooks in the future.
 
 Interruptability
 ~~~~~~~~~~~~~~~~

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
