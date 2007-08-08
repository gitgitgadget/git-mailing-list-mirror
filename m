From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/2] Rename all config sections of a branch
Date: Thu, 09 Aug 2007 00:56:41 +0200
Message-ID: <20070808225641.17114.77114.stgit@yoghurt>
References: <20070808225522.17114.3065.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuSY-0002qz-3i
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761040AbXHHW4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 18:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760050AbXHHW4o
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:56:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1834 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761040AbXHHW4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:56:43 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIuSI-0006Ir-00; Wed, 08 Aug 2007 23:56:42 +0100
In-Reply-To: <20070808225522.17114.3065.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55389>

Just renaming the branch.branchname section doesn't rename the
branch.branchname.stgit section -- we have to do that explicitly.

This fixes bug 9692.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/stack.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index dbd7ea4..9c15b3f 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -616,8 +616,8 @@ class Series(PatchSet):
                    self.get_name(), to_stack.get_name())
=20
         # Rename the config section
-        config.rename_section("branch.%s" % self.get_name(),
-                              "branch.%s" % to_name)
+        for k in ['branch.%s', 'branch.%s.stgit']:
+            config.rename_section(k % self.get_name(), k % to_name)
=20
         self.__init__(to_name)
=20
