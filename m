Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884A020281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934124AbdIYIU6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:20:58 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33291 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933996AbdIYIUy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 04:20:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id i130so4499254pgc.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LHnGf0JtJDAq3zDgHcjEVZUnLQ6VDGMsifz/Xo+UZHY=;
        b=AaA4NAJ+G+skv9jwL70JK1UF9W6EaXra2AyXSr0DxMzBvoCaAWV7E4PuMOvv4Se8lZ
         e/ipbLoFbFw0kZq3k9+MFezpd+hKfG4FUZa+PmHUh4q5f9hnM/X90UlyVEvcBNL+XC6q
         JO5Q+iS7NdHINb+34bOVAsGhQg4zNINAgnGdPr6eJNcT+8tH8Pv1Pq54gMDVFj5UEx+e
         YkMn92U4JMvHgpx/yJI20/CXPoT/8h9hqKOIup0+9lYOYip3Tvmuv+4rKzWp0qFGywN+
         Y1Y6RGVcqplGAjsGHX91c7pC935iAumJ3jaoOCMm1rCbjopkLVzX+woy8UeVpuB9/nw7
         ZzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LHnGf0JtJDAq3zDgHcjEVZUnLQ6VDGMsifz/Xo+UZHY=;
        b=eIWdrfOUv0HHtWnIYTRuO9i2yh2x6nSz090+ugtLQ87qO8bcDVrsrrRBlbRormyI6T
         gPsAxxAZphEpHHtzmmXa4BIYXBT74prA+XpnZov91RwxSg31/r2Rn74xEt8KESgsa36+
         wgstgmzlLdPZDFdcrnUKcAgJfg7jvnWddiWwq41lTkSSgSHlYWi/Py6QHezNrEcutkG0
         +1lRNCoSFIgG2bvHTf5iExSQRcytfsFjIpXIDxZD+4QvmyLrUNxbZTzXO5ZdQuJL8nU+
         3gQb3G3AlDbRYE3V7J3kX7FFW5DWxM5BI6mKhvWNjAWuYpCWEeZy0hDeuTQz5hZ9yLHc
         X5yg==
X-Gm-Message-State: AHPjjUgdYBnZiYx73CgJzm26K1/lMvJf6xnPuvl7CH8yyOum4OyHTN5/
        ZJSnTMqHRz+Cg8SOx6SWuN8=
X-Google-Smtp-Source: AOwi7QB2sRa0hmrYpfFqwfJP943lKX2yzNNKVvwXvylNrFzekjRWLOL4J0ymOSyYN8GVXiEE+ZAawQ==
X-Received: by 10.99.160.65 with SMTP id u1mr6945010pgn.227.1506327654194;
        Mon, 25 Sep 2017 01:20:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700a:bb87:18d5:bb83:9cfe:b5d3])
        by smtp.gmail.com with ESMTPSA id g16sm11469444pfd.6.2017.09.25.01.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2017 01:20:52 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [RFC PATCH v2 5/5] builtin/branch: give more useful error messages when renaming
Date:   Mon, 25 Sep 2017 13:50:24 +0530
Message-Id: <20170925082024.2691-6-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.935.ge2b2bcd8a
In-Reply-To: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
branch name at the same time. This is possible as the branch validation
function now returns the reason it was about to die, when requested.

    $ git branch -m tset master
    fatal: branch 'tset' doesn't exist, and branch 'master' already exists

Note: Thanks to the strbuf API that made it possible to easily construct
the composite error message strings!

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/branch.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 25e3a2f29..0c2017bee 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -456,25 +456,49 @@ static void reject_rebase_or_bisect_branch(const char *target)
 	free_worktrees(worktrees);
 }
 
+static void get_error_msg(struct strbuf* error_msg, const char* oldname, unsigned old_branch_exists,
+			  const char* newname, int new_branch_validation_result)
+{
+	const char* connector_string = _(", and ");
+
+	if (!old_branch_exists) {
+		strbuf_addf(error_msg, _("branch '%s' doesn't exist"), oldname);
+	}
+
+	switch (new_branch_validation_result) {
+		case BRANCH_EXISTS:
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
+	}
+}
+
 static void rename_branch(const char *oldname, const char *newname, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	int recovery = 0;
 	int clobber_head_ok;
+	struct strbuf error_msg = STRBUF_INIT, empty = STRBUF_INIT;
 
 	if (!oldname)
 		die(_("cannot rename the current branch while not on any."));
 
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
@@ -483,7 +507,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	 */
 	clobber_head_ok = !strcmp(oldname, newname);
 
-	validate_branch_creation(newname, &newref, !force, clobber_head_ok, 0);
+	get_error_msg(&error_msg, oldname, ref_exists(oldref.buf),
+			newname, validate_branch_creation(newname, &newref, !force, clobber_head_ok, 1));
+	if (strbuf_cmp(&error_msg, &empty))
+		die("%s", error_msg.buf);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
@@ -509,6 +536,8 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 		die(_("Branch is renamed, but update of config-file failed"));
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
+	strbuf_release(&error_msg);
+	strbuf_release(&empty);
 }
 
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
-- 
2.14.1.935.ge2b2bcd8a

