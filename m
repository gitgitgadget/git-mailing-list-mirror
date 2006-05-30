From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-status: fix detection of dissappeared files
Date: Tue, 30 May 2006 14:48:53 +0200
Message-ID: <20060530124853.GA26416@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 30 14:49:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl3ee-0001sO-FL
	for gcvg-git@gmane.org; Tue, 30 May 2006 14:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWE3Ms6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 08:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWE3Ms5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 08:48:57 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:36488 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932273AbWE3Ms5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 08:48:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 17A5877000A;
	Tue, 30 May 2006 14:48:56 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13821-08; Tue, 30 May 2006 14:48:54 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 022E3770009;
	Tue, 30 May 2006 14:48:54 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2F3606DF823; Tue, 30 May 2006 14:45:44 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id DF20962563; Tue, 30 May 2006 14:48:53 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21029>

fatal: ambiguous argument 'manual.txt': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
diff --git a/cg-status b/cg-status
index e2f97dd..aee5ff0 100755
--- a/cg-status
+++ b/cg-status
@@ -239,7 +239,7 @@ if [ "$workstatus" ]; then
 		git-diff-index HEAD -- "${basepath:-.}" | cut -f5- -d' ' | 
 		while IFS=$'\t' read -r mode file; do
 			if [ "$mode" = D ]; then
-				[ "$(git-diff-files "$file")" ] && mode=!
+				[ "$(git-diff-files -- "$file")" ] && mode=!
 			elif [ "$mode" = M ] && [ "$commitignore" ]; then
 				fgrep -qx "$file" "$_git/commit-ignore" && mode=m
 			fi


-- 
Jonas Fonseca
