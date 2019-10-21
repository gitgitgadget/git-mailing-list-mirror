Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1FF1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 10:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfJUKZ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 06:25:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40341 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUKZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 06:25:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so12174497wmj.5
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HMvEyMtQ6rknd/W2z3oI/7vtWKqTCXS9NqLV0AaFNZU=;
        b=nhtaF5rez2jQbI36lhJlSQoFds8ojAovJLaJE9uBYJZ1OotZ5OfnU9GTxlSsF/ftUA
         0nP+jInhGtrBCxTQbhhA0Y15Nu2JO83L9rpAnAJ3P2Y1xkmQWjSXF6WKhNY8N/OZk/iS
         ycCXMW599h6kNiuDPIRxSM+CSiPVvIgnPfw2rUHpb2r2FwCP8av/4Kc0v482bEBnQhY8
         C042p4J7AGuJoMSCmDI+7uyxqdRO/y0rKs2yE+f2WCLus/sIxTEXbhQuNJq4Fgu21M/5
         /Go0I6pd0J3yedBIsxyADVM9fWTZ0fkjexajBUESKijF7rkvKNl5JHuTuHlJPJ8V9SFj
         e/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HMvEyMtQ6rknd/W2z3oI/7vtWKqTCXS9NqLV0AaFNZU=;
        b=PX4sF/pL3UXCOv4Zt6/JZno0+OvqCTIbnZeFSGBRX+VOdqnNLnjk8qK5CGHTfbBTDr
         0MtOFgGuONmjEIE0zx2CAfIfiWqWtrlgVEz3q1NE/+CWaRL5TMAkjJZtZJou0Lq5jqAU
         HatZ5iYTsTd4mG0ITZhRvb5CXpcpyS8vGFsqK9j1iZ7NlgWjisBDnq/jqqTnCw+HPqXi
         aRIvQsE8XvcwL5Wy5o1DRAm9fTmUVcVlaCJReJGJRhnX5es4kl/mhLIQVp4JPh4oh1Dw
         kjFURr6xqmpaqwzqT/kmaoo3lJdIY6R6mmTyXA5U6LxHdXdo+7fppT+9bNUcWC2mQSJk
         DGiQ==
X-Gm-Message-State: APjAAAU0v3YXiU6KJFqys3nV5eMxkUhceNOQep6EQ9OHqmwvyYwMc9EY
        0qO9OkAQXsOE6X4qn1w=
X-Google-Smtp-Source: APXvYqybAEufrbzOvVUQdZahnLR9N7Gx7g+AKjLaFtJ0C6JwE17OCryKALM++lw0kyejvt8aZIuu7w==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr5954045wmc.124.1571653524789;
        Mon, 21 Oct 2019 03:25:24 -0700 (PDT)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id y186sm18084848wmb.41.2019.10.21.03.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:25:24 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 1/2] format-patch: create leading components of output directory
Date:   Mon, 21 Oct 2019 12:25:22 +0200
Message-Id: <ac3cc3df4452355dc41c58fe94961c37ca09ebec.1571653441.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.13.g28bc381d7c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git format-patch -o <outdir>' did an equivalent of 'mkdir <outdir>'
not 'mkdir -p <outdir>', which is being corrected.

Avoid the usage of 'adjust_shared_perm' on the leading directories which
may have security implications. Achieved by temporarily disabling of
'config.sharedRepository' like 'git init' does.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Changes in v2:
 * squashed and base new tests on 'dl/format-patch-doc-test-cleanup'

Changes in v3:
 * avoid applying adjust_shared_perm

Changes in v4:
 * based on dl/format-patch-doc-test-cleanup and adopt it

Changes in v5:
 * make tests self-contained

Cc: Denton Liu <liu.denton@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config/format.txt    |  2 +-
 Documentation/git-format-patch.txt |  3 ++-
 builtin/log.c                      | 16 ++++++++++++++++
 t/t4014-format-patch.sh            | 26 ++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index cb629fa769..40cad9278f 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -81,7 +81,7 @@ format.coverLetter::
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
-	current working directory.
+	current working directory. All directory components will be created.
 
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0ac56f4b70..2035d4d5d5 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -66,7 +66,8 @@ they are created in the current working directory. The default path
 can be set with the `format.outputDirectory` configuration option.
 The `-o` option takes precedence over `format.outputDirectory`.
 To store patches in the current working directory even when
-`format.outputDirectory` points elsewhere, use `-o .`.
+`format.outputDirectory` points elsewhere, use `-o .`. All directory
+components will be created.
 
 By default, the subject of a single patch is "[PATCH] " followed by
 the concatenation of lines from the commit message up to the first blank
diff --git a/builtin/log.c b/builtin/log.c
index 44b10b3415..8d08632858 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1765,10 +1765,26 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	if (output_directory) {
+		int saved;
 		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
 			rev.diffopt.use_color = GIT_COLOR_NEVER;
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
+		/*
+		 * We consider <outdir> as 'outside of gitdir', therefore avoid
+		 * applying adjust_shared_perm in s-c-l-d.
+		 */
+		saved = get_shared_repository();
+		set_shared_repository(0);
+		switch (safe_create_leading_directories_const(output_directory)) {
+		case SCLD_OK:
+		case SCLD_EXISTS:
+			break;
+		default:
+			die(_("could not create leading directories "
+			      "of '%s'"), output_directory);
+		}
+		set_shared_repository(saved);
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
 			die_errno(_("could not create directory '%s'"),
 				  output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 72b09896cf..3aab25da76 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1606,6 +1606,32 @@ test_expect_success 'From line has expected format' '
 	test_cmp from filtered
 '
 
+test_expect_success 'format-patch -o with no leading directories' '
+	rm -fr patches &&
+	git format-patch -o patches master..side &&
+	count=$(git rev-list --count master..side) &&
+	ls patches >list &&
+	test_line_count = $count list
+'
+
+test_expect_success 'format-patch -o with leading existing directories' '
+	rm -rf existing-dir &&
+	mkdir existing-dir &&
+	git format-patch -o existing-dir/patches master..side &&
+	count=$(git rev-list --count master..side) &&
+	ls existing-dir/patches >list &&
+	test_line_count = $count list
+'
+
+test_expect_success 'format-patch -o with leading non-existing directories' '
+	rm -rf non-existing-dir &&
+	git format-patch -o non-existing-dir/patches master..side &&
+	count=$(git rev-list --count master..side) &&
+	test_path_is_dir non-existing-dir
+	ls non-existing-dir/patches >list &&
+	test_line_count = $count list
+'
+
 test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
-- 
2.23.0.13.g28bc381d7c

