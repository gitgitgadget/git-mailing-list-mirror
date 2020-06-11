Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48D9C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951AB207ED
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDQgr0vU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgFKRmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgFKRmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB2C03E96F
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:02 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w9so5204249qtv.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ucl3goLOKHD7/rXn2cRvDDxp3pkyLPtfovIPwKVdCs=;
        b=qDQgr0vUt1/K9nrWXuvOTrsZuR0GYhQNpY+MSaPL1mgWEujySi6rm9xD8wzOQ7x27j
         d3qM/WRGY7IyBIdd+/+q8/eUjMsQy8H2KvQiFAtLgIVgf69THY/r7pkN5JjDVe9HY72f
         uyXpoReugNX4m5zlfK9/IVk+/XlZPKllJBi1a+RMu137R2khmw/9EkNMN+W9pV5gNQuG
         UjWlNelaatXvYYn2AWJvQem7ti5xbgd2aIzROOAnGOY8Qa0yKp4cDp1Yje+t8+KSXgsB
         oAwanMWW2Aqvd5Su8N9HFkHcWmXRETSX2rKM1rNxoEK4zWYBF5pNLriQgU+z0gHDaoJd
         0ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ucl3goLOKHD7/rXn2cRvDDxp3pkyLPtfovIPwKVdCs=;
        b=fsEYEgmU+tDNRcAoZs4lvVds1tedPwRbVmH6xTSaRJl12HMXfdn2VYqf4yUdKT8r0G
         CD1i0PVRiPvgcHO9B8CnQ1PLG0mVi7Le0bK+6yJKuv/KfiHI5exug5GxuBbzMSy5QC+9
         /aHwENLvSd50VApbqDRdB4HUCMKQ0Lro5V8DUcfHVKvpAH+hvQqDABvBMRRwa0gVk2hO
         RzvnUU0E/L2GzkC4aWZqtiv0Q4DMGRDmUhQIhHZFt0ffIAIh+70LayzQqRQHuptvkQ4e
         0CKS53NSc2IH2FK46lBrD0jq+9JE2qpmPk0H+6au/RYrtDsdQWV1kKJ0bEH7g5m1klXk
         sMHw==
X-Gm-Message-State: AOAM531tBn46/pJhRiwa9R8+7W5RZ9Sw+ZNYIujLYuKAVnlGDb17Zkif
        M/Dijsh+qvd1g7TwgvonhI0n0rhf40Q=
X-Google-Smtp-Source: ABdhPJzOOsn0dI1G603ICzyuun7ZhKNa8MGLZB3kzOMbWx+OTLfSwhps4fPjMbRp6DgLoWV8U3vtKQ==
X-Received: by 2002:ac8:6bc1:: with SMTP id b1mr9745332qtt.65.1591897320642;
        Thu, 11 Jun 2020 10:42:00 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f9sm3050703qtk.68.2020.06.11.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:41:59 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] t: replace incorrect test_must_fail usage (part 5)
Date:   Thu, 11 Jun 2020 13:41:46 -0400
Message-Id: <cover.1591897173.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1588162842.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Sorry for taking so long with the reroll. I've taken Peff's suggestion
and hopefully this approach is a lot more understandable. Unfortunately,
we introduce a few evals in test_submodule_switch_common() in the
process but I think that the end result looks pretty clean.


The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the fifth part. It focuses on lib-submodule-update.sh and tests
that make use of it.

The first part can be found here[2]. The second part can be found
here[3]. The third part can be found here[4]. The fourth part can be
found here[5].

Changes since v1.2:

* In "lib-submodule-update: pass OVERWRITING_FAIL", use if-then return
  to reduce the amount of code churn

Changes since v2:

* Replace the OVERWRITING_FAIL approach with callback functions as
  suggested by Peff[6]

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/
[4]: https://lore.kernel.org/git/cover.1585209554.git.liu.denton@gmail.com/
[5]: https://lore.kernel.org/git/cover.1587372771.git.liu.denton@gmail.com/
[6]: https://lore.kernel.org/git/20200521182928.GA1308647@coredump.intra.peff.net/

Denton Liu (4):
  lib-submodule-update: add space after function name
  lib-submodule-update: consolidate --recurse-submodules
  lib-submodule-update: prepend "git" to $command
  lib-submodule-update: use callbacks in test_submodule_switch_common()

 t/lib-submodule-update.sh        | 115 +++++++++++++++++++++++--------
 t/t1013-read-tree-submodule.sh   |   4 +-
 t/t2013-checkout-submodule.sh    |   4 +-
 t/t3426-rebase-submodule.sh      |  10 ++-
 t/t3512-cherry-pick-submodule.sh |   2 +-
 t/t3513-revert-submodule.sh      |  10 +--
 t/t3906-stash-submodule.sh       |  10 +--
 t/t4137-apply-submodule.sh       |  12 ++--
 t/t4255-am-submodule.sh          |  12 ++--
 t/t5572-pull-submodule.sh        |  28 ++------
 t/t6041-bisect-submodule.sh      |  10 +--
 t/t7112-reset-submodule.sh       |   6 +-
 t/t7613-merge-submodule.sh       |   8 +--
 13 files changed, 132 insertions(+), 99 deletions(-)

Range-diff against v2:
1:  ba2f642e0f = 1:  ba2f642e0f lib-submodule-update: add space after function name
2:  16d0a3eb9a = 2:  16d0a3eb9a lib-submodule-update: consolidate --recurse-submodules
3:  578bab6f1a ! 3:  09446be5b9 lib-submodule-update: prepend "git" to $command
    @@ t/lib-submodule-update.sh: test_submodule_content () {
      
     -# Internal function; use test_submodule_switch() or
     -# test_submodule_forced_switch() instead.
    -+# Internal function; use test_submodule_switch_func(), test_submodule_switch_func(),
    ++# Internal function; use test_submodule_switch_func(), test_submodule_switch(),
     +# or test_submodule_forced_switch() instead.
      test_submodule_switch_common () {
      	command="$1"
4:  48598e3f98 < -:  ---------- lib-submodule-update: pass OVERWRITING_FAIL
-:  ---------- > 4:  74e6086da4 lib-submodule-update: use callbacks in test_submodule_switch_common()
-- 
2.27.0.132.g321788e831

