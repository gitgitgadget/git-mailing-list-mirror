Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07E5C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 10:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbhLVK7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 05:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbhLVK7s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 05:59:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD80C06173F
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:48 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso2140921wmi.0
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tvFZ9qZCejLyG7oTZeRyM1U9KFhGJEvGDTF6g7N48ko=;
        b=LwgkYUavHT5vCqQdVyYtUHxPNJtj60PqHd0IAeP3JLX3VnejST2Jp6WjqihOMgVd8n
         z7Swttoj9616KfJbDXa9xrwKIoFjgtOF+Q8xqNzQltaCWv3Tsv3EBCK4JLSIkZmL/4C9
         kUJ56NsJrvyNhHZXokVBAOHkvKIl/2oPplJ809G1IEyX9xBpM9SohoqMfianZznoPStk
         TSdavfE2GxP5ur/THKJL5JDQkS3rGvEL/ZFw9XJbRAbh20itlo7LBAdoCjVJXNMKx64l
         vrQwkWb4SQ7vQi5qvQxYX3lzgofyGvAxQebNrWCRQLWmoC7PLDj/cKWE8PDFvGCMogER
         b/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tvFZ9qZCejLyG7oTZeRyM1U9KFhGJEvGDTF6g7N48ko=;
        b=keG5rLrFB52z2BGmSRkRXp3ZMYxz/9/M4SSWGX7yNclTPPI8S/wmsx8ZLxEPO0YOGr
         xbSelZhlLcSpQRYoeD+C05Y9NqkMbUmATiZgPHvzy+OiMrTtRastl7vRYOJqvXhO5tbc
         rnwxSN83Ln5b6wEIS3LNbw3wRsSAhNQPmXOjHvIEGbCBPewQtCdZtIoUFyqELudIuaHB
         r4F9wYIhEbsAHWi8lM2GSXMmWdSDkd1LHsfJvoQsPBCkAfFc1Vkty9XHRjDxXaxrRRq/
         Au3nhw2ZZ3ZCy1DmuqTEu4jK9NhQggaX/EbrQwqHoZQf2oukaf9hBaLU3W1yi9rjeXwf
         EbuA==
X-Gm-Message-State: AOAM53334/2FA+Nm3yyrckEtgFUIMfo/sAOTJQ1ulvLVlgRFKXgDbcsj
        VBnZGV1gG6/2otrsd0OAtOY7T7lPdEE=
X-Google-Smtp-Source: ABdhPJzUMGGy2sjYRxXgGgCePSDhcOzmZohGgomBgmvMPC3eUuMK6t2xVF5kRpisxequczCzWj/UjA==
X-Received: by 2002:a1c:1dd0:: with SMTP id d199mr550426wmd.150.1640170786595;
        Wed, 22 Dec 2021 02:59:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm1615451wrp.40.2021.12.22.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 02:59:46 -0800 (PST)
Message-Id: <e0d7dbf8b552381a9b7854f2bb9eff41508aac04.1640170784.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
References: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 10:59:41 +0000
Subject: [PATCH 1/4] t5540: require REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The dumb HTTP protocol exposes ref storage details as part of the protocol,
so it only works with the FILES refstorage backend

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5540-http-push-webdav.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 8b68bb38a44..b0dbacf0b9b 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -18,6 +18,12 @@ then
 	test_done
 fi
 
+if test_have_prereq !REFFILES
+then
+	skip_all='skipping test; dumb HTTP protocol not supported with reftable.'
+	test_done
+fi
+
 LIB_HTTPD_DAV=t
 . "$TEST_DIRECTORY"/lib-httpd.sh
 ROOT_PATH="$PWD"
-- 
gitgitgadget

