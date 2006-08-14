From: David Rientjes <rientjes@google.com>
Subject: [PATCH 26/28] makes show_entry void
Date: Mon, 14 Aug 2006 13:39:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141338500.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:39:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjDq-0001rk-Ah
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWHNUjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWHNUjj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:39:39 -0400
Received: from smtp-out.google.com ([216.239.45.12]:38553 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964863AbWHNUjj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:39:39 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7EKdSHt031790
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:39:34 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=S5fOmb/3KKXslvnajpYK8WF2LI+KKtVIWYRFs9nmC9wFVR8bV2vPwuxDopXnO9e39
	Pv1SHzbXQ11xDOyFb+HVA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7EKdR4Z007565
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:39:27 -0700
Received: by localhost (Postfix, from userid 24081)
	id 75D9D87D71; Mon, 14 Aug 2006 13:39:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 72D1A87D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:39:27 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25407>

Makes show_entry void.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 tree-diff.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 1cdf8aa..916f489 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -15,7 +15,8 @@ static char *malloc_base(const char *bas
 	return newbase;
 }
 
-static int show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base);
+static void show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc,
+		       const char *base);
 
 static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
@@ -131,7 +132,8 @@ static void show_tree(struct diff_option
 }
 
 /* A file entry went away or appeared */
-static int show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base)
+static void show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc,
+		       const char *base)
 {
 	unsigned mode;
 	const char *path;
@@ -152,11 +154,9 @@ static int show_entry(struct diff_option
 
 		free(tree);
 		free(newbase);
-		return 0;
+	} else {
+		opt->add_remove(opt, prefix[0], mode, sha1, base, path);
 	}
-
-	opt->add_remove(opt, prefix[0], mode, sha1, base, path);
-	return 0;
 }
 
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
-- 
1.4.2.g89bb-dirty
