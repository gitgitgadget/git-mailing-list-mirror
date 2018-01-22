Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3611F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeAVLFA (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:05:00 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35425 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeAVLE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:04:58 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so15998386wme.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=4HFe+561zdpiE7tEhQw/JLlpxc2NdI0tO9rUqT9qUpE=;
        b=bBEp6Oii9kFHggjsXL32Snj+mwtWcDXh3vCYAzHbDrqMnJbbwpOrE9k8dSR9xMUMq2
         VP54EmkcOcf0u4k//Nz9GXk6+5d6Jp/mOKFMNNUb4A2qqXTx6adtat6Szbyh6vL1glAa
         VluB5898BqlgOI/7EQQQrqR1+BS2n287qoVQSumyflkD/+F+nb/irrv7NFoO5lPOEwcw
         /wbNu+bc0Uip3FAcDOw0W2i5GXxFQldALqIA4l7aoi6wlE9cK+1RiMWG6s8/vfRfVYw/
         dKrewFSf9MkY2fiZBAraA0BnBt+X4IViwnFJjCJO/SBx7kB3zeTBF6NZ9UiodhHmITEy
         +iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4HFe+561zdpiE7tEhQw/JLlpxc2NdI0tO9rUqT9qUpE=;
        b=p3KIUc23MaHJ/BW/Rr906UeYNAzEsYRt72iu3RiEuv9KGSlvf7WdWev9PKDzFUmmKi
         sfkb/KmyJ34D2OW7/NfLTa6c+UaKBD5W1U9cy82woR4u5YXmFysUa4d4B42+FvS8sqGb
         e9N8hcWnLACDYw0h1IqUApczDyl4BNyZJHt+KHYjbXRVugMsJm8KytV7VA/CunJs6yvI
         vgU/IjZj9QkJedJN53d2xp4SOnLgGVJ0rzasvhTONk+vFW7VMo0Ife1t5TLQ+AovkeNk
         LVZLkLo30+O5oiFz80hVdOHwfxMbPbI1ocU6KdTOYQYA2dwVPL2cP9GVsCgSeIDLQwJ+
         YTFQ==
X-Gm-Message-State: AKwxytdaTnyFYv0GhfqZpoCGsWjsh/z7x0MHvHdbz4pjeq7ygwTLkqln
        lmD75VtqN1+LqoPEAVfzQ51voDvv
X-Google-Smtp-Source: AH8x225Lh6r1P8N3Xs9XhexpGf0T2MoEuD4FVDZhI1rlLT8eskuOlVt34G+kQyXfdSENaYGsJrKL9g==
X-Received: by 10.80.146.211 with SMTP id l19mr12948188eda.152.1516619097123;
        Mon, 22 Jan 2018 03:04:57 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:55 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 12/14] sha1_file: convert force_object_loose to object_id
Date:   Mon, 22 Jan 2018 12:04:35 +0100
Message-Id: <5856101d9591591f112501e2a438773b2503cd59.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
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

