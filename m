From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/8] builtin-apply: use warning() instead of
	fprintf(stderr, "warning: ")
Date: Thu, 19 Feb 2009 13:53:10 +0100
Message-ID: <4f61642d10063adbff86094e91b1b6e90efabe8e.1235047192.git.vmiklos@frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8QL-0000wW-Ix
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbZBSMxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbZBSMxM
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:53:12 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47440 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774AbZBSMxM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:53:12 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 99DD3580D1;
	Thu, 19 Feb 2009 13:53:11 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5C7EC446A6;
	Thu, 19 Feb 2009 13:53:10 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 891F511B877C; Thu, 19 Feb 2009 13:53:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1235047192.git.vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110686>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-apply.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index f312798..f668825 100644
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
1.6.1
