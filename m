Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D140FC6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjCORqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjCORqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:46:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D5551F9C
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so5287442wrh.6
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me8GxrmOEisUVf0+uqtjfq9QHX6r3PDzxZZGj2gQv8c=;
        b=faUwF1VhIiwzSsO2W94HDwe3afR96/VPk3BrRm0fIEgWh9syY3L/kANR+TlLm5WGTL
         v+BEvH2F2P8ZhA9e2Dd/KZVpVWLTz+zyY+6qVYsFy1GVBjPqbFKk1eiik6dcEzr5BkX2
         hYJdQTZPEyxJU2L4FIWIIwlgkkOnUsJ02+OYsIFkQW/MpGDF3w+K5tbXDUHE2ZboGeuK
         dXqm/nw+3WN+3TUOD3BNRA7erDOXt6uH7lhUeTP0FOw/H/g0d30XpmXl1dHS+DU3jXp7
         e5WklQ8E6YLywt28jHAFpwVJwAPPkpztILfXzwdVJ1G+5ORGlyC6/PmcDHZnyTnFPugt
         DVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=me8GxrmOEisUVf0+uqtjfq9QHX6r3PDzxZZGj2gQv8c=;
        b=b9/ZOx42bNL389fIsT573r2LIc2VRJ0z+dycbPlzMgEiaq//5KAM785DTqWh7AiNlV
         DmduSQ3YLGyzrsRKgOs5Y/m5HUGIyJTinC3rLCHc4OoPudnaRmJYY19oH3pySVigP3ij
         36mOzcUtNOisnGppTLj25L5Sous6LSd2TBnOKV7EJGUHFYkfUN1Kftz6NoaII9/caJJh
         Hu+u9/qzHD8rauGO12bG75pKu0Hw35hUDOsT34WQ+wWcnLhwzFe04is2EELeIC/4Lx9o
         XRXXZeNsk9CsSZLPGFuq5mfbYX+BxFEBlxeSczNZKRjhtyAamGD3V7Fgko+f0AZFO5fQ
         OaWA==
X-Gm-Message-State: AO0yUKW1YgE2EhezsJbiwPbODv+w7BcuXaBg8byEzs6ivuBsUEAk7Z6N
        ETHPIm9Ndj4VHl2ca80oIMnJjStSykM=
X-Google-Smtp-Source: AK7set8WGuxobaSBfa/6fYHZS7cyMH5iW8V5K36ZmzKtHA8Gp65NSNYbPQqDacrIMP6q/Uus9PZqVg==
X-Received: by 2002:adf:de10:0:b0:2cf:ea38:ef29 with SMTP id b16-20020adfde10000000b002cfea38ef29mr2681911wrm.44.1678902345619;
        Wed, 15 Mar 2023 10:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b002c7107ce17fsm5265193wrt.3.2023.03.15.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:45:45 -0700 (PDT)
Message-Id: <f9e80e233f1ca26f07f9db49261e54b7deaf83b8.1678902343.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
References: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Mar 2023 17:45:36 +0000
Subject: [PATCH v3 1/8] for-each-ref: add --stdin option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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
 builtin/for-each-ref.c             | 21 ++++++++++++++++-
 t/t6300-for-each-ref.sh            | 37 ++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

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
index 6f62f40d126..4c5f2324793 100644
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
 
@@ -75,7 +79,21 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
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
+		/* vec.v is NULL-terminated, just like 'argv'. */
+		filter.name_patterns = vec.v;
+	} else {
+		filter.name_patterns = argv;
+	}
+
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL);
 	ref_array_sort(sorting, &array);
@@ -97,5 +115,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
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

