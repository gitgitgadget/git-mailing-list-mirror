From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 3/5] git-branch: introduce missing long forms for the options
Date: Sun, 28 Aug 2011 16:54:30 +0200
Message-ID: <fd5a9fe2fba27100a15136717dddccb54eb0b674.1314543252.git.git@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 16:55:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxglN-000078-QC
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 16:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab1H1Oyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 10:54:51 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35382 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037Ab1H1Oyn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 10:54:43 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6E88A20ED8;
	Sun, 28 Aug 2011 10:54:43 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 28 Aug 2011 10:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Wp
	DnGoiUHax+b0A10GmGYKydMnA=; b=s4JWJCseUVGALg0msKQ1tDfPkFnRNPwoUl
	+JACtV38QYHcFr1Owfn0Ej8zFStqJJghMUGAxh1mdgFK9QWQ9zVpV0rJSEaHadkz
	ZswNemPUDdWuHbFOnXQZBX5nxOnkYAl7QCrdibRjEN2h+7W0KfglcTXlh1BgkjtI
	TxA1kAqos=
X-Sasl-enc: MnhkWwwZyoCjuZ7LrdnJ616LgC5TWJDIykKA4QIkfPg1 1314543282
Received: from localhost (p54859364.dip0.t-ipconnect.de [84.133.147.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 95094A00251;
	Sun, 28 Aug 2011 10:54:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <cover.1314367414.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1314543252.git.git@drmicha.warpmail.net>
References: <cover.1314543252.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180272>

Long forms are better to memorize and more reliably uniform across
commands.

Names follow precedents, e.g. "git log --remotes".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I'm somewhat torn between --move and --rename for -m. We have no real precedent
besides "git remote rename".

I left out -M and -D because I feel they should really be -m -f resp. -d -f.
---
 Documentation/git-branch.txt |    5 +++++
 builtin/branch.c             |   10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 507b8d0..4c64ac9 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -64,6 +64,7 @@ way to clean up all obsolete remote-tracking branches.
 OPTIONS
 -------
 -d::
+--delete::
 	Delete a branch. The branch must be fully merged in its
 	upstream branch, or in `HEAD` if no upstream was set with
 	`--track` or `--set-upstream`.
@@ -72,6 +73,7 @@ OPTIONS
 	Delete a branch irrespective of its merged status.
 
 -l::
+--create-reflog::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
@@ -84,6 +86,7 @@ OPTIONS
 	already. Without `-f` 'git branch' refuses to change an existing branch.
 
 -m::
+--move::
 	Move/rename a branch and the corresponding reflog.
 
 -M::
@@ -100,9 +103,11 @@ OPTIONS
 	Same as `--color=never`.
 
 -r::
+--remotes::
 	List or delete (if used with -d) the remote-tracking branches.
 
 -a::
+--all::
 	List both remote-tracking branches and local branches.
 
 -v::
diff --git a/builtin/branch.c b/builtin/branch.c
index aa705a0..94e41ae 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -624,7 +624,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
 			BRANCH_TRACK_OVERRIDE),
 		OPT__COLOR(&branch_use_color, "use colored output"),
-		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
+		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
 		{
 			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
@@ -641,13 +641,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__ABBREV(&abbrev),
 
 		OPT_GROUP("Specific git-branch actions:"),
-		OPT_SET_INT('a', NULL, &kinds, "list both remote-tracking and local branches",
+		OPT_SET_INT('a', "all", &kinds, "list both remote-tracking and local branches",
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
-		OPT_BIT('d', NULL, &delete, "delete fully merged branch", 1),
+		OPT_BIT('d', "delete", &delete, "delete fully merged branch", 1),
 		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
-		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
+		OPT_BIT('m', "move", &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
-		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
+		OPT_BOOLEAN('l', "create-reflog", &reflog, "create the branch's reflog"),
 		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
-- 
1.7.6.845.gc3c05
