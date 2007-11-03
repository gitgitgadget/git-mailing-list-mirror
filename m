From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/2] Small code readability improvement in show_reference() in builtin-tag.c
Date: Sat,  3 Nov 2007 14:08:05 +0100
Message-ID: <1194095285-18651-2-git-send-email-mh@glandium.org>
References: <Pine.LNX.4.64.0711031219530.4362@racer.site>
 <1194095285-18651-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 14:09:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoIkf-0000O1-FD
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbXKCNJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbXKCNJF
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:09:05 -0400
Received: from vawad.err.no ([85.19.200.177]:56529 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbXKCNJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:09:03 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoIkA-0003dL-N9; Sat, 03 Nov 2007 14:08:57 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoIjN-0004rY-OQ; Sat, 03 Nov 2007 14:08:05 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1194095285-18651-1-git-send-email-mh@glandium.org>
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63260>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 builtin-tag.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index e57f57f..3ed5759 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -84,14 +84,13 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		sp = buf = read_sha1_file(sha1, &type, &size);
 		if (!buf)
 			return 0;
-		if (!size) {
+		/* skip header */
+		sp = strstr(buf, "\n\n");
+
+		if (!sp || !size) {
 			free(buf);
 			return 0;
 		}
-		/* skip header */
-		while (sp + 1 < buf + size &&
-				!(sp[0] == '\n' && sp[1] == '\n'))
-			sp++;
 		/* only take up to "lines" lines, and strip the signature */
 		for (i = 0, sp += 2;
 				i < filter->lines && sp < buf + size &&
-- 
1.5.3.5
