From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH 5/5] Autosign imported patches
Date: Wed, 16 Sep 2009 22:41:15 +0100
Message-ID: <20090916214115.6622.76531.stgit@toshiba-laptop>
References: <20090916214049.6622.44662.stgit@toshiba-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 23:48:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo2Ml-0003lJ-Ph
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760099AbZIPVsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760175AbZIPVsd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:48:33 -0400
Received: from cpc3-cmbg12-0-0-cust617.cmbg.cable.ntl.com ([86.9.126.106]:47221
	"EHLO toshiba-laptop" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760162AbZIPVs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 17:48:28 -0400
Received: by toshiba-laptop (Postfix, from userid 1000)
	id E582B1C07A2; Wed, 16 Sep 2009 22:41:15 +0100 (BST)
In-Reply-To: <20090916214049.6622.44662.stgit@toshiba-laptop>
User-Agent: StGit/0.15-rc3-5-g9f71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128683>

If stgit.autosign configuration is set, allow the automatic signing of
the imported patches, similar to the 'new' command.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/imprt.py |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index de77635..0f78490 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -141,6 +141,10 @@ def __create_patch(filename, message, author_name, author_email,
     if options.authdate:
         author_date = options.authdate
 
+    sign_str = options.sign_str
+    if not options.sign_str:
+        sign_str = config.get('stgit.autosign')
+
     crt_series.new_patch(patch, message = message, can_edit = False,
                          author_name = author_name,
                          author_email = author_email,
@@ -164,8 +168,7 @@ def __create_patch(filename, message, author_name, author_email,
         crt_series.refresh_patch(edit = options.edit,
                                  show_patch = options.showdiff,
                                  author_date = author_date,
-                                 sign_str = options.sign_str,
-                                 backup = False)
+                                 sign_str = sign_str, backup = False)
         out.done()
 
 def __mkpatchname(name, suffix):
