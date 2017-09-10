Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2B8202A4
	for <e@80x24.org>; Sun, 10 Sep 2017 14:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbdIJOod (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 10:44:33 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35144 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbdIJOoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 10:44:32 -0400
Received: by mail-wr0-f178.google.com with SMTP id m18so10477650wrm.2
        for <git@vger.kernel.org>; Sun, 10 Sep 2017 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PKjjVKrBW0UqHI3pU5Ru37Ctozbm/owLTU1QjSlFvxQ=;
        b=Ic1EM4cKRU7w/kWuOokE4zii/rSoCgaPCyTlkRbgpqA9Zn5R1ZlEx0u3IojNq+3RAS
         as2cJYK8vBUHMy/wMB7fWxVRQ4bK63CUDFpzuWdFKvSFywxw0/SyqFGZBjh1NmdAyWcP
         RKybVt9swDfcmweuFx8FDiah3euXNFL0a2BEov6q8ayOFFjIR7bsebo1Mj8cZeGhgbEo
         V4nI7Zrdc0Jw8nC3DHdX2txsnZ30Tpbqfz+LjZv8gXYWiMGdnLmcaDnDLOT8pj6TxSWi
         oeMahgB1W7DJ7M2t4iAWuxZM9rAqX+R4H8L5ADF8baCs9GSdH8RbOmfHF+5CqsqNCxK3
         oRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PKjjVKrBW0UqHI3pU5Ru37Ctozbm/owLTU1QjSlFvxQ=;
        b=OxTrAtEJpl1NdzauSzXUDMRex4KLpA7BpiCC3XKWGLxecqpuf3SFVUI99oguY1I3ui
         ANcLR9lHv/52Ed/HVU35arOgSLgbzCLo8VzRYJv9xYNV82wwBCDMEGXs98sEcaP1Do6h
         FexkhTL5nlyvYY8nbYgCMGeC63UFOaH7oQ8o9iS1zcT4bIw/kAggpYSuPEndJhs3Zgs8
         ja2QYJAbphH/V4TC3s5K/5lGpFEmc9T++4+fEzBbpjaXq73O0bZp37yCBau8H+DD70E3
         B5iCkUHRCWGD8BoH6bRP35m2al+CFbV6WkHOjGI9tN0nTGjT21/DUaRjPZrKCKLyfqcg
         ByJQ==
X-Gm-Message-State: AHPjjUioaQwHmkR7vV2ng63FL8/myrD1n5n2QJhuAsZRsgimEOFxRhOq
        sPRgKHBfVpjOZvol
X-Google-Smtp-Source: ADKCNb7E7dpJ+ngr1j0ksrxmkRCLzngoPmmKPgyKF2lwzLynMHzxCg++7ZksZk51TwJsZUqh2+LDgg==
X-Received: by 10.223.182.10 with SMTP id f10mr3380950wre.38.1505054671473;
        Sun, 10 Sep 2017 07:44:31 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB7AFE.dip0.t-ipconnect.de. [93.219.122.254])
        by smtp.gmail.com with ESMTPSA id 4sm6961223wmg.20.2017.09.10.07.44.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 10 Sep 2017 07:44:30 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 0/2] travis-ci: dedicated scripts + skip duplicated builds
Date:   Sun, 10 Sep 2017 16:44:27 +0200
Message-Id: <20170910144429.47346-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

the patches were previously discussed here:
https://public-inbox.org/git/xmqqinifrrzh.fsf@gitster.mtv.corp.google.com/#t

Over there Junio posted the original patch to skip a build on Travis
CI. The patch became 2/2 in this series.

Cheers,
Lars

Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/65ab003ec9
Checkout: git fetch https://github.com/larsxschneider/git travisci/move-into-ci-v1 && git checkout 65ab003ec9

Lars Schneider (2):
  travis-ci: move Travis CI code into dedicated scripts
  travis-ci: skip a branch build if equal tag is present

 .travis.yml                | 88 +++++-----------------------------------------
 ci/install-dependencies.sh | 43 ++++++++++++++++++++++
 ci/lib-travisci.sh         | 28 +++++++++++++++
 ci/print-test-failures.sh  | 18 ++++++++++
 ci/run-build.sh            |  8 +++++
 ci/run-linux32-docker.sh   | 23 ++++++++++++
 ci/run-static-analysis.sh  |  8 +++++
 ci/run-tests.sh            | 10 ++++++
 ci/run-windows-build.sh    |  2 ++
 ci/test-documentation.sh   |  4 ++-
 10 files changed, 151 insertions(+), 81 deletions(-)
 create mode 100755 ci/install-dependencies.sh
 create mode 100755 ci/lib-travisci.sh
 create mode 100755 ci/print-test-failures.sh
 create mode 100755 ci/run-build.sh
 create mode 100755 ci/run-linux32-docker.sh
 create mode 100755 ci/run-static-analysis.sh
 create mode 100755 ci/run-tests.sh


base-commit: 3ec7d702a89c647ddf42a59bc3539361367de9d5
--
2.14.1

