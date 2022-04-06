Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B18C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 10:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiDFKbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 06:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379669AbiDFK3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 06:29:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE01F3479AA
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 23:52:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d15so1151300pll.10
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LKv+9jhy+/kt4X6v+Y9ThscWQt4KGgW1puS3d4DwWQ=;
        b=DERUwSKUdzzlMECpBAllnO+R0zmajoGY6x6FiIaqF2OtdVybtK5N2VP8zqurGeu0p/
         yzP028Q21vyvmLeqZNDIjhYMzjBF7/YID9Ug4ljIiOs3qEhkC2AZNoquiRnyDSYjsQG5
         0CLqtmS0tvVTRl0wynlT5Jq0w2/zKuu8l1YRTKVcyJpQBGx4WyFtIkQSHASMJ7/o1z1K
         L9vLGDUtHt0rB9FNUsovVOwFTxFJmx624Oxm81ks5BXuRIG2mfdH3PT9Cmdx/77YxGzQ
         h1DAOV2SnAm3Wn7ktItEErFzZQBdUUX/dVhjxK+gi9hQRlXr4HaFrwIWQVP7q/i5FTNL
         fHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LKv+9jhy+/kt4X6v+Y9ThscWQt4KGgW1puS3d4DwWQ=;
        b=KWBOPWSjA5m208g3kcNkRKDE2+kPJVFPFUxTCMAeYCHY+7h8a1lnudRHJZsAWjv/fK
         AFfnoQLTxLcTd2/JO+hRCZktURmyIeKsdAE9LyXta/fsuYi5EaCi+LOxMrdQwNzuEzRa
         avlGG5OQrw7YMGur/JZiQVaNduQ1Kclj8hU+luKP65QVQ3dQ8W4prZQ2OyDNGw58dkdv
         gJeM94VVH5N+c8ykH2FtdsCsdTm8Ftd3qiclEq91Bvi4O7NWjKLjXteCoZ68evtFxqLa
         nOCbZOk6XrWMjmnKRch4fOjRCdro+4D0fnJQgqLNTPLGTl/ohZ2W/wLjdgrIdL7yfrSz
         qEWA==
X-Gm-Message-State: AOAM532+T9A1krCrYZjWqzpNFT1ibX8Er1Jn9eO7KgM5PX6iRlfKwj9j
        p3oO8asvuzKtY3Gc91Ch6fhogUrt+zE=
X-Google-Smtp-Source: ABdhPJzzk4y6uz4AKD4LRBesAbEl/e1Jk77Vue8PhWDLX7sLHwwdYIqfXD68zNDmcbmudLYdcbeETA==
X-Received: by 2002:a17:90b:124c:b0:1bc:369b:7db5 with SMTP id gx12-20020a17090b124c00b001bc369b7db5mr8258117pjb.179.1649227959976;
        Tue, 05 Apr 2022 23:52:39 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm16923424pfw.144.2022.04.05.23.52.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Apr 2022 23:52:38 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
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
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.36.0 round #1
Date:   Wed,  6 Apr 2022 14:51:51 +0800
Message-Id: <20220406065151.14954-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.36.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 192 updated messages need to be translated
since last update.  Let's start a new round of git l10n based on commit:

    66593217ec (l10n: git.pot: v2.36.0 round 1 (192 new, 106 removed), 2022-04-06)

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

You can also keep track of the changes in the "po/git.pot" file from
the "pot/master" and "pot/next" branches, and prepare for translation
in advance. See:

 - https://github.com/git-l10n/git-po/tree/pot/master 
 - https://github.com/git-l10n/git-po/tree/pot/next

A helper program hosted on https://github.com/git-l10n/git-po-helper can
help git l10n coordinator and git l10n contributors to check the conventions
of git l10n contributions, and it is also used in GitHub actions for each
pull request for "git-l10n/git-po" repository.

** Please note: The update window will close on Sun, Apr 17, 2022. **


--
Jiang Xin
