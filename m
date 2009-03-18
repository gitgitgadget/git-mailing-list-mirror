From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 3/3] rebase: add options passed to git-am
Date: Wed, 18 Mar 2009 19:05:58 +0100
Message-ID: <1237399558-27289-3-git-send-email-barra_cuda@katamail.com>
References: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 18:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk03M-0000s2-Nb
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbZCRR5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbZCRR5g
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:57:36 -0400
Received: from smtp.katamail.com ([62.149.157.154]:53125 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755368AbZCRR5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:57:34 -0400
Received: (qmail 21856 invoked by uid 89); 18 Mar 2009 17:57:26 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.57.140)
  by smtp2-pc with SMTP; 18 Mar 2009 17:57:25 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
In-Reply-To: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113641>

Add the options --committer-date-is-author-date and --ignore-date
to git-rebase. They were introduced in commit a79ec62d0 for git-am.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

I'm not sure if force_rebase should be set in this case.

 Documentation/git-rebase.txt |    5 +++++
 git-rebase.sh                |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6cb902a..457340c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -269,6 +269,11 @@ OPTIONS
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
index e38d68a..d89d71c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -309,6 +309,9 @@ do
 			;;
 		esac
 		;;
+	--committer-date-is-author-date|--ignore-date)
+		git_am_opt="$git_am_opt $1"
+		;;
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
-- 
1.6.2.22.gc2ac
