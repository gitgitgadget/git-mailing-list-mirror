Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266CC20899
	for <e@80x24.org>; Sun, 20 Aug 2017 20:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbdHTUJs (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 16:09:48 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38279 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbdHTUJn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 16:09:43 -0400
Received: by mail-lf0-f65.google.com with SMTP id y15so9171802lfd.5
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YW8Gpzj5YgjiHTSprqh1umhBJ3x3IT2YrXgAEGvCTgA=;
        b=C45T35gv5RV3X0XeUh/HaQLAkFKM9ciJ7A2vlHYLFqCG2RmamDsekK3syUbigYGsy3
         1XCZmxr1PLk+htQ6+iUVtCLbel4VjlR5d+vjT15C0dQ36FLdIHLHhFUIf7/cuZaoTQSz
         ggrhO8qPn8Wy2e/DHdPjmTVtWKN6JxV3/AEjYBwJpox7pZNhn73n6nPudjpLrC/shM7B
         chy6Ji7R28YyWyXFcwDq7l//h5e9Od0wKz40aFmTU7uFZfWsKtZeSY9t1uGF+6YPRzS8
         9J4JSyqwwAwVpzXP9OIZpc8+X7yxzPC232uJHYomP7Dgbwxz9nFs5/BggdwVLSuTNMYk
         AAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=YW8Gpzj5YgjiHTSprqh1umhBJ3x3IT2YrXgAEGvCTgA=;
        b=RxLkNdeSpO15nxHa3jPczPVQEl2mbua9sAB+QUrfhl+wLLrKeTvJBRgS8nMwFxCIJK
         ERcLnbLj1MUeUC9pyDEJiAYrTUCuvXJhhUdX0YfLTvZlH0M5f3kal91JJe+K6n/AXR2t
         WsM8coMFHPQVFp+BpMWH4BrX3nb/SPHQvnrii4FK+N0D1BmX3+YZXPkJAqY5AxMNHdiW
         zoSROZKkK927ynpq0G37lPrJAU0wwHbEYXbVq/Eq89Pbh6+GfMfABPtjzHVZ5pP16ALF
         a5+wCLf2WMKrFNXIwZeVmMld7pu35HTAe2jpFm0MPhaqzzpMP1fZWKrlf2eJxaOWUWpW
         xdDg==
X-Gm-Message-State: AHYfb5igdSKkUV+sKTMmBqHBL7767foaOcSVT/QApbO5gyVOdGlm5tJN
        /9klSsJ0pedMmjFtsVw=
X-Received: by 10.46.9.16 with SMTP id 16mr5988591ljj.155.1503259782283;
        Sun, 20 Aug 2017 13:09:42 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id a64sm928869lfl.36.2017.08.20.13.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 13:09:41 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 6/6] sha1_file: convert index_stream to struct object_id
Date:   Sun, 20 Aug 2017 22:09:31 +0200
Message-Id: <e15140dfb7b19a1bcaee23889d62bf05ad6e89be.1503258223.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 sha1_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3e2ef4e..8d6960a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3655,11 +3655,11 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_stream(unsigned char *sha1, int fd, size_t size,
+static int index_stream(struct object_id *oid, int fd, size_t size,
 			enum object_type type, const char *path,
 			unsigned flags)
 {
-	return index_bulk_checkin(sha1, fd, size, type, path, flags);
+	return index_bulk_checkin(oid->hash, fd, size, type, path, flags);
 }
 
 int index_fd(struct object_id *oid, int fd, struct stat *st,
@@ -3680,7 +3680,7 @@ int index_fd(struct object_id *oid, int fd, struct stat *st,
 		ret = index_core(oid->hash, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
-		ret = index_stream(oid->hash, fd, xsize_t(st->st_size), type, path,
+		ret = index_stream(oid, fd, xsize_t(st->st_size), type, path,
 				   flags);
 	close(fd);
 	return ret;
-- 
2.9.5

