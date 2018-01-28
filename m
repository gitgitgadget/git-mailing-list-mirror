Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BD11F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbeA1ANq (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:46 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37748 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbeA1ANi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:38 -0500
Received: by mail-lf0-f68.google.com with SMTP id 63so5046853lfv.4
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=4HFe+561zdpiE7tEhQw/JLlpxc2NdI0tO9rUqT9qUpE=;
        b=tb88jatFCjgZgOo4yZolrBPDd1Ut4IwbLbdtZoeMlyj1SnkHnfYLXOqJxZERUUF6oZ
         I89isa11uECoV640ZbGgdknWuNyXXh3TTVhTn4JFlnyj9lt/zObhjCcgvMdH0hV2Ry1e
         N5C6RcgvzC7uSukCn3ReUdfTtpfpm/KPE8plJ4GA3EYtCUyf5HpekPZtTbMmUItme+yI
         w3KcaEk9/+wz1EJZiud0HfLXgXsQvF0K1qbsZvW61kddE6yj9YRJP/GFRnDC34rFP3iB
         OQsxnTPe+q/mjsNqpEQrfs45EPWoJchc5ZB+Sebe9m/VI69R25LRRq7KkosidG7gRQWH
         G/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4HFe+561zdpiE7tEhQw/JLlpxc2NdI0tO9rUqT9qUpE=;
        b=Rf2K9mrrIA4k0KYG5fsDbU6PKpFfIhkYlhlWDWmKw47tvKdWeW+p4NPBOguCThtKkh
         oBLOzNAmbCKM9r8oQYqbClGqa0U9HgenjlxzBWBlqhEW7XuggZauv62M09riwvbXm3oP
         pXtgPU1ERDUi0Ay178yIlhQU6x6Y7RbkeVj+EJAqxHY1oZxa1gNe/aM7Oo28TmC6GCT+
         OGB+lTvJ/QSaxQbwXlpLQIU4eZUx570JWHEqfMoG4Nw7UYxMg6unsA053JQLOqCrMQQQ
         6fCageYEeTp5MydNksNtWB1aTeCcvn0Zm9sqJsuTc3tOhuTTsdcN04tSS++fcOalCd7v
         H6ZQ==
X-Gm-Message-State: AKwxytdkP3AlYvB4wdkLYtUW6jzxbZXWtymSY5n67kaObMWTB2B00gLl
        ad4sGqwmXdwOIxwnqY3f67xmY/gH
X-Google-Smtp-Source: AH8x224AwUpwoedJniL3hq4C8RStaQ2dL3WBFpd9C0hRzyB8BxEZuYl9sEAzq3LkAsvUL71g9zFWyA==
X-Received: by 10.25.158.67 with SMTP id h64mr10615567lfe.56.1517098417293;
        Sat, 27 Jan 2018 16:13:37 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:36 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 10/12] sha1_file: convert force_object_loose to object_id
Date:   Sun, 28 Jan 2018 01:13:20 +0100
Message-Id: <ef417ce6bafc8f6c25f8a57581235af1f709b02d.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <cover.1517097306.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1517097306.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition and declaration of force_object_loose to
struct object_id and adjust usage of this function.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/pack-objects.c |  2 +-
 cache.h                |  3 ++-
 sha1_file.c            | 10 +++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6b9cfc289d..f38197543d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2768,7 +2768,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 			if (!packlist_find(&to_pack, oid.hash, NULL) &&
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime))
-				if (force_object_loose(oid.hash, p->mtime))
+				if (force_object_loose(&oid, p->mtime))
 					die("unable to force loose object");
 		}
 	}
diff --git a/cache.h b/cache.h
index d80141eb64..0a8be9c87f 100644
--- a/cache.h
+++ b/cache.h
@@ -1248,7 +1248,8 @@ extern int hash_sha1_file_literally(const void *buf, unsigned long len, const ch
 extern int pretend_object_file(void *, unsigned long, enum object_type,
 			       struct object_id *oid);
 
-extern int force_object_loose(const unsigned char *sha1, time_t mtime);
+extern int force_object_loose(const struct object_id *oid, time_t mtime);
+
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
diff --git a/sha1_file.c b/sha1_file.c
index d1569b1b96..d9ee966d74 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1670,7 +1670,7 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
 	return status;
 }
 
-int force_object_loose(const unsigned char *sha1, time_t mtime)
+int force_object_loose(const struct object_id *oid, time_t mtime)
 {
 	void *buf;
 	unsigned long len;
@@ -1679,13 +1679,13 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	int hdrlen;
 	int ret;
 
-	if (has_loose_object(sha1))
+	if (has_loose_object(oid->hash))
 		return 0;
-	buf = read_object(sha1, &type, &len);
+	buf = read_object(oid->hash, &type, &len);
 	if (!buf)
-		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
+		return error("cannot read sha1_file for %s", oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
-	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
+	ret = write_loose_object(oid->hash, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
 	return ret;
-- 
2.14.3

