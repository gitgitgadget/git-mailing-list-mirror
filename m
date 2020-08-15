Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88844C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67136206B6
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfe4CtrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgHOV6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgHOVwA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B6EC0A3BE0
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so12986423ljg.13
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V5gv5K9TkWLpRShrsSODi5U1FnGFWzDOBRPbR69Y/jQ=;
        b=Lfe4CtrV2eKpzGMviWiX3dhC1ItZBUDMBOB5bsGwvqvrzOfAxDZvVHcEC7vITug3Hp
         jLLxsQQ6lVYjpGc+MouzopNjQXgNCGfhFIKGR0I8LtER3Ts0HB7YDHDQrn5PD80lwYli
         CH0DBpkaf8gTrYoPbaRvEEiePgu+F3H6QIHBqea/Zv38cpEomL/6KdviEpDSiiNzi5TS
         +i5wccAMKiepbTunWBc9qNtvwEauwH6jM0Han9T3uyyHjRdzJSJozhZG2o8OMcn7mcTZ
         XZfcxj9NKYGDeuzkQCJvzpgF8AYcN/jHVaV3JffQr5tWsBxiBOmn7JWRvK/NJn+0xk0S
         upyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5gv5K9TkWLpRShrsSODi5U1FnGFWzDOBRPbR69Y/jQ=;
        b=pfPn6SdwVxMAsQIHwzwQZJHoIZUQZvnFb4qm4ry+ox6jLM+KeySiag7XRChQUeclkr
         2WyKClFN0bLfe3KvmWBp8u6F/vRfNeu1HVH2iaAVFt4okUjxoWjrFKFyjf8oYvjyHYL9
         ND4xqudmAjNM03YoHnDD8O9xZ7qswiKb+NiC+1I9QCZzQPMPGMjMsm+O/lKCJYEAQVpY
         D8vwfSpOUMqXRhFVLMfReWw+jTWdizWBGkqirulOE6qqWjaSXMESTcgds8K/hBxM8W78
         sDO+oMxz5zzHGQlswEuaDVSXmNqlvp8b52cUzdTbHR9YZ0nqUDjlIoe2/c6jL8lu5co8
         LTTA==
X-Gm-Message-State: AOAM530yk+okVHFRh0+q+oENz6SkO+1NkkpejWGTnQPpgFa6RFiXK9bU
        F6RgEh5t7Lm9ycoa7Vari82giQL112A=
X-Google-Smtp-Source: ABdhPJztUrS7HPDay1HR3Vjm7lWFJRt917AMwCL/HhARTWO/oeFOLAIZKNFbtiTp1g1ByWpNT8UjGA==
X-Received: by 2002:a2e:95cc:: with SMTP id y12mr3423032ljh.138.1597507596440;
        Sat, 15 Aug 2020 09:06:36 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a1sm2670493lfb.10.2020.08.15.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:06:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] shallow.txt: document SHA-256 shallow format
Date:   Sat, 15 Aug 2020 18:06:02 +0200
Message-Id: <8680fc1af6714b1d97b81b824184679593213d91.1597506837.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <cover.1597506837.git.martin.agren@gmail.com>
References: <cover.1597406877.git.martin.agren@gmail.com> <cover.1597506837.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to recent commits, document that we list object names rather
than SHA-1s.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/shallow.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 01dedfe9ff..f3738baa0f 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -13,7 +13,7 @@ pretend as if they are root commits (e.g. "git log" traversal
 stops after showing them; "git fsck" does not complain saying
 the commits listed on their "parent" lines do not exist).
 
-Each line contains exactly one SHA-1. When read, a commit_graft
+Each line contains exactly one object name. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
 to discern from user provided grafts.
 
-- 
2.28.0.297.g1956fa8f8d

