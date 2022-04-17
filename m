Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDA1C433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 12:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiDQMa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbiDQMaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 08:30:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE20FBE0A
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 05:27:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so15221537pjb.2
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wqoOamFFpHLvqQWrErEXYxw5U9Teiutin8UkSkfw08=;
        b=WGWghr9Q9ddZX/ca1Cqcl3OJHaFP+YI8Z5cPPFrb+c0LVKvflNHMcXTwo9Ocoi/oZ5
         +utCS8r6NO2wN5pQP9OSvewSG531LvcP7kwXDEsJ0uoCfy4D6C/mp0e5k3VTh6mBBmXR
         dHSJWtp+bD2lZqhnud6NagOUpMUoWLtLClZYxCU/2FzGceSsugsN7qUlrtXnskbgcscx
         sqIK1V8FMEjWHSXGQuhKNzKYaq9vxhVKMZvMH1dJ8gYMMkLMw5lQ7ZbLJVAlnJFykfNS
         jMQoMz69jN+sd6aZ1Y3/PyZEEBuVqR2JnC4w7FRbBvVANqI06UF8tRn1KVcgfScsp6ip
         jCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wqoOamFFpHLvqQWrErEXYxw5U9Teiutin8UkSkfw08=;
        b=sjC+7zmAe1wk9CyT0Vx5cJc/Xae3j7nCJsuzlpeH+ukUqCjzMcYg1esDvxxYq2ajvG
         S+LX3VvZzTrni8Xdz/SRWoCrFeMt8P6exvbDxuO7GElcPcv9wVs/4xLWaTq5MfI4xyLs
         riM2s/XkUeVuxggM3f0iMGF3H7NDuCec+YfaBp53H8CwqsFj6qhdYrxmrtn+mzkWpNrg
         B0llHMvUJvNGeqCwhaf7VnaO/YoXMgv7ykZbnhwLQK8LbrCY/8y/VqyEFJabHw107J4b
         grXI5IxES8NiUYWhdRnYZKsx206lWED4p51cZmuTpD2U9X39/IVYKtOOm9b+CZ7foGDE
         uIyg==
X-Gm-Message-State: AOAM531zEns437f0calzAjavdNEVJ9dAvUNrmlrcVy3Lna76df0fILrE
        LJVwhN7UnwVYNcpMJgDjxrY=
X-Google-Smtp-Source: ABdhPJw6M6aH2f8Pgse4rS3Pa8KpiFjgfpLeilOyvPIxD4ZxqiVsGzEKlfzdU006gtrGKc9tZ1ZkyQ==
X-Received: by 2002:a17:903:120c:b0:154:c135:60d3 with SMTP id l12-20020a170903120c00b00154c13560d3mr6644615plh.48.1650198469124;
        Sun, 17 Apr 2022 05:27:49 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090a891600b001cd498dc152sm13069557pjn.2.2022.04.17.05.27.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2022 05:27:48 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.36.0 round 2
Date:   Sun, 17 Apr 2022 20:27:44 +0800
Message-Id: <20220417122744.6140-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.36.0.

The following changes since commit 11cfe552610386954886543f5de87dcc49ad5735:

  Git 2.36-rc2 (2022-04-11 21:27:02 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.36.0-rnd2

for you to fetch changes up to 1208041f05ccdcc95a1a1bed02a96a3a17106701:

  Merge branch 'master' of github.com:Softcatala/git-po (2022-04-17 09:07:28 +0800)

----------------------------------------------------------------
l10n-2.36.0-rnd2

----------------------------------------------------------------
Bagas Sanjaya (2):
      l10n: po-id for 2.36 (round 1)
      l10n: po-id for 2.36 (round 2)

Daniel Santos (3):
      l10n: pt_PT: update Portuguese translation
      l10n: pt_PT: update TEAMS file
      l10n: pt_PT: update Portuguese translation

Emir SARI (2):
      l10n: tr: v2.36.0 round 1
      l10n: tr: v2.36.0 round 2

Fangyi Zhou (3):
      l10n: Update zh_CN repo link
      l10n: zh_CN v2.36.0 round 1
      l10n: zh_CN v2.36.0 round 2

Jean-Noël Avila (2):
      l10n: fr: v2.36 round 1
      l10n: fr: v2.36 round 2

Jiang Xin (10):
      Merge branch 'master' of github.com:git-l10n/git-po
      l10n: git.pot: v2.36.0 round 1 (192 new, 106 removed)
      Merge branch 'fz/po-zh_CN' of github.com:fangyi-zhou/git-po
      Merge branch 'fr_2.36_rnd1' of github.com:jnavila/git
      Merge branch 'master' of github.com:git/git
      l10n: git.pot: v2.36.0 round 2 (4 new, 3 removed)
      Merge branch 'loc/tw/0407' of github.com:l10n-tw/git-po
      Merge branch 'fz/po-2.36.0-round2' of github.com:fangyi-zhou/git-po
      Merge branch 'master' of github.com:ruester/git-po-de
      Merge branch 'master' of github.com:Softcatala/git-po

Jordi Mas (1):
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation

Trần Ngọc Quân (1):
      l10n: vi(5285t): v2.36.0 round 2

Yi-Jyun Pan (1):
      l10n: zh_TW: v2.36.0 round 2

 po/TEAMS    |     6 +-
 po/ca.po    |  8936 ++++++++++++++++++---------------
 po/de.po    |  8614 ++++++++++++++++---------------
 po/fr.po    |  8764 +++++++++++++++++---------------
 po/git.pot  |  8180 ++++++++++++++++--------------
 po/id.po    |  9223 ++++++++++++++++++----------------
 po/pt_PT.po | 15859 ++++++++++++++++++++++++++++++----------------------------
 po/tr.po    |  8499 ++++++++++++++++---------------
 po/vi.po    |  8697 +++++++++++++++++---------------
 po/zh_CN.po |  8425 ++++++++++++++++---------------
 po/zh_TW.po |  8746 +++++++++++++++++---------------
 11 files changed, 50280 insertions(+), 43669 deletions(-)

--
Jiang Xin
