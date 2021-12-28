Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AFAC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhL1N3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbhL1N3A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:29:00 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B383DC06173F
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k18so1668720wrg.11
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+Yfz2q++ej0v6zItQ6ZKWYpeo4F+K0YSc0mE39wLFs=;
        b=UrVPYAaX1ZEucbC9WUGriBZZxq6RsCHjlI8Z7BR6x7WVSwOsyM577Kb2XPZRSN9QYP
         M9oYXVMDGWMR+tSjkYtQHp3TLiXC+Qw3G2JGvcEVI3qh4tAXrsHk8921OwOqBOf9OjMd
         vjU0eKAk+olT18bDuUuPXHlCMfWDqtEjEv6kC0Y5kidOm1a4FN1tzDXKojEhzdEipOMU
         JDb4nqTdlnDjLWrTuMpO5d7IBXZh2C2Cm94/6P6GJFx1FubqSH2xV097jeEZLKUXwk4R
         xS4zTEumb63PCm+8sw4AF4+J/nuBY1DE+l1pa/yBe0AcmlmR+SgNmfipvomLitukR2F8
         H0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+Yfz2q++ej0v6zItQ6ZKWYpeo4F+K0YSc0mE39wLFs=;
        b=EGfBn+hLqKMn4l0bLWrinI9/xxejg4J3yJmyH/rT/p0f/PhD6/WJPiOuu1Zv78zcmV
         9x2Jj2M0A/JeyEUqM45tAO0cA1Kdstbz/rX+fEnwQDQZzMIipJkL1QfG0WvxPEGKO/OJ
         nWABbjUM4e6Z5tHdhAWzqbl1KUdR94iAP4tB1WOg5qYeOJTVi9xDm92oX0l445m0RFrx
         tsJlbqXEfcoGTqdgIonjot+njE0TIep6d52gt4ddXDlsAbWC3Ox+M6MuMvzxbeCiMZFX
         zhhU+SApgw6zQQfpIKPe22TxuOvR078pFG99Kz4es7PPqf5IQp8rjqIqV5CrrLwQDL0n
         Ab+w==
X-Gm-Message-State: AOAM533AjbY9cyGvHD2gK+mKzPPA2Lwa3CR3cZj3L8qWEpX0QaEBLUY+
        fd2pVevrkIcD/cGDpnG5uHnBdW3dSqcZnsHY
X-Google-Smtp-Source: ABdhPJzsbVrfoJb+RqgSOLPnbkB3QTnVEr2Yc6FD5FBqltVNmC0bSw54Ugaj80YVEgE0WNOA6wextQ==
X-Received: by 2002:adf:ea0d:: with SMTP id q13mr15917980wrm.597.1640698138075;
        Tue, 28 Dec 2021 05:28:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 07/10] cat-file: fix remaining usage bugs
Date:   Tue, 28 Dec 2021 14:28:47 +0100
Message-Id: <patch-v6-07.10-bf24dd063c9-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the migration of --batch-all-objects to OPT_CMDMODE() in the
preceding commit one bug with combining it and other OPT_CMDMODE()
options was solved, but we were still left with e.g. --buffer silently
being discarded when not in batch mode.

Fix all those bugs, and in addition emit errors telling the user
specifically what options can't be combined with what other options,
before this we'd usually just emit the cryptic usage text and leave
the users to work it out by themselves.

This change is rather large, because to do so we need to untangle the
options processing so that we can not only error out, but emit
sensible errors, and e.g. emit errors about options before errors
about stray argc elements (as they might become valid if the option
were removed).

Some of the output changes ("error:" to "fatal:" with
usage_msg_opt[f]()), but none of the exit codes change, except in
those cases where we silently accepted bad option combinations before,
now we'll error out.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c  | 95 ++++++++++++++++++++++++++++++---------------
 t/t1006-cat-file.sh | 41 +++++++++----------
 2 files changed, 84 insertions(+), 52 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 87356208134..895292074ae 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -648,6 +648,8 @@ static int batch_option_callback(const struct option *opt,
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	int opt = 0;
+	int opt_cw = 0;
+	int opt_epts = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {0};
 	int unknown_type = 0;
@@ -701,45 +703,74 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	batch.buffer_output = -1;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	if (argc && batch.enabled)
-		usage_with_options(usage, options);
-	if (opt == 'b') {
-		batch.all_objects = 1;
-	} else if (opt) {
-		if (batch.enabled && (opt == 'c' || opt == 'w'))
-			batch.cmdmode = opt;
-		else if (argc == 1)
-			obj_name = argv[0];
-		else
-			usage_with_options(usage, options);
-	} else if (!opt && !batch.enabled) {
-		if (argc == 2) {
-			exp_type = argv[0];
-			obj_name = argv[1];
-		} else
-			usage_with_options(usage, options);
-	} else if (batch.enabled && batch.cmdmode != opt)
-		usage_with_options(usage, options);
+	opt_cw = (opt == 'c' || opt == 'w');
+	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
-	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
-		usage_with_options(usage, options);
-	}
-
-	if (force_path && opt != 'c' && opt != 'w') {
-		error("--path=<path> needs --textconv or --filters");
-		usage_with_options(usage, options);
-	}
+	/* --batch-all-objects? */
+	if (opt == 'b')
+		batch.all_objects = 1;
 
