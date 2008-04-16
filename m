From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 07/12] merge,
	pull: mark '--(no-)summary' options as deprecated
Date: Wed, 16 Apr 2008 02:39:06 +0200
Message-ID: <1208306351-20922-8-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-4-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-5-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-6-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-7-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:27:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvhu-0007aE-AI
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbYDPAjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756720AbYDPAjj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:61919 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482AbYDPAjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:37 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis)
	id 0ML25U-1JlvgE2YB4-0001SK; Wed, 16 Apr 2008 02:39:18 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-7-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX18ua1g1hR4KQI3CEpoJWY5sS3gfQ400tgO+Siv
 JBVYLAaR3m7hYiNeFfK/385CXvzDVvq3Hqz8YUXFolkfkQjAyU
 t1ECFoNYDgsjOCIekiSGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79641>

Also remove them from bash completion.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-merge.txt            |    4 ++--
 Documentation/merge-options.txt        |   10 ++++++++--
 contrib/completion/git-completion.bash |    2 +-
 git-merge.sh                           |    4 ++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c514e3b..2f9edd8 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,8 +9,8 @@ git-merge - Join two or more development histories toge=
ther
 SYNOPSIS
 --------
 [verse]
-'git-merge' [-n | --no-stat | --no-summary] [--stat | --summary] [--no=
-commit]
-	[--squash] [-s <strategy>]... [-m <msg>] <remote> <remote>...
+'git-merge' [-n | --no-stat] [--stat] [--no-commit] [--squash]
+	[-s <strategy>]... [-m <msg>] <remote> <remote>...
 'git-merge' <msg> HEAD <remote>...
=20
 DESCRIPTION
diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index 41ef152..d0a2ac9 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,11 +1,17 @@
---stat, \--summary::
+--stat::
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.stat (and the
 	equivalent merge.diffstat).
=20
--n, \--no-stat, \--no-summary::
+-n, \--no-stat::
 	Do not show diffstat at the end of the merge.
=20
+--summary::
+	Deprecated equivalent of --stat.
+
+--no-summary::
+	Deprecated equivalent of --no-stat.
+
 --log::
 	In addition to branch names, populate the log message with
 	one-line descriptions from the actual commits that are being
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ef7bf44..adc1a75 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -779,7 +779,7 @@ _git_merge ()
 		;;
 	--*)
 		__gitcomp "
-			--no-commit --no-stat --no-summary --log --no-log
+			--no-commit --no-stat --log --no-log
 			--squash --strategy
 			"
 		return
diff --git a/git-merge.sh b/git-merge.sh
index 4cda3ec..f0b764f 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -10,8 +10,8 @@ git-merge [options] <msg> HEAD <remote>
 --
 stat                 show a diffstat at the end of the merge
 n,no-stat            don't show a diffstat at the end of the merge
-summary              equivalent to --stat
-no-summary           equivalent to --no-stat
+summary              deprecated equivalent of --stat
+no-summary           deprecated equivalent of --no-stat
 log                  add list of one-line log to merge commit message
 no-log               don't add list of one-line log to merge commit me=
ssage
 squash               create a single commit instead of doing a merge
--=20
1.5.5.76.g546c
