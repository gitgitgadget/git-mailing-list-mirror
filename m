Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AF5200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932980AbcL0QYP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:24:15 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34500 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932863AbcL0QYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:24:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id b1so12845038pgc.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IpzXxj1cC/2u9NM563FCNmWmBKUPqsYIU7s6fp4rhus=;
        b=ZAfK90DIJ96jEutW/5CoYtPGMod/9wnmSNh439VY2GTkZNinX3uTptZ4e8MfeUu1WX
         J3ZhGgUrTEf1gWeDGrLnxVwocY6FVLg9QahPCZf6lIhSzLtV/+g5krF7eif8I3S1sBWU
         k5QdEHWaek11quqts1AZQSa67TaW/fH6llhwfx0DQoeMbmWY5+rCN0O8Nqc83XYKWk9p
         3fCGeViXghBBC8PP6irIwSWjiozIaRuKgfZa0ckWR99izKgUKXENgk9e0BQz+Oj+n1E6
         A8UpucLSK1n6s4bTr6jLdVNPt9K5z/hlXHh6Q2DjoHshEZf1HBgVp8XEMrs2UHoUbGAL
         rPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IpzXxj1cC/2u9NM563FCNmWmBKUPqsYIU7s6fp4rhus=;
        b=fLCMEzMtxsJwvcwHurmJ970oK2sT8nVynHV6qQm3gsdVibWY4LS0A8yQDMJNQeC3eL
         uUzsslHL4/0NPCtrHd/VUOWHcaf1ci+RrsObBed7bbr7gFXS0gvrbOpV3DzED1gUd7ya
         Zv0Nd5B3sBooNb3z/ro+JQ+lUrghWJCA5tLAgncSQcGgtFLMqPGTvJVKR3BqkNLH1PG2
         yJ+uvx+eecy635l3/mD1yUyAyL507V6LQMj3pO00hz7hU6x0eTD9WwUd9lIsHJkcgG2v
         qa69bgsb5RTqY0jJ3qLgchN/Go5yGXuZYxxdC22H2whYhCtB93tXMxBV5wbd+QJS4K2F
         HBJA==
X-Gm-Message-State: AIkVDXJTyLkLi0oi1gKNMyWuU02qxPjYiefiw9r8MgA8Ys/wQnUsfpdyC1v2qQ4Si21dOQ==
X-Received: by 10.99.65.65 with SMTP id o62mr59851819pga.73.1482855842710;
        Tue, 27 Dec 2016 08:24:02 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:24:02 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 20/20] branch: implement '--format' option
Date:   Tue, 27 Dec 2016 21:53:57 +0530
Message-Id: <20161227162357.28212-21-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
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
index 5516a47..1fae4ee 100644
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
index 2887545..4051a18 100644
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
index 4521328..5778c0a 100755
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
2.10.2

