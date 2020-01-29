Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A5C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BC120702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyC0zhNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgA2Ded (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:34:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37775 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgA2Dec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 22:34:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so4815559wmf.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 19:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3PcO5s3p2Umk+7twGJtBhZtoe21TmiTcwljqA3WmxRw=;
        b=iyC0zhNeZaCOYPlmMbXadIFpEgaTYaIZ8j/fWi5GNLwitoEMhnDW61m/gc78y3lO5E
         yJncy4XfqB7cKqaDt1porSvhqQrZcMLjjDfezJp/0iXpi9GRRvEPaJkzmoF8v8PYhmtr
         o4AdSoSbRYvZlTkLtiOby7ktGe6PA4VwNSQvjaX4O/KbqJLJtZvQL21xPbLRo1aSLRgW
         UIhz+dbX3jBfcfSCwHwwogiQCykT+xa2jp45s9xbsHHWYYf31WiXcte0ERz1/zxX5zgM
         Y7Qko3mKgVYSe0Uxtjftbd7G0C25NXlZFMSgsvw985DIxqis65M6ITs4waimpOv6YsgN
         8KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3PcO5s3p2Umk+7twGJtBhZtoe21TmiTcwljqA3WmxRw=;
        b=EeBGlNgz9imAKw8sCibWFX34rn8qmFeWAJjCd/kc2sYKFp81C9dcAwt3wrL39pk4L0
         jga+Xv6dwB4+o+dUPX9vq+71mVKM8JKMsboG4jtdWMTxS0lcz5HdMRtSewZFyXlUbJbq
         +iq8GLKuxU7enJZPrkDa4hTJ9ACD5xn4UaGUH/BmgMfek0pXawanIk3yqZVTXkmdAZ3D
         fCf4X4VpnVYs4OOI9jiOVa+x5nf2e+31650I1kOxa5hKpGNozQcY2DU59XdgMJYS0ArL
         LJRA0tCSYCjpfdRj6n2lzuHaCKAUlIaOwZOJr4dAqE6y3YyS98aHXAQr1Kww3Zrm0Z7/
         Pc4A==
X-Gm-Message-State: APjAAAVOOVaqtkg84xRqWpR8mYV9v9EobWYMTPeV2MBf07yzWhEDA0wy
        MMPz6QOltCQLKtgPUxubd/yV0PNP
X-Google-Smtp-Source: APXvYqxF3Xsfj9W7xp1u2HBqL1Ji/Mgjy500rIcirs8zVwVE3DvrExNtXbDHTVA/R/VOdnRXSPqgPA==
X-Received: by 2002:a05:600c:2942:: with SMTP id n2mr8285260wmd.87.1580268870144;
        Tue, 28 Jan 2020 19:34:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm612650wme.41.2020.01.28.19.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 19:34:29 -0800 (PST)
Message-Id: <1e406ba43093405c1675024ff4bf8ca66737a202.1580268865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
        <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 03:34:23 +0000
Subject: [PATCH v6 4/6] config: split repo scope to local and worktree
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
 config.c               | 7 ++-----
 config.h               | 3 ++-
 remote.c               | 3 ++-
 t/helper/test-config.c | 6 ++++--
 t/t1308-config-set.sh  | 2 +-
 upload-pack.c          | 3 ++-
 6 files changed, 13 insertions(+), 11 deletions(-)

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
index 214003d5b2..9c6ae7a8a7 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -44,8 +44,10 @@ static const char *scope_name(enum config_scope scope)
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

