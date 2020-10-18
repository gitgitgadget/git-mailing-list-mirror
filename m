Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E5AC433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 10:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C27A20897
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 10:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+JjuJus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgJRKmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 06:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgJRKmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 06:42:15 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB698C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 03:42:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n9so4233576pgf.9
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 03:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6NesR83M1qi/CYzNk0pMt0h0IBmWcKBHNxzsGakPMI=;
        b=C+JjuJusCxwqzXlyFZwCBIJLTPtM9ZWCz3agsqNQvl2jBENw4Gf8X/68LkBUZQakVT
         UlBotKzURtwyXfwBgC3RXoguPtHZGBp6uZ12jx/le/jdyyoAfGvecxErJ4YBh71WbSgj
         OBc49h8u23DVPvykOes/lZEl4VXFirGMHoRhCnleXPhdmblIe/QBE6ZNbzLSDOGT8NYL
         DAN2iLcyCx/4BH9wxenB7Pp/JSKF0itiClne6NxYNQ2t/+ldkhdbcYCqXZHo1CaVDftQ
         SFzcfvqBWaZFS7CnZ/CLsBXxKY5EoLTHJD2LpVcG+UTUhlDa9ayMITaQH+MoC6oT0d6N
         2GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6NesR83M1qi/CYzNk0pMt0h0IBmWcKBHNxzsGakPMI=;
        b=fkw5MkKl3D6zHx1rNrpSd2e5VP6kZE9wp1Tk3J3i9BFQ7vOQedn1bWbtHUro/tboC8
         KisK2raQBQu62wCfvwPsHNSr5chIe7LwNJ+NGYhAZWIf7dHkMvTBzUNm6Lv6Gw0Fn/d9
         aVvPRIfgJ1UY7oGP8uAIagcdNwznlHCUoUUyC33JhtnD6Irm7FmMJ0a7h0MMieM8IatC
         svrbBmx642tdVbq7d/V43lKcbRgdtKWPvfjpxVGoKlJHfdf4K54F415dwfzDPGp1IAtA
         GZPuW4lq9HQ0ZHoExvg+QGGozDdErJ9iOc/C7TMHlWR3UglgjeXBlqaA2U9TFFw6wSJt
         GdXA==
X-Gm-Message-State: AOAM530kgXYHlsRa2p40xKt6uHIZ73W/UcoeXDMJhC+NWFRu0frMNJAW
        D4FqoYZOBzpr95J2HTja3mM=
X-Google-Smtp-Source: ABdhPJxnnZKD72U052TcsS6vdIyXXMsOuR5ef2Wfv/pAUpAG1etqe/KlEtuZJUhxmP2OBQD43JfOdg==
X-Received: by 2002:a62:1d57:0:b029:152:47a7:e04b with SMTP id d84-20020a621d570000b029015247a7e04bmr12365650pfd.48.1603017732120;
        Sun, 18 Oct 2020 03:42:12 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id w4sm8423541pjh.50.2020.10.18.03.42.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2020 03:42:10 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Daniel Santos <hello@brighterdan.com>,
        =?UTF-8?q?Emir=20Sar=C4=B1?= <bitigchi@me.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        pan93412 <pan93412@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [GIT PULL] l10n updates for 2.29.0 round 2
Date:   Sun, 18 Oct 2020 06:42:01 -0400
Message-Id: <20201018104201.20210-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.29.0.

The following changes since commit d4a392452e292ff924e79ec8458611c0f679d6d4:

  Git 2.29-rc1 (2020-10-08 21:53:26 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.29.0-rnd2

for you to fetch changes up to 2b4cb0057b021fce043098a9f472d056f2726e8c:

  Merge branch 'master' of github.com:Softcatala/git-po (2020-10-18 09:56:33 +0800)

----------------------------------------------------------------
l10n for Git 2.29.0 round 2

----------------------------------------------------------------
Alessandro Menti (2):
      l10n: it.po: update the Italian translation for Git 2.29.0 round 1
      l10n: it.po: update the Italian translation

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5013t)

Daniel Santos (2):
      l10n: Portuguese translation team has changed. Wohoo!
      l10n: pt_PT: make on po/pt_PT.po

Emir Sarı (2):
      l10n: tr: v2.29.0 round 1
      l10n: tr: v2.29.0 round 2

Jean-Noël Avila (2):
      l10n: fr: v2.29.0 rnd 1
      l10n: fr: v2.29.0 rnd 2

Jiang Xin (12):
      l10n: git.pot: v2.29.0 round 1 (124 new, 42 removed)
      Merge branch 'fr_2.29.0_rnd_1' of github.com:jnavila/git
      Merge tag 'v2.29.0-rc1' of github.com:git/git
      l10n: git.pot: v2.29.0 round 2 (1 new, 1 removed)
      Merge branch '2.29-r2' of github.com:bitigchi/git-po
      Merge branch 'l10n/zh_TW/201010' of github.com:l10n-tw/git-po
      Merge branch 'update-italian-translation' of github.com:AlessandroMenti/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'pt-PT' of github.com:git-l10n-pt-PT/git-po
      l10n: zh_CN: for git v2.29.0 l10n round 1 and 2
      Merge branch 'master' of github.com:Softcatala/git-po

Jordi Mas (1):
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation for Git 2.29.0

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5013t0f0u)

Trần Ngọc Quân (1):
      l10n: vi(5013t): Updated translation for v2.29.0 rd2

Yi-Jyun Pan (1):
      l10n: zh_TW.po: v2.29.0 round 2 (2 untranslated)

 po/TEAMS    |     5 +-
 po/bg.po    |  7864 +++++++-------
 po/ca.po    |  8026 +++++++-------
 po/de.po    |  7269 +++++++------
 po/fr.po    |  7302 +++++++------
 po/git.pot  |  7038 +++++++------
 po/it.po    |  7332 +++++++------
 po/pt_PT.po | 33307 +++++++++++++++++++++++++++++++++++++---------------------
 po/sv.po    |  7272 +++++++------
 po/tr.po    |  8379 ++++++++-------
 po/vi.po    |  7301 +++++++------
 po/zh_CN.po |  7220 +++++++------
 po/zh_TW.po |  7317 +++++++------
 13 files changed, 65182 insertions(+), 50450 deletions(-)

--
Jiang Xin
