Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34CFD20802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753722AbdFVViX (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:38:23 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34833 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753319AbdFVViW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:38:22 -0400
Received: by mail-wr0-f170.google.com with SMTP id k67so40482417wrc.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gxc4uOV4C90cpxmq7G4BdglUdsW3chzYDffHR1zx/lU=;
        b=KyMfUMTGFMtZxagGvdX6ZONc7BpN6pXnmpWfUvdJwN44fc96uwBtQoxawx9PpRobT0
         BdKpOnF521oLo43FVa7ulkwrnPnhZWlVXHkOvnLCg/lByeJaTLeZG4cyZiYoSE7PTkRg
         Z07JMzX95fPGQwa+ZFPyoZKUVXg51TxN43l/O9hG86LhVR/6qfFzUGbrH7s/jPmfAtm0
         8opk3ObgO99OcIL1xHwZkdvioG+MhO2fOzMTSYeiCByIIQS/GuncNBR9C6bMl+XF9xm/
         qbpuOqITd8vL6U7bU1MC/cd45dOITwXHLTeXOZJ68otu06/WAlbvwXBMGmoZPb+2pV+q
         8PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gxc4uOV4C90cpxmq7G4BdglUdsW3chzYDffHR1zx/lU=;
        b=EaxnR/fjpD+VtfvMvDJcv0QqRl4B3P03afvbCGN0FBr3qgUwOTAo41JnWj+k1jBV5w
         E+9PjQNvcLDm0VSYiEvWqqmNAdvZfQzVkzC8gGQBnzjGyBjdlDuuP6lJS3nU8ixwVJCB
         u+hWuCa4Fkf2wgz0anfrcmbjHjyRPqjAikds3F9YYKSbnFv7hp0xDvNmIGlFZdMawhda
         /zdevlWLRfSZqxr5RKxZFQjqh+iSp+bEmP03xUCDS6MpxlWNF4mMZb8VEQZci66LdyqJ
         SmsZOFIGEobHltEnC8V8l21MwlpjDe38oCA1re+LGNuFh1OfgFpehEF+cI7yyfNTKZKS
         2PXQ==
X-Gm-Message-State: AKS2vOyALvW/VqrufSZd4zHWWGO49EqeZOG6ycIE2yN8qCKYR0Nc+DbL
        sKEPqETB/4eMzD8oYes=
X-Received: by 10.80.165.229 with SMTP id b34mr3866004edc.29.1498167500516;
        Thu, 22 Jun 2017 14:38:20 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w26sm1404966edw.28.2017.06.22.14.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 14:38:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] wildmatch refactoring
Date:   Thu, 22 Jun 2017 21:38:07 +0000
Message-Id: <20170622213810.14785-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch here should be applied, but 2 & 3 trail along as RFCs
to show where this is going.

The RFC patches work, but I'm sure there'll be critiques of the
interface / other suggestions, so they're being sent as RFC so Junio
doesn't need to worry about picking them up / tracking them.

This is prep work for a local series of mine which compiles the
wildmatch pattern into JIT-ed PCRE v2 patterns. That may or may not
end up going anywhere, but as 2/3 notes just making these changes
makes it easier to optimize wildmatch() further down the road.

Ævar Arnfjörð Bjarmason (3):
  wildmatch: remove unused wildopts parameter
  wildmatch: add interface for precompiling wildmatch() patterns
  wildmatch: make use of the interface for precompiling wildmatch()
    patterns

 apply.c                   |  2 +-
 builtin/describe.c        |  4 ++--
 builtin/ls-remote.c       |  2 +-
 builtin/name-rev.c        |  6 +++++-
 builtin/reflog.c          |  2 +-
 builtin/replace.c         |  7 ++++---
 builtin/show-branch.c     |  2 +-
 config.c                  |  8 ++++++--
 diffcore-order.c          |  2 +-
 dir.c                     | 20 +++++++++++++++-----
 ref-filter.c              |  4 ++--
 refs.c                    |  7 ++++---
 revision.c                |  2 +-
 t/helper/test-wildmatch.c |  6 +++---
 wildmatch.c               | 23 +++++++++++++++++++++--
 wildmatch.h               | 13 +++++++++----
 16 files changed, 77 insertions(+), 33 deletions(-)

-- 
2.13.1.611.g7e3b11ae1

