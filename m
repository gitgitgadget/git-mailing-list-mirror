Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9214C1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBFAFM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:05:12 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34169 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeBFAFK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:05:10 -0500
Received: by mail-pg0-f67.google.com with SMTP id s73so144717pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8R61dk+giVr2iUIjDEfm1rsspa7YQn99N73GdmHzvHg=;
        b=PeZcO20JavFSB5IXElnFC1YDUI6zbjfWyFzx3qCb+R9/MPQGvaQPetU1GmZ4YgJwDM
         2pPR3YCFEHv7N2m7rROgokGV2/rbeMwQiAUgAitCdEG/zTNGKFKcvBPV1tu9SJMrZhPN
         tQMA8g2BfCNhKb2UpGN/F6lmwR4cJwJ8VRcH6dRuRpLh0Q0WvwQXskHjJhiYmHOGdxzw
         u/lbRQFP1DuVpCoC+1NkRtISXuWMJADIpuKwFDmGakgRtHl8dIapOajGkh1kRYwwZag+
         Ul2V4rQQ4FB3L4LIopp2ljVd9hZ2/fgJzjWDxCnzRuFoahTD6tjdN2LT1kMr14U6as6/
         sNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8R61dk+giVr2iUIjDEfm1rsspa7YQn99N73GdmHzvHg=;
        b=X1m2AhPOjE1OUj+9340yTa5quxWY/74UWUyx2EbrhVXdKrD95e4votRI4VFJD1k60J
         OGF7MTODGegvOAB+8zRrJgh5iWguZhfi5Gt4hTwbJpjVw9o8b7JQ/5/4SfTHjAuPNN4q
         K2AVrITsC4I7x4yrXDU/9lEVElN5mlnbotpqrFv+snoZDrHsRwCRZqSJsa4p6JYkPgI6
         oqNTiu8hU5dsf0pwGMMJkeo8KpyWY1cRuFQoH3SxthS8+W7ZYtKftnlrze2jr1Z1jSqs
         K3U+WhEw2TbV/xSEVruaZRmAVzoqlf9f36r0XaBibGnj9kIMkSYJdSiyT76slusTXFpb
         teug==
X-Gm-Message-State: APf1xPBKsD55TVNhlH/eBZXAOrOIqp2NqPK8j5Xy2CVbcPmIiqxKfjkR
        +V7WcKNTK+r0zE3nrnitrZM98Cjv6FQ=
X-Google-Smtp-Source: AH8x2264JLTN6LcZyvCp3zqOxoSd21pGtQAv9MRcj145sAxVCc8pR4kPUR5qpDx6/nrSUad0Lj0qPw==
X-Received: by 10.98.208.67 with SMTP id p64mr511174pfg.158.1517875509836;
        Mon, 05 Feb 2018 16:05:09 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r8sm4112347pfh.153.2018.02.05.16.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:05:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 053/194] replace-object: add repository argument to register_replace_object
Date:   Mon,  5 Feb 2018 15:55:14 -0800
Message-Id: <20180205235735.216710-33-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the register_replace_object caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 102e009927..1479530d34 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -18,8 +18,10 @@ static int replace_object_pos(const unsigned char *sha1)
 			replace_sha1_access);
 }
 
-static int register_replace_object(struct replace_object *replace,
-				   int ignore_dups)
+#define register_replace_object(r, rp, i) \
+	register_replace_object_##r(rp, i)
+static int register_replace_object_the_repository(struct replace_object *replace,
+						  int ignore_dups)
 {
 	int pos = replace_object_pos(replace->original);
 
@@ -65,7 +67,7 @@ static int register_replace_ref(const char *refname,
 	hashcpy(repl_obj->replacement, oid->hash);
 
 	/* Register new object */
-	if (register_replace_object(repl_obj, 1))
+	if (register_replace_object(the_repository, repl_obj, 1))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
-- 
2.15.1.433.g936d1b9894.dirty

