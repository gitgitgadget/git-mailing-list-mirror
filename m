From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Declare stacked variables before the first statement.
Date: Thu, 19 May 2005 15:23:18 +0200
Message-ID: <20050519132318.GH12796@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 19 15:24:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYkzI-00023a-J5
	for gcvg-git@gmane.org; Thu, 19 May 2005 15:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVESNXd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 09:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVESNXd
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 09:23:33 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:1474 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262489AbVESNX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 09:23:29 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4JDNJS8027140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 May 2005 13:23:19 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4JDNIBs027139;
	Thu, 19 May 2005 15:23:18 +0200 (CEST)
To: GIT <git@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: GIT <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Declare stacked variables before the first statement.

Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/diff.c
+++ b/diff.c
@@ -83,7 +83,7 @@
 			 const char *name_b,
 			 struct diff_tempfile *temp)
 {
-	int i, next_at;
+	int i, next_at, cmd_size;
 	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
 	const char *diff_arg  = "'%s' '%s'||:"; /* "||:" is to return 0 */
 	const char *input_name_sq[2];
@@ -100,7 +100,7 @@
 	 * we use 2 spaces around diff-opts, and we need to count
 	 * terminating NUL, so we subtract 9 here.
 	 */
-	int cmd_size = (strlen(diff_cmd) + strlen(diff_opts) +
+	cmd_size = (strlen(diff_cmd) + strlen(diff_opts) +
 			strlen(diff_arg) - 9);
 	for (i = 0; i < 2; i++) {
 		input_name_sq[i] = sq_expand(temp[i].name);
