Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE0B1F406
	for <e@80x24.org>; Fri, 11 May 2018 17:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeEKRVD (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 13:21:03 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36167 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEKRVC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 13:21:02 -0400
Received: by mail-lf0-f68.google.com with SMTP id t129-v6so8967348lff.3
        for <git@vger.kernel.org>; Fri, 11 May 2018 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OmWNbJfQQf7tJHf0rklIG598azp+k6SZ9SmasttFe3A=;
        b=G/Yf4/Dh+tVRfnzFwe2r3i2OTpcxIUzNYWfR4EZzuUraxtJZ6pbmTq/Y1nzA386S0u
         0JkzhxiquwW2poroDtygirglP29bTM8B6DVODyoKDLZlTEKNLgKn9iddvPdxo755V0k6
         ZQEdRxjEPFUX+D7lvc7Ysy5w2BxTlhfeLOjwRTxeLggHkr3Se0zLeuBWiDx52wXAk6BE
         cPF6hi+39IeLhS9XYC0i0uFg/h8+DNW0SRp9WA4CP7YCTuBzm50E+N8ox3Z9D9Avi/tn
         U8I/UAZuVH45apfLyVYtphwFFYGpwFjUHIbZNrRO+nB/K3HF9XNsKPq3oL8MfkjgVHvV
         EyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OmWNbJfQQf7tJHf0rklIG598azp+k6SZ9SmasttFe3A=;
        b=ZneAGOWXw13wwVoUs1ddgm4izriGIJm3Btzdkta2+EZEgsFgBdzJhT4For5PLowZQ/
         WGb5iVqHWkKsKRElyPnQFgSGiL+XPYJ3KTWioO5lwL+d2SmY6q8/ze57thAXbppvx+tZ
         VV/nUxipXD/FV8QLF6SJawRp9aQGsKlgskzz/pxrx9nRqcfVlUQnhueMwwBIaCoD5ioc
         C0hFmCa0rmsGGH0o2yzRTpA8yjfHwOp/MEl2iOEncOWTl6t6VqrFskkbDUKSkVabjC9m
         WbHAqzHzNTRXgzGg3BvOf70kOdZguV931c4Q7Edi8OuTXs13NRZmdO23AsD/KOOmwbQ2
         79vg==
X-Gm-Message-State: ALKqPwczQS89cg+SkoZ8CWtuw4V4VCnWryuSs/bzysp0TZWfQbGLGUJt
        ITyXS2nklsc2ytN2xQGdTnDrEw==
X-Google-Smtp-Source: AB8JxZq1MGmpgSbDc1rcGXUpLslBus5iYKHZ4cmz3vpSWvlFJjVCqTcNbA6xPaKDAvPriZ8GNYJq+A==
X-Received: by 2002:a2e:3806:: with SMTP id f6-v6mr4991838lja.25.1526059260975;
        Fri, 11 May 2018 10:21:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id m81-v6sm743672lfi.1.2018.05.11.10.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 10:20:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] commit.h: rearrange 'index' to shrink struct commit
Date:   Fri, 11 May 2018 19:20:54 +0200
Message-Id: <20180511172054.7684-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On linux 64-bit architecture, pahole finds that there's a 4 bytes
padding after 'index'. Moving it to the end reduces this struct's size
from 72 to 64 bytes (because of another 4 bytes padding after
graph_pos). On linux 32-bit, the struct size remains 52 bytes like
before.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index e57ae4b583..fd1cbe7263 100644
--- a/commit.h
+++ b/commit.h
@@ -19,11 +19,11 @@ struct commit_list {
 struct commit {
 	struct object object;
 	void *util;
-	unsigned int index;
 	timestamp_t date;
 	struct commit_list *parents;
 	struct tree *tree;
 	uint32_t graph_pos;
+	unsigned int index;
 };
 
 extern int save_commit_buffer;
-- 
2.17.0.705.g3525833791

