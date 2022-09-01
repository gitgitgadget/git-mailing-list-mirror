Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE02ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 13:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiIANUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiIANTq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 09:19:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CB62BDB
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 06:17:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h1so9005196wmd.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5B1JV1EUdUxCgvBeGA4lHjx2PsPKYxFk9x5KAuelL5Y=;
        b=TKK8mqoEr0hEJU8ke+fBN79cJYhq+iNLMewu8WI7bJpjsu7VAYZLpCU1AdrJsfEdrc
         KmuL3Elw6tLEHXb2vlqCZ5n2DzfXmHezj1vbqPgifcV3uIESIqEjmJYXUO1f8l1ByeC2
         z94Zl3ow8NuTcq7JkuiyZt6np5cM6i8xHL21G545B/99XIQhKv4XSZNfrJRoK+918dMP
         lmRFqb2v/T9E5OidbKtxD3YiHjbtkDRBVPqIXx/veXthJhawJlAtsl5TFiSjASsYh8hM
         en0SevGIHGC0OwoRCumq9IwxsuwON8X02dTm0Vlpa6MRisUSITVJGvsyhJ6kaQ0pYrTW
         /Yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5B1JV1EUdUxCgvBeGA4lHjx2PsPKYxFk9x5KAuelL5Y=;
        b=iP4OMPacCGzXHnuSKnps5Lx07HOAJBie+tEEA9IzbGuD1lUvStGgGhNZgn0o0Oz0Or
         INOZkDVpDHsVTs28KP68uqLyE4jJOIklFaoMsBNs5/0F4SqI9eOg8KTXsBvVwYuiBtpS
         FQhPW2HABXaiLe/uaSbN/vtIp/0sFTF8lGQKzN3Nrx4hsMpuxqlt6/vukkGXO62NKfV6
         VhI5xteWrSK29j2yiC8cun6jbpcVHNpElwBgM9VJ/98fWpWpHyIDuXfH6lXQCzJGjLxz
         21lLFQClGpUvbdPu2BOxaGs/7u+RUDCkAjkxK0bOo4t3teO1g+FDD1MIgkw84lCKgQCE
         Z9bg==
X-Gm-Message-State: ACgBeo1AyGezhatiSH8j1prkNLDdXDpO+QzXFq5Yd6HzAzH6tgtGzzV3
        FC8iSgoBXaQ8t53QYByDG+ghqTjz58itdw==
X-Google-Smtp-Source: AA6agR71f5J99uFl43mDUGaA3vAzetDTtBQhRe2GiSwWqtplhfnG43CCrNwboglBHOnacxTerlL90A==
X-Received: by 2002:a05:600c:1e8b:b0:3a6:1a09:2a89 with SMTP id be11-20020a05600c1e8b00b003a61a092a89mr5031301wmb.108.1662038255304;
        Thu, 01 Sep 2022 06:17:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00225239d9265sm14816089wrs.74.2022.09.01.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:17:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] Makefile: define bin-wrappers/% rules with a template
Date:   Thu,  1 Sep 2022 15:17:27 +0200
Message-Id: <patch-4.5-a6d626a5ee1-20220901T130817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1426.g360dd7cf8ca
In-Reply-To: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
References: <sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr> <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eliminate the copy/pasting among the three rules generating the
bin-wrappers/% files by refactoring them into a template.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 96de9e55864..533858ca481 100644
--- a/Makefile
+++ b/Makefile
@@ -3071,23 +3071,18 @@ sed \
 	chmod +x $@
 endef
 
-BW_BINDIR_PROGRAMS_NEED_X = $(BINDIR_PROGRAMS_NEED_X:%=bin-wrappers/%)
-BIN_WRAPPERS += $(BW_BINDIR_PROGRAMS_NEED_X)
-$(BW_BINDIR_PROGRAMS_NEED_X): wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,$(@F),,$X)
-
-BW_BINDIR_PROGRAMS_NO_X = $(BINDIR_PROGRAMS_NO_X:%=bin-wrappers/%)
-BIN_WRAPPERS += $(BW_BINDIR_PROGRAMS_NO_X)
-$(BW_BINDIR_PROGRAMS_NO_X): wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,$(@F))
+define bin_wrappers_template
+BW_$(1) = $$($(1):%=bin-wrappers/%)
+BIN_WRAPPERS += $$(BW_$(1))
+all:: $$(BW_$(1))
+$$(BW_$(1)): wrap-for-bin.sh
+	$$(call mkdir_p_parent_template)
+	$$(QUIET_GEN)$$(call cmd_munge_bin_wrappers_script,$(2),$(3))
+endef
 
-BW_TEST_PROGRAMS_NEED_X = $(TEST_PROGRAMS_NEED_X:%=bin-wrappers/%)
-BIN_WRAPPERS += $(BW_TEST_PROGRAMS_NEED_X)
-$(BW_TEST_PROGRAMS_NEED_X): wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)$(call cmd_munge_bin_wrappers_script,$(@F),t/helper/,$X)
+$(eval $(call bin_wrappers_template,BINDIR_PROGRAMS_NEED_X,'$$(@F)',,$$X))
+$(eval $(call bin_wrappers_template,BINDIR_PROGRAMS_NO_X,'$$(@F)'))
+$(eval $(call bin_wrappers_template,TEST_PROGRAMS_NEED_X,'$$(@F)',t/helper/,$$X))
 
 all:: $(BIN_WRAPPERS)
 
-- 
2.37.3.1426.g360dd7cf8ca

