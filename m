Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86CBB1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933263AbeAXLMp (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:45 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38218 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933235AbeAXLMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:25 -0500
Received: by mail-lf0-f66.google.com with SMTP id g72so4717390lfg.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=4HFe+561zdpiE7tEhQw/JLlpxc2NdI0tO9rUqT9qUpE=;
        b=Na3BMLxpuS6BR/3UjkRgF1eUiMvUPc4nqmTmu2jBCWplSnaQv8zq/x1BCSahdla6Re
         S7Z9n3yEY8/UOjOXPGtVx3Nh3GQvX/E0RjhG5Qg7Q7Q7wFhDsgWm2hFvFwNcA81Z9lYY
         8HwrmiMLemTT6c9MMcyu44CC864kdKJmsg/y0TLf9TTSg6umwJbgKMhHK10WbKo/xi+H
         twoXRIMpR8SmHWnUEa27LGg5iEgvXsPk1ql0EPdZfnCljEd4Rxtk9MBcSZ9S4rjTHW9I
         Jf6rcHSCTTNd01GCmeGnkJcPbS5JGB+4yjKy9d41BtlkHCg2QBFYT2O5g0smrW7QTVsb
         YGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4HFe+561zdpiE7tEhQw/JLlpxc2NdI0tO9rUqT9qUpE=;
        b=VdtrXWSfC7mWeE4C8tKiMpIAvP1Q5GJlGwD+4Q5QBHV7MEbNJpU7rFozSfsfoEURwb
         u99c+zaqzD9RkAU0XvhmIfnRGNJkjtvfLd5y30eO8WnVoY/b0LuLWE2sRiMRGJcq+O+r
         Ah5zme11PiTZV7otSQgfNvXKMMR84Pj9ydDdecV8PrbY7xJHW6CeJjuzqwoQ4M2UmeXN
         qshG0u+M3h8qhGbC0ciEDzGbiD5BG3tbcErs1/tlW/qPH1Xi8x5aLKhnpaIlQ3hnt7ew
         7wbL+7ScHBeC7m22PFrb52kGV+kJeiTK3xV3wyh5yOm1wqlyn3h0qxdUm1EsttALM6Af
         uXSg==
X-Gm-Message-State: AKwxytcy+sM6Q1hCCXaav25IzrovHYqoEQOwM6pPYQ70/n6gbkiCXY3F
        Jwt1LnQYdyPTqxeOl3enIqjiBiF1
X-Google-Smtp-Source: AH8x2257lY9SUJYRbuAfo0rYcZwvXdYT1uQFgGzHY6lf78TCQddcJUid7Zf2h/Ok/ndMlJ9ROZBntA==
X-Received: by 10.25.181.3 with SMTP id e3mr3409500lff.90.1516792344326;
        Wed, 24 Jan 2018 03:12:24 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:23 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 12/14] sha1_file: convert force_object_loose to object_id
Date:   Wed, 24 Jan 2018 12:12:04 +0100
Message-Id: <ecbb3af31291a08b8d6515ac517086b2d25c01a2.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
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

