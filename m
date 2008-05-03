From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH] Rename ENT_INEXISTENT to ENT_NONEXISTENT
Date: Sat,  3 May 2008 08:07:18 +0800
Message-ID: <1209773238-25987-1-git-send-email-pkufranky@gmail.com>
References: <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 03 02:08:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js5IQ-0002kk-Nn
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 02:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764588AbYECAHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 20:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765292AbYECAHW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 20:07:22 -0400
Received: from mail.qikoo.org ([60.28.205.235]:35259 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758427AbYECAHW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 20:07:22 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 7E25F470AE; Sat,  3 May 2008 08:07:18 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.117.g73010
In-Reply-To: <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81050>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
> By the way, "inexistent" is a word, but somehow it sounds quite awkward.
> Perhaps one of NONEXISTENT (more common), REMOVED (run_diff_files() takes
> a SILENT_ON_REMOVED option) or or MISSING (update-index --refresh takes an
> IGNORE_MISSING option) is better? 

I prefer nonexistent because removed or missing has the meaning that the
user has removed it. However, it may be not this case (althogh it is at
current time).


 diff-lib.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 72c2a7b..61a1b7c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -339,7 +339,7 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 }
 
 #define ENT_STAGABLE 1
-#define ENT_INEXISTENT 2
+#define ENT_NONEXISTENT 2
 #define ENT_NOTGITDIR 3		/* Existent but not stagable (not a git dir) */
 /*
  * Check the status of a work tree entity
@@ -350,10 +350,10 @@ static int check_work_tree_entity(const struct cache_entry *ce, struct stat *st,
 	if (lstat(ce->name, st) < 0) {
 		if (errno != ENOENT && errno != ENOTDIR)
 			return -1;
-		return ENT_INEXISTENT;
+		return ENT_NONEXISTENT;
 	}
 	if (has_symlink_leading_path(ce->name, symcache))
-		return ENT_INEXISTENT;
+		return ENT_NONEXISTENT;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
 		if (resolve_gitlink_ref(ce->name, "HEAD", sub))
@@ -407,7 +407,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			       sizeof(struct combine_diff_parent)*5);
 
 			changed = check_work_tree_entity(ce, &st, symcache);
-			if (changed != ENT_INEXISTENT)
+			if (changed != ENT_NONEXISTENT)
 				dpath->mode = ce_mode_from_stat(ce, st.st_mode);
 			else {
 				if (changed < 0) {
@@ -471,7 +471,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			continue;
 
 		changed = check_work_tree_entity(ce, &st, symcache);
-		if (changed == ENT_INEXISTENT) {
+		if (changed == ENT_NONEXISTENT) {
 			if (changed < 0) {
 				perror(ce->name);
 				continue;
@@ -531,7 +531,7 @@ static int get_stat_data(struct cache_entry *ce,
 		changed = check_work_tree_entity(ce, &st, cbdata->symcache);
 		if (changed < 0)
 			return -1;
-		else if (changed == ENT_INEXISTENT) {
+		else if (changed == ENT_NONEXISTENT) {
 			if (match_missing) {
 				*sha1p = sha1;
 				*modep = mode;
-- 
1.5.5.1.117.g73010
