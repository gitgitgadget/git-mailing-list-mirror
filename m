Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39243C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 15:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiITPuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiITPuA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 11:50:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940203DBE8
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:49:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso7227962pjk.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nXysgNlNcBOCIHOuekj3dPtTooffc+8050pI04x5D7U=;
        b=nUsUosbh2VLnCB6iCOCdvPhpPQ2P9iKf+Zwa+I3+vnZ6jh9IiRo2u3Z4Iz6UaLr0JW
         e/LltA8w6dBiuz4MTIzu0fR1BO+f6z1zedRUfoWHiPcDi2VQGbsUP5N9uNj/EgoG5uLS
         Yvg19b/TC68qecNK5u3yYC5+ZntWhXEZYgdeqiaGQT9VEiPOxXjSLNcQ9lsF1Cd05UT4
         K4glg26UieMXqJ6Cvyl5mj9KPdRijR2oqCn7v1IPO4odadfndC+/1mNPTLZStQGfvyiD
         goGlR180SXz1rM4pj003gGLiJ7MKZzMSaPn87pyNS44EsOEGHBxb6yQztPhEKwBblfYK
         BQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nXysgNlNcBOCIHOuekj3dPtTooffc+8050pI04x5D7U=;
        b=Fjn448CvcOrBpgIcBAzPEtoVyyedR3UOQBzny8faXS+5h/Atwb65OrH6oWBLLXI4XZ
         iHTUlCbAMHPltxqZ98aRlkcD9TfdwT2iGIDXsX46G+GpE3Uo/PjMUhEB6uR6hG3xib9c
         tFXx8MjLHVIpSel4/3mX15PZ0M1ehOrNdWEGf2nHmrTIRWMyWEsSj3H+qbucOHFUdSSC
         Q+HKA5boM5zHcylHUFs4bfX+EpyIVrsixtxlwX/EdLo3dn88WDtTitgE9onvRauCp2bi
         GBRxbXdmn4OQjOHYR9P3ZbPOKsMAcSS9gKe63wk7r9+H072/+KpMxwwb9KC3SezEYqmI
         cALw==
X-Gm-Message-State: ACrzQf1no8uIltTDti+wkKTrDYRirym8X/KWbDvzg0kwiEzvwe0/1FJW
        owlWd7THebC4Zmi8qjqhbxPlbrhkMe4=
X-Google-Smtp-Source: AMsMyM6ql74Tf9Xyu22vggwjj8AKVxpY/bBhl2Xv6X7Q8jXFQL5xUOw0Z/X38YoItUAedatj9SBRfA==
X-Received: by 2002:a17:90a:be0a:b0:200:5dda:910a with SMTP id a10-20020a17090abe0a00b002005dda910amr4721336pjs.114.1663688998782;
        Tue, 20 Sep 2022 08:49:58 -0700 (PDT)
Received: from localhost.localdomain ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id 67-20020a621946000000b005379c1368e4sm26013pfz.179.2022.09.20.08.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:49:57 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/4] CodingGuidelines: allow grep -E
Date:   Tue, 20 Sep 2022 22:49:13 +0700
Message-Id: <4ad1ac9d9b25f2fc5a2ada28cae0413c04b07e21.1663688697.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0
In-Reply-To: <cover.1663688697.git.congdanhqx@gmail.com>
References: <cover.1663688697.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite forbidden by CodingGuidelines, our usage of 'grep -E' has been
increased over the years, and noone has come and complained.

Let's lift the restriction.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/CodingGuidelines | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 9fca21cc5f..cb7a367ea0 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -162,8 +162,6 @@ For shell scripts specifically (not exhaustive):
 
    - We do not use \{m,n\};
 
-   - We do not use -E;
-
    - We do not use ? or + (which are \{0,1\} and \{1,\}
      respectively in BRE) but that goes without saying as these
      are ERE elements not BRE (note that \? and \+ are not even part
-- 
2.38.0.rc0

