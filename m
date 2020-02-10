Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3293BC3F68F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0891A208C4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu74TBc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBJAbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32833 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgBJAbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so7265432wmc.0
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LW3c0D8/aZqOlcVV8RbDgbU5zHsLPFMvdmAlQDY17vI=;
        b=Bu74TBc/PIRy/kOk946WI0brT6I3RfzRdl+bDzbCpygNBKwX+U0y/F5XTYpHVX2CwS
         wFeNOM3KKVm+f7V9UYY9VUKh56kbmIKuRS4Jgv51K6ZWPUXpExwrI/gbJZX8vYyqSNR4
         xkKslP2M9+s2BU/ZwsTIUr9W/0tr8pI1EklRZy9tq3AlrYMH4uhjjZLhIDRYUjHNV9fh
         a4gzXk5Pj2P0zb2mDs96EVJGR2a3PMkQuh4bU7z3ecNK3HgtGC8TG+Sh2AFuya/0NFFc
         oPV/YrRlO0ZEs90RLFzTsFMHfQEBJARmUJJBYra6vnqBfWz2DNm/j0PWRzOrD4lP4JnD
         y+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LW3c0D8/aZqOlcVV8RbDgbU5zHsLPFMvdmAlQDY17vI=;
        b=joURKhbvEFctJApQQ67/9yjZpwkugQnf89m/rL0QU2aE0l54D2KdO8h8jVoKsJunIM
         M07UAsXGELlCxEqYF4Vk5Ocrk8+rhFWoTrcRof2YOqdRV1YCxqWBbLcrvs0ERbQSCinO
         B6t5srrJhLuWYhQg8Hw33NG/mxWfDCngMw8ZdNgWm7OtwGh9Arl78ghuFeS8EzRKOeiK
         NEABhjGjo0RXkZIaSM3Eg4kDcPHRWqAUWF6yJcmiRM+3YcUYfautR89xAMKvIy1xhFrv
         XS6Svxomfz9YYkmazd+gSjFPtdN1ZETsVDiVatYnyoPHeLfhegktN/d58s1ozUOq2SHS
         AQMg==
X-Gm-Message-State: APjAAAVGU2DAuncs/qPmMPwY9g3LozEBCwkbuqWIdkqG+okc13WJCxVa
        bLMwKawAu3rF14TtzaQkPGl1zCQG
X-Google-Smtp-Source: APXvYqyOf06i1byvFsEmMAJeT1en8yQt2mPp7+eVj7XpYRO9O/SLUHcgCEZFwSes2LWAlF5GxvzTag==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr11331897wmb.38.1581294665536;
        Sun, 09 Feb 2020 16:31:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm13699596wrr.35.2020.02.09.16.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:05 -0800 (PST)
Message-Id: <1af0237b8e76f0fd84ccac1e29d0cdc326303d7e.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:54 +0000
Subject: [PATCH v7 05/10] config: split repo scope to local and worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

Previously when iterating through git config variables, worktree config
and local config were both considered "CONFIG_SCOPE_REPO".  This was
never a problem before as no one had needed to differentiate between the
two cases, but future functionality may care whether or not the config
options come from a worktree or from the repository's actual local
config file.  For example, the planned feature to add a '--show-scope'
to config to allow a user to see which scope listed config options come
from would confuse users if it just printed 'repo' rather than 'local'
or 'worktree' as the documentation would lead them to expect.  As well
as the additional benefit of making the implementation look more like
how the documentation describes the interface.

To accomplish this we split out what was previously considered repo
scope to be local and worktree.

The clients of 'current_config_scope()' who cared about
CONFIG_SCOPE_REPO are also modified to similarly care about
CONFIG_SCOPE_WORKTREE and CONFIG_SCOPE_LOCAL to preserve previous behavior.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c              | 13 ++++++-------
 config.h              |  3 ++-
 remote.c              |  3 ++-
 t/t1308-config-set.sh |  2 +-
 upload-pack.c         |  3 ++-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 83bb98d65e..7422bdebb1 100644
--- a/config.c
+++ b/config.c
@@ -1724,15 +1724,12 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file(fn, user_config, data);
 
-	current_parsing_scope = CONFIG_SCOPE_REPO;
+	current_parsing_scope = CONFIG_SCOPE_LOCAL;
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
-	/*
-	 * Note: this should have a new scope, CONFIG_SCOPE_WORKTREE.
-	 * But let's not complicate things before it's actually needed.
-	 */
+	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
 	if (!opts->ignore_worktree && repository_format_worktree_config) {
 		char *path = git_pathdup("config.worktree");
 		if (!access_or_die(path, R_OK, 0))
@@ -3304,8 +3301,10 @@ const char *config_scope_name(enum config_scope scope)
 		return "system";
 	case CONFIG_SCOPE_GLOBAL:
 		return "global";
-	case CONFIG_SCOPE_REPO:
-		return "repo";
+	case CONFIG_SCOPE_LOCAL:
+		return "local";
+	case CONFIG_SCOPE_WORKTREE:
+		return "worktree";
 	case CONFIG_SCOPE_CMDLINE:
 		return "command line";
 	default:
diff --git a/config.h b/config.h
index dcb8c274d4..d3ed41ef8e 100644
--- a/config.h
+++ b/config.h
@@ -299,7 +299,8 @@ enum config_scope {
 	CONFIG_SCOPE_UNKNOWN = 0,
 	CONFIG_SCOPE_SYSTEM,
 	CONFIG_SCOPE_GLOBAL,
-	CONFIG_SCOPE_REPO,
+	CONFIG_SCOPE_LOCAL,
+	CONFIG_SCOPE_WORKTREE,
 	CONFIG_SCOPE_CMDLINE,
 };
 const char *config_scope_name(enum config_scope scope);
diff --git a/remote.c b/remote.c
index 5c4666b53a..593ce297ed 100644
--- a/remote.c
+++ b/remote.c
@@ -369,7 +369,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	}
 	remote = make_remote(name, namelen);
 	remote->origin = REMOTE_CONFIG;
-	if (current_config_scope() == CONFIG_SCOPE_REPO)
+	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
+	current_config_scope() == CONFIG_SCOPE_WORKTREE)
 		remote->configured_in_repo = 1;
 	if (!strcmp(subkey, "mirror"))
 		remote->mirror = git_config_bool(key, value);
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 5f3e71a160..728a2b87ce 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -259,7 +259,7 @@ test_expect_success 'iteration shows correct origins' '
 	value=from-repo
 	origin=file
 	name=.git/config
-	scope=repo
+	scope=local
 
 	key=foo.bar
 	value=from-cmdline
diff --git a/upload-pack.c b/upload-pack.c
index a00d7ece6b..c53249cac1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1073,7 +1073,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 		precomposed_unicode = git_config_bool(var, value);
 	}
 
-	if (current_config_scope() != CONFIG_SCOPE_REPO) {
+	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
+	current_config_scope() != CONFIG_SCOPE_WORKTREE) {
 		if (!strcmp("uploadpack.packobjectshook", var))
 			return git_config_string(&pack_objects_hook, var, value);
 	}
-- 
gitgitgadget

