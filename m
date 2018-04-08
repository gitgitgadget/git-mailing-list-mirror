Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CBA1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeDHX6i (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:58:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36526 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbeDHX6g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:58:36 -0400
Received: by mail-wr0-f196.google.com with SMTP id y55so7090733wry.3
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=96Pp81XDiYluxdxAwDr1azU//xCb7rdnW1D/hW/5XPY=;
        b=BZ6veemqKB2wMHRuPexJ8IFOCipSbEhAs7W+txckKtye2585J66iN1nfu3IajS2+tw
         m2b6FRK+rkfJd9Jes5gcXFObSHmUpFoZ1nuTdr/g9p7tjvB2PF+rouQLCW8/CzRHSF1j
         IAJWkeaGrzFoN1qcxGjgTtJrcN7zW6Zm3qDXQ5ik9K6X50YnfXbsd7bFDiUuVXPlL2Fk
         lHgFpaa6OEBgW/3a3VloOOG5LlOuiO6m1Bn67fhWi8FHUUhBiumkGoNtc4KXorse7Y7t
         M/pgiVKOcrzYJ0Gdypqm65JZVMCqd06NTj7tPaE/dRAIoQUzlouIELiV9h6/8sYmPsAK
         Fu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=96Pp81XDiYluxdxAwDr1azU//xCb7rdnW1D/hW/5XPY=;
        b=lvTocAKbZKx7VeodixpJVeIRwyDRFc7CG4LHoy2ZMgpZis4nKnYacRb2cdJg6DGHjw
         pWlGiPogQQUv5wjpJgIjw4fikGnMbl2RsPGb9yvDoCt4fyewUQYNUL9rVHANYxexpuPY
         7t6epKkuvjljwcbxAhr+APooBMENzKHjNT0VeShv4drt6S7JEZhS3MAMtaYqtYSqWXoy
         LR4nge6ylSYhy6AwqmLGcMf4BMewQru6pKmpRtKXqnm7ZSPcxzLy/icWREyBvY9YMiR6
         lCTElt4cu6ZKUSKUsgsTRXWtmajDfrM4m9rRafsSg0w3/e6kNnF8L60K3RLtudB1rAeG
         9HwQ==
X-Gm-Message-State: ALQs6tCgfGA4aaasi3XT9DtCLqMRRxUaYipf2UC5NTrVQKeXFAhYWbno
        ScZiKQ/rrKrJFg95IbymsbhWfWScKSU=
X-Google-Smtp-Source: AIpwx48XpptJh6Rfrgs0I3M+NKFcMrsP80X0BeVevd1getvpx/hsn9GbU8jGsn4TlPhlBhKjyQ2NSg==
X-Received: by 2002:a19:2ad5:: with SMTP id q82-v6mr20312893lfq.79.1523231914840;
        Sun, 08 Apr 2018 16:58:34 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id x4-v6sm3108742lfa.23.2018.04.08.16.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 16:58:34 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v13 4/4] ls-remote: create '--sort' option
Date:   Mon,  9 Apr 2018 01:58:15 +0200
Message-Id: <20180408235815.36582-4-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180408235815.36582-1-haraldnordgren@gmail.com>
References: <20180408235815.36582-1-haraldnordgren@gmail.com>
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
    Changes according to Junio Hamano's code review

 Documentation/git-ls-remote.txt | 17 ++++++++++++-
 builtin/ls-remote.c             | 25 +++++++++++++++++--
 t/t5512-ls-remote.sh            | 54 +++++++++++++++++++++++++++++++++++------
 3 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5f2628c8f..0e26a67a1 100644
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
@@ -60,6 +60,17 @@ OPTIONS
 	upload-pack only shows the symref HEAD, so it will be the only
 	one shown by ls-remote.
 
+--sort=<key>::
+	Sort based on the key given. Prefix `-` to sort in descending order
+	of the value. Supports "version:refname" or "v:refname" (tag names
+	are treated as versions). The "version:refname" sort order can also
+	be affected by the "versionsort.suffix" configuration variable.
+	See linkgit:git-for-each-ref[1] for more sort options, but be aware
+	that because `ls-remote` deals only with remotes, keys like
+	`committerdate` that requires access to the objects themselves will
+	not work for refs whose objects have not yet been fetched from the
+	remote.
+
 <repository>::
 	The "remote" repository to query.  This parameter can be
 	either a URL or the name of a remote (see the GIT URLS and
@@ -90,6 +101,10 @@ EXAMPLES
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
index 540d56429..b5ca67167 100644
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
@@ -104,14 +112,27 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
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
index 02106c922..83cd35c39 100755
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
+	cat >expect <<-EOF &&
+	$(git rev-parse mark)	refs/tags/mark
+	$(git rev-parse mark1.1)	refs/tags/mark1.1
+	$(git rev-parse mark1.2)	refs/tags/mark1.2
+	$(git rev-parse mark1.10)	refs/tags/mark1.10
+	EOF
+	git ls-remote --sort="version:refname" --tags self >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote --sort="-version:refname" --tags self' '
+	cat >expect <<-EOF &&
+	$(git rev-parse mark1.10)	refs/tags/mark1.10
+	$(git rev-parse mark1.2)	refs/tags/mark1.2
+	$(git rev-parse mark1.1)	refs/tags/mark1.1
+	$(git rev-parse mark)	refs/tags/mark
+	EOF
+	git ls-remote --sort="-version:refname" --tags self >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-remote --sort="-refname" --tags self' '
+	cat >expect <<-EOF &&
+	$(git rev-parse mark1.2)	refs/tags/mark1.2
+	$(git rev-parse mark1.10)	refs/tags/mark1.10
+	$(git rev-parse mark1.1)	refs/tags/mark1.1
+	$(git rev-parse mark)	refs/tags/mark
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
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	ref: refs/heads/master	HEAD
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	$(git rev-parse HEAD)	HEAD
+	$(git rev-parse refs/heads/master)	refs/heads/master
+	$(git rev-parse HEAD)	refs/remotes/origin/HEAD
+	$(git rev-parse refs/remotes/origin/master)	refs/remotes/origin/master
+	$(git rev-parse refs/tags/mark)	refs/tags/mark
+	$(git rev-parse refs/tags/mark1.1)	refs/tags/mark1.1
+	$(git rev-parse refs/tags/mark1.10)	refs/tags/mark1.10
+	$(git rev-parse refs/tags/mark1.2)	refs/tags/mark1.2
 	EOF
 	git ls-remote --symref >actual &&
 	test_cmp expect actual
-- 
2.14.3 (Apple Git-98)

