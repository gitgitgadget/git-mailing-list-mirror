Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71802C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 19:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354593AbiE0T4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354550AbiE0T42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 15:56:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FAACE2F
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e2so7249893wrc.1
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ala9tS8IfxqLwnCV6jlS9X3ZEVB0A9mxBthk1ojPRkg=;
        b=DgREg4B1oz3v/qDjAbd0E8Es+SdgnLxHxSTmx8yOBELl/AR6l0qHcxW79KYmGQN5P/
         fvj/GqDDOfubIApW2o1SOXOLs/nBAQCKasZxNwsYhBniolvniiTKcOfvftmxjrPTz14e
         aWhv9hbr0sbaEeiL31qfWxdUIoEDzDWV5jZWjvuF8oeRr61xQEzQH7X2zfOo1CstGH5g
         7uOybIWVHA40C+mlYyvTW335Kj7nj2RFGQQjev9KEU3PwiAVT289IEWWPZ+9rkeH6s1d
         uf7cY7jroiSQ5+NTtXw8HgBU22vUm+6fOXmCdJoXo/v74UG/6PtF884Symwr31m7yuxe
         eVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ala9tS8IfxqLwnCV6jlS9X3ZEVB0A9mxBthk1ojPRkg=;
        b=6DjRTKZYT3LaH4l89wHCVQgCb8XuHfIJzhHd6/ABzYIB4skd4vA1Fu/I1XmQklH0Ka
         vdG+XpDIZIvQYBs529QH8r2AikGqtfgho5AfEP17gdowf+GXzKQejfJFB8BHzCamIiB3
         wh6S2ZU+2qZ1/df2e8qA5o9ZkdhkFtzrGKrSxOp8OWBlizgJG0+p7mX5rrer90iQ7YSl
         CxKGI8vfuDBzCnG8FgH4gNjgQae01tGfipyqvWkskytGY/WswMeX2WB4imKMkLNOPBIN
         NlJXjZ8HGcQOQ1e80Dou+UhfTIbduYhtRIhasTlvBFIr59Tg6iFKdoygtDIPw+d691Y/
         YcEQ==
X-Gm-Message-State: AOAM530TrhytfgD2yvMR5Nq0XYA9NhTNiRRCZpOswsYQIeG3FPT4ists
        0CdZAtvjp5uS4psCqTNAZuw=
X-Google-Smtp-Source: ABdhPJziPgZw2Ywk8PzaykwB27qF6cDUySzZpjSeUfTyvGfKP5c33KypCT7dFOAJD10V15BmXsnRqg==
X-Received: by 2002:a5d:4eca:0:b0:210:1282:ceb1 with SMTP id s10-20020a5d4eca000000b002101282ceb1mr5648458wrv.357.1653681385853;
        Fri, 27 May 2022 12:56:25 -0700 (PDT)
Received: from jonathan-ubuntu.univ-lyon1.fr (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id 129-20020a1c0287000000b0039748be12dbsm3041350wmc.47.2022.05.27.12.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 12:56:25 -0700 (PDT)
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
To:     git.jonathan.bressat@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, cogoni.guillaume@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, guillaume.cogoni@gmail.com,
        jonathan.bressat@etu.univ-lyon1.fr
Subject: [PATCH v2 4/4] error message now advice to use the new option
Date:   Fri, 27 May 2022 21:55:45 +0200
Message-Id: <20220527195545.33984-5-git.jonathan.bressat@gmail.com>
X-Mailer: git-send-email 2.35.1.10.g88248585b1.dirty
In-Reply-To: <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
 <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When all the untracked files in the working tree have the same content
than the files in merged branch then the error message advice to use
the --overwrite-same-content option.

Signed-off-by: Jonathan Bressat <git.jonathan.bressat@gmail.com>
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 builtin/checkout.c |  1 +
 unpack-trees.c     | 20 ++++++++++++++++----
 unpack-trees.h     |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cc804ba8e1..1b1d1813c7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -760,6 +760,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				       &new_branch_info->commit->object.oid :
 				       &new_branch_info->oid, NULL);
 		topts.preserve_ignored = !opts->overwrite_ignore;
+		topts.overwrite_same_content = 0;/* FIXME: opts->overwrite_same_content */
 		tree = parse_tree_indirect(old_branch_info->commit ?
 					   &old_branch_info->commit->object.oid :
 					   the_hash_algo->empty_tree);
diff --git a/unpack-trees.c b/unpack-trees.c
index 1a52be723e..6c660b084b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -158,17 +158,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be overwritten by checkout:\n%%s"
-			  "Please move or remove them before you switch branches.")
+			  "Please move or remove them before you switch branches.%%s")
 		      : _("The following untracked working tree files would be overwritten by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be overwritten by merge:\n%%s"
-			  "Please move or remove them before you merge.")
+			  "Please move or remove them before you merge.%%s")
 		      : _("The following untracked working tree files would be overwritten by merge:\n%%s");
 	else
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
-			  "Please move or remove them before you %s.")
+			  "Please move or remove them before you %s.%%s")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =
 		strvec_pushf(&opts->msgs_to_free, msg, cmd, cmd);
@@ -251,6 +251,14 @@ static void display_error_msgs(struct unpack_trees_options *o)
 {
 	int e;
 	unsigned error_displayed = 0;
+	const char *can_overwrite_msg;
+
+	if (o->can_overwrite) {
+		can_overwrite_msg = _("\nYou can also rerun the command with --overwrite-same-content to overwrite files with same content.");
+	} else {
+		can_overwrite_msg = "";
+	}
+
 	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
 		struct string_list *rejects = &o->unpack_rejects[e];
 
@@ -261,7 +269,8 @@ static void display_error_msgs(struct unpack_trees_options *o)
 			error_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
-			error(ERRORMSG(o, e), super_prefixed(path.buf));
+
+			error(ERRORMSG(o, e), super_prefixed(path.buf), can_overwrite_msg);
 			strbuf_release(&path);
 		}
 		string_list_clear(rejects, 0);
@@ -1711,6 +1720,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	struct pattern_list pl;
 	int free_pattern_list = 0;
 	struct dir_struct dir = DIR_INIT;
+	o->can_overwrite = 1;
 
 	if (o->reset == UNPACK_RESET_INVALID)
 		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
@@ -2261,6 +2271,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		if(o->overwrite_same_content) {
 			return 0;
 		}
+	} else {
+		o->can_overwrite = 0;
 	}
 
 	return add_rejected_path(o, error_type, name);
diff --git a/unpack-trees.h b/unpack-trees.h
index ebe4be0b35..2be74ce5bf 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -72,6 +72,7 @@ struct unpack_trees_options {
 		     exiting_early,
 		     show_all_errors,
 		     overwrite_same_content,
+		     can_overwrite,
 		     dry_run;
 	enum unpack_trees_reset_type reset;
 	const char *prefix;
-- 
2.35.1.10.g88248585b1.dirty

