From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 25/86] notes: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:18 +0100
Message-ID: <20131109070720.18178.81030.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hC-0004uI-Vg
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359Ab3KIHKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:55 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54163 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933267Ab3KIHIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:34 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 2AAF479;
	Sat,  9 Nov 2013 08:08:30 +0100 (CET)
X-git-sha1: 4aec6e899fc26b25b0cd5164cd5a0ee4deca919c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237528>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 notes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/notes.c b/notes.c
index b69c0b8..e23d38a 100644
--- a/notes.c
+++ b/notes.c
@@ -1243,9 +1243,9 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
 			strbuf_addstr(sb, "\nNotes:\n");
 		} else {
-			if (!prefixcmp(ref, "refs/"))
+			if (has_prefix(ref, "refs/"))
 				ref += 5;
-			if (!prefixcmp(ref, "notes/"))
+			if (has_prefix(ref, "notes/"))
 				ref += 6;
 			strbuf_addf(sb, "\nNotes (%s):\n", ref);
 		}
@@ -1293,9 +1293,9 @@ int copy_note(struct notes_tree *t,
 
 void expand_notes_ref(struct strbuf *sb)
 {
-	if (!prefixcmp(sb->buf, "refs/notes/"))
+	if (has_prefix(sb->buf, "refs/notes/"))
 		return; /* we're happy */
-	else if (!prefixcmp(sb->buf, "notes/"))
+	else if (has_prefix(sb->buf, "notes/"))
 		strbuf_insert(sb, 0, "refs/", 5);
 	else
 		strbuf_insert(sb, 0, "refs/notes/", 11);
-- 
1.8.4.1.566.geca833c
