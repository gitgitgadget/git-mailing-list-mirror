Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D20D120954
	for <e@80x24.org>; Tue, 28 Nov 2017 21:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbdK1Vc1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 16:32:27 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34950 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdK1Vc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 16:32:26 -0500
Received: by mail-wr0-f194.google.com with SMTP id g53so1485757wra.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 13:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2G9JtrIqwWcDIMT2V2rIvsW6UYAvx0X9pUa8GUVQVss=;
        b=pNHwIRdqDfNt57tQHyjjOU9s85/zYYz93deXPFzso6iudFoGRfycpsgGA2Jhjo/iej
         KHJO37fsFkm0DAotddz2eNAiCq/OEOe7ZOUdICOlNQQh3CSJTCeHFLpBJumwQTN17cs4
         74J1VBe5cKoku0npzW5otfQ71kfvIuiBnuONfXxRumw/YBB/OipiV8MbWHHygTWt2Lpz
         faoFUhbvzYhJUHNUMbjNjACSFF6P5/Fm5JwokVjEfvyFiGJBgV1ckCmecTU3ikFpJ8c7
         o6YNvJM5n/PGtnHeTbztYjt5g0Wacwu+/x/yjC19M3j20me9TFsUtXzgY4rxA17iTT+D
         sySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2G9JtrIqwWcDIMT2V2rIvsW6UYAvx0X9pUa8GUVQVss=;
        b=sQ42D8p6J0JEkqYcW3ds9yhZ79XBcWnIyvOFtF29LZOBjxSHw8oC6uOaxcwzkehuIA
         lZ5G6dpcNrIEqSygRVK/nQspQSWk49++FQE1O/PIlJ2Vr/DHCSVGR7FdjZL7o6m+asmk
         YzsR/83NtZJ6HyGzxn7L3XFT9M0HM0NhYNPrucFI0MpQjFYFMnb/cAEfK8ymmXqAOViX
         h0ejsMHo3JE2TEVcDLwQbPKbRj7QdF+0IGpuz1UX7BU1qDJVzADt4QvOEky/SqkoFWJo
         srQ6XQkGy2fv750QZ+P9ojh/h84eV+wY7fuHjsocBaL7MCXGkwFeGjtAXuehQe+WOrAO
         kd0g==
X-Gm-Message-State: AJaThX7CgKtDSBazEAHEOMln4uz8ENveQj08m1tHtNhh6GCBVyfw2wEp
        B71eAbOOTl29jBFDKH/zXrNc+jye
X-Google-Smtp-Source: AGs4zMYSPb+R0xEJQFNPflsIQDXgZ08exQlKaWw4dRx26jt6FFSmtH4pAV6EIJpf/oEXm889pASiMg==
X-Received: by 10.223.151.49 with SMTP id r46mr482982wrb.238.1511904745371;
        Tue, 28 Nov 2017 13:32:25 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d18sm147361wrd.54.2017.11.28.13.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 13:32:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] SHA1DC fixes & fully moving to a git.git submodule
Date:   Tue, 28 Nov 2017 21:32:10 +0000
Message-Id: <20171128213214.12477-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've now had a couple of Git releases where we've used
sha1collisiondetection/ if it's checked out, but have gracefully
fallen back on sha1dc/ if it's not there.

This series makes it a hard requirement, without 4/4 you'll still be
able to do NO_DC_SHA1_SUBMODULE=UnfortunatelyYes, but with it even the
ability to do that is removed, i.e. we're fully on the submodule
(unless you have it as an external library).

1/4 should be destined straight for inclusion since it's a bugfix to
the existing logic, and 2/4 could tag along with it, but none of this
is urgent, so I'd figured I'd sent it all as one series and see what
people think.

Ævar Arnfjörð Bjarmason (4):
  Makefile: don't error out under DC_SHA1_EXTERNAL if
    DC_SHA1_SUBMODULE=auto
  sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
  Makefile: use the sha1collisiondetection submodule by default
  sha1dc: remove in favor of using sha1collisiondetection as a submodule

 Makefile              |   29 +-
 sha1dc/.gitattributes |    1 -
 sha1dc/LICENSE.txt    |   30 -
 sha1dc/sha1.c         | 1900 -------------------------------------------------
 sha1dc/sha1.h         |  110 ---
 sha1dc/ubc_check.c    |  372 ----------
 sha1dc/ubc_check.h    |   52 --
 sha1dc_git.h          |    6 +-
 8 files changed, 14 insertions(+), 2486 deletions(-)
 delete mode 100644 sha1dc/.gitattributes
 delete mode 100644 sha1dc/LICENSE.txt
 delete mode 100644 sha1dc/sha1.c
 delete mode 100644 sha1dc/sha1.h
 delete mode 100644 sha1dc/ubc_check.c
 delete mode 100644 sha1dc/ubc_check.h

-- 
2.15.0.403.gc27cc4dac6

