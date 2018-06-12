Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF461F403
	for <e@80x24.org>; Tue, 12 Jun 2018 23:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934878AbeFLX6n (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 19:58:43 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:40651 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934607AbeFLX6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 19:58:40 -0400
Received: by mail-pg0-f49.google.com with SMTP id l2-v6so336331pgc.7
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 16:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gqkrp5wlu3V7XKla17wkNbIeG9sxBtB12WMoEbACDAw=;
        b=M/IstDqpkY2ypLKYsEuwzRkPAnZn3EQhkcFtS5TlVESfmYVQQ3pSnPQOnbboC/Hi+o
         toV4z/TrH4gm5RzlshxAMpwL2OXGkKO8y0S6IzGWd7tKFW4Av63wbGhbllhgi+msITZu
         mKuk3RmGHzTmehW2hrbpMEVnQCK1ZfzXcJpfSCawl04z+lM8/ctqNx2WdrpK5lc/Sr17
         PFkzz4wpbFOJOFFr3UWxUp/lT/N9Fq5kAZW6bnBuChe4M9c4SCB1Rk0j+/5FG5EGvWBM
         yzdpCMyV0fFtWKiU+RB5m0jxw79LZWS5Cg26oKHcEfnQClxJkiJPHL8kC1p7aesoxFwG
         mYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gqkrp5wlu3V7XKla17wkNbIeG9sxBtB12WMoEbACDAw=;
        b=FY0HlcyaHTW5dExC0aFCMA6NNaoCMJZ1QSkK4oVb02s0q2rLQ6OlwCAo9uW+P07LxV
         TPMVjN2/HCXxcFfPqtRroVOMX8Ytj/xoV5VvzgQuS2dmFLv9xCU/EA/qtOvDp11Wh1VB
         YzcOnopG6mO65op1Dx8PZ8GjlaVZ/1jY6EXp4ufXRZBnaw95gwGMvmS/eiMI/gCeKlwl
         L7YnCk0/4fZCr5ZEctzpEeio1K9Er6BvQTLAMqe1/Vo3CWXm1be/0s2QXRKIijM8y68F
         SNdAXtOqdvCc8d0+4vLN+eolkRjYiLe6OFv1y2Vqnbtxkm6wXsoyt7lWRaRLu2sllM5Y
         X3sg==
X-Gm-Message-State: APt69E1CvJu/9IPFIM0fxrGXWvvX1zOFYiD6GQgibKg5zHsTlSK7m5Rn
        a36+gRwgAd8kASfqJxSl4Y0n6eG6gro=
X-Google-Smtp-Source: ADUXVKLuW+Q/g55OBfpxj3GGcTWT3U1pwFKiyKp9OkVejnVIzUtbT/O43x0Auem6xAWIeVUJJSAd0g==
X-Received: by 2002:a65:62cd:: with SMTP id m13-v6mr2096566pgv.207.1528847919410;
        Tue, 12 Jun 2018 16:58:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1443036pfi.84.2018.06.12.16.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:58:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] submodule deinit: unset core.worktree
Date:   Tue, 12 Jun 2018 16:58:25 -0700
Message-Id: <20180612235825.12271-4-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180612235825.12271-1-sbeller@google.com>
References: <20180612235825.12271-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is deinit'd, the working tree is gone, so the setting of
core.worktree is bogus. Unset it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 ++
 t/lib-submodule-update.sh   | 2 +-
 t/t7400-submodule-basic.sh  | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dffc55ed8ee..19480902681 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -980,6 +980,8 @@ static void deinit_submodule(const char *path, const char *prefix,
 		if (!(flags & OPT_QUIET))
 			printf(format, displaypath);
 
+		submodule_unset_core_worktree(sub);
+
 		strbuf_release(&sb_rm);
 	}
 
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 12cd4e9233e..aa5ac03325a 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -235,7 +235,7 @@ reset_work_tree_to_interested () {
 	then
 		mkdir -p submodule_update/.git/modules/sub1/modules &&
 		cp -r submodule_update_repo/.git/modules/sub1/modules/sub2 submodule_update/.git/modules/sub1/modules/sub2
-		GIT_WORK_TREE=. git -C submodule_update/.git/modules/sub1/modules/sub2 config --unset core.worktree
+		# core.worktree is unset for sub2 as it is not checked out
 	fi &&
 	# indicate we are interested in the submodule:
 	git -C submodule_update config submodule.sub1.url "bogus" &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index be946fb1fd1..c6e1f749639 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -993,6 +993,11 @@ test_expect_success 'submodule deinit should remove the whole submodule section
 	rmdir init
 '
 
+test_expect_success 'submodule deinit should unset core.worktree' '
+	test_path_is_file .git/modules/example/config &&
+	test_must_fail git config -f .git/modules/example/config core.worktree
+'
+
 test_expect_success 'submodule deinit from subdirectory' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
-- 
2.18.0.rc1.244.gcf134e6275-goog

