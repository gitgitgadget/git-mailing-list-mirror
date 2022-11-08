Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED89C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiKHSSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiKHSSN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:13 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90715A25
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:18:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id y14so40780953ejd.9
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yblluhftFSaxdfYo+r6rfUi0+MaMH85Qv2Fa+oob0n4=;
        b=Z9I78NvW3EFnlQ3vQnDSfFENHh15KnchlMI9LZHTOf9xyz+siBDTMPVt14jJm1Zvrc
         GZbpL1uFHn6ytqbVjF0S+DFMrY4LdfHwxik4ua3pZwt9L8imxyHJCFEY7124/9wzqC6+
         dZOHHq4kzlbu+UwdzeRZsZwpV3aHv1lI7dt/eGofMUN0cjaZa09ZT1uTswFqIRYvR/on
         uKtUtTmTq+Zi34frZT7rQwssGuYRiQTF5rb/L0GOWvd7ur1jirsG62zyMfFPnSj4FXMe
         euFehJgACQcs8qzCpN7W32ccIssCYre3EsJjQkoTqltbeUGhFsCJoiiH20BJtxa7F1ti
         6uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yblluhftFSaxdfYo+r6rfUi0+MaMH85Qv2Fa+oob0n4=;
        b=3r3GV4s5aKtPvwiEHQDXtGItM64j10n9QUouAMeeEpfRAoFOMBuBM8jPtKa38RNvic
         ZnqLR9Mosx9HeMNlcAFAJ5JK6srJxT9pY7NWea0m+Nm+N1ldnAZE2Hg3h2ygp/Fy1ivw
         98K5LH3PLhxWFMBXTWzoZB55IdrBiRnwP4h+QlbNV2iArmQaRiiWBw7Wm2fPrjKKNdVY
         mtNv6ryyztbRXlErqtvnQmd3ehyK5yrU/ZxTPBW98XmMzQBlQ+x3nY9KkNqQfoIaib+O
         opmuc5082e5PYOWG1NLb4iu/+EECBoOjTnRhe9JoaizosnGksZHoXxMOSdDFatbrUhkL
         HrwQ==
X-Gm-Message-State: ACrzQf10cik82NRIC9BA7OgtdkoSjUpM7acSaGp3ZoTjhNgksoA1fOKo
        DvG0Q1Tv4p1Mmgyo+r8QtsFiVF4h6+L37A==
X-Google-Smtp-Source: AMsMyM5uJjWW2Jrc67FfwhH83SDS932wTEIUztayVIVd2yHMjUgJQpq8/qQ4HBocHJJP7pwYk0AcMw==
X-Received: by 2002:a17:906:899d:b0:7ad:cf09:96be with SMTP id gg29-20020a170906899d00b007adcf0996bemr48050222ejc.221.1667931480151;
        Tue, 08 Nov 2022 10:18:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:17:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/15] revision API: call graph_clear() in release_revisions()
Date:   Tue,  8 Nov 2022 19:17:44 +0100
Message-Id: <patch-v2-08.15-45aa6e24c66-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call graph_clear() in release_revisions(), this will free memory
allocated by e.g. this command, which will now run without memory
leaks:

	git -P log -1 --graph --no-graph --graph

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c             | 1 +
 t/t3413-rebase-hook.sh | 1 +
 t/t4052-stat-output.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index 0760e78936e..650dd17599a 100644
--- a/revision.c
+++ b/revision.c
@@ -3020,6 +3020,7 @@ void release_revisions(struct rev_info *revs)
 	date_mode_release(&revs->date_mode);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
+	graph_clear(revs->graph);
 	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index 9fab0d779bb..e8456831e8b 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -5,6 +5,7 @@ test_description='git rebase with its hook(s)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index b5c281edaa7..3ee27e277dc 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -8,6 +8,7 @@ test_description='test --stat output of various commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-- 
2.38.0.1467.g709fbdff1a9

