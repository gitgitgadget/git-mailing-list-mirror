From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/2] git-cherry-pick.txt: make clearer when revision walking gets activated
Date: Fri, 15 Jun 2012 16:33:16 +0200
Message-ID: <1339770796-542-2-git-send-email-cmn@elego.de>
References: <1339765943.4625.57.camel@beez.lab.cmartin.tk>
 <1339770796-542-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <dirson@bertin.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 16:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfXag-0008F5-SG
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 16:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178Ab2FOOdZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 10:33:25 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:57458 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757167Ab2FOOdX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 10:33:23 -0400
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 9085B4614A;
	Fri, 15 Jun 2012 16:33:16 +0200 (CEST)
Received: (nullmailer pid 580 invoked by uid 1000);
	Fri, 15 Jun 2012 14:33:16 -0000
X-Mailer: git-send-email 1.7.10.2.520.g6a4a482
In-Reply-To: <1339770796-542-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200054>

When given a set of commits, cherry-pick will apply the changes for
all of them. Specifying a simple range will also work as
expected. This can cause the user to think that

    git cherry-pick A B..C

will apply A and then B..C. This is not what happens. Instead the revs
are given to rev-list which will consider A and C as positive revs and
B as a negative one. Add a note about this and add an example with
this particular syntax, which has shown up on the list a few times.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 Documentation/git-cherry-pick.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cher=
ry-pick.txt
index 06a0bfd..10abfbf 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -48,6 +48,7 @@ OPTIONS
 	Sets of commits can be passed but no traversal is done by
 	default, as if the '--no-walk' option was specified, see
 	linkgit:git-rev-list[1].
+	Note that specifying a range will activate revision walking.
=20
 -e::
 --edit::
@@ -130,6 +131,15 @@ EXAMPLES
 	Apply the changes introduced by all commits that are ancestors
 	of master but not of HEAD to produce new commits.
=20
+`git cherry-pick master next ^maint`::
+`git cherry-pick master maint..next`::
+
+	Apply the changes introduced by all commits that are ancestors
+	of master or next, but not maint or any of its ancestors. The
+	second spelling is often a misunderstanding of revision
+	walking works when trying to apply a range plus a particular
+	commit and included for completeness.
+
 `git cherry-pick master~4 master~2`::
=20
 	Apply the changes introduced by the fifth and third last
--=20
1.7.10.2.520.g6a4a482
