Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B731F404
	for <e@80x24.org>; Mon, 26 Mar 2018 01:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeCZBOd (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 21:14:33 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:44724 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeCZBOc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 21:14:32 -0400
Received: by mail-pl0-f54.google.com with SMTP id 9-v6so10936153ple.11
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 18:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=U+VpYuCZ7ueAvcjpy0BQkNzwifajLIax5DwcaTWHcnE=;
        b=LoS/7roJOQkWIEIr2AGxUGwwTUGOuVQtaEkU9zEu2bdLWwtrAJ47LONXWPBofA74fU
         JKcv5ldBjI3BbQwvOvQX26b42QJ8mjHzTEcLejgdYq6SsiM4gc3YduJxkg5OTCmCh5KU
         nxR2eX0MdY0pSlW0iq8OYL6octR0vdz5/8L1UQldTHjK22XrtyT+RFw0dH+bnQVGp0S9
         jIQIXPN0kzpR+g4VlarSviSxmNExwbODVoJ+4agYPWyfGhvMAlgnEcGMBEWHNBD7ChfK
         /eCIZSHjrokSXFYRhI71DjZxklUiBbtWlKo9+KjxiA55eKXEe4VjcdYafGuoFau9F74t
         Miaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U+VpYuCZ7ueAvcjpy0BQkNzwifajLIax5DwcaTWHcnE=;
        b=unhayiTQZo4DhJUCnR7Er7DOPCdY+vBKkxxtfXIWR6JwPVBC06RbGVH0grNT2t2HSt
         DJ/qFx6cJkeUKi3FWYpmtpsARA1pRpuSlH1zE//jU0sKiU1sWCc0m7Ka2l6TKedOrfjh
         HEiIwcCTXTG6eoTD0+fSDc7JSbeuU8qBrURkgKGdXBCmEzPsk5eD8t8E+wjYNxtmVXcW
         RIkx6IpQbaoVIS2zURHU7Hnr2X6iBexUL4rbqc7xncRDsaG0t5MDHIdqxj+ogmpG69f2
         sP4OBueWyKq4qzltYoEHf1X8x3GOlioyjFf6bYcT6sr3vhnmXRi4P6CuWbPT9SE66bHd
         9N2A==
X-Gm-Message-State: AElRT7G0u87cHGrbUiqXD7ZC/C6xHAKX25sUm+QipwloF8/GZz6Vxo61
        WGzberbF6QC65uYn20LpqA9h7Yw=
X-Google-Smtp-Source: AG47ELtvLpFqBmPRgB2hB4w8NQdwL55bxDAwSI6aOLplvgMU9GjaVL9kBjntJyapqY20U9VgaBmZ5g==
X-Received: by 2002:a17:902:8481:: with SMTP id c1-v6mr27890332plo.304.1522026872094;
        Sun, 25 Mar 2018 18:14:32 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id k70sm18664894pga.72.2018.03.25.18.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 18:14:31 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v2 0/6] Convert some stash functionality to a builtin
Date:   Sun, 25 Mar 2018 18:14:20 -0700
Message-Id: <20180326011426.19159-1-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been working on converting all of git stash to be a
builtin, however it's hard to get it all working at once with
limited time, so I've moved around half of it to a new
stash--helper builtin and called these functions from the shell
script. Once this is stabalized, it should be easier to convert
the rest of the commands one at a time without breaking
anything.

I've sent most of this code before, but that was targetting a
full replacement of stash. The code is overall the same, but
with some code review changes and updates for internal api
changes.

Since there seems to be interest from GSOC students who want to
work on converting builtins, I figured I should finish what I
have that works now so they could build on top of it.

Previous threads:
v1: https://public-inbox.org/git/20180325173916.GE10909@hank/T/

Changes from v1:
 - Fixed memory leaks
 - Fixed formatting
 - Fixed typos
 - Removed old .sh code that has been replaced
 - Fix differences in error messages
 - Added tests to ensure argument handling work when specifiying
   multiple refs, or no arguments for branch
 - Refactored the code a bit
 - Reordered the patches so they compile and test successfully

Joel Teichroeb (6):
  stash: Add tests for passing in too many refs
  stash: Add test for branch with no arguments
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

 .gitignore              |   1 +
 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 620 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 125 +---------
 git.c                   |   1 +
 t/t3903-stash.sh        |  26 ++
 7 files changed, 658 insertions(+), 117 deletions(-)
 create mode 100644 builtin/stash--helper.c

-- 
2.16.2

