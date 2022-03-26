Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794CEC4332F
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 17:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiCZRQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiCZRQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 13:16:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555DC3585D
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u16so14682933wru.4
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUyH4Qw4hoNidtaKQcAE+HZ3wX31UE41Wx4eSFEcQ+I=;
        b=n9+HriEKOqlb8P31hVSKWkogLALVFPS8jHZ87c1VTiHHgdIsWTeu1X7U802tWk784g
         8gvLtptwIVGkyUGSlKt9NL6ToAySTPyyUoc5Kqh0h0u52DGF0Cc5m6Eqbk+0jSXtglxk
         mqf/MoiHE3cLNaBLlzaii/O483/fFFudRFAp7zxlPN/zwJfKwCtDpEagAEOygcoJ6VjJ
         yURQf9TObZkVLya26BEd7TW77NpAvfaaeNfMtrjUVgznRS5ozlR8RE3CEh1WITnXCbHD
         BgwRWY4VeZCmhskih74RXW3xwDZCqAojkAq6XJUWRjyhrO0SgogZei+teFE/oTwB8Xk/
         Is9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUyH4Qw4hoNidtaKQcAE+HZ3wX31UE41Wx4eSFEcQ+I=;
        b=cOm+JImLzn2lPgE3DjB32QyAyElN/QCKx6Z6y7HiwuMazgNbhInKjWLxMgANXBZjR0
         IxwWrKFTDmzH0e2InN4Sq3W+Q29dqkGsV80l7lqW+9o4OYfTU5GXbinYYqdnqFEGnfij
         nThnD/qkFdre8sbaNF+Ntc0s43Yrnn3qoDr1+X+b+g4H584WCyTp2km/5EvsvRjoysD+
         TRU9eXhYpobTqVrrm6qvL+/HIoGJE++reLb/Utu23F5V9OAMCm9UgoA0gsZ/jZLJJbJc
         ncA5+xBpARvXOKGfpfsAcikpaEDKnLBKH7CnfBYYAMpRdwWLjv3rqUb/zbCRXhicjoCc
         24bw==
X-Gm-Message-State: AOAM533CupuTuCNwOM/GKJittsRJ+r8/5VcywhxMCHTmJktCWbos3ANg
        jdXthysEp3Q8qnAevLe7s89CDkqzRe/MlQ==
X-Google-Smtp-Source: ABdhPJz3sPe60UpgAzCGYbn9JxNOHu6u3LXJcqO7CkWsdJTy7kBv3CK0yzLvXwuJXeppha9XB1Qdog==
X-Received: by 2002:adf:ed44:0:b0:203:f01a:8823 with SMTP id u4-20020adfed44000000b00203f01a8823mr14401151wro.715.1648314871502;
        Sat, 26 Mar 2022 10:14:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0038cb924c3d7sm7805913wmq.45.2022.03.26.10.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 10:14:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/7] configure.ac: remove USE_PIC comment
Date:   Sat, 26 Mar 2022 18:14:14 +0100
Message-Id: <patch-v3-2.7-93dc689e1aa-20220326T171200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1535.gf8d72b9da1e
In-Reply-To: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
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
2.35.1.1535.gf8d72b9da1e

