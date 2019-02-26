Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C05220248
	for <e@80x24.org>; Tue, 26 Feb 2019 20:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfBZUKB (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 15:10:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34192 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBZUKB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 15:10:01 -0500
Received: by mail-qt1-f193.google.com with SMTP id w4so16519371qtc.1
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 12:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKf7Y0SqHIMwJEsqlFL4OTmolC4RWB/Hp3IFTNF3ahg=;
        b=B5obSzHLfNsE7b9kfkKa2magDC1KK+VLp4dQFN0cNR6hOHQ2euDL/t/G9HXKwbVVt6
         eq1V+sCqEx4ajIC4fGTjyfly9c+KHHIXll4F4Q2RcMk5bNdR1vWdw3RpVB+T2N7AEhbx
         yKkeo1u6gFJhmPUNt62Sqct0IanJC6j3MAdE5u7XIND0Uy9ZeJD+b9unHmrf15YYub85
         qY+qY3IlkCrWelVsCOH9+qaWFkpDKSXNGqTL1CPqbUYSWXO1N9SekMK9IZciQaAfJOEV
         R6phiHXHPjn7D8nSWPycRjdkUKMgQlToBEArv3T8eOElednAInBdCCa9kccZzF7AZU3d
         TMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKf7Y0SqHIMwJEsqlFL4OTmolC4RWB/Hp3IFTNF3ahg=;
        b=mpDNV05JGPmzyH2Rh3ndhww1toJAddiMfdYwNsy9qo4LG4dRqQlqsuX/8hIeb0V8Rn
         XNnu3KWdegA4kOpXPR2oC0n++o2svmAZJq5SkBuZXhLtg3rGvJu3SVCyCmYHS9f41Mse
         d1alQg4YYTltoPG27N+m8//wYQzcFlSQT2Qk5JVr8oKM09SgKNCbNjt4ef0GHkK4ItBf
         sOyno8VIR3Sx2s1/+ykn52PSkiW+FdT3Q/zobHe8fTGepeWL1uHdgKj7IV1MzNKCpEfv
         9OiluyYMoKd7B3Cbx9X5qDMQgcRGCTTJns7znOuR9/u7jRMBQ9FGlEDSqLoW17bH+7Yn
         B5yA==
X-Gm-Message-State: AHQUAuZXLOS0arPZFZpgYv13VGPYaFpFEnTkPnfw5NlpBvxya+nGcNhP
        2sAvazVJJ6uD6Uk72TpDEhceIQ8o
X-Google-Smtp-Source: AHgI3IbIVXhTE8yrg32fn+XUbwV7Q68io6BsYx+6F5BIlmRcOvmADtv0PWu0Kvk72Dl4gcuf1HghVg==
X-Received: by 2002:a0c:91d7:: with SMTP id r23mr19110605qvr.36.1551211799653;
        Tue, 26 Feb 2019 12:09:59 -0800 (PST)
Received: from localhost.localdomain ([131.202.255.236])
        by smtp.gmail.com with ESMTPSA id s41sm8557130qtc.38.2019.02.26.12.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Feb 2019 12:09:59 -0800 (PST)
From:   Brandon <brandon1024.br@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Richardson <brandon1024.br@gmail.com>
Subject: [PATCH] commit-tree: utilize parse-options api
Date:   Tue, 26 Feb 2019 16:09:52 -0400
Message-Id: <20190226200952.33950-1-brandon1024.br@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Richardson <brandon1024.br@gmail.com>

Rather than parse options manually, which is both difficult to
read and error prone, parse options supplied to commit-tree
using the parse-options api.

It was discovered that the --no-gpg-sign option was documented
but not implemented in 55ca3f99, and the existing implementation
would attempt to translate the option as a tree oid.It was also
suggested in 55ca3f99 that commit-tree should be migrated to
utilize the parse-options api, which could help prevent mistakes
like this in the future. Hence this change.

Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
---

Notes:
    GitHub Pull Request: https://github.com/brandon1024/git/pull/1
    Travis CI Results: https://travis-ci.com/brandon1024/git/builds/102337393

 builtin/commit-tree.c | 162 ++++++++++++++++++++++++------------------
 1 file changed, 92 insertions(+), 70 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 12cc403bd7..310f38d000 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -12,8 +12,14 @@
 #include "builtin.h"
 #include "utf8.h"
 #include "gpg-interface.h"
+#include "parse-options.h"
+#include "string-list.h"
 
-static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>";
+static const char * const builtin_commit_tree_usage[] = {
+	N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...] "
+		"[(-F <file>)...] <tree>"),
+	NULL
+};
 
 static const char *sign_commit;
 
