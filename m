From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/5] notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
Date: Sat, 14 Feb 2009 21:23:22 +0100
Message-ID: <69c813ea5c4a3c3f43e729bd59a4064f74e72d66.1234642638.git.trast@student.ethz.ch>
References: <200902142056.42198.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:25:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYR4S-0004Kh-B0
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbZBNUXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZBNUXh
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:23:37 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:27331 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbZBNUXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:23:37 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:34 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:33 +0100
X-Mailer: git-send-email 1.6.2.rc0.296.ge2122
In-Reply-To: <200902142056.42198.trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 20:23:33.0522 (UTC) FILETIME=[1BB2B720:01C98EE2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109917>

This is the order documented in git-config(1), so we should stick to
it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

Same as v1.

 git-notes.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-notes.sh b/git-notes.sh
index 246df65..6859470 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -35,7 +35,8 @@ edit)
 		git cat-file blob :$COMMIT >> "$MESSAGE" 2> /dev/null
 	fi
 
-	${VISUAL:-${EDITOR:-vi}} "$MESSAGE"
+	core_editor="$(git config core.editor)"
+	${GIT_EDITOR:-${core_editor:-${VISUAL:-${EDITOR:-vi}}}} "$MESSAGE"
 
 	grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed
 	mv "$MESSAGE".processed "$MESSAGE"
-- 
1.6.2.rc0.296.ge2122
