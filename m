Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB6C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E094564FC3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhCKM4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbhCKM4M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 07:56:12 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE0AC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:56:12 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u18so10139804plc.12
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQIH4+jqORYL+Bth1pd6EzIp/0uUW1Axp5lqq1bOlGs=;
        b=W/LGr0/uB0nevWGkT8n7M3DymQglpwTLSExho8NJrcTHyKDnG7BFJrfr9wZhX+6jzU
         3TJ1gp/jb1le37BpxwmPmusQdgAw8zlkAGBVKsGveNTkbHZUAZoA/Ll4TxMMB2Q8VC7F
         Ftz9uXHuwB7oV0ldPoBFKDRG66F+A2ofr0ZqlEyQfRf86qxTAXCp7oD7lRIfl5oGrnnc
         vGDooOoS00qbUlzVhE0QlmjcgEPTkjRoin4302zhvygslaPXmKK0b3NvIh0LFSK2nMA4
         HsPNJG2cv5Bg4Z2KDEXITKgfQVSb9+st/Ds8h/nLSruFUMidEroPRAEwhmRjT4S45OhQ
         QilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQIH4+jqORYL+Bth1pd6EzIp/0uUW1Axp5lqq1bOlGs=;
        b=qJdsRK3hkzmmPntMaGRSrW5oARMnmVjdenGx45qyTIthKolXlerC+ErIThoihEH6iO
         RExHmiOK/ENCUitErC5yDNwjOXS824uQuhZSwmmKySOUavmO2alaGWeHS9zwDeCTCzH0
         nMNUH8FKzGUQFlkLCwzGksYBVHrmgksMBExphM9k+pZ8WfE5ksMMR1eHwxAzAA7U7ucp
         dgwMvVaaeZJPyjrW9f6aJqhy1au5x0eG207LeTTzhVsL1vOOb32mx/9p96GRBHVmW6y5
         3oDMkTf2diTmBAdf6agG3dXH6tG+fg8Zuf7lBy8jeoDIKreSslZ069PLWfOH6d34sgzc
         U8Ig==
X-Gm-Message-State: AOAM530uZOji/xD6RrgZ21hyqPtW66p3nokzGKCiqupWNsdcifErgx9c
        BGbjkMKAG25vxNEyYzi8Wzj8StVVGPOw3Q==
X-Google-Smtp-Source: ABdhPJwgOfoWlE2S6SQmkb5NCYWPN9IQ/ebNY9fZM3TjG8lJsPsEc0C0315U+aVxfYTelhUfbIneBA==
X-Received: by 2002:a17:90a:ae0a:: with SMTP id t10mr8642485pjq.169.1615467371511;
        Thu, 11 Mar 2021 04:56:11 -0800 (PST)
Received: from ubuntu.mate (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id o1sm2389418pjp.4.2021.03.11.04.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:56:10 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     worldhello.net@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] po/README: document miscellaneous topics mentioned by l10n coordinator
Date:   Thu, 11 Mar 2021 19:55:08 +0700
Message-Id: <20210311125511.51152-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document various topics mentioned by l10n coordinator (Jiang Xin) when
pulling l10n contributions.

Bagas Sanjaya (3):
  po/README: document PO helper
  po/README: document "core translation"
  po/README: document l10n conventions

 po/README | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

-- 
2.25.1

