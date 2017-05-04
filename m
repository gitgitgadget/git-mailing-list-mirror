Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611AE207D6
	for <e@80x24.org>; Thu,  4 May 2017 22:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbdEDWBB (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:01:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35057 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdEDWBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:01:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id g12so2691962wrg.2
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ve/JAfBTg8takI/1jr5iZxtAMC8cm218UpTA9JcQDCE=;
        b=RQdAJmJKGth9hKcHytCm4K69ILW0pgUy2pKc1eVK0Ewmg68w6RTisPufTcQZc+1IyD
         QzhgYtlJZ5aaa7J4gZlnClmSdX1qxP7fKBvxS+JFC2TO5sDNMaiQlR/qnff1EEL8ogjU
         h6Yr+Y1sp193gJZ1i7okzroOCkH3m97TdCO4OD+XdUYMt4ZLZIN3wj+oUYGfCAm5UnUg
         M0YEPbRRsg1OBeQlN/PYHnptfOvQNh7GUeS1vhbD+QImaq4OTnwo9BKkbMkZAqjhxJ0g
         bFP8wwkja+J1/uaQGJEtDxkFWaECM1d4rg4UnFTAPi307hjqgNkra2ogleZPAp/Skmzq
         SS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ve/JAfBTg8takI/1jr5iZxtAMC8cm218UpTA9JcQDCE=;
        b=ZY479mPtGLu8rNX10yRr3sKxsLSMCwe2nwnRgiXcxN8RZgErd0wVtDoGojFygxkhre
         mZUlOc3qETSfligdtdFGb62na9Ofr2OlT72IhCxaoDbdXWtYiApEfJaQQv5Al3Ok0EoN
         doqyJTNkJto+W0SG0bslGJY/D++yJ73GiIQPG866XsjcQSgEUbX5G2WBBBqLslwds14q
         6vxgPojk45MfTy86ArfKIoOGwvYVAaRnxg03PpILVEZsa6q1Xc1wYygGIUGVIJL0By8Q
         2xkNMV9TUKZvNkiiDdXDBM6RvT85+4xljIJmdlB06sXPGyy5tyfUjsWAugLRaOLjbK3X
         oyEg==
X-Gm-Message-State: AN3rC/6FvyYlZjuf8wcqMatpekEFFxIZw7SQnoxWpY8zFDamH9nKiswJ
        JnsWI/KMSU2Pxw==
X-Received: by 10.223.174.200 with SMTP id y66mr23609942wrc.79.1493935259010;
        Thu, 04 May 2017 15:00:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w136sm2424680wmd.0.2017.05.04.15.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 15:00:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?UTF-8?q?Ond=C5=99ej=20B=C3=ADlka?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/7] Update the compat/regex engine from upstream
Date:   Thu,  4 May 2017 22:00:36 +0000
Message-Id: <20170504220043.25702-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the first patch for motivation & why.

The only reason this has a cover letter is to explain the !fixup
commits. IIRC the mailing list has a 100K limit, which this series
would violate, so I split up the second commit.

Consider all these !fixup commits to have by Signed-off-by, easier to
say that here than to modify them all.

Ævar Arnfjörð Bjarmason (7):
  compat/regex: add a README with a maintenance guide
  compat/regex: update the gawk regex engine from upstream
  fixup! compat/regex: update the gawk regex engine from upstream
  fixup! compat/regex: update the gawk regex engine from upstream
  fixup! compat/regex: update the gawk regex engine from upstream
  fixup! compat/regex: update the gawk regex engine from upstream
  fixup! compat/regex: update the gawk regex engine from upstream

 Makefile                                           |   8 +-
 compat/regex/README                                |  21 +
 compat/regex/intprops.h                            | 448 +++++++++++++++++++++
 .../0001-Add-notice-at-top-of-copied-files.patch   | 120 ++++++
 .../0002-Remove-verify.h-use-from-intprops.h.patch |  41 ++
 compat/regex/regcomp.c                             | 356 +++++++++-------
 compat/regex/regex.c                               |  32 +-
 compat/regex/regex.h                               | 120 +++---
 compat/regex/regex_internal.c                      | 118 +++---
 compat/regex/regex_internal.h                      | 118 +++---
 compat/regex/regexec.c                             | 242 +++++------
 compat/regex/verify.h                              | 286 +++++++++++++
 12 files changed, 1487 insertions(+), 423 deletions(-)
 create mode 100644 compat/regex/README
 create mode 100644 compat/regex/intprops.h
 create mode 100644 compat/regex/patches/0001-Add-notice-at-top-of-copied-files.patch
 create mode 100644 compat/regex/patches/0002-Remove-verify.h-use-from-intprops.h.patch
 create mode 100644 compat/regex/verify.h

-- 
2.11.0

