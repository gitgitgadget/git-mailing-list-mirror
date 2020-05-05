Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88975C47256
	for <git@archiver.kernel.org>; Tue,  5 May 2020 07:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61592206B8
	for <git@archiver.kernel.org>; Tue,  5 May 2020 07:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o06HK8aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgEEHSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727849AbgEEHSQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 03:18:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B21C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 00:18:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q7so1367959qkf.3
        for <git@vger.kernel.org>; Tue, 05 May 2020 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGvBMwrMw/Jke1W9yf+uLgXQlMeaYPy36ynvxuvq4kQ=;
        b=o06HK8aaOE7E6Z2qP4/dyw1E1TnIIAJU9KD8R5UPpbHWjdE7lukkH5wV12cWDoyOaz
         vpdZ5onv3ErFX2/hBif4wFnmeNsF74X8omgPYbRntnrCL55q8OT6PBwmfiJYej+KEY94
         Gqy24Hee+5dPJm/517KZHGF4lDDj2K9pNKsDRMFIYYF3Xf0Jt2a8QkXQGZmoDQiOhkJ6
         /eW/fvyFB3mX4jaXQhaaxGrHpWV69E5FWGoWHXagH4FqIfsU8rh/zRcMNa4N8e/MnBdB
         A8u+iSLKgGTq5t/1k7U6j3/uHpJxKhm3RzQ57J8JjZnDKSvOnzKVsIYVBuOB7nvEolff
         MceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dGvBMwrMw/Jke1W9yf+uLgXQlMeaYPy36ynvxuvq4kQ=;
        b=gF2dXc2jW7Q8SG5LgF4zeq2cz91an1VjMtppUPOjLaAXr75X/HMibTgEwx5hgmj9Cf
         rw5b85fk/MN+DnK4JeqSx8tGlvxEJgAY5lRQas6so1HksE2fyIuv3eV0QtRN6y5Cv2wm
         DDDopoKnHEPV4MvwgBVlxhnKpmio8x35z9t7JEd0gGNHh68c4t6Jxm15UmHe9GeaWQQO
         xbAU1LbLvkCVMiM96tFUa7rIG0sNYPW7kye5rMHZUOtnrHhRPTXmYhwDg8KXPfRw73hx
         PiP9rzeyOj5V6Ckf5E6w8ORUMmdOU60KIc7rrJjfGB+OoPAsD4kYgV5khkGzULQfuonB
         J2FQ==
X-Gm-Message-State: AGi0Pub0rgSZwzk4M7In9202d9A5n/alfyHoQ5RH+NhDE3ehIH+mb8uZ
        NB4rWrKhNNYx/P/0+RRpFytlrJHV
X-Google-Smtp-Source: APiQypKx1Lc/2kTxjrjviW0ytlRgt0Pb/IKhwsIHnRpjV5l2Mb5BJ21M+k4n/JouPlV21HZqDNdsmg==
X-Received: by 2002:a05:620a:49e:: with SMTP id 30mr2007396qkr.294.1588663095119;
        Tue, 05 May 2020 00:18:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r51sm1019307qtk.89.2020.05.05.00.18.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 00:18:14 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Harri=20Meht=C3=A4l=C3=A4?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/1] restore: default to HEAD when combining --staged and --worktree
Date:   Tue,  5 May 2020 03:17:16 -0400
Message-Id: <20200505071716.23240-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <20200505071716.23240-1-sunshine@sunshineco.com>
References: <20200505071716.23240-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, files are restored from the index for --worktree, and from
HEAD for --staged. When --worktree and --staged are combined, --source
must be specified to disambiguate the restore source[1], thus making it
cumbersome to restore a file in both the worktree and the index.

However, HEAD is also a reasonable default for --worktree when combined
with --staged, so make it the default anytime --staged is used (whether
combined with --worktree or not).

[1]: Due to an oversight, the --source requirement, though documented,
is not actually enforced.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-restore.txt | 11 ++++-------
 builtin/checkout.c            |  6 +++---
 t/t2070-restore.sh            | 11 +++++++++++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 8e3b339802..84c6c40010 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -22,9 +22,8 @@ The command can also be used to restore the content in the index with
 `--staged`, or restore both the working tree and the index with
 `--staged --worktree`.
 
-By default, the restore sources for working tree and the index are the
-index and `HEAD` respectively. `--source` could be used to specify a
-commit as the restore source.
+By default, if `--staged` is given, the contents are restored from `HEAD`,
+otherwise from the index. Use `--source` to restore from a different commit.
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
@@ -39,10 +38,8 @@ OPTIONS
 	tree. It is common to specify the source tree by naming a
 	commit, branch or tag associated with it.
 +
-If not specified, the default restore source for the working tree is
-the index, and the default restore source for the index is
-`HEAD`. When both `--staged` and `--worktree` are specified,
-`--source` must also be specified.
+If not specified, the contents are restored from `HEAD` if `--staged` is
+given, otherwise from the index.
 
 -p::
 --patch::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8bc94d392b..500c3e23ff 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1605,10 +1605,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
 		BUG("these flags should be non-negative by now");
 	/*
-	 * convenient shortcut: "git restore --staged" equals
-	 * "git restore --staged --source HEAD"
+	 * convenient shortcut: "git restore --staged [--worktree]" equals
+	 * "git restore --staged [--worktree] --source HEAD"
 	 */
-	if (!opts->from_treeish && opts->checkout_index && !opts->checkout_worktree)
+	if (!opts->from_treeish && opts->checkout_index)
 		opts->from_treeish = "HEAD";
 
 	/*
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 076d0df7fc..89e5a142c9 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -69,6 +69,17 @@ test_expect_success 'restore --staged uses HEAD as source' '
 	test_cmp expected actual
 '
 
+test_expect_success 'restore --worktree --staged uses HEAD as source' '
+	test_when_finished git reset --hard &&
+	git show HEAD:./first.t >expected &&
+	echo dirty >>first.t &&
+	git add first.t &&
+	git restore --worktree --staged first.t &&
+	git show :./first.t >actual &&
+	test_cmp expected actual &&
+	test_cmp expected first.t
+'
+
 test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
 	git init unmerged &&
 	(
-- 
2.26.2.672.g232c24e857

