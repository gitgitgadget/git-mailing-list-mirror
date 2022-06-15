Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A983CCA47B
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbiFOKoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348542AbiFOKoU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:44:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2438650463
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:44:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so911114wmq.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdqnNJqB0zP8S057Z+i88XufMN+qmGte4BPFZyZW+1s=;
        b=QwI8vu3nRTgZ1jdLFU24kShoEKIv7o0rgRYPgbzX5T7nHXO7Pxks7ztHAbCvOCh6l7
         5xuUwnCiXAQaoYnC5rYYfldY3wzyt1OXzfVLNkgGyq/j0jeo+lVTZtwPHmdKfKcYHfHM
         aUsWsnAR7BqB+22cj2L8iajuYgT3SWEeXGd3nlib6AP6x8O52X3w+6g5f3ppcV6SToIr
         imbQkGELY5E/dT46W5kNc0aYl5gL+KBsu+3XnvO/ogxVcLaLRT+sVQFhq4QVWkV3n+JV
         lzcMSsiq7bl78TyfsOmT1IW4vIgexbKCq+VLwXKbe1DNLQqYcXKUetrWK1giVvKIISg3
         x07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdqnNJqB0zP8S057Z+i88XufMN+qmGte4BPFZyZW+1s=;
        b=OvOPuXIeLIlnl8CfVRzAsQkqc/1QUKHectNEwKFoy1RV5a3poFJAiinESOA4s7xgoS
         +zPBwaT0dphNN/FlVsOeoDKokmx8HUW4dI1OV6rbqKY3fzuTxOyvyoi6/JJZEiDAdk+p
         rgouiM7VWWcU2gO+fVghvIHndwZX2VEN56NwuCSoQy56O6rRzquhFX1jU+C7wz4ujsCp
         +mmtnXKfvdLNqGYOYOkdXQvqtVNG0mTaLjbqxDE10dvJ+kgFKDyyHzTulMWlR3q/AO7K
         ngLkIzoXLsITHtbAbAgoecg6zsh5rtPQBuFnXcHoI1QthjGBle7Axa2WflQVuMwwsPKQ
         LPdw==
X-Gm-Message-State: AOAM531yfb+pmTJARDRpYoFHX3hWStc9u55P5/Ln/m28GdS6Q4e2HheQ
        gT4jU5o6L49QWeM75f2mwEeRKn/RFI7GUQ==
X-Google-Smtp-Source: ABdhPJw14yynlNZJO9UfST/ETFt6mmVaGc8/pH8WT4d1BdC/P4Hq+fsyDEUEdTX7eSjeqKkBfOAMoQ==
X-Received: by 2002:a05:600c:1d19:b0:39c:4aee:fe3a with SMTP id l25-20020a05600c1d1900b0039c4aeefe3amr9202084wms.89.1655289857157;
        Wed, 15 Jun 2022 03:44:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q1-20020adff501000000b002117ef160fbsm14487620wro.21.2022.06.15.03.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:44:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] For v2.37.0: rename fetch.credentialsInUrl to transfer.credentialsInUrl
Date:   Wed, 15 Jun 2022 12:44:10 +0200
Message-Id: <cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The $subject is a case where nothing is broken except potential user
expectations, but as argued in 2/2 I think we really should rename
this before we kick it out the door.

Having a "fetch" configuration configure "git push" is really
confusing, and once we need to support it backing out of it would be a
hassle.

Then 1/2 clarifies how it really works, and what it's aimed to do, and
notes the major caveat that the check doesn't cover "pushurl"
configuration, which in some setups is the only place you'll put
passwords in URLs. I think it likewise makes sense to have that in
v2.37.0 so we won't lull users into a false sense of security.

This is a relatively large change for an "rc", but the only code
changes are s/fetch\.credentialsInUrl/transfer.credentialsInUrl/g, the
rest is all docs.

There's a trivial conflict with my just-submitted
https://lore.kernel.org/git/cover-0.1-00000000000-20220615T103609Z-avarab@gmail.com:
The relevant "test_expect_success" line needs a "LIBCURL" prerequisite
added in the merge conflict.

Ævar Arnfjörð Bjarmason (2):
  fetch doc: note "pushurl" caveat about "credentialsInUrl", elaborate
  transfer doc: move fetch.credentialsInUrl to "transfer" config
    namespace

 Documentation/RelNotes/2.37.0.txt |  6 +++--
 Documentation/config/fetch.txt    | 14 ------------
 Documentation/config/transfer.txt | 38 +++++++++++++++++++++++++++++++
 remote.c                          |  4 ++--
 t/t5516-fetch-push.sh             | 14 ++++++------
 t/t5601-clone.sh                  | 10 ++++----
 6 files changed, 56 insertions(+), 30 deletions(-)

-- 
2.36.1.1239.gfba91521d90

