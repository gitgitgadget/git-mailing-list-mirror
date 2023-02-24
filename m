Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D51C64ED6
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBXAKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBXAKO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:10:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA194614D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j2so12146031wrh.9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9qzaDFEfBqpAh2RNG3iSiFMBaiPM1J9KlsUGohgR0g=;
        b=RvznWZKBCa76p4i2hyaUqC8KKMcaXD979tN1OAkNNniCMMIzl9SL7ORlFVPAPhmA/7
         81SSp3l4B2Z6u6CebVBiGPKSclcbWXg3KB9ntiq+h4M5zWVcMXt/r24q/nxbS32OGk2+
         //pk6L/WkOIlucbrfGsC1bm+OeFzNJ1FUwRei1XRxRTfhc/wotl7Twz4zdmbYi8BFiUJ
         TTpKCQUXr/SrO+wBAEGIWAmV7TnjDSCBKIBnZlWczsnCtpCuAioxTlTp8k5Vhrr9nkhS
         9CgmwyRRh9KNPs+eX400rB2tEDhNeizGUB2Wn3FyBBoRouEO8Z2MdNioYjLU6HzDnSm4
         eqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9qzaDFEfBqpAh2RNG3iSiFMBaiPM1J9KlsUGohgR0g=;
        b=Jm0eKu4Gvj3XAq7zf+rCVnvvforMPQ7oVfLzpVJ7F0qCWjaR4VhLz2KTD5NJGTFuUM
         mnuTeJmUbI9lvmGc/aYywZ78WkTk+rzYzoRplAYHiWGAv1RnpwoisdVNGxGuUbaGzHFE
         IFFKkgUWNhkPEs5ZAaALiSJWK9kROMMxOS7tdlm19gxPs/g8eDCxtEEL9R/PtqUQFqsa
         3W32DYOlGnM8Q2ZQsd6CV9rUXH1jwzJKKAX/PEWBxJ4iKga+JeouLk1IIw/rn9b1U31V
         mNK/eXZ+k1LeHjIAEf7XA8CO2o8JIzIZrY51UnHqbTfPuV5+HulcGTmTLt2bYOG2Behl
         isew==
X-Gm-Message-State: AO0yUKWIcDzi0xF4rMNbTFekROlMwebOhSjb9/ucAukSFtv/Ekeo7nna
        QyI2A9bktohHYu6lRzYTKyK1/NLRhrc=
X-Google-Smtp-Source: AK7set8QBJZMwMLtLQKYhv3yRqMzQQOiOSWqR/mqyMeW32gQMZbkv3iyVfg/2jyDoHACS54jsFxmnw==
X-Received: by 2002:a5d:440c:0:b0:2c7:778:5da6 with SMTP id z12-20020a5d440c000000b002c707785da6mr8312110wrq.42.1677197393482;
        Thu, 23 Feb 2023 16:09:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b002c55521903bsm14546972wrq.51.2023.02.23.16.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:53 -0800 (PST)
Message-Id: <a172801bbf032465126f043ae86b6f0ee7bfe8a8.1677197378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:36 +0000
Subject: [PATCH v2 17/17] diff.h: remove unnecessary include of object.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/diff.h b/diff.h
index b90036f5294..f80bd297ca5 100644
--- a/diff.h
+++ b/diff.h
@@ -6,7 +6,6 @@
 
 #include "tree-walk.h"
 #include "pathspec.h"
-#include "object.h"
 #include "oidset.h"
 #include "strbuf.h"
 
-- 
gitgitgadget
