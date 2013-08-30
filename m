From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2 1/8] reset: rename update_refs to reset_refs
Date: Fri, 30 Aug 2013 14:11:59 -0400
Message-ID: <ce57e08b2fe53b23ba3627bc8a9e0cc44a7683e2.1377885441.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 20:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFTCi-0007cv-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab3H3SNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 14:13:48 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:50946 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755037Ab3H3SNq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 14:13:46 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id CB12A9FB89; Fri, 30 Aug 2013 14:12:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377885441.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233452>

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
