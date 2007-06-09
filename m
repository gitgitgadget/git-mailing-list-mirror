From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 2/2] Have mail take the default for --prefix from
	stgit.mail.prefix.
Date: Sat, 09 Jun 2007 19:25:26 +0200
Message-ID: <20070609172526.30912.56153.stgit@gandelf.nowhere.earth>
References: <20070609172520.30912.80799.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 19:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx4gm-0003Up-W1
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 19:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbXFIRZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 13:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756140AbXFIRZX
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 13:25:23 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46121 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067AbXFIRZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 13:25:22 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 777F87A84;
	Sat,  9 Jun 2007 19:25:21 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 446D71F019;
	Sat,  9 Jun 2007 19:25:26 +0200 (CEST)
In-Reply-To: <20070609172520.30912.80799.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49583>

It is more convenient to set the prefix once and for all in the config
file than each time on command line.
---

 stgit/commands/mail.py |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index cec1828..899cb1a 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -296,7 +296,11 @@ def __build_cover(tmpl, total_nr, msg_id, options):
     if options.prefix:
         prefix_str = options.prefix + ' '
     else:
-        prefix_str = ''
+        confprefix = config.get('stgit.mail.prefix')
+        if confprefix:
+            prefix_str = confprefix + ' '
+        else:
+            prefix_str = ''
         
     total_nr_str = str(total_nr)
     patch_nr_str = '0'.zfill(len(total_nr_str))
@@ -374,7 +378,11 @@ def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
     if options.prefix:
         prefix_str = options.prefix + ' '
     else:
-        prefix_str = ''
+        confprefix = config.get('stgit.mail.prefix')
+        if confprefix:
+            prefix_str = confprefix + ' '
+        else:
+            prefix_str = ''
         
     if options.diff_opts:
         diff_flags = options.diff_opts.split()
