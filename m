From: mhagger@alum.mit.edu
Subject: [PATCH 3/7] fetch-pack.c: rename some parameters from "path" to "refname"
Date: Sat, 11 Feb 2012 07:20:57 +0100
Message-ID: <1328941261-29746-4-git-send-email-mhagger@alum.mit.edu>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 07:21:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw6Kw-0001hy-Kz
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 07:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab2BKGV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 01:21:26 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50476 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2BKGVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 01:21:23 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED675.dip.t-dialin.net [84.190.214.117])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B6L6CD019131;
	Sat, 11 Feb 2012 07:21:14 +0100
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190487>

From: Michael Haggerty <mhagger@alum.mit.edu>

The parameters denote reference names, which are no longer 1:1 with
filesystem paths.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 6207ecd..9bd2096 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -58,9 +58,9 @@ static void rev_list_push(struct commit *commit, int mark)
 	}
 }
 
-static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int rev_list_insert_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(sha1), path, 0);
+	struct object *o = deref_tag(parse_object(sha1), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		rev_list_push((struct commit *)o, SEEN);
@@ -68,9 +68,9 @@ static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int
 	return 0;
 }
 
-static int clear_marks(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int clear_marks(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(sha1), path, 0);
+	struct object *o = deref_tag(parse_object(sha1), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		clear_commit_marks((struct commit *)o,
@@ -493,7 +493,7 @@ done:
 
 static struct commit_list *complete;
 
-static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int mark_complete(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 
-- 
1.7.9
