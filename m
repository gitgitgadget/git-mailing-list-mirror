Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70032C35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 00:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BCD2071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 00:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+1Hu+s6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgAXAVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:21:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36721 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgAXAVO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 19:21:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so24151wru.3
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 16:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6NRzuQmbNQuX3qumUbsbslbMePVYQw4AO29iqnS59bU=;
        b=P+1Hu+s6bA2i3ZmYC3kX/68lIsTdkE2x4KMeAEigBjsqwUbtY6tvr475ntOyyEB2oL
         E7fWX3cXDi8PVJ1Az/dmnI/bnHrnZSsj8sAq/7q0O6O/szWMRO2x/WRqXfPhKVxKSyXb
         XSK2WOAddj+cqJzIkR+f8kP6wL7nyqFdgLAm15GDCkaG7QD3sVn/5bfeocfrlsEdH0ms
         2HPwAj+qT2Sk66bVbGYHtptdSZezOwf8sflPHEClofMlaWZB5c/mK7VCsUGYej0OFSou
         0BIofEGfvDSHydRO30mZkC67REdKwSeyv74k3kwnRGxkeh1nQMiNcC7GdnOvLXcf716d
         gITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6NRzuQmbNQuX3qumUbsbslbMePVYQw4AO29iqnS59bU=;
        b=NL2/AxgG1HLOImjrwsaFsugoyTHo9/FgovL6Q2lJgLxL5f+rw3usC6H0iZ7VITy9Bt
         N17RFbb3vEEbidQdIgC6YAjxsxUpU1IAJ4YaVsRAfvr1p+5RyZiGXHJwavEcrw65swvi
         +qLh0qKYqTolFAbhogSbfm2wK/mn+GRL/7TruW6QUT8Eg+wtSHgwPAtDWZDXlEQy0JbH
         39bDWeannX4Jo2mHbpzVvFsHyM7eSs7ZCqqwZcqfzbqx2Cv+LYPglINoqhB+1frZHLIz
         uamndoWO9o6CyfEYe+xpgz/tyDdtneOLoyEFTz9PYHtzywNrnMdTKLB6mHQoTvhwDDNc
         y8Cg==
X-Gm-Message-State: APjAAAX1Ymb8gMq0xmlgNZ/uHjbTWaRlxZk26UH18h1Ql+whWNbDVhJG
        xUqkYccm5Ev3/D02JQnwsR5r2zWQ
X-Google-Smtp-Source: APXvYqyRpKhPuqaDZ+ZO8y9Wk8pRkQao0P2Ci/1PoaiFGB5TcrD6DWiWa7HLeoo2UEyXQOJKm35UOg==
X-Received: by 2002:a05:6000:1248:: with SMTP id j8mr702327wrx.44.1579825271718;
        Thu, 23 Jan 2020 16:21:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm4993461wrt.74.2020.01.23.16.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 16:21:11 -0800 (PST)
Message-Id: <9f160e281a984ea7578f8fbe244adc77c6585e44.1579825267.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 00:21:04 +0000
Subject: [PATCH v4 4/6] config: split repo scope to local and worktree
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
---
 config.c               | 7 ++-----
 config.h               | 3 ++-
 remote.c               | 3 ++-
 t/helper/test-config.c | 4 +++-
 t/t1308-config-set.sh  | 2 +-
 upload-pack.c          | 3 ++-
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index d75f88ca0c..447a013a15 100644
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
diff --git a/config.h b/config.h
index 91fd4c5e96..284d92fb0e 100644
--- a/config.h
+++ b/config.h
@@ -298,7 +298,8 @@ enum config_scope {
 	CONFIG_SCOPE_UNKNOWN = 0,
 	CONFIG_SCOPE_SYSTEM,
 	CONFIG_SCOPE_GLOBAL,
-	CONFIG_SCOPE_REPO,
+	CONFIG_SCOPE_LOCAL,
+	CONFIG_SCOPE_WORKTREE,
 	CONFIG_SCOPE_CMDLINE,
 };
 
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
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 214003d5b2..6695e463eb 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -44,8 +44,10 @@ static const char *scope_name(enum config_scope scope)
 		return "system";
 	case CONFIG_SCOPE_GLOBAL:
 		return "global";
-	case CONFIG_SCOPE_REPO:
+	case CONFIG_SCOPE_LOCAL:
 		return "repo";
+	case CONFIG_SCOPE_WORKTREE:
+		return "worktree";
 	case CONFIG_SCOPE_CMDLINE:
 		return "cmdline";
 	default:
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7b4e1a63eb..90196e2862 100755
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

