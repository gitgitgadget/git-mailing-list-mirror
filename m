Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1DEC6FA86
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 19:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiINTbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiINTbU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 15:31:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEE857CB
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 12:31:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id s6so15587981lfo.7
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5E/61Cn98Fl6nCBQNTD8VxesLFg633aWZ+2DTu9sp4c=;
        b=CzpTkguaHiJR9RGYeANxyUZPkZaKDJGRrhTpupIMvg8Rx+OAaFKyNmoWLjTzqrYJa8
         bgC+s3tzkEuWI1JhFJ/jv4a/GZVhQfQy7Pv2CVWrJrb13nrEjk1K2A016rtGRPXEtT69
         wHBziRgYHK5jeEBvMObkdTWve6wtZ1hw8EPUlXCjGx918F9f+npuupy2vnB3ejwotBY6
         B6madaLlh9LQKZF7oHMfU8dKBMOC4KwbnBCo3Jwv/+szQ1l3sGLUGgFDApMvirbzgPZO
         vIsttnxO6kM5M2FlA+wrdWVQiDhBouh1cmJXlVRhr1Ll1b1Bjbp3hdZBOAn2OOi4ig9p
         a1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5E/61Cn98Fl6nCBQNTD8VxesLFg633aWZ+2DTu9sp4c=;
        b=K6XUo6+aLZCXAVhGMql5/MbqrjbHEvXMHvkFwp0SOJoO8FeDHPoWGXeWmo4YuAYUs+
         z+Nv0NlrjZaFUglgizVH055LCT8M2O9lAJoIr/LCKifvq6x2PoI6BeTo5NErAAwQ3Y5F
         HptDRr0UcsZz8Lxuh9yBnCHWG5G7HtqfjdjvDjr8GIeMasM7W+hzAOV2u5IlbG57mnIi
         VRpY+jyrGKQBOJECs1mVeoTyuxbOKQD1o+2ggBqkWiCBpXw1+CpQkDINhBILqIHZI7tk
         IzlycoQtxB9XXOa+58JDv/mbgduEgoT8wckdMwglNrdILDrnKIcOzF0GKQ1GWxY8cd4Q
         2ROw==
X-Gm-Message-State: ACrzQf1juoR00C8acZg9cssglGp02B4UE5x5Ppnm4a4JiQ3/BNE57GBU
        bPpj8rqsC7Eg/2oXgaTW9Aw=
X-Google-Smtp-Source: AMsMyM6PCkunPEKD/4Ts6m5OpI+iBmcUlzLSqiYPTF6lyerk/39PtfGsRQEJtchxxsOwqGRiJft0Mg==
X-Received: by 2002:a05:6512:39c6:b0:49e:75e6:8d4f with SMTP id k6-20020a05651239c600b0049e75e68d4fmr461474lfu.34.1663183877001;
        Wed, 14 Sep 2022 12:31:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u3-20020a05651220c300b0048ad4c718f3sm2522305lfr.30.2022.09.14.12.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 12:31:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 3/3] diff-merges: clarify log.diffMerges documentation
Date:   Wed, 14 Sep 2022 22:31:02 +0300
Message-Id: <20220914193102.5275-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914193102.5275-1-sorganov@gmail.com>
References: <20220914193102.5275-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/config/log.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 5250ba45fb4e..cbe34d759221 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -30,9 +30,9 @@ log.excludeDecoration::
 	option.
 
 log.diffMerges::
-	Set default diff format to be used for merge commits. See
-	`--diff-merges` in linkgit:git-log[1] for details.
-	Defaults to `separate`.
+	Set diff format to be used when `--diff-merges=on` is
+	specified, see `--diff-merges` in linkgit:git-log[1] for
+	details. Defaults to `separate`.
 
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
-- 
2.25.1

