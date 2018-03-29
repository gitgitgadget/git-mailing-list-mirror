Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5801D1F424
	for <e@80x24.org>; Thu, 29 Mar 2018 10:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeC2KRN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 06:17:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39103 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC2KRM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 06:17:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id f125so10521001wme.4
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iEKISdbupGDvPl0mY5xrfmu4rXS5sogZvabs96sbByU=;
        b=rJI1yrIE6uox6m1++43zYckWKI2AlCd8tIvwkxkOeYNdpigCSfB9e9HVvp2YEpyT17
         CFlW0it4EPJx85kTmqynTBPwrlngCHwPkKFFgyIKsOD0Ho8GiwQz1ErXP+S9+57bfzHs
         xJRnkFyRuVS4r7ZXf3071ydEEM2ArxhmwISYSeSrX9PJWVm4bdAQn4UQ/WfW2e571Up0
         WxpimhRTrDv6TflA3WJgu0kYNTA51S8Mrk3yYnsVJSYue0zsWqLkOGSV5CAV3jewdGxP
         TN1TY+ztIR6ONg6BjR0kGS5CmEdISt5T4K3wQYbFsmJWzMmK+ToEuasYMzatWkGX+gv6
         MRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iEKISdbupGDvPl0mY5xrfmu4rXS5sogZvabs96sbByU=;
        b=A0gUiwsbKGmfPZ2d88EplZUd88gqWR3QrtNeG8JNO5AB02n1s7wk3Xd1/hXAf8KeEl
         3X8HdKwukixxmv3ACkJsg64i80DXab63RaP11VCy94GQ9PXOTleZSKx7bRXWNqKZfMI5
         IER0+3HeZcj1QTQhhwKe0WuDUJeTDcMDLMUEXB7kww6DPh1br3a0KuUdxZ0EeY1U/hHM
         J5Ro5IQZyvslSmMLc8587kTigmUQUvq+K0kEuwx31bKJfILUWVs2tlxF0EvAz19GPWa1
         QqtDZGBBJU4aV5fmDfYv0Tit1MPDAv9+t/5Vs4LPzB3gT8YSn/TNhuF4xIz3hpoKKUrS
         cN8A==
X-Gm-Message-State: AElRT7HZ+8lHAYJKnb3S21B1HnNCLhq3CUvfRQu4rkKh79KfNoVqEV4Y
        2xHDbPu+ZpjNzORmhEOTQ73c/JxV
X-Google-Smtp-Source: AIpwx48EYrCD/sqQyiW/EYpK8azZolj/RKt8xELf2+I1G765Fi/bqPujireVZgIqjSBSPrYYyXcFmg==
X-Received: by 10.28.55.129 with SMTP id e123mr5109056wma.141.1522318630796;
        Thu, 29 Mar 2018 03:17:10 -0700 (PDT)
Received: from voidlinux ([41.136.242.154])
        by smtp.gmail.com with ESMTPSA id p15sm2183681wmd.7.2018.03.29.03.17.08
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 03:17:09 -0700 (PDT)
Date:   Thu, 29 Mar 2018 14:14:18 +0400
From:   Loganaden Velvindron <logan@hackers.mu>
To:     git@vger.kernel.org
Subject: [PATCH v4] Allow use of TLS 1.3
Message-ID: <20180329101418.GA7736@voidlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a tlsv1.3 option to http.sslVersion in addition to the existing
tlsv1.[012] options. libcurl has supported this since 7.52.0.

This requires OpenSSL 1.1.1 with TLS 1.3 enabled or curl built with
recent versions of NSS or BoringSSL as the TLS backend.

Signed-off-by: Loganaden Velvindron <logan@hackers.mu>
---
 Documentation/config.txt | 1 +
 http.c                   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce9102cea..f31d62772 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1957,6 +1957,7 @@ http.sslVersion::
 	- tlsv1.0
 	- tlsv1.1
 	- tlsv1.2
+	- tlsv1.3
 
 +
 Can be overridden by the `GIT_SSL_VERSION` environment variable.
diff --git a/http.c b/http.c
index a5bd5d62c..f84b18551 100644
--- a/http.c
+++ b/http.c
@@ -62,6 +62,9 @@ static struct {
 	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
 #endif
+#if LIBCURL_VERSION_NUM >= 0x073400
+	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
+#endif
 };
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
-- 
2.16.2

