Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C751F454
	for <e@80x24.org>; Fri,  8 Nov 2019 19:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfKHT0c (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 14:26:32 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:53235 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHT0c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 14:26:32 -0500
Received: from localhost.localdomain (unknown [1.186.12.17])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3C150240006;
        Fri,  8 Nov 2019 19:26:29 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] git-shortlog.txt: include commit limiting options
Date:   Sat,  9 Nov 2019 00:56:27 +0530
Message-Id: <20191108192627.19408-1-me@yadavpratyush.com>
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
only the "Commit Limiting" and "History Simplification" sections.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
Changes in v3:
- Include the "History Simplification" section too.

- Wrap each section in an ifdef individually to make it easier to move
  them around later.

 Documentation/git-shortlog.txt     |  3 +++
 Documentation/rev-list-options.txt | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

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
index 90ff9e2bea..e37df921b5 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -579,6 +579,7 @@ above) if (1) they are referenced by tags, or (2) they change the
 contents of the paths given on the command line.  All other
 commits are marked as TREESAME (subject to be simplified away).

+ifndef::git-shortlog[]
 ifdef::git-rev-list[]
 Bisection Helpers
 ~~~~~~~~~~~~~~~~~
@@ -634,8 +635,9 @@ This option can be used along with `--bisect-vars`, in this case,
 after all the sorted commit objects, there will be the same text as if
 `--bisect-vars` had been used alone.
 endif::git-rev-list[]
+endif::git-shortlog[]

-
+ifndef::git-shortlog[]
 Commit Ordering
 ~~~~~~~~~~~~~~~

@@ -677,7 +679,9 @@ together.
 	Output the commits chosen to be shown (see Commit Limiting
 	section above) in reverse order. Cannot be combined with
 	`--walk-reflogs`.
+endif::git-shortlog[]

+ifndef::git-shortlog[]
 Object Traversal
 ~~~~~~~~~~~~~~~~

@@ -817,7 +821,9 @@ endif::git-rev-list[]

 --do-walk::
 	Overrides a previous `--no-walk`.
+endif::git-shortlog[]

+ifndef::git-shortlog[]
 Commit Formatting
 ~~~~~~~~~~~~~~~~~

@@ -973,7 +979,9 @@ ifdef::git-rev-list[]
 	counts and print the count for equivalent commits separated
 	by a tab.
 endif::git-rev-list[]
+endif::git-shortlog[]

+ifndef::git-shortlog[]
 ifndef::git-rev-list[]
 Diff Formatting
 ~~~~~~~~~~~~~~~
@@ -1016,3 +1024,4 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 -t::
 	Show the tree objects in the diff output. This implies `-r`.
 endif::git-rev-list[]
+endif::git-shortlog[]
--
2.21.0

