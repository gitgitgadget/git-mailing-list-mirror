Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E145D20450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbdKBGxO (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:53:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44111 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdKBGxN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:53:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id x7so3906357pfa.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/nmrCcfQmFReVvHeXtc9FWa6kBJ1A6hw5EanObAmsIA=;
        b=au+UI1ebZK/4A084FWSQ7hPyIIj/VdbGmxlB/7Li1Uh0PzW7EBecJ+Qa+sU2j4YXaL
         4k6bL8icTCSl9Ktg3DjUsL85g6SAKhPiNLgSEs3+V0s1yCH79mX1Pm0dupZMoAUlPdUZ
         yHlDqCWuMCQQb6slmrWfsZTpPQKmtP6uP35p9VBTrZjgbb7Q5QGvo5wcdERiI0k2B1OX
         Et6kh5UALe8viTc/6kWzLwYQ3Z+mcfjI/tySh1ETmCRTefOzGazfJwaVG96iJ4g6LV0e
         Hio5oc88tzxBSbv3yr6v0wHT6NkkAkA91Oraf+6zBzpVe7p7VMZIMBHVMimjEXGVJy2X
         o5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/nmrCcfQmFReVvHeXtc9FWa6kBJ1A6hw5EanObAmsIA=;
        b=cwViIP8w1iu+G6pHjhCHH3gyD1m+hlFGRF32XyysRNdGOkOSo2ytm8n6k1AzU5jF1H
         ALbhTcEzR7Ao4O7SY++zkt25ogotuaJ7HHKUW+7MJHLClwoz9MZWDDmbcydp/DJJ8xno
         FJ4nJonQNfDNqHMDEVhdVwSfXZVQ+Y7capXkWTjdmpQ7xl5W35RDzk6rjfZoFyWZiu7j
         wzm0Mb2ksThQuZahRH8W0K75pUbLaV5e9HRjAFmorYOGJfoM32hYmaflXwZ891tqNeQy
         WoyPLM9s79A+zfm7ilnyPWfFGtsk4ZC9d57s0AIK5MaYhADeARcmNP835d81swQmtwfi
         Be/Q==
X-Gm-Message-State: AMCzsaUQI46zHeBrHU2KKkoqwFx80alTKtEVAawSJf3a83r+ysWHU/6u
        ugKGRNMCxEAvaOoS+g64lGlQgpvBtig=
X-Google-Smtp-Source: ABhQp+RsbcpkwZnkGDgSL0iVWE8NXrCpMmhYWWwPcUMVx9+Nh30yT7qjVxjY13Uxfgd3FKfwpErDMA==
X-Received: by 10.84.174.1 with SMTP id q1mr2251794plb.220.1509605592143;
        Wed, 01 Nov 2017 23:53:12 -0700 (PDT)
Received: from localhost.localdomain ([117.245.109.9])
        by smtp.gmail.com with ESMTPSA id p4sm3879871pga.58.2017.11.01.23.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 23:53:11 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [RFC PATCH v3 4/4] builtin/branch: give more useful error messages when renaming
Date:   Thu,  2 Nov 2017 12:22:42 +0530
Message-Id: <20171102065242.25299-5-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
In-Reply-To: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
References: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

When trying to rename an inexistent branch to with a name of a branch
that already exists the rename failed specifying the new branch name
exists rather than specifying that the branch trying to be renamed
doesn't exist.

    $ git branch -m tset master
    fatal: A branch named 'master' already exists.

It's conventional to report that 'tset' doesn't exist rather than
reporting that 'master' exists, the same way the 'mv' command does.

    (hypothetical)
    $ git branch -m tset master
    fatal: branch 'tset' doesn't exist.

That has the problem that the error about an existing branch is shown
only after the user corrects the error about inexistent branch.

    $ git branch -m test master
    fatal: A branch named 'master' already exists.

This isn't useful either because the user would have corrected this error in
a single go if he had been told this alongside the first error. So, give
more useful error messages by giving errors about old branch name and new
branch name at the same time. This is possible as the branch name validation
functions now return the reason they were about to die, when requested.

    $ git branch -m tset master
    fatal: branch 'tset' doesn't exist, and branch 'master' already exists

Note: Thanks to the strbuf API that made it possible to easily construct
the composite error message strings!

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/branch.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7018e5d75..c2bbf8c3d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -458,11 +458,42 @@ static void reject_rebase_or_bisect_branch(const char *target)
 	free_worktrees(worktrees);
 }
 
+static void get_error_msg(struct strbuf* error_msg, const char* oldname, unsigned old_branch_exists,
+			  const char* newname, enum branch_validation_result res)
+{
+	const char* connector_string = _(", and ");
+
+	if (!old_branch_exists) {
+		strbuf_addf(error_msg, _("branch '%s' doesn't exist"), oldname);
+	}
+
+	switch (res) {
+		case BRANCH_EXISTS_NO_FORCE:
+			strbuf_addf(error_msg, "%s", (!old_branch_exists) ? connector_string : "");
+			strbuf_addf(error_msg,_("branch '%s' already exists"), newname);
+			break;
+		case CANNOT_FORCE_UPDATE_CURRENT_BRANCH:
+			strbuf_addf(error_msg, "%s", (!old_branch_exists) ? connector_string : "");
+			strbuf_addstr(error_msg, _("cannot force update the current branch"));
+			break;
+		case INVALID_BRANCH_NAME:
+			strbuf_addf(error_msg, "%s", (!old_branch_exists) ? connector_string : "");
+			strbuf_addf(error_msg, _("branch name '%s' is invalid"), newname);
+			break;
+		/* not necessary to handle success cases */
+		case BRANCH_EXISTS:
+		case BRANCH_DOESNT_EXIST:
+			break;
+	}
+}
+
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	int recovery = 0;
+	struct strbuf error_msg = STRBUF_INIT, empty = STRBUF_INIT;
+	enum branch_validation_result res;
 
 	if (!oldname) {
 		if (copy)
@@ -471,15 +502,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("cannot rename the current branch while not on any."));
 	}
 
-	if (strbuf_check_branch_ref(&oldref, oldname)) {
+	if (strbuf_check_branch_ref(&oldref, oldname) && ref_exists(oldref.buf))
+	{
 		/*
 		 * Bad name --- this could be an attempt to rename a
 		 * ref that we used to allow to be created by accident.
 		 */
-		if (ref_exists(oldref.buf))
-			recovery = 1;
-		else
-			die(_("Invalid branch name: '%s'"), oldname);
+		recovery = 1;
 	}
 
 	/*
@@ -487,9 +516,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
 	 */
 	if (!strcmp(oldname, newname))
-		validate_branchname(newname, &newref, 0);
+		res = validate_branchname(newname, &newref, 1);
 	else
-		validate_new_branchname(newname, &newref, force, 0);
+		res = validate_new_branchname(newname, &newref, force, 1);
+
+	get_error_msg(&error_msg, oldname, ref_exists(oldref.buf), newname, res);
+	if (strbuf_cmp(&error_msg, &empty))
+		die("%s", error_msg.buf);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
@@ -530,6 +563,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		die(_("Branch is copied, but update of config-file failed"));
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
+	strbuf_release(&error_msg);
+	strbuf_release(&empty);
 }
 
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
-- 
2.15.0.461.gf957c703b.dirty

