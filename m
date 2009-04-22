From: andy@petdance.com
Subject: [PATCH 2/2] Applying const to arg for rev_is_head(). Localized a work variable.
Date: Wed, 22 Apr 2009 01:00:37 -0500
Message-ID: <1240380037-24785-2-git-send-email-andy@petdance.com>
References: <1240380037-24785-1-git-send-email-andy@petdance.com>
Cc: gitster@pobox.com, Andy Lester <andy@petdance.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 08:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwVyX-0000GY-P7
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 08:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbZDVG2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 02:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbZDVG2y
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 02:28:54 -0400
Received: from uniqua.petdance.com ([64.81.227.163]:51497 "EHLO
	uniqua.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbZDVG2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 02:28:54 -0400
X-Greylist: delayed 1695 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2009 02:28:53 EDT
Received: by uniqua.petdance.com (Postfix, from userid 500)
	id EBAA15CD0113; Wed, 22 Apr 2009 01:00:37 -0500 (CDT)
X-Mailer: git-send-email 1.6.2.4
In-Reply-To: <1240380037-24785-1-git-send-email-andy@petdance.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117177>

From: Andy Lester <andy@petdance.com>

---
 builtin-show-branch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 828e6f8..549f99a 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -261,7 +261,6 @@ static void show_one_commit(struct commit *commit, int no_name)
 {
 	struct strbuf pretty = STRBUF_INIT;
 	const char *pretty_str = "(unavailable)";
-	struct commit_name *name = commit->util;
 
 	if (commit->object.parsed) {
 		pretty_print_commit(CMIT_FMT_ONELINE, commit,
@@ -272,6 +271,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 		pretty_str += 8;
 
 	if (!no_name) {
+		struct commit_name *name = commit->util;
 		if (name && name->head_name) {
 			printf("[%s", name->head_name);
 			if (name->generation) {
@@ -456,7 +456,7 @@ static void snarf_refs(int head, int remotes)
 	}
 }
 
-static int rev_is_head(char *head, int headlen, char *name,
+static int rev_is_head(const char *head, int headlen, const char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
 	if ((!head[0]) ||
@@ -548,7 +548,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
+static int omit_in_dense(const struct commit *commit, struct commit **rev, int n)
 {
 	/* If the commit is tip of the named branches, do not
 	 * omit it.
-- 
1.6.2.4
