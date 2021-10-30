Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D6AC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 02:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F656103E
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 02:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJ3CLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 22:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJ3CLw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 22:11:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E58DC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 19:09:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x5so1739774pgk.11
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 19:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svIAQY2+i76VA9qryNqLQ4zICQVVTdoRRPS1ciwNeJA=;
        b=iGLD0ghBmCHn9VfHWJanh84laMSzkUDG8SdM8gTfKIT2m/XaRFbWbMocPvEPTde7zo
         v54LueaG1r7Jfkc0NfSFIpCNk65+dH8BxgI/Xzs3v9ikGNTxD1jP3dEXarDZ25Tp0bkB
         Q4wnf5uLx/Eyc1ZROuR0cMAAVFc+Hv7kkjonYKkT4QM4RU9ymmSHB5nGZURJ6wDj623i
         RN2mK8bnpIBjj6eFO7R0qqZ+nGkTiDQomJSGd2Uc5BJFVJqoW85MZtv5LHlIwTLuanPr
         41/O/kccrz9VqBEbCbb2nHxMcpPbXo1Uml2dBL/BATOGgpiLsVezSKizuS5wwNfGsNIv
         PJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svIAQY2+i76VA9qryNqLQ4zICQVVTdoRRPS1ciwNeJA=;
        b=Nigs2ymVv4O79RGkP5S99zJDnjaQJloyHmSVJtWfSbbvVhhYL1VoIfT0fK5CKyC+u3
         Wn8hClbfVq2X6W1wp6JqDyUyrNq94IrxowulsB//fngbvS2XSQeco48uUaau7afCU2bl
         fnLhFH/QO7lEgilZv3zJSq7fcxezn2/u+96lQYJeRRni9q5UCx8O6TQz0u4sVuQgRGF6
         aRKNFN930stZ8LUQDAbVZ03UezCDIa4YjO/QOgX4XwdKqDKCl/oezGdeVp7OSzkW0Y30
         bXTV0lkrR7yQjKruoWADCgFrqRwNZLk9gVQ5E9mmTeM2KvF6/hdfgqMDSw8xNloVWeCV
         Ah4A==
X-Gm-Message-State: AOAM530YXnm4kbhsP+CzS08xAiD9dsA5eJnJ6ndEo1PsX1SDNj8lkVB1
        7a+22sV7AZPGbbXEAgfMjIQA3obHG7k=
X-Google-Smtp-Source: ABdhPJxNaXSdPQKOiyiCXxvX8v9sIas91IyElYv2vxY6otJsM8y88juJ4MQDO+05AdhWNjjp13lghg==
X-Received: by 2002:a05:6a00:1709:b0:47e:66f7:1d13 with SMTP id h9-20020a056a00170900b0047e66f71d13mr8278473pfc.36.1635559762824;
        Fri, 29 Oct 2021 19:09:22 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b13sm12463148pjl.15.2021.10.29.19.09.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Oct 2021 19:09:22 -0700 (PDT)
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
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.34.0 round #1
Date:   Sat, 30 Oct 2021 10:09:17 +0800
Message-Id: <20211030020917.32132-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.34.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 134 updated messages need to be translated
since last update.  Let's start a new round of git l10n based on this
commit:

    l10n: git.pot: v2.34.0 round 1 (134 new, 154 removed)
    
    Generate po/git.pot from v2.34.0-rc0 for git v2.34.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

There is a helper program hosted on https://github.com/git-l10n/git-po-helper
for git l10n coordinator and git l10n contributors to verify their commits.


--
Jiang Xin
