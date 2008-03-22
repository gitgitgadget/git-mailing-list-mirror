From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/7] Make unpack_trees_options bit flags actual bitfields
Date: Sat, 22 Mar 2008 10:22:39 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:24:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7ST-0002Td-2h
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbYCVRYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbYCVRYA
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:24:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32782 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753587AbYCVRX7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 13:23:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHMg43001684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 10:22:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHMdpS019306;
	Sat, 22 Mar 2008 10:22:40 -0700
In-Reply-To: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.756 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77828>


From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Fri, 21 Mar 2008 13:14:47 -0700

Instead of wasting space with whole integers for a single bit.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is really unrelated to the rest of the series, except for the fact 
that it irritated me when I was thinking about the required changes to 
unpack-trees.

 unpack-trees.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/unpack-trees.h b/unpack-trees.h
index 50453ed..ad8cc65 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -9,16 +9,16 @@ typedef int (*merge_fn_t)(struct cache_entry **src,
 		struct unpack_trees_options *options);
 
 struct unpack_trees_options {
-	int reset;
-	int merge;
-	int update;
-	int index_only;
-	int nontrivial_merge;
-	int trivial_merges_only;
-	int verbose_update;
-	int aggressive;
-	int skip_unmerged;
-	int gently;
+	unsigned int reset:1,
+		     merge:1,
+		     update:1,
+		     index_only:1,
+		     nontrivial_merge:1,
+		     trivial_merges_only:1,
+		     verbose_update:1,
+		     aggressive:1,
+		     skip_unmerged:1,
+		     gently:1;
 	const char *prefix;
 	int pos;
 	struct dir_struct *dir;
-- 
1.5.5.rc0.28.g61a0.dirty
