From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-filter-branch: Add an example on how to remove empty commits
Date: Wed, 29 Oct 2008 17:33:53 -0700
Message-ID: <1225326833-15210-1-git-send-email-pasky@suse.cz>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 01:35:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvLVO-0004Ov-1d
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 01:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbYJ3AeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 20:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbYJ3AeD
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 20:34:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39844 "EHLO pixie.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751201AbYJ3AeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 20:34:01 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id BE0F02ACFF1; Wed, 29 Oct 2008 17:33:53 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99440>

From: Sverre Rabbelier <srabbelier@gmail.com>

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---
 Documentation/git-filter-branch.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index fed6de6..2565244 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -246,6 +246,21 @@ git filter-branch --commit-filter '
 	fi' HEAD
 ------------------------------------------------------------------------------
 
+To remove commits that are empty (do not introduce any change):
+
+------------------------------------------------------------------------------
+git rev-list HEAD | while read c; do [ -n "$(git diff-tree --root $c)" ] || echo $c; done > revs
+
+git filter-branch --commit-filter '
+  if grep -q "$GIT_COMMIT" '"$(pwd)/"revs';
+  then
+    skip_commit "$@";
+  else
+    git commit-tree "$@";
+  fi' HEAD
+
+------------------------------------------------------------------------------
+
 The function 'skip_commit' is defined as follows:
 
 --------------------------
-- 
1.5.6.3.536.g61aad
