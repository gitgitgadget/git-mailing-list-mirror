Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BFFC433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhL1N3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbhL1N27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:28:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5F5C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e5so38388394wrc.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTVfyjirTNb1gaLuV5PFc+rtsbxmrD69sqOgEzr165E=;
        b=pjF2hllIvEeoC2E2djKP29goEqNbXJX2x00kiMwmm9vQkzhXvIZlvZwqurXEiox5Sp
         DBJ3b6tQO1HEZSNurJp2aUyzFhe7WNGxvvr3H5D9QnZBjNgA95umfPL1SOKxVNSl4ifd
         5OgWGH5eFNW8QMRasDXzwnZpxFDjaPW7OtvkzT/qcadHQcS+1uM+GzjHkkJj9dzME1A0
         B0BjRpzqq6vSknKMeUHUrff+sfrD/tp80T/9DLXoyp3moHc2jSqfq6oHuvt1KapGoxid
         MJpA+qtgXkpiTrwitRXOIt7eL8JmIxoNwA8RIasrqPFvA8GuwV2qM4Q3yGXnGufHgynm
         ww3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTVfyjirTNb1gaLuV5PFc+rtsbxmrD69sqOgEzr165E=;
        b=a0Wf++R0JYGGo1ero/ptn8LRJvgyeMHM0dLeYkcaTPiZ8LDhXjUlYPwPneOvEdmj2l
         JrrLW4hl2GDsYlhZOTgtcXQr+JRv/GS75dZQF8AW2Rlj1NSpka1bDpFEk25BmJIuHxrS
         hH7mj/PinHOzP76jFw2i9XLdDAlkR78DEFlvpIVfZXgBQQqNNwBh/t5uLdJ17iCr0asS
         RxZu+f6NjnnjBN+sJy1yd3hgZMYzR+ni3m6x+9+OaY8HuI5PHkdhfeTAWuZFD6VuU6uh
         /79rqSZLm7MSjkrg9z0VxdZgtkQPAlJSDFGflOQfoce4uv/UFfSncMT2MsOoi3kho/i7
         y9vQ==
X-Gm-Message-State: AOAM530B+qT1e0kO2WiljcS5/QtpzkuYhKKuKbDW/mIIzlf6tWj5fkL2
        0dDwCpyHmDzTVeVi/8EluqpMgANe82IvoBPm
X-Google-Smtp-Source: ABdhPJw12s1HFBA94Zeq5gIEjnqE9u8X6KNL/u8x3Rq+ZKTt8aXpSBNXxV9+CfkZRAIUICVFEcZG/w==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr5532117wrq.96.1640698137353;
        Tue, 28 Dec 2021 05:28:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 06/10] cat-file: make --batch-all-objects a CMDMODE
Date:   Tue, 28 Dec 2021 14:28:46 +0100
Message-Id: <patch-v6-06.10-30ed6617de8-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usage of OPT_CMDMODE() in "cat-file"[1] was added in parallel with
the development of[3] the --batch-all-objects option[4], so we've
since grown[5] checks that it can't be combined with other command
modes, when it should just be made a top-level command-mode
instead. It doesn't combine with --filters, --textconv etc.

By giving parse_options() information about what options are mutually
exclusive with one another we can get the die() message being removed
here for free, we didn't even use that removed message in some cases,
e.g. for both of:

    --batch-all-objects --textconv
    --batch-all-objects --filters

We'd take the "goto usage" in the "if (opt)" branch, and never reach
the previous message. Now we'll emit e.g.:

    $ git cat-file --batch-all-objects --filters
    error: option `filters' is incompatible with --batch-all-objects

1. b48158ac94c (cat-file: make the options mutually exclusive, 2015-05-03)
2. https://lore.kernel.org/git/xmqqtwspgusf.fsf@gitster.dls.corp.google.com/
3. https://lore.kernel.org/git/20150622104559.GG14475@peff.net/
4. 6a951937ae1 (cat-file: add --batch-all-objects option, 2015-06-22)
5. 321459439e1 (cat-file: support --textconv/--filters in batch mode, 2016-09-09)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c  | 25 +++++++++++--------------
 t/t1006-cat-file.sh |  7 ++-----
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6d0f645301b..87356208134 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -674,6 +674,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			    N_("for blob objects, run textconv on object's content"), 'c'),
 		OPT_CMDMODE(0, "filters", &opt,
 			    N_("for blob objects, run filters on object's content"), 'w'),
+		OPT_CMDMODE(0, "batch-all-objects", &opt,
+			    N_("show all objects with --batch or --batch-check"), 'b'),
 		OPT_STRING(0, "path", &force_path, N_("blob"),
 			   N_("use a specific path for --textconv/--filters")),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
@@ -689,8 +691,6 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			batch_option_callback),
 		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
 			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
-		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
-			 N_("show all objects with --batch or --batch-check")),
 		OPT_BOOL(0, "unordered", &batch.unordered,
 			 N_("do not order --batch-all-objects output")),
 		OPT_END()
@@ -699,30 +699,27 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	git_config(git_cat_file_config, NULL);
 
 	batch.buffer_output = -1;
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	if (opt) {
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc && batch.enabled)
+		usage_with_options(usage, options);
+	if (opt == 'b') {
+		batch.all_objects = 1;
+	} else if (opt) {
 		if (batch.enabled && (opt == 'c' || opt == 'w'))
 			batch.cmdmode = opt;
 		else if (argc == 1)
 			obj_name = argv[0];
 		else
 			usage_with_options(usage, options);
-	}
-	if (!opt && !batch.enabled) {
+	} else if (!opt && !batch.enabled) {
 		if (argc == 2) {
 			exp_type = argv[0];
 			obj_name = argv[1];
 		} else
 			usage_with_options(usage, options);
-	}
-	if (batch.enabled) {
-		if (batch.cmdmode != opt || argc)
-			usage_with_options(usage, options);
-		if (batch.cmdmode && batch.all_objects)
-			die("--batch-all-objects cannot be combined with "
-			    "--textconv nor with --filters");
-	}
+	} else if (batch.enabled && batch.cmdmode != opt)
+		usage_with_options(usage, options);
 
 	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
 		usage_with_options(usage, options);
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8a29f96809d..2ce5c8b1824 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -14,7 +14,8 @@ for switches in \
 	'-p -t' \
 	'-t -s' \
 	'-s --textconv' \
-	'--textconv --filters'
+	'--textconv --filters' \
+	'--batch-all-objects -e'
 do
 	test_expect_success "usage: cmdmode $switches" '
 		test_cmdmode_usage git cat-file $switches
@@ -41,10 +42,6 @@ do
 	test_expect_success "usage: $opt requires another option" '
 		test_expect_code 129 git cat-file $opt
 	'
-
-	test_expect_failure "usage: incompatible options: --batch-all-objects with $opt" '
-		test_incompatible_usage git cat-file --batch-all-objects $opt
-	'
 done
 
 for opt in $short_modes
-- 
2.34.1.1257.g2af47340c7b

