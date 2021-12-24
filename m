Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED85DC433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353328AbhLXRh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhLXRh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:37:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07ADC061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:57 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so5148125wmc.2
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jgPWFBNDsc2p9VcyREebqFROPhllWgSlBqjR6csgLLc=;
        b=NPrHAy4HsvDb7d9XdsCdBYIJsjlNuhhuScd7dlep/yFj84uQxNAB2CG1tsCFccnLj8
         Nfo6mfDHTPC3v5lDUqd0l2HidozRGPaAhZB98Dz3E/dVw76QVISKo5wrbuJV2bj1mPuk
         uTYqopimKKbS4OKZOGXLubSJvVpW/8UiEWc71u8OKi3BCofzKiGJMxwVLqIJguxbhK0J
         /NJN11IZ9oOwZHrur03qM6vKPGjU4ESq3nD5ZQzTIl8a07mdfLGbbeXfYq1Raa76RWRM
         k3PiWhkodS+ehWZeVWoMb7XGq0U5gWSoJsp76VSajNCSP/LE2OBhBLOTpl3BputoyW/q
         HoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jgPWFBNDsc2p9VcyREebqFROPhllWgSlBqjR6csgLLc=;
        b=HzlpBG8c4iVnMvRTOcRSMuqtJiqSpGRaNSU/kYexPDRMbw1FcrNU9ohpgfcQFh2GQG
         qs+uINDwiF61Mj5HOylebHsthXYrplVfUxH4PLX54MgtyEo2dHPEZB86nKi5xodxS3ja
         QwxI6Lwjs1EFw1JKgkHHeYKI3Ncgjm7dafYNPO41RkyvAL5zkur0LlWxCyeB6ffA37kX
         pLMOJCa0L64cnN572o84GxItg5qfCHdDL4um+3tJP8lWC51oaqOvtHd2eIkNDB8DSfqC
         xGQiQuGnxwLlnro4SvQTLIEOcRTsyQI4x2Bo3rCgzox51O1oirW7ioznYGVxNJSrjHt8
         ZLRA==
X-Gm-Message-State: AOAM532ihm92cvP06xAc1IdHM4cl/3W0BdFXTRVco+1xZ3lptW2aj9EX
        DSJ/V72w4LrUgPizfeyW7W4JGKQpO0Rt2N9/
X-Google-Smtp-Source: ABdhPJwahzyEuW4inohNMjb5j5La5pPQHgcu3pNaoY0nkgfTk1CnlRm37g8rqePki6jDok3iOf7Kpw==
X-Received: by 2002:a05:600c:4e15:: with SMTP id b21mr5528288wmq.91.1640367476178;
        Fri, 24 Dec 2021 09:37:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3sm8033518wro.22.2021.12.24.09.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:37:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] Makefile: disable GNU make built-in wildcard rules
Date:   Fri, 24 Dec 2021 18:37:41 +0100
Message-Id: <patch-v2-2.8-b0c9be581a6-20211224T173558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1215.g6e154b84c77
In-Reply-To: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Override built-in rules of GNU make that use a wildcard target. This
can speeds things up significantly as we don't need to stat() so many
files. GNU make does that by default to see if it can retrieve their
contents from RCS or SCCS. See [1] for an old mailing list discussion
about how to disable these.

The speed-up may wary. I've seen 1-10% depending on the speed of the
local disk, caches, -jN etc. Running:

    strace -f -c -S calls make -j1 NO_TCLTK=Y

Shows that we reduce the number of syscalls we make, mostly in "stat"
calls.

We could also invoke make with "-r" by setting "MAKEFLAGS = -r"
early. Doing so might make us a bit faster still. But doing so is a
much bigger hammer, since it will disable all built-in rules,
some (all?) of which can be seen with:

    make -f/dev/null -p | grep -v -e ^# -e ^$

We may have something that relies on them, so let's go for the more
isolated optimization here that gives us most or all of the wins.

1. https://lists.gnu.org/archive/html/help-make/2002-11/msg00063.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/shared.mak b/shared.mak
index 0170bb397ae..29f0e69ecb9 100644
--- a/shared.mak
+++ b/shared.mak
@@ -1,3 +1,14 @@
+### Remove GNU make implicit rules
+
+## This speeds things up since we don't need to look for and stat() a
+## "foo.c,v" every time a rule referring to "foo.c" is in play. See
+## "make -p -f/dev/null | grep ^%::'".
+%:: %,v
+%:: RCS/%,v
+%:: RCS/%
+%:: s.%
+%:: SCCS/s.%
+
 ### Flags affecting all rules
 
 # A GNU make extension since gmake 3.72 (released in late 1994) to
-- 
2.34.1.1215.g6e154b84c77

