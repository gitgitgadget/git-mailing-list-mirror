From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH] Advertise the ability to abort a commit
Date: Tue, 29 Jul 2008 21:32:05 +0200
Message-ID: <1217359925-30130-1-git-send-email-mail@cup.kalibalik.dk>
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 21:33:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNuwY-0000cw-Qb
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbYG2TcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYG2TcJ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:32:09 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:55600 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbYG2TcI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:32:08 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 3913314062;
	Tue, 29 Jul 2008 21:32:05 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 1294E1405A;
	Tue, 29 Jul 2008 21:32:05 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90672>

This treats aborting a commit more like a feature.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 builtin-commit.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 9a11ca0..75eeb4b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -555,6 +555,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		fprintf(fp,
 			"\n"
 			"# Please enter the commit message for your changes.\n"
+			"# To abort the commit, use an empty commit message.\n"
 			"# (Comment lines starting with '#' will ");
 		if (cleanup_mode == CLEANUP_ALL)
 			fprintf(fp, "not be included)\n");
@@ -1003,7 +1004,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
-		die("no commit message?  aborting commit.");
+		die("no commit message.  aborting commit.");
 	}
 	strbuf_addch(&sb, '\0');
 	if (is_encoding_utf8(git_commit_encoding) && !is_utf8(sb.buf))
-- 
1.5.6.4
