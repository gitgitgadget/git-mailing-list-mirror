Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA315C19F29
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiG0XOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiG0XN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:13:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E294D4C6
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bn9so98780wrb.9
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+ydImvf6cfVwO1RsBPo7CKzgDBylTtd8okEswqW+BgI=;
        b=JgysCvpOaiUEjeyow4YHTbiZKUWqYALIKbi5EK6Udop/lBcEwYPj9AUZ49gj/5L/nl
         OwG4YbfiywPISH+NKM9ksVOTm0aBiOXA6XsoGy0pW+vdEjqMUXC+t8nmLQKCWN5Djqg6
         vG31qkecicikMG/GkeYWRlG0PL3TBneIgHJQEJHYKG/saNs0kQC7BIaOTaoGDSbmwWDh
         VfBfE9YFQo7ePXO2WSpI/nxnWZxz/HaVFWZDT5TBm+r1sM3TqUYIQMPAwIieTkhCyVXl
         5VfyKIFUToCmGUKqn5neRSJVcNoGZJVytooMCRoOYhHThHwgqrNkTC3jMPdWgAyo6Auv
         QuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+ydImvf6cfVwO1RsBPo7CKzgDBylTtd8okEswqW+BgI=;
        b=IJjBVmai12RA/81/LcfiH2/gNqOJ0h4jB3uKDXL5uVkKY9O8P7Ag/N/OJHiYziWLI8
         Ie9nQfagnkgMFwQfKkSY6gQlsSvfjhM1M8OFUaXPPyXyeWdSSg++xY2PW1lK64UlSrlQ
         3A9M43gzTx7I3KUhlkF8RCVApDzhtABJ1vMSZEF5yShxJtBkNVdXjrbbia/W+EBowbb3
         CDoYreD1fgsit6w92Q90poXy72o4LyGOnaBxcDL7M9RxnTHQCmiqNWy2G6VvNLO2yZNp
         IUBiYXe4VhdcCWOMRnBiazAmdWVQ6ynKWQGpwkrnCZJxZnFOjQSvIRca21GdWK/0nSNP
         DJfQ==
X-Gm-Message-State: AJIora/n9bRtVfnv4ODE2CpiiC3qXwyQwu6+xTznCgVy2ro281EbBctb
        4uPi3XIKU5sjQ5labhI+7fEr7XOgybNvcg==
X-Google-Smtp-Source: AGRyM1uLKSB95sdw7uHg8Ty5BrrZ2YaBTq3jl6Y9JUgiAlNiDJmU8xJQSVjdcFpUzw2tyt49CkBlhg==
X-Received: by 2002:a5d:47ab:0:b0:21d:b2b1:59b1 with SMTP id 11-20020a5d47ab000000b0021db2b159b1mr15148931wrb.99.1658963634425;
        Wed, 27 Jul 2022 16:13:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/15] t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
Date:   Thu, 28 Jul 2022 01:13:33 +0200
Message-Id: <patch-v3-05.15-80a36a47b37-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the documentation added in 956d2e4639b (tests: add a test mode
for SANITIZE=leak, run it in CI, 2021-09-23) for brevity.

The comment added in the same commit was also misleading: We skip
certain tests if SANITIZE=leak and GIT_TEST_PASSING_SANITIZE_LEAK=true,
not if we're compiled with SANITIZE=leak. Let's just remove the
comment, the control flow here is obvious enough that the code can
speak for itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      | 10 ++++------
 t/test-lib.sh |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/README b/t/README
index 4f9981cf5e3..7f409392537 100644
--- a/t/README
+++ b/t/README
@@ -366,12 +366,10 @@ excluded as so much relies on it, but this might change in the future.
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
-GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
-SANITIZE=leak will run only those tests that have whitelisted
-themselves as passing with no memory leaks. Tests can be whitelisted
-by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
-"test-lib.sh" itself at the top of the test script. This test mode is
-used by the "linux-leaks" CI target.
+GIT_TEST_PASSING_SANITIZE_LEAK=true skips those tests that haven't
+declared themselves as leak-free by setting
+"TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
+test mode is used by the "linux-leaks" CI target.
 
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 31213b5f95b..f8adb92f027 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1447,7 +1447,6 @@ then
 	test_done
 fi
 
-# skip non-whitelisted tests when compiled with SANITIZE=leak
 if test -n "$SANITIZE_LEAK"
 then
 	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
-- 
2.37.1.1127.g4ecf1c08f67

