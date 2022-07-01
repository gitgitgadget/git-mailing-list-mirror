Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F7C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiGAKiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiGAKh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:37:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5807969A
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so3037947wmc.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ca5w5CqWQOiRhpc/mQX3C/lEE9+FaPWQDOOwPIJasPQ=;
        b=KjRYnX89ArcMp/mDOo71kutejkHhHfnYBcyv8uJE5oO3jMWKiY31q0tFMh1qIX5BS7
         5V3/oxkyv5ar1+bysRn9ytMGEqSHAs36M/DxLxjngJ5uj7b4Wu0mfyrkPYWpO/No+C9j
         JyTmWZ82kna3IQL34KYNE5lzybtllj4Cd9jwCKtU8THyqw143fkq2f+EziWYop7ZILt4
         1a1IYtT9VcpecWAtyv6DyaIj0zIevwUgKIeG/BuEgPuWV2U+RzaXL5elsxrR23vry7VZ
         Kx+vyLmLuZLhrqrpmfFS/jlviegf3lGAMArRbAV0V7MH2U7nB2Ync/NJMm5nGc0mOk2C
         s/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ca5w5CqWQOiRhpc/mQX3C/lEE9+FaPWQDOOwPIJasPQ=;
        b=BQf99wqQASq3F8t2osKr2PRIwVQIQ3XQFhq5O8sX2mr/U1soc/D+6dqifaSyCOkgOb
         ZgVr5eIl+R0xcyezKmik8uOywASjqz3Z6fgBFIsiPAMmEhku30CXPsnGGU6yGRINCSdG
         5IztwMm0qmSrIGbrmSgiwMnI3/Cpc5RvltNNbnHFzuKyKWdTiFh6xfeSMST7OHU3u8mR
         5FCe7XCUQcWkK105YTSMvHS3PH42oRofVtPhrYAgSm80of6oq3+xTtdFneqZ6QVcNKdo
         0N5kS5UPjonZe3aLSZX6i/2ITZdi7AVgEcEUfpctifJjS+E9iR3N8A5Y12MJMCuEVVsg
         oZgA==
X-Gm-Message-State: AJIora8nNSgZQvclVcQHTvb8slv1LTpsOu039I/hNna6wSdNFqtyYWL4
        5gUd127J99QaOdzGThnYtUqswjzpHpeD0A==
X-Google-Smtp-Source: AGRyM1uH3I+rqZ1Gx7w5xAdhbQtCnn17JnfGfdUQ8oqCIn629De4ma7VCdfb0D/Goifi6G4zEggn7w==
X-Received: by 2002:a05:600c:3ca2:b0:3a0:1825:2e6b with SMTP id bg34-20020a05600c3ca200b003a018252e6bmr17312116wmb.132.1656671874285;
        Fri, 01 Jul 2022 03:37:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/9] test-tool bloom: fix memory leaks
Date:   Fri,  1 Jul 2022 12:37:38 +0200
Message-Id: <patch-v2-7.9-0957c99817b-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks introduced with these tests in f1294eaf7fb (bloom.c:
introduce core Bloom filter constructs, 2020-03-30), as a result we
can mark almost the entirety of t0095-bloom.sh as passing with
SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true", there's still an
unrelated memory leak in "git commit" in one of the tests, let's skip
that one under SANITIZE_LEAK for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-bloom.c | 2 ++
 t/t0095-bloom.sh      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index ad3ef1cd77a..6c900ca6684 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -16,6 +16,7 @@ static void add_string_to_filter(const char *data, struct bloom_filter *filter)
 		}
 		printf("\n");
 		add_key_to_filter(&key, filter, &settings);
+		clear_bloom_key(&key);
 }
 
 static void print_bloom_filter(struct bloom_filter *filter) {
@@ -80,6 +81,7 @@ int cmd__bloom(int argc, const char **argv)
 		}
 
 		print_bloom_filter(&filter);
+		free(filter.data);
 	}
 
 	if (!strcmp(argv[1], "get_filter_for_commit")) {
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 5945973552a..daeb4a5e3e7 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -67,7 +67,7 @@ test_expect_success 'compute bloom key for test string 2' '
 	test_cmp expect actual
 '
 
-test_expect_success 'get bloom filters for commit with no changes' '
+test_expect_success !SANITIZE_LEAK 'get bloom filters for commit with no changes' '
 	git init &&
 	git commit --allow-empty -m "c0" &&
 	cat >expect <<-\EOF &&
-- 
2.37.0.900.g4d0de1cceb2

