From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Improve error message: not a valid branch name
Date: Sun, 26 Aug 2007 18:28:18 +0300
Organization: Private
Message-ID: <y7fyfh7x.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 17:24:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPJyZ-0004y9-NO
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 17:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbXHZPY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 11:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbXHZPY1
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 11:24:27 -0400
Received: from main.gmane.org ([80.91.229.2]:55369 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbXHZPY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 11:24:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPJyL-0006qc-GC
	for git@vger.kernel.org; Sun, 26 Aug 2007 17:24:17 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 17:24:17 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 17:24:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:BoeAx/xMB++yGyFgN9E8T2ii5bE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56689>


(create_branch): Extend die message from 'is not a valid branch name'
to '...(see git-check-ref-format)'.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 builtin-branch.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 7408285..1006a85 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -431,7 +431,8 @@ static void create_branch(const char *name, const char *start_name,
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
 	if (check_ref_format(ref))
-		die("'%s' is not a valid branch name.", name);
+		die("'%s' is not a valid branch name "
+                    "(see git-check-ref-format)", name);
 
 	if (resolve_ref(ref, sha1, 1, NULL)) {
 		if (!force)
@@ -502,13 +503,15 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 		die("Old branchname too long");
 
 	if (check_ref_format(oldref))
-		die("Invalid branch name: %s", oldref);
+		die("Invalid branch name: %s "
+                    "(see git-check-ref-format)", oldref);
 
 	if (snprintf(newref, sizeof(newref), "refs/heads/%s", newname) > sizeof(newref))
 		die("New branchname too long");
 
 	if (check_ref_format(newref))
-		die("Invalid branch name: %s", newref);
+		die("Invalid branch name: %s "
+                    "(see git-check-ref-format)", newref);
 
 	if (resolve_ref(newref, sha1, 1, NULL) && !force)
 		die("A branch named '%s' already exists.", newname);
-- 
1.5.3.rc5
