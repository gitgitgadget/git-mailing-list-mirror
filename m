Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D4CC07E9D
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 00:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiI1AWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 20:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiI1AWB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 20:22:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3E1138F2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 17:21:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b23so11083035pfp.9
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tbQuk/lfA9+iWRNhe7fB0o3BjvsxGV4dyVO2WvAKcgg=;
        b=mjwCfozRU6ovILin3SInWlfkBP8sByRFZvf0qbVIjZUPrr6BALLTyyf4qk8WPv0Wcl
         nTdMK2QA929vJhAePlCZZjzT0XH+oCqD7EMNmm5PeNDoTuTWRaE3E8iY5G5XjWpCmlY5
         eAJ2vjS4F3ww9cR3gD4gYb7PL5MB9SHr5CG9Zjczv04Dr3IORqzn8ZEUEJyV89YrJ33Q
         qzQugZt73MSS78GKn/7PAHm1acVwAQOFsFWr92MuIw6qBtfNYfPTJTC20jH8j2dE9D93
         yFrm3KvBGUQ5HLsq3YaOVPzcNSKuo3MlDUrqiNTUFs4ivSeirZVlx2aKukaMSNKg3EEy
         NFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tbQuk/lfA9+iWRNhe7fB0o3BjvsxGV4dyVO2WvAKcgg=;
        b=LThbdhzFgE8olBf1JeiTVHIian5UFTqxdFqluTUtlZTvqf8xLk1n1LEZ7fxi/aXmF+
         wv82oEFvY4EzdyfWdur3VrdzLh7l0bDGWU8ATnQuN+kj3yB4IyVKTMWycAeJfunSWRPA
         Kr2K97zGKM14PsvfoV9T0a35N/cdjuP3m7//H5OCISqVYJFlaJDK3XmmQ1QO/TpY2ztS
         SglnANPURtS72knD9jfWZxQ970iQZaQdU5epJhR3nLMmQMlw6mVgEyzPTCddITcI2/z6
         /nFo75uSNpWTXHyXNOLISOx8P8V8D65Lh++CbiuDsqAWRW91MmWrHIA2lgXnG0QrR6Gy
         4TXw==
X-Gm-Message-State: ACrzQf2vZ71TJYVYVwSX37BEqy2QmlvJoxqOsmNaTCZVHu5D1cy6bMR3
        7dDuOopVVCtSCUqup/S+uyqCMrIwe74=
X-Google-Smtp-Source: AMsMyM5103WRKNW7OcAAIIDa/042PiJ4AWh2ob5vWm4cZKSwjtVUX2ewxvs226NXCwYa4GC7mSQ3AQ==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id b12-20020a056a00114c00b005282c7a6302mr31935835pfm.37.1664324515035;
        Tue, 27 Sep 2022 17:21:55 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d128-20020a623686000000b0053e66f57334sm2404553pfa.112.2022.09.27.17.21.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 17:21:54 -0700 (PDT)
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
Subject: [L10N] Kickoff for Git 2.38.0 round #3
Date:   Wed, 28 Sep 2022 08:21:51 +0800
Message-Id: <20220928002151.15377-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Another new translatable message was found in the just-released Git
v2.38.0-rc2. Let's start a new round of git l10n. Please send your
pull request to the l10n coordinator's repository below before this
update window closes on Sun, Oct 02, 2022. 

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


** Please note: The update window will close on Sun, Oct 02, 2022. **


--
Jiang Xin
