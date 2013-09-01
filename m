From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/6] push: trivial reorganization
Date: Sun,  1 Sep 2013 03:26:37 -0500
Message-ID: <1378024002-26190-2-git-send-email-felipe.contreras@gmail.com>
References: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 10:32:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG34o-0001DU-4v
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 10:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab3IAIbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 04:31:47 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:63792 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab3IAIbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 04:31:31 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so4094917oag.16
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uUoXFhRRHYPEgrKXJyq0R6HZ4VVyL9WjLQfd9CdmYeQ=;
        b=hjNBvJOBYJP4P0TplOjZwMjK6zioAgGTyA7hRA4/OVJoszbjEgRJbg5lJ1nUcVNGlj
         2yReaeP0TRN0I1dEpP/nUtV53lvIENVDrOLFwECT9608NPbDvXaa0DoJ/g5Pt7FhUgdg
         f7N2srkVxUFO4Mi5DPq0pQWN0R7Sbd1Pd5TI5RHM6ULSOm2rdvmME580lQwHZTVEBvBB
         e0F+/RlkktFGcKuRI3RRrz7dcov5ydXSaEbbtcTDpsUQ+332Hgl5VJp0wVJvCbk7ptsJ
         O29Hl2E6n140H43jxahVdm2sOCtxwc9BMMTo/hNqHX4HWEZjxFlWdE9GNvmVo4eEzScH
         aTcg==
X-Received: by 10.60.83.46 with SMTP id n14mr11648251oey.34.1378024287334;
        Sun, 01 Sep 2013 01:31:27 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm7753907oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 01:31:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233578>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 04f0eaf..5dc06a3 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -113,20 +113,11 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	    remote->name, branch->name, advice_maybe);
 }
 
-static const char message_detached_head_die[] =
-	N_("You are not currently on a branch.\n"
-	   "To push the history leading to the current (detached HEAD)\n"
-	   "state now, use\n"
-	   "\n"
-	   "    git push %s HEAD:<name-of-remote-branch>\n");
-
 static void setup_push_upstream(struct remote *remote, struct branch *branch,
 				int triangular)
 {
 	struct strbuf refspec = STRBUF_INIT;
 
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
@@ -156,8 +147,6 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
 {
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	add_refspec(branch->name);
 }
 
@@ -191,9 +180,23 @@ static int is_workflow_triangular(struct remote *remote)
 	return (fetch_remote && fetch_remote != remote);
 }
 
-static void setup_default_push_refspecs(struct remote *remote)
+static const char message_detached_head_die[] =
+	N_("You are not currently on a branch.\n"
+	   "To push the history leading to the current (detached HEAD)\n"
+	   "state now, use\n"
+	   "\n"
+	   "    git push %s HEAD:<name-of-remote-branch>\n");
+
+static struct branch *get_current_branch(struct remote *remote)
 {
 	struct branch *branch = branch_get(NULL);
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+	return branch;
+}
+
+static void setup_default_push_refspecs(struct remote *remote)
+{
 	int triangular = is_workflow_triangular(remote);
 
 	switch (push_default) {
@@ -208,17 +211,17 @@ static void setup_default_push_refspecs(struct remote *remote)
 
 	case PUSH_DEFAULT_SIMPLE:
 		if (triangular)
-			setup_push_current(remote, branch);
+			setup_push_current(remote, get_current_branch(remote));
 		else
-			setup_push_upstream(remote, branch, triangular);
+			setup_push_upstream(remote, get_current_branch(remote), triangular);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, branch, triangular);
+		setup_push_upstream(remote, get_current_branch(remote), triangular);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		setup_push_current(remote, branch);
+		setup_push_current(remote, get_current_branch(remote));
 		break;
 
 	case PUSH_DEFAULT_NOTHING:
-- 
1.8.4-337-g7358a66-dirty
