From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH v2 3/3] rebase: add options passed to git-am
Date: Wed, 18 Mar 2009 21:53:49 +0100
Message-ID: <1237409629-4289-1-git-send-email-barra_cuda@katamail.com>
References: <7v1vsufzbs.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 18 21:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk2fH-0004gr-Fg
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 21:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbZCRUp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 16:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbZCRUp1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 16:45:27 -0400
Received: from smtp.katamail.com ([62.149.157.154]:53823 "HELO smtp1.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751856AbZCRUp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 16:45:26 -0400
Received: (qmail 24247 invoked by uid 89); 18 Mar 2009 20:45:16 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.228)
  by smtp1-pc with SMTP; 18 Mar 2009 20:45:12 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
In-Reply-To: <7v1vsufzbs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113659>

Add the options --committer-date-is-author-date and --ignore-date
to git-rebase. They were introduced in commit a79ec62d0 for git-am.
These options imply --force-rebase.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 Documentation/git-rebase.txt |    5 +++++
 git-rebase.sh                |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 276f151..3d5a066 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -270,6 +270,11 @@ OPTIONS
 	(see linkgit:git-apply[1]) that applies the patch.
 	Incompatible with the --interactive option.
 
+--committer-date-is-author-date::
+--ignore-date::
+	These flags are passed to 'git-am' to easily change the dates
+	of the rebased commits (see linkgit:git-am[1]).
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
