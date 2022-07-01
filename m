Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C79C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiGAKh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbiGAKhw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:37:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6076E7969A
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q9so2580160wrd.8
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rqez1klTZBqtfKpHA1O74r6gJIg2hqaiAW/GbxrR+BI=;
        b=AkMSlA8baZp0FTntwnX5V3vzXun2WzCrjwZlxLukqyjwqGo8qJS9JCMY2AH8n0tZzB
         a9tV7tilv6/wssmy/B5qyCTGe5bo4Jvd12nV2gWUcXNqHPF78AfUH6VlOgZXnYROCLpN
         suLpCxNR9vsBJc9MOtSmmyXRChYUrNX8tafxHYBc111AA8du3m/tYe3ENjzVW2eA7LSw
         c+hn9eUrkadIcV+sM3jrBY2hhD9At6+D5m73Zk2LQkD6rNtTKIXGCtV1jWhpji8kKWE3
         U5tmnimMQ+W8xNFbtus6oRU9b5hZoAXZIFlJq7PG84SJ7rgylImopmTZWu4Roc16UhDy
         54Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rqez1klTZBqtfKpHA1O74r6gJIg2hqaiAW/GbxrR+BI=;
        b=EHAIIM2L+EickjdszgNKvpUl4x61g+DDZbGpPWyfiC4ZE1NS+43rcuHoI46PcAa/eX
         PkA7oB4IWvHkr+9yWH0rQiIijfeiX4Y8uPtc7NPMMRh/AlYE4kn9Iwt/3c08hA6pMztb
         OI6CjOfMeQVxh3g5yyWC9mVKQoP68OkFZRU0RzndlfZY7iyo4VQLvyJ2inYaOb8ttZ6t
         hFwegnf4DlRCBCNeFP2jQqwgXLEx80F/t/w0hKqgWE4nfuEqZusnOdVzGsx+INY87UnK
         OoPAHB7xBSMG3Pc46ItO4f6p+YHaOreQKWUjnXS5u1dfz6CusfLuINHzsVgK3t8XZXVl
         kIhA==
X-Gm-Message-State: AJIora9A/Wiwin2gW3kj8KpQyJEuVwOLxTh7v0Erw5HnN5MD/OKFK8e8
        A5gH3YGGwc2u/VrOz8w615wb/LVwynznuw==
X-Google-Smtp-Source: AGRyM1u3z2N2DL1Pb7GMPGnFxHJQF7NVxNYmjkhdYK7uJLzJkgpVbMCbSv3nyVokfdEpe8k0hDkCTw==
X-Received: by 2002:a05:6000:1d97:b0:210:25d6:e125 with SMTP id bk23-20020a0560001d9700b0021025d6e125mr12497251wrb.464.1656671868535;
        Fri, 01 Jul 2022 03:37:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] test-tool test-hash: fix a memory leak
Date:   Fri,  1 Jul 2022 12:37:32 +0200
Message-Id: <patch-v2-1.9-4406fedba80-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in "test-tool test-hash" which has been there since
b57cbbf8a86 (test-sha1: test hashing large buffer, 2006-06-24), as a
result we can mark more tests as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-hash.c              | 1 +
 t/t0015-hash.sh                   | 3 ++-
 t/t5308-pack-detect-duplicates.sh | 2 ++
 t/t5309-pack-delta-cycles.sh      | 2 ++
 t/t5321-pack-large-objects.sh     | 2 ++
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index 261c545b9d1..5860dab0ffa 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -54,5 +54,6 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 		fwrite(hash, 1, algop->rawsz, stdout);
 	else
 		puts(hash_to_hex_algop(hash, algop));
+	free(buffer);
 	return 0;
 }
diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
index 086822fc45b..0a087a1983d 100755
--- a/t/t0015-hash.sh
+++ b/t/t0015-hash.sh
@@ -1,8 +1,9 @@
 #!/bin/sh
 
 test_description='test basic hash implementation'
-. ./test-lib.sh
 
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
 
 test_expect_success 'test basic SHA-1 hash values' '
 	test-tool sha1 </dev/null >actual &&
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 693b2411c89..655cafa0541 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='handling of duplicate objects in incoming packfiles'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 55b787630fc..4e910c5b9d2 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test index-pack handling of delta cycles in packfiles'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5321-pack-large-objects.sh b/t/t5321-pack-large-objects.sh
index 8a56d98a0e8..70770fe274d 100755
--- a/t/t5321-pack-large-objects.sh
+++ b/t/t5321-pack-large-objects.sh
@@ -6,6 +6,8 @@
 test_description='git pack-object with "large" deltas
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
-- 
2.37.0.900.g4d0de1cceb2

