Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6015C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiBXJdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiBXJdl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:41 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58064269A8E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:12 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso3092140wms.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jBbpFIusfbY5LFX/yR/vscKWuRQlTdHd8ZV89bK1PhE=;
        b=JnASP3cv/ZbvBBsjHIH1vN1s7p3iOIR7ITMp0kCJ2Wo+F//zb7pdfzyfoeEo/KcmTa
         s46UR1m6nfGA/qz5aJH8l648eoKGs4ZxlWCuMapPxeBM0DtTLArQ7Yz/iOdL117Z+K62
         ATlnYvW5nFhlSUhJXQDNYo/eI33XOU0K1v2lOsbOwRoQvb4gRI2KxOHJKInOP4gLCwas
         ZakaNM2OqwK0WyORlPd21VMCO4JE2tU2BlO8vWzy3GEUCU/01Vqqh+jF1ofaozvaxquh
         E4CR7GPvd3a1MfPHfnnVWBgiY/UJ834GBhkHEasIAZbRRm76V85atV3lbVOzYg2y0qO6
         YISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jBbpFIusfbY5LFX/yR/vscKWuRQlTdHd8ZV89bK1PhE=;
        b=IKEuQJnUr3ATvQKgT/vqfUD6MFSJYWNM0eRBLSvSY4YT4SZ0+0Ei6eNlaa0UzIoE7c
         due9pa1BD9Tk+pmgNe+68cCm3eWO2dqrCLwHYo5q+s+wWa0XnYP2Fva4exVEQPaQUmjW
         s7lMavINV1XlFi38Ll4ZtiqbWYolQ4/9gV4xeM17t1Pm0E3Uino+m4sQiISgMF3zt3mh
         Q+7iAwHlO8S1nJM0eDNidSkAaab1PYOkNAOwr9xS+jyrg2OW5XGGoEtODkGbtsbWfKGm
         +IHw9KdbOUZ/B214Sti9DJ0nkYXbfg5l3NhGnNaIyE9XIm+8K1n7+3J/Xxvn9tl9voRR
         v3TA==
X-Gm-Message-State: AOAM5318Oes0dcLOPNk1XCdB3W1hcnQYFpoGf7+DoqKL2+lFvHpuFt0s
        RpfUqo1jaSUYgwTLgP5obGLF697ak8s=
X-Google-Smtp-Source: ABdhPJyDujQ3Yq7qNLomBcnCEXgx8ynZ3nEQUrnv6AfKtFQeWqd+d5vAfc9yE5b1J/kYL9x0mIMg3Q==
X-Received: by 2002:a05:600c:22d2:b0:37b:c4bf:c6d5 with SMTP id 18-20020a05600c22d200b0037bc4bfc6d5mr10610491wmg.125.1645695190582;
        Thu, 24 Feb 2022 01:33:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/12] c99: use more designated initializers
Date:   Thu, 24 Feb 2022 10:32:55 +0100
Message-Id: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up to 404c4a54624 (Merge branch 'ab/designated-initializers',
2021-10-11) and a4b9fb6a5cf (Merge branch
'ab/designated-initializers-more', 2021-10-18). These code readability
improvements are something we can allow ourselves now that we have a
hard dependency on C99.

These changes merge cleanly with "seen", so they should be easy to
deal with as far as anything else that's in-flight goes.

Ævar Arnfjörð Bjarmason (12):
  imap-send.c: use designated initializers for "struct imap_server_conf"
  refs: use designated initializers for "struct ref_storage_be"
  refs: use designated initializers for "struct ref_iterator_vtable"
  trace2: use designated initializers for "struct tr2_tgt"
  trace2: use designated initializers for "struct tr2_dst"
  object-file: use designated initializers for "struct git_hash_algo"
  archive-*.c: use designated initializers for "struct archiver"
  userdiff.c: use designated initializers for "struct userdiff_driver"
  convert.c: use designated initializers for "struct stream_filter*"
  refspec.c: use designated initializers for "struct refspec_item"
  misc *.c: use designated initializers for struct assignments
  misc *.c: use designated initializers for "partial" struct assignments

 archive-tar.c           |  6 +--
 archive-zip.c           |  6 +--
 attr.c                  |  2 +-
 builtin/fast-import.c   | 14 +++++--
 convert.c               | 18 ++++-----
 imap-send.c             | 12 +-----
 notes-merge.c           |  1 +
 object-file.c           | 87 +++++++++++++++++++++--------------------
 refs/debug.c            | 55 +++++++++++++-------------
 refs/files-backend.c    | 62 ++++++++++++++---------------
 refs/iterator.c         | 18 ++++-----
 refs/packed-backend.c   | 56 +++++++++++++-------------
 refs/ref-cache.c        |  6 +--
 refspec.c               | 14 +++----
 trace2/tr2_tgt_event.c  | 64 +++++++++++++++---------------
 trace2/tr2_tgt_normal.c | 64 +++++++++++++++---------------
 trace2/tr2_tgt_perf.c   | 64 +++++++++++++++---------------
 userdiff.c              | 36 ++++++++++-------
 18 files changed, 299 insertions(+), 286 deletions(-)

-- 
2.35.1.1157.g524e2d5a0db

