From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 33/86] notes-utils: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:26 +0100
Message-ID: <20131109070720.18178.88664.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gZ-0004Ea-Fj
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933342Ab3KIHKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:19 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54114 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933276Ab3KIHIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:38 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 8EDD276;
	Sat,  9 Nov 2013 08:08:33 +0100 (CET)
X-git-sha1: 7687fc2bfa10f8780cc98464aaafba1223dbff42 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237514>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 notes-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes-utils.c b/notes-utils.c
index 9107c37..0a4c3de 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -70,7 +70,7 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
 static int notes_rewrite_config(const char *k, const char *v, void *cb)
 {
 	struct notes_rewrite_cfg *c = cb;
-	if (!prefixcmp(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
+	if (has_prefix(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
 		c->enabled = git_config_bool(k, v);
 		return 0;
 	} else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
@@ -85,7 +85,7 @@ static int notes_rewrite_config(const char *k, const char *v, void *cb)
 	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
 		/* note that a refs/ prefix is implied in the
 		 * underlying for_each_glob_ref */
-		if (!prefixcmp(v, "refs/notes/"))
+		if (has_prefix(v, "refs/notes/"))
 			string_list_add_refs_by_glob(c->refs, v);
 		else
 			warning(_("Refusing to rewrite notes in %s"
-- 
1.8.4.1.566.geca833c
