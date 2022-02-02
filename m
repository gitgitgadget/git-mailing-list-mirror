Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714EBC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 11:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbiBBLPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbiBBLPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 06:15:19 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B703DC06173B
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 03:15:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f17so37675065wrx.1
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 03:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBxDNlY6wXccBIgCQ63AvEPQH7CrXidIqItC81gtR64=;
        b=mlm7R7O3VCrSQTKM+GarEvRyZuMmFobGQqMq6DzOQa/sK++IPFAGupNF8ysHTH1sgL
         Lvu/8NgLghjo2V+XGvN9uxAl/H/Ci/NZPdfp6kIZpv2h2EUWCZr2lfqhpgqGbbRBFl1h
         I26VgovbJ04pNCkRUNhNV/FmgWag7ri14kEz15f4wzLm/k+ZPMzYxm7b9qUJTYJ3zBgG
         3qFFCL2p1bkP8QHvG3PMI3oD6YVPm6dB8IsbF4Vv+eAMfFDsmiquHToau/sXNYKaTAdu
         Ywq59HhePOlgtJ+5s3v0AWCc2RQ1w2lDACiYlaUfY0EQ8WSNQv6XW6QYoOL/wLLzS/YV
         psjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBxDNlY6wXccBIgCQ63AvEPQH7CrXidIqItC81gtR64=;
        b=6o2d8mOqbn3O14DGd5RyL8nX5/tZ2oQeznXHOtjA1mPsB6p2QQiV3UoidWSj/Tu/wr
         y3FXWwOx/rO2wPnsNnoF1GvmpxhF5HAtsnqdJ3j4WbLAwzQFnrg22LPpFCjvwkyMzjJL
         4UTga2T3iZ9ANTg2f8xlkjeJ4rf8Ns6f/mIUK8iKlHbk+6pBtiy3k+T03XstteS8i2TA
         hcrTOqgTA1usygTJVAe9P8F6eoZoluTY51zd2lHPxAiaTr0L2oZnSH5YhRMzk7K1tUHQ
         ZK/EMzYVCZ3xEb32fIngHDsnJ1Bw8jgyZ2PQT04nP9Mu36jZIOAIMYgwRSUJii5Iz/Tv
         J93w==
X-Gm-Message-State: AOAM531Ges9hHXbfZRA7Il6cfsErc61udenjzOwNpBy/reDpQlcvl+Wz
        xx5AXLCQexRNx9efhWZGDGd7phyZc423sw==
X-Google-Smtp-Source: ABdhPJxj+u8HwZHlrEOACNEBOGkUpbmN51+vA8J6JWUZJswcvmKL0vKV/4DiJlUL4WdqSw6C4bAAwA==
X-Received: by 2002:a05:6000:385:: with SMTP id u5mr24996506wrf.62.1643800516970;
        Wed, 02 Feb 2022 03:15:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm18266603wrs.51.2022.02.02.03.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:15:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Victor=20Bonfim?= 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] completion tests: re-source git-completion.bash in a subshell
Date:   Wed,  2 Feb 2022 12:15:09 +0100
Message-Id: <patch-v2-1.2-cf09546e079-20220202T111228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <cover-v2-0.2-00000000000-20220202T111228Z-avarab@gmail.com>
References: <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20220202T111228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change tests of git-completion.bash that re-source it to do so inside
a subshell. Re-sourcing it will clobber variables it sets, and in the
case of the "GIT_COMPLETION_SHOW_ALL=1" test added in
ca2d62b7879 (parse-options: don't complete option aliases by default,
2021-07-16) change the behavior of the completion persistently.

Aside from the addition of "(" and ")" on new lines this is an
indentation-only change, only the "(" and ")" lines are changed under
"git diff -w".

So let's change that test, and for good measure do the same for the
three tests that precede it, which were added in
8b0eaa41f23 (completion: clear cached --options when sourcing the
completion script, 2018-03-22). The may not be wrong, but doing this
establishes a more reliable pattern for future tests, which might use
these as a template to copy.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9902-completion.sh | 50 +++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 98c62806328..c9805f2147d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2396,27 +2396,33 @@ test_expect_success 'options with value' '
 '
 
 test_expect_success 'sourcing the completion script clears cached commands' '
-	__git_compute_all_commands &&
-	verbose test -n "$__git_all_commands" &&
-	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-	verbose test -z "$__git_all_commands"
+	(
+		__git_compute_all_commands &&
+		verbose test -n "$__git_all_commands" &&
+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		verbose test -z "$__git_all_commands"
+	)
 '
 
 test_expect_success 'sourcing the completion script clears cached merge strategies' '
-	__git_compute_merge_strategies &&
-	verbose test -n "$__git_merge_strategies" &&
-	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-	verbose test -z "$__git_merge_strategies"
+	(
+		__git_compute_merge_strategies &&
+		verbose test -n "$__git_merge_strategies" &&
+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		verbose test -z "$__git_merge_strategies"
+	)
 '
 
 test_expect_success 'sourcing the completion script clears cached --options' '
-	__gitcomp_builtin checkout &&
-	verbose test -n "$__gitcomp_builtin_checkout" &&
-	__gitcomp_builtin notes_edit &&
-	verbose test -n "$__gitcomp_builtin_notes_edit" &&
-	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-	verbose test -z "$__gitcomp_builtin_checkout" &&
-	verbose test -z "$__gitcomp_builtin_notes_edit"
+	(
+		__gitcomp_builtin checkout &&
+		verbose test -n "$__gitcomp_builtin_checkout" &&
+		__gitcomp_builtin notes_edit &&
+		verbose test -n "$__gitcomp_builtin_notes_edit" &&
+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		verbose test -z "$__gitcomp_builtin_checkout" &&
+		verbose test -z "$__gitcomp_builtin_notes_edit"
+	)
 '
 
 test_expect_success 'option aliases are not shown by default' '
@@ -2424,12 +2430,14 @@ test_expect_success 'option aliases are not shown by default' '
 '
 
 test_expect_success 'option aliases are shown with GIT_COMPLETION_SHOW_ALL' '
-	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-	GIT_COMPLETION_SHOW_ALL=1 && export GIT_COMPLETION_SHOW_ALL &&
-	test_completion "git clone --recurs" <<-\EOF
-	--recurse-submodules Z
-	--recursive Z
-	EOF
+	(
+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		GIT_COMPLETION_SHOW_ALL=1 && export GIT_COMPLETION_SHOW_ALL &&
+		test_completion "git clone --recurs" <<-\EOF
+		--recurse-submodules Z
+		--recursive Z
+		EOF
+	)
 '
 
 test_expect_success '__git_complete' '
-- 
2.35.0.913.g12b4baa2536

