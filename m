Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197F4208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 17:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbdHURoB (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 13:44:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32999 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbdHURoA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 13:44:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id 30so6610048wrk.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVp7qiSWroMxnhSYqg7WvdUMHN1yo6Xa1lTML0DLwvE=;
        b=lAtqamva8ZcrRUF+h0c9BzjZT5xQ9ZV+DOcfNT3jHKRHZ1KDivl9ndJ2GdaHlxi7T1
         LYoJPOVCnrZ5gRave7A9nHo5+2Udpt4gbi/95Ej92oSBqWHb0xvL5dFnpH/wy9OKbXyl
         kb2QMat2Z1OrpgxBy9B9MTtNvy2NcbmkRauV1b9i5Q06VabSZMO5lLxyCWdP0EjikKt+
         x9ooQyS4yfsNGrqs5l6toITbt+zrXoXExKCrG5KQsAImsMvAY1QsPIxqGiGacgYD+4Fo
         88e5iIOj5IMJF21CY8xySfB6/9YRpbwq5IJvMS/B1stKWgZAWkTItZEjnU78xkKxakOk
         dxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVp7qiSWroMxnhSYqg7WvdUMHN1yo6Xa1lTML0DLwvE=;
        b=E7PyPqabGPZELMoR9VVq9x9+H6+qKtDYH/26YbkSlwkYT7BS3OVMPu6zAjPhL1ldjX
         mgHcTBs3775TPfix+isvJuNlCMKRxrv6jCW6Q933Gruw8OdPSE7F5HSPX0ZAKGnOptD2
         X3Zy759FuFYkgzjHJs+3eE/iRGpZQt8ED7sG7Wd4gDKC5O+8Ws6/PCYK+EvPivYmEgX9
         qMIZsfSBAWyakvDsYJsC+sRTwatBgvokCpdSoZSUaoiDka/o5kWE4Dk89TlJnqSh0fdO
         OiBcaBD7M2OYug8E8Ust1+T2Cyzb9fnHDsyVKWeu0+qk00mIMvYStFrR17fFExU4QZ+N
         NxuA==
X-Gm-Message-State: AHYfb5ivOZMNrdb2xUItU74ZDqPrC5PkNkubukB9CF5731+w72p+D17V
        VKu6j3gMhnDTnBGqL9s=
X-Received: by 10.223.136.104 with SMTP id e37mr6672779wre.152.1503337439213;
        Mon, 21 Aug 2017 10:43:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id y8sm5942458wmg.12.2017.08.21.10.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 10:43:58 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/4] Some ThreadSanitizer-results
Date:   Mon, 21 Aug 2017 19:43:44 +0200
Message-Id: <cover.1503323390.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1502780343.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second version of my series to try to address some issues
noted by ThreadSanitizer. Thanks to all who took the time to provide
input on the first version.

The largest change is in the third patch, which moves the "avoid writing
to slopbuf"-logic into strbuf_setlen, and compiles it unconditionally.
Patch 2 hasn't been changed. The others have seen some minor changes.
The patch introducing GIT_THREAD_SANITIZER is gone.

The end result as far as ThreadSanitizer is concerned is the same:

1) set_try_to_free_routine, where Peff outlined some possibilities, and
where I don't feel like I have any idea which of them is better.

2) hashmap_add, which I could try my hands on if Jeff doesn't beat me to
it -- his proposed change should fix it and I doubt I could come up with
anything "better", considering he knows the code.

Martin

Martin Ågren (4):
  convert: always initialize attr_action in convert_attrs
  pack-objects: take lock before accessing `remaining`
  strbuf_setlen: don't write to strbuf_slopbuf
  ThreadSanitizer: add suppressions

 strbuf.h               |  5 ++++-
 builtin/pack-objects.c |  6 ++++++
 color.c                |  7 +++++++
 convert.c              |  5 +++--
 transport-helper.c     |  7 +++++++
 .tsan-suppressions     | 10 ++++++++++
 6 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 .tsan-suppressions

-- 
2.14.1.151.gdfeca7a7e

