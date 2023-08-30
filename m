Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4141C83F1B
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjH3S3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbjH3QoM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA781A1
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e4d2b7d16so81983167b3.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413848; x=1694018648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4lD4HwO+DkoOj8CZD/xO8HI1nsAXhFIfmBS8F/rsik=;
        b=wPLWEGdAIs2BmrTzymdwWBXM+5TJ/F65t4DcooLlBF51Fnvg+WA74LEiIXoW94enxc
         1yTSWoJIdvoVxwzl6lic51bCiHaqqoedIE8g8mgCgmnYOMXxlhKOUQyNXTzZ+n7kVfe8
         DGvKC8l2QKwxbxSsjPYkoYgYt34DOoDFXciiZE82pOey8vTNmap8EII1vb1Zfn1FMs2O
         vqNZvdXkC3bSBQ0+4Ag283GFkzW5jm7q0HiiME0XEj7KlZ83GR8QyvzlxwEtx+dQcY8H
         8bXKbC3rJdB5aCq4TEOJCNu0c8p4qxJQqA28jHspI6Id8XitLMvbe69Q39zt/ke6yXNO
         wZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413848; x=1694018648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4lD4HwO+DkoOj8CZD/xO8HI1nsAXhFIfmBS8F/rsik=;
        b=GfIOuZpbTGxbdxkGZ/gA681gdLJDuEEu8TRS4Pab6ADLCtcQOGOj4XvJeGqFKC+PFh
         barEzC+otlTyNvKA20882n/HovgqsMzM5gsjnapC5yJ8iUkUHr5cHYR/oBjBnRiPsanv
         txl2pf53+2Xrbq/UiKw/TiYxVVonSDPc8vP5+WMI+7Kg5mPunCWOFUBPAD0gXwlfokCe
         n8FPlX81otXo7qNzTlVxsQNv4lCbEoK6QCFkVP12/OYoPgikJN0qlw2xrmJgLBQ2BZ+a
         OvQ6q7TZN7F/FMNFzSwDjB5eTUv4KC4QafRTaJ+14SaVasHGvrG7kDFVNgOnBGVulO26
         hEIg==
X-Gm-Message-State: AOJu0YwHKaxW/C3kaq+ErAmc+pKpJOBh4nyWFKbWg2njzzKTN7vgGzt8
        Bvch1//ZbxCYjJNH0jELh3e6+OyepUgn8ilfciL22paCQFqSdbhS30/HRTgRrf+66IYcJq+MuMc
        QUpgI8SoOFLlMoDR+FV7c5ZFz5chekExTytpTHyrm9DawATlRZmeyNpjxyaKienAjwEwtePvlLN
        s9
X-Google-Smtp-Source: AGHT+IHXBF3axItj1n4PMddneg/Nm3dpkDbGMqPwqx3gWC/yQsHZpOX3t/A89CuMIw0XhVDWrXvAlrSuh2kdT70jN8DU
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1366:b0:d08:ea77:52d4 with
 SMTP id bt6-20020a056902136600b00d08ea7752d4mr80159ybb.12.1693413848498; Wed,
 30 Aug 2023 09:44:08 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:45 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <785801066563fdc9ec74635886aaea36347e45dd.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 05/15] t4216: test changed path filters with high bit paths
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4216-log-bloom.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..0aa9719934 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -404,4 +404,56 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+get_first_changed_path_filter () {
+	test-tool read-graph bloom-filters >filters.dat &&
+	head -n 1 filters.dat
+}
+
+# chosen to be the same under all Unicode normalization forms
+CENT=$(printf "\302\242")
+
+test_expect_success 'set up repo with high bit path, version 1 changed-path' '
+	git init highbit1 &&
+	test_commit -C highbit1 c1 "$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'setup check value of version 1 changed-path' '
+	(
+		cd highbit1 &&
+		echo "52a9" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual
+	)
+'
+
+# expect will not match actual if char is unsigned by default. Write the test
+# in this way, so that a user running this test script can still see if the two
+# files match. (It will appear as an ordinary success if they match, and a skip
+# if not.)
+if test_cmp highbit1/expect highbit1/actual
+then
+	test_set_prereq SIGNED_CHAR_BY_DEFAULT
+fi
+test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
+	# Only the prereq matters for this test.
+	true
+'
+
+test_expect_success 'setup make another commit' '
+	# "git log" does not use Bloom filters for root commits - see how, in
+	# revision.c, rev_compare_tree() (the only code path that eventually calls
+	# get_bloom_filter()) is only called by try_to_simplify_commit() when the commit
+	# has one parent. Therefore, make another commit so that we perform the tests on
+	# a non-root commit.
+	test_commit -C highbit1 anotherc1 "another$CENT"
+'
+
+test_expect_success 'version 1 changed-path used when version 1 requested' '
+	(
+		cd highbit1 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
 test_done
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

