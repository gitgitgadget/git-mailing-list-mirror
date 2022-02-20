Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C9BC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbiBTRzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:55:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiBTRyy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:54:54 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A014D9EB
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n8so8258582wms.3
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WKsjhKQh9X+EsJy0g/IlxjZL2l4R2BAcspMe0/TGXqM=;
        b=f5RcEPm8kDN8lh5W3SyRJF5FTmxjzCgdgZpoCsIRXotTu7XZokByhHwS3zL/dZHXd8
         j5G+sDoE/Jg7AN7jQnd0dycQvAp2rt6VJzBe7OJY8NhyFHwAtHQ4vwR62aqqBjtvQTI9
         t6YxIqv+/QWMH/YUBmGpwyFyEy/Q8zEK/dlVuKU795FC5SgnFf+SpA7E+3/S5lQH20Qg
         Yz/S4f7Dm35diNtNfcsYQkxi6Nz7MUSUAhs7f8mVJwG27PVQsgRJtLGYpp8+SnBKeP+2
         jfxCX/xNH3vFfLgtaEPPIthV7t3Z5IG9hz4J9HrLIWg4W9k9lYyxzpgMJswNa183of4F
         KBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WKsjhKQh9X+EsJy0g/IlxjZL2l4R2BAcspMe0/TGXqM=;
        b=2mtCYbMONVZu3qLnSHme+1pmKQKVmulpTGSTrYq6P0hEQ2Z970YAYHVDlo264WvV3A
         P/sx0K+znK/pTeU57Y/aCfhRPrTeNiHm2C0nKDP9phyutbz5tCYF4VQS03oWBt/dBuKn
         xSK/1teOT1mBf8rb64lcq6R7zSj+LCUeL/HKsltOUbXdrCtm2BZ8C0PciRuKsLW18tfw
         U62+YW1CIDEamgU9wBq2G+C8XUr5L4NO31aaCx1r9Oq2YRlNxORdmqVIN9NVeavDjvrC
         ypm55uY4jzcWlj+XMF1HGdCLnYEtzDLeHcc6KPjl55HpJVavfLomjJT5PL7qXoln10k2
         BbTw==
X-Gm-Message-State: AOAM53227yc4EBCW+yIVsDWF+b8R4REQWZer7+ys8LQdiYYjfF1PcXkR
        JYRSjY6b7+MjReldQujfp5Ob0OWiF2Y=
X-Google-Smtp-Source: ABdhPJzqQJoJV0H0mLFgj4oQW63HSNG+t4Dhb5bu1Hv2HoTVXdzMu9GRUIklkHvRYwTIt12g2rI0dQ==
X-Received: by 2002:a05:600c:4e13:b0:37b:e449:7afe with SMTP id b19-20020a05600c4e1300b0037be4497afemr15100468wmq.60.1645379670785;
        Sun, 20 Feb 2022 09:54:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm3456843wrr.54.2022.02.20.09.54.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:30 -0800 (PST)
Message-Id: <f8aa87112a85ee2aa263cb2096232f462e76d06c.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:18 +0000
Subject: [PATCH 02/11] worktree: extract copy_filtered_worktree_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This logic was introduced by 5325591 (worktree: copy sparse-checkout
patterns and config on add, 2022-02-07), but some feedback came in that
the add_worktree() method was already too complex. It is better to
extract this logic into a helper method to reduce this complexity.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/worktree.c | 81 ++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7c272078dc9..2771a6dc793 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -236,6 +236,46 @@ static void check_candidate_path(const char *path,
 		die(_("'%s' is a missing but already registered worktree;\nuse '%s -f' to override, or 'prune' or 'remove' to clear"), path, cmd);
 }
 
+static void copy_filtered_worktree_config(const char *worktree_git_dir)
+{
+	char *from_file = git_pathdup("config.worktree");
+	char *to_file = xstrfmt("%s/config.worktree", worktree_git_dir);
+
+	if (file_exists(from_file)) {
+		struct config_set cs = { { 0 } };
+		const char *core_worktree;
+		int bare;
+
+		if (safe_create_leading_directories(to_file) ||
+			copy_file(to_file, from_file, 0666)) {
+			error(_("failed to copy worktree config from '%s' to '%s'"),
+				from_file, to_file);
+			goto worktree_copy_cleanup;
+		}
+
+		git_configset_init(&cs);
+		git_configset_add_file(&cs, from_file);
+
+		if (!git_configset_get_bool(&cs, "core.bare", &bare) &&
+			bare &&
+			git_config_set_multivar_in_file_gently(
+				to_file, "core.bare", NULL, "true", 0))
+			error(_("failed to unset '%s' in '%s'"),
+				"core.bare", to_file);
+		if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
+			git_config_set_in_file_gently(to_file,
+							"core.worktree", NULL))
+			error(_("failed to unset '%s' in '%s'"),
+				"core.worktree", to_file);
+
+		git_configset_clear(&cs);
+	}
+
+worktree_copy_cleanup:
+	free(from_file);
+	free(to_file);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -360,45 +400,8 @@ static int add_worktree(const char *path, const char *refname,
 	 * values from the current worktree into the new one, that way the
 	 * new worktree behaves the same as this one.
 	 */
-	if (repository_format_worktree_config) {
-		char *from_file = git_pathdup("config.worktree");
-		char *to_file = xstrfmt("%s/config.worktree",
-					sb_repo.buf);
-
-		if (file_exists(from_file)) {
-			struct config_set cs = { { 0 } };
-			const char *core_worktree;
-			int bare;
-
-			if (safe_create_leading_directories(to_file) ||
-			    copy_file(to_file, from_file, 0666)) {
-				error(_("failed to copy worktree config from '%s' to '%s'"),
-				      from_file, to_file);
-				goto worktree_copy_cleanup;
-			}
-
-			git_configset_init(&cs);
-			git_configset_add_file(&cs, from_file);
-
-			if (!git_configset_get_bool(&cs, "core.bare", &bare) &&
-			    bare &&
-			    git_config_set_multivar_in_file_gently(
-					to_file, "core.bare", NULL, "true", 0))
-				error(_("failed to unset '%s' in '%s'"),
-				      "core.bare", to_file);
-			if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
-			    git_config_set_in_file_gently(to_file,
-							  "core.worktree", NULL))
-				error(_("failed to unset '%s' in '%s'"),
-				      "core.worktree", to_file);
-
-			git_configset_clear(&cs);
-		}
-
-worktree_copy_cleanup:
-		free(from_file);
-		free(to_file);
-	}
+	if (repository_format_worktree_config)
+		copy_filtered_worktree_config(sb_repo.buf);
 
 	strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
-- 
gitgitgadget

