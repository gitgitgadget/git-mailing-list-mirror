From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 5/8] bash completion: More completions for 'git stash'
Date: Mon,  4 Aug 2008 23:50:35 -0600
Message-ID: <1217915438-6838-6-git-send-email-lee.marlow@gmail.com>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-2-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-3-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-4-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-5-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 07:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFT7-0007dV-Ir
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 07:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbYHEFu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 01:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbYHEFuw
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 01:50:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:56663 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603AbYHEFur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 01:50:47 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3753909wfd.4
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 22:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1QCzCgnClclvD6YAMXQpN8LGKqIgbRmBu3yQCohcvAQ=;
        b=oLsCSxJdm/yhWl0ruy++pBz41pgxfXO5qkmgL9XjyDIjGb6NateF6hHIsCMJHtK1rr
         PYOV1Kpxf6HHocd2KS/QP6jo6eBxyq2WdSTG/93lf5qpqMMAAKClWG/ydFnSTBvQUSs6
         nnD6PJj6fKP0NQQUqgHCqa6uGlwqK1edxRwSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Eb4w8qnkoi7Et+CV1mhMGTkPs7xwxhQpPPUMIfuHr6MC940YU1aQkeh4jmX3dewNsM
         Lj+bkkMe4WeyzX9nj9BaZYfOyKBh47N1PHd9f1GaQsVjoBL8htl/Ec5c12e1l6wZK2Bj
         vyuQnoRQ01AVWFRRhkvIgcrBWRTrNx7sTD6gU=
Received: by 10.142.177.7 with SMTP id z7mr5281252wfe.15.1217915446874;
        Mon, 04 Aug 2008 22:50:46 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id 32sm10686014wfc.12.2008.08.04.22.50.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 22:50:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
In-Reply-To: <1217915438-6838-5-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91423>

Add branch subcommand to completions and USAGE for git-stash.sh.
Complete stash names for show, apply, drop, pop, and branch.
Add "--index" long option for apply.

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   12 +++++++++++-
 git-stash.sh                           |    2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6a5c4cd..a292cbd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1348,7 +1348,7 @@ _git_show_branch ()
 
 _git_stash ()
 {
-	local subcommands='save list show apply clear drop pop create'
+	local subcommands='save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -1358,6 +1358,16 @@ _git_stash ()
 		save,--*)
 			__gitcomp "--keep-index"
 			;;
+		apply,--*)
+			__gitcomp "--index"
+			;;
+		show,--*|apply,--*|drop,--*|pop,--*|branch,--*)
+			COMPREPLY=()
+			;;
+		show,*|apply,*|drop,*|pop,*|branch,*)
+			__gitcomp "$(git --git-dir="$(__gitdir)" stash list \
+					| sed -n -e 's/:.*//p')"
+			;;
 		*)
 			COMPREPLY=()
 			;;
diff --git a/git-stash.sh b/git-stash.sh
index d4609ed..5ad2c4b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2007, Nanako Shiraishi
 
-USAGE='[  | save | list | show | apply | clear | drop | pop | create ]'
+USAGE='[  | save | list | show | apply | clear | drop | pop | create | branch ]'
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
-- 
1.6.0.rc1.48.g2b6032
