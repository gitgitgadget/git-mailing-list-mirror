From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 2/3] Disallow non-patch args to "stg show" (gna #8453).
Date: Thu, 28 Jun 2007 23:44:10 +0200
Message-ID: <20070628214410.26983.20341.stgit@gandelf.nowhere.earth>
References: <20070628214242.26983.99859.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 23:44:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I41nK-0002wS-UF
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 23:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764592AbXF1Vo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 17:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761249AbXF1Vo0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 17:44:26 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:42493 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762391AbXF1VoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 17:44:25 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4E9235A1A2;
	Thu, 28 Jun 2007 23:44:24 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 35E5A1F084;
	Thu, 28 Jun 2007 23:44:10 +0200 (CEST)
In-Reply-To: <20070628214242.26983.99859.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51132>

Git-core refs and patch@branch args were not allowed in the
multiple-argument form of "stg show".  For consistency we completely
disallow them: git-core refs are available from git-show, and "stg
show patch@branch" as "stg show patch -b branch".

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/show.py |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index c59ac68..3bf4f20 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -55,12 +55,7 @@ def func(parser, options, args):
     elif len(args) == 0:
         patches = ['HEAD']
     else:
-        if len(args) == 1 and args[0].find('..') == -1 \
-               and not crt_series.patch_exists(args[0]):
-            # it might be just a commit id
-            patches = args
-        else:
-            patches = parse_patches(args, applied + unapplied, len(applied))
+        patches = parse_patches(args, applied + unapplied, len(applied))
 
     if options.diff_opts:
         diff_flags = options.diff_opts.split()
