From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] completion: add missing options for git-merge
Date: Thu, 22 May 2014 14:58:38 +0100
Message-ID: <5cfeac0e9b7fb0ff4a2468f30476152fc93f4c16.1400767118.git.john@keeping.me.uk>
References: <CANu1nikzk-rGjzKv6R-OR6Et-fB-JYnt245+P6NY-RQiihzXyA@mail.gmail.com>
 <e4a536d29a59d7dc89cc2f42fa8339506b4829f1.1400767118.git.john@keeping.me.uk>
Cc: Haralan Dobrev <hkdobrev@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 16:05:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnTcn-0001HH-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 16:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbaEVOFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 10:05:32 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49509 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbaEVOFb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 10:05:31 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 May 2014 10:05:31 EDT
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 60F45606582;
	Thu, 22 May 2014 14:59:01 +0100 (BST)
X-Quarantine-ID: <KMkEQoPXYyte>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KMkEQoPXYyte; Thu, 22 May 2014 14:59:00 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 61A04606534;
	Thu, 22 May 2014 14:58:54 +0100 (BST)
X-Mailer: git-send-email 2.0.0.rc2.4.g1dc51c6
In-Reply-To: <e4a536d29a59d7dc89cc2f42fa8339506b4829f1.1400767118.git.john@keeping.me.uk>
In-Reply-To: <e4a536d29a59d7dc89cc2f42fa8339506b4829f1.1400767118.git.john@keeping.me.uk>
References: <e4a536d29a59d7dc89cc2f42fa8339506b4829f1.1400767118.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249905>

The options added to __git_merge_options are those that git-pull also
understands, since that variable is used by both commands.  Those added
directly in _git_merge() are specific to git-merge and are not
supported by git-pull.

Reported-by: Haralan Dobrev <hkdobrev@gmail.com>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ff97c20..019026e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1476,6 +1476,8 @@ _git_log ()
 __git_merge_options="
 	--no-commit --no-stat --log --no-log --squash --strategy
 	--commit --stat --no-squash --ff --no-ff --ff-only --edit --no-edit
+	--verify-signatures --no-verify-signatures --gpg-sign
+	--quiet --verbose --progress --no-progress
 "
 
 _git_merge ()
@@ -1484,7 +1486,8 @@ _git_merge ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "$__git_merge_options"
+		__gitcomp "$__git_merge_options
+			--rerere-autoupdate --no-rerere-autoupdate --abort"
 		return
 	esac
 	__gitcomp_nl "$(__git_refs)"
-- 
2.0.0.rc2.4.g1dc51c6