@@ -39,87 +45,103 @@ static int commit_tree_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int parse_parent_arg_callback(const struct option *opt,
+		const char *arg, int unset)
+{
+	struct object_id oid;
+	struct commit_list **parents = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!arg)
+		return 1;
+	if (get_oid_commit(arg, &oid))
+		die("Not a valid object name %s", arg);
+
+	assert_oid_type(&oid, OBJ_COMMIT);
+	new_parent(lookup_commit(the_repository, &oid), parents);
+	return 0;
+}
+
+static int parse_message_arg_callback(const struct option *opt,
+		const char *arg, int unset)
+{
+	struct strbuf *buf = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!arg)
+		return 1;
+	if (buf->len)
+		strbuf_addch(buf, '\n');
+	strbuf_addstr(buf, arg);
+	strbuf_complete_line(buf);
+
+	return 0;
+}
+
+static int parse_file_arg_callback(const struct option *opt,
+		const char *arg, int unset)
+{
+	int fd;
+	struct strbuf *buf = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!arg)
+		return 1;
+	if (buf->len)
+		strbuf_addch(buf, '\n');
+	if (!strcmp(arg, "-"))
+		fd = 0;
+	else {
+		fd = open(arg, O_RDONLY);
+		if (fd < 0)
+			die_errno("git commit-tree: failed to open '%s'", arg);
+	}
+	if (strbuf_read(buf, fd, 0) < 0)
+		die_errno("git commit-tree: failed to read '%s'", arg);
+	if (fd && close(fd))
+		die_errno("git commit-tree: failed to close '%s'", arg);
+
+	return 0;
+}
+
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
-	int i, got_tree = 0;
+	static struct strbuf buffer = STRBUF_INIT;
 	struct commit_list *parents = NULL;
 	struct object_id tree_oid;
 	struct object_id commit_oid;
-	struct strbuf buffer = STRBUF_INIT;
+
+    struct option builtin_commit_tree_options[] = {
+		{ OPTION_CALLBACK, 'p', NULL, &parents, "parent",
+		  N_("id of a parent commit object"), PARSE_OPT_NONEG,
+		  parse_parent_arg_callback },
+		{ OPTION_CALLBACK, 'm', NULL, &buffer, N_("message"),
+		  N_("commit message"), PARSE_OPT_NONEG,
+		  parse_message_arg_callback },
+		{ OPTION_CALLBACK, 'F', NULL, &buffer, N_("file"),
+		  N_("read commit log message from file"), PARSE_OPT_NONEG,
+		  parse_file_arg_callback },
+		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
+		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_END()
+    };
 
 	git_config(commit_tree_config, NULL);
 
 	if (argc < 2 || !strcmp(argv[1], "-h"))
-		usage(commit_tree_usage);
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "-p")) {
-			struct object_id oid;
-			if (argc <= ++i)
-				usage(commit_tree_usage);
-			if (get_oid_commit(argv[i], &oid))
-				die("Not a valid object name %s", argv[i]);
-			assert_oid_type(&oid, OBJ_COMMIT);
-			new_parent(lookup_commit(the_repository, &oid),
-						 &parents);
-			continue;
-		}
+		usage_with_options(builtin_commit_tree_usage, builtin_commit_tree_options);
 
-		if (!strcmp(arg, "--gpg-sign")) {
-		    sign_commit = "";
-		    continue;
-		}
-
-		if (skip_prefix(arg, "-S", &sign_commit) ||
-			skip_prefix(arg, "--gpg-sign=", &sign_commit))
-			continue;
-
-		if (!strcmp(arg, "--no-gpg-sign")) {
-			sign_commit = NULL;
-			continue;
-		}
+	argc = parse_options(argc, argv, prefix, builtin_commit_tree_options,
+			builtin_commit_tree_usage, 0);
 
-		if (!strcmp(arg, "-m")) {
-			if (argc <= ++i)
-				usage(commit_tree_usage);
-			if (buffer.len)
-				strbuf_addch(&buffer, '\n');
-			strbuf_addstr(&buffer, argv[i]);
-			strbuf_complete_line(&buffer);
-			continue;
-		}
-
-		if (!strcmp(arg, "-F")) {
-			int fd;
-
-			if (argc <= ++i)
-				usage(commit_tree_usage);
-			if (buffer.len)
-				strbuf_addch(&buffer, '\n');
-			if (!strcmp(argv[i], "-"))
-				fd = 0;
-			else {
-				fd = open(argv[i], O_RDONLY);
-				if (fd < 0)
-					die_errno("git commit-tree: failed to open '%s'",
-						  argv[i]);
-			}
-			if (strbuf_read(&buffer, fd, 0) < 0)
-				die_errno("git commit-tree: failed to read '%s'",
-					  argv[i]);
-			if (fd && close(fd))
-				die_errno("git commit-tree: failed to close '%s'",
-					  argv[i]);
-			continue;
-		}
+	if (argc != 1)
+		die("Must give exactly one tree");
 
-		if (get_oid_tree(arg, &tree_oid))
-			die("Not a valid object name %s", arg);
-		if (got_tree)
-			die("Cannot give more than one trees");
-		got_tree = 1;
-	}
+	if (get_oid_tree(argv[0], &tree_oid))
+		die("Not a valid object name %s", argv[0]);
 
 	if (!buffer.len) {
 		if (strbuf_read(&buffer, 0, 0) < 0)
-- 
2.21.0

