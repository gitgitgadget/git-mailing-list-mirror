From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Fix uncommit status message
Date: Thu, 17 Jul 2008 22:43:21 +0200
Message-ID: <20080717204321.23542.77124.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaKx-0008Cn-Uo
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbYGQUn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756220AbYGQUn0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:43:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1869 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbYGQUnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:43:24 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KJaJu-0008Ho-00; Thu, 17 Jul 2008 21:43:22 +0100
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88920>

It should say

  Uncommitting to 8561b089afbaed2651591e5a4574fdca451d82f2 (exclusive) =
=2E..

not

  Uncommitting to Commit<sha1: 8561b089afbaed2651591e5a4574fdca451d82f2=
, data: None> (exclusive) ...

(though arguably, the sha1 should be abbreviated as well).

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/uncommit.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index eb39fcc..0f43b49 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -104,9 +104,9 @@ def func(parser, options, args):
             next_commit =3D get_parent(next_commit)
     else:
         if options.exclusive:
-            out.start('Uncommitting to %s (exclusive)' % to_commit)
+            out.start('Uncommitting to %s (exclusive)' % to_commit.sha=
1)
         else:
-            out.start('Uncommitting to %s' % to_commit)
+            out.start('Uncommitting to %s' % to_commit.sha1)
         while True:
             if next_commit =3D=3D to_commit:
                 if not options.exclusive:
