Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15891F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933233AbeBMBXQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38821 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933195AbeBMBXP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:15 -0500
Received: by mail-pg0-f66.google.com with SMTP id l24so2708473pgc.5
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GRevDkERx7jOdqGtG/UP6J54m+EB3oM8Bt6vEHkFzSs=;
        b=Xhw1OVsQLcMka3/VvaTql80d4ECY4Zz0QpH3nuRh5mCxBm2RCpZdrBEC0DCmbEDpgi
         9ySiZsxhEAh6KSXH/KUqkuJSG/OIjQ9sgkbYzwYKhyEPG8AAWTo0PEONQH6VX9vQT4RF
         WZd/GkLUoJWGOukhqVJW17T50lo6z/DaTbuSszFbSDX8/mrfV7hCUv+kag5ELk2rakjB
         MrRhS/GlWBUDGUufcluh0fRcD4BqqH5UCUhR0WpDGPNzes1hPxmjiYBkRj2Y1ebXB1VS
         MI7JVf/85SY4UwoHP5868v0/timZKhU6ZHTU1Ktx9dy1nLqQDtQ2yJodNSOdyKqxzs6V
         R8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GRevDkERx7jOdqGtG/UP6J54m+EB3oM8Bt6vEHkFzSs=;
        b=ucbYA0aCcbolzdd3j7u8IMhCry+DjSmobSRe/X4jVY5r17eJjgAKCzbTDSL2W1Rsft
         9YOt2Yw6lcqg/7x9ina76DBAW9HWbN+nAzFcDqh8Vzbq9lE0xp0ODRj5YsPfAzR7ssoW
         mjVVfbdo62Gt6gZeXyqIQvLjVjGYtJJA9kDOP+OqlSQWVHeg6gSXz3fQzE4eu0GIsNYQ
         CH5tMVojcY5edA78bqj69AJbIljS2PbGzix2bdgPlMEKkW9mj7lXFutV8hmPjmmhdUGu
         NtYgoVNqWbrdikl8KHkc4kBXdX79pYXKslBwsrKq5dVQ10S7H1Rqo77c4Q506MwoSoSy
         MyMw==
X-Gm-Message-State: APf1xPC7tBqCzE4HI1OlXAqTAk0aueYK1E0m8vud3jYkJwa4BFwkcUYb
        rGgeOkkJXSOU2Xxaa9Q7Iji6ujqYbB8=
X-Google-Smtp-Source: AH8x2279IZxxiFH7h1woUwVZpra4cOjUDwxM2qDHwZVwyidO5PDW/BWctJkXWcsMcETjB17SoyOBEQ==
X-Received: by 10.99.177.4 with SMTP id r4mr10685619pgf.245.1518484994464;
        Mon, 12 Feb 2018 17:23:14 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o63sm31638654pfa.101.2018.02.12.17.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/26] sha1_file: add repository argument to open_sha1_file
Date:   Mon, 12 Feb 2018 17:22:32 -0800
Message-Id: <20180213012241.187007-18-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the open_sha1_file caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1d81bafe56..e9e01fb471 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -899,7 +899,9 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_sha1_file(const unsigned char *sha1, const char **path)
+#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
+static int open_sha1_file_the_repository(const unsigned char *sha1,
+					 const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -938,7 +940,7 @@ static void *map_sha1_file_1(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(sha1, &path);
+		fd = open_sha1_file(the_repository, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.16.1.73.ga2c3e9663f.dirty

