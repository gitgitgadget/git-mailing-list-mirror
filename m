From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] stage: remove unused, unreferenced builtin-alias
Date: Mon, 24 Jun 2013 23:42:26 +0530
Message-ID: <1372097546-27721-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:16:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBJ2-0000go-CI
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab3FXSPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:15:53 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:43960 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab3FXSPv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:15:51 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so11378746pbc.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HX/NrsloazNAElXlSO3JvSKk8mlL41oYzSlNQdUbigo=;
        b=XyU5zUC1s85uJ5KZM/nedMcas9+BrgSibI6ZARgbsRa0DKVOWhWwyZxY92g+MBjMF8
         jN0P93sVW06Hf5oBZl+QnNMw1ExDhlD/iJkGz5o/Jc8YigdZG+/teGZ309zyI8Svjtt/
         7Kj8ba5a05OEWHhOHK2wU8E2u126rhqJQeeyXABo2oc8D8XL99TBYzVfIL3nd2CTtg0I
         FpHv64CqsV2wDj7AMoBcPkKjCxNsZNrH9JzDtnLUuPSRm/lx7hSWdyE92z6utqtr7SLw
         zNdGCqxD94Vt1p0CYulr6iYuLhC1TtDkHo947vQppx94kEvFB3JWzRMB9DmFFiJqUVgR
         KoOQ==
X-Received: by 10.68.134.103 with SMTP id pj7mr24579797pbb.171.1372097750664;
        Mon, 24 Jun 2013 11:15:50 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id ue9sm11062496pab.7.2013.06.24.11.15.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 11:15:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.550.g54d55ef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228886>

11920d2 (Add a built-in alias for 'stage' to the 'add' command,
2008-12-01) added a the 'git stage' command which simply calls
cmd_add().  Since then, no references to it have been made anywhere on
the internet; there is no evidence that anyone even knows about its
existence.  It is a long-lost forgotten command that only serves the
purpose of preventing the user from having a custom alias.stage to do
something useful.  Remove it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I just found out about its existence.

 Documentation/git-stage.txt | 23 -----------------------
 Makefile                    |  3 +--
 git.c                       |  1 -
 3 files changed, 1 insertion(+), 26 deletions(-)
 delete mode 100644 Documentation/git-stage.txt

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
deleted file mode 100644
index ba3fe0d..0000000
--- a/Documentation/git-stage.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-git-stage(1)
-==============
-
-NAME
-----
-git-stage - Add file contents to the staging area
-
-
-SYNOPSIS
---------
-[verse]
-'git stage' args...
-
-
-DESCRIPTION
------------
-
-This is a synonym for linkgit:git-add[1].  Please refer to the
-documentation of that command.
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 79f961e..33ea9df 100644
--- a/Makefile
+++ b/Makefile
@@ -597,7 +597,6 @@ BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
 BUILT_INS += git-show$X
-BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
@@ -2527,7 +2526,7 @@ check-docs::
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
 		git-merge-resolve | git-merge-subtree | \
 		git-fsck-objects | git-init-db | \
-		git-remote-* | git-stage | \
+		git-remote-* | \
 		git-?*--?* ) continue ;; \
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
diff --git a/git.c b/git.c
index 4359086..38bffdb 100644
--- a/git.c
+++ b/git.c
@@ -408,7 +408,6 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "show", cmd_show, RUN_SETUP },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
-		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-- 
1.8.3.1.550.g54d55ef
