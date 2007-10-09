From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Fix error message generation
Date: Tue, 09 Oct 2007 06:40:57 +0200
Message-ID: <20071009044045.11981.93951.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 06:42:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If6v8-0003kC-03
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 06:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbXJIElG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 00:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbXJIElF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 00:41:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4233 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbXJIElE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 00:41:04 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1If6tu-0005v0-00; Tue, 09 Oct 2007 05:40:58 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60355>

The right-hand-side operand of % is supposed to be a tuple with the
same number of arguments as there are formatting codes in the
left-hand-side operand, or just any value if there is just one
formatting code; however, here it was a variable with a tuple value,
which didn't work. So wrap it in a tuple of length one, and all is
well again.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/run.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/run.py b/stgit/run.py
index 989bb27..83bf5f5 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -40,7 +40,7 @@ class Run:
         self.__cmd =3D list(cmd)
         for c in cmd:
             if type(c) !=3D str:
-                raise Exception, 'Bad command: %r' % cmd
+                raise Exception, 'Bad command: %r' % (cmd,)
         self.__good_retvals =3D [0]
         self.__env =3D None
         self.__indata =3D None
