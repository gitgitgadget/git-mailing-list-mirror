Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9867BC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 23:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353231AbiDOXQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiDOXQg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 19:16:36 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C5260CFF
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:14:06 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id e4so9557839oif.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/KcVrP2Awi9GlrOFO+90oHT2HmTgSpfQ7kgvajYr2o=;
        b=WTSTBDXuuDOacoQjjbgqxuB4hSBg/94+QUm35O6MXZsRPHih/2o9HNgOtPF/7Hg3jP
         agxAmMppVcawjbOEbEXlznlFmWv7wQna0Rnz8QQITCgmttyPvKxCaW7rP6te4EPa3T8n
         sAWwll35s24KQYKZSdZMyxvOxPAWwsdWzOoMETSDyvh+eDtyWCrkx6aWhKWOJ/KqoGn+
         YWL7M856YpNAMhvct+TYObEGJmD7NkeMhczPdBIuNPlwdl6CfD+K5M7OBvlkMqIRLagO
         6ny/g+8NJksj/hopl73RO4B8UtDG2eiLfZQDGXjOg+2G7qPLMGeOg1Hq10BU4pd+4VC5
         BJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/KcVrP2Awi9GlrOFO+90oHT2HmTgSpfQ7kgvajYr2o=;
        b=QcwHyZW5ItVkLe5GOhPl7NgxoyC3prGoTC0RNMMaPnikG6P6FpmatzGEQ4LZC0wLYP
         jZxgFo3LIvx7Tq7t0B5qsv/opTJwpBm/abfU1Mza4A+kxoNYhCgURuS5rh1jTEJdL1YH
         V68mcnG4EcgvzuGbukgh07nLFky2XgGI+RRlt1y/uiNOYgC7PoJ+L0+kZbbTvMvufXek
         6wRjgXvA/ghV1cBBloOVAcy/HER8WihL78MshhzvfSLDzXCrIfK91hvGemHBgkdlWL+o
         //ITLtBcvdyy4yoxiyMcPdrB9ZI7n1JZK5582XwiLfvgbla48QrFIYSOl7Ub8988ZaP2
         wslg==
X-Gm-Message-State: AOAM531/oxCEEx+NA2WIM8MgSVShBt4qD1YbA7SUQ3bMhr3AWXHhA0JN
        oCtsCLRBEkwfHpWHzt/i5mozQWy+J0Y=
X-Google-Smtp-Source: ABdhPJy/s2Jefz1gN+UMG0UQV88QFzbxzGkd3V1EtgVgf5mGGqnkLhQmgmGfTb26w38q6H7C/LOO5g==
X-Received: by 2002:aca:e004:0:b0:2da:850a:966d with SMTP id x4-20020acae004000000b002da850a966dmr2448811oig.61.1650064446036;
        Fri, 15 Apr 2022 16:14:06 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b0032993003287sm1584720ooq.38.2022.04.15.16.14.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 16:14:05 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@talktalk.net, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12 warning in http.c
Date:   Fri, 15 Apr 2022 16:13:42 -0700
Message-Id: <20220415231342.35980-3-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.283.gbef64175c85
In-Reply-To: <20220415231342.35980-1-carenas@gmail.com>
References: <20220415123922.30926-1-carenas@gmail.com>
 <20220415231342.35980-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This provides a "no code change needed" option to the "fix" currently
queued as part of ab/http-gcc-12-workaround and therefore should be
reverted once that gets merged.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index 335efd46203..c3104f400b2 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -68,6 +68,7 @@ endif
 # https://bugzilla.redhat.com/show_bug.cgi?id=2075786
 ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wno-error=stringop-overread
+DEVELOPER_CFLAGS += -Wno-error=dangling-pointer
 endif
 
 GIT_TEST_PERL_FATAL_WARNINGS = YesPlease
-- 
2.36.0.rc2.283.gbef64175c85

