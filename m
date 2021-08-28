Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36552C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 12:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE3860EAF
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 12:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhH1MW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 08:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhH1MW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 08:22:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139FEC061756
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 05:22:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v123so8145482pfb.11
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 05:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+Ev408EwTlFT4C3RKMK1/47GpEKHPPZ4+wRZDOWzGw=;
        b=lrIIC1oHcnebREirnL+qiXu8JqJK2goBULUeTZO9JF6a/SkihsTmk8+M1gSXFl51OE
         dKifpNE37a0sDv1blzbjckWTxtTi/ciayvgGTA2hJcVflydkNY2ZmhnchFsoC3QTvwA1
         ywUMorkZZRYnYYxS4Hb81zeGbzKM6AE7X/iYghH5Nn7YQluZ6cTz4h6xPqvwkt9eR2HB
         22n0YOf1Hfb8OH35l91eZGbaklCDx/GTiz7+vQj1jbEUYue+hd7oV0aoqJ30naes57MN
         NU+qv8gZWpawVVfNF0TA8VpVK87qB0a6UCW6+8dYW/aNBVr+mF9oMVCEgjZSqW5rK8kk
         TCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+Ev408EwTlFT4C3RKMK1/47GpEKHPPZ4+wRZDOWzGw=;
        b=FTiat2ldFfUCeECDctRB2OZg5XmDvmz31/ryDNWwiB5a2BKMAI8mlpySPlrDR//249
         KMIeZ+92sclFpHCso1vlMzRkf3SKEy2cGzzzahrlc7Pw87Ex/sRjVQ//4oyFvbzRSqj3
         Zj5NCcvMvsBP6ibqQolCxMWe7lLNhFJwt7M/VDFi/07sbwnvk7JuofTkkfHogun6TaEt
         B2mCtwuWiu+3XpJqycqIoCMLFkCX83RkppzZ2aHio7FHoRJZnd9hCwBmBay0+Hcsuorh
         LviKYpvFZXou2LsBeUQpTEjFYm2M06OQk5DVb8eqMToi68/ITIOnwJF9RC3lpvYqMcMK
         Sqdw==
X-Gm-Message-State: AOAM531kvo8viyEDSU2qxUj46E/c3TENU18Koa+CgIA9zuB4i7nDqC70
        +ForNVdLGdsJDjSLW6RsWNbx5l4GkgE=
X-Google-Smtp-Source: ABdhPJwFR8czGOXt8ECuM4peEPZkodUx8E3/E2/mpHtu5cmLaoglusqB3kUY5gQDWmdoQZfZZvStVA==
X-Received: by 2002:a63:1b60:: with SMTP id b32mr12159123pgm.422.1630153325287;
        Sat, 28 Aug 2021 05:22:05 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id s16sm8855972pfk.185.2021.08.28.05.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 05:22:04 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, felipe.contreras@gmail.com,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] make: add install-stripped target
Date:   Sat, 28 Aug 2021 19:21:19 +0700
Message-Id: <20210828122118.56283-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the target that install Git with stripped executables.

install and install-stripped share the almost-same recipe, with the
difference only on passing arguments to $(INSTALL). In order for this to
work properly, installing all programs ($(ALL_PROGRAMS) and
$(install_bindir_programs)) must be splitted into compiled programs and
scripts install portion. For compiled programs, pass $(INSTALL_OPTS),
since stripping is only meaningful for them and not scripts.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 Changes from v1:
 - Share recipes between install-stripped and install targets (suggested
   by Junio)
 - Don't delete 'strip' target. There may exist scripts that depend on
   that target. Once this patch is integrated, deprecation notice can
   be displayed when running the target, but it is done in separate
   patch.

 [1]:
https://lore.kernel.org/git/20210826113824.50078-1-bagasdotme@gmail.com/T/#t

 Makefile | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index d1feab008f..73a97d952c 100644
--- a/Makefile
+++ b/Makefile
@@ -3004,7 +3004,8 @@ mergetools_instdir = $(prefix)/$(mergetoolsdir)
 endif
 mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
-install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
+install_bindir_xprograms := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X))
+install_bindir_programs := $(install_bindir_xprograms) $(BINDIR_PROGRAMS_NO_X)
 
 .PHONY: profile-install profile-fast-install
 profile-install: profile
@@ -3013,12 +3014,21 @@ profile-install: profile
 profile-fast-install: profile-fast
 	$(MAKE) install
 
-install: all
+INSTALL_OPTS :=
+
+.PHONY: install-stripped
+
+install-stripped: INSTALL_OPTS = -s --strip-program=$(STRIP)
+
+install-stripped install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(INSTALL_OPTS) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(INSTALL_OPTS) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
+
 ifdef MSVC
 	# We DO NOT install the individual foo.o.pdb files because they
 	# have already been rolled up into the exe's pdb file.

base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
2.25.1

