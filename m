Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E362018F
	for <e@80x24.org>; Mon, 11 Jul 2016 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbcGKUZb (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:25:31 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:60970 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbcGKUZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:25:30 -0400
Received: from localhost.localdomain ([92.22.73.13])
	by smtp.talktalk.net with SMTP
	id MhlcbLEzMY8RwMhlgbR8mB; Mon, 11 Jul 2016 21:25:29 +0100
X-Originating-IP: [92.22.73.13]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=R5CpdR+gL2+IAQkTIkP0Ow==:117
 a=R5CpdR+gL2+IAQkTIkP0Ow==:17 a=xtxXYLxNAAAA:8 a=wgAWyCurPUsrivyQAi4A:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 4/8] doc: give headings for the two and three dot notations
Date:	Mon, 11 Jul 2016 21:25:14 +0100
Message-Id: <20160711202518.532-5-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160711202518.532-1-philipoakley@iee.org>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfC+wao++7lhecHJakQ7tygHuoLf/VSEbpbZjtcRoy2jrxy3naO0m2+r1oz3GwAGk/62ffS8GX8JtU5ctw4GHTjpILiMA7+FmTTJrV65PCRF7Zn+dYE1L
 8hXErS+IxwJTflKgu/tfz8XtGAF+By8jFulo839Wu5kEtEhXN7h4Y8V2Vy6ZqvfoEzGWul3I6UDSaaDcyCxnvHHsTHnEY4dXwYueIxR4dJf+8fzlNRWhzKsY
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While there, also break out the other shorthand notations and
add a title for the revision range summary (which also appears
in git-rev-parse, so keep it mixed case).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/revisions.txt | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 79f6d03..1c59e87 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -242,35 +242,46 @@ specifying a single revision with the notation described in the
 previous section means the set of commits reachable from that
 commit, following the commit ancestry chain.
 
+The '{caret}' (caret) notation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 To exclude commits reachable from a commit, a prefix '{caret}'
 notation is used.  E.g. '{caret}r1 r2' means commits reachable
 from 'r2' but exclude the ones reachable from 'r1'.
 
-This set operation appears so often that there is a shorthand
+The '..' (two-dot) range notation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The '{caret}r1 r2' set operation appears so often that there is a shorthand
 for it.  When you have two commits 'r1' and 'r2' (named according
 to the syntax explained in SPECIFYING REVISIONS above), you can ask
 for commits that are reachable from r2 excluding those that are reachable
 from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
 
+The '...' (three dot) Symmetric Difference notation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A similar notation 'r1\...r2' is called symmetric difference
 of 'r1' and 'r2' and is defined as
 'r1 r2 --not $(git merge-base --all r1 r2)'.
 It is the set of commits that are reachable from either one of
 'r1' (Left side) or 'r2' (Right side) but not from both.
 
-In these two shorthands, you can omit one end and let it default to HEAD.
+In these two shorthand notations, you can omit one end and let it default to HEAD.
 For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
 did I do since I forked from the origin branch?"  Similarly, '..origin'
 is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
+Additional '{caret}' Shorthand notations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Two other shorthands for naming a set that is formed by a commit
-and its parent commits exist.  The 'r1{caret}@' notation means all
-parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
-all of its parents.
+and its parent commits exist.
 
-To summarize:
+The 'r1{caret}@' notation means all parents of 'r1'.
+
+'r1{caret}!' includes commit 'r1' but excludes all of its parents.
+
+Revision Range Summary
+----------------------
 
 '<rev>'::
 	Include commits that are reachable from (i.e. ancestors of)
-- 
2.8.4.windows.1.3.ge328a54

