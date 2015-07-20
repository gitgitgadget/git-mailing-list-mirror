From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] config: rename "gc.pruneWorktreesExpire" to "gc.worktreePruneExpire"
Date: Mon, 20 Jul 2015 01:29:22 -0400
Message-ID: <1437370162-8031-6-git-send-email-sunshine@sunshineco.com>
References: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 07:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH3eI-0008Ex-5n
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 07:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbbGTF3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 01:29:54 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38393 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbbGTF3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 01:29:50 -0400
Received: by iggf3 with SMTP id f3so74105410igg.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sP63pNhD28spXOlzdjD/GGqOqkYeP9C0x6s5SkMAHTE=;
        b=y326ZN/ADG2mjJcOlVjqQGFAl8cfIDBm+K+n94N2FsxDbVwZC+LqBWDjRbzJcSE2vH
         ENmg9DU/j5IkTKjXPeUgIaqJTLtnPqM2eZRO/TcPVFheAXxv4X5gLa/Vpa7BHBG2AcVB
         +bz9+I1Czj1/5xEjDIZ2AYj7g4xntww3gqWfLGoztEBmWDqzzn1txQ8eyiGml51dlzqw
         hy+uZ84nFvujR8zEobzojIwNORd0kU7PVw5AMQrXR8YNEIZ/3ZrfJfXR2RruIP6bdnc8
         J/H/Ttre3r9CWJbwoNlWT+894qFYtsMWez5twFFj8n9xB/kNNrHpz4KqURMwMaD8+VGI
         x5sQ==
X-Received: by 10.107.169.138 with SMTP id f10mr25278438ioj.75.1437370189864;
        Sun, 19 Jul 2015 22:29:49 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm13104584iod.25.2015.07.19.22.29.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 22:29:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.386.g87d813d
In-Reply-To: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274308>

As of df0b6cf (worktree: new place for "git prune --worktrees",
2015-06-29), linked worktree pruning functionality moved from
"git prune --worktrees" to "git worktree prune". Rename the
associated configuration variable accordingly.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I'm not convinced this is worth the churn. Can be easily dropped if not
deemed worthwhile.

 Documentation/config.txt       | 2 +-
 Documentation/git-worktree.txt | 2 +-
 builtin/gc.c                   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 10bc351..746d292 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1291,7 +1291,7 @@ gc.pruneExpire::
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
 
-gc.pruneWorktreesExpire::
+gc.worktreePruneExpire::
 	When 'git gc' is run, it calls
 	'git worktree prune --expire 3.months.ago'.
 	This config variable can be used to set a different grace
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index a6d8ad7..3234459 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -27,7 +27,7 @@ bare repository) and zero or more linked working trees.
 When you are done with a linked working tree you can simply delete it.
 The working tree's administrative files in the repository (see
 "DETAILS" below) will eventually be removed automatically (see
-`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
+`gc.worktreePruneExpire` in linkgit::git-config[1]), or you can run
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 4957c39..bcc75d9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -85,7 +85,7 @@ static void gc_config(void)
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_date_string("gc.pruneexpire", &prune_expire);
-	git_config_date_string("gc.pruneworktreesexpire", &prune_worktrees_expire);
+	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config(git_default_config, NULL);
 }
 
-- 
2.5.0.rc2.386.g87d813d
