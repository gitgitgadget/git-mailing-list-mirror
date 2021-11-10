Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE01C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE80B61107
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhKJBmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhKJBmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:42:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FCBC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 17:40:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n8so1675382plf.4
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 17:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lE0iCdqPAVwdyrpYNQoDPD0tjqxI9k5AnLEWPZfR9Z4=;
        b=T4fvrDk0uvsK0Qk8qrUP7uAd9V/1fEiisp2q+uK3puasM8NJVSSCNUn6jU3YuxmMI1
         8H5BWB4FWsLoMoa4Rq3wWudzdDpBJs78oqC7wtx2UfldGlvfzf15AzCrijl83CYmH72w
         STrv7w0y4qE3qdNOhhx0V3xUm5aVP8ZL+r+FwczxRYTnwt72sO52fsbTSFApXpCzN7FF
         YJQGssC8DQ9ElAuXHVMdFOnTR9t1/Ffiq8/aZqTgGGx9guMqGrprggClakIPrJV8jWW7
         7f06WeckFKlcab+xHqBK8sLSzNbQjx12z/5h+npgrS1KuJTk6gnpAppVGiCgHrR/sGb+
         6t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lE0iCdqPAVwdyrpYNQoDPD0tjqxI9k5AnLEWPZfR9Z4=;
        b=M+EwP4S4pmcwzzkmAQLoIZTEG4pqWksCGQzJqC2m5QWJ71rYxZAbWYcRY8zDM9p8/5
         UW97xu/y0bcTFtuSEs4XCz7br/5bW3o6f218Zl3tRqEcUP4tg3O7MHVorXzXAZuDSxUv
         fMB+OgUQoAH/c5x9jL+eEPgua/polWQx7evHeoWOmGrRHzr30boKz4rHh0SSCrbAA1ln
         mpdhwzehaPfrpKZ2SLNPwH1ZCeX2CipXnEgSOANTkvPdYzmKLiSRDzcvKvgSiXfDBQfc
         ifzj/7Z98Mrtywu4VjrLGjZt4JoyfKWrlkEE4wPnKKF/Q5NhGtJl+9jAyeU1ARaMu270
         A91g==
X-Gm-Message-State: AOAM531J877RNv11oRN2EGF1Vs4nPDKPlSpfwy3djbyHAO5hQ99DFbW/
        GtuwUK86Layg+pKERKzpeHxHIWSJUvekUg==
X-Google-Smtp-Source: ABdhPJz1LyTiQZ/dSxj8RhDVF5ZGkxFqb/X4zqpRv4mBWmpvWnY9Vju4P77rnlMzJanr6dcN9jakew==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id cx12mr12301668pjb.11.1636508402249;
        Tue, 09 Nov 2021 17:40:02 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d8sm3910658pfl.123.2021.11.09.17.40.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 17:40:01 -0800 (PST)
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
Subject: [L10N] Kickoff for Git 2.34.0 round #3
Date:   Wed, 10 Nov 2021 09:39:58 +0800
Message-Id: <20211110013958.21993-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.34.0-rc2 has been released, and it's time to start new round of
git l10n.  This time there is one new message need to be translated
since last update.  Let's start a new round of git l10n based on commit:

    d83443820f (l10n: git.pot: v2.34.0 round 3 (1 new), 2021-11-10).

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

** Please note: The update window will close on Sun, Nov 15, 2021. **

--
Jiang Xin
