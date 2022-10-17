Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B549C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJQNRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJQNRv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A65FF50
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w18so18419904wro.7
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7faw4EUCXSCyKuXe8/STylGCsukVPYq05BacxCx1390=;
        b=l5y0tLV3LKuosmrl57TF5KuQmdf3m/IZMlEFqHj/YuPsILEMzXvquzg83pFrNg34kr
         XmzpBkPV3GUBba5SbPHmxtzgiD93qVMwAUGN1NMGdSDUOkknm2inWEOeothpSGyEfHOB
         xdAIVmCHARDUiugzHk6gYV7mus/a5If996jnbpEf/ibkkmZvrZHvROQ6AIzSas5F0A+m
         nNySWEdSfyT66X0SdhsWaGtFZkZO8s1t0rdWjZ3J9nMw0rQz08aFmhH7vUSliuw2ogi7
         Lo3ULkzQD3CuTY3x+M8hh1L1RNylAXaqJ7TPdXhTmQ1P+jbUg0hJUN+e6zZsn3pISwQw
         ZSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7faw4EUCXSCyKuXe8/STylGCsukVPYq05BacxCx1390=;
        b=f1Xp1YtAJ8r8yLwGZyeRmetBUOJXVJxf7W1vkLf9eFqjvYQbOOk/AVB9VqzFb/ORcG
         SWWyyAQIzRThd875E6A0RWNBpTfn4k3XS9GkadJ/L0HXBXMw64T7YzQi80TfjZ28e27H
         9SvMbmbXerkyqVuWj1z3ZuDgwtSJol376uwHi3DUa+rZLaJgdCI0FyrrnNGeNW+J739p
         spgKiJHmcj/MlFDfJbCxyISDJb6LoJN6scyVaB+k7EFXCgeN79+CwSXFtl+CRuWy0wRB
         AbXhafc395Af6p0MX7SWgXAksGwzzgSrzGJPtd1Uod5ALnCI0bEdlDJP7MHM4uEqM9uL
         j2hw==
X-Gm-Message-State: ACrzQf16DTpXGyEBCX9l9a/YyBhS9bhsVYpFnIdIlg6/1RjO8O04MrRD
        7hSle1aPoZ1hy6fmK28zdmpzf/az5u0=
X-Google-Smtp-Source: AMsMyM6arQf2xdQ79PBKiAyVDD56WRVEYmIiwb+sm3Cei7gZl4UlKJj604sqEEJizErHxbxtkchAmg==
X-Received: by 2002:a5d:4c8e:0:b0:22e:3979:7dc9 with SMTP id z14-20020a5d4c8e000000b0022e39797dc9mr6030714wrs.41.1666012668339;
        Mon, 17 Oct 2022 06:17:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d43d0000000b00228d67db06esm8519319wrr.21.2022.10.17.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:47 -0700 (PDT)
Message-Id: <d6f2f716c77cbd0a19b3b6032f69f6dd9b257e96.1666012665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 13:17:39 +0000
Subject: [PATCH v4 2/8] t3416: set $EDITOR in subshell
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As $EDITOR is exported, setting it in one test affects all subsequent
tests. Avoid this by always setting it in a subshell. Also remove a
couple of unnecessary call to set_fake_editor where the editor does
not change the todo list.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3416-rebase-onto-threedots.sh | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index dc67d2308f3..01eb9513d6c 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -79,8 +79,10 @@ test_expect_success 'rebase -i --onto main...topic' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
-	set_fake_editor &&
-	EXPECT_COUNT=1 git rebase -i --onto main...topic F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=1 git rebase -i --onto main...topic F
+	) &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
@@ -90,8 +92,10 @@ test_expect_success 'rebase -i --onto main...' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
-	set_fake_editor &&
-	EXPECT_COUNT=1 git rebase -i --onto main... F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=1 git rebase -i --onto main... F
+	) &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
@@ -102,7 +106,6 @@ test_expect_success 'rebase --onto main...side requires a single merge-base' '
 	git checkout side &&
 	git reset --hard K &&
 
-	set_fake_editor &&
 	test_must_fail git rebase -i --onto main...side J 2>err &&
 	grep "need exactly one merge base" err
 '
@@ -157,8 +160,10 @@ test_expect_success 'rebase -i --keep-base main from topic' '
 	git checkout topic &&
 	git reset --hard G &&
 
-	set_fake_editor &&
-	EXPECT_COUNT=2 git rebase -i --keep-base main &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=2 git rebase -i --keep-base main
+	) &&
 	git rev-parse C >base.expect &&
 	git merge-base main HEAD >base.actual &&
 	test_cmp base.expect base.actual &&
@@ -172,8 +177,10 @@ test_expect_success 'rebase -i --keep-base main topic from main' '
 	git checkout main &&
 	git branch -f topic G &&
 
-	set_fake_editor &&
-	EXPECT_COUNT=2 git rebase -i --keep-base main topic &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=2 git rebase -i --keep-base main topic
+	) &&
 	git rev-parse C >base.expect &&
 	git merge-base main HEAD >base.actual &&
 	test_cmp base.expect base.actual &&
@@ -188,9 +195,13 @@ test_expect_success 'rebase --keep-base requires a single merge base' '
 	git checkout side &&
 	git reset --hard K &&
 
-	set_fake_editor &&
 	test_must_fail git rebase -i --keep-base main 2>err &&
 	grep "need exactly one merge base with branch" err
 '
 
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
 test_done
-- 
gitgitgadget

