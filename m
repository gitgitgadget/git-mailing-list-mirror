X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 15:19:44 +0000
Message-ID: <200612141519.44294.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:19:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 6fc93213c5998147
X-UID: 192
X-Length: 1226
Content-Disposition: inline
X-OriginalArrivalTime: 14 Dec 2006 15:21:45.0659 (UTC) FILETIME=[90FE58B0:01C71F93]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34347>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GusNF-000450-Jd for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932795AbWLNPTt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbWLNPTt
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:19:49 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:32583 "EHLO
 369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S932795AbWLNPTs (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 10:19:48 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 14 Dec 2006 15:21:45 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GusN7-0007dq-00 for <git@vger.kernel.org>; Thu, 14 Dec
 2006 15:19:45 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This patch makes all merge log messages of the form:

  Merge branch XXXX into YYYY

Regardless of whether YYYY is master or not.

"master" shouldn't get special treatment; making different log messages
based on the name of the branch is bad form.  What if a user likes
"my/master" or "my/head" as their master branch?

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-fmt-merge-msg.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 87d3d63..99edb75 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -331,10 +331,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			printf(" of %s", srcs.list[i]);
 	}
 
-	if (!strcmp("master", current_branch))
-		putchar('\n');
-	else
-		printf(" into %s\n", current_branch);
+	printf(" into %s\n", current_branch);
 
 	if (merge_summary) {
 		struct commit *head;
-- 
1.4.4.1.g3ece-dirty
