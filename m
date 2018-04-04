Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33D21F404
	for <e@80x24.org>; Wed,  4 Apr 2018 23:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeDDXcx (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 19:32:53 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34675 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeDDXcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 19:32:52 -0400
Received: by mail-wr0-f177.google.com with SMTP id d17so9992998wre.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZIjVvcnyOu6ZCwjWpdyZ0KxyhRsBTo9814/+bQNw4rk=;
        b=gxxExyQ67D9Kyd84x/ZXDgOQ3AY1APRn0tUO1lFsIP4jJwXVVSWJqKq+MEEBoiYd7x
         611AhTxlI6lWaQpQVfzk2K/DA7qcvRs7koVaJj5b+e9YKYdMwSYu66q+0BeB/WLxv2tK
         VrViwyHu6c+xYzGu/IVwPF8g3dUVD049fNad9NISoeLOt1aOFOPFnN4nnu3tAIANwgfC
         8z7XbCmK1ib07jnwXR7J5d5G/0+XgXEzOQlcp6XwASN/fMFIep0EELI18zXqAzABgB+b
         DPXBAHvVhebedXyNDNr1+vcn1r3gPhO8yfINXjX/D7v+7pSmXgptzV+sOKeZLork+xG+
         gC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZIjVvcnyOu6ZCwjWpdyZ0KxyhRsBTo9814/+bQNw4rk=;
        b=RmIAsvlh8XTn0G8SLdp7N+Oy/1IryeYxYqHkwTH5iNzgJ/5zbXN9OU/DVTwSdO1Q+J
         XALuNzKuOoGH7LhDH+qY5lN8ZQ8K7TdplE4tRJY+J6IZieYPY7AfWfe/yPLcxovk0UP0
         /B6kW1hG39jsdyFNBoVkQM2N0tva5KpCBjsAsz9qJO8j7TlUFn0e4dKI1GuI44DAV83U
         NSoHOrYgvDtj1t1bDlB2nopc+zJ5C5plBwAhAzUp6t4kAAy8DehMzRUlQW+n39jOPoWg
         QX2SWpL+nyZF6+aRbhVimNe0NRZxQ305qf8C0ByeAHQpurjUKJBiwPz/xhgAeFyPlTxZ
         3qGg==
X-Gm-Message-State: ALQs6tAoaywz+BbvR7pkn0Bz3Ld/8ZMVTgmM/7Abv+SxMfuNql+Oh5ZB
        xbYTmoJrEVeawnjFdbOe+73quAgV0aw=
X-Google-Smtp-Source: AIpwx48LpVpKQ3YtF6n3S2gT6gj/thBaVkcV+zlquecpbn2KJEmozzEupo/eb0maq8yL1lAkJOyjmw==
X-Received: by 2002:a19:1903:: with SMTP id 3-v6mr11795607lfz.59.1522884770410;
        Wed, 04 Apr 2018 16:32:50 -0700 (PDT)
Received: from localhost.localdomain (c-5eea2375-74736162.cust.telenor.se. [94.234.35.117])
        by smtp.gmail.com with ESMTPSA id t6sm1052139ljd.55.2018.04.04.16.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 16:32:49 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v9] ls-remote: create '--sort' option
Date:   Thu,  5 Apr 2018 01:32:32 +0200
Message-Id: <20180404233232.14913-1-haraldnordgren@gmail.com>
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
    Create 'ref_array_push' function in ref-filter

 Documentation/git-ls-remote.txt | 15 ++++++++++++++-
 builtin/ls-remote.c             | 20 ++++++++++++++++++--
 ref-filter.c                    | 12 ++++++++++++
 ref-filter.h                    |  2 ++
 t/t5512-ls-remote.sh            | 41 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 86 insertions(+), 4 deletions(-)

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
index 540d56429..f87b2657c 100644
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
@@ -108,9 +116,17 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
+		ref_array_push(&array, ref);
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
diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216..a5686dacd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1861,6 +1861,18 @@ static int ref_kind_from_refname(const char *refname)
 	return FILTER_REFS_OTHERS;
 }
 
+void ref_array_push(struct ref_array *array, const struct ref *ref)
+{
+	struct ref_array_item *item;
+
+	FLEX_ALLOC_STR(item, refname, ref->name);
+	item->symref = xstrdup_or_null(ref->symref);
+	oidcpy(&item->objectname, &ref->old_oid);
+
+	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
+	array->items[array->nr++] = item;
+}
+
 static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 {
 	if (filter->kind == FILTER_REFS_BRANCHES ||
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b3..43e713a72 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -127,6 +127,8 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 char *get_head_description(void);
 /*  Set up translated strings in the output. */
 void setup_ref_filter_porcelain_msg(void);
+/*  Create a ref_array_item from a ref and push it to the ref_array */
+void ref_array_push(struct ref_array *array, const struct ref *ref);
 
 /*
  * Print a single ref, outside of any ref-filter. Note that the
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

