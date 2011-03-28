From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Fix two unused variable warnings in gcc 4.6
Date: Sun, 27 Mar 2011 20:32:19 -0500
Message-ID: <1301275939-17018-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 03:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q41Jo-0004rr-42
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 03:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab1C1Bc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 21:32:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45736 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab1C1Bc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 21:32:26 -0400
Received: by gyd10 with SMTP id 10so741656gyd.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=CFqWbFvVAFjg+3i3sbPGzGIdFqppWsxavG5J+cp6Cwk=;
        b=xJFPqrA89spT6ZGk6EtW6sjL6gOKm7ZTUhf+g9Ea7d1/tuX/3ZYUDCh3waqc8PRKbv
         eWFVJF/KwMnhaclOHUYpMngDyRz+bJWRWcUTBozhRROu83/gjhiwKLKOXOjJh0U3DpAw
         2RcjSiysCUl7vhgqRsGQpaEwaKAEnM0+oz21g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=e19xrXgBytAAsHJesmrHkufme0MaYzRGTrOVkuXK8V2aVXJvO8XBjmeVA5goKWgNqd
         rkIIgQ0x57LQ3Hs1axjT5xs/q6onX5HwORfhcLw+DZwk1Egx4oRMywWGWBZmAhhasv/E
         ws7nEJJBvbMMnlmvcr6nr9/UKPf0p7vPJ2a0g=
Received: by 10.236.79.197 with SMTP id i45mr4253252yhe.382.1301275945413;
        Sun, 27 Mar 2011 18:32:25 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id h63sm1683931yhm.86.2011.03.27.18.32.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 18:32:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170096>

Seen with -Wunused-but-set-variable.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 http-fetch.c      |    3 +--
 merge-recursive.c |    4 ----
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 923904f..3af4c71 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -8,7 +8,6 @@ static const char http_fetch_usage[] = "git http-fetch "
 
 int main(int argc, const char **argv)
 {
-	const char *prefix;
 	struct walker *walker;
 	int commits_on_stdin = 0;
 	int commits;
@@ -60,7 +59,7 @@ int main(int argc, const char **argv)
 	if (argv[arg])
 		str_end_url_with_slash(argv[arg], &url);
 
-	prefix = setup_git_directory();
+	setup_git_directory();
 
 	git_config(git_default_config, NULL);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 8e82a8b..af13150 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -356,7 +356,6 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	 */
 	const char *last_file = NULL;
 	int last_len = 0;
-	struct stage_data *last_e;
 	int i;
 
 	for (i = 0; i < entries->nr; i++) {
@@ -386,7 +385,6 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 		if (S_ISREG(e->stages[2].mode) || S_ISLNK(e->stages[2].mode)) {
 			last_file = path;
 			last_len = len;
-			last_e = e;
 		} else {
 			last_file = NULL;
 		}
@@ -961,7 +959,6 @@ static int process_renames(struct merge_options *o,
 	}
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
-		char *src;
 		struct string_list *renames1, *renames2Dst;
 		struct rename *ren1 = NULL, *ren2 = NULL;
 		const char *branch1, *branch2;
@@ -996,7 +993,6 @@ static int process_renames(struct merge_options *o,
 			ren2 = ren1;
 			ren1 = tmp;
 		}
-		src = ren1->pair->one->path;
 
 		ren1->dst_entry->processed = 1;
 		ren1->src_entry->processed = 1;
-- 
1.7.4.1
