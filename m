From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/4] Don't write None to the conf file
Date: Sun, 26 Aug 2007 22:26:21 +0200
Message-ID: <20070826202620.15933.51552.stgit@yoghurt>
References: <20070826202309.15933.54183.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:26:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOh6-00063l-M2
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbXHZU0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbXHZU0q
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:26:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3255 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbXHZU0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:26:24 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOgf-0005sr-00; Sun, 26 Aug 2007 21:26:21 +0100
In-Reply-To: <20070826202309.15933.54183.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56714>

If we don't have a value for the remote, just don't write it. Writing
None will either write the string "None" or crash StGIT, depending on
how exactly the call is done -- and neither is what we want!

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/stack.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 030562d..0ce9992 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -546,7 +546,8 @@ class Series(PatchSet):
=20
     def set_parent(self, remote, localbranch):
         if localbranch:
-            self.__set_parent_remote(remote)
+            if remote:
+                self.__set_parent_remote(remote)
             self.__set_parent_branch(localbranch)
         # We'll enforce this later
 #         else:
