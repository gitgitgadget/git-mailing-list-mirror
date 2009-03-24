From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/9] builtin-apply: use warning() instead of fprintf(stderr, "warning: ")
Date: Tue, 24 Mar 2009 02:09:10 +0100
Message-ID: <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
 <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:10:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llv9d-0006Vh-S6
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbZCXBIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754761AbZCXBI3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:29 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57050 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbZCXBIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:24 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 17FE129406E;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 90F11186220; Tue, 24 Mar 2009 02:09:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114373>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-apply.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index b52aa20..1926cd8 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2451,7 +2451,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	if ((st_mode ^ patch->old_mode) & S_IFMT)
 		return error("%s: wrong type", old_name);
 	if (st_mode != patch->old_mode)
-		fprintf(stderr, "warning: %s has type %o, expected %o\n",
+		warning("%s has type %o, expected %o",
 			old_name, st_mode, patch->old_mode);
 	if (!patch->new_mode && !patch->is_delete)
 		patch->new_mode = st_mode;
@@ -2932,8 +2932,7 @@ static int write_out_one_reject(struct patch *patch)
 	cnt = strlen(patch->new_name);
 	if (ARRAY_SIZE(namebuf) <= cnt + 5) {
 		cnt = ARRAY_SIZE(namebuf) - 5;
-		fprintf(stderr,
-			"warning: truncating .rej filename to %.*s.rej",
+		warning("truncating .rej filename to %.*s.rej",
 			cnt - 1, patch->new_name);
 	}
 	memcpy(namebuf, patch->new_name, cnt);
@@ -3315,8 +3314,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		    squelch_whitespace_errors < whitespace_error) {
 			int squelched =
 				whitespace_error - squelch_whitespace_errors;
-			fprintf(stderr, "warning: squelched %d "
-				"whitespace error%s\n",
+			warning("squelched %d "
+				"whitespace error%s",
 				squelched,
 				squelched == 1 ? "" : "s");
 		}
@@ -3326,12 +3325,12 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			    whitespace_error == 1 ? "" : "s",
 			    whitespace_error == 1 ? "s" : "");
 		if (applied_after_fixing_ws && apply)
-			fprintf(stderr, "warning: %d line%s applied after"
-				" fixing whitespace errors.\n",
+			warning("%d line%s applied after"
+				" fixing whitespace errors.",
 				applied_after_fixing_ws,
 				applied_after_fixing_ws == 1 ? "" : "s");
 		else if (whitespace_error)
-			fprintf(stderr, "warning: %d line%s add%s whitespace errors.\n",
+			warning("%d line%s add%s whitespace errors.",
 				whitespace_error,
 				whitespace_error == 1 ? "" : "s",
 				whitespace_error == 1 ? "s" : "");
-- 
1.6.2
