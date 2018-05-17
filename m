Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F021F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeEQWwX (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:23 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:36639 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQWwV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:21 -0400
Received: by mail-pl0-f51.google.com with SMTP id v24-v6so3399054plo.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3u4uMJWf7W2vf/LjqCmf3iMG6s1SiwXmqfmb7lxLtc=;
        b=pzz/lHjtlsSQ0KtYxHAOgenmt/LgxcUTJolQYxnoP/a3ijvWEVKgW0G7twRdVbrdEO
         tVt2fJO3lBApQSvvk+WNFyiJrYa/AJ0Ao9NEKtTNPxbM21MtqnOLZG/sJzCBGX3/MzOX
         l5w/AOuBOFao33cNQLKPlDVqeuoRXfMJLgcxk2P1QKZS3sFyZIAxxZRqaoWzBKkmLBDD
         WkDDk9CJ6se9GzYA/XtR5ccJDVNLrQDHMSdvi8amrt1nEd9wtyoOERM0f57xLcCh4XM9
         74uiJaJABoTzXWPRR3vjgJpk987hMaSdUuUpQXHl/wDgt71fIY4q0amc/ffnBUeeFFWl
         etZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3u4uMJWf7W2vf/LjqCmf3iMG6s1SiwXmqfmb7lxLtc=;
        b=kk9/BanGNVSyAfNroCZjeSqjMddWbr5hjPnOjfSDR1Peb0H/pdUJZWH28zJQVa28RD
         7tXpJY0WxDO9sIF16NPzFOKARq0WEYfccGRVyqm06pzqD4Q/T/UyBYFaq1YGMOOEf4HQ
         KxhNoTYUdUITGJwcmpXwyBGMVZ4mkzGANlvD+fsyIB7QUGn+AVWkG/U/bI8YyPcXwD17
         CCkRu0t4gcKjv97jKvfhlg0tPSPQFp/tqTsZ+FyVCeH9Hhjom+8VyAEyoSFer0SFESKL
         zNEc33mTu0XnPiRUqIhunJuGQREbDijpujezHG9H7BBdvmgyYc9AAIjU/d64SqY8GI0m
         WwKQ==
X-Gm-Message-State: ALKqPwdiM8kjrUsRSKMbqZQzNe+0FMP6AsKEmkJ1/HbW/fDLRLsecV5i
        AtNx2ZoBuMJwCaaFc/4NrD+9o+m5v4Y=
X-Google-Smtp-Source: AB8JxZoq0p1Ma1K/ChaRZ/NSbXnnHF1A7f1qI6Z2wD6p19cFJBtoxHK35hh+QBzgV3jYYd7kx9CEQQ==
X-Received: by 2002:a17:902:ac96:: with SMTP id h22-v6mr6960291plr.338.1526597540571;
        Thu, 17 May 2018 15:52:20 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id n83-v6sm11549938pfi.183.2018.05.17.15.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 08/19] shallow: add repository argument to set_alternate_shallow_file
Date:   Thu, 17 May 2018 15:51:43 -0700
Message-Id: <20180517225154.9200-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of set_alternate_shallow_file
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.h      | 3 ++-
 environment.c | 2 +-
 git.c         | 2 +-
 shallow.c     | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit.h b/commit.h
index f6746125766..f88c854e2f6 100644
--- a/commit.h
+++ b/commit.h
@@ -199,7 +199,8 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern struct commit_list *get_shallow_commits_by_rev_list(
 		int ac, const char **av, int shallow_flag, int not_shallow_flag);
-extern void set_alternate_shallow_file(const char *path, int override);
+#define set_alternate_shallow_file(r, p, o) set_alternate_shallow_file_##r(p, o)
+extern void set_alternate_shallow_file_the_repository(const char *path, int override);
 extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 				 const struct oid_array *extra);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
diff --git a/environment.c b/environment.c
index b991fc0a87c..87d9e52ffde 100644
--- a/environment.c
+++ b/environment.c
@@ -189,7 +189,7 @@ void setup_git_env(const char *git_dir)
 	git_namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
-		set_alternate_shallow_file(shallow_file, 0);
+		set_alternate_shallow_file(the_repository, shallow_file, 0);
 }
 
 int is_bare_repository(void)
diff --git a/git.c b/git.c
index 3a89893712e..5e8903681e6 100644
--- a/git.c
+++ b/git.c
@@ -207,7 +207,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		} else if (!strcmp(cmd, "--shallow-file")) {
 			(*argv)++;
 			(*argc)--;
-			set_alternate_shallow_file((*argv)[0], 1);
+			set_alternate_shallow_file(the_repository, (*argv)[0], 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
diff --git a/shallow.c b/shallow.c
index ca360c700c5..73cb11a9162 100644
--- a/shallow.c
+++ b/shallow.c
@@ -19,7 +19,7 @@ static int is_shallow = -1;
 static struct stat_validity shallow_stat;
 static char *alternate_shallow_file;
 
-void set_alternate_shallow_file(const char *path, int override)
+void set_alternate_shallow_file_the_repository(const char *path, int override)
 {
 	if (is_shallow != -1)
 		die("BUG: is_repository_shallow must not be called before set_alternate_shallow_file");
-- 
2.17.0.582.gccdcbd54c44.dirty

