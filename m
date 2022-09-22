Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90388C32771
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 00:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIVAub (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 20:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIVAua (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 20:50:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BB76D54E
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 17:50:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y136so7712257pfb.3
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 17:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=j708c84yAml8kVNmupMPK9D+vjHDv5fYejaKY8zysOE=;
        b=AbCXq01J+xeKZQ3FFOrDlMTNyTA+ZP3YjiL0/1vyZ9qiTtFCY9MRS6nnRjBGzDSvA+
         hlqWhEDZrnslBd8g7prKNwolLGSHzv/q+9DtmTHcwLlpktgXpAYLnuuin7New5JEUwOg
         c73zdoQo52IECcaFvTx58GJpLWIORKxvghRncnJm5ecBAOzVNn9CNfU7WERmSgzgnibO
         QQpRETpGt6UMvKV6q+4yuJZ+BlZ7tMENFfcef7O5+d2DvVvP3wWTD29J9MQW1pqX9J13
         bgZrLpfnkr7XY73hYl6qNRdiV26+nb3rm1oXuqxfQvhYxXa+2Lgt95rfQEDoOrmVs7xd
         iyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=j708c84yAml8kVNmupMPK9D+vjHDv5fYejaKY8zysOE=;
        b=xj6KVAdhzqDcbRMYnRsSadQTBmbnp9QV1AQ3VG873p+0NrxcSrfLOpq2L6jZHhDcqd
         TxGEJz/jxHZ7b1mE5BaxpX9qiGwAMdmcWVNQLL4hNFohroDaMnYrazJJ4nTZyNhfjyYp
         sNsBNfNMqTfq6U6Lfoff5Ly10pIaxELO5GrMx+b584CqsHMA2Trh7YSD/WP4Ohfh13gP
         LJuP2VDaFPD9J8EcPg4DCDw7oWGcJNIkEqdJ3YL1V4dZsS1LkGCdM1u5GHNjTVZIh/26
         A+X1pL32H5SQS9MaKFbS/fnkLwMC5s8a9bDGwPoKKlqGcfRALptLW3fwakQshndGoEDV
         aiWw==
X-Gm-Message-State: ACrzQf3kAQnr2Lx/VAc/Wm67YaTskxrbuFgT0/db63d5ppgDIxmjrl9v
        fETvq/FSxzAUyTdL+ki1MU3QIwUmW0gVBw==
X-Google-Smtp-Source: AMsMyM6frC6zDgUa+dF/2dFy7u+O377opzFwMnXB0dfNW8CYyPT0FKYviB0ojcJYazQy68syd01Shg==
X-Received: by 2002:a65:42cc:0:b0:431:af8c:77e1 with SMTP id l12-20020a6542cc000000b00431af8c77e1mr790825pgp.308.1663807827760;
        Wed, 21 Sep 2022 17:50:27 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79732000000b00545832dd969sm2865277pfg.145.2022.09.21.17.50.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2022 17:50:27 -0700 (PDT)
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
Subject: [L10N] Kickoff for Git 2.38.0 round #2
Date:   Thu, 22 Sep 2022 08:50:24 +0800
Message-Id: <20220922005024.23869-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Additional 8 new translatable messages were found in the just-released
Git v2.38.0-rc1. Let's start a new round of git l10n. Please send your
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
