From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/3] rebase -i: Export GIT_AUTHOR_* variables explicitly
Date: Fri, 22 Jan 2010 10:22:31 +0100
Message-ID: <c6efda03848abc00cf8bf8d84fc34ef0d652b64c.1264151435.git.mhagger@alum.mit.edu>
References: <cover.1264151435.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	tarmigan+git@gmail.com, j.sixt@viscovery.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 10:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYFjk-0002zJ-KY
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 10:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065Ab0AVJXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 04:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995Ab0AVJXV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 04:23:21 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53976 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab0AVJXT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 04:23:19 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1CC41.dip.t-dialin.net [79.193.204.65])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0M9Mb4Q014743;
	Fri, 22 Jan 2010 10:22:51 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1264151435.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1264151435.git.mhagger@alum.mit.edu>
References: <cover.1264151435.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137751>

As pointed out on the mailing list, one-shot shell variable exports do
not necessarily work with shell functions.  So export the GIT_AUTHOR_*
variables explicitly using "export".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c2f6089..c8603f0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -215,9 +215,7 @@ has_action () {
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE exported from the current environment.
 do_with_author () {
-	GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
-	GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
-	GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
 	"$@"
 }
 
-- 
1.6.6
