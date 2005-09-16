From: Martin Atukunda <matlads@dsmagic.com>
Subject: Add uninstall target to Makefile
Date: Fri, 16 Sep 2005 15:58:14 +0300
Message-ID: <20050916125814.GA8084@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 16 15:03:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGFpM-0002Xu-IF
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 15:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbVIPNAO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 09:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbVIPNAO
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 09:00:14 -0400
Received: from mail1.starcom.co.ug ([217.113.72.31]:21351 "EHLO
	mail1.infocom.co.ug") by vger.kernel.org with ESMTP
	id S1161087AbVIPNAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 09:00:12 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Fri, 16 Sep 2005 15:59:51 +0300
  id 000E9B9B.432AC1C7.00007311
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 199FA5268
	for <git@vger.kernel.org>; Fri, 16 Sep 2005 16:01:11 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.52)
	id 1EGFnC-00026x-Vb
	for git@vger.kernel.org; Fri, 16 Sep 2005 15:58:15 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8682>


Add the uninstall target to the Makefile.

Signed-off-by: Martin Atukunda <matlads@dsmagic.com>
--- 

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -305,6 +305,15 @@ install-doc:
 	$(MAKE) -C Documentation install
 
 
+### Uninstallation rules
+
+uninstall:
+	-sh ./remove-cmd-rename.sh $(DESTDIR)$(bindir)
+	cd $(DESTDIR)$(bindir) && \
+	rm $(PROGRAMS) $(SCRIPTS) && \
+	rm git-cherry-pick && \
+	cd $(DESTDIR)$(GIT_PYTHON_DIR) && \
+	rm $(PYMODULES)
 
 
 ### Maintainer's dist rules
diff --git a/remove-cmd-rename.sh b/remove-cmd-rename.sh
new file mode 100644
--- /dev/null
+++ b/remove-cmd-rename.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+d="$1"
+test -d "$d" || exit
+
+while read name
+do
+	rm  -f "$d/$name"
+done <<\EOF
+git-add-script
+git-archimport-script
+git-bisect-script
+git-branch-script
+git-checkout-script
+git-cherry-pick-script
+git-clone-script
+git-commit-script
+git-count-objects-script
+git-cvsimport-script
+git-diff-script
+git-send-email-script
+git-fetch-script
+git-format-patch-script
+git-log-script
+git-ls-remote-script
+git-merge-one-file-script
+git-octopus-script
+git-parse-remote-script
+git-prune-script
+git-pull-script
+git-push-script
+git-rebase-script
+git-relink-script
+git-rename-script
+git-repack-script
+git-request-pull-script
+git-reset-script
+git-resolve-script
+git-revert-script
+git-sh-setup-script
+git-status-script
+git-tag-script
+git-verify-tag-script
+git-http-pull
+git-local-pull
+git-checkout-cache
+git-diff-cache
+git-merge-cache
+git-update-cache
+git-convert-cache
+git-fsck-cache
+EOF
