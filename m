From: David Rientjes <rientjes@google.com>
Subject: [PATCH 06/28] make cmd_log_walk void
Date: Mon, 14 Aug 2006 13:23:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141322440.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:24:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCiyw-00074C-Oh
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWHNUYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWHNUYP
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:24:15 -0400
Received: from smtp-out.google.com ([216.239.45.12]:58768 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932701AbWHNUYO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:24:14 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id k7EKNtDH005394
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:23:55 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=yl+NSaIk8Q7Sm8FRQdYxreLtcIjjL7J37uZXhS3s0Zq69pXrAv+dU8ry2Vk2LcKbH
	qrKq0vljq8SVNMgRL1bpw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps37.corp.google.com with ESMTP id k7EKNqLx032578
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:23:52 -0700
Received: by localhost (Postfix, from userid 24081)
	id AA19787D71; Mon, 14 Aug 2006 13:23:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id A767F87D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:23:52 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25386>

Makes cmd_log_walk void.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-log.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 691cf3a..cf103ea 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -29,7 +29,7 @@ static void cmd_log_init(int argc, const
 		die("unrecognized argument: %s", argv[1]);
 }
 
-static int cmd_log_walk(struct rev_info *rev)
+static void cmd_log_walk(struct rev_info *rev)
 {
 	struct commit *commit;
 
@@ -41,7 +41,6 @@ static int cmd_log_walk(struct rev_info 
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 	}
-	return 0;
 }
 
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
@@ -56,7 +55,8 @@ int cmd_whatchanged(int argc, const char
 	cmd_log_init(argc, argv, prefix, &rev);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
-	return cmd_log_walk(&rev);
+	cmd_log_walk(&rev);
+	return 0;
 }
 
 int cmd_show(int argc, const char **argv, const char *prefix)
@@ -73,7 +73,8 @@ int cmd_show(int argc, const char **argv
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
 	cmd_log_init(argc, argv, prefix, &rev);
-	return cmd_log_walk(&rev);
+	cmd_log_walk(&rev);
+	return 0;
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
@@ -84,7 +85,8 @@ int cmd_log(int argc, const char **argv,
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	cmd_log_init(argc, argv, prefix, &rev);
-	return cmd_log_walk(&rev);
+	cmd_log_walk(&rev);
+	return 0;
 }
 
 static int istitlechar(char c)
-- 
1.4.2.g89bb-dirty
