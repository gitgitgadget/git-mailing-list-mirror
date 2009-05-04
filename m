From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/5] completion: add {gui,diff,merge}tool, man, and pager config variables
Date: Sun,  3 May 2009 23:25:32 -0700
Message-ID: <1241418335-18474-2-git-send-email-bebarino@gmail.com>
References: <1241418335-18474-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 04 08:26:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rd9-0004vC-4C
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbZEDGZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 02:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZEDGZx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:25:53 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:48721 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbZEDGZw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 02:25:52 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2971167wfd.4
        for <git@vger.kernel.org>; Sun, 03 May 2009 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=BTSQ4ToSQ8X8xQczPuBm9R+xLujUqasvKCEWJbzyHMA=;
        b=u+Q46fftbNIpYu6nr2+nYHs7l32gdXsX6XJKou+DZCIANQc0QzrsaP8gV8yr9JzxKL
         fGVXaxJRAJ93fNABG0OtSKeoAXiouRYc8IN7zRvIDQ/qDHAp6FPCVoeT+wowPZTRixMJ
         SFP7icWzDsv1UzMSvoPAAafaIZnmmT/ytwWN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dSCwIyx3os+SWgKeRsY/snDEPh3e7/Ppi3lLUs6QMW6sYW+3IcFQEnjy+3bufIzh9E
         whTawViq5bxw+PVP8tEE3AHDNCNPKkJqNN6lQPjgUKS5ke/Mm9Z0YyevJqK2GhtN5q62
         PwZVC6ciNN3Vk3Il4cktk67C7tNfExxx6km2M=
Received: by 10.143.31.4 with SMTP id i4mr2027897wfj.0.1241418352173;
        Sun, 03 May 2009 23:25:52 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 30sm18391257wfa.15.2009.05.03.23.25.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 23:25:51 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 May 2009 23:25:41 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1241418335-18474-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118206>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |   45 ++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 28682a7..ec02b06 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1376,6 +1376,39 @@ _git_config ()
 		__gitcomp "$(__git_heads)" "$pfx" "$cur" "."
 		return
 		;;
+	guitool.*.*)
+		local pfx="${cur%.*}."
+		cur="${cur##*.}"
+		__gitcomp "
+			argprompt cmd confirm needsfile noconsole norescan
+			prompt revprompt revunmerged title
+			" "$pfx" "$cur"
+		return
+		;;
+	difftool.*.*)
+		local pfx="${cur%.*}."
+		cur="${cur##*.}"
+		__gitcomp "cmd path" "$pfx" "$cur"
+		return
+		;;
+	man.*.*)
+		local pfx="${cur%.*}."
+		cur="${cur##*.}"
+		__gitcomp "cmd path" "$pfx" "$cur"
+		return
+		;;
+	mergetool.*.*)
+		local pfx="${cur%.*}."
+		cur="${cur##*.}"
+		__gitcomp "cmd path trustExitCode" "$pfx" "$cur"
+		return
+		;;
+	pager.*)
+		local pfx="${cur%.*}."
+		cur="${cur#*.}"
+		__gitcomp "$(__git_all_commands)" "$pfx" "$cur"
+		return
+		;;
 	remote.*.*)
 		local pfx="${cur%.*}."
 		cur="${cur##*.}"
@@ -1391,6 +1424,12 @@ _git_config ()
 		__gitcomp "$(__git_remotes)" "$pfx" "$cur" "."
 		return
 		;;
+	url.*.*)
+		local pfx="${cur%.*}."
+		cur="${cur##*.}"
+		__gitcomp "insteadof" "$pfx" "$cur"
+		return
+		;;
 	esac
 	__gitcomp "
 		alias.
@@ -1465,6 +1504,7 @@ _git_config ()
 		diff.suppressBlankEmpty
 		diff.tool
 		diff.wordRegex
+		difftool.
 		difftool.prompt
 		fetch.unpackLimit
 		format.attach
@@ -1495,6 +1535,7 @@ _git_config ()
 		gitcvs.enabled
 		gitcvs.logfile
 		gitcvs.usecrlfattr
+		guitool.
 		gui.blamehistoryctx
 		gui.commitmsgwidth
 		gui.copyblamethreshold
@@ -1538,6 +1579,7 @@ _git_config ()
 		log.date
 		log.showroot
 		mailmap.file
+		man.
 		man.viewer
 		merge.conflictstyle
 		merge.log
@@ -1545,6 +1587,7 @@ _git_config ()
 		merge.stat
 		merge.tool
 		merge.verbosity
+		mergetool.
 		mergetool.keepBackup
 		mergetool.prompt
 		pack.compression
@@ -1556,6 +1599,7 @@ _git_config ()
 		pack.threads
 		pack.window
 		pack.windowMemory
+		pager.
 		pull.octopus
 		pull.twohead
 		push.default
@@ -1593,6 +1637,7 @@ _git_config ()
 		status.showUntrackedFiles
 		tar.umask
 		transfer.unpackLimit
+		url.
 		user.email
 		user.name
 		user.signingkey
-- 
1.6.2.3
