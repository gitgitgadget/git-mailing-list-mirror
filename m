From: Andrei Dinu <mandrei.dinu@gmail.com>
Subject: [GSoc PATCH 1/3] diff-no-index.c: rename read_directory()
Date: Thu, 20 Mar 2014 21:52:44 +0200
Message-ID: <1395345164-5239-1-git-send-email-mandrei.dinu@gmail.com>
Cc: Andrei Dinu <mandrei.dinu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 20:53:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQj1W-0006Eu-2P
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 20:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759485AbaCTTxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 15:53:00 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:37770 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758618AbaCTTw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 15:52:59 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so1066107eei.14
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hGqaupo87xw0Wsk4131xl7CVTKfmm5ejBdx+qFCyIgI=;
        b=y09RWwcyS7iK0fg4qNIiG80K8ZYJScwoTL3H0ZAMfQvhKk6GYiR8Zju6nKHDE+juQF
         3QipgLsjoAR57CDDQZwPviUIzLYM1UkSW5R4jdn/Gu0TEARRBgCLBRSQxD6ZnKg0ZAtV
         Lfo6XWr65FxDo7Y14sFYX1kxVkonWrnFckzLd/h4Ux2cR8BAEM9wAAHszHmx5BQpZw2N
         op+IUzT3xnPJCqCYtPVdFDovDvwWCs2D4RZ8nKdbaRFES24o9M6u/PM9X4ky6wr5My+V
         BkVehi+ir7PUt6GJ/ESpC7ZKxJwTcQ6+f5V9rp/5FIN9/UvRX3qiyJ1eBPRxcfaDTeiv
         sDfQ==
X-Received: by 10.14.9.195 with SMTP id 43mr11286205eet.89.1395345178772;
        Thu, 20 Mar 2014 12:52:58 -0700 (PDT)
Received: from andrei-K52JT.pub.ro ([141.85.218.212])
        by mx.google.com with ESMTPSA id o5sm6423478eeg.8.2014.03.20.12.52.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 12:52:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244578>


Avoid the conflict between read_directory() from diff-no-index.c and 
read_directory() from "dir.h"

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>

---

 I plan on applying to GSOC 2014

 Submit again on the list for an older bug that I solved, to show you that 
 I received your feedback and I reviewed my code, numbering and partitioning 
 patches style. Thank you!


 diff-no-index.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..5e4a76c 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
 
-static int read_directory(const char *path, struct string_list *list)
+static int read_directory_path(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && read_directory_path(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && read_directory_path(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
-- 
1.7.9.5


>From d54129eacb45b307dacf2b7afebd1da40df17047 Mon Sep 17 00:00:00 2001
From: Andrei Dinu <mandrei.dinu@gmail.com>
Date: Wed, 19 Mar 2014 17:42:08 +0200
Subject: [GSoc PATCH 2/3] diff-no-index.c: read_directory_path() use
 is_dot_or_dotdot().

Implement code so read_directory_path() use is_dot_or_dotdot() from "dir.h"
instead of strcmp().

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>

---

 I plan on applying to GSOC 2014
 diff-no-index.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 5e4a76c..2d1165f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,6 +15,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "string-list.h"
+#include "dir.h"
 
 static int read_directory_path(const char *path, struct string_list *list)
 {
@@ -25,7 +26,7 @@ static int read_directory_path(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (!is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
-- 
1.7.9.5


>From 4843ad23675047163211c68434517c097435ebb7 Mon Sep 17 00:00:00 2001
From: Andrei Dinu <mandrei.dinu@gmail.com>
Date: Wed, 19 Mar 2014 18:01:55 +0200
Subject: [GSoc PATCH 3/3] fsck.c: fsck_tree() now use is_dot_or_dotdot().

Rewrite fsck_tree() to use is_dot_or_dotdot() from "dir.h" instead 
of calling twice strcmp().

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>

---

 I plan on applying to GSOC 2014.

 fsck.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 64bf279..82a55ab 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "fsck.h"
+#include "dir.h"
 
 static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 {
@@ -171,10 +172,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 			has_full_path = 1;
 		if (!*name)
 			has_empty_name = 1;
-		if (!strcmp(name, "."))
-			has_dot = 1;
-		if (!strcmp(name, ".."))
-			has_dotdot = 1;
+		if (is_dot_or_dotdot(name))
+			if (name[1] == '\0')
+				has_dot = 1;
+			else
+				has_dotdot = 1;
 		if (!strcmp(name, ".git"))
 			has_dotgit = 1;
 		has_zero_pad |= *(char *)desc.buffer == '0';
-- 
1.7.9.5
