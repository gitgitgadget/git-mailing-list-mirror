From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/2] update-index --refresh --porcelain: add missing const
Date: Tue, 22 Feb 2011 22:43:23 +0000
Message-ID: <1298414603-22338-3-git-send-email-avarab@gmail.com>
References: <1298414603-22338-1-git-send-email-avarab@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 23:44:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps0xx-000460-8R
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 23:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab1BVWoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 17:44:18 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:56536 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab1BVWoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 17:44:16 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3819163bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 14:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=iskwBVR1fo3cNzuHbMgKiSHnfdqQJVkKxTYNfpH3nt0=;
        b=dBs2S/0Rq3hlncbW8beICCwHeCof8ZrRrRQFuaLdxV/jYFW93PtZwhVOjwLcvJCuHi
         OYoLfXgfyO0nbcsi+PK8wVH3MA237JmhR5gvwYqn5CYYO+aj4GPe6+dnfiLc8Kd76g30
         2x9VGnLDi+2iKn0693wAKZ+/Tbmx0lIy0zNdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UDm7UzesOwPGGb7MjefoYiKJVIlBjW+7UpFhqZsTgVejJtVU4LwvjsaRqec7hjKMwK
         0i/Ba3cBxabpJVKopuSuIU/xabNKNXTe9hLYsw6Bwo5WH2xo2JE4ecTN5Kq+q2a/3KdY
         yvC4t18Svd+vFa3VlB2u2JtvWFuKsjO9flU58=
Received: by 10.204.24.78 with SMTP id u14mr3053634bkb.171.1298414655871;
        Tue, 22 Feb 2011 14:44:15 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id a17sm4883767bku.11.2011.02.22.14.44.15
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 14:44:15 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298414603-22338-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167588>

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h      |    2 +-
 read-cache.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 3abf895..4a758ba 100644
--- a/cache.h
+++ b/cache.h
@@ -511,7 +511,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
-extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen, char *header_msg);
+extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen, const char *header_msg);
 
 struct lock_file {
 	struct lock_file *next;
diff --git a/read-cache.c b/read-cache.c
index 4f2e890..15b0a73 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1104,7 +1104,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 }
 
 static void show_file(const char * fmt, const char * name, int in_porcelain,
-		      int * first, char *header_msg)
+		      int * first, const char *header_msg)
 {
 	if (in_porcelain && *first && header_msg) {
 		printf("%s\n", header_msg);
@@ -1114,7 +1114,7 @@ static void show_file(const char * fmt, const char * name, int in_porcelain,
 }
 
 int refresh_index(struct index_state *istate, unsigned int flags, const char **pathspec,
-		  char *seen, char *header_msg)
+		  char *seen, const char *header_msg)
 {
 	int i;
 	int has_errors = 0;
-- 
1.7.2.3
