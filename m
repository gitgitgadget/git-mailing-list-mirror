From: Brian Bourn <ba.bourn@gmail.com>
Subject: [PATCH] [GSoC 2014]diff: Imported dir.h and renamed read_directory()
Date: Tue, 18 Mar 2014 20:35:35 -0400
Message-ID: <CAM+=D-Ac2yL02-6qGQFuV_qz4FKt_6EGwRHk4+MLDnSb5CgucQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 01:35:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ4Tv-0008VC-Go
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 01:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702AbaCSAfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 20:35:36 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53952 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662AbaCSAfg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 20:35:36 -0400
Received: by mail-qa0-f46.google.com with SMTP id i13so7654764qae.5
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2ooZ4NjWd8sRbPjoofUh4H6cg6gFV9Id4KZkJ0s2HwU=;
        b=isix+eeYhwysGF5lT790B9lxSX574BNdQAXwfvzV7jpihvLxTa8enMRGGRBiEg8aVd
         lBg99nNQtgS23hlGMr0AdTdI0oFtZjWBPcekJky+wkIv1SbpPOlvrOUggtjgN5LI2Mek
         +3bzZrWYuT0jMEqqYhRpk6YGhM8LROl46FSZUjEbLWtUuEE6vy+mnlCWVspPLgbGxOGO
         9R8jCQuJFP+3cYKLxBohjcthUCLwTgHaGZkcVtuscuAF0IsHqn2VPSf769JQN6XB0NsH
         5Uv+f8b9pjxOqQa85bUwo+Mx+qn7Zp/cFtb/tzal2qiPoudau39YB+I61VYgaNWtsfho
         QYIA==
X-Received: by 10.224.56.5 with SMTP id w5mr39327165qag.60.1395189335636; Tue,
 18 Mar 2014 17:35:35 -0700 (PDT)
Received: by 10.96.86.38 with HTTP; Tue, 18 Mar 2014 17:35:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244399>

this was done in order to implement the GSoC
Micro project for diff-no-index.c this is the
first patch importing dir.h, for the use of
is_dot_or_dotdot(), and renaming
read_directory() to read_directory_contents()
in order to deal with the conflicting function
in dir.h

Signed-off-by: Brian Bourn <bab2177@columbia.edu>
---

I plan on applying to GSoC 2014

 diff-no-index.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..ba915af 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -10,13 +10,14 @@
 #include "blob.h"
 #include "tag.h"
 #include "diff.h"
+#include "dir.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
 #include "string-list.h"

-static int read_directory(const char *path, struct string_list *list)
+static int read_directory_contents(const char *path, struct string_list *list)
 {
  DIR *dir;
  struct dirent *e;
@@ -107,9 +108,9 @@ static int queue_diff(struct diff_options *o,
  int i1, i2, ret = 0;
  size_t len1 = 0, len2 = 0;

- if (name1 && read_directory(name1, &p1))
+ if (name1 && read_directory_contents(name1, &p1))
  return -1;
- if (name2 && read_directory(name2, &p2)) {
+ if (name2 && read_directory_contents(name2, &p2)) {
  string_list_clear(&p1, 0);
  return -1;
  }
-- 
1.9.0
