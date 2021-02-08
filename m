Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B925FC433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6996664E8F
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhBHT11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbhBHT1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:27:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD36C06178A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:26:27 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nm1so138681pjb.3
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzApgmmiZ3JaIAmZ3S4aK9nDBeH5eSiazpznxHF5DG4=;
        b=oJhW6b9S7U7cGiGaqS8dqvLLFH+zSPJ614tyd0/Tz7EnsQZO5JEFzyOouWpbcD/Bpz
         nFmsbwXMbByIqvnn0juJ35Zr6MLTH7H2GGyz0rH+Ius3RM+nRns8s6dXzryzXFrT26kG
         PwPbbEZoOuC6PnoEJXn08vM2DKXustW5LGJJ0W9qOcw+QEC5bOAGloGe9ploh8AaXyST
         HyOMF6UzdjwcZDxmSvWigzDMuGaN+FM6WGlWnfH4sCw30Or+Gbf86qPC5DWnJ+QYQjNf
         VN4ztxC3AVgiP6E+S0nACB5354PfWEFZmYXK/RSdFpo+Q94Da69l996yD6pcxPIPRWVl
         TfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzApgmmiZ3JaIAmZ3S4aK9nDBeH5eSiazpznxHF5DG4=;
        b=i5TqC74Cgs+kIvSGPlvNwDqpdf40HM/H/WNM8DJghhIcy9jrZOHWPbKHU7hXsjxyBb
         S6IYKkGoi6eu8oRwnBd7avAnBm/rQGvxreP3xlfsnwER/gVNyjW1R91sSxgyiKX6Rtb6
         yP9dERwwsNhqCcrXQPJX1JEPuNwnr6Rf+SOf+myff8ePBARdj+9zpDkjUuoi0n5gmzRJ
         Fueo35g+i3jNLKWiC0Osjyz0BuriehUZ/SB5nEdtNs2w+Ijvvwaw4okDR0sr10kkFopv
         vOEwpMxlKk+dhG0oKedAKjBUbquQDTofhLM2ljc3PQp1zYV1yONUmKh9VNC0luuGiUxR
         E/og==
X-Gm-Message-State: AOAM531Q5E3Q2ejOzZ17XpBYOiQGbtmKKwzbt91PRR4K5sKH/PG+LK+i
        KpYOyKJpp8tvZJLEUInMBNknFq/BNitQag==
X-Google-Smtp-Source: ABdhPJyK6Pgg2fQhV/s2EtE6dZbCQy27hVDyZLQChvbmMJ2KiUN55Q7pIzpBuUkWY1hnyX199aALWA==
X-Received: by 2002:a17:902:a383:b029:e0:10e6:6ed7 with SMTP id x3-20020a170902a383b02900e010e66ed7mr18118155pla.5.1612812387136;
        Mon, 08 Feb 2021 11:26:27 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:26:26 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 00/11][Outreachy] Improve the 'fixup [-C | -c]' in interactive rebase
Date:   Tue,  9 Feb 2021 00:55:18 +0530
Message-Id: <20210208192528.21399-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is build on the top of "cm/rebase-i" in the 'next' branch and
improves it. It fixup the source code of 'fixup [-C | -c]' command in the
sequencer, do some fixes in rebase -i, improves the 'fixup_-C' like commands
in lib-rebase.sh, update the test-script 't3437' and fixes a typo in the
documentation.

Changes from v1 :
* Splits the patch 'update test-script', to make it more easy to follow.
* Modification in few commit messages as suggested by Eric.


Charvi Mendiratta (11):
  sequencer: fixup the datatype of the 'flag' argument
  sequencer: rename a few functions
  rebase -i: clarify and fix 'fixup -c' rebase-todo help
  t/lib-rebase: change the implementation of commands with options
  t/t3437: fix indentation of the here-doc
  t/t3437: remove the dependency of 'expected-message' file from tests
  t/t3437: check author date of the fixed up commit
  t/t3437: simplify and document the test helpers
  t/t3437: cleanup the 'setup' test and use named commits in the tests
  t/t3437: fixup the test 'multiple fixup -c opens editor once'
  doc/rebase -i: fix typo in the documentation of 'fixup' command

 Documentation/git-rebase.txt    |   2 +-
 rebase-interactive.c            |   6 +-
 sequencer.c                     |  23 +++---
 t/lib-rebase.sh                 |   8 +-
 t/t3437-rebase-fixup-options.sh | 140 +++++++++++++++++---------------
 5 files changed, 94 insertions(+), 85 deletions(-)

--
2.29.0.rc1

