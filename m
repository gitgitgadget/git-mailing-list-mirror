Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D419C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbiBGVdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240896AbiBGVdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:33:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09DDC061A73
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:33:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m14so27098062wrg.12
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 13:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D3bNaELIYHVf+nC7o47wgpqMZkoLpv+hq4KgoP47X2w=;
        b=NCeBzv/iRYFDJfCqRMDJbFvRL/uP3DXjHzAsurjoJxcQDdgNcOu2owOpCmQASBrZt0
         /k5+mVy5vbPP90mFvKzpuLUOUAzOWZbJWmImSE2/khD1VPFOxnTQIIKTpD2w7HeRm+IQ
         9HRN1OYH0a0HH7H83qA0tfPe84Oedg/pu6z+ImSZQeMsyAGGYyLQ9Nn3b/eQ2xxuaMyW
         0l+hnFxqKqOPe6VuYGwuy7RW0u9eKUlXWh+ITvmnCcghgWgTHa18sEAdB4nXENJrFNIu
         MExbBIvYtoBxCieyxKBouprJelBU+wIGY9Z764xCMm3/LbYrkAXrGNqv1D54mC6t7IDZ
         Ra4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D3bNaELIYHVf+nC7o47wgpqMZkoLpv+hq4KgoP47X2w=;
        b=8QXd+gMtooDYTWYdq037rlrfzQiJZPZh+ra3nywTHNVDpbj20PMWil+82kvc+NebCQ
         gsDWETwDHZtbtMmMYqKS8EkqXsfHX8aVzJRr88PxP+xZWZG0l7yRygG2GuwFT37gNCjR
         GDrWZy2SwmZyPuDwVVNhHeR6qiPIkYzwPpWhre0C0HlKuyMo36q5HPA5N5SgnxyZrp00
         lRjyeoiGjPK84XwTASu0G6W2m0ZyJqIRKN67QGiPvk2jOraPMXtIHCTboSfn2+jqRbgI
         fKsP4TROqIvI5yyj3j9Etv64bBq2VL/IznNFZv+IPU8+KoJiKYFJwALEFXzG5s2DNNPa
         8mGw==
X-Gm-Message-State: AOAM532hcgKddwAiHOwkzazQxDlXv5XkFOwS9bN6hVKLF5sGBiSh3aaN
        XS38xoH+4x17FNLxUNc2TZ+rRSc5RCI=
X-Google-Smtp-Source: ABdhPJxZmUFqpwVSTWO8XyMpJq6WmL0Dy3SNvlTyH/WqMBzPJVjMm/Mk3BOZWJ4eJfZe5BrKhZZvTw==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr1031713wrx.336.1644269587185;
        Mon, 07 Feb 2022 13:33:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13sm11080607wrv.24.2022.02.07.13.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:33:06 -0800 (PST)
Message-Id: <5d0cc242d92c68bf239f9e17eab9c80ec6b2d469.1644269583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 21:32:59 +0000
Subject: [PATCH v6 2/6] worktree: create init_worktree_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Upgrading a repository to use extensions.worktreeConfig is non-trivial.
There are several steps involved, including moving some config settings
from the common config file to the main worktree's config.worktree file.
The previous change updated the documentation with all of these details.

Commands such as 'git sparse-checkout set' upgrade the repository to use
extensions.worktreeConfig without following these steps, causing some
user pain in some special cases.

Create a helper method, init_worktree_config(), that will be used in a
later change to fix this behavior within 'git sparse-checkout set'. The
method is carefully documented in worktree.h.

Note that we do _not_ upgrade the repository format version to 1 during
this process. The worktree config extension must be considered by Git
and third-party tools even if core.repositoryFormatVersion is 0 for
historical reasons documented in 11664196ac ("Revert
"check_repository_format_gently(): refuse extensions for old
repositories"", 2020-07-15). This is a special case for this extension,
and newer extensions (such as extensions.objectFormat) still need to
upgrade the repository format version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 worktree.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h | 21 ++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/worktree.c b/worktree.c
index 6f598dcfcdf..5292c94b3d9 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,6 +5,7 @@
 #include "worktree.h"
 #include "dir.h"
 #include "wt-status.h"
