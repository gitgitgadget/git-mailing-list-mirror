Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 784121F576
	for <e@80x24.org>; Tue, 27 Feb 2018 09:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeB0J64 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 04:58:56 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43436 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeB0J6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 04:58:54 -0500
Received: by mail-pg0-f68.google.com with SMTP id e9so2996919pgs.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 01:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vBa0Yldpu+EAw+Ww9GoKehi1hTuEGyjZ8mqGzgkGm8o=;
        b=Bg6GGRjR0utLy5fJtzAOo5httEVHsAKkC4SEYv0nzCo2IruburOP5VXc17rUZlZoBn
         z2mAfQ2S7+rDx/UsCl6C2mxh7KYqFTlBsJXG3C63iWUB432tQifgggD0yvNSuMuLAgsl
         n89YvIuv6WnImWqNZrRUSZDjFEmMOb27CahLvHcNQPiVEUWmNCRrHoV90DgVKieOOkR6
         aL1jHt8Nv8OzUgosutJgEsfXXBogmcBGXDFVz2Ri2SYndbrpHG3y6Vgatx4XE24dGpp+
         2yMiPrSfKot6IZCDpWSq0X7HHEqEzJXdpGmcWIqeSIvNz1V4t6ya0U5Au/41GzNh77cf
         bfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vBa0Yldpu+EAw+Ww9GoKehi1hTuEGyjZ8mqGzgkGm8o=;
        b=BR4lzSeOg8O0ReNgwztAJZjYW1x/Iy7mWqDi1GqihssC8/dhZqz+su+QG1FC2QZ/ek
         wBo4xr+JNYs1fsu47r2sTtEg7OWn9DmFmjoXSJoA3+MfM5dm+7RlTDXLQa4FwCN9cC86
         SRgzy7BDo+rmaXyUTDUn+MPLE8AHVBkwQtQUH8Fy6oIl8atSJsDDzgx/XnZNzNPwM9Jy
         mJgCZ8e0+pwQJOF3pvjqnK1g6yVYlv3DUneFZFRIp2a728q+LEfh0H4KEHw8olTAv4Hy
         6nsh4CLwlFW1p+HgxlkqGPRAUXZ9LDtiBcTPaAsZx2BwaqOeEfJ/1dSJoYl/G5mZdZ05
         fFOw==
X-Gm-Message-State: APf1xPCitiwdTjL4yu4aau5FxLCTpFoDLCMO4qrkK5nyG61ahdW7rzaz
        W0HOqqtRvFOIIshCtbSPgEs=
X-Google-Smtp-Source: AH8x225ZWRAEw3fusxTEfoWh7v5YcNYl4RKUS52uo3aQEB6I89urVzwM/75KQ/AzQrSYl48KuUDLhg==
X-Received: by 10.99.96.199 with SMTP id u190mr10863520pgb.231.1519725534091;
        Tue, 27 Feb 2018 01:58:54 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id k23sm12199530pfi.79.2018.02.27.01.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 01:58:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 27 Feb 2018 16:58:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 0/4] Delete ignore_env member in struct repository
Date:   Tue, 27 Feb 2018 16:58:42 +0700
Message-Id: <20180227095846.9238-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180226103030.26900-1-pclouds@gmail.com>
References: <20180226103030.26900-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes the incorrect use of consecutive getenv() and adds a comment
to clarify the role of old_gitdir

Interdiff:

diff --git a/environment.c b/environment.c
index 95de419de8..47c6e31559 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"
 #include "object-store.h"
+#include "argv-array.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
@@ -148,18 +149,34 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
+/* Wrapper of getenv() that returns a strdup value. This value is kept
+ * in argv to be freed later.
+ */
+static const char *getenv_safe(struct argv_array *argv, const char *name)
+{
+	const char *value = getenv(name);
+
+	if (!value)
+		return NULL;
+
+	argv_array_push(argv, value);
+	return argv->argv[argv->argc - 1];
+}
+
 void setup_git_env(const char *git_dir)
 {
 	const char *shallow_file;
 	const char *replace_ref_base;
 	struct set_gitdir_args args = { NULL };
+	struct argv_array to_free = ARGV_ARRAY_INIT;
 
-	args.shared_root = getenv(GIT_COMMON_DIR_ENVIRONMENT);
-	args.object_dir = getenv(DB_ENVIRONMENT);
-	args.graft_file = getenv(GRAFT_ENVIRONMENT);
-	args.index_file = getenv(INDEX_ENVIRONMENT);
-	args.alternate_db = getenv(ALTERNATE_DB_ENVIRONMENT);
+	args.shared_root = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
+	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
+	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
+	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
+	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
 	repo_set_gitdir(the_repository, git_dir, &args);
+	argv_array_clear(&to_free);
 
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs = 0;
diff --git a/repository.c b/repository.c
index 8f6386022f..c555dacad2 100644
--- a/repository.c
+++ b/repository.c
@@ -48,6 +48,11 @@ void repo_set_gitdir(struct repository *repo,
 		     const struct set_gitdir_args *o)
 {
 	const char *gitfile = read_gitfile(root);
+	/*
+	 * repo->gitdir is saved because the caller could pass "root"
+	 * that also points to repo->gitdir. We want to keep it alive
+	 * until after xstrdup(root). Then we can free it.
+	 */
 	char *old_gitdir = repo->gitdir;
 
 	repo->gitdir = xstrdup(gitfile ? gitfile : root);

Nguyễn Thái Ngọc Duy (4):
  repository.c: move env-related setup code back to environment.c
  repository.c: delete dead functions
  sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
  repository: delete ignore_env member

 cache.h        |  2 +-
 environment.c  | 30 ++++++++++++++++--
 object-store.h |  5 ++-
 object.c       |  1 +
 repository.c   | 84 ++++++++++++++++++++++++--------------------------
 repository.h   | 21 +++++++------
 setup.c        |  3 +-
 sha1_file.c    |  6 +---
 8 files changed, 86 insertions(+), 66 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

