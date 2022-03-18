Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C875C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiCRAfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCRAf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:35:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5BD231933
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d7so9679902wrb.7
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XN5nvOhXUsUFxJgs9jl31Bip/SW8C0Pcfa2RtlGjPzA=;
        b=gu6HvCRpYEdYB6+S5I2w0uCV3RGuzKKre9oPQX1CFTECtufEgDlweybhaE0ZZPd8it
         ryItFRXk9TgUvy2SWaJtP1rEJg+L4xTSA5IOJq4SShxS2+IOSOrydn1APDYEsYP6C0Eb
         k6zRH6tf5xPcy7KHj7YCF0c83f8mK4WiWf02fLGQz4+6e5NHpYZKsy1EbtcywnjgdzQY
         dRC+5UjDfEBGQyF6mjCX41eTVp2jIp7LgXLHfKDO7qccwr1jLJYzywa6cnFexiEmnbfT
         +pQqfVAmtJ0Vz9e+Gc7oOd0Qb+sYIp7TJnnQehVZsczgkwAM5oy37JIXEn/fxbiMn0fj
         jh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XN5nvOhXUsUFxJgs9jl31Bip/SW8C0Pcfa2RtlGjPzA=;
        b=gh2dsrpge/eXkBiSVfHVdYBLTBWrHFcENPAKaFcsr8JMbhyyqfKp7s7FN7qoJkT5CD
         5aHBUQCSVFu1Rq5tUWWHU+ZSaZIi7KqB3E6K+jSljvbQxmPYVPkvhh9gB11/F6zNe8re
         yC1z/R2wkN5LDmRey1yGXu5lmRRfaYbry54QwVkUnQRf0vLlBmU6Y6+f2HJM9oKKZqYa
         r3FvDTZs+gdJO7TL5XzYPXzJtNUgo3U0FVWoiJNIXBsjLVkSwrJtNFL+r56q0V7xCdjl
         hL5SN16TuG6N9BX9M/PNUUK1e+DZI4qI9PA877y1ZRzi+sVgX+KgNx/R6U5qzn0IGEIK
         dvUQ==
X-Gm-Message-State: AOAM533frPtjp8PyN2C9lhHTMlplyxh6mzIr8Dr5GXV4yAkwxr+fd4fU
        2dUnIFcTnzjAbhbNy9QfjCyrH0PpY3MqTw==
X-Google-Smtp-Source: ABdhPJyiDkKXo8LmROhqyCQrTKz/Z9lqoyBBNh0RlRwJ7Jh+sKThiA/VuP2dGLLwAAXrNGgKOsVF7g==
X-Received: by 2002:adf:e589:0:b0:203:e324:3485 with SMTP id l9-20020adfe589000000b00203e3243485mr6044423wrm.271.1647563649491;
        Thu, 17 Mar 2022 17:34:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b00203dde8d82bsm5096548wro.88.2022.03.17.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:34:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/7] test-lib-functions: a better "test_expect_failure"
Date:   Fri, 18 Mar 2022 01:33:55 +0100
Message-Id: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1436.g756b814e59f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As explained in detail in 1/7 there's several major shortcomings to
"test_expect_failure", this series adds a "test_expect_todo".

It allows us to assert exactly how something that fails .. fails (no
more conflating segfaults for "exit 1"), but also emits all the right
output & metadata about the test being "TODO" that
"test_expect_failure" does.

The rest of the series then expands on that to convert several more
tests, along with adding helpers like:

    todo_test_cmp want expect actual

Where the "want" is what we want once we'd mark the test as
"test_expect_success", but the "expect" is what we get right now with
the failing TODO test.

This series has a (rather trivial) textual conflict with
js/ci-github-workflow-markup in "seen".

Ævar Arnfjörð Bjarmason (7):
  test-lib: add a "test_expect_todo", similar to "test_expect_failure"
  test-lib-functions: add and use a "test_todo" helper
  tests: allow test_* in "test_must_fail_acceptable" for "test_todo"
  test-lib-functions: add and use a "todo_test_cmp" helper
  test-lib-functions: add and use a "todo_test_path" helper
  test-lib-functions: make test_todo support a --reset
  sparse tests: convert a TODO test to use "test_expect_todo"

 t/README                           |  20 +++-
 t/t0000-basic.sh                   |  48 +++++++-
 t/t1021-rerere-in-workdir.sh       |   9 +-
 t/t1060-object-corruption.sh       |   4 +-
 t/t1091-sparse-checkout-builtin.sh |  17 ++-
 t/t1309-early-config.sh            |  14 ++-
 t/t1410-reflog.sh                  |   4 +-
 t/t3600-rm.sh                      |  23 +++-
 t/t6403-merge-file.sh              |  32 +++++-
 t/t7814-grep-recurse-submodules.sh |  60 ++++++----
 t/t7815-grep-binary.sh             |   4 +-
 t/test-lib-functions.sh            | 172 ++++++++++++++++++++++++++++-
 t/test-lib.sh                      |  32 +++++-
 13 files changed, 379 insertions(+), 60 deletions(-)

-- 
2.35.1.1436.g756b814e59f

