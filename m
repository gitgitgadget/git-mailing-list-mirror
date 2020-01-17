Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FBEC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB412083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWnIXxqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgAQMXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:23:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39903 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAQMXf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 07:23:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so7411150wmj.4
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 04:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yyiAbtp0KD6tm85cJzPFjDk3InQK5Lch3xx3GQg6ifw=;
        b=KWnIXxqJbapOR/J625s5VBjxuRWN0k81vYtYINZTvVsXBGCEeUpOHzdj3q/KK7DfF5
         ZpizJaqLwSyOhPPrN0tf3kgBXC+HFX4BBApWnMnN85/j7vpDaUgaK81z/o9pEqOHlrwV
         Agm69N//me6FQFUWlQSkVc/1pC0WH6hcSJxi9ncf46hpoAhz232EpSjlplRs/0DT3IS3
         NGf/PXWUSH3fAF+6Q6vmIDNIELppUjjE7ywppkek4/CW6NkKhEfcX/yKjSSyrcsaIPae
         IkzOku58VbdIV+S2hENJe3HYZppQ01rp2pspon8rj8qH4NlpcKyOnUP7zbzoj8n4zgxY
         xaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yyiAbtp0KD6tm85cJzPFjDk3InQK5Lch3xx3GQg6ifw=;
        b=OywwCmbUOD/bfJeE2yRcDpnxYYvgHLRVDCb51/A87KKCxaqMwIrWHxqg4C02eHLrrz
         CijMahTviQD6nRdVw90S0UAHZtkmjZFvldjjH/3tLFwiSHwOfqFlN9Yv+KV/pPy00mnq
         eiiuAd+R+9IaFYPoOhOh/K6iDqHOx5i+0ZiIACRkS1aeoNWz/MhWT/gAPZrt38wIJPpE
         7yCh2R6BxqwAl76JgSHF+R11m2BkZdQKz06K4un/vxLUR1Ot6AKUUHomZSrKUS0xxjoL
         7GRKhOCZbvZPhYvXt25jDkX+3xoSuDaEVK6hqllMz0+2LH/itG7oc9YNjTQPtGvBvPvJ
         hLFg==
X-Gm-Message-State: APjAAAVc3AFKizAfARQXC/vMYPHW1fFH8TrxI2+W35IKJydW35ZgKmih
        wLKyWrmIAs4gVE98dAhfjrbnx52S
X-Google-Smtp-Source: APXvYqym6WvhAs7JDdifw+pwhBWWttla5JRgrLoaui7jePYxg+D58WuahePh0wLEDKqPnQrViv9kBA==
X-Received: by 2002:a05:600c:24ca:: with SMTP id 10mr4416757wmu.4.1579263813950;
        Fri, 17 Jan 2020 04:23:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm9452352wmm.15.2020.01.17.04.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 04:23:33 -0800 (PST)
Message-Id: <6e0e664026757315a337dead8079167f4fb29c4b.1579263809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.523.git.1579263809.gitgitgadget@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 12:23:28 +0000
Subject: [PATCH 3/4] t2405: clarify test descriptions and simplify test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

When 'checkout --to' functionality was moved to 'worktree add', tests were adapted
in f194b1ef6e (tests: worktree: retrofit "checkout --to" tests for "worktree add",
2015-07-06).

The calls were changed to 'worktree add' in this test (then t7410), but the test
descriptions were not updated, keeping 'checkout' instead of using the new
terminology (linked worktrees).

Clarify the tests by using the right terminology. While at it, remove some unnecessary
leading directories such that all superproject worktrees are directly next to one
another in the trash directory.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t2405-worktree-submodule.sh | 36 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index b9040c30d4..f1952c70dd 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -18,43 +18,39 @@ test_expect_success 'setup: create origin repos'  '
 	git -C origin/main commit -m "sub updated"
 '
 
-test_expect_success 'setup: clone' '
-	mkdir clone &&
-	git -C clone clone --recursive "$base_path/origin/main"
+test_expect_success 'setup: clone superproject to create main worktree' '
+	git clone --recursive "$base_path/origin/main" main
 '
 
 rev1_hash_main=$(git --git-dir=origin/main/.git show --pretty=format:%h -q "HEAD~1")
 rev1_hash_sub=$(git --git-dir=origin/sub/.git show --pretty=format:%h -q "HEAD~1")
 
-test_expect_success 'checkout main' '
-	mkdir default_checkout &&
-	git -C clone/main worktree add "$base_path/default_checkout/main" "$rev1_hash_main"
+test_expect_success 'add superproject worktree' '
+	git -C main worktree add "$base_path/worktree" "$rev1_hash_main"
 '
 
-test_expect_failure 'can see submodule diffs just after checkout' '
-	git -C default_checkout/main diff --submodule master"^!" >out &&
+test_expect_failure 'submodule is checked out just after worktree add' '
+	git -C worktree diff --submodule master"^!" >out &&
 	grep "file1-updated" out
 '
 
-test_expect_success 'checkout main and initialize independent clones' '
-	mkdir fully_cloned_submodule &&
-	git -C clone/main worktree add "$base_path/fully_cloned_submodule/main" "$rev1_hash_main" &&
-	git -C fully_cloned_submodule/main submodule update
+test_expect_success 'add superproject worktree and initialize submodules' '
+	git -C main worktree add "$base_path/worktree-submodule-update" "$rev1_hash_main" &&
+	git -C worktree-submodule-update submodule update
 '
 
-test_expect_success 'can see submodule diffs after independent cloning' '
-	git -C fully_cloned_submodule/main diff --submodule master"^!" >out &&
+test_expect_success 'submodule is checked out just after submodule update in linked worktree' '
+	git -C worktree-submodule-update diff --submodule master"^!" >out &&
 	grep "file1-updated" out
 '
 
-test_expect_success 'checkout sub manually' '
-	mkdir linked_submodule &&
-	git -C clone/main worktree add "$base_path/linked_submodule/main" "$rev1_hash_main" &&
-	git -C clone/main/sub worktree add "$base_path/linked_submodule/main/sub" "$rev1_hash_sub"
+test_expect_success 'add superproject worktree and manually add submodule worktree' '
+	git -C main worktree add "$base_path/linked_submodule" "$rev1_hash_main" &&
+	git -C main/sub worktree add "$base_path/linked_submodule/sub" "$rev1_hash_sub"
 '
 
-test_expect_success 'can see submodule diffs after manual checkout of linked submodule' '
-	git -C linked_submodule/main diff --submodule master"^!" >out &&
+test_expect_success 'submodule is checked out after manually adding submodule worktree' '
+	git -C linked_submodule diff --submodule master"^!" >out &&
 	grep "file1-updated" out
 '
 
-- 
gitgitgadget

