Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16FDC1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbeCYS2d (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:28:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45205 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753472AbeCYS2c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:28:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id u11so4405546wri.12;
        Sun, 25 Mar 2018 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JfYK0bN3arTZZU38+9k+ugJpeU8FAK2KD5kU6sc4txg=;
        b=iPjWv06FXK80QXxV8kt4k4oRSL4bqSAPRSkHaWl6s5MDVzCF7heH2DcaKgbsQzAlVE
         J0O+32LZuFEKXZT9i44SvBzoB0nyEP6oVlIpEq8lzyU5U+iztbTfqdvOUdrcSBveICQd
         bo4Qn9rpyVeKGfc5PoCbTWSdYALbmxZVXFvyzBvtsfiMIaaxeOusmggmZ0Dz9YmaEDyP
         GHt/VtWnHm0BbRCO/4kRTizq3TbMkodabykQo30SOfA2uDT/ArXo4+Teo1vFdEVW4RUp
         bGdYKEYRrPZ+8mlEcsaqFrPnlYFt0CoEyjO4JMe2Z9N/nNdiLoBmzGp/RG5x19mnds+o
         cyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JfYK0bN3arTZZU38+9k+ugJpeU8FAK2KD5kU6sc4txg=;
        b=BgsEcLA7vm9fdPm5tQxIvM9e0YZw+4SbQzsXpk1LIUxyYH8IFPd206p2Zo1TivW4qJ
         FqCeMEclb5ECLKg4w0VSH009Mefi8P/qwrVw2NhiLmBnbWarAvGAIaeCi0Tf/nppCz0L
         k5NfO30HqL27BQwGdzipaCz7Y7R0SBgHBSoEoUQbpKW1aNnijrdHwh+xaQ8eLWHjl8GJ
         iBKtyEmRpqSb3ItF4RTvwHrVlzsiYJgpuEx62yExd4evhwRADbNoIrWaaIF+/cvbqxwZ
         /VuWWXv5vbsMfd+bDnr8ltp3PtaSmn4tHZGaw8i57zAsZSphqoxTtAy/Kk0pbNWc15p9
         cnIA==
X-Gm-Message-State: AElRT7Ep3z5KiPwhXx1eXLMp+V9L98WoPfixg/GCmULP2wbUOfyBOi0E
        YfSQeUZkgbM5IQTeWjKFykpjP6if
X-Google-Smtp-Source: AG47ELu9w6p9mAQb6rhLAeSgTzTIh5Y0W/+G0tmmffEWeIS2YHzsJWMDrvBIs/MtaSRtp94e65K4VQ==
X-Received: by 10.223.171.164 with SMTP id s33mr30061265wrc.181.1522002510721;
        Sun, 25 Mar 2018 11:28:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x10sm14451762wrc.64.2018.03.25.11.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 11:28:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] send-email: impose a delay while sending to appease GMail
Date:   Sun, 25 Mar 2018 18:28:01 +0000
Message-Id: <20180325182803.30036-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.37.g46b2b28759
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GMail doesn't sort E-Mail by the "Date" header, but by when the E-Mail
was received. As a result patches sent to the git ML and LKML (and
friends) show up out of order in GMail.

This series works around that issue by sleeping for 1 second between
sending E-Mails.

If you're on the LKML and wondering why you got this, I figured
feedback from the other big user (that I know of) of send-email would
be helpful.

Ævar Arnfjörð Bjarmason (2):
  send-email: add an option to impose delay sent E-Mails
  send-email: supply a --send-delay=1 by default

 Documentation/config.txt         | 17 ++++++++++
 Documentation/git-send-email.txt |  4 +++
 git-send-email.perl              | 15 +++++++--
 t/t9001-send-email.sh            | 55 ++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.16.2.804.g6dcf76e118

