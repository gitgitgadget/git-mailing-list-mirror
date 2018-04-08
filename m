Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29AC81F404
	for <e@80x24.org>; Sun,  8 Apr 2018 12:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDHM2z (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 08:28:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34380 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeDHM2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 08:28:53 -0400
Received: by mail-wr0-f195.google.com with SMTP id d19so1736300wre.1
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=//slVdyuM65CS0xWpc9QhnW7kRwRVk5+cTN+C9PdU6E=;
        b=hmSGh1cwzjPiwvwuJxQ2O4JxWDFOgw4d4H6OgKckBVI+WH0hJPKDQSZf4JrCPiVPf1
         3Yr74FwyEzPjYRC2LwH4aYXsmjHdG1t2ew2qv/+bhVG+0LF8uAP+/8TO93tIigydC70h
         DNP/rlCCL2GJEqHggVd+eeKRtdZek+MAMJA67Zc0D8Z4UmiaUtVEr34SqcoqR/yzOF9a
         HRyL4pKGanIdt+O4J5cesN1LCjCxpF11PJXvt+2iJ9o5hXUILPWPBANk1mUVsoETpey1
         vM6WGXAAA72PYdnN/H0T6tRF5pS/gZwcmz+/tgkRbETEPigYnBRnZgDZoLGIW6rn7mq+
         P9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=//slVdyuM65CS0xWpc9QhnW7kRwRVk5+cTN+C9PdU6E=;
        b=s8HaK0YAYRqxFsPozlYuspkzlFu/3pFzIag66SgU0mfIwhCPTxapFcNNs15px+9yig
         XqzWmAgSgHXks+YneR2U0xQQ6iUVVEL6HaCIeCpARv16ZN1W6azEC8QOpGJrvwCOAAIN
         xP+dYW8Qse7agu15eGoVbjX2VUJFiTGxqmdlFcVVHHmEST3RpdCGTveFqtQSSwemZJ/Z
         DjB+xzWF6rQtPBEuQOckvB1cqtC6+BG+PPAcymfOcBvBmL357ISmYrAU1UoLFBiIFU2o
         9QGCE5KFItacA2NgxN9RKMSw429x+WGZz/Y6HESkGYhyf/SJsm/LrhLEvOUISkU8sy3j
         mfqw==
X-Gm-Message-State: ALQs6tDl4BTsytjcz/RDy/udgw6eJFXsd1lhDN7bwfHKL5302acfMa0+
        iUIyU4w5DwJuRtQU5ROXME66WSo9iJs=
X-Google-Smtp-Source: AIpwx4+O55CHmeHSZT+xFTwdkEJfSLmWx5irYYzR9GlMjoBxvWYDOKOdwEsFvZJ9W1k1uJS8OkDHbQ==
X-Received: by 2002:a19:53cf:: with SMTP id h76-v6mr19992756lfl.87.1523190531721;
        Sun, 08 Apr 2018 05:28:51 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id p9-v6sm2965038lfh.93.2018.04.08.05.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 05:28:51 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v12 4/4] ls-remote: create '--sort' option
Date:   Sun,  8 Apr 2018 14:28:32 +0200
Message-Id: <20180408122832.65414-4-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180408122832.65414-1-haraldnordgren@gmail.com>
References: <20180408122832.65414-1-haraldnordgren@gmail.com>
In-Reply-To: <20180402005248.52418-1-haraldnordgren@gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a '--sort' option for ls-remote, based on the one from
for-each-ref. This e.g. allows ref names to be sorted by version
semantics, so that v1.2 is sorted before v1.10.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---

Notes:
    Changes according to Eric Sunshine's code review

 Documentation/git-ls-remote.txt | 16 ++++++++++++-
 builtin/ls-remote.c             | 30 +++++++++++++++++++++---
 t/t5512-ls-remote.sh            | 52 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5f2628c8f..80a09b518 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
-	      [-q | --quiet] [--exit-code] [--get-url]
+	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
 	      [--symref] [<repository> [<refs>...]]
 
 DESCRIPTION
@@ -60,6 +60,16 @@ OPTIONS
 	upload-pack only shows the symref HEAD, so it will be the only
 	one shown by ls-remote.
 
+--sort=<key>::
+	Sort based on the key given. Prefix `-` to sort in descending order
+	of the value. Supports "version:refname" or "v:refname" (tag names
+	are treated as versions). The "version:refname" sort order can also
+	be affected by the "versionsort.suffix" configuration variable.
+	See linkgit:git-for-each-ref[1] for more sort options, but be aware
+	that because `ls-remote` deals only with remotes, any key like
+	`committerdate` that requires access to the object itself will
+	cause a failure.
+
 <repository>::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
@@ -90,6 +100,10 @@ EXAMPLES
 	c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
 	7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
 
