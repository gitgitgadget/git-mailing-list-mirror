Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13DFC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 14:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiI3OK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiI3OKS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 10:10:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718135AC6D
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l8so3016528wmi.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=22MgE6MUmcc+NTQAqT88DepsA0HjSt/jPf9tI3NoNP4=;
        b=cXh0ZdTVMBzgW4RDWV7l15eU/TTTlhlkS0ht9DINZy3rXomx/JstXV1ztk0+VtnOR7
         nG92oRq0jwVGtcJOMDfhuVW7y1nMq5a1Vw/KlI5YibnsQZxvUE55GrniqRSy2I1TZOWs
         fgeGfT7eKxG1yw2j1Xg2l0K0LFuq5zlKX9cHVifetqdqM2jGZtR0JUT2dUSxG/63R6Dg
         fDx3n5OweyywZO7LWannjPiyedjtbURpCASdO8xNBIKCXZgLtaQ/CrQqDu6H9tx5Fqj3
         fpwpc+Ytxr6HebzaqTITfiSrMMlts80yeplP8CMgWF5zV7Sw1UpBTV9j4nfCyI3KCDDc
         bQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=22MgE6MUmcc+NTQAqT88DepsA0HjSt/jPf9tI3NoNP4=;
        b=SmVCY8BQRnc3UjZ8E24/xqn9HbjXdh/tyX4WPMKvyKTltpCtO7/5y7QPXGDKp6HpeN
         6PSgXDRghml9a5ZqhifOfp4sq6bQtEZdxnHWjYl+npxgykJCmbcVufJb9/NRO0irfFVs
         /HxQ4+a4aQo4th4YcOm6sC1s7CPmPxu3YMN6OIcYCCoKUc1dbKJMMHyHTNWPd5dSs/mv
         g0AxSm+82alMPGl5v9lRImMBfGOSqSMlcFePbOShZzDTHXy6qxZJLmZpsEMEuynJYqGe
         3acu6xFiYcJYfGQZxbs55fQIS09vqutm3S84mxW6Q56iwRvEF0bphjUC1GrwlCUiWPTc
         a1Lg==
X-Gm-Message-State: ACrzQf2mrpLGSTdyiV3E79dAiPZET4w8CCB23Nm4b4Gxb1klQPJzC3LE
        ukAVGJ6EyI74rfxqbpdXTZY6b4w4Pvg=
X-Google-Smtp-Source: AMsMyM4iQXSZXlz7qa6az9Ix0a1KJ8nlpa4X5QSh9pGmtcAcZXKfaDNYNkmPIu6G34i2LKe94HFQVQ==
X-Received: by 2002:a05:600c:268f:b0:3b4:acef:34ab with SMTP id 15-20020a05600c268f00b003b4acef34abmr5871067wmt.176.1664547015775;
        Fri, 30 Sep 2022 07:10:15 -0700 (PDT)
Received: from localhost (94-21-37-194.pool.digikabel.hu. [94.21.37.194])
        by smtp.gmail.com with ESMTPSA id t12-20020adff04c000000b00228dd80d78asm2049398wro.86.2022.09.30.07.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:10:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/6] t2407-worktree-heads.sh: remove outdated loop
Date:   Fri, 30 Sep 2022 16:09:43 +0200
Message-Id: <20220930140948.80367-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.542.g9b62912f7f
In-Reply-To: <20220930140948.80367-1-szeder.dev@gmail.com>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'refuse to overwrite during rebase with --update-refs'
initially [1] used two branches 'fake-3' and 'fake-4', and to run the
same git operation and check on both it used a 'for i in 3 4' loop.
This test was then soon updated [2] to operate only on a single
branch.  This change made that loop unnecessary, but it forgot to
remove it.

(For future work, note the misleading error message in this test: it
says "cannot force update the branch <branch> checked out at
<worktree>", but the branch in question is not, in fact, checked out
in the named worktree (it's not checked out anywhere actually!); it
can't be updated because it's kind-of "locked" by an 'update-ref'
instruction of the ongoing rebase operation.)

[1] aa7f2fd150 (branch: consider refs under 'update-refs', 2022-07-19)
[2] 89fc0b53fd (rebase: update refs from 'update-ref' commands,
                2022-07-19)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t2407-worktree-heads.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 019a40df2c..126f0d4956 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -87,12 +87,8 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with
 	git branch -f can-be-updated wt-3 &&
 	test_must_fail git -C wt-3 rebase --update-refs conflict-3 &&
 
-	for i in 3 4
-	do
-		test_must_fail git branch -f can-be-updated HEAD 2>err &&
-		grep "cannot force update the branch '\''can-be-updated'\'' checked out at.*wt-3" err ||
-			return 1
-	done
+	test_must_fail git branch -f can-be-updated HEAD 2>err &&
+	grep "cannot force update the branch '\''can-be-updated'\'' checked out at.*wt-3" err
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
-- 
2.38.0.rc2.542.g9b62912f7f

