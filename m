Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0DBC636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4A4613DA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhGOX3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGOX3E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E8C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:09 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id x18-20020ad440d20000b02902e121b2b364so5309031qvp.12
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=FF3bi23Q2+V9IBRONphTpqZKGNw0CxdDx1xBudQNTow=;
        b=glHZZvNnvHs3Ywru1HFPmZXzStoQvej7oW+G1NdfT6X7qYfG68uuxZwsQRrbKaDB+I
         M64266ilg6qkmbxqiaiZkE36EC3bATeCZ74XpWoKacYJfMdFckVYdam5vYSG9vzZA+g8
         bmCIBndyl1MzXiz6MT1V2R/8RVjJof1/nr84rjRmieL/LCNry6EpgPZPrcqDYX/p/FNd
         j2KidgD/W75szNnSeQn+gAI6XxJdBUiph9PBSX0HRejT2f+PMbXAcWq2HGt0u34cjwe5
         hgveMk/AORGUxRcq1qbmQlRwSuFr472/YeyzFgy36+4Y34QghgienmaINsttc2cIUvvh
         Y/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=FF3bi23Q2+V9IBRONphTpqZKGNw0CxdDx1xBudQNTow=;
        b=haDiq/awZKRcjgNASHsR+wKCoOlz9k6kWIniexA7eTR1nxT1V3L9Dn5XeVB7c4dA4E
         a6YJS++/xKNxP3e4Z7XuLZVS0DClhIK0JSWdyhZvh8aNJ/tZRgyUEKjIzsgE5k79MQ7B
         g2W6XuPKEYYGABl8YcyT0XeEWCr4w+ydAjNAHst1m92A186RQP7x2vDkS4NJcj5ihsyA
         6n2spAgmZmxjheGQEkt9VovThfyvPmyhoXletnj+WhMuAcftvYm3LO945oC+evhVG3Xf
         jNl2tCmcGvAHBFfqN+9SsqRtvGD2dB6yWh7IsiSeYhQavzbxulSiH6SI6m8/vCXPUAgt
         YuOg==
X-Gm-Message-State: AOAM532RPn08yj0F1AiRAYa3VqRuliu3Je8Bhhl1hJVCQfOVr3AebBIZ
        xGd0HyhxFWbcZt/48JpV0E9wt3src88Ldoef8/s+zOfU2817vD1zFyJpSpbyb65e03OI2tNSXwx
        5mMO2vDSGKQMwqiM2zbtNZ2rri+5NVDRUClnrvv/o6si7QxkzHPAdRC5hfHb6x7gi1NkYF8MY5A
        ==
X-Google-Smtp-Source: ABdhPJwzcVnTNFRITuc4Kz/R/EzHqyzKFQql8n5UuANc3vwihRco9MnLvUjNEYJYpAVh4boOhbJE9+3VaUfgUrOzD3Q=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:ee2a:: with SMTP id
 l10mr7161520qvs.22.1626391567922; Thu, 15 Jul 2021 16:26:07 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:25:54 -0700
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
Message-Id: <20210715232603.3415111-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 0/9] config-based hooks restarted
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The work formerly found at
https://lore.kernel.org/git/20210527000856.695702-1-emilyshaffer@google.com
has been rebased on top of
https://lore.kernel.org/git/cover-00.27-0000000000-20210617T101216Z-avarab@=
gmail.com
(ab/config-based-hooks-base).

Some features have been dropped from v9 of the larger config-based-hooks
series, and many patches have been replaced by =C3=86var's new base.

This series no longer introduces the 'hook.runHooksDir' config - I think
it is OK to introduce that later and quibble about it in isolation from
the rest of this work.

I also would encourage folks interested in reviewing this to not spend
too much time looking through it without first leaving a review on
=C3=86var's series which this is based on; this series won't go anywhere
without that one. :) (And yes, I owe a review on the more recent version
of that series, too.)

Note: I am worried that somewhere around patch 6 a flaky test may have
been added - I saw flaky failures on the osx-clang and linux-musl tests
when I ran CI on GitHub. I *think* this was due to missing a field when
initializing 'struct hook' for addition to the hook linked list, and I
*think* I have fixed that, but if something jumps out to anyone in the
code or in the test, I'd really appreciate the hint. A passing CI run
for the tip of this series is at
https://github.com/nasamuffin/git/actions/runs/1035559898.

 - Emily

Emily Shaffer (9):
  hook: run a list of hooks instead
  hook: allow parallel hook execution
  hook: introduce "git hook list"
  hook: treat hookdir hook specially
  hook: allow running non-native hooks
  hook: include hooks from the config
  hook: allow out-of-repo 'git hook' invocations
  hook: teach 'hookcmd' config to alias hook scripts
  hook: implement hookcmd.<name>.skip

 Documentation/config/hook.txt |  22 +++
 Documentation/git-hook.txt    |  97 ++++++++++++-
 builtin/am.c                  |  12 +-
 builtin/checkout.c            |   3 +-
 builtin/clone.c               |   3 +-
 builtin/gc.c                  |   3 +-
 builtin/hook.c                |  58 +++++++-
 builtin/merge.c               |   3 +-
 builtin/rebase.c              |   3 +-
 builtin/receive-pack.c        |  14 +-
 builtin/worktree.c            |   3 +-
 commit.c                      |   4 +-
 git.c                         |   2 +-
 hook.c                        | 251 +++++++++++++++++++++++++++++++---
 hook.h                        |  44 ++++--
 read-cache.c                  |   3 +-
 refs.c                        |   3 +-
 reset.c                       |   4 +-
 sequencer.c                   |   7 +-
 t/t1360-config-based-hooks.sh | 227 ++++++++++++++++++++++++++++++
 transport.c                   |   4 +-
 21 files changed, 711 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/config/hook.txt
 create mode 100755 t/t1360-config-based-hooks.sh

--=20
2.32.0.402.g57bb445576-goog

