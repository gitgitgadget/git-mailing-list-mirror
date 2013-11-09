From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 50/86] builtin/clone: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:43 +0100
Message-ID: <20131109070720.18178.10765.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gB-0003oQ-Ea
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933286Ab3KIHJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:56 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65404 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933284Ab3KIHIl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:41 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id AF09F9F;
	Sat,  9 Nov 2013 08:08:40 +0100 (CET)
X-git-sha1: 858d58f5a33f5333f722cd97ba0267305d7d9fbf 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237507>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 84fb1bd..49b7a08 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -508,7 +508,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
 {
 	const struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
-		if (prefixcmp(ref->name, "refs/tags/"))
+		if (!has_prefix(ref->name, "refs/tags/"))
 			continue;
 		if (has_suffix(ref->name, "^{}"))
 			continue;
@@ -578,7 +578,7 @@ static void update_remote_refs(const struct ref *refs,
 static void update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
-	if (our && !prefixcmp(our->name, "refs/heads/")) {
+	if (our && has_prefix(our->name, "refs/heads/")) {
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
@@ -625,7 +625,7 @@ static int checkout(void)
 		if (advice_detached_head)
 			detach_advice(sha1_to_hex(sha1));
 	} else {
-		if (prefixcmp(head, "refs/heads/"))
+		if (!has_prefix(head, "refs/heads/"))
 			die(_("HEAD not found below refs/heads!"));
 	}
 	free(head);
-- 
1.8.4.1.566.geca833c
