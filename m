Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A121C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCIRaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCIRal (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:30:41 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98BF8E5B
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:30:39 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-17683b570b8so3011293fac.13
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678383038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs2CqtH+fOfohdqDnxmIC4CThZh4jJqollzth1En4d8=;
        b=DzoEIuoUtU5iFHVjgIXvVz8pYUXV7wp/wvafzlxG737Lh4lthXZ3Y7mU1xKOyY7RT4
         4nFm1b3kYeScluLQc4ZoupSS5fqQ1uSsa+ybVhCbMY5s8PR1nRQXZjd2Np9SKP4Kw03A
         XRMutxrswVBUnh2FxbnpcRTTSkPrL58B6Qztdm6tbvaFs2tw06pMrjyuxhBiPiBoX9CN
         TmdThnGEd4twpGShWeRdCzsM3TBh+S7vmwNgugcOmKn2p5NAzrlJ7h0va4ib9NPKpD/s
         7hTflKtQIx2gELQamH1tKOBX6mcL8a/9EZm8TU6Wo+G09HD4XBwcJktfG9p9atCzsDTG
         rSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678383038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs2CqtH+fOfohdqDnxmIC4CThZh4jJqollzth1En4d8=;
        b=kBt+I4VsjGuuYGfVpzI9LiWWcGiXlPMimr8JplnmAeh9uypGcRrN4xj22fCu4uBiNX
         GsP1aKeV7ojkBlJ4utDhyrueLX+djzaIZ1N7dkwZ2l7uDgm9hv2sfrjzxtrcOaJtOsCF
         bj7i2UWBaV8reKzzMyd3muqsKdXF8WWOu22yu9pC5b3IQVHF6VUkcLOUbImNH+C03RI9
         h5iuqQAJsAlPr71A4/wtdPVhr+AoExncWSdK4D6GwQrj4ASvXBVQqxxjnijG5LYAXDrr
         OmXjwlB1/hzDEX25VmItE+nTsbnlQ57GTbSNHhAOaSz/l4JEjbk6YZEA9jzB8peGRIaa
         gYBw==
X-Gm-Message-State: AO0yUKU7zvQWC4uiOWRU2HtaJ94ZYk1sG2+vze2Nid614VWQVVPb3YER
        CqOa0NRCVUkNOJ4I6C3RQf7sKugvG8I=
X-Google-Smtp-Source: AK7set/k+lWJW9jT9/mjSi5WKXPWujOx+sHjrmjpTMhabMbYABInfCfv14/TJmmjp0LsbKZBu+YpAQ==
X-Received: by 2002:a05:6870:e40c:b0:16e:907:e198 with SMTP id n12-20020a056870e40c00b0016e0907e198mr13421313oag.45.1678383038225;
        Thu, 09 Mar 2023 09:30:38 -0800 (PST)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ee6-20020a056870c80600b0016dbf59175bsm7379353oab.47.2023.03.09.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:30:37 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] test: don't print aggregate-results command
Date:   Thu,  9 Mar 2023 11:30:32 -0600
Message-Id: <20230309173032.959968-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309173032.959968-1-felipe.contreras@gmail.com>
References: <20230309173032.959968-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no value in it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/subtree/t/Makefile | 2 +-
 t/Makefile                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
index aa204d43b6..093399c788 100644
--- a/contrib/subtree/t/Makefile
+++ b/contrib/subtree/t/Makefile
@@ -74,7 +74,7 @@ aggregate-results-and-cleanup: $(T)
 	$(MAKE) clean
 
 aggregate-results:
-	'$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh '$(TEST_RESULTS_DIRECTORY_SQ)'
+	@'$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh '$(TEST_RESULTS_DIRECTORY_SQ)'
 
 valgrind:
 	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
diff --git a/t/Makefile b/t/Makefile
index 6ce79849e1..88fa504957 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -140,7 +140,7 @@ aggregate-results-and-cleanup: $(T)
 	$(MAKE) clean
 
 aggregate-results:
-	'$(SHELL_PATH_SQ)' ./aggregate-results.sh '$(TEST_RESULTS_DIRECTORY_SQ)'
+	@'$(SHELL_PATH_SQ)' ./aggregate-results.sh '$(TEST_RESULTS_DIRECTORY_SQ)'
 
 valgrind:
 	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
-- 
2.39.2

