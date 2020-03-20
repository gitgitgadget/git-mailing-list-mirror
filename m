Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A54C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43AB20739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 16:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE86zSkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCTQHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:07:40 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33309 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTQHk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 12:07:40 -0400
Received: by mail-pj1-f66.google.com with SMTP id dw20so3596307pjb.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rb90CEL7GnK/biLzkp/7BYx18kNqWygy/aYZ+8q25iY=;
        b=WE86zSkYCPBrQ50b0XPXYCUszKzsWUzOl8Y00w8MjUwpk6c0xyXGn3P3WWNcIxj8kY
         EOfzzUoF75UtUazTo3idT7KXzRIaJUFzZD1CfOnZYJ7tikcZujoGr/bokps+O3tWRUSo
         OS6ayYODu2gGF+v7Nr6BKz2xpJVVDZ6h3fdv2dI5txUUWl0hSWowOIceo0+OIKLxrTl0
         KUGsS4EB4ZFLt1YAAk+X9Ns2eGbdw6yeM5PVnHmn1FInUWmqdOZuiYCuPnK61t38xAah
         d6yB5eBifv77jAX2buHBORG8xM2STn5EUSNxN+89UhVpThpfMoW1w6MeCnfbDv2gSciY
         NjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rb90CEL7GnK/biLzkp/7BYx18kNqWygy/aYZ+8q25iY=;
        b=k4fL8XH7B9pHD3lzzvYD2Q2uKdxAP4xrRrcYcEAEzEJn+0rTRh1/t+oD4UGMcQ6QXf
         L2AMsFlIFBmww9AZ7Ahz/EUOSJ3fHsuLKQNVVk8pRl2Extjs2Z6SXP3Ihos1j4lkQvOV
         PjMFnR9N7Mpeg9XTox/vKheBO1WN7bT6KA6Ce8hJkjQJxMH1i96VzMEtxXvh2EMn5IPQ
         PUXHzb8v3sYv/3WsrSt89vONADztDCobdZgtz9jOozqjyGPbJ5mGX9tSDlB/ziEbLZkr
         ZXraLAvTJNF8Ac1OHnhH8ySl3tFPeOkVJi2Yp0zf51V4buLRXimT1AQZRXYMSl9TExcT
         Warg==
X-Gm-Message-State: ANhLgQ0vhtUPh8kQQBNzfOPLjSLEBE3YKbUCVrNLY//c5UWUNBdIfuDP
        ZKVpcvt+odAR/PElAJA1Bykk3oXOxwpOLA==
X-Google-Smtp-Source: ADFU+vvwZMg08npTqxEM5YW43CKoPJ9UHwNy0zYUAe1qvLkzxM9UZIrzsjsyquxhogd2R7DbJwHKcQ==
X-Received: by 2002:a17:90a:c715:: with SMTP id o21mr10632860pjt.160.1584720458587;
        Fri, 20 Mar 2020 09:07:38 -0700 (PDT)
Received: from localhost.localdomain ([36.77.94.225])
        by smtp.gmail.com with ESMTPSA id g81sm5928783pfb.188.2020.03.20.09.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:07:37 -0700 (PDT)
From:   Adrian Wijaya <adrianwijaya100@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Adrian Wijaya <adrianwijaya100@gmail.com>
Subject: [GSOC][PATCH v2] t1300: convert "test -f" with "test_path_is_file"
Date:   Fri, 20 Mar 2020 23:07:23 +0700
Message-Id: <20200320160723.15190-1-adrianwijaya100@gmail.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940356
In-Reply-To: <CA+0Uiy-gtdn07=QOx3JcOH-zhMz5yAKOW6=9mNc8Zi+RdfWGyQ@mail.gmail.com>
References: <CA+0Uiy-gtdn07=QOx3JcOH-zhMz5yAKOW6=9mNc8Zi+RdfWGyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert "test -f" with "test_path_is_file" to give more verbose
test output on failure.

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

