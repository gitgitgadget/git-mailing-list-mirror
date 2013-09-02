From: Brad King <brad.king@kitware.com>
Subject: [PATCH v3 1/8] reset: rename update_refs to reset_refs
Date: Mon,  2 Sep 2013 13:48:49 -0400
Message-ID: <ce57e08b2fe53b23ba3627bc8a9e0cc44a7683e2.1378142796.git.brad.king@kitware.com>
References: <cover.1377885441.git.brad.king@kitware.com> <cover.1378142795.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 19:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGYH2-000623-Tl
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758858Ab3IBRup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:50:45 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:55769 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758660Ab3IBRuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 13:50:44 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 97D709FB86; Mon,  2 Sep 2013 13:48:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1378142795.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233644>

The function resets refs rather than doing arbitrary updates.
Rename it to allow a future general-purpose update_refs function
to be added.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 builtin/reset.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index afa6e02..789ee48 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -219,7 +219,7 @@ static const char **parse_args(const char **argv, const char *prefix, const char
 	return argv[0] ? get_pathspec(prefix, argv) : NULL;
 }
 
-static int update_refs(const char *rev, const unsigned char *sha1)
+static int reset_refs(const char *rev, const unsigned char *sha1)
 {
 	int update_ref_status;
 	struct strbuf msg = STRBUF_INIT;
@@ -350,7 +350,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (!pathspec && !unborn) {
 		/* Any resets without paths update HEAD to the head being
 		 * switched to, saving the previous head in ORIG_HEAD before. */
-		update_ref_status = update_refs(rev, sha1);
+		update_ref_status = reset_refs(rev, sha1);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
 			print_new_head_line(lookup_commit_reference(sha1));
-- 
1.7.10.4
