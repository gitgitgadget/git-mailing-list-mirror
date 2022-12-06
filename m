Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB90C4708E
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiLFCJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiLFCJb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:31 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3A7240AB
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z92so18410878ede.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSyrJZ6fjKnxWWuh6XDBUkPT0qMKoS9MYDMXW2LVJSw=;
        b=neRTT6sG79CAjZCRuKRVzT2LbdoM/66C72yZxIs5wh79l597IGXDv1Pf8NF6HFapu1
         FFaDYlZQHhJPQj1Y6at3r54qNq6ES10kGvX3sazJrzsxa2hIlNRt8NrhYObc3YXBcrbA
         YEohRwnF09TL0llf/Ec6ayKvOf7WhJFnJJQLFdP9NxTJIoXKlsYoyChqOeRmaYM87aAA
         to1Nap/kU+oU/tI+qCSX6rKHQo5qydpwQpihocHnmYBctpS6EoxUN4BvZlk4ZAcneHlb
         b63YuM+62n+4SXfimFx0MPchXv7THZbd+G2EHgYUugXSpYyjIVes9wLG0rn+OVpP28sd
         inkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSyrJZ6fjKnxWWuh6XDBUkPT0qMKoS9MYDMXW2LVJSw=;
        b=L0vTbtlYL55mLasjjsOCN0LjFQ/XQShJ7UzsFuNoYJMrlnKiyCXHI2eN8W+TL746LF
         InFvuXNyfJT3/KBFOY1ZghF2/b3OFa380KndLwMK8gaww25Qg1I2tcPtI6yR26zV2Xzw
         RFZFyBXNAQZiudNz37bU7zS5BQdoomHpZXWXH+U25g3y3i2osBVj7vRcMthmtVJt6L5Q
         gBUERF/oXvcKQtWY7yfPU96c0g+c0yNF3APpLz4LGRgecaRY3pCOgv2AEzGcNDKwuLjx
         WKGC0e0EObcWex8p+MRUWIMF8h7IsORB3yRxDKmH+IQlP2xnmTyxpIlymr6yGpQF5A6p
         r0Mw==
X-Gm-Message-State: ANoB5pnXj3My/jnpyO6Q3umPGHV6k2dc8/FaoKnU5T51CSs3ahGdyY8Z
        ekBlXsq73L1crzpSqYnniKrUP614xAC4yA==
X-Google-Smtp-Source: AA0mqf4xWlQKl+AOySSzi2e+sPK0/YUs6pmAUU7isrpYJ5Dux0cMguShkOVsLJykQ10t3ulhMzpz3A==
X-Received: by 2002:aa7:c690:0:b0:46a:e2b8:1be9 with SMTP id n16-20020aa7c690000000b0046ae2b81be9mr40632697edq.182.1670292568677;
        Mon, 05 Dec 2022 18:09:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 01/15] cmake: don't invoke msgfmt with --statistics
Date:   Tue,  6 Dec 2022 03:08:59 +0100
Message-Id: <patch-v6-01.15-fc190b379cd-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1] I made the same change to our Makefile, let's follow-up and do
the same here.

For "cmake" this is particularly nice with "-G Ninja", as before we'd
emit ~40 lines of overflowed progress bar output, but now it's only
the one line of "ninja"'s progress bar.

1. 2f12b31b746 (Makefile: don't invoke msgfmt with --statistics,
   2021-12-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2f6e0197ffa..8f8b6f375f7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -897,7 +897,7 @@ if(MSGFMT_EXE)
 	foreach(po ${po_files})
 		file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
-				COMMAND ${MSGFMT_EXE} --check --statistics -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
+				COMMAND ${MSGFMT_EXE} --check -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
 		list(APPEND po_gen ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo)
 	endforeach()
 	add_custom_target(po-gen ALL DEPENDS ${po_gen})
-- 
2.39.0.rc1.1006.gb4c675778ba

