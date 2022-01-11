Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54F6C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 06:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiAKG0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 01:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiAKG0S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 01:26:18 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB47C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 22:26:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c3so15627030pls.5
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 22:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYacLx5D18jFFexLk9xPqjMCp/k4wnpwJi2Wapana2g=;
        b=Lhb8VA7rXe7MQmjZ++9feSPcUgDGuW2+hpeV5f3xTEDhylXjDtxJxhOpXq3/227yfp
         d8Mr5BlR9Y9KULcpj0OIEXXhpoyOyflv4GrAgeBICspB09yj//iUh30vrmmawx3/2VBW
         xncKaJrjqzr1NnzI6c/SwNSE6bdQcNx9DnKYdLUCh5sBG/naAUHjRRGadxhrj6xyD8ah
         Li+m1gp/5dibPe10ynWEup6J3TEHMnurMfa3HZ2yKzVaQqBwcokV+pwtgQpcADognUpv
         UEg0QomCOd8M7gols3H7DYN/oMrqgEkjcm5aodBEZVlZRv40fnBriI5eRIYuvxMAQPzJ
         4Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYacLx5D18jFFexLk9xPqjMCp/k4wnpwJi2Wapana2g=;
        b=n3vHKF0eDnakPiA2jIFpicVArM3WVFE/T/TWjyo0hQ2jwsswLzEGNmJCAgo+FZYt2L
         n3gMlJNi021WGVYmMt9gYd5KFUbyI9VWipn1NoWWHvw9u1y80UoEKvB5Ssk7cCJ22wj0
         V7OAbGg8+ixCSQwehJKpfamwwdz29+LHeD6I0ERJYicrjc53gtCZggjJmQT5x6qau6Fl
         gu/lzQmTrNVVfQjUL2J7FZKEQRdx2jKYuFyQcWZYSeecbmJb3JXFY57KpB5SsF1uUGe6
         Vz0eltxfxoPY4kNcBxNV66lFmqwB3i+KukaUrGairTxBNXL5W5TAGRliYacUa7gkpbDG
         AGCA==
X-Gm-Message-State: AOAM533h3BwJQfxTXlYCXH2L94oWT107ef8baNFKT70mhi40P8xmF71a
        F7oVRxVuVQIdZjUFMonIjzhR3z7dr2Nl5A==
X-Google-Smtp-Source: ABdhPJxiH2/IFjKW1dzeLiflHLBwHP0aM4voy16tlpxZzuzEydlk2QEFmx/QuY7kPEV0vOrWmQ4nJw==
X-Received: by 2002:a62:154c:0:b0:4be:d3f9:c329 with SMTP id 73-20020a62154c000000b004bed3f9c329mr3176757pfv.2.1641882377685;
        Mon, 10 Jan 2022 22:26:17 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id m19sm9119627pfk.218.2022.01.10.22.26.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jan 2022 22:26:16 -0800 (PST)
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
Subject: [L10N] Kickoff for Git 2.35.0 round #1
Date:   Tue, 11 Jan 2022 14:26:09 +0800
Message-Id: <20220111062609.23926-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.35.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 126 updated messages need to be translated
since last update.  Let's start a new round of git l10n based on commit:

    79aed79241 (l10n: git.pot: v2.35.0 round 1 (126 new, 142 removed), 2022-01-11)

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README.md" file.

You can also keep track of the changes in the "po/git.pot" file from
the "pot/master" and "pot/next" branches, and prepare for translation
in advance. See:

 - https://github.com/git-l10n/git-po/blob/pot/master/po/git.pot
 - https://github.com/git-l10n/git-po/blob/pot/next/po/git.pot

A helper program hosted on https://github.com/git-l10n/git-po-helper can
help git l10n coordinator and git l10n contributors to check the conventions
of git l10n contributions, and it is also used in GitHub actions for each
pull request for "git-l10n/git-po" repository.

** Please note that the update window will close on Sun, Jan 23, 2022. **


--
Jiang Xin
