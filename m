Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D28FC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiGAKiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiGAKhx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:37:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50906796BA
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k22so2588247wrd.6
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vu2/8s4kOtbJaAUdt7iB+IA1LGia9fD8Zda0Dx9tDk=;
        b=DLTrfFyKR4iIgxt2becW4b+72ntl5iQG+TQZtiBAInt3ht7pPzA1SJ9TlJICAbjuov
         gy6Fs6MySwN+zJIbSnfuZWwLbbwJmlboYPaCROeDwfjuFzGN6ptoYmRIPgwH5Zi1TX7U
         NxTHDY2oDV0UFpSKIWGYAJnHvwMkomx+W+9sYgRlmrUuowkjd6XcXt4/TA23p7IT1OW4
         ueUad6Smzz9+5NyezWjNWs60IFh2T9SBZLh1KK6df/dz3Ti2oG8GmQ/kTq5TMshv0143
         nhce1wNRwXCN0w48zJUwb5CuYS8EmUAthmeM7vG0L9QcIPm01j00Jayv3Z9FhdDR8TsH
         Kkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vu2/8s4kOtbJaAUdt7iB+IA1LGia9fD8Zda0Dx9tDk=;
        b=25KK3UaZaPyq0wiwYXzkHHCNg0b6dyarvyDUZbDv30Nh38Gcp2RL5pOmDsjf4Accgt
         4jyYhENp58LXtn1J7ZEQ1Li3kVlWrxZ7gPo9FN1WtfqIiqzEYA4LIwWFYvH6EL0D3ED+
         WmqFU0AsJtQs/ht0MMOQ3RKi5UdX1CCGjDLuQAakq74uVygUreBUxLeP5N7wTx07Gq34
         VREuW6VAkDWHwfTrDCpkD8ucguA+4d8c3AgmfZaXnTyo4JFhH+vn/DaZoSILqWrPbWlx
         V4CFU3tobYT3aISPNWOWWPTQqxy+7xR2N+ehPKNcsQadfht4zZxx/8DEwCQU/6ke7Wuh
         kySQ==
X-Gm-Message-State: AJIora9PAPNcbrZiWTXG6ObL7dECMeGMRdv0EeIzFsvHhNNqXKmYa6xO
        B46ZR54lpgOELpQnmkc5toH71fKX1FiHcA==
X-Google-Smtp-Source: AGRyM1vSBD+2aitBf6ukgBGA0NdMzsls7kSVSNWCiw22OoS0IhR/q8JI1tnyJv/DJ8mqURn+YFRZLg==
X-Received: by 2002:a05:6000:5c5:b0:21b:9b11:9128 with SMTP id bh5-20020a05600005c500b0021b9b119128mr13190715wrb.492.1656671870584;
        Fri, 01 Jul 2022 03:37:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] test-tool {dump,scrap}-cache-tree: fix memory leaks
Date:   Fri,  1 Jul 2022 12:37:34 +0200
Message-Id: <patch-v2-3.9-5f9f34629c4-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in two test-tools used by t0090-cache-tree.sh. As a
result we can mark the test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-dump-cache-tree.c  | 7 ++++++-
 t/helper/test-scrap-cache-tree.c | 1 +
 t/t0090-cache-tree.sh            | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 6a3f88f5f5d..0d6d7f1ecbf 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -59,11 +59,16 @@ int cmd__dump_cache_tree(int ac, const char **av)
 {
 	struct index_state istate;
 	struct cache_tree *another = cache_tree();
+	int ret;
+
 	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
 	istate = the_index;
 	istate.cache_tree = another;
 	cache_tree_update(&istate, WRITE_TREE_DRY_RUN);
-	return dump_cache_tree(active_cache_tree, another, "");
+	ret = dump_cache_tree(active_cache_tree, another, "");
+	cache_tree_free(&another);
+
+	return ret;
 }
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 393f1604ff9..026c802479d 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -12,6 +12,7 @@ int cmd__scrap_cache_tree(int ac, const char **av)
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	if (read_cache() < 0)
 		die("unable to read index file");
+	cache_tree_free(&active_cache_tree);
 	active_cache_tree = NULL;
 	if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		die("unable to write index file");
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 90675726484..d8e2fc42e15 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -5,6 +5,8 @@ test_description="Test whether cache-tree is properly updated
 Tests whether various commands properly update and/or rewrite the
 cache-tree extension.
 "
+
+TEST_PASSES_SANITIZE_LEAK=true
  . ./test-lib.sh
 
 cmp_cache_tree () {
-- 
2.37.0.900.g4d0de1cceb2

