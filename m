From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 77/86] builtin/shortlog: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:10 +0100
Message-ID: <20131109070720.18178.54365.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2l0-00014x-57
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933471Ab3KIHOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:32 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33982 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933457Ab3KIHOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:22 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 41B2D61;
	Sat,  9 Nov 2013 08:14:21 +0100 (CET)
X-git-sha1: 0e485f0af61ba4cda2f22880bc9570bca7624f1a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237552>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/shortlog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index c226f76..3f35682 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -65,7 +65,7 @@ static void insert_one_record(struct shortlog *log,
 	eol = strchr(oneline, '\n');
 	if (!eol)
 		eol = oneline + strlen(oneline);
-	if (!prefixcmp(oneline, "[PATCH")) {
+	if (has_prefix(oneline, "[PATCH")) {
 		char *eob = strchr(oneline, ']');
 		if (eob && (!eol || eob < eol))
 			oneline = eob + 1;
@@ -95,7 +95,7 @@ static void read_from_stdin(struct shortlog *log)
 
 	while (fgets(author, sizeof(author), stdin) != NULL) {
 		if (!(author[0] == 'A' || author[0] == 'a') ||
-		    prefixcmp(author + 1, "uthor: "))
+		    !has_prefix(author + 1, "uthor: "))
 			continue;
 		while (fgets(oneline, sizeof(oneline), stdin) &&
 		       oneline[0] != '\n')
@@ -123,7 +123,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		else
 			eol++;
 
-		if (!prefixcmp(buffer, "author "))
+		if (has_prefix(buffer, "author "))
 			author = buffer + 7;
 		buffer = eol;
 	}
-- 
1.8.4.1.566.geca833c
