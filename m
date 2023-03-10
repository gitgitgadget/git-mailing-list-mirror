Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A698C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 17:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCJRVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjCJRVM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 12:21:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5654610F841
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:08 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l25so5739336wrb.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678468866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W13mDQpZsO3npuqGR4YYjbz9Yk1yrAuDJ3FVDoTdpvQ=;
        b=l2UeXGX2Q3rz4mUtgXsOjisCWm4klMKfT7EjjJjH2R8dpIbQuURHQed/2xPv412umW
         mIPyeAg3AuZRAO/MS1jPXTXUaoRzKQMemeizwrIYzCEOorFekN1ia40IRV6cgABmUsfK
         tyXju7wlCoKCFP6XsdblrnylsaJjDF4ddFrLb38Tel360GICQjsxS4OZN+MNzZ4tS7yD
         hED3XILIt7nsHxh9PZNOUXbFEqKcmMgyTT3MZSALv8JyFyGfyxn5Xj0NNPF5TzEpQie9
         glaNgqnU/ejJJ2Df5dIGbHLqzcKgl1euUMdMiQt85sgWA5NQbP8YhpS5UReLIx+5RYvD
         sBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W13mDQpZsO3npuqGR4YYjbz9Yk1yrAuDJ3FVDoTdpvQ=;
        b=00dJXYSEBMDeaOEN0/rxF4OLeQAapJS0s6G3a1rM5eRrGeargjDoh1Yr0iDcjcBE52
         CK284en/dn98DQpQ/+5MEGguxy/Xhro8B0L5V4+APsv/d+M62oow7FahPkZsLzDfNxQr
         EVvOdCxiRAH55Gg7pssKLzAaEI//9F98GGL2qEiapY5+/GLAV3CRWUvFwp9QiYQ16DEP
         zf+MCNyRHeWdYoHW6rQ3ayiNmXxueOe098MCGre4JsD2uujT5pW0ojMsejQmt02NThaJ
         2h+LvdEm2Niwo97JO+9dOLXk1fXRh+NVfj1j9aXEq7KA6JPiv1VgCR+poy7e/hlc1mIj
         FmUg==
X-Gm-Message-State: AO0yUKVQXzqo+QMKdF9o7x9zdmT/xjl1FS+o4jC3iTNYcO5f/DYLwKtP
        0po0MVL5zSRxzY5/0AE+SJv1N+ZI29k=
X-Google-Smtp-Source: AK7set9qWJKJfGdnkAo2pLo/vrSmHKVD+Eup2ANJBOfNtpIZM1Msq3kfFh+jF+E6yNWTAwGrE4NNLQ==
X-Received: by 2002:a5d:678b:0:b0:2c5:5870:b589 with SMTP id v11-20020a5d678b000000b002c55870b589mr17628029wru.14.1678468866409;
        Fri, 10 Mar 2023 09:21:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18-20020a056000137200b002c7163660a9sm287440wrz.105.2023.03.10.09.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:21:06 -0800 (PST)
Message-Id: <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 17:20:56 +0000
Subject: [PATCH v2 1/8] for-each-ref: add --stdin option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When a user wishes to input a large list of patterns to 'git
for-each-ref' (likely a long list of exact refs) there are frequently
system limits on the number of command-line arguments.

Add a new --stdin option to instead read the patterns from standard
input. Add tests that check that any unrecognized arguments are
considered an error when --stdin is provided. Also, an empty pattern
list is interpreted as the complete ref set.

When reading from stdin, we populate the filter.name_patterns array
dynamically as opposed to pointing to the 'argv' array directly. This
requires a careful cast while freeing the individual strings,
conditioned on the --stdin option.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-for-each-ref.txt |  7 +++++-
 builtin/for-each-ref.c             | 29 ++++++++++++++++++++++-
 t/t6300-for-each-ref.sh            | 37 ++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6da899c6296..ccdc2911bb9 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
-		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
+		   [(--sort=<key>)...] [--format=<format>]
+		   [ --stdin | <pattern>... ]
 		   [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
@@ -32,6 +33,10 @@ OPTIONS
 	literally, in the latter case matching completely or from the
 	beginning up to a slash.
 
+--stdin::
+	If `--stdin` is supplied, then the list of patterns is read from
+	standard input instead of from the argument list.
+
 --count=<count>::
 	By default the command shows all refs that match
 	`<pattern>`.  This option makes it stop after showing
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6f62f40d126..e005a7ef3ce 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -25,6 +25,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_format format = REF_FORMAT_INIT;
 	struct strbuf output = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
+	int from_stdin = 0;
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
@@ -49,6 +50,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
 		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
+		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
 		OPT_END(),
 	};
 
@@ -75,7 +77,27 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 
-	filter.name_patterns = argv;
+	if (from_stdin) {
+		struct strbuf line = STRBUF_INIT;
+		size_t nr = 0, alloc = 16;
+
+		if (argv[0])
+			die(_("unknown arguments supplied with --stdin"));
+
+		CALLOC_ARRAY(filter.name_patterns, alloc);
+
+		while (strbuf_getline(&line, stdin) != EOF) {
+			ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
+			filter.name_patterns[nr++] = strbuf_detach(&line, NULL);
+		}
+
+		/* Add a terminating NULL string. */
+		ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
+		filter.name_patterns[nr + 1] = NULL;
+	} else {
+		filter.name_patterns = argv;
+	}
+
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL);
 	ref_array_sort(sorting, &array);
@@ -97,5 +119,10 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	free_commit_list(filter.with_commit);
 	free_commit_list(filter.no_commit);
 	ref_sorting_release(sorting);
+	if (from_stdin) {
+		for (size_t i = 0; filter.name_patterns[i]; i++)
+			free((char *)filter.name_patterns[i]);
+		free(filter.name_patterns);
+	}
 	return 0;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c466fd989f1..a58053a54c5 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1464,4 +1464,41 @@ sig_crlf="$(printf "%s" "$sig" | append_cr; echo dummy)"
 sig_crlf=${sig_crlf%dummy}
 test_atom refs/tags/fake-sig-crlf contents:signature "$sig_crlf"
 
+test_expect_success 'git for-each-ref --stdin: empty' '
+	>in &&
+	git for-each-ref --format="%(refname)" --stdin <in >actual &&
+	git for-each-ref --format="%(refname)" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git for-each-ref --stdin: fails if extra args' '
+	>in &&
+	test_must_fail git for-each-ref --format="%(refname)" \
+		--stdin refs/heads/extra <in 2>err &&
+	grep "unknown arguments supplied with --stdin" err
+'
+
+test_expect_success 'git for-each-ref --stdin: matches' '
+	cat >in <<-EOF &&
+	refs/tags/multi*
+	refs/heads/amb*
+	EOF
+
+	cat >expect <<-EOF &&
+	refs/heads/ambiguous
+	refs/tags/multi-ref1-100000-user1
+	refs/tags/multi-ref1-100000-user2
+	refs/tags/multi-ref1-200000-user1
+	refs/tags/multi-ref1-200000-user2
+	refs/tags/multi-ref2-100000-user1
+	refs/tags/multi-ref2-100000-user2
+	refs/tags/multi-ref2-200000-user1
+	refs/tags/multi-ref2-200000-user2
+	refs/tags/multiline
+	EOF
+
+	git for-each-ref --format="%(refname)" --stdin <in >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