+SEE ALSO
+--------
+linkgit:git-check-ref-format[1].
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 540d56429..d3851074c 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "transport.h"
+#include "ref-filter.h"
 #include "remote.h"
 
 static const char * const ls_remote_usage[] = {
@@ -43,10 +44,13 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int show_symref_target = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
+	int i;
 
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *ref;
+	struct ref_array ref_array;
+	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print remote URL")),
@@ -60,6 +64,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
+		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
+			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		OPT_SET_INT_F(0, "exit-code", &status,
 			      N_("exit with exit code 2 if no matching refs are found"),
 			      2, PARSE_OPT_NOCOMPLETE),
@@ -68,6 +74,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	memset(&ref_array, 0, sizeof(ref_array));
+
 	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest = argv[0];
@@ -90,6 +98,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	if (get_url) {
 		printf("%s\n", *remote->url);
+		UNLEAK(sorting);
 		return 0;
 	}
 
@@ -98,20 +107,35 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
 	ref = transport_get_remote_refs(transport);
-	if (transport_disconnect(transport))
+	if (transport_disconnect(transport)) {
+		UNLEAK(sorting);
 		return 1;
+	}
 
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
 	for ( ; ref; ref = ref->next) {
+		struct ref_array_item *item;
 		if (!check_ref_type(ref, flags))
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
+		item = ref_array_push(&ref_array, ref->name, &ref->old_oid);
+		item->symref = xstrdup_or_null(ref->symref);
+	}
+
+	if (sorting)
+		ref_array_sort(sorting, &ref_array);
+
+	for (i = 0; i < ref_array.nr; i++) {
+		const struct ref_array_item *ref = ref_array.items[i];
 		if (show_symref_target && ref->symref)
-			printf("ref: %s\t%s\n", ref->symref, ref->name);
-		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
+			printf("ref: %s\t%s\n", ref->symref, ref->refname);
+		printf("%s\t%s\n", oid_to_hex(&ref->objectname), ref->refname);
 		status = 0; /* we found something */
 	}
+
+	UNLEAK(sorting);
+	UNLEAK(ref_array);
 	return status;
 }
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 02106c922..e8df4c7e0 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -10,6 +10,9 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m initial &&
 	git tag mark &&
+	git tag mark1.1 &&
+	git tag mark1.2 &&
+	git tag mark1.10 &&
 	git show-ref --tags -d | sed -e "s/ /	/" >expected.tag &&
 	(
 		echo "$(git rev-parse HEAD)	HEAD"
@@ -39,6 +42,39 @@ test_expect_success 'ls-remote self' '
 	test_cmp expected.all actual
 '
 
+test_expect_success 'ls-remote --sort="version:refname" --tags self' '
+	cat >expect <<-\EOF &&
+	'$(git rev-parse mark)'	refs/tags/mark
+	'$(git rev-parse mark1.1)'	refs/tags/mark1.1
+	'$(git rev-parse mark1.2)'	refs/tags/mark1.2
+	'$(git rev-parse mark1.10)'	refs/tags/mark1.10
+	EOF
+	git ls-remote --sort="version:refname" --tags self >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote --sort="-version:refname" --tags self' '
+	cat >expect <<-\EOF &&
+	'$(git rev-parse mark1.10)'	refs/tags/mark1.10
+	'$(git rev-parse mark1.2)'	refs/tags/mark1.2
+	'$(git rev-parse mark1.1)'	refs/tags/mark1.1
+	'$(git rev-parse mark)'	refs/tags/mark
+	EOF
+	git ls-remote --sort="-version:refname" --tags self >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote --sort="-refname" --tags self' '
+	cat >expect <<-\EOF &&
+	'$(git rev-parse mark1.2)'	refs/tags/mark1.2
+	'$(git rev-parse mark1.10)'	refs/tags/mark1.10
+	'$(git rev-parse mark1.1)'	refs/tags/mark1.1
+	'$(git rev-parse mark)'	refs/tags/mark
+	EOF
+	git ls-remote --sort="-refname" --tags self >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'dies when no remote specified and no default remotes found' '
 	test_must_fail git ls-remote
 '
@@ -131,7 +167,7 @@ test_expect_success 'Report no-match with --exit-code' '
 
 test_expect_success 'Report match with --exit-code' '
 	git ls-remote --exit-code other.git "refs/tags/*" >actual &&
-	git ls-remote . tags/mark >expect &&
+	git ls-remote . tags/mark* >expect &&
 	test_cmp expect actual
 '
 
@@ -170,14 +206,18 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	grep refs/tags/magic actual
 '
 
+git fetch origin
 test_expect_success 'ls-remote --symref' '
 	cat >expect <<-\EOF &&
 	ref: refs/heads/master	HEAD
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	'$(git rev-parse HEAD)'	HEAD
+	'$(git rev-parse refs/heads/master)'	refs/heads/master
+	'$(git rev-parse HEAD)'	refs/remotes/origin/HEAD
+	'$(git rev-parse refs/remotes/origin/master)'	refs/remotes/origin/master
+	'$(git rev-parse refs/tags/mark)'	refs/tags/mark
+	'$(git rev-parse refs/tags/mark1.1)'	refs/tags/mark1.1
+	'$(git rev-parse refs/tags/mark1.10)'	refs/tags/mark1.10
+	'$(git rev-parse refs/tags/mark1.2)'	refs/tags/mark1.2
 	EOF
 	git ls-remote --symref >actual &&
 	test_cmp expect actual
-- 
2.14.3 (Apple Git-98)

