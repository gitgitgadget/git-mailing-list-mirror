Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B6C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E8660238
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhBQXfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:35:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:36764 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232468AbhBQXfF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 18:35:05 -0500
Received: (qmail 20859 invoked by uid 109); 17 Feb 2021 23:34:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 23:34:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10765 invoked by uid 111); 17 Feb 2021 23:34:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 18:34:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 18:34:21 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] docs/rev-list: add an examples section
Message-ID: <YC2n/R1O77sRICSQ@coredump.intra.peff.net>
References: <YC2nOxPP3SAY2g1I@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC2nOxPP3SAY2g1I@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently don't show any examples of using git-rev-list at all. Let's
add some pretty elementary examples. They likely seem obvious to anybody
who has worked with the tool for a while, but my purpose here is
two-fold:

  - they may be enlightening to people who haven't used the tool a lot
    to give a general flavor of how it is meant to be used

  - they can serve as a starting point for adding more interesting
    examples (we can do that without the basic ones, of course, but I
    think it makes sense to show off the building blocks)

This set is far from exhaustive, but again, the purpose is to be a
starting point for further additions.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm open to feedback on these. But please, if you have suggestions for
adding more, do it in the form of a patch on top. :)

 Documentation/git-rev-list.txt | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 5da66232dc..d7ff519b90 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -31,6 +31,58 @@ include::rev-list-options.txt[]
 
 include::pretty-formats.txt[]
 
+EXAMPLES
+--------
+
+* Print the list of commits reachable from the current branch.
++
+----------
+git rev-list HEAD
+----------
+
+* Print the list of commits on this branch, but not present in the
+  upstream branch.
++
+----------
+git rev-list @{upstream}..HEAD
+----------
+
+* Format commits with their author and commit message (see also the
+  porcelain linkgit:git-log[1]).
++
+----------
+git rev-list --format=medium HEAD
+----------
+
+* Format commits along with their diffs (see also the porcelain
+  linkgit:git-log[1], which can do this in a single process).
++
+----------
+git rev-list HEAD |
+git diff-tree --stdin --format=medium -p
+----------
+
+* Print the list of commits on the current branch that touched any
+  file in the `Documentation` directory.
++
+----------
+git rev-list HEAD -- Documentation/
+----------
+
+* Print the list of commits authored by you in the past year, on
+  any branch, tag, or other ref.
++
+----------
+git rev-list --author=you@example.com --since=1.year.ago --all
+----------
+
+* Print the list of objects reachable from the current branch (i.e., all
+  commits and the blobs and trees they contain).
++
+----------
+git rev-list --objects HEAD
+----------
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.30.1.989.g5e01c2f281

