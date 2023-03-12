Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611B1C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjCLUJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCLUJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:09:27 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364F76B5
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:06 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id a4-20020a056830008400b0069432af1380so5682958oto.13
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678651739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyqYOaxxImvzJ2bqTTROPStQr1pAZDd9ApQJRZXamwM=;
        b=Tv8HidT0l5xqP/C7f6dzllhmxKJj1SYpLlLXajlYZ99L01Mg6pKAh5CSdJPCkr13xl
         yaHotCuD2vQycxSyy8wTe6T5qJLlznhglcKCXOVOB3LivT2tX6arOr0TGsdD+kACWG46
         X836G6APkGj/4+um1baqATi0PgjQrtJLoSA+H6DEAYiEXJLTeuwceBxsO9UMh7HK9+nO
         u4Q7bjPbUfX7zFwRo3KBAnvm8bnUuN+Bkh+ZzJ4+TjJsmQhG/4SkLFHb1ygvUhpy77gR
         a3wgrPPeAK3zfph3z51QhfgymyMv6znXDaNadmD9ToGDsoHJnywjfBTw1blgy8r+B9C4
         +S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyqYOaxxImvzJ2bqTTROPStQr1pAZDd9ApQJRZXamwM=;
        b=pDVw+HgPvde2l1aRX9IdqPBDZLjnIw0dI89UVLQHMocg6lCVSn0gav5JEGeZHkSXwI
         VPgqdX3dqJ1/eJRaBLCfV9K2wikjROBUPv6M2zUyruEvSjmlWFUOtoyRD49bHYZQd0Fx
         farImid5fmTtp1CX65uS89saqnqe2fHPcXqVHySFkjr1+ENuVAL6FwO66YrnZsVRlrU0
         Kf+e7oaf4fO9RN2NZgn7ugi2QksCA6mVm1fZ1EPfltyHvRscWnQioz+NmXq/sFnS6aFQ
         IpBgtk0pzPKegm9EnTzdg8Xj504OEM+THmeHk9CUDzROtUqsAVX3JA6T1c63eicjliRJ
         egLQ==
X-Gm-Message-State: AO0yUKWzDbsPRLic95u6mY4G92gtNAkW0lwUoXFPQYQEDGxKVOJgT0gh
        9FVJ1TLClXlEU0O1zb7hM/Yk9GCSqy0=
X-Google-Smtp-Source: AK7set/ksSz9bj16Prjjoja15CRrEeVxFgaXLWwnKsaj5zjS3qqfong7wtweX8RQpoJTzYFtc6iLUQ==
X-Received: by 2002:a05:6830:2338:b0:693:c3bb:8392 with SMTP id q24-20020a056830233800b00693c3bb8392mr4338925otg.7.1678651738917;
        Sun, 12 Mar 2023 13:08:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o16-20020a9d4110000000b0068664355604sm2450585ote.22.2023.03.12.13.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:08:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH 1/5] perf: sparse: remove grep --sparse option
Date:   Sun, 12 Mar 2023 14:08:52 -0600
Message-Id: <20230312200856.323688-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230312200856.323688-1-felipe.contreras@gmail.com>
References: <20230312200856.323688-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was never added.

Cc: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/perf/p2000-sparse-operations.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a..e4a132f593 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -124,6 +124,6 @@ test_perf_on_all git read-tree -mu HEAD
 test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
-test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git grep --cached bogus -- "f2/f1/f1/*"
 
 test_done
-- 
2.39.2.13.g1fb56cf030

