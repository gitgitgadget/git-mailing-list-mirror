Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423212090B
	for <e@80x24.org>; Tue, 19 Sep 2017 07:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbdISHP7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 03:15:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38364 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdISHP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 03:15:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id a7so8614pfj.5
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wyup3kAwpFN6qp5XMsyFFme6yfvjbLjE50IHxF7j+40=;
        b=QXzuf1OepATRz59uXP4i93EfuXzcaoF10hTXpOBVtaPvJkfM9ukNufrsjEy+zy3jKt
         5C/605brOpIDl/gKuImfU/OKvHbNkymTeEcrSH70XHsFOniQn1amNp/C6gX/9dVSuFzx
         /Ci2bdTFQQVURJzpQuJt6pVMxvNX5gJ5gfXWrMR/TbvMWmCCOQ+d26434SPqv4vMRrUp
         b3NEJl2ehP7BJYVVjWjLFtSm9Ug7EhiJBP0LsqrZPaLKueU0SmKmLgKYayhkAvNnLvlb
         XN7QpOBKpS5obJEfLqBo7kmSKd1dNQjlvlLklBzl5LwUyCK5Bvr8sI6McFzH/oGVpwP1
         6zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wyup3kAwpFN6qp5XMsyFFme6yfvjbLjE50IHxF7j+40=;
        b=msM4y68LWGnzaKNKSksvZEooF5l/bM2+v0UC+8UwTsr4fSi+WmmfjfE8XDV+yIrVix
         YDpr9yv/cUPmpy+Ys2GfgsSykTYoPg683Zpk5WpTO1z2QzLizFvBH/5juQEm1u+14I1t
         /ftfq8gLvw6DY4SJTiJApPyiK9mtdgmSSadp8+X3UpXLJ2shYkQtiNKnt4F20s82MEIe
         mtq4TJegj+sz/fbZPBT3AmLRB0/wg6mK02rx64xIBaKhmSrXgbxR1YwieX6OZ5jUrZTm
         ev6+khdwSqEcAnduQhVZGSu5m2BJ1k7E2C16HJnAWv6uKS7FCw4stCt3MjGgTZ3kRsBJ
         +h2w==
X-Gm-Message-State: AHPjjUjwWlK24Y68R3ZwXg1uJLtdYWjrzrvKV/AuR003SkHTU5AMhpD7
        QnaRiVjCSvjYOCXj3peP5+5lvygkUw0=
X-Google-Smtp-Source: AOwi7QAFDiYv2MaucqJWAzu5dO8O8bL3hkRIEQ0pT9CXlL5enpyBBOgg2PilDy66gQllmid1HNTIGw==
X-Received: by 10.101.83.143 with SMTP id x15mr443322pgq.425.1505805355661;
        Tue, 19 Sep 2017 00:15:55 -0700 (PDT)
Received: from glitch-pc.sce.com ([117.209.170.72])
        by smtp.gmail.com with ESMTPSA id d126sm1927863pgc.85.2017.09.19.00.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 00:15:55 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [RFC PATCH 5/5] builtin/branch: give more useful error messages when renaming
Date:   Tue, 19 Sep 2017 12:45:25 +0530
Message-Id: <20170919071525.9404-6-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.930.g532ff9be2
In-Reply-To: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trying to rename an inexistent branch to an existing branch
the rename failed specifying the new branch name exists rather than
specifying that the branch trying to be renamed doesn't exist.

    $ git branch -m tset master
    fatal: A branch named 'master' already exists.

It's conventional to report that 'tset' doesn't exist rather than
reporting that 'master' exists, the same way the 'mv' command does.

    $ git branch -m tset master
    fatal: branch 'tset' doesn't exist.

That has the problem that the error about an existing branch is shown
only after the user corrects the error about inexistent branch.

    $ git branch -m test master
    fatal: A branch named 'master' already exists.

This isn't useful either because the user would have corrected this error in
a single go if he had been told this alongside the first error. So, give
more useful error messages by giving errors about old branch name and new
branch name at the same time. This is possible as the branch update validation
function now returns the reason it was about to die, when requested.

    $ git branch -m tset master
    fatal: branch 'tset' doesn't exist, and branch 'master' already exists

Note: Thanks to the strbuf API that made it possible to easily construct
the composite error message strings!

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/branch.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 205c12a11..27d24e83d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -456,25 +456,56 @@ static void reject_rebase_or_bisect_branch(const char *target)
 	free_worktrees(worktrees);
 }
 
+static void get_error_msg(struct strbuf* error_msg, const char* oldname, unsigned old_branch_exists,
+			  const char* newname, int new_branch_validation_result)
+{
+	const char* connector_string = ", and ";
+	const unsigned connector_length = 6;
+	unsigned connector_added = 0;
+
+	if (!old_branch_exists) {
+		strbuf_addf(error_msg, _("branch '%s' doesn't exist"), oldname);
+
+		/* add the 'connector_string' and remove it later if it's not needed */
+		strbuf_addstr(error_msg, connector_string);
+		connector_added = 1;
+	}
+
+	switch (new_branch_validation_result) {
+		case BRANCH_EXISTS:
+			strbuf_addf(error_msg, _("branch '%s' already exists"), newname);
+			break;
+		case CANNOT_FORCE_UPDATE_CURRENT_BRANCH:
+			strbuf_addstr(error_msg, _("cannot force update the current branch"));
+			break;
+		case INVALID_BRANCH_NAME:
+			strbuf_addf(error_msg, _("branch name '%s' is invalid"), newname);
+			break;
+		case VALID_BRANCH_NAME:
+		case FORCE_UPDATING_BRANCH:
+			if(connector_added)
+				strbuf_remove(error_msg, error_msg->len-connector_length, connector_length);
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
@@ -483,7 +514,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	 */
 	clobber_head_ok = !strcmp(oldname, newname);
 
-	validate_branch_update(newname, &newref, force, clobber_head_ok, 0);
+	get_error_msg(&error_msg, oldname, ref_exists(oldref.buf),
+			newname, validate_branch_update(newname, &newref, force, clobber_head_ok, 1));
+	if (strbuf_cmp(&error_msg, &empty))
+		die("%s", error_msg.buf);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
@@ -509,6 +543,8 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 		die(_("Branch is renamed, but update of config-file failed"));
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
+	strbuf_release(&error_msg);
+	strbuf_release(&empty);
 }
 
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
-- 
2.14.1.868.g66c78774b

