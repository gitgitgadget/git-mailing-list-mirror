Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D70C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 20:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbiEPU27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 16:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiEPU1p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 16:27:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779218E12
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d21so6040884wra.10
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xe4mMWm75qppTGdTaj8uVSs0xTobaeCr6mEjy+hpChU=;
        b=BrRHLBclhyksWmmDQeO5Dde3HLjdvxO91z+E5JjpFSnOwmN9Y0oOCIarJnGDIIF8tJ
         UNPOKgAo2frIu7aKi7BNnQ51/5K7wOs0qR0+E1JapPKHA7Twi9ynoD/wjoTiIHEi7bIi
         gPDfbRoqOiZIZJslNr97gRMyAiEadmRkhpJIFCWrxOdDl49HHOjkJjsJ3F++LezdFQ42
         CDAmSI8l4aVpFdWXX5UgINQPSwbpPfBhjm7jgl6rKDHzf8xeyptP1c7TvCqulrZviYlU
         R2Bca1H1goycR3naPw5tsnY5FIUPmRRH9DJLRX3X8+KF3IE+6JRysO5Xw25LtdnP0ZlX
         Rg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xe4mMWm75qppTGdTaj8uVSs0xTobaeCr6mEjy+hpChU=;
        b=4hZ4Kl9NhPJvTtVm/5HZgbfy1pNUxLTSTwGeH3ba6dbo+Sc5afdtemVmL2zpuPXFUl
         ZYYNZ5GfHllPazEbFqUlF3yI8gibfWg7XyBmAjVHrsTe6HPWfNCgxh0vCuiphgWl7Ulx
         uBGRVnG5yvhHozyWjJb3G7DnUE3/ZlMX//uWrQ9PcklsZ2Y7ehOGQA5+0TDBfQI+1zAc
         WFHK9x0yt8J113PfXJ9QbcWexLQoA5gXA+yJP7QuL3UvfimUulSd3CxiqbkfUGZ+C060
         nP+XHbHXrhJPNe0Awt8y6ep0Cri3GQVM7JeP4QO2wa4xafFZ3ZcmxM2xQg1jrG5VuIYj
         rU1g==
X-Gm-Message-State: AOAM53337lD+7KfSymeWSj1a1LkfNFqveg70NK2EQsvAM3qFFbmXqiCi
        8YuVggSH4jGGXaXI8Yby9dUgGkuFjf4=
X-Google-Smtp-Source: ABdhPJynyLCTgJrlHAKbwMmNDXV7g2JM10sKMkF1CJ8SPO4zhwyRVz/0el07s79IdJBPpYiuHxEBmQ==
X-Received: by 2002:adf:f24d:0:b0:20c:f5a0:be7e with SMTP id b13-20020adff24d000000b0020cf5a0be7emr12547661wrp.344.1652731874150;
        Mon, 16 May 2022 13:11:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h28-20020adfaa9c000000b0020d02ddf4d5sm3162068wrc.5.2022.05.16.13.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:11:13 -0700 (PDT)
Message-Id: <47ecf804d9ce58527b55c6217fb3b6928b8feb8f.1652731865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
References: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 20:11:02 +0000
Subject: [PATCH 5/8] http: make http_get_file() external
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, albertqcui@gmail.com, robbat2@gentoo.org,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This method will be used in an upcoming extension of git-remote-curl to
download a single file over HTTP(S) by request.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 http.c | 4 ++--
 http.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 229da4d1488..04e73149357 100644
--- a/http.c
+++ b/http.c
@@ -1945,8 +1945,8 @@ int http_get_strbuf(const char *url,
  * If a previous interrupted download is detected (i.e. a previous temporary
  * file is still around) the download is resumed.
  */
-static int http_get_file(const char *url, const char *filename,
-			 struct http_get_options *options)
+int http_get_file(const char *url, const char *filename,
+		  struct http_get_options *options)
 {
 	int ret;
 	struct strbuf tmpfile = STRBUF_INIT;
diff --git a/http.h b/http.h
index df1590e53a4..ba303cfb372 100644
--- a/http.h
+++ b/http.h
@@ -163,6 +163,15 @@ struct http_get_options {
  */
 int http_get_strbuf(const char *url, struct strbuf *result, struct http_get_options *options);
 
+/*
+ * Downloads a URL and stores the result in the given file.
+ *
+ * If a previous interrupted download is detected (i.e. a previous temporary
+ * file is still around) the download is resumed.
+ */
+int http_get_file(const char *url, const char *filename,
+		  struct http_get_options *options);
+
 int http_fetch_ref(const char *base, struct ref *ref);
 
 /* Helpers for fetching packs */
-- 
gitgitgadget

