Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08BC1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeDBUII (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:08:08 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33955 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbeDBUIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:08:07 -0400
Received: by mail-wm0-f51.google.com with SMTP id w2so7842082wmw.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VkwJEWLa5WWhB4XFkT+we6zA6rwC6/0/70RxpUeoDek=;
        b=or6n8EGYvpoBujgPEJ+FLTpUOtlz47GKpqgEOTbNrhQUc5cpW7eahz0Gzk5xw3Ve3D
         EFyhqu1snV1VLsxAvW9zLzvXFUJ50y8inrNOot88mE9nScy2xLPd39cLl00CZcjo2iLA
         1DvLSVEx6ZgKTXGBZXTLkMOPJbUhO+6hbsugkyqPnf/LJiKVtw/04ZU+V4QJJ60sTcBi
         na0lsNDwcYKJEgjnSmNXIDouj7pzP30q6f8omp9UslTLfy3XHYULcEBXjX+jZGVjrVnP
         U4SX3JQjQv2yByGPzCxn7DU+PIMYBx/Xfa47D26vHLi5s4ByCWRCjwY/7c7UoukInXh3
         qAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VkwJEWLa5WWhB4XFkT+we6zA6rwC6/0/70RxpUeoDek=;
        b=VsouOZZl6u9MNfFDkXglFVXKY5pyA1vv4fb3ezO/+775u3ouB2S7gUm/CQ3ScMxHG2
         86uAVNksS8IWGeL/sd1ur6ygAbm71CVoGx6cVuwYuLawL16HBwk3SNOBY5hOxbMzvL+g
         mycHUku+6tFxyfOpVvIZCNEsRFhuUte0fvlINMABggGuOd6ivU2Yk40V7o3AB+8lNurz
         8fjsj++AONEvCNZK9xCKgblvYPTBnjBnCSbcHL/UrCmUO1UCQnS7E0xH0VENGoPWYsLu
         qOF9tBX2R7IMhbKdd5Rnwc4ZtQwNv2iaz0yZR9MmeC/N6omh+g+7XgjWAxRZAs8xq+iB
         iJ1A==
X-Gm-Message-State: ALQs6tDzH77TYe9xpeZS+QF7EB4pD7xFz6XsyPiiqCLzm4bjtKE21kt8
        hk5/OQLm6vudLLV+qOZzMP9H8bZU
X-Google-Smtp-Source: AIpwx4/LUPbdYI5msYPK3RNzmcr6DlKMUpsgP8NAvjdNrNfc71QjuIniY84t2cH/bkPHw/NRuYRdoQ==
X-Received: by 10.46.145.212 with SMTP id u20mr2594973ljg.48.1522699685254;
        Mon, 02 Apr 2018 13:08:05 -0700 (PDT)
Received: from localhost.localdomain (c-5eea2412-74736162.cust.telenor.se. [94.234.36.18])
        by smtp.gmail.com with ESMTPSA id k25sm179899ljk.20.2018.04.02.13.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:08:04 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH] ls-remote: create '--sort' option
Date:   Mon,  2 Apr 2018 22:07:36 +0200
Message-Id: <20180402200736.80161-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <[PATCH] ls-remote: create option to sort by versions>
References: <[PATCH] ls-remote: create option to sort by versions>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a '--sort' option for ls-remote. This is useful e.g. for the Go
repository after the release of version 1.10, where by default v1.10 is
sorted before v1.2. See:

	$ git ls-remote -t https://go.googlesource.com/go
	...
	205f850ceacfc39d1e9d76a9569416284594ce8c        refs/tags/go1.1
	d260448f6b6ac10efe4ae7f6dfe944e72bc2a676        refs/tags/go1.1.1
	1d6d8fca241bb611af51e265c1b5a2e9ae904702        refs/tags/go1.1.2
	bf86aec25972f3a100c3aa58a6abcbcc35bdea49        refs/tags/go1.10
	ac7c0ee26dda18076d5f6c151d8f920b43340ae3        refs/tags/go1.10.1
	9ce6b5c2ed5d3d5251b9a6a0c548d5fb2c8567e8        refs/tags/go1.10beta1
	594668a5a96267a46282ce3007a584ec07adf705        refs/tags/go1.10beta2
	5348aed83e39bd1d450d92d7f627e994c2db6ebf        refs/tags/go1.10rc1
	20e228f2fdb44350c858de941dff4aea9f3127b8        refs/tags/go1.10rc2
	1c5438aae896edcd1e9f9618f4776517f08053b3        refs/tags/go1.1rc2
	46a6097aa7943a490e9bd2e04274845d0e5e200f        refs/tags/go1.1rc3
	402d3590b54e4a0df9fb51ed14b2999e85ce0b76        refs/tags/go1.2
	9c9802fad57c1bcb72ea98c5c55ea2652efc5772        refs/tags/go1.2.1
	...

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-ls-remote.txt | 12 +++++++++++-
 builtin/ls-remote.c             | 27 +++++++++++++++++++++++++--
 t/t5512-ls-remote.sh            | 41 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5f2628c8f..17fae7218 100644
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
+	Sort based on the key given.  Prefix `-` to sort in
+	descending order of the value. You may use the --sort=<key> option
+	multiple times, in which case the last key becomes the primary
+	key. Also supports "version:refname" or "v:refname" (tag
+	names are treated as versions). The "version:refname" sort
+	order can also be affected by the "versionsort.suffix"
+	configuration variable.
+	The keys supported are the same as those in `git for-each-ref`.
+
 <repository>::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 540d56429..5521c72f4 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "transport.h"
+#include "ref-filter.h"
 #include "remote.h"
 
 static const char * const ls_remote_usage[] = {
@@ -47,6 +48,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *ref;
+	struct ref_array array;
+	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print remote URL")),
@@ -60,6 +63,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
+		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
+			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		OPT_SET_INT_F(0, "exit-code", &status,
 			      N_("exit with exit code 2 if no matching refs are found"),
 			      2, PARSE_OPT_NOCOMPLETE),
@@ -68,6 +73,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	memset(&array, 0, sizeof(array));
+
 	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest = argv[0];
@@ -108,9 +115,25 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
+
+		struct ref_array_item *item;
+		FLEX_ALLOC_MEM(item, refname, ref->name, strlen(ref->name));
+		item->symref = ref->symref;
+		item->objectname = ref->old_oid;
+
+		REALLOC_ARRAY(array.items, array.nr + 1);
+		array.items[array.nr++] = item;
+	}
+
+	if (sorting) {
+		ref_array_sort(sorting, &array);
+	}
+
+	for (int i = 0; i < array.nr; i++) {
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

