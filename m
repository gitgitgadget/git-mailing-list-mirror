Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED668C433FE
	for <git@archiver.kernel.org>; Sun,  2 Oct 2022 09:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJBJv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Oct 2022 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJBJv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2022 05:51:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90664BD35
        for <git@vger.kernel.org>; Sun,  2 Oct 2022 02:51:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso5131186pjb.0
        for <git@vger.kernel.org>; Sun, 02 Oct 2022 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fLv2VxVPvd4/W8W4HGMLXQBqWykGpcZWsevO4o6E6fs=;
        b=oQcmYiGnqfsgs8oQTghD9qfOk+WHut+MHLy8kHugEzc2R6yDg803z7zLWOugFinHp9
         xAplt2zZwpN20egdjzej+Ps7lsdS/UDUNKGFUisUpi38uk9GniRF4wR51XmXVKXVBZcg
         k6gTDq167RL0eKoD84DCuLxWdXX2iku3EAhVCOXPIV/0wg0t5PX3jjbunmx8CftSRnFv
         281n5YsF92ePBRTT8tzYio5QyMkq6tLWlqyH4u7Dxqd+bLvwS41pIO11/UVF9ouc9umn
         09/N7szPmmGTFyX4TRe6d0Hgo+nobVjotwhtixMPJkrOIE56qk5zVPmTTpNXzWwghgw8
         8hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fLv2VxVPvd4/W8W4HGMLXQBqWykGpcZWsevO4o6E6fs=;
        b=7LWJLQ+gQu3tjDxDadAjzyEGwlQLijd1ofddsldJW++aoNdbcqt+Ldah3qlVe9123I
         Q5iJRcRwSr3K+GclK8jAEruIDIh7j6NOVtYY70rkhjuJf/sIG5wozcF+IFWNkCWnzYvU
         bq6y4Ln2N3N9OXkiu67Jy6Wde1tbH+J3ZprBbGFXinpg8o4vi+7w8BuxQ2v2geKXxYqp
         PTZik87J86uDcpdHI7gZTVH++g54sbvGAlnjxzLZ7sdfzB9tmzXDqMgAnB2D7+DasG9S
         iMNZmUS4deFlK+zvlwHLCaiIZqMAHQavVvqgvoHngJggLHr738X8KLfunPJ96lpDij7A
         yqIQ==
X-Gm-Message-State: ACrzQf3NOEOPDnomNQwl/NVwT6uX9monlTnGT21ekcJyKxFtj4rIkvUp
        U7dOLY92OYCNbc9DwD+0ekk=
X-Google-Smtp-Source: AMsMyM6kYiVFcU6fY7x11/p3erAxS6mXipgMF6U7eEHRCfdijNXRjfBvmaCHRh9cS5qmLQonSsXzNw==
X-Received: by 2002:a17:903:2306:b0:177:eafd:36e9 with SMTP id d6-20020a170903230600b00177eafd36e9mr17026626plh.135.1664704316149;
        Sun, 02 Oct 2022 02:51:56 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b13-20020a1709027e0d00b00176c37f513dsm5036439plm.130.2022.10.02.02.51.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Oct 2022 02:51:55 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>, Emir SARI <emir_sari@icloud.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Hubert Bossot <hbossot@profideo.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.38.0 round 3
Date:   Sun,  2 Oct 2022 17:51:52 +0800
Message-Id: <20221002095152.24431-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.38.0.

The following changes since commit bcd6bc478adc4951d57ec597c44b12ee74bc88fb:

  Git 2.38-rc2 (2022-09-27 11:25:52 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.38.0-rnd3

for you to fetch changes up to dedb2883ce5670401ccd2a18e47d6dae2bc798ab:

  l10n: zh_TW.po: Git 2.38.0, round 3 (2022-10-01 19:10:41 +0800)

----------------------------------------------------------------
l10n-2.38.0-rnd3

----------------------------------------------------------------
Alex Henrie (2):
      l10n: fr: don't say that merge is "the default strategy"
      l10n: es: update translation

Alexander Shopov (3):
      l10n: bg.po: Updated Bulgarian translation (5482t)
      l10n: bg.po: Updated Bulgarian translation (5484t)
      l10n: bg.po: Updated Bulgarian translation (5484t)

Bagas Sanjaya (3):
      l10n: po-id for 2.38 (round 1)
      l10n: po-id for 2.38 (round 2)
      l10n: po-id for 2.38 (round 3)

Emir SARI (3):
      l10n: tr: Update translations for v2.38.0 round #1
      l10n: tr: v2.38.0 round 2
      l10n: tr: v2.38.0 3rd round

Fangyi Zhou (2):
      l10n: zh_CN v2.38.0 rounds 1 & 2
      l10n: zh_CN: 2.38.0 round 3

Hubert Bossot (1):
      l10n: fr: The word 'branche' is only feminine

Jean-Noël Avila (3):
      l10n: fr: v2.38 round 1
      l10n: fr: v2.38.0 round 2
      l10n: fr: v2.38.0 round 3

Jiang Xin (18):
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'main' of github.com:git/git
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'main' of github.com:git/git
      Merge branch 'l10n-de-2.38' of github.com:ralfth/git
      Merge branch 'catalan' of github.com:Softcatala/git-po
      Merge branch 'fr_v2.38_rnd2' of github.com:jnavila/git
      Merge branch 'turkish' of github.com:bitigchi/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'fr_quickfix' of github.com:jnavila/git
      Merge branch 'main' of github.com:git/git
      Merge branch 'main' of github.com:git/git
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'turkish' of github.com:bitigchi/git-po
      Merge branch 'catalan' of github.com:Softcatala/git-po
      Merge branch 'fr_2.38_rnd3' of github.com:jnavila/git
      Merge branch 'l10n-de-2.38-rnd3' of github.com:ralfth/git
      Merge branch 'po-id' of github.com:bagasme/git-po

Jordi Mas (3):
      l10n: Update Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (5482t0f0u)
      l10n: sv.po: Update Swedish translation (5484t0f0u)

Ralf Thielow (2):
      l10n: de.po: update German translation
      l10n: de.po: update German translation

Yi-Jyun Pan (1):
      l10n: zh_TW.po: Git 2.38.0, round 3

 po/bg.po    | 1333 +++++++++++++++-------
 po/ca.po    | 2287 ++++++++++++++++++++-----------------
 po/de.po    | 1297 ++++++++++++++-------
 po/es.po    | 2595 ++++++++++++++++++++++++------------------
 po/fr.po    | 1339 +++++++++++++++-------
 po/id.po    | 3642 ++++++++++++++++++++++++++++++++++++-----------------------
 po/sv.po    | 1236 +++++++++++++-------
 po/tr.po    | 1471 +++++++++++++++---------
 po/zh_CN.po | 1541 +++++++++++++++++--------
 po/zh_TW.po | 1558 +++++++++++++++++--------
 10 files changed, 11692 insertions(+), 6607 deletions(-)

--
Jiang Xin
