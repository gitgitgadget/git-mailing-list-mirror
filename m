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
	by dcvr.yhbt.net (Postfix) with ESMTP id E07171F404
	for <e@80x24.org>; Mon,  9 Apr 2018 01:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932909AbeDIBmz (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 21:42:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53437 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932933AbeDIBmr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 21:42:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id 66so8719328wmd.3
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qSVTKpjfalkJPvElj6z34aEX0nJl2qpsL//Ip9zUaNw=;
        b=m7F2iPz5meAZ+/pW0zh37hAJovlExVL5aFT8CMQTo3Yrd2d/4uASpy2Vz3B98fVt9T
         8s7y9K3WwAwQvhICvpmH2pAebd87ed7+bemsP4ElTIX7RxYiK3KCnS0fMgM8fB2k9CV9
         w36AlUrYiW118gixaQdqPq9wjsHC6GiFzN5sIkB/FjfSoQwke6aRU7qiZ38Yeu2JHRgI
         7mbY2FSVTP7e6G4qEuuSxL21gpPOgjX//2OttrX74kwpvcTh7lae4YadiX4MTfswOCPk
         p0N8Ei9GZbgI4AcbhICmxCi8VXYIV0t3cHKIh04opePkQBuLefPXGgJlAqFlsZreZ2Sx
         ndlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qSVTKpjfalkJPvElj6z34aEX0nJl2qpsL//Ip9zUaNw=;
        b=ggDO88WR269lpST69G6cYJe6LYcIjDCyD2UQOtK8CxrUe+rTJD9AR3DbYct1KNulrn
         iICUMEWxOyiicTaJ36G+dqOSqjJwORcU2Du6ZxtS7u4Bw/kJAXEu7hIEzrnNi4hd6lC8
         3sfxfIa/wLnfX+MAneyFf3tJbgNBChfsvD2ShFnahSi2tp9engXWo2wBQ4y/Bt0p6uqd
         VsQKWIM+4QY03UN+VckfqEN8WdP5N6TzcM/RYUaO+NsWktOgfz0+5JDbZ1fjiPOaXmHn
         GE6jttOr7ixgDyhIudLCEqDyAMac4zUAMb+f5KS1ys4f8nG8gTzLOQ/CjCPiPCOqgmcT
         +Cyg==
X-Gm-Message-State: ALQs6tAKvw1MWqSqI+9P5Uu14EyY7j7k11Tvn3hwGM9xHZJKsrrCe5L8
        rAaugNT1PNKyJAJMZBAfr0T5qUZdeyE=
X-Google-Smtp-Source: AIpwx48yki3swc1JW4HZyeMFR3vpRaQ5SzgR/4xqUAkPBFB1jpAqCPNrpYwJwnb4wV43WpRMi4q3lg==
X-Received: by 10.46.137.71 with SMTP id b7mr14791476ljk.39.1523238165457;
        Sun, 08 Apr 2018 18:42:45 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id n62-v6sm3197231lfi.4.2018.04.08.18.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 18:42:44 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v14 4/4] ls-remote: create '--sort' option
Date:   Mon,  9 Apr 2018 03:42:26 +0200
Message-Id: <20180409014226.2647-4-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180409014226.2647-1-haraldnordgren@gmail.com>
References: <20180409014226.2647-1-haraldnordgren@gmail.com>
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
    Changes according to Junio Hamano's code review (2)

 Documentation/git-ls-remote.txt | 16 +++++++++++-
 builtin/ls-remote.c             | 28 ++++++++++++++++++---
 t/t5512-ls-remote.sh            | 54 +++++++++++++++++++++++++++++++++++------
 3 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5f2628c8f..6ad1e34af 100644
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
+	keys like `committerdate` that require access to the objects
+	themselves will not work for refs whose objects have not yet been
+	fetched from the remote, and will give a `missing object` error.
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
index 540d56429..b26c53670 100644
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
 
@@ -98,20 +107,33 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
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

