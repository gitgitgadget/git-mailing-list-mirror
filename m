From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 04/13] contrib/subtree: Fix Synopsis
Date: Tue,  5 Feb 2013 05:36:50 -0600
Message-ID: <1360064219-28789-5-git-send-email-greened@obbligato.org>
References: <1360064219-28789-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 12:38:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2gr3-0000c5-NO
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 12:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab3BELh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 06:37:59 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:38200 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753967Ab3BELhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 06:37:53 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U2grV-00055A-Ln; Tue, 05 Feb 2013 05:38:54 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360064219-28789-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "David A. Greene" <greened@obbligato.org> Fix the documentation
    of add to show that a repository can be specified along with a commit. Suggested
    by Yann Dirson <dirson@bertin.fr>. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215486>

From: "David A. Greene" <greened@obbligato.org>

Fix the documentation of add to show that a repository can be
specified along with a commit.

Suggested by Yann Dirson <dirson@bertin.fr>.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh  |    6 ++++++
 contrib/subtree/git-subtree.txt |    3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 771f39d..8a23f58 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -9,6 +9,7 @@ if [ $# -eq 0 ]; then
 fi
 OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
+git subtree add   --prefix=<prefix> <repository> <commit>
 git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <refspec...>
 git subtree push  --prefix=<prefix> <repository> <refspec...>
@@ -502,6 +503,11 @@ cmd_add()
 
 	    "cmd_add_commit" "$@"
 	elif [ $# -eq 2 ]; then
+	    # Technically we could accept a refspec here but we're
+	    # just going to turn around and add FETCH_HEAD under the
+	    # specified directory.  Allowing a refspec might be
+	    # misleading because we won't do anything with any other
+	    # branches fetched via the refspec.
 	    git rev-parse -q --verify "$2^{commit}" >/dev/null ||
 	    die "'$2' does not refer to a commit"
 
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index c5bce41..7ba853e 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -9,7 +9,8 @@ git-subtree - Merge subtrees together and split repository into subtrees
 SYNOPSIS
 --------
 [verse]
-'git subtree' add   -P <prefix> <commit>
+'git subtree' add   -P <prefix> <refspec>
+'git subtree' add   -P <prefix> <repository> <refspec>
 'git subtree' pull  -P <prefix> <repository> <refspec...>
 'git subtree' push  -P <prefix> <repository> <refspec...>
 'git subtree' merge -P <prefix> <commit>
-- 
1.7.10.4
