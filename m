Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1959BC433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 00:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiCNAYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 20:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiCNAYm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 20:24:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0367D33E2A
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 17:23:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y8so12564069edl.9
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 17:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JctfJxJuuK863hExb0IsdxjEPg+pVDdMi867plvQb3c=;
        b=HGbD7fCliidtpqNUQpGWWIAJ4ecnc8ZQMqnkbOLDHwXfRWpU7PPxGyAxM89A1g5skW
         kw3R6R1gunVVNqVJ8Sr8nwxZ6KOYdXxpD1y8pKFP4w7ckUOdv7BSb0lxAda0D8E+Dg0W
         Hxf+Q4fK4jLX7Af7CZsHdF9HYddPV+yz9GmgTjP6fDoOT1DMicpcXfgLGPsHPJLasD+1
         gigZhnyvRtrt3DoIRNbsD+KHNb39wRBA+ID34eRew5FXs5GnuSHK+jwPmXMofWabTMSy
         MN+ixs5A51MbNYOOAcDxeeiORZr9QDKvhvUdkKH6xBydGP3Y4Tghr5UA9tc+VM2OwG46
         TXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JctfJxJuuK863hExb0IsdxjEPg+pVDdMi867plvQb3c=;
        b=aXNfdOMp8kSEmkRnKBhNMkNOdRtqlIWwT7vguT+uxxD/gVOG4aP1w3QEEJXtOAhLtQ
         Spg+mn8OPx8/rk1h7c/w4PHVtPcZtTovK+c/By4TZBvkK1sFC834QrVXOgY6qt5H/9W0
         Bf6VOnxzGJ9/fNE9HroMpBvl/MIF2/Au9c+oLsIxmndcdmjl7RAzphu+5fSi0gCgoAvC
         BKWfdLtaeYoA1Si9n/Zc04KB1HjHY7SXanmMZPML77jeaOOYLeBDxtTy+xKMRWmG9n5S
         CkdjXDokvgvaBKd2RugEU0DRohmDR2BBtql37dpyJwAnVZl102JXj7WQ9VBYG67iOlQS
         wKXw==
X-Gm-Message-State: AOAM531WPZeW6pKH/hR8haOgMJ2PNSF59KDXwsyofnFYZzk66Z1/FhXB
        zIPpZ2gWyGX4I1FxBXAFukSrsDhWiFc=
X-Google-Smtp-Source: ABdhPJxjaET+8fUx31v46coU+LQ3P6/qqBvztUk/6IwbOIIqSsvq3LqZYDC/G1LQ80/RnJVPKiewlg==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr17763879edw.113.1647217412192;
        Sun, 13 Mar 2022 17:23:32 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id re27-20020a170906d8db00b006d76251f4e7sm6043122ejb.109.2022.03.13.17.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 17:23:31 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 6/6] attr.h: remove duplicate struct definition
Date:   Mon, 14 Mar 2022 00:23:27 +0000
Message-Id: <20220314002327.243915-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct index_state is declared more than once.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 attr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/attr.h b/attr.h
index 3732505eda..3fb40cced0 100644
--- a/attr.h
+++ b/attr.h
@@ -121,7 +121,6 @@ struct git_attr;
 /* opaque structures used internally for attribute collection */
 struct all_attrs_item;
 struct attr_stack;
-struct index_state;
 
 /*
  * Given a string, return the gitattribute object that
-- 
2.35.1

