Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F350C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiKJQhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiKJQhG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7970232B88
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so1816075pll.6
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsahwT6HWiNXUp0jyRsbD41SHVPLS1UoFDa08g8ygJM=;
        b=nIB2Hh2T1pRROuFiIvqUbjcI/fdsCx2EWq2iAuPem8uOHsmCxjsbTqEoVRP42+/8he
         PAB+sPHQ5iB8n+U+UXQfnLjHxWQGq2EnkoUUKVACXI+G34ghs1VCg6RgS0TYOjC5I/ZY
         FM5gNEBAF3s7DdXCqzCi/QlFUFod8R+o4AUNeP3G1v65HhnDcnjHy1Q1EmIXl+deuVfG
         x+mBLcCkGXTiPpmgsRDcECrafNNf3eoilzuCfCB59qxLuF6RAOTJUlLjmXmB1A2h6YdK
         oN3sWSef+JznRadheeSuy/Fjmimm8+RFPZbKbddDOCbpfQN60GmWAQO7AcDfroxoMvbo
         6tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsahwT6HWiNXUp0jyRsbD41SHVPLS1UoFDa08g8ygJM=;
        b=rYkMzz+h+JmcxOe2sGREaeb2+Ye1NTJ0G/EqZB4m+1EeHueFAJ1GoJvxlUEOixvXuV
         CZ8xrYaDbFi3BhxHLkTQjkCIFJSu5h88fOV4rndq4Oi7/UiksEVETwU6b+UG8HrB9OJq
         pYSX8I6yG3A37MnC7DfQ7e/H1jLPb7H7dDp3rIC8x1VwTiCdUngQy5fG/vqdQ6lwTp4A
         6Q634yz7OXzOhOQjPLOsiUADBuJ7s15DT5NiXthRC6D5/6Vg51nF3DDr+4nnmbHXujXY
         Jq+cD9qrHG7Jzne0xDwz11hOVfQIqDomeGRsINtrmpZRhAcRLAc3PbOVZTbOZuHN/Uhf
         EWQg==
X-Gm-Message-State: ACrzQf32ey8GbzrA4L+xwE6oojMJ5Eg3ywA25NU7UdqlRZTE0ak7lpce
        FyVksVU6jUNkzA7Afb6oTvdThrwPnTc=
X-Google-Smtp-Source: AMsMyM7e4HC3hQLYwXh4PEXvdfVJ4pkRLx5Ph3SiPo6klo1p7gAjtiLEo3Aow1c3lkoYSvzsa2FYXQ==
X-Received: by 2002:a17:903:2406:b0:186:fd58:c706 with SMTP id e6-20020a170903240600b00186fd58c706mr1493772plo.4.1668098224682;
        Thu, 10 Nov 2022 08:37:04 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:04 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 02/11] bisect: refactor bisect_run() to match CodingGuidelines
Date:   Thu, 10 Nov 2022 23:36:37 +0700
Message-Id: <d82c7eaabff114fab86459482ce1e5751a783497.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

We didn't add "{}" to all "if/else" branches, and one "error" was
mis-indented. Let's fix that first, which makes subsequent commits
smaller. In the case of the "if" we can simply early return instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 6e41cbdb2d..08d83e6867 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1191,13 +1191,12 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
 
-	if (argc)
-		sq_quote_argv(&command, argv);
-	else {
+	if (!argc) {
 		error(_("bisect run failed: no command provided."));
 		return BISECT_FAILED;
 	}
 
+	sq_quote_argv(&command, argv);
 	while (1) {
 		res = do_bisect_run(command.buf);
 
@@ -1268,7 +1267,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect--helper --bisect-state"
-			" %s' exited with error code %d"), new_state, res);
+				" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
 		}
-- 
2.38.1.157.gedabe22e0a

