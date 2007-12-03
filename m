From: "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH] Reorder msgfmt command-line arguments.
Date: Mon, 3 Dec 2007 01:26:33 +0000
Message-ID: <20071203012631.GA22450@crustytoothpaste.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 02:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz0NY-0001UC-Mq
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 02:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbXLCBp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 20:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbXLCBp0
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 20:45:26 -0500
Received: from mknod.org ([209.223.236.42]:55640 "EHLO mknod.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbXLCBpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 20:45:25 -0500
X-Greylist: delayed 1128 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Dec 2007 20:45:25 EST
Received: from crustytoothpaste.ath.cx (c-98-197-197-167.hsd1.tx.comcast.net [98.197.197.167])
	by mknod.org (Postfix) with ESMTP id 16AC4218002
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 19:26:37 -0600 (CST)
Received: from crustytoothpaste.ath.cx (lakeview.crustytoothpaste.ath.cx [172.16.2.249])
	(authenticated bits=0)
	by crustytoothpaste.ath.cx (8.14.2/8.14.2/Debian-2) with ESMTP id lB31QXff024872
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 3 Dec 2007 01:26:36 GMT
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66841>

Any program using getopt or getopt_long will stop processing options
once a non-option argument has been encountered, if POSIXLY_CORRECT is
set.  Therefore, reorder the command-line arguments to put options
first, so that the msgfmt call works in this scenario.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.ath.cx>
---

Note that this patch is against the next branch, since that's what I 
use.  It may or may not apply (or be needed) on the mainline.

  git-gui/Makefile |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index e860319..4ce4663 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -212,7 +212,7 @@ $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
  update-po:: $(PO_TEMPLATE)
  	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
  $(ALL_MSGFILES): %.msg : %.po
-	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@) $(QUIET_MSGFMT1)
+	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
  
  lib/tclIndex: $(ALL_LIBFILES) GIT-GUI-VARS
  	$(QUIET_INDEX)if echo \
-- 
1.5.3.6.1797.g67f5d
