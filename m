From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] Forbid the "series --all --short" combination.
Date: Mon, 02 Jul 2007 21:47:48 +0200
Message-ID: <20070702194748.31124.16084.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 21:48:15 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Rsc-0001wK-0O
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 21:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbXGBTsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbXGBTsK
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 15:48:10 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:57026 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076AbXGBTsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 15:48:08 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E12FA5A416;
	Mon,  2 Jul 2007 21:48:07 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 572001F175;
	Mon,  2 Jul 2007 21:47:48 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51397>

That combination would otherwise simply augment with hidden patches
the display we would have with --short, which does not seem useful,
but can be confusing.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/series.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 0b3efe0..9e0b0ff 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -109,6 +109,9 @@ def func(parser, options, args):
     """
     global crt_series
 
+    if options.all and options.short:
+        raise CmdException, 'combining --all and --short is meaningless'
+    
     # current series patches
     if options.invisible:
         applied = unapplied = []
