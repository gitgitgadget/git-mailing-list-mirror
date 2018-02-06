Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B32A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeBFA0R (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:26:17 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34003 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeBFA0M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:26:12 -0500
Received: by mail-pg0-f67.google.com with SMTP id s73so187665pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FnAIDcSCjU8NJCMSUmaovAnGbrT5Nbvv+2p00Y5rjAs=;
        b=dP25mRqdTarVPEssDSKUEwoVTtDQjMmE8JmjQaJS1gVJmE5fpviLdCKavv3wKgFB42
         ARZwx94QA2HxKDDyQGuJjEgq3QAv7ZJMfSdbuVwAoOrzV6YYu381memA2Q/oRr/8qAjB
         WSoKCJnnQRZE9nxtvYRJUuW8aUmrduT3BsYKr1Q7aSqPnA3aKAAyyhEQPYVYikXDUjk2
         43NUuUvujCJeETytO7YCTEtCy6cV5MG0vexEmN8dNsqavUYZLqCFvQeDOSuEAb5lLAsX
         hFwFanNnwwPbC7DVnWs3tpBJIb0Fyrnp0JiS5JXmBIGiW8b/Vq9ekmBdTfNDIpRpfEaC
         OiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FnAIDcSCjU8NJCMSUmaovAnGbrT5Nbvv+2p00Y5rjAs=;
        b=sYLUVMZUSbGwYz05fMt9StrYnAAcizAVw2vI4mIXPYOeIbZ6/CIffFi8J7F5gCQ9Tf
         5B5GU6fZMbon8UZZFpCkP4Oj3yWkKctFTm1QCSnm5ZCxexBbEHIBklfsOZmKyTP93LiH
         kTGi+1d8eBTxp7fgJfEw7qHZXkIOLiUeDdRci6E1fSw5dOYW1B3Dwgg+U19zWI8dFE+k
         nBlgqGSp0DNabTXiWjF05JLSiG8cL03hf5jcNTH+lvroe8/RIco/p8pt3terv1dFG/mz
         j7CT2Zo4XKuZAEFu1ORBI83/Yst76qsg1JLolZmb1IcJJluoebFBZ8UQgv5EgX4ofPGv
         ipMg==
X-Gm-Message-State: APf1xPABQpf1We5uBi1W0QLjlMwzg8dUgfeYGDZKXaTPByok6kiAiv0d
        n4tUVcf+cC4dAqCZZnI7Ueiynr9+wdg=
X-Google-Smtp-Source: AH8x227JEjNyFfltecZ61DnI50SgB5Rqs5dbxEM7+rqRzjX0Lhtdswi4qg7LsfThJDCU6yJofw7VLA==
X-Received: by 10.99.55.65 with SMTP id g1mr463125pgn.284.1517876771857;
        Mon, 05 Feb 2018 16:26:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c19sm6600576pfk.22.2018.02.05.16.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:26:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 152/194] shallow: add repository argument to set_alternate_shallow_file
Date:   Mon,  5 Feb 2018 16:17:07 -0800
Message-Id: <20180206001749.218943-54-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.h      | 3 ++-
 environment.c | 2 +-
 git.c         | 2 +-
 shallow.c     | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit.h b/commit.h
index 0d3ccd7279..7ef21a0fbf 100644
--- a/commit.h
+++ b/commit.h
@@ -204,7 +204,8 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
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
index 972ade61d8..d3915a5a0a 100644
--- a/environment.c
+++ b/environment.c
@@ -160,7 +160,7 @@ void setup_git_env(void)
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
-		set_alternate_shallow_file(shallow_file, 0);
+		set_alternate_shallow_file(the_repository, shallow_file, 0);
 }
 
 int is_bare_repository(void)
diff --git a/git.c b/git.c
index c870b9719c..6c5ef91a0d 100644
--- a/git.c
+++ b/git.c
@@ -189,7 +189,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		} else if (!strcmp(cmd, "--shallow-file")) {
 			(*argv)++;
 			(*argc)--;
-			set_alternate_shallow_file((*argv)[0], 1);
+			set_alternate_shallow_file(the_repository, (*argv)[0], 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
diff --git a/shallow.c b/shallow.c
index 254c1a397a..c26e99fedd 100644
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
2.15.1.433.g936d1b9894.dirty

