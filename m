Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA732C28D13
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 14:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbiHYOge (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbiHYOgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 10:36:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D16593
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h24so24892775wrb.8
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fU/xzQCqw/Hw4pqVQ6vYzbQsxC26a7OF1RmKqLhlVGo=;
        b=cOpHcY8Ev9M8K9hiSxaMt6slkYeiepIDgSYAa/tztN073OhlhZI0/vPz2Mu/ep6t01
         lrFWv/wky4xqW5mVFyJQxZ1IiSNWq4f2Ixfq4NBVDJlp6goAYfapx3HAnhpihRwtM2FB
         2i90uK7wz9sPHUlJs9lMUydGly7Z1cDZAxN1gtTQ2Qt+jCey2YZq9Y9Z6Eya/4UUdIOq
         EHmGBKNUK431xGBASlysPsWImvLjq3LhCVuIWYdKluS4MKgJZ6gyMakH6AsVx1o6owWl
         W8TZYGpOMnpVaCON/Og83SSB9pOcTAqgnoiQXEEJRrDNMQHTuXAqd0TKVqyzu1I3WS6k
         zSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fU/xzQCqw/Hw4pqVQ6vYzbQsxC26a7OF1RmKqLhlVGo=;
        b=c+E1nWsEl+ZmIdRAKFsR/PkobzwGfA8OZlZgQl75/W2hfbcEXFAQfdih8UrA1K43FH
         AsaP4vevhUP/2nmnAe65A/PPkxtASKWoLAho+8LYfzGDMtXV246pGR1JuTFrS7YoJb9h
         liIl9fEz7jcXNGyO7x5zj5ZG0stf24vOSpvhdUQLZrGg1x5wnZHH2pU4KpKZUc4pmeZw
         8ub9qsmqkCvQlUUuYO8PSqwBzjGOh7kxPGEDInH6H5vWg3WgVD8SSZgT+DhFbG583W6Q
         5yz0Evo55FyIaUFeORzd/AriMWZTOVJYXUh851VJ30JBCBw+n97YrcBaUV68vLIayb39
         hQpg==
X-Gm-Message-State: ACgBeo3ik8LmtcogJxlc3onWkLeI5XarQ36iZSN8Hd9pGOmU4e0MI8sh
        zU4S65FbRzCx9tQ+5YTNOiFBz15a5Ec=
X-Google-Smtp-Source: AA6agR63hAzsEnz+U1jmkfj5DXbME2DjSWvo9gKPAqiRCpad3mEG+EoKYphEEsDyTVwo3UiYZrU44A==
X-Received: by 2002:a5d:595e:0:b0:225:3dd7:e376 with SMTP id e30-20020a5d595e000000b002253dd7e376mr2461516wri.223.1661438181382;
        Thu, 25 Aug 2022 07:36:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a056000181b00b0022549ac786asm14418027wrh.47.2022.08.25.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:36:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] cocci: make "incremental" possible + a ccache-like tool
Date:   Thu, 25 Aug 2022 16:36:12 +0200
Message-Id: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes the "coccicheck" rule incremental by only re-running
"spatch" for those file/rule combinations that changed.

The result is that e.g. running "make coccicheck" followed by a:

	make -W grep.c coccicheck

Will take around 2s instead of a *lot* longer. The 3/5 change has all
the details about this, and why it's safe.

Furthermore we'll properly handle re-building if any of the required
headers change (e.g. column.h).

I had a previous stab at trying to make "coccicheck" faster a while
ago in [1], but that was fatally flawed because it would break in
cases where grep.c e.g. dependen on a header that changed.

This series doesn't suffer from that issue, because we piggy-back on
the corresponding .depend/* files to extract dependency info. This
does mean that the incremental speed-ups depend on
COMPUTE_HEADER_DEPENDENCIES=yes (which is the case with "gcc" and
"clang" by default).

I've been running with this series locally for a while. I think it
should fully solve the lamentations about the coccicheck being too
slow (e.g. in [2]), particularly when paired with the new
"spatchcache" helper added in 5/5.

Even without that helper running "make coccicheck" e.g. after applying
a patch series now becomes viable, provided the patches don't modify
one of the "rebuild everything" files we have (such as cache.h and
git-compat-util.h).

1. https://lore.kernel.org/git/20210302205103.12230-1-avarab@gmail.com/
2. https://lore.kernel.org/git/xmqqh7249b8d.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (5):
  Makefile: add ability to TAB-complete cocci *.patch rules
  Makefile: have "coccicheck" re-run if flags change
  cocci: make "coccicheck" rule incremental
  cocci: make incremental compilation even faster
  spatchcache: add a ccache-alike for "spatch"

 .gitignore                                    |   1 +
 Makefile                                      | 114 +++++++--
 contrib/coccinelle/spatchcache                | 217 ++++++++++++++++++
 .../coccinelle/the_repository.pending.cocci   |   1 -
 shared.mak                                    |   4 +-
 5 files changed, 310 insertions(+), 27 deletions(-)
 create mode 100755 contrib/coccinelle/spatchcache

-- 
2.37.2.1279.g64dec4e13cf

