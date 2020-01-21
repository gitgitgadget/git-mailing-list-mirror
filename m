Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D692C2D0DB
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8A421569
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+kfUDe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAUPBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:01:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38811 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgAUPBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 10:01:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so3569425wrh.5
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=57T/B0gGtAvH23Pp+uSvPOJTmUnO1UCQprr0xSugBr0=;
        b=p+kfUDe9jG1uPlmuR+Pe6oAPHG4VEQuuJ9l6SmDc3lLQMqPdILzRvBYwj3ljgY7b3M
         6GXPd5XiJkqQRvIw4xIdlLmXJ4WXHDoQJvECnJ8tlWaH/1z6wGmlfZeTdJ5VnMLbr/Vy
         MboCat/v3MyCAWUCS/xkqmz27miix7XbFWaVlKr/Xs7aFG5c8xX7zpvpExijYz2+H2Dk
         Aw6iGt6n6m/W3P/IsQuHIW5MkwkPyETYrQXK1CzOnR1VmPDT2wAI2L5DB44XSELINnH6
         ln4PJb6gWbUKUZ8RbIkZZB5RWz1C/VUAuaKodL99be+yGgGUZPJTZE0sCtSMO7ro7B6X
         oFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=57T/B0gGtAvH23Pp+uSvPOJTmUnO1UCQprr0xSugBr0=;
        b=CWrbrh8UIbHMezz0jgEwNRswqXrwpZg3tBgnCMX+bnD7GoFgklw6GH5GvSpaA/DQiH
         OqDScELlHMRhkykeoXqdkBtex0JOAGJ/rJWzccVb+hkSAxIpkBUw2z8iF71jt90DJSnA
         isytCTJNNmICzi057UzvytPD2pYyJReeIRzvLU9SphPj0d2FRW0zkfN4PV8yLVN5m7sj
         HIQJAMTSGeN0mQpZKHwvDqUJMVLmsS2VYnDiIFXYaOhN0kxb0TeYu0QSGnUqJPl+BOS0
         yeDim/cVjzhkYmJAa475QNMgdDfbKg5jGNz8+RQKEWf1UrjscU7n0sMiBYBIzFUCQr69
         rxog==
X-Gm-Message-State: APjAAAXtvGdav6y9vMNJQVF+txIauNpSuvUxzOAutaufJFOnm80JYMGf
        ryx8xeQ9B6qL4cNELt0PdsDadWOY
X-Google-Smtp-Source: APXvYqwCpOUZIt+VlLYMKwvvtmzJxGNfoLTl/4UDs+laanv8ljkgl84Tu1y810PNcijMW4vw3wquBg==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr5988805wru.40.1579618881360;
        Tue, 21 Jan 2020 07:01:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm4249554wmg.46.2020.01.21.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 07:01:20 -0800 (PST)
Message-Id: <10727275a2a7188eec374a82438eeda09f3b82b8.1579618877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
        <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 15:01:16 +0000
Subject: [PATCH v2 3/4] t2405: clarify test descriptions and simplify test
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

Also, in the test each worktree is created in
$TRASH_DIRECTORY/<leading-directory>/main, where the name of <leading-directory>
carries some information about what behavior each test verifies. This directory
structure is not mandatory for the tests; the worktrees can live next to one
another in the trash directory.

Clarify the tests by using the right terminology, and remove the unnecessary
leading directories such that all superproject worktrees are directly next to one
another in the trash directory.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t2405-worktree-submodule.sh | 36 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index c4e555776a..d0830058fd 100755
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
 	grep "file1 updated" out
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
 	grep "file1 updated" out
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
 	grep "file1 updated" out
 '
 
-- 
gitgitgadget

