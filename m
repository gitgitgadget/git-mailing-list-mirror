From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 3/4] Assert that the argument to Run is a sequence of
	strings
Date: Sun, 26 Aug 2007 22:33:39 +0200
Message-ID: <20070826203339.16265.43048.stgit@yoghurt>
References: <20070826202724.16265.85821.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOoW-0008Ch-3S
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbXHZUeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbXHZUd7
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:33:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4761 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbXHZUdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:33:42 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOnj-0005vw-00; Sun, 26 Aug 2007 21:33:39 +0100
In-Reply-To: <20070826202724.16265.85821.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56720>

This runtime assertion makes bugs easier to find.

In most other languages, we'd have been able to check this at compile
time. But this is Python. Yay!

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/run.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/stgit/run.py b/stgit/run.py
index d925cce..1bc4759 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -31,6 +31,9 @@ class Run:
     exc =3D RunException
     def __init__(self, *cmd):
         self.__cmd =3D list(cmd)
+        for c in cmd:
+            if type(c) !=3D str:
+                raise Exception, 'Bad command: %r' % cmd
         self.__good_retvals =3D [0]
         self.__env =3D None
         self.__indata =3D None
