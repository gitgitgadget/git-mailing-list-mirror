Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF1C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F3120740
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH0QO49U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgCSXrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:47:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40099 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSXrk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 19:47:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so2127970pgj.7
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YxE7CWBNI6pSwHR+dfi0OI+LlqyUW0wQgSxiiVi/vbg=;
        b=ZH0QO49UkJH1TeeNaqR2etP7RqCOiaNsiO+jX7PdntXn7b8rtqB47VPOD8z9pBSqO2
         65L4WW6GqGO+lFg7dPzea6HZQ7HQxMYypD+iuHLsnqvBanWza096B4vn7xxhs4rmUHsZ
         25fedMCv2UR3FM/04z4I9QEiKTPBohADc4oxQ61sGFRf7Aup4Kns2/zb0i16g6OXKNja
         H22NMQ5NDF5k3ElvFH3WeC5Zf73U5V1v93i3CwhRtWmHJ15jZamwS25RdK5u6wMabYv2
         GxyWzla/ZZLbv8Ds4kVLfB3FtLAskf2gu1l2o4AtUQrKfpcRu3o0DMa9ixU93K8+oTqv
         +J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YxE7CWBNI6pSwHR+dfi0OI+LlqyUW0wQgSxiiVi/vbg=;
        b=qkq3o+luqol6lYqcaBrexBjw6xAv7CFtSWfOTkOnBn+2u9yp4jYEortw/9FWs7JKm+
         fI8UoHqR3iVattwoPepzFnt2qi2ymZ2ZUoprMUkqi9012tGhFC0fZQoxdOGdmP2sanUx
         /KZgVpSBAeT6GZjfnTQHeBWpngCDhX5zu75iLNjgxGZ9BX8ENWxLGBbps9akl8Ur70mO
         xqY9iEm1tfAKPJAt9rJqBfkispDLSVxDr6CkRE+6abY966UEKD53iZHemnZ7mqiKRlwb
         t6iIQo5d68f7BMCVIBxKW84uPQLRwwe87MjVCa7sPo+yifR8dp+Hb1wu0rgHjJ47RjQ4
         /QMQ==
X-Gm-Message-State: ANhLgQ0evWdtMCiUatFy125R5a3ETY42haMCxoGtZPO7/smOu5mKNuoB
        GL40KCGNKYsS1kdmIE0FNiL95jegeWkKGg==
X-Google-Smtp-Source: ADFU+vtP/S8T4+FKY7ikjMxANW/5fVl63SLThNDfsO22DC3Vi0xHdmh4JPA9S1H240HgiEUwF4wCLQ==
X-Received: by 2002:a62:55c7:: with SMTP id j190mr6476550pfb.65.1584661658534;
        Thu, 19 Mar 2020 16:47:38 -0700 (PDT)
Received: from localhost.localdomain ([36.77.94.225])
        by smtp.gmail.com with ESMTPSA id i126sm3347187pfc.105.2020.03.19.16.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 16:47:37 -0700 (PDT)
From:   Adrian Wijaya <adrianwijaya100@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Adrian Wijaya <adrianwijaya100@gmail.com>
Subject: [GSOC][PATCH 2/2] t1300: replace "test -f" into "test_path_is_file"
Date:   Fri, 20 Mar 2020 06:47:23 +0700
Message-Id: <20200319234723.6504-2-adrianwijaya100@gmail.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940356
In-Reply-To: <20200319234723.6504-1-adrianwijaya100@gmail.com>
References: <20200319234723.6504-1-adrianwijaya100@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace "test -f" into "test_path_is_file" to give more verbose
test output.

Signed-off-by: Adrian Wijaya <adrianwijaya100@gmail.com>
---
 t/t1300-config.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97ebfe1f9d..d74554fc09 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1020,11 +1020,11 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 	ln -s notyet myconfig &&
 	git config --file=myconfig test.frotz nitfol &&
 	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_file notyet &&
 	test "z$(git config --file=notyet test.frotz)" = znitfol &&
 	git config --file=myconfig test.xyzzy rezrov &&
 	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_file notyet &&
 	cat >expect <<-\EOF &&
 	nitfol
 	rezrov
-- 
2.26.0.rc1.11.g30e9940356

