Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEB0203C1
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbcLGPhK (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:10 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35797 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbcLGPhE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:37:04 -0500
Received: by mail-pf0-f196.google.com with SMTP id i88so11381211pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uez9hfJv4Zg29SbXp7+5XAe7ou1KfjwnXLKNL8svEoQ=;
        b=UmAfNxkdXIZZCMbf3J2xrrArP+cLkqoX7zJQFlN/ktxfLjVqM0HVYb0nBdUgyz9LEt
         Xtqci4NIWffsKSD4t3+CBtqgb3IlYP4C5q+zlFRvwbveDX+JP/UIETT1+VjyuelWNwZS
         p5whcwGiiKv2RuTolZRxkM1mvFplhwAk/OezGQD2UyiluoOG7KIVae/X5tkt3h7CNwoF
         JWBmPW9RnfzJmni7wk6Nl7SKmEgprz/hZu3BKuIzxgQB5Xwb2Pc/mUDR6Nx1nC8fr68T
         3c3WKucbEfqUoBvUx/MdfEOQ+SY8lwAnFy7zsgFRoIy8RL2AgAco2a295Jv5Z5+MyIsY
         TsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uez9hfJv4Zg29SbXp7+5XAe7ou1KfjwnXLKNL8svEoQ=;
        b=f9g1U6UT7sBd8d0cse/uTP1mFd0GPy/8NTybQSN5W67+81QCfhWF0lOE4ImbgKKd4D
         r1WQaq6YdgAXOh3tQbkSKFOLiKKdTRuI3L6h0Mh8IxNE9CdtQ6Cr1pk53sOrcqZXWqd5
         sPhKP7QvNNva6Z2+GZ7Ejq0zUF7AXVeQj/HFvXMT+8LDLXY/vB17JXG9SAnZT8tChipG
         EI3eD25ktmZcTf4cqsyDvThcq6BqdzMyyiB2hWkLcHyGnrcHOdSSX0gmgPe2/nXbFR/Z
         ez/r964yrfEvLnLN8Nmk5TGhRA3cRFyroWqpc6CIq96oWd5APj5hjbIDY94ltX0daymi
         WLdQ==
X-Gm-Message-State: AKaTC01bcgU6AV5NvsQK4UDIng2hywOLCvXa4kRylBAlzEcVF/5Dk0rjxK+Kn8UjN61hZQ==
X-Received: by 10.99.235.10 with SMTP id t10mr121320893pgh.95.1481125023947;
        Wed, 07 Dec 2016 07:37:03 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:37:03 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 19/19] branch: implement '--format' option
Date:   Wed,  7 Dec 2016 21:06:27 +0530
Message-Id: <20161207153627.1468-20-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
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
index 1fe7344..e5b6f31 100644
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
@@ -246,6 +246,11 @@ start-point is either a local or remote-tracking branch.
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
index 046d245..6393c3c 100644
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
 
 	/*
@@ -416,7 +418,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	}
 
 	ref_array_clear(&array);
-	free(format);
+	free(to_free);
 }
 
 static void reject_rebase_or_bisect_branch(const char *target)
@@ -536,6 +538,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -576,6 +579,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
 
@@ -636,7 +640,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
 		filter.name_patterns = argv;
-		print_ref_list(&filter, sorting);
+		print_ref_list(&filter, sorting, format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 980c732..d8edaf2 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -196,4 +196,18 @@ test_expect_success 'local-branch symrefs shortened properly' '
 	test_cmp expect actual
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

