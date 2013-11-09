From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 24/86] merge-recursive: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:17 +0100
Message-ID: <20131109070720.18178.95423.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fW-00036C-DC
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785Ab3KIHIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:55 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36319 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933258Ab3KIHIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:31 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id B4E0BAC;
	Sat,  9 Nov 2013 08:08:29 +0100 (CET)
X-git-sha1: 479e55de6d26d619a048700ca79dd0bde1e69c5e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237490>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 merge-recursive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index dbb7104..9043362 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2063,13 +2063,13 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->recursive_variant = MERGE_RECURSIVE_THEIRS;
 	else if (!strcmp(s, "subtree"))
 		o->subtree_shift = "";
-	else if (!prefixcmp(s, "subtree="))
+	else if (has_prefix(s, "subtree="))
 		o->subtree_shift = s + strlen("subtree=");
 	else if (!strcmp(s, "patience"))
 		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
 	else if (!strcmp(s, "histogram"))
 		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
-	else if (!prefixcmp(s, "diff-algorithm=")) {
+	else if (has_prefix(s, "diff-algorithm=")) {
 		long value = parse_algorithm_value(s + strlen("diff-algorithm="));
 		if (value < 0)
 			return -1;
@@ -2088,7 +2088,7 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
 		o->renormalize = 0;
-	else if (!prefixcmp(s, "rename-threshold=")) {
+	else if (has_prefix(s, "rename-threshold=")) {
 		const char *score = s + strlen("rename-threshold=");
 		if ((o->rename_score = parse_rename_score(&score)) == -1 || *score != 0)
 			return -1;
-- 
1.8.4.1.566.geca833c
