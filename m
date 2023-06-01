Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1F5C77B73
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 00:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjFAAb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 20:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjFAAbz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 20:31:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA196124
        for <git@vger.kernel.org>; Wed, 31 May 2023 17:31:54 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5343c3daff0so130320a12.0
        for <git@vger.kernel.org>; Wed, 31 May 2023 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685579514; x=1688171514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRLj945sh2x4EXE3Y2yg6RMDKav2ztvvYdMoB9dT/ws=;
        b=NMyFywvy6lp4uYHWwSp7RKuKqo6bT6Lb7yHtkrNmRGDmLKevPeuNKwLWlkPcQj5a2i
         0CQqqGSkSuB6c43R1RjYOUMw/fqmnSE2lXzLaMcukhP7Wndo4tS1nHul3run819dqCt0
         0ypIJ3kQQRXfSQZOBWg//KWkaUKYRvfZw1evrcWwShmASd6kXYwTfkqwX8tll8Q339as
         SMgT7TY5E97HugZkvlynM1ahdXE5EV/aOV4Vk1Lq8RiYI30VpeMcsUgG0TY9pShQ9MGO
         IW7eccDW/EqIvpBTeV8Izj02cis91K8NnACAo5MQ4Y9pkuC72GI2F6VshvEEMHf3AmbI
         /ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685579514; x=1688171514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRLj945sh2x4EXE3Y2yg6RMDKav2ztvvYdMoB9dT/ws=;
        b=GnRi/1n/mdPucS3xuSTWs9Ck+WRNAX0WMw8bSzXHwEZEhITwviIoVab3fCimHU+GI2
         vBKQ3LIhZM6EME951K+mRt05sj3QorfEexLgPrp6oeQdYTcKD6Rd8jWoGl9ujZvBSlhP
         Z6V3NAr+vTkrJpDwa+I+CTF2qaoU39/hadEQMW3sc08MKVvbXB2RgthIno778KEYhoEA
         PL0T8heQDl45+g0GQlPsWW6iIjmObyXdAb//oLqHCuR4XbQpIX312m8z0WmSJDdg7bwg
         zkxpSt+EbyIN0ASwEayJP1OkzDybkVLe/+sOhVeUARn5+X8utJ3xD3voz8iBXXphL2rv
         uJaA==
X-Gm-Message-State: AC+VfDzHglFT+6CDw6jmkjWD6RVMNM3ay81KuzYl6WSLJF+Ap5H+osCX
        +TkuKIF16pLcaGpvs/IftXs=
X-Google-Smtp-Source: ACHHUZ6yLbcL7WpUjhKjWzTsSe2DL2ukWe8uvkNlWQoOTh/QxjDPRb+J8eQN4xhWsuTaQmA6KCCsxw==
X-Received: by 2002:a17:90b:4b0d:b0:253:9374:6976 with SMTP id lx13-20020a17090b4b0d00b0025393746976mr6019768pjb.32.1685579514241;
        Wed, 31 May 2023 17:31:54 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090abc8100b0024de5227d1fsm102630pjr.40.2023.05.31.17.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2023 17:31:53 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.41.0 round 2
Date:   Thu,  1 Jun 2023 08:31:51 +0800
Message-Id: <20230601003151.26771-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> In this release we have a new l10n language, Ukrainian, thanks Arkadii
> for contribution. L10n for Traditional Chinese is still in draft mode
> at [1] and not ready to be merged yet.  Maybe another update will be
> sent tomorrow.
> 
>   [1] https://github.com/git-l10n/git-po/pull/712
> 

Please pull the following l10n updates for Git 2.41.0.

The following changes since commit 9e49351c3060e1fa6e0d2de64505b7becf157f28:

  A few more topics after 2.41-rc1 (2023-05-20 05:35:57 +0900)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.41.0-2

for you to fetch changes up to f86de088f8c32377fbd681cc481e7128af83ce2f:

  l10n: zh_TW.po: Git 2.41.0 (2023-06-01 00:53:09 +0800)

----------------------------------------------------------------
l10n-2.41.0-2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5515t)

Arkadii Yakovets (3):
      l10n: uk: add initial translation
      l10n: uk: remove stale lines
      l10n: update uk localization

Bagas Sanjaya (1):
      l10n: po-id for 2.41 (round 1)

Benjamin Jorand (1):
      l10n: fr: fix translation of stash save help

Daniel Santos (1):
      l10n: TEAMS: Update pt_PT repo link

Emir SARI (1):
      l10n: tr: Update Turkish translations for 2.41.0

Jean-Noël Avila (2):
      l10n: fr.po v2.41.0 rnd1
      l10n: fr.po v2.41.0 rnd2

Jiang Xin (10):
      Merge tag 'v2.41.0-rc0'
      Merge branch 'master' of github.com:git/git
      Merge branch 'tl/zh_CN_2.41.0_rnd1' of github.com:dyrone/git
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'fr_2.41.0_rnd1' of github.com:jnavila/git
      Merge branch 'main' of github.com:alshopov/git-po
      Merge branch 'tr' of github.com:bitigchi/git-po
      Merge branch 'catalan' of github.com:Softcatala/git-po
      Merge branch 'l10n-de-2.41' of github.com:ralfth/git
      Merge branch 'add-uk-initial-l10n' of github.com:arkid15r/git-ukrainian-l10n

Jordi Mas (2):
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5515t0f0u)

Ralf Thielow (1):
      l10n: Update German translation

Teng Long (1):
      l10n: zh_CN: Git 2.41.0 round #1

Yi-Jyun Pan (1):
      l10n: zh_TW.po: Git 2.41.0

 po/TEAMS    |    12 +-
 po/bg.po    |   500 +-
 po/ca.po    |   893 +--
 po/de.po    |   882 +--
 po/fr.po    |   518 +-
 po/id.po    |   615 +-
 po/sv.po    |   481 +-
 po/tr.po    |   491 +-
 po/uk.po    | 21554 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/zh_CN.po |   604 +-
 po/zh_TW.po |  2841 ++++----
 11 files changed, 25784 insertions(+), 3607 deletions(-)
 create mode 100644 po/uk.po

--
Jiang Xin
