Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814FEC4743D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 17:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6920B613F9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 17:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhFDRqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:46:16 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36370 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFDRqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 13:46:16 -0400
Received: by mail-wm1-f43.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so8398792wmk.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fhJvnhnH40DJ4DKtvwKPdjwjeAWKhE6qvu1LmDaLYeE=;
        b=cfpFTLnINDwWTatugInRYc//iY8fe8BggMRizDXS3SObiIUT7P9Kmzsa+NN50GiAaB
         ShAst9MCmI/JWYthpcFLFIe/yEMCQiNQjVelMDeGgBiGbGQocsLzBAvnUUtk+9UlbTAu
         4uX8xEKe3YzX5HJpxEfO3/IyiKKIE7nvI5k8Y++pPYPjlZR6oP9MWyxLiPBFakwGQbdp
         R9Hqmsa0TvzemWTE3rSV/PbN7M6VhKrJqEkYTPkPG921dmmIy7xD5diUZKdXasE9dk67
         4unMBrGwn/l0qAzZK1Zy0i1VTWIgwi7NXZz6th9Zi9+rDLTLRoqQKIJNaniKo661PhZp
         gloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fhJvnhnH40DJ4DKtvwKPdjwjeAWKhE6qvu1LmDaLYeE=;
        b=Jl1mJTHyJsSnMO+6anhagu354VM6wiJg8hfjTyXbZLtqwVJR2dBeVfJwXQt0PQuBJk
         dfVJTWGbjjrtRx6LpCi86rh+d6B7D8zCu2UBPmRNOc2PIPGWoVbfKMv05FzS2oO67LaI
         h97PP8iPDfrT8lOl76By8SRP/SEDetILdcQ3uzn8CMVXm900puB0nfS9wf50fopkB6jJ
         YVlxSqdyo7AWMJbZxArlpzUIsOqifLaft0bFb9XevPZGqZfHccrRf9FXGs1RVeHFMubw
         eRRlMcJwgxSN8xDtILzk7PWhGo+DzcmbmbUy4rRtGjUDiHIvCdo6IQ2yckmok53ozxTQ
         +5dg==
X-Gm-Message-State: AOAM530txtXMwSfm/QYGRZ6ykZ3XqNckAQyl2TvZGr3XguiwfRITTMMN
        otd/1jv/7dTg5Z/84ztA2aQsJEh9Slo=
X-Google-Smtp-Source: ABdhPJzJJt+/xnb8NHbmFJoZuPuY3NVTwm22YJfSoBEEUsfLlQoOPxcgl+Bd9pEAvcadYOxNuqDbaQ==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr4721921wmk.25.1622828608799;
        Fri, 04 Jun 2021 10:43:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y189sm6460564wmy.25.2021.06.04.10.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:43:28 -0700 (PDT)
Message-Id: <07763a9de723af8674b707ba762845fd414bd0a6.1622828605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.970.git.1622828605.gitgitgadget@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 17:43:25 +0000
Subject: [PATCH 3/3] cmake: add warning for ignored MSGFMT_EXE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

It does not make sense to attempt to set MSGFMT_EXE when NO_GETTEXT is
configured, as such add a check for NO_GETTEXT before attempting to set
it.

suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 99150c8f5853..ea43a4f9cc9f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -190,14 +190,18 @@ if(WIN32 AND NOT MSVC)#not required for visual studio builds
 	endif()
 endif()
 
-find_program(MSGFMT_EXE msgfmt)
-if(NOT MSGFMT_EXE)
-	if (USING_VCPKG)
-		set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
-	endif()
-	if(NOT EXISTS ${MSGFMT_EXE})
-		message(WARNING "Text Translations won't be built")
-		unset(MSGFMT_EXE)
+if(NO_GETTEXT)
+	message(STATUS "msgfmt not used under NO_GETTEXT")
+else()
+	find_program(MSGFMT_EXE msgfmt)
+	if(NOT MSGFMT_EXE)
+		if (USING_VCPKG)
+			set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+		endif()
+		if(NOT EXISTS ${MSGFMT_EXE})
+			message(WARNING "Text Translations won't be built")
+			unset(MSGFMT_EXE)
+		endif()
 	endif()
 endif()
 
-- 
gitgitgadget
