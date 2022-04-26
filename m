Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D0AC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355123AbiDZUqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355093AbiDZUqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:46:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60E613AB5A
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 129so39647wmz.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U8VIyeB5pUxVlY98wG9v1/OCleHuGbhOKK2qfZecUFg=;
        b=D1PDYhzD77IMfaT+fCV2lihdFSLtUTROPn8mfNtcGPEkxH5KyVerzAqwAkzNhTRhtq
         gNd2hUNTSczgNaUnfC0Ueu6jvN/pmCLMESX219uO6JhWbIZEjwNxjn7NTtEQPQUBMR8M
         Ifxkf+vLRHCqhikzlF6T1/kAcMLkZZ7QbIQ0WxatcRvkWMNYmeyPZ8/55/IVVaZahJpK
         6B47bsGau6xFc8j1Wzxrrsk9Q06tsmRqeHxqGpv+2FOuL409Z/F3pwdjBISfGUnbR48P
         XQSktJmI+i3TL9AWjuGUITSUvnTEwryt3V7Wm0kmkOQRG8OB3zerJkwYa0VOVYjbRVNl
         wj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U8VIyeB5pUxVlY98wG9v1/OCleHuGbhOKK2qfZecUFg=;
        b=gM9tQii0gi0XjwFLyxEOpjprsFM5J9CK6ykxU2kcaDFT1bjCOIHqRk6XpSvj3BM46l
         OgJMBBeMM7duigkU6DfLEsoK0pgLFTAZLUJ30R1tFEtS4LCqbu14ac37Y8g5vsr+QHoD
         kXXa+lJYI6ppiwmbo3PEZ21TqQ6k93pI9V5vNokakI/YM4r56331uYn6wmme767xsgqH
         Nsg5zVxYXfAeQmOPAZnKgO/9e1l/3R6e+Eoxp8jtiRJhrfSsFJWjxMMKYxWW0DpkXSAY
         2RFsksI7jyQwgSBcCtTxVDVTkTJEVnfccHoM3HxdCHA16Dn046eUR05EwKEMMFcaw6dS
         hbwQ==
X-Gm-Message-State: AOAM531IKwC3e2xid+RftfuPoeDlHJuOfEV/6xxoujAJvm15ifiq9veB
        0Xdv7I7lCPel4wZLIi960Z2vKAWMDr0=
X-Google-Smtp-Source: ABdhPJx9PCzW753WsAkQZyUwmuut6ibWs+06xuEp3cHV+bM6yax5sRa507EKAR4+iKxdZVieX6KE2g==
X-Received: by 2002:a05:600c:3ca3:b0:392:990b:af11 with SMTP id bg35-20020a05600c3ca300b00392990baf11mr22923881wmb.173.1651005804109;
        Tue, 26 Apr 2022 13:43:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w12-20020adf8bcc000000b002060e3da33fsm12148381wra.66.2022.04.26.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:43:23 -0700 (PDT)
Message-Id: <2e9d47ab09ba8bca0166ca21bd936f2b4b5bb75e.1651005800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
        <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 20:43:17 +0000
Subject: [PATCH v2 2/5] show: integrate with the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Philip Oakley <philipoakley@iee.email>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git show' command can take an input to request the state of an
object in the index. This can lead to parsing the index in order to load
a specific file entry. Without the change presented here, a sparse index
would expand to a full one, taking much longer than usual to access a
simple file.

There is one behavioral change that happens here, though: we now can
find a sparse directory entry within the index! Commands that previously
failed because we could not find an entry in the worktree or index now
succeed because we _do_ find an entry in the index.

There might be more work to do to make other situations succeed when
looking for an indexed tree, perhaps by looking at or updating the
cache-tree extension as needed. These situations include having a full
index or asking for a directory that is within the sparse-checkout cone
(and hence is not a sparse directory entry in the index).

For now, we demonstrate how the sparse index integration is extremely
simple for files outside of the cone as well as directories within the
cone. A later change will resolve this behavior around sparse
directories.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/log.c                            |  5 +++++
 t/t1092-sparse-checkout-compatibility.sh | 24 ++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c211d66d1d0..8e2e9912ab9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -661,6 +661,11 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
+
 	memset(&match_all, 0, sizeof(match_all));
 	repo_init_revisions(the_repository, &rev, prefix);
 	git_config(grep_config, &rev.grep_filter);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 74792b5ebbc..3506c0216f0 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1159,12 +1159,21 @@ test_expect_success 'show (cached blobs/trees)' '
 	test_sparse_match git show :folder1/a &&
 
 	# Asking "git show" for directories in the index
-	# does not work as implemented. The error message is
-	# different for a full checkout and a sparse checkout
-	# when the directory is outside of the cone.
+	# had different behavior depending on the existence
+	# of a sparse index.
 	test_all_match test_must_fail git show :deep/ &&
 	test_must_fail git -C full-checkout show :folder1/ &&
-	test_sparse_match test_must_fail git show :folder1/
+	test_must_fail git -C sparse-checkout show :folder1/ &&
+
+	git -C sparse-index show :folder1/ >actual &&
+	git -C full-checkout show HEAD:folder1 >expect &&
+
+	# The output of "git show" includes the way we referenced the
+	# objects, so strip that out.
+	test_line_count = 4 actual &&
+	tail -n 2 actual >actual-trunc &&
+	tail -n 2 expect >expect-trunc &&
+	test_cmp expect-trunc actual-trunc
 '
 
 test_expect_success 'submodule handling' '
@@ -1388,6 +1397,13 @@ test_expect_success 'sparse index is not expanded: diff' '
 	ensure_not_expanded diff --cached
 '
 
+test_expect_success 'sparse index is not expanded: show' '
+	init_repos &&
+
+	ensure_not_expanded show :a &&
+	ensure_not_expanded show :deep/a
+'
+
 test_expect_success 'sparse index is not expanded: update-index' '
 	init_repos &&
 
-- 
gitgitgadget

