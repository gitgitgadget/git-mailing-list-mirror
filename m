From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/2] git-fsck: remove commit test already done by parse_commit_buffer
Date: Sun, 13 Jan 2008 19:11:10 +0100
Message-ID: <1200247870151-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12002478702664-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 19:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE7JH-00008V-7B
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 19:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYAMSLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 13:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbYAMSLN
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 13:11:13 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:35898 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbYAMSLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 13:11:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 974A6680BF60;
	Sun, 13 Jan 2008 19:11:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YHZD74DiTf-4; Sun, 13 Jan 2008 19:11:10 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 6E347680BED1; Sun, 13 Jan 2008 19:11:10 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12002478702664-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70402>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index e4874f6..a77d8c0 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -360,18 +360,6 @@ static int fsck_commit(struct commit *commit)
 		fprintf(stderr, "Checking commit %s\n",
 			sha1_to_hex(commit->object.sha1));
 
-	if (memcmp(buffer, "tree ", 5))
-		return objerror(&commit->object, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
-		return objerror(&commit->object, "invalid 'tree' line format - bad sha1");
-	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
-		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
-			return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
-		buffer += 48;
-	}
-	if (memcmp(buffer, "author ", 7))
-		return objerror(&commit->object, "invalid format - expected 'author' line");
 	free(commit->buffer);
 	commit->buffer = NULL;
 	if (!commit->tree)
-- 
1.4.4.4
