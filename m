From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 4/4] completion: complete `git push --force-with-lease=`
Date: Sat, 19 Jul 2014 10:45:57 +0100
Message-ID: <ead0ead00ac48f0a8fc316c0e5fa0b8fd04477c3.1405763157.git.john@keeping.me.uk>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 11:46:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8RDs-0007zI-1p
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 11:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758259AbaGSJq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 05:46:29 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:41696 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757969AbaGSJq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 05:46:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9F6B9CDA3A8;
	Sat, 19 Jul 2014 10:46:28 +0100 (BST)
X-Quarantine-ID: <u+5pbAPWBJrm>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u+5pbAPWBJrm; Sat, 19 Jul 2014 10:46:28 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 6AC16CDA54D;
	Sat, 19 Jul 2014 10:46:22 +0100 (BST)
X-Mailer: git-send-email 2.0.1.472.g6f92e5f.dirty
In-Reply-To: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
In-Reply-To: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253872>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9dcc222..ad0e75c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1621,6 +1621,22 @@ _git_pull ()
 
 __git_push_recurse_submodules="check on-demand"
 
+__git_complete_force_with_lease ()
+{
+	local cur_=$1
+
+	case "$cur_" in
+	--*=)
+		;;
+	*:*)
+		__gitcomp_nl "$(__git_refs)" "" "${cur_#*:}"
+		;;
+	*)
+		__gitcomp_nl "$(__git_refs)" "" "$cur_"
+		;;
+	esac
+}
+
 _git_push ()
 {
 	case "$prev" in
@@ -1634,6 +1650,10 @@ _git_push ()
 		;;
 	esac
 	case "$cur" in
+	--force-with-lease=*)
+		__git_complete_force_with_lease "${cur##--force-with-lease=}"
+		return
+		;;
 	--repo=*)
 		__gitcomp_nl "$(__git_remotes)" "" "${cur##--repo=}"
 		return
@@ -1647,7 +1667,7 @@ _git_push ()
 			--all --mirror --tags --dry-run --force --verbose
 			--quiet --prune --delete --follow-tags
 			--receive-pack= --repo= --set-upstream
-			--recurse-submodules=
+			--force-with-lease --force-with-lease= --recurse-submodules=
 		"
 		return
 		;;
-- 
2.0.1.472.g6f92e5f.dirty
