Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445B6C47082
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 03:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242DD6141D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 03:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFFD1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 23:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFFD1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 23:27:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BBEC061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 20:25:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 27so11154339pgy.3
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FE6a801PSuKrtf/mA0WP3UptBqsrf4YEQbEd9BFBogI=;
        b=OlEEE6Z3Uj7Sexb6iD7yrh6PlyCXTVZFGAMwajsGW/uGyJrFJM1Z4j6Y2peCIH+Su5
         AI+oEw5CX5MtSfjJvBesYbcYg1jBsrxnouOg+Yo9W2/p9GkJEUM7DqiAJ1J7+6v3bLjq
         Bc4X96V22INsT3OwQSwuMPSWprpezL8TAAnFqam3+k5+6S0hRmIOxvpRy/j3lhhK/bKL
         CnyXnEDM/bpgex+d4G6pJURMSjkINE0Jr8s6MFLTiNzDHEbseXQvg7qd/4/+r/jLdVc/
         VEiZ1+/p8PaVnGbK2gCrkRKTYkWiVPGuowx0cz0w0TEuPWAJaIE4jFZVzKGJQDQlq0Xj
         2Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FE6a801PSuKrtf/mA0WP3UptBqsrf4YEQbEd9BFBogI=;
        b=p152xU9ob3PtNxoUQMjrLNQPPBpduY60qyiCuqTSMBX5gVIpSqI1kuin+Ejlr4LJ82
         DPGZj+y+pIY1NuIhKSHQGx76r82wo+bjPFgvK5zxi/u/ICyqUHRch/MslBdyIZLWIrwv
         JFU3L6jRTcBYJUC64MxqZZQUomcEyei2rCAPJmCLBSwiE4vKU0MDNT8sA9s6y1qr0CvE
         tO+h2uB15Z5Ukm5LlBRpZ3m8oYvq/VBuc1gvvQ0mXYI+MDbgRiCzQV0WCPqVoaCGnmoZ
         fSBdrfxo2O7YOWptCzcZeCDXjlV0RBxuT+J+uyewcMYIhhR/D5mXLNU+0nCeIgv3lebE
         AZeA==
X-Gm-Message-State: AOAM533tRjNsRJKLJQB2jKyimxKOD5GL91Iz+n81aIFEKpH5lGtKndVa
        hWr5Y/gBGAbcc80OOByD3R4=
X-Google-Smtp-Source: ABdhPJx+5w7Bk5N3ZOjy91VX5C82p1HmkSlWdCNuluQB30qQ9kKbkii5VyzNxgIIc24hrCkQqpqH1A==
X-Received: by 2002:a05:6a00:a02:b029:2ec:a0a6:9c54 with SMTP id p2-20020a056a000a02b02902eca0a69c54mr7011349pfh.47.1622949932045;
        Sat, 05 Jun 2021 20:25:32 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t5sm4920273pfe.116.2021.06.05.20.25.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 20:25:31 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Alexey Roslyakov <alexey.roslyakov@gmail.com>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        =?UTF-8?q?Emir=20Sar=C4=B1?= <bitigchi@me.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>,
        rlespinasse <romain.lespinasse@gmail.com>
Subject: [GIT PULL] l10n updates for 2.32.0 round 1.1
Date:   Sun,  6 Jun 2021 11:25:27 +0800
Message-Id: <20210606032527.3641-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20210605145717.13646-1-worldhello.net@gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

After sending pull request last night, I received new update from Christopher.
So I deleted tag l10n-2.32.0-rnd1 and creataed a new tag l10n-2.32.0-rnd1.1
with update on "po/es.po".

Please pull the following l10n updates for Git 2.32.0.

The following changes since commit bf949ade81106fbda068c1fdb2c6fd1cb1babe7e:

  Git 2.32-rc0 (2021-05-16 21:05:24 +0900)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.32.0-rnd1.1

for you to fetch changes up to 8e02217e104d9084bdba17d945f078863073ff59:

  l10n: es: 2.32.0 round 1 (2021-06-05 20:06:23 -0500)

----------------------------------------------------------------
l10n-2.32.0-rnd1.1

----------------------------------------------------------------
Alex Henrie (1):
      l10n: Update Catalan translation

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5204t)

Alexey Roslyakov (1):
      l10n: ru.po: fix typo in Russian translation

Bagas Sanjaya (5):
      l10n: id: po-id for 2.32.0 (round 1)
      l10n: README: document git-po-helper
      l10n: README: document "core translation"
      l10n: README: document l10n conventions
      l10n: README: note on fuzzy translations

Christopher Diaz Riveros (1):
      l10n: es: 2.32.0 round 1

Daniel Santos (2):
      l10n: pt_PT: add Portuguese translations part 2
      l10n: pt_PT: add Portuguese translations part 3

Emir Sarı (1):
      l10n: tr: v2.32.0-r1

Jean-Noël Avila (1):
      l10n: fr: v2.32.0 round 1

Jiang Xin (9):
      l10n: git.pot: v2.32.0 round 1 (126 new, 26 removed)
      l10n: fix typos in po/TEAMS
      Merge branch 'fr_next' of github.com:jnavila/git
      Merge branch 'master' of github.com:Softcatala/git-po
      Merge branch 'l10n/zh_TW/21-05-20' of github.com:l10n-tw/git-po
      l10n: README: add file extention ".md"
      Merge branch 'pt-PT' of github.com:git-l10n-pt-PT/git-po
      Merge branch 'fix_typo' of github.com:e-yes/git
      l10n: zh_CN: for git v2.32.0 l10n round 1

Jordi Mas (1):
      l10n: Update Catalan translation

Matthias Rüster (1):
      l10n: de.po: Update German translation for Git v2.32.0

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5204t0f0u)

Trần Ngọc Quân (1):
      l10n: vi.po(5204t): Updated Vietnamese translation for v2.32.0

Vincent Tam (1):
      l10n: fr.po fixed inconsistencies

Yi-Jyun Pan (2):
      l10n: zh_TW.po: v2.32.0 round 1 (11 untranslated)
      l10n: zh_TW.po: localized

rlespinasse (1):
      l10n: fr: fixed inconsistencies

 po/{README => README.md} |   113 +
 po/TEAMS                 |     4 +-
 po/bg.po                 |  7100 ++++++++++++------------
 po/ca.po                 | 13056 ++++++++++++++++++++++++---------------------
 po/de.po                 |  6956 +++++++++++++-----------
 po/es.po                 |  7106 ++++++++++++------------
 po/fr.po                 | 10104 ++++++++++++++++-------------------
 po/git.pot               |  6731 ++++++++++++-----------
 po/id.po                 |  9809 +++++++++++++++++++---------------
 po/pt_PT.po              |  1237 +++--
 po/ru.po                 |     2 +-
 po/sv.po                 |  6882 +++++++++++++-----------
 po/tr.po                 |  6819 ++++++++++++-----------
 po/vi.po                 |  6893 +++++++++++++-----------
 po/zh_CN.po              |  6862 +++++++++++++-----------
 po/zh_TW.po              |  7104 ++++++++++++------------
 16 files changed, 51055 insertions(+), 45723 deletions(-)
 rename po/{README => README.md} (72%)
