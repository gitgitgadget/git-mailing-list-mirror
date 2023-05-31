Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9133BC7EE2E
	for <git@archiver.kernel.org>; Wed, 31 May 2023 13:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbjEaNri (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbjEaNqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 09:46:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4161FF0
        for <git@vger.kernel.org>; Wed, 31 May 2023 06:43:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b021cddb74so29422595ad.0
        for <git@vger.kernel.org>; Wed, 31 May 2023 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685540573; x=1688132573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9Z25fK/1OPgxJOodhQBmZF4fa4PUPvsbqycdnshhCY=;
        b=AuTM+jFrZqA4tBdvRfp15UjVpioLO/+lLNJZkMDz1sXf+dsCuTuwe/xd1D5ns+qDU/
         5PXfkjlpQAEwMoTMJNLfdMTY+JFhEIQ8+EifLOTJQF3Hz7uW2tqyXazre/PJ41Wbdlt2
         EjQ0wObEgqKFVZaMFGh09aOQ+XYamkU2zXOCqPTfLFz6NZs6LCyeljKXyZXax+sM4tah
         FO1jSFFCDEDxSodygd9Wj+mfLYV3ir7nV21Jm7u21cXPcioqDBLczLtxMQkfofStJ+Bj
         F74y4af2PmFlH2iwMVghV7tJgrCE8eT8hstJ8duUrB4+us6tfViEEHVwVSnDE0HjGZGm
         a3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685540573; x=1688132573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9Z25fK/1OPgxJOodhQBmZF4fa4PUPvsbqycdnshhCY=;
        b=D0CK8cux3Yk6msGYCSXrFy5YvYoyYy8xc3nf3fCyqzly8+x7jt82kH2yCBQO7stZ4v
         21OVvssBCzmRyOpUjLIuScspowC+ERLU7DAUpfJ1Td+JnwFQE/6FAkCjFvZFty/FONWe
         37ZaWrjNHPYfcwpPZlncYZXF9nTHhDnvC1zygKERLDCFlXRwlyNXbEDh251awPt+rRJ7
         Al8fBGvpOQb2sMk+iILjUy9shOfTOWqoZBEDGOm5i7WbGV087oE8ErlNvN2vmR6Vcznd
         7uUTqcBP69my9oLiCXwXs2hJ52ZHmWSeHhztmAt+s12rsNjwctZCK2Fj1rsTSfNpk5bK
         gsQQ==
X-Gm-Message-State: AC+VfDwsvXHQ/9kA+G3bBmm9Z1vqZ5uMCGFs10tiWv4xM/eYLj5qFv42
        n6QrM93wQttXYYfiuyG8l4VUgoemhgp1aA==
X-Google-Smtp-Source: ACHHUZ5QB+F8yfGDqJMa+LIpwxYon2BMUGHZj5Wodu97loQpFt1ImbBEFvg9wmcWu/Lc774Rf8okNg==
X-Received: by 2002:a17:902:ba95:b0:1af:cabb:87b6 with SMTP id k21-20020a170902ba9500b001afcabb87b6mr4441294pls.19.1685540572881;
        Wed, 31 May 2023 06:42:52 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id jk6-20020a170903330600b001a9bcedd598sm1399111plb.11.2023.05.31.06.42.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2023 06:42:52 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arkadii Yakovets <ark@cho.red>, Arusekk <arek_koz@o2.pl>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Benjamin Jorand <benjamin.jorand@doctolib.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>, Emir SARI <emir_sari@icloud.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.41.0 round 1
Date:   Wed, 31 May 2023 21:42:44 +0800
Message-Id: <20230531134244.26455-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

In this release we have a new l10n language, Ukrainian, thanks Arkadii
for contribution. L10n for Traditional Chinese is still in draft mode
at [1] and not ready to be merged yet.  Maybe another update will be
sent tomorrow.

  [1] https://github.com/git-l10n/git-po/pull/712

Please pull the following l10n updates for Git 2.41.0.

The following changes since commit 9e49351c3060e1fa6e0d2de64505b7becf157f28:

  A few more topics after 2.41-rc1 (2023-05-20 05:35:57 +0900)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.41.0-1

for you to fetch changes up to 81a797fcdfaa867a2c26115234edc10902396b4f:

  Merge branch 'add-uk-initial-l10n' of github.com:arkid15r/git-ukrainian-l10n (2023-05-31 21:11:25 +0800)

----------------------------------------------------------------
l10n-2.41.0-1

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
 10 files changed, 24203 insertions(+), 2347 deletions(-)
 create mode 100644 po/uk.po

--
Jiang Xin
