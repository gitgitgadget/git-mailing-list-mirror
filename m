From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/5] Eliminate temp variable that's used just once
Date: Tue, 29 Jan 2008 04:03:44 +0100
Message-ID: <20080129030337.926.3502.stgit@yoghurt>
References: <20080129030059.926.29897.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgln-0004CH-Mo
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623AbYA2DDs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753682AbYA2DDr
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:03:47 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1925 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495AbYA2DDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:03:46 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJglD-0000XI-00; Tue, 29 Jan 2008 03:03:43 +0000
In-Reply-To: <20080129030059.926.29897.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71929>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/transaction.py |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)


diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 809eabf..6a2ed81 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -174,7 +174,6 @@ class StackTransaction(object):
         """Attempt to push the named patch. If this results in conflic=
ts,
         halts the transaction. If index+worktree are given, spill any
         conflicts to them."""
-        i =3D self.unapplied.index(pn)
         cd =3D self.patches[pn].data
         cd =3D cd.set_committer(None)
         s =3D ['', ' (empty)'][cd.is_nochange()]
@@ -203,7 +202,7 @@ class StackTransaction(object):
                 s =3D ' (conflict)'
         cd =3D cd.set_tree(tree)
         self.patches[pn] =3D self.__stack.repository.commit(cd)
-        del self.unapplied[i]
+        del self.unapplied[self.unapplied.index(pn)]
         self.applied.append(pn)
         out.info('Pushed %s%s' % (pn, s))
         if merge_conflict:
