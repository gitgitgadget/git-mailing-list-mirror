Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEACD1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 09:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfAYJvc (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 04:51:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39582 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfAYJva (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 04:51:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so4011561pgl.6
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 01:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mehImfjZXdLdqpiYsFmJlOOcLtCHOtQJsqvacFyAsFw=;
        b=BvnBkOLQ3jUFUthtGokgq0No68lAm1GdMUga61tuaA2akVfb5houqfWsJlBXBdbK9b
         2+HCp7FVg5IRpL2q6V4MlA8ejBnjCe9Mq/Xn7Ck4yV5AhgzXRHAD/DhnG0hu/Z2cuaJH
         02784EB2lwWYuLt2pecE+dJn13Vuh3UlDQZdXGPw3oFFFGgL0CggqRv6iGzSCKRSWujW
         WMR5Wu3UPrio8qkNwG1TvtBlSI3n9xaPCdv+180Q+BYU3Ir05a1wH1X1S31HrLwDO6Tj
         Q9e4o6hrBeXgrm/AVEl3mOM8UGvZ9petvQnwe2NhH33dTqeN5actVaqbRxslNvYORhfy
         LeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mehImfjZXdLdqpiYsFmJlOOcLtCHOtQJsqvacFyAsFw=;
        b=Z7AGOpQN/sn6MuSmYPJL8+kQvB52fAyi3dE2Cl25TPxDoD8wfDvuygYT4zhmJyWCKZ
         73zON7ZZK7Yoro/G5g1dBAQTyDg8B1/V0sE5V3YxB05Dr+MGxV1eYuGdSoFzYVpAwcl3
         LtGUiBY0dvCVz93Ps/NVHkX+p0Wedz8DOI74OKvWvsKWgPVAfrUM1VAABQkX6H6Ilk2L
         4ceIP6IHkoKIWa6eAU5nNYT2+pmvmNz7OSncWz4mqKbcPKntoW0Ig7rXDjJUkTD3tuNc
         /A7qVGVwy/v4T+23auK2Nsxo8JXAZekrioz5KBRcooxB5rOqX8YOUOf10S78pzkTt/H4
         62kw==
X-Gm-Message-State: AJcUukekVqrosMVEPhlboYePDdcanH0exqmpysmLkGzr3K6DzH8T7bGC
        Ki1PvsZy7MsA/2NpVvRSrAIuRBow
X-Google-Smtp-Source: ALg8bN4YLM5AG9Iq+lpJ0VdXj0cJBgItv+PHAkkcaoImet3O8cvSgEoLEROikOpiq/ZDN4fJgnuFpw==
X-Received: by 2002:a62:cd1:: with SMTP id 78mr10196003pfm.219.1548409889429;
        Fri, 25 Jan 2019 01:51:29 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 6sm50764408pfv.30.2019.01.25.01.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 01:51:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 25 Jan 2019 16:51:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] fetch: prefer suffix substitution in compact fetch.output
Date:   Fri, 25 Jan 2019 16:51:22 +0700
Message-Id: <20190125095122.28719-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a remote named "jch" and it has a branch with the same name. And
fetch.output is set to "compact". Fetching this remote looks like this

 From https://github.com/gitster/git
  + eb7fd39f6b...835363af2f jch                -> */jch  (forced update)
    6f11fd5edb..59b12ae96a  nd/config-move-to  -> jch/*
  * [new branch]            nd/diff-parseopt   -> jch/*
  * [new branch]            nd/the-index-final -> jch/*

Notice that the local side of branch jch starts with "*" instead of
ending with it like the rest. It's not exactly wrong. It just looks
weird.

This patch changes the find-and-replace code a bit to try finding prefix
first before falling back to strstr() which finds a substring from left
to right. Now we have something less OCD

 From https://github.com/gitster/git
  + eb7fd39f6b...835363af2f jch                -> jch/*  (forced update)
    6f11fd5edb..59b12ae96a  nd/config-move-to  -> jch/*
  * [new branch]            nd/diff-parseopt   -> jch/*
  * [new branch]            nd/the-index-final -> jch/*

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fetch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0140327aa..e0173f8a33 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -629,9 +629,14 @@ static int find_and_replace(struct strbuf *haystack,
 			    const char *needle,
 			    const char *placeholder)
 {
-	const char *p = strstr(haystack->buf, needle);
+	const char *p = NULL;
 	int plen, nlen;
 
+	nlen = strlen(needle);
+	if (ends_with(haystack->buf, needle))
+		p = haystack->buf + haystack->len - nlen;
+	else
+		p = strstr(haystack->buf, needle);
 	if (!p)
 		return 0;
 
@@ -639,7 +644,6 @@ static int find_and_replace(struct strbuf *haystack,
 		return 0;
 
 	plen = strlen(p);
-	nlen = strlen(needle);
 	if (plen > nlen && p[nlen] != '/')
 		return 0;
 
-- 
2.20.1.560.g70ca8b83ee

