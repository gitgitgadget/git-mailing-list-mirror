Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9B8C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 08:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiDMI4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiDMI4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 04:56:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A079844753
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 01:53:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s2so1411224pfh.6
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4eiknTXhlhDr5h7Mqs+3ajkdAYgrB/JsRsWvXXNCI60=;
        b=m8JjxjLgwtf4MRYocPmHju67eWVURSZr+pcd6Y1aoAhtEzsAUEarsgqupYj2R5if7s
         40NLLLPAi1qnkGKQomizeGxg8eBfGuCR+/b9yEI2Z3ecNSDdghn+TEofEfq60PqlpXeX
         AnlRgcjyPvZfFNL6BhxgxiiisVQrkFNkDQ5rUVFn5yRG97sjOUn6uZ2eNebQXxgt4eLi
         t1G8GgwhAn5z4O9IkyiwEAaeypjwbOXEaKav5/HXpaB8LWpzN5ic8WQrfB0wjDV9Gvm6
         msIOBgfcHhpUu9vfj/7B0Hi/IBaE1k1Md6wK+58S2Omq9JDiUVcpr+twGNCqR7JQF9TP
         XUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4eiknTXhlhDr5h7Mqs+3ajkdAYgrB/JsRsWvXXNCI60=;
        b=DLCKxe/aDMTGBVF4uDYPaDXZhXwfFkOxITvdIRm9zW5nrY+HENogZaYe++LcrG/I5b
         fUXK2MSqriVbZDsV9EuYaj3T239j2GWNis5o+gBGS4xV0lAjAsKJYgiAcvV1Ly6opVUi
         wr11XGLc4yylmHT2JXyBToW4m8JE9KL8ldxkd3QUZURx8+V0ZwrIsnPg0scJTt3gxaoR
         kbRG1J1OtK3+vrhQf+T8Al7lnI2PXQOfYSgv4uZPyxwb5/97jGEpcFbGg4gMZPJMSG+n
         WT6ked3KO7zY2QiJRNW5fqGzCUn9bWmm73ffPy9tfB+k7ZjShp+P4CQqMhaqYugFQeLG
         f+yQ==
X-Gm-Message-State: AOAM531US/f7fJzLxpkkdIjB2c5TocYEB13JCA6UHzP3S/TBnGXO4E2R
        AB1LCRVMrO5rGjWfcXfUd2NNJVvw/+g=
X-Google-Smtp-Source: ABdhPJyD3VgT7c+YQXjg/n7uvLJ8sfSA97bmhmt9NRi69w70+SBxCUUaB1Fa8ioHdpR44vMhU4qn7g==
X-Received: by 2002:a65:5b84:0:b0:398:fd62:6497 with SMTP id i4-20020a655b84000000b00398fd626497mr33535295pgr.179.1649840031031;
        Wed, 13 Apr 2022 01:53:51 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id mq6-20020a17090b380600b001c6357f146csm2589040pjb.12.2022.04.13.01.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:53:50 -0700 (PDT)
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
Subject: [L10N] Kickoff for Git 2.36.0 round #2
Date:   Wed, 13 Apr 2022 16:51:36 +0800
Message-Id: <20220413085136.4100-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.36.0-rc2 has been released, and it's time to start new round of
git l10n.  This time there are 4 updated messages need to be translated
since last update.  Let's start a new round of git l10n based on commit:

    2731109c91 (l10n: git.pot: v2.36.0 round 2 (4 new, 3 removed), 2022-04-13)

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
