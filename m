From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 29/86] branch: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:22 +0100
Message-ID: <20131109070720.18178.57801.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hA-0004uI-HZ
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933355Ab3KIHKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:50 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54170 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933268Ab3KIHIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:34 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id DD51897;
	Sat,  9 Nov 2013 08:08:31 +0100 (CET)
X-git-sha1: 5fc9a14fdafd1bf4fe5018eb286f0d4e90a71a20 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237526>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 9e6c68e..fc3a61d 100644
--- a/branch.c
+++ b/branch.c
@@ -50,7 +50,7 @@ static int should_setup_rebase(const char *origin)
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = remote + 11;
-	int remote_is_branch = !prefixcmp(remote, "refs/heads/");
+	int remote_is_branch = has_prefix(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
@@ -272,7 +272,7 @@ void create_branch(const char *head,
 		break;
 	case 1:
 		/* Unique completion -- good, only if it is a real branch */
-		if (prefixcmp(real_ref, "refs/heads/") &&
+		if (!has_prefix(real_ref, "refs/heads/") &&
 		    validate_remote_tracking_branch(real_ref)) {
 			if (explicit_tracking)
 				die(_(upstream_not_branch), start_name);
-- 
1.8.4.1.566.geca833c
