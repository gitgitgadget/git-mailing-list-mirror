Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F263C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 05:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBYFWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 00:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYFWG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 00:22:06 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716D6013D
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 21:22:03 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id l15so1616792pls.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 21:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4yNiKVNIXVKdlLLJCJWFvgDNjsH952QjF2u/fpg8kg=;
        b=HM8lY1aiYnR5iSR1N802O9EJlS8R2K6fKDFdnzXy+mzhoJ4dsEgaXp0iUMizjH2k+c
         3AbnJ1tJ0QEm2wrjUlYmxB9oam9MAXkrsxB9PeUxo02kdIsAcFIGgsZt4uJYAvUlWNXh
         y0GuzOw5HJyKCTN9ftf3OyPlZzrJjpnYwar6eFoqoheg8B8PirBIqQXyhmW7JIWd/sJa
         DwnwYyUp/ex7uxHf+Dz46ZkAqNu/5J6x0EWJXG66GowGVP7vB+dlYjTKLmsbTY0cLXVQ
         iyya0b/+ivf/XniLjP2aMnQe+LubaSjjbUVYB9kSenqp85ADltVnxCfzVM2Xue3LF9fF
         UU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4yNiKVNIXVKdlLLJCJWFvgDNjsH952QjF2u/fpg8kg=;
        b=0W1TS3Yh3+yqyLj7qbwbmmbo2LY6Kvs7CWBmfw505aFvAjmqlqUa8wTHDlAxpvDRvf
         QDsnMxyLFqxLT+svYnomwp9+g8RyzBaz8zXOppGZMHHsiXEKw7iILilnotrIuHcNhPhD
         iTtel43BGKssaM9+PPfusxoJI4PrDkvTnhy6zWykhRwf0wzk3QVBXhMemUUmsU2A5bng
         rnajEx4ih05KmeZK8IdBSyJEoqW5as028dZgZxqxQDdzFddAX8TGR57/W901auDLg7aE
         R3XvV7d7V0O/eTDfMbhnJjv39gldVhR8S8geWL1grk0SVcV5Jbg2PNCqxg/ehp5dryZf
         +3qQ==
X-Gm-Message-State: AO0yUKXzdK9qkDHHqMrD+0WNZ1Cuzokct30YImUoUPrvveQnD+Nza+yp
        j7vUrNpBg9Hq78s7wxUTjn1Vt+ZMKP0=
X-Google-Smtp-Source: AK7set9Nai7UBCUNaqQZ2A6pgL7aPrgPH1XNVzN9JHZMgabuKdbz/lJb+iT/tDbLKiTRJSxYQkKxcA==
X-Received: by 2002:a17:902:ce8a:b0:19a:a650:ac55 with SMTP id f10-20020a170902ce8a00b0019aa650ac55mr1885868plg.23.1677302523124;
        Fri, 24 Feb 2023 21:22:03 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902b61200b0019956488546sm344533pls.277.2023.02.24.21.22.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2023 21:22:02 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>,
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
        Yi-Jyun Pan <pan93412@gmail.com>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.40.0 round #1
Date:   Sat, 25 Feb 2023 13:21:59 +0800
Message-Id: <20230225052159.16855-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.40.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 60 updated messages need to be translated
since last release. Please send your pull request to the l10n coordinator's
repository below before this update window closes on Sun, 12 Mar 2023. 

    https://github.com/git-l10n/git-po/

Since git 2.37, we (git l10n contributors) have a new l10n workflow. The
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


** Please note: The update window will close on Sun, 12 Mar 2023. **


--
Jiang Xin
