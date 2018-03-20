Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58BF81F404
	for <e@80x24.org>; Tue, 20 Mar 2018 20:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeCTUpP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 16:45:15 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39725 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeCTUpO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 16:45:14 -0400
Received: by mail-pl0-f66.google.com with SMTP id k22-v6so1744040pls.6
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=069xlFKfXbZckeAJ9EDYEFuyTtQtG+sT7DaU7rdMvE8=;
        b=R1OA3dpGPcb2vDQD0g1ybOp3K+YM3aWMRL+a9nU55sSXwUAbTtkRi+pQpdUCtMwxYB
         +a3IvObln8EfjZsrjqfT8GhKxqOvZV18AW0p13Wns/xeXyzzABODxMRg9FE6hBLuUthg
         ULFRf+kgeix+Q1oBfE6DELS5URrqah87gsVhq3VCPeLmV4yNyjoBpNMcCj4nzmk27D5w
         jabjErcZ9EX/yQY6Q5/I0QXLaeyd3etX8ezsmh9PGWS6XspRWXzQAoU2OPBx/0m9CWy4
         coycVb7l84+y131CQp0HQl7XceMej8PhEc+L33z0UMTMDDQttHANnnhiobIvaPlksjR5
         q40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=069xlFKfXbZckeAJ9EDYEFuyTtQtG+sT7DaU7rdMvE8=;
        b=JmJd+SzFuJib6vqYsfmNPe5TMNvLoW85W6Ehkjw4b2LtDrnAoFqLogleWqD+NIbWPv
         1gAysvmGAfrYFh8RX1JBWT5DTBJ2gJ0dClB5IQ5HMUlov5+n6ziFHS3AzWmya2+/7PtH
         gIitiuRYGe+Dx1qT0x/ezp5DigJCGQv+zJ3AN7CDoJjQ9ktfobpmmp3heQZVuTXustlN
         DX+YLKo+lDoGPsVERffJg0t3Oy5MaXJ/Wqv0fNDFid8Lu/9GMlSc6M/9nZLdswWcEaJ1
         mC5Y7+eCSdkmXQeQDCYyRsfGpmoGtsR4YoHroJANiffmkHM0M5PFB1zTogpQVXbzX7KP
         KLzA==
X-Gm-Message-State: AElRT7G07AJwZhuvWNdmY7TVZuIJVRK8FaDA3xA0PQEE3qE3PHxwzUEH
        NIg3Pf7B3CMrm6YlU5Kf61i8zXUeV7Q=
X-Google-Smtp-Source: AG47ELvbSVr5gWWNgiiVKJw6RxXPDWhmC8/n8Vo1f6Btd8YBWU0yjJ88/nhxhxpXp1WCD4UUVlWN5Q==
X-Received: by 2002:a17:902:322:: with SMTP id 31-v6mr18067404pld.122.1521578712983;
        Tue, 20 Mar 2018 13:45:12 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id m18sm4180259pgu.51.2018.03.20.13.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Mar 2018 13:45:11 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Wink Saville <wink@saville.com>
Subject: [RFC PATCH 0/3] rebase-interactive
Date:   Tue, 20 Mar 2018 13:45:04 -0700
Message-Id: <20180320204507.12623-1-wink@saville.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've not worked on the git sources before and while looking into
fixing test_expect_failure 'exchange two commits with -p' in
t3404-rebase-interactive.sh, I found it difficult to understand
the git testing infracture and git-rebase--interactive.sh.

So as part of learning my way around I thought I'd refactor
git-rebase--interactive to make it easier for me to understand.
At this point I do have some understanding and will be working
on fixing the bug. In the mean time I'm requesting comments on
this refactoring patch sequence.

Patch 0001 creates a library of functions which can be
used by git-rebase--interactive and
git-rebase--interactive--preserve-merges. The functions are
those that exist in git-rebase--interactive.sh plus new
functions created from the body of git_rebase_interactive
that will be used git_rebase_interactive in the third patch
and git_rebase_interactive_preserve_merges in the second
patch. None of the functions are invoked so there is no
logic changes and the system builds and passes all tests
on travis-ci.org.

Patch 0002 creates git-rebase--interactive--preserve-merges.sh
with the function git_rebase_interactive_preserve_merges. The contents
of the function are refactored from git_rebase_interactive and
uses existing and new functions in the library. A small modification
of git-rebase is also done to invoke the new function when the -p
switch is used with git-rebase. When this is applied on top of
0001 the system builds and passes all tests on travis-ci.org.

The final patch, 0003, removes all unused code from
git_rebase_interactive and uses the functions from the library
where appropriate. And, of course, when applied on top of 0002
the system builds and passes all tests on travis-ci.org.

Wink Saville (3):
  rebase-interactive: create git-rebase--interactive--lib.sh
  rebase-interactive: create git-rebase--interactive--preserve-merges
  rebase-interactive: refactor git-rebase--interactive to use library

 .gitignore                                  |    2 +
 Makefile                                    |    2 +
 git-rebase--interactive--lib.sh             |  944 +++++++++++++++++++++++++
 git-rebase--interactive--preserve-merges.sh |  134 ++++
 git-rebase--interactive.sh                  | 1019 +--------------------------
 git-rebase.sh                               |    7 +-
 6 files changed, 1107 insertions(+), 1001 deletions(-)
 create mode 100644 git-rebase--interactive--lib.sh
 create mode 100644 git-rebase--interactive--preserve-merges.sh

-- 
2.16.2

