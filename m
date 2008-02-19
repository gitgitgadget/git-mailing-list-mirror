From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] prefix_path: use is_absolute_path() instead of *orig == '/'
Date: Tue, 19 Feb 2008 22:29:40 +0100
Message-ID: <1203456580.47bb4a44b9d24@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 19 22:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRa2b-0003TR-Lc
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbYBSV3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754425AbYBSV3n
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:29:43 -0500
Received: from smtp2.srv.eunet.at ([193.154.160.116]:40111 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbYBSV3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:29:42 -0500
Received: from localhost (webmail01.srv.eunet.at [193.154.180.195])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id E47FEBF00C;
	Tue, 19 Feb 2008 22:29:40 +0100 (CET)
Received: from 77.116.207.249 ([77.116.207.249]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Tue, 19 Feb 2008 22:29:40 +0100
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.116.207.249
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74455>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

This goes on top of branch jc/setup.

-- Hannes

 setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 5e4cecb..18ddfae 100644
--- a/setup.c
+++ b/setup.c
@@ -91,7 +91,7 @@ const char *prefix_path(const char *prefix, int len,
 {
 	const char *orig = path;
 	char *sanitized = xmalloc(len + strlen(path) + 1);
-	if (*orig == '/')
+	if (is_absolute_path(orig))
 		strcpy(sanitized, path);
 	else {
 		if (len)
@@ -100,7 +100,7 @@ const char *prefix_path(const char *prefix, int len,
 	}
 	if (sanitary_path_copy(sanitized, sanitized))
 		goto error_out;
-	if (*orig == '/') {
+	if (is_absolute_path(orig)) {
 		const char *work_tree = get_git_work_tree();
 		size_t len = strlen(work_tree);
 		size_t total = strlen(sanitized) + 1;
-- 
1.5.4.2.940.g0f70f.dirty
