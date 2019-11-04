Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D6A1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 13:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfKDNJE (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 08:09:04 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:50545 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfKDNJE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 08:09:04 -0500
Received: from localhost.localdomain (unknown [1.186.12.17])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0A473240006;
        Mon,  4 Nov 2019 13:09:00 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] git-shortlog.txt: include commit limiting options
Date:   Mon,  4 Nov 2019 18:38:58 +0530
Message-Id: <20191104130858.23673-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191030203603.27497-1-me@yadavpratyush.com>
References: <20191030203603.27497-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-shortlog, like git-log, supports options to filter what commits are
used to generate the log. These options come from git-rev-list, and are
documented in Documentation/rev-list-options.txt. Include those options
in shortlog's documentation.

But since rev-list-options.txt contains some other options that don't
really apply in the context of shortlog (like diff formatting, commit
ordering, etc), add a switch in rev-list-options.txt that excludes those
sections from the shortlog documentation. To be more specific, include
only the "Commit Limiting" section.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
That ifdef covers almost the entire document. Is there a better way in
Asciidoc to do something like this?

 Documentation/git-shortlog.txt     | 3 +++
 Documentation/rev-list-options.txt | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index bc80905a8a..a72ea7f7ba 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -76,6 +76,9 @@ them.
 Paths may need to be prefixed with `--` to separate them from
 options or the revision range, when confusion arises.

+:git-shortlog: 1
+include::rev-list-options.txt[]
+
 MAPPING AUTHORS
 ---------------

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 90ff9e2bea..f4b67a917d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -314,6 +314,7 @@ ifdef::git-rev-list[]
 	`<header>` text will be printed with each progress update.
 endif::git-rev-list[]

+ifndef::git-shortlog[]
 History Simplification
 ~~~~~~~~~~~~~~~~~~~~~~

@@ -1016,3 +1017,4 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 -t::
 	Show the tree objects in the diff output. This implies `-r`.
 endif::git-rev-list[]
+endif::git-shortlog[]
--
2.21.0

