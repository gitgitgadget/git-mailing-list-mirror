Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5D41F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 22:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbdFIWEh (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 18:04:37 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35518 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbdFIWEg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 18:04:36 -0400
Received: by mail-qt0-f195.google.com with SMTP id x58so17989393qtc.2
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wH6Dtg9Vn5WMkSzoJqCIZqKiCZg3kZmb52yauFbHL2g=;
        b=rOiGNweT+niMDJdNSh+2d6EaWq08eJSvgOoqYTa/BdaaAwbeYcRAyyHy5XkX9qQleU
         +t0vbMZiRENXH7BCLs7Fur+ariWXwQ6I7U+1WxQsnluBdtLrW4M/kphcevvkTx0jIqHe
         bBUOnLptjdg2kZXcZGqCQJbtIzbYt9gAOWAwNvImYXMqj6lsZPN01bEHouLKRl20Ho5H
         B24pSvkdfAPSFKkPIEEYxNCtNrs7l+m+VNA2gv+6uNhrtamMHL4vZHH0r3RSQiuiDI+w
         aVj4u1zYbOChr+fOh8MyrXQxFUHNqwuEfVRdCqq9gx/3JrZKU8HrTp0HqROA+zKRCVsP
         uPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wH6Dtg9Vn5WMkSzoJqCIZqKiCZg3kZmb52yauFbHL2g=;
        b=Jx0tkJbjsJQY+pevpc56QDoSM9fiVJ4MtB/brzQtFeVr8KhwTa0VzF4feqbuLLxkE0
         LYlaJzke+uTsEcZ+C7ho9QsCk/HAJhdAGZ+zHChBjFAXuOlI2p6dIK3ALbfQSHfY/LLl
         GxZ9CtCByfwmNruHyzi3Dh55YrpDQDzRjGdVlhJ+xDU90IK5vDXMIqxi6oLF/1hcATWF
         L2tbgOlLtludRzfLHhQRnwCf6HBQtCzNZw6s3L4V2mKFbB0MaVP+zmZG9wTeF1cQv1LR
         NNcPugBuaupcXXmF9Xk/TeQLeKOjZ7pqIWXX7IIKweIv6uZXVz4PdguM+QVjRKPIMceL
         L5vQ==
X-Gm-Message-State: AKS2vOxX1rngIS32/9qOUAFzJ2i5LloQ35+geV/e6y+xuMx+PahqQ4V2
        psxD6IPQBY9ejYD7bN0=
X-Received: by 10.55.73.67 with SMTP id w64mr14204867qka.207.1497045875168;
        Fri, 09 Jun 2017 15:04:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j65sm1523444qkf.38.2017.06.09.15.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 15:04:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] Add a FREEZ() wrapper macro
Date:   Fri,  9 Jun 2017 22:04:18 +0000
Message-Id: <20170609220420.4910-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170609085346.19974-1-avarab@gmail.com>
References: <20170609085346.19974-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See <20170609085346.19974-1-avarab@gmail.com>
(https://public-inbox.org/git/20170609085346.19974-1-avarab@gmail.com/)
for v1.

Changes:

 * Now called FREEZ() instead of freez().
 * Documented the caveat of giving it ptr++ both in the commit message
   and in a comment.
 * Moved the definition to be with other similar macros.
 * Just unconditionally call free(ptr), even if ptr is NULL, as we do
   everywhere else.

Ævar Arnfjörð Bjarmason (2):
  git-compat-util: add a FREEZ() wrapper around free(ptr); ptr = NULL
  *.[ch] refactoring: make use of the FREEZ() macro

 alias.c                  |  6 ++----
 apply.c                  |  3 +--
 attr.c                   |  6 ++----
 blame.c                  |  3 +--
 branch.c                 |  3 +--
 builtin/am.c             | 18 +++++-------------
 builtin/clean.c          |  6 ++----
 builtin/config.c         |  6 ++----
 builtin/index-pack.c     |  6 ++----
 builtin/pack-objects.c   | 12 ++++--------
 builtin/unpack-objects.c |  3 +--
 builtin/worktree.c       |  6 ++----
 commit-slab.h            |  3 +--
 commit.c                 |  3 +--
 config.c                 |  3 +--
 credential.c             |  9 +++------
 diff-lib.c               |  3 +--
 diff.c                   |  6 ++----
 diffcore-rename.c        |  6 ++----
 dir.c                    |  9 +++------
 fast-import.c            |  6 ++----
 git-compat-util.h        |  6 ++++++
 gpg-interface.c          | 15 +++++----------
 grep.c                   | 12 ++++--------
 help.c                   |  3 +--
 http-push.c              | 24 ++++++++----------------
 http.c                   | 15 +++++----------
 imap-send.c              |  3 +--
 line-log.c               |  6 ++----
 ll-merge.c               |  3 +--
 mailinfo.c               |  3 +--
 object.c                 |  3 +--
 pathspec.c               |  3 +--
 prio-queue.c             |  3 +--
 read-cache.c             |  6 ++----
 ref-filter.c             |  3 +--
 refs/files-backend.c     |  3 +--
 refs/ref-cache.c         |  3 +--
 remote-testsvn.c         |  3 +--
 rerere.c                 |  3 +--
 sequencer.c              |  3 +--
 sha1-array.c             |  3 +--
 sha1_file.c              |  3 +--
 split-index.c            |  3 +--
 transport-helper.c       | 27 +++++++++------------------
 transport.c              |  3 +--
 tree-diff.c              |  6 ++----
 tree-walk.c              |  3 +--
 tree.c                   |  3 +--
 49 files changed, 103 insertions(+), 197 deletions(-)

-- 
2.13.1.508.gb3defc5cc