-	if (force_path && batch.enabled) {
-		error("--path=<path> incompatible with --batch");
-		usage_with_options(usage, options);
-	}
+	/* Option compatibility */
+	if (force_path && !opt_cw)
+		usage_msg_optf(_("'%s=<%s>' needs '%s' or '%s'"),
+			       usage, options,
+			       "--path", _("path|tree-ish"), "--filters",
+			       "--textconv");
 
+	/* Option compatibility with batch mode */
+	if (batch.enabled)
+		;
+	else if (batch.follow_symlinks)
+		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+			       "--follow_symlinks");
+	else if (batch.buffer_output >= 0)
+		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+			       "--buffer");
+	else if (batch.all_objects)
+		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+			       "--batch-all-objects");
+
+	/* Batch defaults */
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
 
-	if (batch.enabled)
+	/* Return early if we're in batch mode? */
+	if (batch.enabled) {
+		if (opt_cw)
+			batch.cmdmode = opt;
+		else if (opt && opt != 'b')
+			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
+				       usage, options, opt);
+		else if (argc)
+			usage_msg_opt(_("batch modes take no arguments"), usage,
+				      options);
+
 		return batch_objects(&batch);
+	}
+
+	if (opt) {
+		if (!argc && opt == 'c')
+			usage_msg_optf(_("<rev> required with '%s'"),
+				       usage, options, "--textconv");
+		else if (!argc && opt == 'w')
+			usage_msg_optf(_("<rev> required with '%s'"),
+				       usage, options, "--filters");
+		else if (!argc && opt_epts)
+			usage_msg_optf(_("<object> required with '-%c'"),
+				       usage, options, opt);
+		else if (argc == 1)
+			obj_name = argv[0];
+		else
+			usage_msg_opt(_("too many arguments"), usage, options);
+	} else if (!argc) {
+		usage_with_options(usage, options);
+	} else if (argc != 2) {
+		usage_msg_optf(_("only two arguments allowed in <type> <object> mode, not %d"),
+			      usage, options, argc);
+	} else if (argc) {
+		exp_type = argv[0];
+		obj_name = argv[1];
+	}
 
 	if (unknown_type && opt != 't' && opt != 's')
 		die("git cat-file --allow-unknown-type: use with -s or -t");
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 2ce5c8b1824..964b3bc0b40 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -24,7 +24,7 @@ done
 
 test_incompatible_usage () {
 	test_expect_code 129 "$@" 2>err &&
-	grep -E "^error:.**needs" err
+	grep -E "^(fatal|error):.*(requires|incompatible with|needs)" err
 }
 
 for opt in --batch --batch-check
@@ -34,48 +34,54 @@ do
 	'
 done
 
+test_missing_usage () {
+	test_expect_code 129 "$@" 2>err &&
+	grep -E "^fatal:.*required" err
+}
+
 short_modes="-e -p -t -s"
 cw_modes="--textconv --filters"
 
 for opt in $cw_modes
 do
 	test_expect_success "usage: $opt requires another option" '
-		test_expect_code 129 git cat-file $opt
+		test_missing_usage git cat-file $opt
 	'
 done
 
 for opt in $short_modes
 do
 	test_expect_success "usage: $opt requires another option" '
-		test_expect_code 129 git cat-file $opt
+		test_missing_usage git cat-file $opt
 	'
 
 	for opt2 in --batch \
 		--batch-check \
-		--follow-symlinks
+		--follow-symlinks \
+		"--path=foo HEAD:some-path.txt"
 	do
-		test_expect_failure "usage: incompatible options: $opt and $opt2" '
+		test_expect_success "usage: incompatible options: $opt and $opt2" '
 			test_incompatible_usage git cat-file $opt $opt2
 		'
 	done
-
-	opt2="--path=foo HEAD:some-path.txt"
-	test_expect_success "usage: incompatible options: $opt and $opt2" '
-		test_incompatible_usage git cat-file $opt $opt2
-	'
 done
 
+test_too_many_arguments () {
+	test_expect_code 129 "$@" 2>err &&
+	grep -E "^fatal: too many arguments$" err
+}
+
 for opt in $short_modes $cw_modes
 do
 	args="one two three"
 	test_expect_success "usage: too many arguments: $opt $args" '
-		test_expect_code 129 git cat-file $opt $args
+		test_too_many_arguments git cat-file $opt $args
 	'
 
 	for opt2 in --buffer --follow-symlinks
 	do
 		test_expect_success "usage: incompatible arguments: $opt with batch option $opt2" '
-			test_expect_code 129 git cat-file $opt $opt2
+			test_incompatible_usage git cat-file $opt $opt2
 		'
 	done
 done
@@ -84,14 +90,9 @@ for opt in --buffer \
 	--follow-symlinks \
 	--batch-all-objects
 do
-	status=success
-	if test $opt = "--buffer"
-	then
-		status=failure
-	fi
-	test_expect_$status "usage: bad option combination: $opt without batch mode" '
-		test_expect_code 129 git cat-file $opt &&
-		test_expect_code 129 git cat-file $opt commit HEAD
+	test_expect_success "usage: bad option combination: $opt without batch mode" '
+		test_incompatible_usage git cat-file $opt &&
+		test_incompatible_usage git cat-file $opt commit HEAD
 	'
 done
 
-- 
2.34.1.1257.g2af47340c7b

