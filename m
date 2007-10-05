From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Teach core.autocrlf to 'git blame'
Date: Fri,  5 Oct 2007 14:13:31 +0200
Message-ID: <1191586411-7436-1-git-send-email-marius@trolltech.com>
Cc: Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Oct 05 14:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idm4L-0007Rb-GC
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 14:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820AbXJEMOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 08:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755686AbXJEMOE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 08:14:04 -0400
Received: from esparsett.troll.no ([62.70.27.18]:39568 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344AbXJEMOC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 08:14:02 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 29B2274258; Fri,  5 Oct 2007 14:14:01 +0200 (CEST)
Received: from localhost.localdomain (vrang.troll.no [10.3.4.57])
	by esparsett.troll.no (Postfix) with ESMTP
	id 131E274189; Fri,  5 Oct 2007 14:14:01 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.1155.gfe96ee-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60072>

Pass the fake commit through convert_to_git, so that the
file is adjusted for local line-ending convention.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Added missing signoff in the previous mail.

 builtin-blame.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index e3112a2..8432b82 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2059,6 +2059,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die("read error %s from stdin", strerror(errno));
 	}
+	convert_to_git(path, buf.buf, buf.len, &buf);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
-- 
1.5.3.4.1155.gfe96ee-dirty
