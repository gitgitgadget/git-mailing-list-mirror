From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3] git-sh-setup: make require_clean_work_tree part of the interface
Date: Tue, 20 Dec 2011 22:42:39 +0100
Message-ID: <b121d918166dea3b578b075ac6b794967c4bdcbe.1324415678.git.trast@student.ethz.ch>
References: <7vd3bjj78h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 22:42:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd7SV-0006Ja-51
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 22:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab1LTVmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 16:42:47 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:28774 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232Ab1LTVmp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 16:42:45 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 22:42:42 +0100
Received: from thomas.inf.ethz.ch (129.132.211.99) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 22:42:43 +0100
X-Mailer: git-send-email 1.7.8.484.gdad4270
In-Reply-To: <7vd3bjj78h.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.211.99]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187530>

92c62a3 (Porcelain scripts: Rewrite cryptic "needs update" error
message, 2010-10-19) refactored git's own checking to a function in
git-sh-setup.  This is a very useful thing for script writers, so
document it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano writes:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > +require_clean_work_tree <action> [<hint>]::
> > +	checks that the working tree associated with the repository
> > +	has no uncommitted changes to tracked files.  Otherwise it
> > +	emits an error message of the form `Cannot <action>:
> > +	<reason>. <hint>`, and dies.  Example:
> 
> Doesn't it also enforce cleanliness on the index, not just the working tree?

Of course.  Here's the "and index" update.

BTW neither gitglossary(7) nor git-cherry-pick(1) get this right.


 Documentation/git-sh-setup.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index a2f346c..eb08ba6 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -68,6 +68,16 @@ require_work_tree_exists::
 	cd_to_toplevel, which is impossible to do if there is no
 	working tree.
 
+require_clean_work_tree <action> [<hint>]::
+	checks that the working tree and index associated with the
+	repository have no uncommitted changes to tracked files.
+	Otherwise it emits an error message of the form `Cannot
+	<action>: <reason>. <hint>`, and dies.  Example:
++
+----------------
+require_clean_work_tree rebase "Please commit or stash them."
+----------------
+
 get_author_ident_from_commit::
 	outputs code for use with eval to set the GIT_AUTHOR_NAME,
 	GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE variables for a given commit.
-- 
1.7.8.484.gdad4270
