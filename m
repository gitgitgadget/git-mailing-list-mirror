From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 5/5] fixup! rev-list --min-parents,--max-parents: doc, test and completion
Date: Wed, 23 Mar 2011 10:38:52 +0100
Message-ID: <37bdb92b4ceaa99e45afd446b1c738d00edec602.1300872923.git.git@drmicha.warpmail.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 10:42:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Kad-0008Vn-Km
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 10:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab1CWJmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 05:42:38 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33047 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752978Ab1CWJmh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 05:42:37 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0A4F5202B3;
	Wed, 23 Mar 2011 05:42:37 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 23 Mar 2011 05:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=IfLfP7Co8IEsRjt34mG68Udhn94=; b=QeS+rJedRtygLUCPZwoQtkCHACxSejO9I57k0IE9zhSA0PfcFdX2uLmpDEWPoMXsDett2eJzs+6b06cVvcAV2lvJ3GWPISuAWsYBPlE5XSQ9cmPt5P64Avzn2CZN5oeQpQu6Q4E3CRM6R/xs/q9Abyu+dEzxI5UAgQWFcahLRv8=
X-Sasl-enc: 8EVhg7KQiwM8mLes8nTPuaDd6ER2mMsys/euQRLjyuHf 1300873356
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 556F2408DD7;
	Wed, 23 Mar 2011 05:42:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
In-Reply-To: <20110321105628.GC16334@sigill.intra.peff.net>
In-Reply-To: <cover.1300872923.git.git@drmicha.warpmail.net>
References: <cover.1300872923.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169811>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-list.txt         |    2 ++
 Documentation/rev-list-options.txt     |   13 ++++++++-----
 contrib/completion/git-completion.bash |    1 +
 t/t6009-rev-list-parent.sh             |    4 +++-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index c5ea96f..415f4f0 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -17,7 +17,9 @@ SYNOPSIS
 	     [ \--merges ]
 	     [ \--no-merges ]
 	     [ \--min-parents=<number> ]
+	     [ \--no-min-parents ]
 	     [ \--max-parents=<number> ]
+	     [ \--no-max-parents ]
 	     [ \--first-parent ]
 	     [ \--remove-empty ]
 	     [ \--full-history ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 0bbf7da..ea5c6c4 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -81,14 +81,17 @@ endif::git-rev-list[]
 
 --min-parents=<number>::
 --max-parents=<number>::
+--no-min-parents::
+--no-max-parents::
 
 	Show only commits which have at least (or at most) that many
-	commits, where negative parameters for `--max-parents=` denote
-	infinity (i.e. no upper	limit).
+	commits. In particular, `--max-parents=1` is the same as `--no-merges`,
+	`--min-parents=2` is the same as `--merges`.  `--max-parents=0`
+	gives all root commits and `--min-parents=3` all octopus merges.
 +
-In particular, `--max-parents=1` is the same as `--no-merges`,
-`--min-parents=2` is the same as `--merges`.  `--max-parents=0`
-gives all root commits and `--min-parents=3` all octopus merges.
+`--no-min-parents` and `--no-max-parents` reset these limits (to no limit)
+again.  Equivalent forms are `--min-parents=0` (any commit has 0 or more
+parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 
 --first-parent::
 	Follow only the first parent commit upon seeing a merge
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4da087e..d5215e8 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1578,6 +1578,7 @@ __git_log_common_options="
 	--max-age= --since= --after=
 	--min-age= --until= --before=
 	--min-parents= --max-parents=
+	--no-min-parents --no-max-parents
 "
 # Options that go well for log and gitk (not shortlog)
 __git_log_gitk_options="
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 5309378..fc89d6d 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -107,7 +107,9 @@ test_expect_success 'rev-list override and infinities' '
 	check_revlist "--min-parents=2 --max-parents=1 --max-parents=3" tripus normalmerge &&
 	check_revlist "--min-parents=1 --min-parents=2 --max-parents=7" tetrapus tripus normalmerge &&
 	check_revlist "--min-parents=2 --max-parents=8" tetrapus tripus normalmerge &&
-	check_revlist "--min-parents=2 --max-parents=-1" tetrapus tripus normalmerge
+	check_revlist "--min-parents=2 --max-parents=-1" tetrapus tripus normalmerge &&
+	check_revlist "--min-parents=2 --no-max-parents" tetrapus tripus normalmerge &&
+	check_revlist "--max-parents=0 --min-parents=1 --no-min-parents" one five
 '
 
 test_expect_success 'set up dodecapus' '
-- 
1.7.4.1.511.g72e46
