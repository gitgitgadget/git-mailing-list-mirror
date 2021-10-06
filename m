Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458C5C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2995561181
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhJFKEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbhJFKE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80705C061762
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:02:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so7184852wrb.0
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E30+B515R7CZSWLL+Weo8b3THBOo1CNPwk7l0wuIGSk=;
        b=SB6r6N/2qii03KrOwlutASx7RWNQKnwqogzQsABgS6ewJWwhp2omvkzKvaV5QHE5lW
         u8FzRCCAhPFtxd6hatqFxtaVeEg8dkSMarMwgqpCXZNrqxosgPKpwLrsAM/mSZD/3iZZ
         QjFkxuOJmlZ9K7MT6b/u/uCD1CW2+gr8Gs3FAoVrie6oftZGF38uUogneR5P2YghkYzY
         P6p1lp4EImCfS5+OoYoPCJpotSg9yUIea/ZnLAfMYNRJU5wR39ymFD3dwe+uPW5AiheM
         53Ph1CDMc2VcioqcUFrAchnUQcEN10NxRx5HasZVZ9NQ3nu5Qdxzsf40+HoiCqOVAwPM
         HQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E30+B515R7CZSWLL+Weo8b3THBOo1CNPwk7l0wuIGSk=;
        b=yILdQWp6ImUbTgKtJ+qvUHb+T/8JbOjhepCO13IbPwemDFAflxUJHlpBmTWAq1arRg
         xjg0tXHBatJuZkX1agPsw9Ivnfa1z0EhYslaIoJlnZNQdJTtWYFDnb0cc1Xai7TO+ZDe
         eH+ebTxjUhxEj2aU7ysRxlZ29NmeWaQUXiifkBSERjSe40F7irarzmJoPK6xkhtqluWQ
         eD2CekaZS4OW7z86T6BQloFffIit2Flf9f6zkIpF68d7nA0V8mBZ6S4xC7fH7wTzQltD
         Zwa6y+vF2EpILD8q/wGQtRuNCdNpryUyVlgmvN5uJX8tMOoUZ/4PFMlU0QpNHEkWxFBW
         r+iA==
X-Gm-Message-State: AOAM533KFaOQKVQQTZnKvbtbw1FIvdJAz4JxIK5yo06bsYvB8snU1IHF
        rIZB4uSq7dpuwK7hGzoxxt1paax9rhbjtA==
X-Google-Smtp-Source: ABdhPJxlWhVSqOIy4iMbbIfdUsfriVdT5qkkf/0vaLRcirxfuvvGYcxQZJeFu8H2BGL6SjAMFO1d8Q==
X-Received: by 2002:adf:8b59:: with SMTP id v25mr28296375wra.386.1633514548838;
        Wed, 06 Oct 2021 03:02:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h18sm5515279wmq.23.2021.10.06.03.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:02:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/7] leak tests: fix "test-tool" & other small leaks
Date:   Wed,  6 Oct 2021 12:02:18 +0200
Message-Id: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like my just-submitted series to mark existing tests as passing[1]
under the test mode added in ab/sanitize-leak-ci, this marks more
tests as passing, but here we need to fix some small memory
leaks. This goes on top of ab/sanitize-leak-ci.

Like [1] I merged each of these with "seen" and tested them with
GIT_TEST_PASSING_SANITIZE_LEAK=true, so they should hopefully not be a
hassle while cooking. This doesn't inter-depend on any other topic I
have except ab/sanitize-leak-ci.

But with the outstanding topics I've got in this area (+ [2] + [3] +
[4]) and Elijah's en/removing-untracked-fixes these topics in
combination will get us to a spot where we can start fixing the big blocking memory leaks in the test suite.

I.e. most tests fail because "git log" and "git checkout" leak when
doing almost anything. I've got patches on top of this which fix both
of those for 80-90% of cases. After that most failing tests will have
failures because of things specific to those tests, not just because
their setup code dies as they use "git checkout" or "git log" to set
something up.

1. https://lore.kernel.org/git/cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com
3. https://lore.kernel.org/git/cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com/
4. https://lore.kernel.org/git/cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com/#t

Ævar Arnfjörð Bjarmason (7):
  tests: fix a memory leak in test-prio-queue.c
  tests: fix a memory leak in test-parse-options.c
  tests: fix a memory leak in test-oidtree.c
  tests: fix test-oid-array leak, test in SANITIZE=leak
  ls-files: fix a trivial dir_clear() leak
  ls-files: add missing string_list_clear()
  merge: add missing strbuf_release()

 builtin/ls-files.c                 | 14 ++++++--------
 builtin/merge.c                    |  2 ++
 t/helper/test-oid-array.c          |  4 ++++
 t/helper/test-oidtree.c            |  3 +++
 t/helper/test-parse-options.c      |  7 ++++++-
 t/helper/test-prio-queue.c         |  2 ++
 t/t0009-prio-queue.sh              |  2 ++
 t/t0040-parse-options.sh           |  1 +
 t/t0064-oid-array.sh               |  2 ++
 t/t0069-oidtree.sh                 |  1 +
 t/t3001-ls-files-others-exclude.sh |  5 +++--
 t/t3005-ls-files-relative.sh       |  1 +
 t/t3020-ls-files-error-unmatch.sh  |  2 ++
 t/t3700-add.sh                     |  1 +
 t/t7104-reset-hard.sh              |  1 +
 t/t7604-merge-custom-message.sh    |  1 +
 16 files changed, 38 insertions(+), 11 deletions(-)

-- 
2.33.0.1441.gbbcdb4c3c66

