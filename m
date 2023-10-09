Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B1CD613C
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 22:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378905AbjJIWVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 18:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378890AbjJIWVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 18:21:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C01A3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 15:21:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7aa161b2fso11827177b3.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696890096; x=1697494896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=px107Y762qXvT5MpaAD6ablRHp4svuXJoMLuEtx+BXg=;
        b=LwJ2ZqftZmx6UPcox3n7w+330x9nSgfX2VHJS/gsXtN/nJUAK53kH9JEGMRYl0Tf71
         Zg7BPbrGgp9NpaJHsU0m4eSrvX1pzFBZVzcuFAlEMugPmr1gq4EI/tDIocB8pr7SVTi6
         QBmGfLmw+QnstLctllFrOH4H20umMsk37ZhTutJ4G0jw9I9MlZjIJ09OcmI3XPTXZu2W
         70/9rUxIwH6UsUV4MJlH7Ee6RNz8e+w5ajLyLIdSiP6bDd9MQQWDyomFFm6sNm3MWHDD
         d+fAg3/NJhUV+Qr8poXHZXKdiuIIr2dNOyv7CpNq+O7R5g8W1P3mot5FxVyL+xqOSehb
         No+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696890096; x=1697494896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=px107Y762qXvT5MpaAD6ablRHp4svuXJoMLuEtx+BXg=;
        b=MrM8noRguMVtFigyMHFmoXbrXegeBJG3g/i9yG5xX6PKf/M9ZP6SGQPb53U4Dvyxz0
         sYTYb5GsMg5lQTsn3uGRa3hClNfKU45YXt+e6Ao/gjeyrazc7VE97ycIuuj4hxX2Y8Ma
         YVtJ/gifjWqV3BdRSquI97J5fMtEW6AWHEqNx91tuGbeQPpJMFm8/TL11ncedTbFLaAS
         c1+Lgl2VXYZS3HxtiJgaNGCqXhRu6XlZ2d6A/zIx2HVQQpqA7ahJ1xXrJmmiepvVaeBF
         0ywRX3Fieqrhe5kVFuSFsFX3To+AUwm0OszGkSqFPIkUL0JI5u2b3eJemTJcosodi6Dg
         bC5Q==
X-Gm-Message-State: AOJu0YxkMKD7JWox9Vca7aUuCryN5XZJUblK1E1EzhWTmVLjkafVXC5r
        1jKzu7YFkeCwNo2pKP3pzPxj2Q+jPgK7Lv4VOZjn+QqyGr7PEJ+wzh7LcXmjHZleMmgkCzii+DO
        FZ+8W1iYLq+cwM/WYNz8Rjusfxb9SyxG4JONJslRf1kdSXAA6AiGPweXQN3t1Vus=
X-Google-Smtp-Source: AGHT+IFA61Uo4RVhfgAKK4b4+dKXGBxW+1NrmbrqcNrBAzXYFTpgN6DToEEgf44iFlNP/llZDyxqhAdYRgqH4g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:bbb3:af9c:b456:cb2a])
 (user=steadmon job=sendgmr) by 2002:a25:3290:0:b0:d9a:5b63:a682 with SMTP id
 y138-20020a253290000000b00d9a5b63a682mr689yby.13.1696890096187; Mon, 09 Oct
 2023 15:21:36 -0700 (PDT)
Date:   Mon,  9 Oct 2023 15:21:22 -0700
In-Reply-To: <cover.1696889529.git.steadmon@google.com>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <aa1dfa4892030c2c82170a56f8d7a0a5dd97f103.1696889530.git.steadmon@google.com>
Subject: [PATCH v8 3/3] ci: run unit tests in CI
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, linusa@google.com, calvinwan@google.com,
        gitster@pobox.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Run unit tests in both Cirrus and GitHub CI. For sharded CI instances
(currently just Windows on GitHub), run only on the first shard. This is
OK while we have only a single unit test executable, but we may wish to
distribute tests more evenly when we add new unit tests in the future.

We may also want to add more status output in our unit test framework,
so that we can do similar post-processing as in
ci/lib.sh:handle_failed_tests().

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .cirrus.yml               | 2 +-
 ci/run-build-and-tests.sh | 2 ++
 ci/run-test-slice.sh      | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 4860bebd32..b6280692d2 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -19,4 +19,4 @@ freebsd_12_task:
   build_script:
     - su git -c gmake
   test_script:
-    - su git -c 'gmake test'
+    - su git -c 'gmake DEFAULT_UNIT_TEST_TARGET=unit-tests-prove test unit-tests'
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2528f25e31..7a1466b868 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -50,6 +50,8 @@ if test -n "$run_tests"
 then
 	group "Run tests" make test ||
 	handle_failed_tests
+	group "Run unit tests" \
+		make DEFAULT_UNIT_TEST_TARGET=unit-tests-prove unit-tests
 fi
 check_unignored_build_artifacts
 
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index a3c67956a8..ae8094382f 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -15,4 +15,9 @@ group "Run tests" make --quiet -C t T="$(cd t &&
 	tr '\n' ' ')" ||
 handle_failed_tests
 
+# We only have one unit test at the moment, so run it in the first slice
+if [ "$1" == "0" ] ; then
+	group "Run unit tests" make --quiet -C t unit-tests-prove
+fi
+
 check_unignored_build_artifacts
-- 
2.42.0.609.gbb76f46606-goog

