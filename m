Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC98ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiIEI1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiIEI1C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7869193
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c11so6043906wrp.11
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Hea2vi2NWUuK/hENlYVLOY5BKstOUOO5qGWcLAUM3Qw=;
        b=ViLVcKTq0FTbtK5/L8Yf+x+CGw7CRZvV+nwfPg2FEpvYMQm3bNflJ7p/029lQ8FHQz
         9dfRRl89LB6pA1RKqi3/bH0cBix4IgzmCLnaReZKDuirS2ig8Hoj6E/KY5882upItHcq
         hb8MJvdIGFHjeuCoAaoWPnny16fe4t4mzcLJyd1kNl3mdLI756j4CKgQTI571C4A6oMn
         RBA+N4qddAxpI9TLM4U02rDP2aSBiV2YlieASpI8GtrNhFOba+KV+McV+jkCcbq7Gbsw
         0PgSpOtODpOl8xxGaRhX8OY1Vwdob9sa5/ZH+Y3Dweapu5yGdHvPVXxo33tZodxYcjQk
         Ze1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hea2vi2NWUuK/hENlYVLOY5BKstOUOO5qGWcLAUM3Qw=;
        b=okyx8PZPPc8Lo7Up70BxOTnOLsBdyjDEFDAfdi7a6cDMpLCsJwmt7c/I5lyU61YjlS
         x1VQrCbarY+iflVFwSZdNRbmdhXEABmcP3jlHotadNuFY/s0Xaoms+rMa3RAg+WB6E09
         nH7kJ0KpbBEGlYOBCvElmWq1zR8t9DxFPJFReClFjagO/iDKFcbTqLF+oM9Nmr9Ciapu
         zcznkInZPCnkUbkejlvbpGMB4ufmyUBgviij/NrI3XxFoibFfgy9vaqMWX3aLdtQmHmq
         Y63mDYYb/EVGhegXWyLLy0VWa3dFjwxdIag0XABw7IMoVKyC9/Vas1ofBEcRNFB9Lh6M
         M8rg==
X-Gm-Message-State: ACgBeo2ParB9XfYn6IKOG3Et3sK/qD44BF7ntb3hW+slS6xpt4hrCbLH
        fxEQU3stXC2CfR6Ltc+ONs/vu58Dq+YkyA==
X-Google-Smtp-Source: AA6agR7s6q+Lhd5ylOVR9672h6zgK5ViykJSaolFzwntKRVHcmMQxMRpLeiMfKXpw8RcgrT7tRB1Uw==
X-Received: by 2002:a5d:4301:0:b0:21b:8af6:4a21 with SMTP id h1-20020a5d4301000000b0021b8af64a21mr24899489wrq.296.1662366421110;
        Mon, 05 Sep 2022 01:27:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/34] doc txt & -h consistency: fix incorrect alternates syntax
Date:   Mon,  5 Sep 2022 10:26:21 +0200
Message-Id: <patch-10.34-965f6b3b3cb-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the incorrect "[-o | --option <argument>]" syntax, which should be
"[(-o | --option) <argument>]", we were previously claiming that only
the long option accepted the "<argument>", which isn't what we meant.

This syntax issue for "bugreport" originated in
238b439d698 (bugreport: add tool to generate debugging info,
2020-04-16), and for "diagnose" in 6783fd3cef0 (builtin/diagnose.c:
create 'git diagnose' builtin, 2022-08-12), which copied and adjusted
"bugreport" documentation and code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 builtin/diagnose.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index faa268f3cfb..23170113cc8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]\n"
+	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
 	   "              [--diagnose[=<mode>]"),
 	NULL
 };
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index c7672fa99e2..54491f2c51c 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,7 +3,7 @@
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]\n"
+	N_("git diagnose [(-o|--output-directory) <path>] [(-s|--suffix) <format>]\n"
 	   "             [--mode=<mode>]"),
 	NULL
 };
-- 
2.37.3.1425.g73df845bcb2

