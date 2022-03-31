Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC1EC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352417AbiCaBsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352378AbiCaBsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:48:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C83488AA
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a1so31595569wrh.10
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGG7OhYfaKxeOAy0gjgHb2xuVNXPya1r0uKKe5l+ID0=;
        b=TodJjskqUs7r/nywohjnsFjj4ZCwtgcZyiDfahUnccHWZqX5/UM47OHRakqruTJlZu
         hlHEeb23p+ZZ1Zo2NwuHYG3Yt29hrqiHW/CJZjBOsqcK0Jpcb+6VGfTnmnYIccPrq2qh
         zF068iIetMQLzYkDdN27SKWO5KVkZOaSWpTf1l9ASLK7Yg8hCKyKnxkyMRdTsixGsUd6
         8bA1PXzq7dLCDF3I+jfjr0lmJqgC2IZVPndyBc7vATmeNsvBgo26c23PaNKNXWSFILg2
         NephGRVNzMERyy+a2HXYikzXyMy/JvbMO5iVF8QidBAbFGDwo1hyB/okix7foblGJplT
         4JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGG7OhYfaKxeOAy0gjgHb2xuVNXPya1r0uKKe5l+ID0=;
        b=2eTCeppNSoys1xiNG0hu7aVqC1i9cYKDwUUrUdKF/3+5365d73mgujqHjK1AGA47gK
         Sks2UnbadDmLnIu/XEcXiKrI+A0Ax6V0tBDmjo64tbRQBuxd0xnVfMbPT2kPrNuzavz+
         5Wnm8QHeqQZdsVmnpzPuP793knGnL2sEMhMPmHB/m7vg/3hIRGXrb7qk17UW+L2b2rmV
         mX35zqwItHIAyVP8+mveMgvMaPhtw2afot96pEZTNozuG85rAgfRhedL+qAe6+bLGUj8
         ZCKSmgyOmYw+QbGH/Yi+y/KDeGFVlYD1SAVeI8svjyK27fhBvE84bXpEYXjWFlLR5lLt
         xnGg==
X-Gm-Message-State: AOAM533C8yoLMOd8yK9pOAwP2xh/2V6QsNNuo8m32fTPUX3w9qzpPQeA
        0Eg/8vXZ7Tkvan6X3yRnx1wJ74sE90uQrQ==
X-Google-Smtp-Source: ABdhPJwNtfobzpm0bP3vOdg5Qzwcs48LKQYQ1v8k+MudOm0PzDVlzjw6sqfHrwg3YSOniBOMrllVAg==
X-Received: by 2002:a5d:59a2:0:b0:204:20d9:a5b9 with SMTP id p2-20020a5d59a2000000b0020420d9a5b9mr1996604wrr.560.1648691171888;
        Wed, 30 Mar 2022 18:46:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm23603272wri.77.2022.03.30.18.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:46:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/6] configure.ac: remove USE_PIC comment
Date:   Thu, 31 Mar 2022 03:45:51 +0200
Message-Id: <patch-v4-2.6-f6125e9f62a-20220331T014349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1561.ge8eddc63765
In-Reply-To: <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a comment about a Makefile knob that was removed in
f7661ce0b8e (Remove -fPIC which was only needed for Git.xs,
2006-09-29). The comment had been copied over to configure.ac in
633b423961d (Copy description of build configuration variables to
configure.ac, 2006-07-08).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 configure.ac | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6bd6bef1c44..789dcde3eae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1189,9 +1189,6 @@ AC_COMPILE_IFELSE([BSD_SYSCTL_SRC],
 GIT_CONF_SUBST([HAVE_BSD_SYSCTL])
 
 ## Other checks.
-# Define USE_PIC if you need the main git objects to be built with -fPIC
-# in order to build and link perl/Git.so.  x86-64 seems to need this.
-#
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
-- 
2.35.1.1561.ge8eddc63765

