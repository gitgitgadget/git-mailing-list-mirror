Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670CAEE49A4
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 23:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjHTXZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 19:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjHTXZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 19:25:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A304A9
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 16:25:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a3236a414so911614b3a.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692573942; x=1693178742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vrb1PIoq81DirHiVHtV0r73D+WpptT2FumC0kL8/qPw=;
        b=D8e3S7/mgz245DuysoeYe+LTZhjafahvschAuyszhKfwPjsq7VVBhZx7bTsaxSli4C
         nIVMxA5Z/EN5Ez7lSrfDf0Eq68rvxkWY/2flKNcmzJrXQZwyOjV9mtGzUcDsDqAZm0/y
         ZjLzivIQHPBIwSkaUmriWfl40RIA4FHG3Ak1B5Gs0Wfem7idWrlmYPRQcAKLmpYS6Sev
         jByf8dzos9ngg00llaGJch9ZPlLNWi33phH6e0Fou9k8pshLjruuAQFArtVxYM4xeJRZ
         RPMW1crRvpUHAQMs8f0FITXCmCmH8P20g34lg8OhjXYHi0mgpFjAVqirhm6SeGZKX4zT
         gFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692573942; x=1693178742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vrb1PIoq81DirHiVHtV0r73D+WpptT2FumC0kL8/qPw=;
        b=Z7cEFQ/B8xrYS/Yt6tRUIpQaB1RqbU52Me7s9GRCX/vNvKyD2ZNkkqiIpLbqNqsRce
         GBNAvtDYlLS6PFEjkOdzY5CJOdS12+snzhgIdEmRdT8GxW551j8wPxtRKwraZbmJQKt5
         2HOf9na14iBOg31pM4XHL8Fkos7l30jMKJ7FZ7mds8ISkP79ZHQYDSQjTsMTYslRr8LB
         bhCUg/d6RKO3es+FXW9Nl7vYk/c8rTx4+sJmIx3vsWl2htgoluT3DAoLj5VB27BSSyJw
         /liROqNXuohKc0lK0uuZSswH4Fo1howDVGfCTApsJTfVYB8+oo38xAjJMqoEPfjg+dxz
         QaLw==
X-Gm-Message-State: AOJu0YzHk15yqgGMI8oKY20r+yKCJ3AzfUOFSjmQw7QwywYzW9e2889v
        T4Mzn5et7L+uSQ/h1pcUcqw=
X-Google-Smtp-Source: AGHT+IG7APC0i5pqnXfa+tgO2Ldy6gt6CHNXfWH9k4f1ZTJRu1CTqCgOJJAnTuPCMH35o/bRzF5OwQ==
X-Received: by 2002:a05:6a00:1702:b0:68a:2c24:57df with SMTP id h2-20020a056a00170200b0068a2c2457dfmr5834724pfc.7.1692573941814;
        Sun, 20 Aug 2023 16:25:41 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j20-20020a62e914000000b00688c733fe92sm4853511pfh.215.2023.08.20.16.25.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2023 16:25:41 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arkadii Yakovets <ark@cho.red>, Arusekk <arek_koz@o2.pl>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
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
Subject: [GIT PULL] l10n updates for 2.42.0 round 2
Date:   Mon, 21 Aug 2023 07:25:37 +0800
Message-Id: <20230820232538.9751-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.42.0.

The following changes since commit f1ed9d7dc0e49dc1a044941d821c9d2342313c26:

  Git 2.42-rc2 (2023-08-15 10:20:02 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.42.0-rnd2

for you to fetch changes up to d1f87c2148b025a9c664e64db17205783ef2991c:

  Merge branch 'po-id' of github.com:bagasme/git-po (2023-08-21 07:05:38 +0800)

----------------------------------------------------------------
l10n-2.42.0-rnd2
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmTinJwACgkQk24VDd1F
MtXNfw/9Hn8LCB7MXV0FGvS7BYcijWuXZxGa+3o4mxKREwmHe3R7AYVTcVKADw03
YE77oHVCcG6EiVldfUDOdwIO3bgKTlp8On4LpLzGAoB8+oT4dLntQvIQK+W0vw8A
zCgTR5c0IMahdUxJgFMoYsTxN3bScTMJgdrQZ6OLJ8OaP4nTOhrzyoGIPWKE7QMt
zQ058zUJi+OA/Z7arKJG72IiwB6u+/xSdnf94+qjIbvCaQf1HDs2E/eniNMKY/do
u4ETO5mgqnAZdowWvp18uBwStkGZTmucYb5D9aq1lUDeUKGXEIRZlYCIz8h7g318
9ZYVJlj8L2y/vCw4C/jdpcjGvZeIWQYibIHPItWLGo3HgKXp41phCsGPi4TkBi61
dwpizSkCXpUMr7EVj4ngBiqCLvjqIrX/WPU3KrAgUYLvsUwPtczAHsCrT1EA7gXR
Wbpv6yEDRjdvqgId4oL2UvJK6EANIug6ZJt29LdkegAH9lCB4Q13ULeHgS9CsWpZ
xwmmR8ybxoSmjsjvpcMFKfBLuB/kc9JjqGx852w2GQMDOTtVGxLMTPGrkMWr2pfw
WpbQ/HImNG6UEFpstW7/pEP/0OQV/oUZjGD39/NJBEcIImS89LUV+MXeZj+3DwbO
TqZ+Q5eF+ScgCD32CNM/CU7x2o5xs+42dYk09r8cGdqzB4NUBQc=
=bnqd
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Arkadii Yakovets (1):
      l10n: uk: update translation (2.42.0)

Bagas Sanjaya (1):
      l10n: po-id for 2.42 (round 1)

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Emir SARI (1):
      l10n: tr: git 2.42.0

Jean-Noël Avila (2):
      l10n: fr v2.42.0 rnd 1
      l10n: fr v2.42.0 rnd 2

Jiang Xin (9):
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-ru
      Merge branch 'master' of github.com:git/git
      Merge branch 'l10n-tr' of github.com:bitigchi/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'tl/zh_CN_2.42.0_rnd1' of github.com:dyrone/git
      Merge branch 'update-uk-l10n' of github.com:arkid15r/git-ukrainian-l10n
      Merge branch 'catalan' of github.com:Softcatala/git-po
      Merge branch 'l10n-de-2.42' of github.com:ralfth/git
      Merge branch 'po-id' of github.com:bagasme/git-po

Jordi Mas (1):
      l10n: Update Catalan translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation 5549t0f0u

Ralf Thielow (1):
      l10n: Update German translation

Teng Long (2):
      l10n: zh_CN: v2.42.0 round 1
      l10n: zh_CN: 2.42.0 round 2

Yi-Jyun Pan (1):
      l10n: zh_TW.po: Git 2.42

 po/ca.po    |  548 +++--
 po/de.po    |  532 +++--
 po/fr.po    |  519 +++--
 po/id.po    |  608 ++++--
 po/ru.po    | 2983 ++++++++++++++-----------
 po/sv.po    |  493 +++--
 po/tr.po    |  490 +++--
 po/uk.po    | 7020 +++++++++++++++++++++++++++++++++++------------------------
 po/zh_CN.po |  566 +++--
 po/zh_TW.po |  603 +++--
 10 files changed, 8759 insertions(+), 5603 deletions(-)

--
Jiang Xin
