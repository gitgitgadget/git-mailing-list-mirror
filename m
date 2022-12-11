Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C0C001B2
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 11:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLKL7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 06:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiLKL7a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 06:59:30 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED41146D
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 03:59:25 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h33so6413276pgm.9
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 03:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RP87F+8vyTxmUq9Y/6AgEUGexWZrhyr3igPvI0d/T2E=;
        b=Ga2AMhtwOgTGpg3QJPNlTDQCMPrFekJI6dKVIK1BxKyloJbuXPzDA/+gt1NEaLF9RZ
         UqkEbxvxi8E8GLoYrRYgrSLcma627o/jGl/gXnvpkD4CpMYiVObVndeqhhkiJZ6QnX5A
         IhSm9hocqplwqt1RTaJjDwoj6YiDANJss/hA3abzy/0cYqy/KsjP/yt7vVuCD9+EQ8GG
         AVqmas/A+85kVIQ52f68LYCAClgRyN/w59jZfMEqJ0fs/GLZxNS92TKGLw+/xRFklT9v
         zj/VvQKQ8G4znOyZkRdqS4eNf1VYsitBWhQ+zqrNYoFYcBQGPBMEjStYPPNA2dFp5mmA
         djTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RP87F+8vyTxmUq9Y/6AgEUGexWZrhyr3igPvI0d/T2E=;
        b=ag2qA0SjzwJ1xbQ8x9sBOKYoqpudBqEyQWrr+ZamYo+USzlpKuiu58ZBe+CMJ3CBeK
         KIo94TwiK9C2556Zt7Ud7ieRpkL8UJ2OGpZN9c5WvJhMYxXCSZKzh/2ONsO2/3YFCsg5
         +Xkw/GtVmk3rpuKoQxM9WgUlhFWshD4kw5KecBX8IfySuuvzKLqOSznRUsYaO3uQGx+q
         RWCnVtVgoAKdSPckwAcqltkV2DeokAXKBN5RzvqER8N4UKUqKUhvtIgZFjd9vm/Lxzua
         xuToFXraoVM6bHJox8IBWArExeI0FK/y11GC8UkV+5dzgFrB/g0aRzEFtCLs+LFQTn3p
         8jpw==
X-Gm-Message-State: ANoB5pnValLAh1NPelvZxCgdxEw6I77IpOm6C7g0kG6DgpszmOBfwsvL
        YR36XYDgtOApDIdMbLMuKPk=
X-Google-Smtp-Source: AA0mqf77IPtXBc3r5FoaATmfFZ5R0O8DMbEddD140CmXoS9Ij11K8Vd9AUHoBpQ7f3ePgG33bxrhbQ==
X-Received: by 2002:a62:e50e:0:b0:56e:34b0:4fec with SMTP id n14-20020a62e50e000000b0056e34b04fecmr11702892pff.14.1670759964657;
        Sun, 11 Dec 2022 03:59:24 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id v66-20020a626145000000b0057716769289sm3877680pfb.196.2022.12.11.03.59.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Dec 2022 03:59:23 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>, Emir SARI <emir_sari@icloud.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.39.0 round 1
Date:   Sun, 11 Dec 2022 19:59:20 +0800
Message-Id: <20221211115920.706-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.39.0.

The following changes since commit 2e71cbbddd64695d43383c25c7a054ac4ff86882:

  Git 2.39-rc2 (2022-12-06 09:49:31 +0900)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.39.0-rnd1

for you to fetch changes up to 6d0497d526d0d13680e912b385cddbd52d9f3825:

  l10n: zh_TW.po: Git 2.39-rc2 (2022-12-11 01:27:25 +0800)

----------------------------------------------------------------
l10n-2.39.0-rnd1

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5501t)

Bagas Sanjaya (1):
      l10n: po-id for 2.39 (round 1)

Emir SARI (1):
      l10n: tr: v2.39.0 updates

Fangyi Zhou (1):
      l10n: zh_CN v2.39.0 round 1

Jean-Noël Avila (1):
      l10n: fr: v2.39 rnd 1

Jiang Xin (8):
      Merge branch 'fr_v2.39_rnd1' of github.com:jnavila/git
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'l10n-de-2.39' of github.com:ralfth/git
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'fz/po-zh_CN' of github.com:fangyi-zhou/git-po
      Merge branch 'catalan' of github.com:Softcatala/git-po
      Merge branch 'turkish' of github.com:bitigchi/git-po

Jordi Mas (1):
      l10n: Update Catalan translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5501t0f0)

Ralf Thielow (1):
      l10n: de.po: update German translation

Yi-Jyun Pan (1):
      l10n: zh_TW.po: Git 2.39-rc2

 po/bg.po    |  856 +++++++++++++----------
 po/ca.po    |  958 ++++++++++++++------------
 po/de.po    |  814 +++++++++++++---------
 po/fr.po    |  927 ++++++++++++++++---------
 po/id.po    | 1048 +++++++++++++++++++----------
 po/sv.po    |  766 ++++++++++++---------
 po/tr.po    |  848 +++++++++++++----------
 po/zh_CN.po |  853 +++++++++++++----------
 po/zh_TW.po | 2161 ++++++++++++++++++++++++++++++++++-------------------------
 9 files changed, 5514 insertions(+), 3717 deletions(-)

--
Jiang Xin
