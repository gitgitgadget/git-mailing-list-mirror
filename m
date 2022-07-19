Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42978C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiGSVFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbiGSVFg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946153DBDC
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c22so1508616wmr.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFlMPu7IdLHqAcXqRWRSzDee6l1ebvbO/JBM1MFZ+J0=;
        b=CuYIzOlK+rp3xI54pc5uyTKhPSLy/N4Kk6RqhOkXnEhQw2a99Ju36x+/y+WeYugATr
         OsP68T4mMmm+rQPuZHathlbDQWZwEZ4vJZaHHc9J6JneyzqFLFYIssCKeWKiw42tTbRy
         OXGmvS7kbYx0yHv6VkPMw2wSrJnm+i+447yNQWKkky5mRELGI/62coil25R186r3otiZ
         7/upZsnMWL+ZXnA9SDBBm8qmcjj61xwfX2E3kX4PFgiXay23kLAXoOy7T9SMORlQwk5k
         FjSDKsz/4PKjs1JX5dz/C3LatnjBRN1TT4OddrU3ZJrxd0mm5PehMEH6kS/aqOueWAvS
         ml6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFlMPu7IdLHqAcXqRWRSzDee6l1ebvbO/JBM1MFZ+J0=;
        b=Z9L53v6wc+pwwJwB+UoHGm2N/4iJVmIgjAmPNV4mp0uk19mL1E0moD7rJT8eYwRUw5
         hFeD4ptWlE6WKLYccPseSIg2NqRFQKI11jGFC1dzhkVHqKyRaKL8U2HE8Mv5I5IpAbaV
         o7XG8OBEB5ntBbAOFK5rb43DLmMoDvT9jP8OyQkpWtqtQe/gjRsHi5416EP6NiHmC/Xy
         HHTgKnlVhIQL9CFZu1LHsy/Dkl0oh1njfMjhAq1thOYuFsjTiLIQfh37PXrchQg8kScm
         MUH/JedBYfw1fo5b1tPGvkXJrtik7Y/sPEoFaA69GtdE9NJaSleQYf5SQgvLlETydrhJ
         4Ihg==
X-Gm-Message-State: AJIora/cUuM1JoVOYzHS2bITH5I8VwKXsn3OB4kYt07z3trCuVQU3fA7
        EX9VAWE7bECwTVNl6Ub/GgaOoNu08x+OTg==
X-Google-Smtp-Source: AGRyM1sXQgClyssnu/Cjxlev6GoT8+YGKpz2uCCb4A9TL6jWSw9izQK0Tpv7zw2M7/Rca6oiTNuqJg==
X-Received: by 2002:a7b:c3c6:0:b0:3a3:2065:e022 with SMTP id t6-20020a7bc3c6000000b003a32065e022mr941222wmj.117.1658264733890;
        Tue, 19 Jul 2022 14:05:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] test-lib.sh: use $1, not $@ in test_known_broken_{ok,failure}_
Date:   Tue, 19 Jul 2022 23:05:15 +0200
Message-Id: <patch-01.10-5664c4f9a0e-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify that these two functions never take N arguments, they'll only
ever receive one. They've needlessly used $@ over $1 since
41ac414ea2b (Sane use of test_expect_failure, 2008-02-01).

In the future we might want to pass the test source to these, but now
that's not the case. This preparatory change helps to clarify a
follow-up change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7726d1da88a..3f11ce35112 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -804,14 +804,14 @@ test_failure_ () {
 
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
-	say_color error "ok $test_count - $@ # TODO known breakage vanished"
-	finalize_test_case_output fixed "$@"
+	say_color error "ok $test_count - $1 # TODO known breakage vanished"
+	finalize_test_case_output fixed "$1"
 }
 
 test_known_broken_failure_ () {
 	test_broken=$(($test_broken+1))
-	say_color warn "not ok $test_count - $@ # TODO known breakage"
-	finalize_test_case_output broken "$@"
+	say_color warn "not ok $test_count - $1 # TODO known breakage"
+	finalize_test_case_output broken "$1"
 }
 
 test_debug () {
-- 
2.37.1.1062.g385eac7fccf

