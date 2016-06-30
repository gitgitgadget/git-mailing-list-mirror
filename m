Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5E31FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 20:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbcF3UlW (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 16:41:22 -0400
Received: from smtp-d-6.talktalk.net ([78.144.6.134]:42108 "EHLO
	smtp-d-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbcF3UlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 16:41:19 -0400
Received: from localhost.localdomain ([2.96.205.30])
	by smtp.talktalk.net with SMTP
	id IiWUbMHWfgKstIiWWbS4Ff; Thu, 30 Jun 2016 21:25:20 +0100
X-Originating-IP: [2.96.205.30]
X-Spam:	0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=QTrtdgWXx+RZbj7kV87ZQA==:117
 a=QTrtdgWXx+RZbj7kV87ZQA==:17 a=xtxXYLxNAAAA:8 a=wgAWyCurPUsrivyQAi4A:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/4] doc: give headings for the two and three dot notations
Date:	Thu, 30 Jun 2016 21:25:08 +0100
Message-Id: <20160630202509.4472-4-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160630202509.4472-1-philipoakley@iee.org>
References: <20160625164654.5192-1-philipoakley@iee.org>
 <20160630202509.4472-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfN8tXlCD5YYqi+z13Dm9ykjWCOoE2yPbyzTr63XBEKpQfg8BDLnp1eeriPdqf4AtN+n0OLa5PbX+9t9ccif42Hl2p1a4XOFSCTQEtGKObIPc7qy/JY/m
 5p0CVgT5DI66/JIy5fXsDcWl3eugn8tHcYjEmWS9lUTqiUQfPyFMoAWVikZLuMD4ECvpd6yXnhEraPykbWSLhm8CNWL3KI9OJbl9+OCYvu85Kcaa/guZVcow
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
index 19314e3..131060c 100644
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
 'r1' or 'r2' but not from both.
 
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

