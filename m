From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/6] Make sure patches with no parents have an empty
	list of parents
Date: Thu, 20 Mar 2008 01:31:40 +0100
Message-ID: <20080320003140.13102.91209.stgit@yoghurt>
References: <20080320002604.13102.53757.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8iB-0006sd-7g
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938268AbYCTAbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 20:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938034AbYCTAbs
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:31:48 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2852 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163275AbYCTAbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:31:44 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jc8h1-0004sB-00; Thu, 20 Mar 2008 00:31:39 +0000
In-Reply-To: <20080320002604.13102.53757.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77599>

They used to have None instead of an empty list, which was
inconsistent. (It went undetected for quite a while because StGit
seldom needs to handle initial commits.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 50dc4f1..cdfe885 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -204,7 +204,7 @@ class Commitdata(Repr):
                 ) % (tree, parents, self.author, self.committer, self.=
message)
     @classmethod
     def parse(cls, repository, s):
-        cd =3D cls()
+        cd =3D cls(parents =3D [])
         lines =3D list(s.splitlines(True))
         for i in xrange(len(lines)):
             line =3D lines[i].strip()
