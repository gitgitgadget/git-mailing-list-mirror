Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D72020A93
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936361AbdAJItp (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:45 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36271 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932940AbdAJItl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:41 -0500
Received: by mail-pf0-f193.google.com with SMTP id b22so11592136pfd.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LjCfnxf455gtS2LFR7tBkBwOPz1VIM9seElg1sg/1tg=;
        b=BkH4st4pKJA1vOuOMCKGrrw6AvOO6KsxUsjlXPXQJuRYjlgvRoGRjhlQodCZJ7onN5
         GPi4h516uL4I7SMWsvmetBbjrUA35iz9BwtbTuM1vgOPJeXO3DIBHfeX7p/95mGpWaom
         JeTnLk+Jhj2IKjR3g1TtyCLGvFD/ZT5t6S6hkcHgfssJCJbmfGOC1RNZlDalpiZKTE5e
         EMAr/hYm3V+Sy+u4IItOgQ20gj7s/BysWKd1h6djCPixpFAYdnIBtQQZVvH6OGqaLsg3
         yULW3K0t4akM03I1JgsfczgnowjccbkZu8CRgV9cVeyc4UuW4CPa73ntcEO4hl1pR7xi
         k7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LjCfnxf455gtS2LFR7tBkBwOPz1VIM9seElg1sg/1tg=;
        b=bTO4n1UcvMAnF/ChstdX3YlhX8g7NWkZuAmP9MH4PGPzoR98M6UOmAF09J7H3l48dd
         SzyvdRqnQJZ2Q8jac+TZIvGihomgAW2Q4dZfd9P62I//iLm4rEEoF/2EMeZ1mZzIiHzi
         AqWzvci23reAbnQd6fgHHKkgh16o0w0AEbG6JlEmYd8lOQJAau/EjlTupUK3Oa4XxXSs
         V//rcc/IgehIuybbFwAKnZfd3mD9WQE/ukjIeF1JdZzQaqFrKu+QLHE2dHSn4eLncO3k
         2/mdCTZwtona58Z6opOqpYvOGQaVMrSDttmY18s3OJFNinT5ZDAVAHeEo1ydedTYjW7J
         6CVw==
X-Gm-Message-State: AIkVDXI5+X9la5tIZIlWb9jTjwYUXU77YjlAWjQgNogG8qGntHR9HhhltjLLn65u1qhyXQ==
X-Received: by 10.84.215.2 with SMTP id k2mr3308795pli.58.1484038180376;
        Tue, 10 Jan 2017 00:49:40 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:39 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 20/20] branch: implement '--format' option
Date:   Tue, 10 Jan 2017 14:19:53 +0530
Message-Id: <20170110084953.15890-21-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Implement the '--format' option provided by 'ref-filter'. This lets the
user list branches as per desired format similar to the implementation
in 'git for-each-ref'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-branch.txt |  7 ++++++-
 builtin/branch.c             | 14 +++++++++-----
 t/t3203-branch-output.sh     | 14 ++++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 5516a47b5..1fae4eeee 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column]
 	[(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>]
-	[--points-at <object>] [<pattern>...]
+	[--points-at <object>] [--format=<format>] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
@@ -250,6 +250,11 @@ start-point is either a local or remote-tracking branch.
 --points-at <object>::
 	Only list branches of the given object.
 
+--format <format>::
+	A string that interpolates `%(fieldname)` from the object
+	pointed at by a ref being shown.  The format is the same as
+	that of linkgit:git-for-each-ref[1].
+
 Examples
 --------
 
diff --git a/builtin/branch.c b/builtin/branch.c
index f293ee5b0..cbaa6d03c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -28,6 +28,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
+	N_("git branch [<options>] [-r | -a] [--format]"),
 	NULL
 };
 
@@ -364,14 +365,14 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	return strbuf_detach(&fmt, NULL);
 }
 
-static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting)
+static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
 	int i;
 	struct ref_array array;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
 	struct strbuf out = STRBUF_INIT;
-	char *format;
+	char *to_free = NULL;
 
 	/*
 	 * If we are listing more than just remote branches,
@@ -388,7 +389,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	format = build_format(filter, maxwidth, remote_prefix);
+	if (!format)
+		format = to_free = build_format(filter, maxwidth, remote_prefix);
 	verify_ref_format(format);
 
 	ref_array_sort(sorting, &array);
@@ -407,7 +409,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	}
 
 	ref_array_clear(&array);
-	free(format);
+	free(to_free);
 }
 
 static void reject_rebase_or_bisect_branch(const char *target)
@@ -528,6 +530,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	struct ref_filter filter;
 	int icase = 0;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -569,6 +572,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			N_("print only branches of the object"), 0, parse_opt_object_name
 		},
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
 
@@ -641,7 +645,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!sorting)
 			sorting = ref_default_sorting();
 		sorting->ignore_case = icase;
-		print_ref_list(&filter, sorting);
+		print_ref_list(&filter, sorting, format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 45213280a..5778c0afe 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -225,4 +225,18 @@ test_expect_success 'sort branches, ignore case' '
 	)
 '
 
+test_expect_success 'git branch --format option' '
+	cat >expect <<-\EOF &&
+	Refname is (HEAD detached from fromtag)
+	Refname is refs/heads/ambiguous
+	Refname is refs/heads/branch-one
+	Refname is refs/heads/branch-two
+	Refname is refs/heads/master
+	Refname is refs/heads/ref-to-branch
+	Refname is refs/heads/ref-to-remote
+	EOF
+	git branch --format="Refname is %(refname)" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0

