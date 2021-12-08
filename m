Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715DCC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhLHPBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbhLHPBk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71744C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so1956148wme.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bcCGT7qWydoUuj2E6FQ1QbDM97Qqw7k8VFpmNeRqJyQ=;
        b=dWri/JMt2eg0M/dg4GJQ6BlWd3thBTMlEtWiRjsXX9551ijGKgbH8sQmdFkAQz+5Gb
         r5GPCRshxgBYO3TNHkzUzTSmUhoFauOi3h/A7DYYkKqIo5Y5oTiIy+RWNOKy0ZlPNAWC
         9t2neavVX/ruNOJ1vMvjJYPFDiGpLLzeHK8Qu86BmbqKnxMHrKiLe8X69u9RgxEWeN7i
         AZhrUeDq7r1NwO12JPaYN3ZWQTaHmlU0wu4AU8iMmw/WRWfpm9oLjGuK2xj+dmirMqVk
         zMyn9VSt11PvJStlsYVlDwwEcMcU80QT9UNzWFfrG7yG95OrqrLLoLMTegcP2oq0oshx
         vspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bcCGT7qWydoUuj2E6FQ1QbDM97Qqw7k8VFpmNeRqJyQ=;
        b=Lbf7AZRTugX+JsdN4nzPwmGpMbKMxF/WsGKhUltxb5Cj0SH7EMXmNHinH/zeqohSYY
         PjOptTL1gI1bJXP8UDqhgzrlTt0dRPa3SFKoDsZNLtJAHnqCcb4kfqT+6E3QWmK1cQ68
         8ZwZTQ08zlvtWADvPw/CZWBh53ZmMU51mli/7IGcTdRc1umBVF0+oP0VhpQMUVLqbZjG
         C8QjvTs13RV7NXa6Av+TrevCNFaumljtNziOf2CIwtMUm5s3/u1Xk81nLSAcpdtzW6Fy
         s1tt/ASav+vrS349Xyt7aZ8a17M5x+Iz0/XZ6aqOfBfnY2vaNaLmnJ5f8Ulv2E+VJUZH
         Bt/Q==
X-Gm-Message-State: AOAM5316ebQIXGR1SYtSMwkx1vhnCLwU8ZfTyqhJNMaTAJYvqf0Uu1ux
        UHhjvFK7GmbInyK0T7sZWPfQvEs6KWw=
X-Google-Smtp-Source: ABdhPJwKpFn+nPqm5MZ3vBu0pWYnqOPFaLLxPe0UPncPxuKDu39+4O/8s7Q27RJyvILaXvgdAsNAVg==
X-Received: by 2002:a1c:287:: with SMTP id 129mr16833207wmc.49.1638975486911;
        Wed, 08 Dec 2021 06:58:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm5763356wmh.13.2021.12.08.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:06 -0800 (PST)
Message-Id: <04e7340a7e7b9fe0193070e9b9c9fb99b60503fc.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:52 +0000
Subject: [PATCH v2 05/14] rebase --apply: don't run post-checkout hook if
 there is an error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The hook should only be run if the worktree and refs were successfully
updated. This primarily affects "rebase --apply" but also "rebase
--merge" when it fast-forwards.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 reset.c                       | 2 +-
 t/t5403-post-checkout-hook.sh | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/reset.c b/reset.c
index 3e7b9e2e131..3537de91f65 100644
--- a/reset.c
+++ b/reset.c
@@ -126,7 +126,7 @@ reset_head_refs:
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
 	}
-	if (run_hook)
+	if (!ret && run_hook)
 		run_hook_le(NULL, "post-checkout",
 			    oid_to_hex(head ? head : null_oid()),
 			    oid_to_hex(oid), "1", NULL);
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index fd2817b4068..d1181816906 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -88,12 +88,16 @@ test_rebase () {
 
 	test_expect_success "rebase $args checkout does not remove untracked files" '
 		test_when_finished "test_might_fail git rebase --abort" &&
+		test_when_finished "rm -f .git/post-checkout.args" &&
 		git update-ref refs/heads/rebase-fast-forward three &&
 		git checkout two &&
+		rm -f .git/post-checkout.args &&
 		echo untracked >three.t &&
 		test_when_finished "rm three.t" &&
 		test_must_fail git rebase $args HEAD rebase-fast-forward 2>err &&
-		grep "untracked working tree files would be overwritten by checkout" err
+		grep "untracked working tree files would be overwritten by checkout" err &&
+		test_path_is_missing .git/post-checkout.args
+
 '
 }
 
-- 
gitgitgadget

