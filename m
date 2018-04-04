Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA001F404
	for <e@80x24.org>; Wed,  4 Apr 2018 23:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeDDXBa (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 19:01:30 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:46562 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeDDXB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 19:01:29 -0400
Received: by mail-wr0-f180.google.com with SMTP id d1so25287822wrj.13
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KuiGWWa776xVxmqAHlfJEwGtnj76YBcQs6LmM2C2wSY=;
        b=HoNZQc+nxSDcTj6JHZOWJfhCbdiB5rFwKRTfgbqYDOlkTTtZlr7SSkqxL4W/tpOMYx
         l2l54oqxcS+mzNxogN26pe3BBLAxj0GctSn4ZVv+/nQ5VfYpBc9GUZTTTAoGACF/F48D
         FfALjtUhLpRwrt7e3dA3XVoL+Y7gw10kvZQJdkjRlBYOcwdtsU3suqYtFsldSmr74Yf9
         3p+75uhJdFvzICILuqb7I37/FHlpu/a+p2Jd+0YaoIMQGNFNwMJASmgpk0J0yzOT556u
         0VosahmJ/WJpA4JrH8nKk/vUJfzkbY1wNv6TGE3Unoe0STwHLZdQC/MaRDDEU2H1y9T/
         uwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KuiGWWa776xVxmqAHlfJEwGtnj76YBcQs6LmM2C2wSY=;
        b=mCI1D4PweZWXhyUZQYELF7gtq/NtER4b7KhKbteX24NlodoS0Zqge1UzUHth/U+u61
         +48pAiS4t3vYD+7bkIj5V5BwWcpNWV9MuhiBKX1ru4NqfRful4Q7TAIB04VE6qtuq6Z7
         m7hjtLixszXzo8+5Yq05piy57YM1H1xXxrM2GfOfjGIOEjF5sY9eSNPewAjxxI9h5W8N
         uO3cKHkfM97WtsArGdWKGvjeiH1AmKanVlzyoEeVYKZSGJUO30my5yRrPuYamX32sUOw
         mDwokBTCGFO+JUEL2jk0eL/ZSBtICy1stqMPXKz4h+T+gPpn/ftp9gmplXwToiXyDclG
         rPrg==
X-Gm-Message-State: ALQs6tDobOfWXzF2G6RWfZG+RmjAs/Hsn33X3a0fzFMHhOEZ4brwr0pG
        LNl6R1aUpAJTk069CNiQZr6rzpsqfv0=
X-Google-Smtp-Source: AIpwx49yydAD1mawCaKGkdow5jSp1Nzgq9tN8JUDabCmWa/xKB2iEN0tkannQgX8T9bF6xEM1auuOg==
X-Received: by 2002:a19:c713:: with SMTP id x19-v6mr12547035lff.32.1522882887747;
        Wed, 04 Apr 2018 16:01:27 -0700 (PDT)
Received: from localhost.localdomain (c-5eea2375-74736162.cust.telenor.se. [94.234.35.117])
        by smtp.gmail.com with ESMTPSA id x7-v6sm1205958lff.64.2018.04.04.16.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 16:01:26 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v8] ls-remote: create '--sort' option
Date:   Thu,  5 Apr 2018 01:01:10 +0200
Message-Id: <20180404230110.9950-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
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
    Partial fixes from Jeff King's comments

 Documentation/git-ls-remote.txt | 15 ++++++++++++++-
 builtin/ls-remote.c             | 27 +++++++++++++++++++++++++--
 t/t5512-ls-remote.sh            | 41 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5f2628c8f..fa4505fd7 100644
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
@@ -60,6 +60,19 @@ OPTIONS
 	upload-pack only shows the symref HEAD, so it will be the only
 	one shown by ls-remote.
 
+--sort=<key>::
+	Sort based on the key given.  Prefix `-` to sort in
+	descending order of the value. You may use the --sort=<key> option
+	multiple times, in which case the last key becomes the primary
+	key. Also supports "version:refname" or "v:refname" (tag
+	names are treated as versions). The "version:refname" sort
+	order can also be affected by the "versionsort.suffix"
+	configuration variable.
+	The keys supported are the same as those in `git for-each-ref`,
+	except that because `ls-remote` deals only with remotes, keys like
+	`committerdate` that require access to the objects themselves will
+	not work.
+
 <repository>::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 540d56429..fbec2bc95 100644
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
+	struct ref_array array;
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
 
+	memset(&array, 0, sizeof(array));
+
 	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest = argv[0];
@@ -104,13 +112,28 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
 	for ( ; ref; ref = ref->next) {
+		struct ref_array_item *item;
 		if (!check_ref_type(ref, flags))
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
+
+		FLEX_ALLOC_STR(item, refname, ref->name);
+		item->symref = xstrdup_or_null(ref->symref);
+		oidcpy(&item->objectname, &ref->old_oid);
+
+		ALLOC_GROW(array.items, array.nr + 1, array.alloc);
+		array.items[array.nr++] = item;
+	}
+
+	if (sorting)
+		ref_array_sort(sorting, &array);
+
+	for (i = 0; i < array.nr; i++) {
+		const struct ref_array_item *ref = array.items[i];
 		if (show_symref_target && ref->symref)
-			printf("ref: %s\t%s\n", ref->symref, ref->name);
-		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
+			printf("ref: %s\t%s\n", ref->symref, ref->refname);
+		printf("%s\t%s\n", oid_to_hex(&ref->objectname), ref->refname);
 		status = 0; /* we found something */
 	}
 	return status;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 02106c922..66370cd88 100755
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
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.1
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.2
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.10
+	EOF
+	git ls-remote --sort="version:refname" --tags self >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote --sort="-version:refname" --tags self' '
+	cat >expect <<-\EOF &&
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.10
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.2
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.1
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	EOF
+	git ls-remote --sort="-version:refname" --tags self >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote --sort="-refname" --tags self' '
+	cat >expect <<-\EOF &&
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.2
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.10
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.1
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
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
 
@@ -178,6 +214,9 @@ test_expect_success 'ls-remote --symref' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.1
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.10
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.2
 	EOF
 	git ls-remote --symref >actual &&
 	test_cmp expect actual
-- 
2.14.3 (Apple Git-98)

