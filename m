From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 03/12] add 'merge.stat' config variable
Date: Wed, 16 Apr 2008 02:39:02 +0200
Message-ID: <1208306351-20922-4-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 07:45:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvhp-0007aE-MS
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbYDPAjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbYDPAjV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52370 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbYDPAjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:18 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis)
	id 0ML25U-1JlvgB14Fe-0001WP; Wed, 16 Apr 2008 02:39:15 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-3-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/aqeKLpAJENcchp9OTPNY5O9S/NvGHraPOH/e
 xkQFmVIuxxlBLi3hjdxFz7nqid4t9nfhnKb4OkU/kyAXBbsOeZ
 1Ye9cGsGYAdFfPKcMyRaw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79666>

This config variable has the same effect as the current
'merge.diffstat', but its name is consistent with the related command
line option.

Update documentation and bash completion accordingly.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/merge-config.txt         |    5 +++++
 Documentation/merge-options.txt        |    3 ++-
 contrib/completion/git-completion.bash |    1 +
 git-merge.sh                           |    1 +
 4 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index cc815cc..15efc0d 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,3 +1,8 @@
+merge.stat::
+merge.diffstat::
+	Whether to print the diffstat berween ORIG_HEAD and merge result
+	at the end of the merge.  True by default.
+
 merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index c82bc7e..9c46dcb 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,6 +1,7 @@
 --stat, \--summary::
 	Show a diffstat at the end of the merge. The diffstat is also
-	controlled by the configuration option merge.diffstat.
+	controlled by the configuration option merge.stat (and the
+	equivalent merge.diffstat).
=20
 -n, \--no-stat, \--no-summary::
 	Do not show diffstat at the end of the merge.
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5221a1a..4caff8d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1022,6 +1022,7 @@ _git_config ()
 		i18n.logOutputEncoding
 		log.showroot
 		merge.tool
+		merge.stat
 		merge.summary
 		merge.verbosity
 		pack.window
diff --git a/git-merge.sh b/git-merge.sh
index cda78de..a29a7ec 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -212,6 +212,7 @@ while test $args_left -lt $#; do shift; done
=20
 if test -z "$show_diffstat"; then
     test "$(git config --bool merge.diffstat)" =3D false && show_diffs=
tat=3Dfalse
+    test "$(git config --bool merge.stat)" =3D false && show_diffstat=3D=
false
     test -z "$show_diffstat" && show_diffstat=3Dt
 fi
=20
--=20
1.5.5.76.g546c
