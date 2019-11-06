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
	by dcvr.yhbt.net (Postfix) with ESMTP id 368B31F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfKFJUj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:20:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36348 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKFJUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:20:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id v19so18395170pfm.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWyVVsGPKyQMi25op3B6zG1hfv+dNHxs9TEeoUTo3Es=;
        b=jKpwRqAvvscbHvluINTpJQAo4uvHhFuCWS1E4LXx1cOfnBy1WneTBpXreUeFPgzQJu
         r5v/UzgL5mDs3D7HBeI5+HUnR3pju3KgC5nqDE77bClb9iLshfc5iOcGbwZItEcV2GkZ
         hopEKGeKDQWX7ryfumuSjkyp5cVy+3hs0fcnC26fU/5xtzwPly8S0MTg8ZEmsQgGrqH0
         +C6shEreTTpKdndxDiIvFMschRTGedDvcyN9j6f+ZDmkhO5kOEyt0tTP2eU+h29PrdHk
         tPUqqkdpFL+1UFOxJJSOx99mVPJqc+w7N+5wxLwSoa/5xyY8IadRuwvBjImvv5fbVo6f
         cQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWyVVsGPKyQMi25op3B6zG1hfv+dNHxs9TEeoUTo3Es=;
        b=TrVgU2bntuQJp6s85tSQTp4NULNuykHZdKEfAYVp6rKqa2rLRCvvAYmO9PqkAUOc0q
         svWFPz/Djpad1NEf6ZcxqGvpU6vlkGoTKzjxcYJ9fzMjQy0F0fE/3K5jLj6OyZs08+ha
         FUW4gPv2YU75x3JsPk+grHyswPHEQgMNGaPrwyJtXJPBe7wa9aubLUtv2tKVMUTv0Gxk
         splvAXX/5GbYv4TXDLracS3M6CN2soY40LpAIYGo6bncwwujXSMxCySPoaU5j56QJh+u
         9t2TjzkYii5iujzdCBchc1Rtc8atITCtYoi1TJsURR+3lKqUF44DuxdNOoFibaB2dYGG
         CNyA==
X-Gm-Message-State: APjAAAUUdTpFOT4AC6Np8YYNyQMjnx2bH+9YQ48Bu7WiIgAUJ59xrMjE
        rvc5PNpl5rIvE1jyhgPPdM02mTbE
X-Google-Smtp-Source: APXvYqzwC1XRXvMNaEdcJbqG7xO2MIcSlr71015aebm0pYg35NpxCRJlVaJRqHlpBrCNXJXTPh0WRw==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr2483926pjp.74.1573032036901;
        Wed, 06 Nov 2019 01:20:36 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id c1sm4696984pjc.23.2019.11.06.01.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:20:36 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 3/8] t3900: demonstrate git-rebase problem with multi encoding
Date:   Wed,  6 Nov 2019 16:20:01 +0700
Message-Id: <662e5bd545135f9ed26547f47c457bf6aa74d3f3.1573031848.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.4.g6a51fdd29c
In-Reply-To: <cover.1573031848.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573031848.git.congdanhqx@gmail.com>
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
 t/t3900-i18n-commit.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index b92ff95977..85cac6e2dc 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -204,4 +204,34 @@ test_commit_autosquash_flags eucJP fixup
 
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
+		git config --unset-all i18n.commitencoding &&
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
2.24.0.4.g6a51fdd29c

