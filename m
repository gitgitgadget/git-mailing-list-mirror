From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/86] config: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:02 +0100
Message-ID: <20131109070720.18178.11881.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hn-0005cp-3E
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372Ab3KIHL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:27 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36282 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933226Ab3KIHIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:24 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 36219A6;
	Sat,  9 Nov 2013 08:08:23 +0100 (CET)
X-git-sha1: 4e4ecf8fafa02d689ce196dca410a0ba9e3ee281 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237535>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 config.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index e1d66a1..8d5d70c 100644
--- a/config.c
+++ b/config.c
@@ -969,25 +969,25 @@ static int git_default_mailmap_config(const char *var, const char *value)
 
 int git_default_config(const char *var, const char *value, void *dummy)
 {
-	if (!prefixcmp(var, "core."))
+	if (has_prefix(var, "core."))
 		return git_default_core_config(var, value);
 
-	if (!prefixcmp(var, "user."))
+	if (has_prefix(var, "user."))
 		return git_ident_config(var, value, dummy);
 
-	if (!prefixcmp(var, "i18n."))
+	if (has_prefix(var, "i18n."))
 		return git_default_i18n_config(var, value);
 
-	if (!prefixcmp(var, "branch."))
+	if (has_prefix(var, "branch."))
 		return git_default_branch_config(var, value);
 
-	if (!prefixcmp(var, "push."))
+	if (has_prefix(var, "push."))
 		return git_default_push_config(var, value);
 
-	if (!prefixcmp(var, "mailmap."))
+	if (has_prefix(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
-	if (!prefixcmp(var, "advice."))
+	if (has_prefix(var, "advice."))
 		return git_default_advice_config(var, value);
 
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
@@ -1872,7 +1872,7 @@ int parse_config_key(const char *var,
 	const char *dot;
 
 	/* Does it start with "section." ? */
-	if (prefixcmp(var, section) || var[section_len] != '.')
+	if (!has_prefix(var, section) || var[section_len] != '.')
 		return -1;
 
 	/*
-- 
1.8.4.1.566.geca833c