+#include "config.h"
 
 void free_worktrees(struct worktree **worktrees)
 {
@@ -826,3 +827,75 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 	*wtpath = path;
 	return 0;
 }
+
+static int move_config_setting(const char *key, const char *value,
+			       const char *from_file, const char *to_file)
+{
+	if (git_config_set_in_file_gently(to_file, key, value))
+		return error(_("unable to set %s in '%s'"), key, to_file);
+	if (git_config_set_in_file_gently(from_file, key, NULL))
+		return error(_("unable to unset %s in '%s'"), key, from_file);
+	return 0;
+}
+
+int init_worktree_config(struct repository *r)
+{
+	int res = 0;
+	int bare = 0;
+	struct config_set cs = { { 0 } };
+	const char *core_worktree;
+	char *common_config_file;
+	char *main_worktree_file;
+
+	/*
+	 * If the extension is already enabled, then we can skip the
+	 * upgrade process.
+	 */
+	if (repository_format_worktree_config)
+		return 0;
+	if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
+		return error(_("failed to set extensions.worktreeConfig setting"));
+
+	common_config_file = xstrfmt("%s/config", r->commondir);
+	main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
+
+	git_configset_init(&cs);
+	git_configset_add_file(&cs, common_config_file);
+
+	/*
+	 * If core.bare is true in the common config file, then we need to
+	 * move it to the main worktree's config file or it will break all
+	 * worktrees. If it is false, then leave it in place because it
+	 * _could_ be negating a global core.bare=true.
+	 */
+	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
+		if ((res = move_config_setting("core.bare", "true",
+					       common_config_file,
+					       main_worktree_file)))
+			goto cleanup;
+	}
+	/*
+	 * If core.worktree is set, then the main worktree is located
+	 * somewhere different than the parent of the common Git dir.
+	 * Relocate that value to avoid breaking all worktrees with this
+	 * upgrade to worktree config.
+	 */
+	if (!git_configset_get_value(&cs, "core.worktree", &core_worktree)) {
+		if ((res = move_config_setting("core.worktree", core_worktree,
+					       common_config_file,
+					       main_worktree_file)))
+			goto cleanup;
+	}
+
+	/*
+	 * Ensure that we use worktree config for the remaining lifetime
+	 * of the current process.
+	 */
+	repository_format_worktree_config = 1;
+
+cleanup:
+	git_configset_clear(&cs);
+	free(common_config_file);
+	free(main_worktree_file);
+	return res;
+}
diff --git a/worktree.h b/worktree.h
index 9e06fcbdf3d..e9e839926b0 100644
--- a/worktree.h
+++ b/worktree.h
@@ -183,4 +183,25 @@ void strbuf_worktree_ref(const struct worktree *wt,
 			 struct strbuf *sb,
 			 const char *refname);
 
+/**
+ * Enable worktree config for the first time. This will make the following
+ * adjustments:
+ *
+ * 1. Add extensions.worktreeConfig=true in the common config file.
+ *
+ * 2. If the common config file has a core.worktree value, then that value
+ *    is moved to the main worktree's config.worktree file.
+ *
+ * 3. If the common config file has a core.bare enabled, then that value
+ *    is moved to the main worktree's config.worktree file.
+ *
+ * If extensions.worktreeConfig is already true, then this method
+ * terminates early without any of the above steps. The existing config
+ * arrangement is assumed to be intentional.
+ *
+ * Returns 0 on success. Reports an error message and returns non-zero
+ * if any of these steps fail.
+ */
+int init_worktree_config(struct repository *r);
+
 #endif
-- 
gitgitgadget

