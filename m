Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5666EC433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 08:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiKWI05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 03:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiKWI0z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 03:26:55 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699BDFC71D
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 00:26:52 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d6so2491068pll.7
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 00:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJkLKNNrm60X6iBTEsYY+02i5oRWQVDR3LEbGrCznwY=;
        b=pWmbbph8ctYtjUn9XaKbDZ2dtp0sW9ii2pXC3kIQ+AcZQgTUZXXH8BTRnKFMuOG61l
         BnMkceG9RuybhgclFMCype7lbMsP7iTFacAj9Qz0VRtwjk3OmwmZexlXDwSNYDcD8CzV
         ZNcySZKggLju594OOxZDOWoewCzztAP/fG0DdIJZnh0GOc5OpqjdeoKMvpaFT9gVCr7X
         T79pPMQEABxblkDuaw/sIaueddyvrUXrX1mlHQ17G8mtgE+ITzdAXnw9qn9Bv4z2yOxO
         bW37L8RZfIvPNpGAgpsyOPxdr3MlImUCZwgbankZRHiTxJffT26BlI2wvXQALtQ44dKU
         Qliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJkLKNNrm60X6iBTEsYY+02i5oRWQVDR3LEbGrCznwY=;
        b=VJb+9rfhOCQjMhpYGKjmYoqY3BV5QdeDWri9gsnNTgxMUkdxTHkuu8p4sCzlVoNUUg
         YvswHezcjpvtHMMCB8yc/w697H3skfxzEgunW3eKqC9XwJlGOpp72xbY6o5aVTU487/j
         VXkF/FDyP8GZ0f6x8znuqm+c5lEeWu/uaKU7XuWbbTLWWttg27yxsA8B5DSLuNCZ2nCc
         BU6Sz3ZdHwlvA2RdVkPo4sQY7ixB6VJ6Sn9MZ9XUn1lTXzyFzzAdSiyE4u/RRcVS6+aB
         ma14x2RgmxLfmcJdh4uYYUbY9NTnAgV6/aGKfJ+OBa/zxtXN+mhWZCiuQAQGPbIY//rc
         P/pQ==
X-Gm-Message-State: ANoB5pmqxiErlShwUrRUToNjodFoKxlYkY9la+5Z6zxsk6g8YNQteK4q
        gTamtmfOgh0Hqn7GkPM8sfr34cakfuF4ZQ==
X-Google-Smtp-Source: AA0mqf5352nHbRGbNqWVwAqg1JttEqc2dk4VDIinIVpCI6LYe/VwpOa/DWoKbHdaHoLbPfyR8bYPkQ==
X-Received: by 2002:a17:90a:2dc9:b0:218:df8d:fbf5 with SMTP id q9-20020a17090a2dc900b00218df8dfbf5mr2899594pjm.20.1669192011644;
        Wed, 23 Nov 2022 00:26:51 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e7-20020aa798c7000000b0056bee23a80bsm12021509pfm.137.2022.11.23.00.26.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:26:50 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
        Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
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
Subject: [L10N] Kickoff for Git 2.39.0 round #1
Date:   Wed, 23 Nov 2022 16:26:32 +0800
Message-Id: <20221123082632.3224-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.39.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 111 updated messages need to be translated
since last release. Please send your pull request to the l10n coordinator's
repository below before this update window closes on Sun, Dec 11, 2022. 

    https://github.com/git-l10n/git-po/

As of git 2.37, we (git l10n contributors) have a new l10n workflow. The
following description of the new l10n workflow is from the "po/README.md"
file.


## The "po/git.pot" file is a generated file, no longer in the repository

The l10n coordinator does not need to generate the "po/git.pot" file every
time to start a new l10n workflow, and there is no "po/git.pot" file at all.

Everyone can generate the "po/git.pot" file with the command below:

    make po/git.pot

But we can also forget about it. By updating our corresponding "po/XX.po"
file, the "po/git.pot" file is automatically generated.


## Update the "po/XX.po" file, and start to translate

Before updating the "po/XX.po" file, l10n contributors should pull the latest
commits from the master branch of "git.git". E.g.:

    git pull --rebase git@github.com:git/git.git master

Then update the cooresponding "po/XX.po" file using the following command:

    make po-update PO_FILE=po/XX.po

Translate the uptodate "po/XX.po" file, and create a new commit.


## Refine your commits, send pull requests

In the "po/XX.po" file, there are location lines in comments like below:

    #: add-interactive.c:535 add-interactive.c:836 reset.c:136 sequencer.c:3505
    #: sequencer.c:3970 sequencer.c:4127 builtin/rebase.c:1261
    #: builtin/rebase.c:1671

These comments with file locations are useful for l10n contributors to locate
the context easily during translation. But these file locations introduce a
lot of noise and will consume a lot of repository storage. Therefore, we
should remove these file locations from the "po/XX.po" file.

To remove file locations in the "po/XX.po" file, you can use one of the
following two ways, but don't switch back and forth.

 * Keep the filenames, only remove locations (need gettext 0.19 and above):

        msgcat --add-location=file po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

 * Remove both filenames and locations:

        msgcat --no-location po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

After squashing trivial commits and removing file locations in the "po/XX.po"
file, send pull request to the l10n coordinator's repository below:

    https://github.com/git-l10n/git-po/


## Resolve errors found by the l10n CI pipeline for the pull request

A helper program hosted on "https://github.com/git-l10n/git-po-helper" can
help git l10n coordinator and git l10n contributors to check the conventions
of git l10n contributions, and it is also used in GitHub actions as l10n CI
pipeline to validate each pull request in the "git-l10n/git-po" repository.
Please fix the issues found by the helper program.


** Please note: The update window will close on Sun, Dec 11, 2022. **


--
Jiang Xin
