Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDC6C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbiCDSdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbiCDSdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:12 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BEA1D3AEB
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b5so13949035wrr.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4w3MkaIqyiHIv0yDR7u5CxP+gzqC3twSAbWRGtBcvs=;
        b=WVmMUrUL5H94HnRHDKk2/HUYpQwsF7kBXypO/wLeSNmYMKs3DAQ3btClQ5pvZYSoHT
         bR4uPGnm8PoTpO0npiqSqhCzaKeoWDmSggu2CKBsmV9EUFOzCZCsKHIjlA51KLQNYA72
         dzdxomgxxsoZjihkv5KTB4ifbJT0cGxQgg8H7fKDJDx0/MaKnmcUnn7mZ4WBcuD9lenk
         U+AuRg4vs/Rw40C6Tn+f3O6WTEiU0HziloftZfSOn3yYQlpJQFQSg/S3Atlz+7z7JxO6
         NLXVJ4XcK75XtaFR24387Cw1eCVWrdCIYBGI7Om1obkcgw/NGyLqC5fcUI5HZNqHhgir
         G3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4w3MkaIqyiHIv0yDR7u5CxP+gzqC3twSAbWRGtBcvs=;
        b=nrFVlkbYlMN1ImYC3iZiDuZDKuORZexQPz8krzkY2uxhYbmR53Qm6tyd+kJpsSi5eU
         i3SVBh5Bn8ZOzWSGYqmCzK/B4hMUNxeJsMv8Jbb6C8DEvUaXX2VohOvOS+E+yKzSV8rz
         RALDT9/n1/d7D9XPCkiea1fvQ/0IJNUsy2by+CuawPDMQVDoJWvb4aFwT1be4iifCv7v
         wgaOPNGcaJeaTF+VJUCQroekW1U0rB+vWBxGu8enTtyjXVH8VxcTEs7TKw6c7vdOZGnA
         JMo6BVAWBxn+UiB1VygEb+HUKy7T3lU7Gu9z7f5IWBJ+spdAR+DIfBARuXI5O8HzyolD
         fFyw==
X-Gm-Message-State: AOAM532DGh0/yaFT0ijNh4OU7XF8syAXAC5Oy7Yo2hgw7MS1ujIfneWt
        CVuS9M+sAvF9ho1IPbOPvcWtqyMviEnIvQ==
X-Google-Smtp-Source: ABdhPJwnaKnLVY/Zvz0iChvcjuxNfaG56kjJ3N4FKZzGRN8lTSS2i+9dogNOhtlp2TMi3/nDGM2RWw==
X-Received: by 2002:adf:9d93:0:b0:1f0:639f:3bc2 with SMTP id p19-20020adf9d93000000b001f0639f3bc2mr17705wre.203.1646418741764;
        Fri, 04 Mar 2022 10:32:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/14] merge-base: free() allocated "struct commit **" list
Date:   Fri,  4 Mar 2022 19:32:05 +0100
Message-Id: <patch-v2-02.14-4ee2881adfb-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in 53eda89b2fe (merge-base: teach "git merge-base"
to drive underlying merge_bases_many(), 2008-07-30) by calling free()
on the "struct commit **" list used by "git merge-base".

This gets e.g. "t6010-merge-base.sh" closer to passing under
SANITIZE=leak, it failed 8 tests before when compiled with that
option, and now fails only 5 tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 26b84980dbd..a11f8c6e4bb 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -138,6 +138,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	int rev_nr = 0;
 	int show_all = 0;
 	int cmdmode = 0;
+	int ret;
 
 	struct option options[] = {
 		OPT_BOOL('a', "all", &show_all, N_("output all common ancestors")),
@@ -186,5 +187,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	ALLOC_ARRAY(rev, argc);
 	while (argc-- > 0)
 		rev[rev_nr++] = get_commit_reference(*argv++);
-	return show_merge_base(rev, rev_nr, show_all);
+	ret = show_merge_base(rev, rev_nr, show_all);
+	free(rev);
+	return ret;
 }
-- 
2.35.1.1248.gb68c9165ad8

