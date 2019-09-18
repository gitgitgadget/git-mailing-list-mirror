Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC001F463
	for <e@80x24.org>; Wed, 18 Sep 2019 00:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfIRAM2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 20:12:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36871 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfIRAM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 20:12:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4so4975582edy.4
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 17:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=domanski-co.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MWzWGYHQyJB2DZDdkveeDTj6tgepO6M2fRs7U0w9b9s=;
        b=uFQHQ/WMs8Y8902gerkGiP8KcBUp0xT/mxtiTfzAD8Z+Y4JRKSLJ/E2bGue+H7JWQu
         ofbD5sSItThTOIxXIKnmegt+A4dTeOvO0pLXRBQB7wEjoER9CEhMMcJ5tCg7X+NRGJXd
         SoVtaqrv8LFT1zCs4E32iXOvUG9pP1nr79Cztp8r4bG8kFfuZDQKwYcd97RqTQhI5NBj
         iOyMyIeLv2FFeMZXw1koAGqclG0Z3loA2NlbMVb7U33/YNpW8lgkpegARgFlIxadp6Fm
         p35ihx4jnHiN5qE15iZxVctCHdmP+HksNsr+vGhciOaBQ4/En92nQlshq+laSWTeyq0v
         T3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MWzWGYHQyJB2DZDdkveeDTj6tgepO6M2fRs7U0w9b9s=;
        b=VtHKUBCDrw9daOGQT0xY09LkXmZbOBfGDjAFoBrsT9jPHXR2iYTb8fRqard3gE+kY1
         vLeUaJ9K7Q850UW0SIdFO4L07o/Rc6t/3cK7iTHW9CryInYqSVGfO+LIuKOaEI3W42bn
         4K53AuJ3o7TTO0Fe+uxY3lHzahNBaV5+M+Dz0HdAuHpowVcAgi4Ivvy5MO0nqVwsddfd
         XVYXps6iYclufJhcAxpqzqUBw2GUKhKgOZTNHGT1JyOpZBKQV3HEDVq6wongxwd8GmUf
         vxXaGN90+pFGgHzKzjXlwpRHzTv4/9qYRcE694YwCvWiPcNG4GhWpZBGjkvYdchNba9V
         /WJg==
X-Gm-Message-State: APjAAAUgDV2Ff/Iu8kMYFXR7Qrqhw+gFxNqNBAKL+Fem14GXz5ujTffI
        Rwt3QVN7vDQR1pLq1ghBi6sSiGBlY48=
X-Google-Smtp-Source: APXvYqxx5ezTgyt8LII4csfglc7KkMQX3O60vrF66062wcwC1Pd076NPNBmt6fDMlnv/dCFI2Oc83Q==
X-Received: by 2002:a50:935d:: with SMTP id n29mr7510705eda.294.1568765544341;
        Tue, 17 Sep 2019 17:12:24 -0700 (PDT)
Received: from admiral.h.domanski.co ([2a04:4540:6b26:8900:b1b6:6577:8cba:8314])
        by smtp.gmail.com with ESMTPSA id j9sm698175edt.15.2019.09.17.17.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 17:12:23 -0700 (PDT)
From:   =?UTF-8?q?Kamil=20Doma=C5=84ski?= <kamil@domanski.co>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Kamil=20Doma=C5=84ski?= <kamil@domanski.co>
Subject: [PATCH] ls-remote: create '--count' option
Date:   Wed, 18 Sep 2019 02:11:34 +0200
Message-Id: <20190918001134.20776-1-kamil@domanski.co>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a '--count' option for ls-remote, based on the one from
for-each-ref. This allows e.g. to return only the first result
from a sorted list of refs.

Signed-off-by: Kamil Domański <kamil@domanski.co>
---
 Documentation/git-ls-remote.txt | 11 ++++++++---
 builtin/ls-remote.c             | 16 ++++++++++++----
 t/t5512-ls-remote.sh            |  9 +++++++++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 0b057cbb10..5adc1d676e 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -9,9 +9,9 @@ git-ls-remote - List references in a remote repository
 SYNOPSIS
 --------
 [verse]
-'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
-	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
-	      [--symref] [<repository> [<refs>...]]
+'git ls-remote' [--count=<count>] [--heads] [--tags] [--refs]
+	      [--upload-pack=<exec>] [-q | --quiet] [--exit-code] [--get-url]
+	      [--sort=<key>] [--symref] [<repository> [<refs>...]]
 
 DESCRIPTION
 -----------
@@ -21,6 +21,11 @@ commit IDs.
 
 OPTIONS
 -------
+--count=<count>::
+	By default the command shows all refs that match
+	`<pattern>`.  This option makes it stop after showing
+	that many refs.
+
 -h::
 --heads::
 -t::
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 6ef519514b..482b8c5b3c 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -8,7 +8,7 @@
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
 	   "                     [-q | --quiet] [--exit-code] [--get-url]\n"
-	   "                     [--symref] [<repository> [<refs>...]]"),
+	   "                     [--symref] [--count=<n>] [<repository> [<refs>...]]"),
 	NULL
 };
 
@@ -43,6 +43,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	int status = 0;
 	int show_symref_target = 0;
+	int maxcount = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
@@ -55,7 +56,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct ref_array ref_array;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 
-	struct option options[] = {
+	struct option opts[] = {
 		OPT__QUIET(&quiet, N_("do not print remote URL")),
 		OPT_STRING(0, "upload-pack", &uploadpack, N_("exec"),
 			   N_("path of git-upload-pack on the remote host")),
@@ -73,14 +74,19 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			      2, PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "symref", &show_symref_target,
 			 N_("show underlying ref in addition to the object pointed by it")),
+		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
 		OPT_END()
 	};
 
 	memset(&ref_array, 0, sizeof(ref_array));
 
-	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
+	argc = parse_options(argc, argv, prefix, opts, ls_remote_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (maxcount < 0) {
+		error("invalid --count argument: `%d'", maxcount);
+		usage_with_options(ls_remote_usage, opts);
+	}
 	dest = argv[0];
 
 	if (argc > 1) {
@@ -138,7 +144,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (sorting)
 		ref_array_sort(sorting, &ref_array);
 
-	for (i = 0; i < ref_array.nr; i++) {
+	if (!maxcount || ref_array.nr < maxcount)
+		maxcount = ref_array.nr;
+	for (i = 0; i < maxcount; i++) {
 		const struct ref_array_item *ref = ref_array.items[i];
 		if (show_symref_target && ref->symref)
 			printf("ref: %s\t%s\n", ref->symref, ref->refname);
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 43e1d8d4d2..5c27a126bd 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -75,6 +75,15 @@ test_expect_success 'ls-remote --sort="-refname" --tags self' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-remote --count=2 --sort="refname" --tags self' '
+	cat >expect <<-EOF &&
+	$(git rev-parse mark)	refs/tags/mark
+	$(git rev-parse mark1.1)	refs/tags/mark1.1
+	EOF
+	git ls-remote --count=2 --sort="refname" --tags self >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'dies when no remote specified and no default remotes found' '
 	test_must_fail git ls-remote
 '
-- 
2.23.0

