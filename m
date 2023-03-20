Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E2AC7618D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 11:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCTL1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCTL1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 07:27:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3035E524C
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so2396039wmq.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311618;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzWG7yCW5ur5d7QC+XEvdDFRu02hEqMdMKyfKCZeia0=;
        b=bIQM3/lFeegWiwD94eUiV+gdE3oirdAi1MFZ1WdLsnzFKzuy/yY6rMDzaxttUgcF6+
         hY50fa4e8J///1rsymbrmHPwqUhFCcPW85RNT+gMvOE17NFOh4uznFrZiSLZYDIYN0Vn
         agvtsJBLutU4Ma8V1l0NuQKwLi+ojr9FOEcvFIRTTF+kSEK9H9gER/AK9mX0gC63aLob
         qP48y07Q+VRNgYJxTvD1puxBkyf2T5zImOKCb93FFzy0LfOnfUcgzL1AKp2aut3VWlrQ
         qREQWP2JLrHb6urop5/uiyPXnHeTNlLtMSLjWER9X3anyGCwrb3dvztw1+n4FiIyWnhp
         NWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311618;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzWG7yCW5ur5d7QC+XEvdDFRu02hEqMdMKyfKCZeia0=;
        b=JS9JC3fYx4aXS0grdrtn8tMDlt9Ws/pmIYFmVDiNmAXongpKK4ASoNYB68tvi1DOcy
         s7Zg7m3jy3hsoVLQeA1dHz4qscS129i7WXLTyocRNu7LWHjaOR4TwvHcngDWVPxLVwEU
         9ZxismknsH6G8A16Vdr5RysJJyHsFynXr/vSRSscQVrXvuJ1loLvsEEDnzNI1mux3Hzr
         WJdr9imrxMrGrxJEgrQGzYhF5nvE7tGzWv+6f6c7WsroPqWSkDnS4AkBNChp9lPMItfo
         B8BBcSjwx3wilhc7/9yfGHUskv3y4AS5szS4T+jlQa3Ab0ZUEQ+lnfl8U9zlbpuonjk9
         yDjg==
X-Gm-Message-State: AO0yUKVDe83olf3c6Xsw45c+p3OrTUlIh9tGujNbE8bmZVe1c9NaCJFi
        utS50SVh9PWUmXyXWOjPd38xafeDNtA=
X-Google-Smtp-Source: AK7set9tXduoAsvREjRE79Qksj5lm3OFASlCGryFo4oRRhn4VSZ28X4/RhDqy61o8RRuKADWKEXXww==
X-Received: by 2002:a05:600c:4f01:b0:3ed:31cf:fe6e with SMTP id l1-20020a05600c4f0100b003ed31cffe6emr15753408wmq.41.1679311618484;
        Mon, 20 Mar 2023 04:26:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c025000b003ed1ff06faasm10195386wmj.19.2023.03.20.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:26:58 -0700 (PDT)
Message-Id: <27d94077aa98c7ea76787ac8c2a8fd15915c9eab.1679311616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
References: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
        <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 11:26:47 +0000
Subject: [PATCH v4 1/9] for-each-ref: add --stdin option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
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
dynamically as opposed to pointing to the 'argv' array directly. This is
simple when using a strvec, as it is NULL-terminated in the same way. We
then free the memory directly from the strvec.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-for-each-ref.txt |  7 +++++-
 builtin/for-each-ref.c             | 23 ++++++++++++++++++-
 t/t6300-for-each-ref.sh            | 37 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 2 deletions(-)

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
index 6f62f40d126..9df16cfb854 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "parse-options.h"
 #include "ref-filter.h"
+#include "strvec.h"
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
@@ -25,6 +26,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_format format = REF_FORMAT_INIT;
 	struct strbuf output = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
+	int from_stdin = 0;
+	struct strvec vec = STRVEC_INIT;
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
@@ -49,6 +52,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
 		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
+		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
 		OPT_END(),
 	};
 
@@ -75,7 +79,23 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 
-	filter.name_patterns = argv;
+	if (from_stdin) {
+		struct strbuf line = STRBUF_INIT;
+
+		if (argv[0])
+			die(_("unknown arguments supplied with --stdin"));
+
+		while (strbuf_getline(&line, stdin) != EOF)
+			strvec_push(&vec, line.buf);
+
+		strbuf_release(&line);
+
+		/* vec.v is NULL-terminated, just like 'argv'. */
+		filter.name_patterns = vec.v;
+	} else {
+		filter.name_patterns = argv;
+	}
+
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL);
 	ref_array_sort(sorting, &array);
@@ -97,5 +117,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	free_commit_list(filter.with_commit);
 	free_commit_list(filter.no_commit);
 	ref_sorting_release(sorting);
+	strvec_clear(&vec);
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

