Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FB0C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF1522CAF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbhAWNCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbhAWNBs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:01:48 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDEEC061788
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j18so6590746wmi.3
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yic/Yy6hNB5o7SqughnfPB86/3RjIAx5Qe3c2I6N3SQ=;
        b=TUTx7a6W0pn6bI4nLJ4GN9/A1xZo7cayNVQFhS9sEXpih7TDHvE5K4vZo/zd7DhDMq
         xOokIDo72NQ/p6217V8NvKlvvTuxB6Y2xcQ3ieXRey0gpS+6fl/G5+F9Ijz7nMJkCbMR
         o8vlKLcljRKpmWTRHkrqzZ3j0rNOnQVHTLz2MWVlP1wEUS/C8QtMAocH5oQ7hDRFHtFi
         jkoQOUUI+v7m497GbAMQYrt1k2AQJxti6gzc4gXYau1RhzxDTXwLcUP3iBOrmo7WUQNG
         0T9bVk6QaNWBbLeirNfZYGAQIv17bc/pqfe4EQYtDmnfDiVlHQzzFXLt+Rg05DG4G/SF
         kU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yic/Yy6hNB5o7SqughnfPB86/3RjIAx5Qe3c2I6N3SQ=;
        b=kRnqpD74VmfDlxC+tlEN7QMbPrTZwjSjqVdQ+pKnTsGI4OVb7UGY3GA8K/DvQb0eR4
         dsbbpYTlu2bC245WOMxnLPA6y8GhocDvibkf6QLtG8mSKl9bDSI8wBUjJ6tK8xlnS0RV
         XX1PyiFaLzK8ajmYeGwMKr0ZAluCLxvDb+6KAzhXvGgsJKJhQAq+Kc5qntBMJ89QmAcN
         GP7Pgj8tioaqvVzanGBwk18/Xwx9j8TbQD7JZzQ63/EU+ZgtKrp03jszT5H+3mW4XTbq
         9C3wV8kUzQ3NcZN9OLL3DfHr+Fx1BH3+VwMQPG76WPEUzKRm7Axe8MwTdrzOkyz/s7PC
         kkSQ==
X-Gm-Message-State: AOAM530BJYC/QHiVw3rd6MI4idtAXfUf0mSIA4VCsFVrR5ZJCViv5yeh
        ScdTpHM6KeGSFAPhPpkR4bX3VLgHZBrVgQ==
X-Google-Smtp-Source: ABdhPJz1I1BM8e0vlbtIUxoKdO0ybUrxly65kPsP0iULKAz0xrBH9NtrGB0lzjRPTBIg1UrWJvH2Ag==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr8391932wmc.68.1611406866829;
        Sat, 23 Jan 2021 05:01:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/10] cache-tree tests: use a sub-shell with less indirection
Date:   Sat, 23 Jan 2021 14:00:39 +0100
Message-Id: <20210123130046.21975-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a "cd xyz && work && cd .." pattern introduced in
9c4d6c0297 (cache-tree: Write updated cache-tree after commit,
2014-07-13) to use a sub-shell instead with less indirection.

We did actually recover correctly if we failed in this function since
we were wrapped in a subshell one function call up. Let's just use the
sub-shell at the point where we want to change the directory
instead.

It's important that the "|| return 1" is outside the
subshell. Normally, we `exit 1` from within subshells[1], but that
wouldn't help us exit this loop early[1][2].

Since we can get rid of the wrapper function let's rename the main
function to drop the "rec" (for "recursion") suffix[3].

1. https://lore.kernel.org/git/CAPig+cToj8nQmyBCqC1k7DXF2vXaonCEA-fCJ4x7JBZG2ixYBw@mail.gmail.com/
2. https://lore.kernel.org/git/20150325052952.GE31924@peff.net/
3. https://lore.kernel.org/git/YARsCsgXuiXr4uFX@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0090-cache-tree.sh | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 7ff7f04719..5bb4f75443 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -17,7 +17,7 @@ cmp_cache_tree () {
 # We don't bother with actually checking the SHA1:
 # test-tool dump-cache-tree already verifies that all existing data is
 # correct.
-generate_expected_cache_tree_rec () {
+generate_expected_cache_tree () {
 	dir="$1${1:+/}" &&
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
@@ -28,18 +28,13 @@ generate_expected_cache_tree_rec () {
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
 	for subtree in $subtrees
 	do
-		cd "$subtree"
-		generate_expected_cache_tree_rec "$dir$subtree" || return 1
-		cd ..
+		(
+			cd "$subtree" &&
+			generate_expected_cache_tree "$dir$subtree"
+		) || return 1
 	done
 }
 
-generate_expected_cache_tree () {
-	(
-		generate_expected_cache_tree_rec
-	)
-}
-
 test_cache_tree () {
 	generate_expected_cache_tree >expect &&
 	cmp_cache_tree expect
-- 
2.29.2.222.g5d2a92d10f8

