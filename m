Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A52C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FC42083B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgG2UMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:12:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:41520 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2UMM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:12:12 -0400
Received: (qmail 8853 invoked by uid 109); 29 Jul 2020 20:12:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 20:12:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7881 invoked by uid 111); 29 Jul 2020 20:12:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 16:12:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 16:12:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 6/7] doc/git-log: move "-t" into diff-options list
Message-ID: <20200729201210.GF2989342@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729201002.GA2989059@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "-t" option is infrequently used; it doesn't deserve a spot near the
top of the options list. Let's push it down into the diff-options
include, near the definition of --raw.

We'll protect it with a git-log ifdef, since it doesn't make any sense
for non-tree diff commands. Note that this means it also shows up in
git-show, but that's a good thing; it applies equally well there.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm open to suggestions of a better spot to put it. The diff options
list is a rather unwieldy mess.

 Documentation/diff-options.txt | 5 +++++
 Documentation/git-log.txt      | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7987d72b02..b7af973d9c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -73,6 +73,11 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
+ifdef::git-log[]
+-t::
+	Show the tree objects in the diff output.
+endif::git-log[]
+
 --indent-heuristic::
 	Enable the heuristic that shifts diff hunk boundaries to make patches
 	easier to read. This is the default.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2cbe636b2b..0a4c99e5f8 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -146,9 +146,6 @@ below can be used to show the changes made by each commit.
 	in that case, the output represents the changes the merge
 	brought _into_ the then-current branch.
 
--t::
-	Show the tree objects in the diff output.
-
 :git-log: 1
 include::diff-options.txt[]
 
-- 
2.28.0.465.gd2839157e3

