From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] completion: add support for 'git blame'
Date: Mon, 27 Jun 2011 17:45:24 +0900
Message-ID: <1309164324-15146-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 27 10:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qb7cd-0005Pc-Ey
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 10:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757047Ab1F0IrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 04:47:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35400 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757344Ab1F0Ipb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 04:45:31 -0400
Received: by pvg12 with SMTP id 12so2727205pvg.19
        for <git@vger.kernel.org>; Mon, 27 Jun 2011 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=OmmrxucGoaLZOAeep3I0EPfMmyu8vtbIo1XuBlPcczU=;
        b=acPN9i4T8Dbikn5jzOrSti+RXrJA7puASioJTEYcWHBrULphY3mV1w9HsXoawSIZHG
         WkHcuEjxobRrsypFyppmSb5OrlRRyEq83spuOSjcPjcUWkPWCIT16mwq0/KNQJ+M9UmC
         X1LVPKR6IVmaHGzXz0KDdbQJrmh3DqhdC+MnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=l+R1f6GXEliYgkzP3QeaHBKbXX2ahWd82Napye86ltqZ/7pgx6UEg9m5DvHQLPjN6W
         T8JzpNT05e+eaf4L9Oegti68N0OCN0e+0VdDVW93GcUaaz83y/oRPBhqQhFHpTUPurJ3
         n2T8Wrb3VAoJ11Ss9dV7hvKuI8c2nEOE+nSHw=
Received: by 10.68.29.130 with SMTP id k2mr2684835pbh.514.1309164330198;
        Mon, 27 Jun 2011 01:45:30 -0700 (PDT)
Received: from localhost.localdomain ([118.176.76.64])
        by mx.google.com with ESMTPS id q5sm694008pbk.26.2011.06.27.01.45.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Jun 2011 01:45:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176345>

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 contrib/completion/git-completion.bash |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5a83090..bebadda 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1118,6 +1118,28 @@ _git_bisect ()
 	esac
 }
 
+_git_blame ()
+{
+	__git_has_doubledash && return
+
+	case "$cur" in
+	--date=*)
+		__gitcomp "$__git_log_date_formats" "" "${cur##--date=}"
+		;;
+	--*)
+		__gitcomp "
+			--incremental --root --show-stats --score-debug
+			--show-name --show-number --porcelain
+			--line-porcelain --show-email --contents
+			--abbrev= --date= --encoding --reverse
+			"
+		;;
+	*)
+		COMPREPLY=()
+		;;
+	esac
+}
+
 _git_branch ()
 {
 	local i c=1 only_local_ref="n" has_r="n"
-- 
1.7.6
