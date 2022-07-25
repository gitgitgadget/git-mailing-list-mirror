Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D172CC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiGYMjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiGYMjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA1D1AD9C
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ss3so20222795ejc.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdREtaFtzl2ZM0yi9y/5BXT3TPp1ypMJMob+q+TlHJo=;
        b=S9lyhPmgYlIbK0qGgV+Il6IeCGQMovtKD28tts8H0d9DaI4kssi0SnJ+qVRIt2kueW
         BfxjNXmEfX2/Hzw2Sf5LoFuPSHF/+W4dV2RXepDac41hO+pWqwUsaZJwVtDf2IP528m/
         +RELq0fRfItOrtU/LpxtC0NFU7SbeaG/Otsamcq5rorkdV9eAG6O6CSg+wRyx0q+ltS9
         VxjuQVWzETvG/5b0+utKRo5t9jPk+4wWODp1cR+Pidj2/NyOH8NMIda4KOCfTRcWriJY
         Ww6pqZq7Rew5xetXpYCebgepYe5oORCRlZLMI2T+dH5aB38q1E2LytmZp6/G2KOwfsMV
         OOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdREtaFtzl2ZM0yi9y/5BXT3TPp1ypMJMob+q+TlHJo=;
        b=YkiwpA7ZmNhNB/LIgu79vKQPFeGNEHi4xIL5V5ofxAybHT5m/g6KaDCINlUMoNPDDf
         i6zOv1txdqFEBrVqxNLbu/NMvwzoSPj8ccegJK5fANtjPYHZmiJI8NdxlfRvWEVHxOKt
         Ym0dSNNmGzFQu4Iorys8ujNCRUqi1wCjlf7CmCCvasmylYBz4TiGcZS+wepJa8mPIVed
         vHEi+/Ls+pfJtRxUbh0iqReYSIFDzQ9EK9f3ZXgSNVfLxzNU6m7ThGf/rmYaj7CBQ31i
         I0pih9FPNZLkNaIVSZMd/oX59e9RQDMtNZATSn0xNkJQwoxnv8jrW4wjJIQQtAx+1kF/
         G4Ig==
X-Gm-Message-State: AJIora944PEf68S8Z59j6bUDqmJJZFZ1gHb6+I2RakxLms+CZzAOUhal
        9QkxyzJekUBw4V2aW3VnP58b2uxq7qI=
X-Google-Smtp-Source: AGRyM1sRQMAF2Vz1llV8ILzjkWnZQla3lDd2vPBx3W4NMRtRHDbIieDUBcYVDtquOX/hLH4KqUMiOA==
X-Received: by 2002:a17:907:2cef:b0:72b:5b3e:3d7a with SMTP id hz15-20020a1709072cef00b0072b5b3e3d7amr10074382ejc.293.1658752750874;
        Mon, 25 Jul 2022 05:39:10 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090623ea00b0072ab06bf296sm5350679ejg.23.2022.07.25.05.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 05/20] api-parse-options.txt: fix description of OPT_CMDMODE
Date:   Mon, 25 Jul 2022 14:38:42 +0200
Message-Id: <20220725123857.2773963-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of the 'OPT_CMDMODE' macro states that "enum_val is
set to int_var when ...", but it's the other way around, 'int_var' is
set to 'enum_val'.  Fix this.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/technical/api-parse-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index acfd5dc1d8..5a04f3daec 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -236,7 +236,7 @@ There are some macros to easily define options:
 `OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
 	Define an "operation mode" option, only one of which in the same
 	group of "operating mode" options that share the same `int_var`
-	can be given by the user. `enum_val` is set to `int_var` when the
+	can be given by the user. `int_var` is set to `enum_val` when the
 	option is used, but an error is reported if other "operating mode"
 	option has already set its value to the same `int_var`.
 
-- 
2.37.1.633.g6a0fa73e39

