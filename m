From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH v3 3/3] rebase: add options passed to git-am
Date: Thu, 19 Mar 2009 16:28:48 +0100
Message-ID: <1237476528-6040-2-git-send-email-barra_cuda@katamail.com>
References: <fabb9a1e0903190401k1127dc8ev7704c8a7bd381c99@mail.gmail.com>
Cc: git@vger.kernel.org
To: srabbelier@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 19 16:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkK4P-0003bI-PA
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbZCSPUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 11:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755538AbZCSPUc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:20:32 -0400
Received: from smtp.katamail.com ([62.149.157.154]:55046 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754982AbZCSPUb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 11:20:31 -0400
Received: (qmail 19378 invoked by uid 89); 19 Mar 2009 15:20:19 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.113)
  by smtp2-pc with SMTP; 19 Mar 2009 15:20:19 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
In-Reply-To: <fabb9a1e0903190401k1127dc8ev7704c8a7bd381c99@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113783>

Add the options --committer-date-is-author-date and --ignore-date
to git-rebase. They were introduced in commit a79ec62d0 for git-am.
These options imply --force-rebase.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 Documentation/git-rebase.txt |    6 ++++++
 git-rebase.sh                |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7ffeec8..592ec76 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -272,6 +272,12 @@ OPTIONS
 	If the flag `fix` (or its equivalent `strip`) is used, it implies
 	--force-rebase.
 
+--committer-date-is-author-date::
+--ignore-date::
+	These flags are passed to 'git-am' to easily change the dates
+	of the rebased commits (see linkgit:git-am[1]).
+	Both imply --force-rebase.
+
 -i::
 --interactive::
 	Make a list of the commits which are about to be rebased.  Let the
diff --git a/git-rebase.sh b/git-rebase.sh
index e38d68a..b83fd3f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -309,6 +309,10 @@ do
 			;;
 		esac
 		;;
+	--committer-date-is-author-date|--ignore-date)
+		git_am_opt="$git_am_opt $1"
+		force_rebase=t
+		;;
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
-- 
1.6.2.22.gc2ac
