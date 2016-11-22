Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B191FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 01:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932278AbcKVBgC (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 20:36:02 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36156 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbcKVBgA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 20:36:00 -0500
Received: by mail-pf0-f169.google.com with SMTP id 189so768228pfz.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 17:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=81w/VB6WgQd97vew9lTI9lGEX21TCXyi1wcWx9xS/mc=;
        b=dsLI9idS+/Vo6TpasccBBtIhxV4XbLho38StFjQ03AYbG1KcXRMveFtB00gzjlFu7s
         tUsoNxM8RiHDMAr5QqxA6Y5qowGBK2lIMR+1RzINAig1AFSz8euyRBazKuQKLctFeCGm
         2cZKojQop/PsVtqtfNYm0KWH120p87plKH+2ItD80TUmFkCPbBLRFM5sKUoHuOvKJFF0
         eTX9Z6z+PYFaUwMBnTBp80+hwUEuRnYD5zkoHwXwRSpKQrZbCiJtzft0SYcPySln4VJv
         9Ec17Ll5q+KhFxJUd55z3RSfc/KzFKY7XLoZPnQLz8xUHZXmQ0pW6PVFtiEcJPZTz0a/
         FDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=81w/VB6WgQd97vew9lTI9lGEX21TCXyi1wcWx9xS/mc=;
        b=guZLJ8jodmUxwjvpdshH8hFBBG4z4uWOiFa927DUkT08Ubo6on3j2+c6UlJjTyCdzD
         bsStJtsXXIR2y41zsgzbl0Zij6feu2acTs8B+mayXuDrz5ssh+o6X9eXBUSWFoZw+ywq
         Y4dZGvoXlJt4oBmS7UyOttczaUO1X5wSv3GVHPDHwQ5DP8HhlTNf/b0mknv3L5GcrDNl
         SnqEq9SlPtn6oqvPxbadOvIGnWDzwDN2mmsSYCLFJ6GyCupKAE4efh+LKQg/3Kk2OMW1
         xQifiWrU9+iaAQCpZRW5jKEFCfgKYqR84616EiNzRpHfDHULpuy/zj0JMA6RO3T0wBx8
         3mfQ==
X-Gm-Message-State: AKaTC03VYhTJFL5m2GBnTBocy7AWI2oGS68trEBlNzPLCSQpDjPU/Gy6IMsKUlX0qmWDh16g
X-Received: by 10.99.5.21 with SMTP id 21mr38638992pgf.32.1479778559876;
        Mon, 21 Nov 2016 17:35:59 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id a24sm24181264pfh.57.2016.11.21.17.35.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 17:35:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/3] submodule config: inline config_from_{name, path}
Date:   Mon, 21 Nov 2016 17:35:48 -0800
Message-Id: <20161122013550.1800-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
In-Reply-To: <20161122013550.1800-1-sbeller@google.com>
References: <20161122013550.1800-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no other user of config_from_{name, path}, such that there is no
reason for the existence of these one liner functions. Just inline these
to increase readability.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 098085be69..15ffab6af4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -471,18 +471,6 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	return submodule;
 }
 
-static const struct submodule *config_from_path(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *path)
-{
-	return config_from(cache, commit_sha1, path, lookup_path);
-}
-
-static const struct submodule *config_from_name(struct submodule_cache *cache,
-		const unsigned char *commit_sha1, const char *name)
-{
-	return config_from(cache, commit_sha1, name, lookup_name);
-}
-
 static void ensure_cache_init(void)
 {
 	if (is_cache_init)
@@ -508,14 +496,14 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name)
 {
 	ensure_cache_init();
-	return config_from_name(&the_submodule_cache, commit_sha1, name);
+	return config_from(&the_submodule_cache, commit_sha1, name, lookup_name);
 }
 
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path)
 {
 	ensure_cache_init();
-	return config_from_path(&the_submodule_cache, commit_sha1, path);
+	return config_from(&the_submodule_cache, commit_sha1, path, lookup_path);
 }
 
 void submodule_free(void)
-- 
2.11.0.rc2.18.g0126045.dirty

