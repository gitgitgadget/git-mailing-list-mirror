Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B020C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 15:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiITPuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiITPt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 11:49:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20F2CE2C
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:49:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y136so3155026pfb.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zp2io+rmxGacBOx8sdAjuYK36YCmtDh3UwEkjc8vEbw=;
        b=VjYjVLfbPBR6Ik5/2V2d/3C2IhoRc7qonz1mDV4ztvssOcVWb6fh/S1Ib4dGjB1/TT
         DsuuZBR+k60Tbkjvi/3x0LZ3I/inPmu4VsGDi9Z7W1AR9C42y1eBLrdN2faBARRUlcaT
         puu68RIAcggHtIlz+ptNsWYKGNyLQXb9YF6TUFSqFe0NfoKaiXDREZAXRDkwk1vU1LbZ
         9dUHoWhBTK2+nIzobsuGDV0N9sER6R7sNjB5jc3yE2StNLoWl/9zfaqdvGDWt4lKztrz
         +JGR/IPtHZWyK59+UOXboXWS/0gGZbcVYfnakD6R29jgniJ15m0EIfXBCqaM95jfKPrq
         2iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zp2io+rmxGacBOx8sdAjuYK36YCmtDh3UwEkjc8vEbw=;
        b=PTX5GWI6XYDTyAvl/9t/YkcDCMuRZZcjsKKrSiOugI2K/bUbT+a3I1CW2C97T1Tvmw
         gSi7iVi+peuG1yrd+2PAyBll9B4gchrcR/lLWJ2x5o0S8RmzRr2Fl7DwuL2hDsHrPNLn
         MxfKyWg3hZUrI2h32YDyEklYq0cxZ3vVNuhc2+DZ/SThoLn5SSTNfib9efVcJW6ngZsc
         1rlNekGQ1LWREtHE5g3NRmtWqGTCta0ZHp817Hj6ezEOhWxH/muWrSQ4o//nkgakK9Jq
         alaAj2BsIu4QjsoQcUVGHuDBT7w4IRkWq+M5f2mNA8JfsfMUTpPm/mtsI9xMYUo490lq
         NRYQ==
X-Gm-Message-State: ACrzQf02HMWleu2NHD421yr1mD/RbK0P3TTm9ea1akxfxuJ/EU/AxwM3
        rAjK7KufStzlmrZ24h3ZcNuH0QFyPM4=
X-Google-Smtp-Source: AMsMyM6y+eKmB4wCgbr0pUC/IC+y8Vr9yL6ZTvCNBvn+ns8QcgspieJt2kwpF2nH7hIhtqLGm+kwBw==
X-Received: by 2002:a05:6a00:3:b0:53e:5edd:116a with SMTP id h3-20020a056a00000300b0053e5edd116amr24368721pfk.7.1663688996178;
        Tue, 20 Sep 2022 08:49:56 -0700 (PDT)
Received: from localhost.localdomain ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id 67-20020a621946000000b005379c1368e4sm26013pfz.179.2022.09.20.08.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:49:54 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 0/4] allow grep -E, and remove egrep
Date:   Tue, 20 Sep 2022 22:49:12 +0700
Message-Id: <cover.1663688697.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite our CodingGuidelines dictates that grep -E and or grep \{m,n\}
are forbidden. Our code bases uses them all over place.

In addiion, GNU grep 3.8 started to spit warning about the continuation
of deprecation process for egrep and fgrep.

This series aim to allow "grep -E" and replace {e,f}grep usage with
"grep -{E,F}"

Đoàn Trần Công Danh (4):
  CodingGuidelines: allow grep -E
  t: remove \{m,n\} from BRE grep usage
  t: convert egrep usage to "grep -E"
  t: convert fgrep usage to "grep -F"

 Documentation/CodingGuidelines       |  2 --
 t/perf/run                           |  4 ++--
 t/t1304-default-acl.sh               |  4 ++--
 t/t3200-branch.sh                    |  6 ++++--
 t/t3305-notes-fanout.sh              |  2 +-
 t/t3404-rebase-interactive.sh        |  6 +++---
 t/t3700-add.sh                       |  2 +-
 t/t3702-add-edit.sh                  |  2 +-
 t/t4014-format-patch.sh              |  8 ++++----
 t/t5320-delta-islands.sh             |  2 +-
 t/t5550-http-fetch-dumb.sh           |  2 +-
 t/t5702-protocol-v2.sh               |  2 +-
 t/t7003-filter-branch.sh             |  4 ++--
 t/t7527-builtin-fsmonitor.sh         | 18 +++++++++---------
 t/t7701-repack-unpack-unreachable.sh |  4 ++--
 t/t9001-send-email.sh                |  8 ++++----
 t/t9133-git-svn-nested-git-repo.sh   |  6 +++---
 t/t9134-git-svn-ignore-paths.sh      |  8 ++++----
 t/t9140-git-svn-reset.sh             |  4 ++--
 t/t9147-git-svn-include-paths.sh     |  8 ++++----
 t/t9814-git-p4-rename.sh             |  2 +-
 t/t9815-git-p4-submit-fail.sh        |  4 ++--
 t/test-lib-functions.sh              |  2 +-
 23 files changed, 55 insertions(+), 55 deletions(-)

-- 
2.38.0.rc0

