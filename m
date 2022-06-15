Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE5DC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbiFOKgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbiFOKgt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:36:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA50D50031
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:36:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u8so14729031wrm.13
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=567gwqkG+nqqOnrFkdgP8fsb2FUO3nVv6L99wr0AA7o=;
        b=HHOWilZl3dUYkV7mB9zOlV13xvoXRsij5ya5+FvcMfPlT75Iyf6Kp+WYO/iLm/g2MU
         e1epanT/k/Z6XgUIlVcGOs+WfRs0wQvXfLQYW4vsKFDqOoWDfYz1OG5V2WfkTut5nEzR
         qW4ouyEmNqR3sHgO4cd/Do/LUrdVKKtNPp9Ra6wwi6jqOu1xdzvVxfkzQtEdyQuL4/1Y
         cQHCaFmZQqY2mcccAjAIq/4e9pQBd8ME+fLYY4u7R/sKuT7p0PBCIpWCGOs946ZcO9uQ
         4YPy+QK1CXqwdjudvm6ZW82hu/sOUT5ClQVJFy6g3EhhKkQeVjQc4qWhDWUBN/98EXqH
         zJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=567gwqkG+nqqOnrFkdgP8fsb2FUO3nVv6L99wr0AA7o=;
        b=AMEpiHCk1Hq6yrRBjo1zMdLE7pKr7Ajc9ZlsTDfZQ98Iqhn7g03uFq/fbJR0zFBU2Y
         /NL8c7si24ZPPhQAvRicFSV1h3EusvcVlBOlXZ7Q8qknCXnxXEDQq04nQCTEYkS8LuiC
         D0wih/gjV6xhiQkzK3uzOhkbrikwNAS4fGL0t4uQIEbW6ctQBX52Q14pwP03jPl1LfWH
         83JBiVBzhZhL0C1GNeqXEGTDEXPtIz4CXOf+45XCuqYC3eW+usZ3JPdHchKHGxZhbD9m
         s8l/KPtmqGNKxaad7WFCRjpY4DHJLob1ZFvAYWViwrq75sB4xJuw7Lwd/T3E2locAsts
         iFDw==
X-Gm-Message-State: AJIora9rBWyCpVh2vKgnE4Dw/GNn1n65w07QGKYj3OxI7Xk77a+jyFuh
        Hs18b/apt3WsyDV8rk/C4ypgllpm/zp1Aw==
X-Google-Smtp-Source: AGRyM1t301ry4g7q4Lk1j8d7Pq8KRkpwNXWyfeN6Jw7vBHtPj12LhX4NL0YqSJbJPkb1k74DySOcLw==
X-Received: by 2002:a5d:6786:0:b0:215:3cb5:b16c with SMTP id v6-20020a5d6786000000b002153cb5b16cmr9190534wru.6.1655289406857;
        Wed, 15 Jun 2022 03:36:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i27-20020a1c541b000000b0039c5ab7167dsm1947810wmb.48.2022.06.15.03.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:36:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/1] tests: add LIBCURL prerequisite to tests needing libcurl
Date:   Wed, 15 Jun 2022 12:36:32 +0200
Message-Id: <patch-1.1-353c384d2b1-20220615T103609Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-0.1-00000000000-20220615T103609Z-avarab@gmail.com>
References: <cover-0.1-00000000000-20220615T103609Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and use a LIBCURL prerequisite for tests added in
6dcbdc0d661 (remote: create fetch.credentialsInUrl config,
2022-06-06).

These tests would get as far as emitting a couple of the warnings we
were testing for, but would then die as we had no "git-remote-https"
program compiled.

It would be more consistent with other prerequisites (e.g. PERL for
NO_PERL) to name this "CURL", but since e9184b0789a (t5561: skip tests
if curl is not available, 2018-04-03) we've had that prerequisite
defined for checking of we have the curl(1) program.

The existing "CURL" prerequisite is only used in one place, and we
should probably name it "CURL_PROGRAM", then rename "LIBCURL" to
"CURL" as a follow-up, but for now (pre-v2.37.0) let's aim for the
most minimal fix possible.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-httpd.sh        | 2 +-
 t/t5516-fetch-push.sh | 4 ++--
 t/t5601-clone.sh      | 4 ++--
 t/test-lib.sh         | 1 +
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 782891908d7..1f6b9b08d1d 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -29,7 +29,7 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
-if test -n "$NO_CURL"
+if ! test_have_prereq LIBCURL
 then
 	skip_all='skipping test, git built without http support'
 	test_done
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dedca106a7a..c1220b2ed35 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1834,7 +1834,7 @@ test_expect_success 'refuse to push a hidden ref, and make sure do not pollute t
 	test_dir_is_empty testrepo/.git/objects/pack
 '
 
-test_expect_success 'fetch warns or fails when using username:password' '
+test_expect_success LIBCURL 'fetch warns or fails when using username:password' '
 	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
 	test_must_fail git -c fetch.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
 	! grep "$message" err &&
@@ -1853,7 +1853,7 @@ test_expect_success 'fetch warns or fails when using username:password' '
 '
 
 
-test_expect_success 'push warns or fails when using username:password' '
+test_expect_success LIBCURL 'push warns or fails when using username:password' '
 	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
 	test_must_fail git -c fetch.credentialsInUrl=allow push https://username:password@localhost 2>err &&
 	! grep "$message" err &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d2f046b4b92..eeed233362d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -71,7 +71,7 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
 
 '
 
-test_expect_success 'clone warns or fails when using username:password' '
+test_expect_success LIBCURL 'clone warns or fails when using username:password' '
 	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
 	test_must_fail git -c fetch.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
 	! grep "$message" err &&
@@ -89,7 +89,7 @@ test_expect_success 'clone warns or fails when using username:password' '
 	test_line_count = 1 warnings
 '
 
-test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
+test_expect_success LIBCURL 'clone does not detect username:password when it is https://username@domain:port/' '
 	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
 	! grep "uses plaintext credentials" err
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 736c6447ecf..02bc88c72b4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1572,6 +1572,7 @@ esac
 test_set_prereq REFFILES
 
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
+test -z "$NO_CURL" && test_set_prereq LIBCURL
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
-- 
2.36.1.1239.gfba91521d90

