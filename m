Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34491F454
	for <e@80x24.org>; Thu,  7 Nov 2019 02:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbfKGC4f (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 21:56:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43378 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfKGC4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 21:56:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id a18so405051plm.10
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 18:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pk4FgXUamrCFDH4re1KEbklwualxn2EpHl2M0t+aNd8=;
        b=vh12rtVNZJj/91pe3hQumkkzu8bq7DDltVz10yVxgnfr4fOwRNSGeDM2poggVLA09K
         ExjKFwfSaR1JIF5J38Fa/AC/O8K4MNQroRJxfUDBBk+daSeti2eyOcXojqIus0RoXC2S
         +nE+rehSrRz1r59MxA5dNUu8FxLB4LtR2af2JBkKh0QVxp/sfrYUqrzM/0sjs10AI2/V
         +WiSGrd5rr1EHm5I/EZrdgseyi1CFLYc+af5I8qLHD293+O4y1l4Mm8S+uRIdtHs4A+Z
         GBMUPhBlorEmEMe2mOFyDAJF2sK2Vu7cOFla8tbRB2zso6uS9N5gj5zzjWi6vmQsAgxq
         cbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pk4FgXUamrCFDH4re1KEbklwualxn2EpHl2M0t+aNd8=;
        b=XSBWkBpWXkZEjZLUBeZwT/RamJgeCEJsY7nluhAVDcNx+hLz7nRbGaEzPxcrOXVcCc
         JXrwku/y30NefSgqPqgNQ+zhBOI/anmfQWJLhF4QbhPa+ZaO1DzWDyWgzQ2W8O64rrwk
         8e59XTmzSaJGj5sbbetWJXbYg6+gjeVGP0jvU5pLaTDZNdxPsbfKH+oXYSnhGoALUr+Q
         /SCAbzvUOf3OyXfI4K43W3aUIjfAPpQ7M/fZ0RPVVnBpwS0JrZBUKeSCMvOfj1GWy8Sn
         mRda24uOPZicUGxWEkD1tHRow5k17RxWL5laW00U8wlvafepDP3cot5hLXuinzxLIfWQ
         AH0A==
X-Gm-Message-State: APjAAAW9EKWQPeEQnGHYxx10dMs1iyEd1k7h6aUaUtpjyqwR7ZlO/LCl
        3dd9g7/YzUA5TRHIfkW5ylu5WaTtemc=
X-Google-Smtp-Source: APXvYqy2xdgsoveOE/GB8XiLZ8/3DdI3zMPZVAP8u7A5SD8yF5GuSMEeDzUquFNhlzAOgCETlemrGA==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr1114606plq.177.1573095393670;
        Wed, 06 Nov 2019 18:56:33 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id n15sm393767pfq.146.2019.11.06.18.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:56:33 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v4 3/8] t3900: demonstrate git-rebase problem with multi encoding
Date:   Thu,  7 Nov 2019 09:56:14 +0700
Message-Id: <ca869cef57bcf620a7b5d0519d362dcd9a27eae6.1573094789.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g36796e2b67
In-Reply-To: <cover.1573094789.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573094789.git.congdanhqx@gmail.com>
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
index b92ff95977..0f978bfde1 100755
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
+		git checkout -b '$flag-$old-$new' C0 &&
+		git config i18n.commitencoding '$old' &&
+		echo '$old' >>F &&
+		git commit -a -F "$TEST_DIRECTORY/t3900/'$msg'" &&
+		test_tick &&
+		echo intermediate stuff >>G &&
+		git add G &&
+		git commit -a -m "intermediate commit" &&
+		test_tick &&
+		git config i18n.commitencoding '$new' &&
+		echo '$new-$flag' >>F &&
+		git commit -a --'$flag' HEAD^ &&
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
2.24.0.8.g36796e2b67

