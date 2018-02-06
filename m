Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378681F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeBFATz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:19:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35903 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBFATy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:19:54 -0500
Received: by mail-pg0-f66.google.com with SMTP id x25so169086pge.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44WSXDrhWgUjU8Kl/S9RzUIdwAJhPDWRrhyAOQOgut4=;
        b=PYymKtktEsH4uVFCQkhshelFAw7m+O6syv/8SK5r637szEbcasuX9IeJDdSIodfw2p
         FuSKndZfWuP6Lx2nlT6pZT2PwfpZiujW1Psd/FfrDlnaB59bv8KtAvimNzHX5Va+bOVf
         mlaFz7tXg8g1vCOajwS9PguZpQCXSHwxDHBl8y32Gp4CcpR6Je3MM2Hk+DCCBySPfE1L
         len/LqlyFHjKoUk7a3jJNObqDj2FM6fmU+DfooNsf/jm057w3Ejwa2iznV/7wJqsrSOT
         vw4MgFTpLSmztvUwhDiM/6Np+QFEoy207OprYQMZl86EN65H+qONFc0N85R8z2MoEl8E
         iYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44WSXDrhWgUjU8Kl/S9RzUIdwAJhPDWRrhyAOQOgut4=;
        b=kuykXGrNZZNWgHFWFqnEZIn3SsHOSxqEUGp8wMO/HJe4FYnEPvk5lbuEm6sbVRCzep
         WI6rc1BiY1rGax/xqb4mqH0Vudl+emSVmra/yzzCQi9RPt03LFE11lxQlO2pdLpR12eh
         /5R/WxhVdpoxECq/IUnX+8lzkJsX1VMKijvGgXP2iy8EfpWkIUaTmxvWYHioCiNODenE
         FNqgnl4q40SmdZfIKUUKwr1VUKKTdeaMl4r4A539KlSAy+oDN2nNPM/3vXGkGNchIJyE
         L0laoffqdMj3f4j5t5wDwkIseQCLJL8J5IbJatkNtuGdB6H1mCMjrY+yRsMMudd/4WwJ
         W0nQ==
X-Gm-Message-State: APf1xPAOXM0aqmSb8vnQoYXe4p4tqqGs5M2IeYCrDTlfVQjCEjvDWcWZ
        KTw4o+DRymiTDa7QLE4FBc1Mz0z0694=
X-Google-Smtp-Source: AH8x227fGYrtVLMxtyC8AM+85jSrP6fJa1XFshvsb0XCc/Qxm2VrzoihYXDnwxqD54acyF28FTCbpg==
X-Received: by 10.101.69.67 with SMTP id x3mr434057pgr.69.1517876393269;
        Mon, 05 Feb 2018 16:19:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o82sm21742716pfj.73.2018.02.05.16.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:19:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 111/194] object-store: add repository argument to read_object
Date:   Mon,  5 Feb 2018 16:16:26 -0800
Message-Id: <20180206001749.218943-13-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of read_object to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1_file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9ef25e6154..e62595e3e2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1319,7 +1319,8 @@ int sha1_object_info(struct repository *r,
 	return type;
 }
 
-static void *read_object(const unsigned char *sha1, enum object_type *type,
+#define read_object(r, s, t, sz) read_object_##r(s, t, sz)
+static void *read_object_the_repository(const unsigned char *sha1, enum object_type *type,
 			 unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1369,7 +1370,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		lookup_replace_object(the_repository, sha1) : sha1;
 
 	errno = 0;
-	data = read_object(repl, type, size);
+	data = read_object(the_repository, repl, type, size);
 	if (data)
 		return data;
 
@@ -1701,7 +1702,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 
 	if (has_loose_object(sha1))
 		return 0;
-	buf = read_object(sha1, &type, &len);
+	buf = read_object(the_repository, sha1, &type, &len);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
-- 
2.15.1.433.g936d1b9894.dirty

