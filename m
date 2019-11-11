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
	by dcvr.yhbt.net (Postfix) with ESMTP id A93EB1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKGER (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44938 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKGER (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so9909577pfn.11
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvhckOTi7yJkJ+fP0MtCiRWhSTZCUXYpJVLSditKkC0=;
        b=FEfKmsQZyaEM2Nts43LQ6tbQHa1c/YiThfG3XQnH+sRy2QkkWjircOguzn9SW6+hhH
         EyBbuJcTPfXaFEJo/Rgwyy3dhVJAQp0KecgKoXZiwL2wYRpThDKfrOH7TeAwkYljZw42
         poLD86po29bjuZsONrvip1ym+C+Q1PxuS4ExulcYX84RoaSNVNKxt8gswSnNG52QxoZV
         meCZ7NyeoNzh8zn/tCzNOL4KX2V9qdXyUMxG6sAlB+TFYfXgrm/p6xHovHoiD8XdKL8L
         pQxNCXs8g/b/U/kauKwS3MzAJLPfxDwktII5ft/P5AVeQkjuFnrGlQ87iqbAgL+h79z/
         9SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvhckOTi7yJkJ+fP0MtCiRWhSTZCUXYpJVLSditKkC0=;
        b=bT0aOWdweQdJa4Y/WH/or/ivRoTN6GqvA1TidI0RZap3YSMSICIJPzS/Jc/5sL+m5i
         42Fdu97a8ZR8d/3dD3pgp+Snpe02+hHYEh4XiR//mzMCWCEAFYIfn32JhEqPXjvVpitb
         csP0t2rX+XtIB6ErX9Ywobk+U8HNO3jF6gAy6SBP+wyEOwNnt79vEWoZGdsiGnajBzyk
         34heikLZ4DpIbB4b4qlxWUNBYtl8Mhvk8dWSJxcRWWHxQ/rmPGBxYBhm9dMAZJfd4JBU
         hg4LiOIyFcH6V6dvXg4yPdLyU1xlU/7SgAphwghWQ5BcMrbDqSq4OERFFJZdYPBxAFXO
         5CXg==
X-Gm-Message-State: APjAAAVKjPrCdEhtFKujVqD+Yk6NyGMfdJ3kNbdufE5SG0DhSblkydcI
        RyVbW0IjfSQv+RmDMzmEClhxvHyr
X-Google-Smtp-Source: APXvYqwlkuqq4SEwqy6K1dVV+XKovOdyYvlU1GUprXmqzbJVLhk5g4mu/6v+ys/88zqtRw/eZjVeNg==
X-Received: by 2002:a62:e308:: with SMTP id g8mr28313927pfh.121.1573452256234;
        Sun, 10 Nov 2019 22:04:16 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:15 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 3/9] t3900: demonstrate git-rebase problem with multi encoding
Date:   Mon, 11 Nov 2019 13:03:36 +0700
Message-Id: <c41046e717b9ea616a792668c70df96122ba41df.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're using fixup!/squash! <subject> to mark if current commit will be
used to be fixed up or squashed to a previous commit.

However, if we're changing i18n.commitencoding after making the
original commit but before making the fixing up, we couldn't find the
original commit to do the fixup/squash.

Add a test to demonstrate that problem.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 t/t3900-i18n-commit.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index b92ff95977..dd56384b93 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -204,4 +204,33 @@ test_commit_autosquash_flags eucJP fixup
 
 test_commit_autosquash_flags ISO-2022-JP squash
 
+test_commit_autosquash_multi_encoding () {
+	flag=$1
+	old=$2
+	new=$3
+	msg=$4
+	test_expect_failure "commit --$flag into $old from $new" '
+		git checkout -b $flag-$old-$new C0 &&
+		git config i18n.commitencoding $old &&
+		echo $old >>F &&
+		git commit -a -F "$TEST_DIRECTORY"/t3900/$msg &&
+		test_tick &&
+		echo intermediate stuff >>G &&
+		git add G &&
+		git commit -a -m "intermediate commit" &&
+		test_tick &&
+		git config i18n.commitencoding $new &&
+		echo $new-$flag >>F &&
+		git commit -a --$flag HEAD^ &&
+		git rebase --autosquash -i HEAD^^^ &&
+		git rev-list HEAD >actual &&
+		test_line_count = 3 actual
+	'
+}
+
+test_commit_autosquash_multi_encoding fixup UTF-8 ISO-8859-1 1-UTF-8.txt
+test_commit_autosquash_multi_encoding squash ISO-8859-1 UTF-8 ISO8859-1.txt
+test_commit_autosquash_multi_encoding squash eucJP ISO-2022-JP eucJP.txt
+test_commit_autosquash_multi_encoding fixup ISO-2022-JP UTF-8 ISO-2022-JP.txt
+
 test_done
-- 
2.24.0.164.g78daf050de.dirty

