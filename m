Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C839ECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiHaImE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiHaIl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:41:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A82B655F
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k9so17313753wri.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=77jY/9A+tzmIQeNPkbAyiHpxjzPKVdzRp1wwHzcFouM=;
        b=Lo94IhxSc6KBpyBi3TwqamMpmEF9fF7GSAzAH+3I/+wl4rSsOFHLxI06qac8zn5H/D
         W5GT18/CXG7RLjr7qjr8jlNcnIIrZadZFpwfzqc0AVb9+Z30kMnRoAfmSl/R9dTWeOwh
         yrlw8osAQDDNpUrTopFV6lV8UmYCkmwJnpPf1IAV+ag7h7d5nEE5MrkSNYikTiZ1gsoM
         abbrpvvX6n+XOJEdhJKmg3Z1l9OgUJ9Fc2AjDTvbR0NxjIdi2YNspaiavTbb16CH0w8x
         s24x2qcdiO5b+1BNMDZT6yU3TaP1ORUJfZpHwX6FaYrqE6OtBu6IP140VQQrGnskJbu+
         b86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=77jY/9A+tzmIQeNPkbAyiHpxjzPKVdzRp1wwHzcFouM=;
        b=FpVsis9LPZwVVysdF3E/CSwpxyOacAEGSS3c6zy35lC951VpBUpQz9vMdMYETwmhcI
         HvFAQaHYLsi750cts5yw/E0mjen5nS5RuM0tmtFgz0qVmy82KEeNuQIRofG+97AdjLRH
         cka+dg6ctZJ4e/SmaSo1lBdqwDNG1q3N/TlVzfmYF9gQPSwTSMy4uAM9h1kNRQr5/pq1
         mhGXhjCgr27DM5VRNwayiXu/SUj+f4vSfvyF5hCn59juxp+xM3c70oWMzAIAVhwAPRgi
         duipG09gt6OTOnLmCuiu77lPz3uN/iFij2rJO+FrAfY9E+grBBAvs6B88AmUkPTCZOEh
         Mmlw==
X-Gm-Message-State: ACgBeo248SCNMhaJRfZ3nPBcTgbnfEiKmc/dlg91qHf+LYkk92+8x9JA
        vfGgfozhExwct6lfozohVPvoHJ44g+TKEA==
X-Google-Smtp-Source: AA6agR7pkGE7ZKEuT66qzBLAgR5+TkU/TSTwfpKbpS+42oep8LlumME4U42E+PuHtXmwBMVnqklGRg==
X-Received: by 2002:a05:6000:2c1:b0:226:e7d0:f098 with SMTP id o1-20020a05600002c100b00226e7d0f098mr2695287wry.578.1661935315428;
        Wed, 31 Aug 2022 01:41:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/9] apply docs: de-duplicate configuration sections
Date:   Wed, 31 Aug 2022 10:41:35 +0200
Message-Id: <patch-v3-4.9-5707c9dd635-20220831T083759Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The wording is not identical to Documentation/config/apply.txt, but
that version is better.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-apply.txt | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b6d77f42068..1d478cbe9b5 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -263,13 +263,9 @@ has no effect when `--index` or `--cached` is in use.
 CONFIGURATION
 -------------
 
-apply.ignoreWhitespace::
-	Set to 'change' if you want changes in whitespace to be ignored by default.
-	Set to one of: no, none, never, false if you want changes in
-	whitespace to be significant.
-apply.whitespace::
-	When no `--whitespace` flag is given from the command
-	line, this configuration item is used as the default.
+include::includes/cmd-config-section-all.txt[]
+
+include::config/apply.txt[]
 
 SUBMODULES
 ----------
-- 
2.37.3.1406.g184357183a6

