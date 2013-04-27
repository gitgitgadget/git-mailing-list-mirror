From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] merge-tree: fix typo in "both changed identically"
Date: Sat, 27 Apr 2013 14:03:43 +0100
Message-ID: <51cbc79a9b250544a8365980d078601dfcd2b782.1367067799.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 15:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW4nT-0007Mg-Aw
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 15:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935Ab3D0NEE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Apr 2013 09:04:04 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:44615 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab3D0NED (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 09:04:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 12C9ACDA5B0;
	Sat, 27 Apr 2013 14:04:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8l13-XmaxDFr; Sat, 27 Apr 2013 14:04:00 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EB002CDA580;
	Sat, 27 Apr 2013 14:03:54 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.715.gb260f47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222642>

Commit aacecc3 (merge-tree: don't print entries that match "local" -
2013-04-07) had a typo causing the "same in both" check to be incorrect
and check if both the base and "their" versions are empty instead of
checking that both the "our" and "their" versions are empty.  Fix this.

Reported-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/merge-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ed25d81..ec49917 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -302,7 +302,7 @@ static void unresolved(const struct traverse_info *=
info, struct name_entry n[3])
 static int threeway_callback(int n, unsigned long mask, unsigned long =
dirmask, struct name_entry *entry, struct traverse_info *info)
 {
 	/* Same in both? */
-	if (same_entry(entry+1, entry+2) || both_empty(entry+0, entry+2)) {
+	if (same_entry(entry+1, entry+2) || both_empty(entry+1, entry+2)) {
 		/* Modified, added or removed identically */
 		resolve(info, NULL, entry+1);
 		return mask;
--=20
1.8.2.1.715.gb260f47
