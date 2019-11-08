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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0505D1F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfKHJoI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfKHJoH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id d7so1894234pls.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCOP+T5rQSDaMPRYqZOZ5Yhzl5wgPrsbjWG4h7kjtws=;
        b=fcrAJLsFJZQEA555Coytn2Gpr9nBeTm713me13A37is+fMAOt231WIsfHTF6v0kti9
         2lAU044/vKrFpdGN9BJMUhMObI9qywNrXKAjRom9VLx2XGvtC5ppOq7g+JEBIuhh2pm7
         065CgTNlAsuraGsdrW+RIcYZWsZBAck2RbTMU3HoPw4NQdWwlwuuTgbnL18xznlLkS9x
         32iDH0F1kqUA7CbVL9/O+r8mLm3lxLq7/IRX2L5FR6VGxSu1u8KJJU2j+8ZAOyd4R/cH
         +EDMjgb1Fb15yzt5F+MZkAE6YZKZ6KnQJHk801+weS8e+rOmTzNacV4tCmnHnl0g76/e
         NbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCOP+T5rQSDaMPRYqZOZ5Yhzl5wgPrsbjWG4h7kjtws=;
        b=pzmCiAYHp8De2Jqqg6s2eQcqk3tlytzm1+UiMtY6+jFish0K/NjMTaeDNCP+vSPazf
         HdnR4ryF01+YvsD4t03SavOM9i8yf9CDRG9SEB7lKocfSNHl0fOzUCc6Sswk4l50kdWv
         pqBdLCrdO3oFIjW5B9cOCNkGoaaz0DlHdbYEZrASA6xbXMEfDus7BtFJB/wJYH75n657
         XpAZ0UjV6E+DFA7HumlQcb7FAXHErKb0NBFPIUnPazbZYevIIy86jcW5PhAPfS92gA1o
         81T+c4uIoq9/tUNUkhc6osJ3U8bCg476Y0Aq10Wo2f8u2zfXRyXQn5xSZYwIJ/tgs6jl
         Md/g==
X-Gm-Message-State: APjAAAWqMChEGC6Wa6LiULQGbD+PK/bRf10a8MEmVEkiL7qL57O93Yps
        xF8i3edpnfxa1G42mWKUtqAUKrRU
X-Google-Smtp-Source: APXvYqwd0vuBGP0QArFVJ+Y+HVCH7XReJRzFHF4bd3P+a/GbdFx/IyawemiM+pe0o90NAwMZ6RfyyA==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr12021043pjt.38.1573206245303;
        Fri, 08 Nov 2019 01:44:05 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:44:04 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5 3/9] t3900: demonstrate git-rebase problem with multi encoding
Date:   Fri,  8 Nov 2019 16:43:45 +0700
Message-Id: <30f15075c405b9049790518b64f66cb1740184f1.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573205699.git.congdanhqx@gmail.com>
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
2.24.0.8.g2e95ca57d2.dirty

