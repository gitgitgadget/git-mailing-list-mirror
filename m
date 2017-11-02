Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F1820450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755300AbdKBGyf (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:54:35 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:55537 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755230AbdKBGy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:54:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id 15so4243147pgc.12
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/nmrCcfQmFReVvHeXtc9FWa6kBJ1A6hw5EanObAmsIA=;
        b=Xjy7rt6RLEijNeN/Tf0Tzt4cTLv3x7DhTJ5JJUYFU952PuDro8f4CzTyZM5cd731eT
         SGr2lChbpqYyLEZAFLdIbTFU3jRwVOoaad8UB04cncXGmlW7sb6BLtnbtU/s1BxeplY/
         dIzxhYdzyyiQhJVYrBqqi860Pe5A7qOPLAKCkLyqq0u/ZGDeOm4EFkrjjDsOGNYhZVIg
         CHKTe8s4+OwNYBSK+Ch+/h7GGwoq67PaVXhFHLHKzykUJNq9XL5Q8snhMfOTyV4Ox+CO
         hqHQIUhxEhzOkZgbhcU7pJv/sLNX5Fgh3ds4QLF+oeESWJyfZc76TuKah4YKRsZx0+7X
         +aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/nmrCcfQmFReVvHeXtc9FWa6kBJ1A6hw5EanObAmsIA=;
        b=PBuQjLm0t60BcIifJ4e1c1xnntf4skmBHHs5VLt6f+CR8TXxnEXidbDdge/dGuzdsh
         mby7h89+JL1RmYWBd3WAw/N8uQy264mcVSyr6fRnGSlGtjfDCi4KFoIm0EpGi/0p7uo4
         +QWPVy+JZK6XW8zUD/pjC2t36XDa0u+rRpxebM18PqTCcLxPsBm0aWiPlhWAitf0UxX1
         CVkN/zGWpPEOvztNxMu04yuuHFI2hspd85h8xV9BaIP1MhnIv4CkkT1dJt8PGGm0H3HW
         ceEPpj+07Kr1S6YYNE3LBzCSjpkc38hlFHl45OFXGlqP6f83okEasF8NOMa+3v7HuhEz
         mZ4g==
X-Gm-Message-State: AMCzsaXEk8RBVd65pFO0pcploPVWcXl42YQIJS4Had/gWgGeAQID67Lg
        AiuLfvPeYs8ug8oRLA0HNyvQ6cd5iKg=
X-Google-Smtp-Source: ABhQp+TewsgIQaOPPbXvMk03FCOBvDjQc9t9rhrkUwjIWuIywgwzrHqiTI77ychwQbhhNIPRNCsKrw==
X-Received: by 10.99.113.92 with SMTP id b28mr2594368pgn.42.1509605667469;
        Wed, 01 Nov 2017 23:54:27 -0700 (PDT)
Received: from localhost.localdomain ([117.243.29.9])
        by smtp.gmail.com with ESMTPSA id q12sm3843567pgn.56.2017.11.01.23.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 23:54:26 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [RFC PATCH v3 4/4] builtin/branch: give more useful error messages when renaming
Date:   Thu,  2 Nov 2017 12:24:07 +0530
Message-Id: <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
In-Reply-To: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
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

