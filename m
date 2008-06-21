From: shire <shire@tekrat.com>
Subject: [PATCH] Move deletion of configure generated files to distclean
Date: Fri, 20 Jun 2008 17:57:45 -0700
Message-ID: <D4D1BF84-3D3F-4DEC-87C0-F926228E0BF5@tekrat.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 03:06:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9rYc-0007DJ-SB
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 03:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbYFUBF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 21:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbYFUBF1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 21:05:27 -0400
Received: from sizzo.org ([69.63.177.213]:42120 "EHLO sizzo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbYFUBF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 21:05:26 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jun 2008 21:05:26 EDT
Received: from [99.204.10.66] (99-204-10-66.area1.spcsdns.net [99.204.10.66])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sizzo.org (Postfix) with ESMTPSA id 71F754F7651
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 17:57:48 -0700 (PDT)
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85684>


Running "make clean" also requires a run of "./configure ..." again  
because it deletes auto-generated files, which I found a little  
unexpected.  I figured I'd mention it as I'm not sure if this is  
confusing for other users or intended functionality of "make clean"  
vs. "make distclean", I would assume that the first would not revert  
configuration changes.

Signed-off-by: Brian Shire <shire@tekrat.com>

---
  Makefile |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b003e3e..f868b0b 100644
--- a/Makefile
+++ b/Makefile
@@ -1346,6 +1346,7 @@ dist-doc:
  ### Cleaning rules

  distclean: clean
+	$(RM) config.log config.mak.autogen config.mak.append config.status  
config.cache
  	$(RM) configure

  clean:
@@ -1355,7 +1356,6 @@ clean:
  	$(RM) $(TEST_PROGRAMS)
  	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags  
cscope*
  	$(RM) -r autom4te.cache
-	$(RM) config.log config.mak.autogen config.mak.append config.status  
config.cache
  	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
  	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-- 
1.5.6.dirty
