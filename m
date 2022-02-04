Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE7EC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378330AbiBDXtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378227AbiBDXs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303E3E009504
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r7so5599637wmq.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0awZAX70E4xqX9goFjMgAqryoi2Iua+fDVMAIeoVuOQ=;
        b=bKNOIiSsACipusVKJbVqDaSpMb9tw7qGkf0pKp3EV49tiDIsfsh3xSakQQZ7BxszqP
         xv4Mv3wnJfKigx0dxc1No5cSO9v0xyeavRg+2Vd08l/TRLwcnDs5EmmnrPTSVZDMKngl
         w1tz4P8ROuHaA3tIo922VB4ddV7m9YXAH6ApTYLDjf+Min985gnrrI7dE4ygAZMENJjb
         nYLnTMX94VRuth5i6GZa6JycZ2GTlGQShet145bQOsqsYtREyNHK6Rj/AeXE8GkkXhbx
         VUItyK5J+Dp9Zv22fY80YCDTu35fOxYw6XYyXXzyZzuEL9JgY0+cOa/dSz9o9sYoVVc1
         t6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0awZAX70E4xqX9goFjMgAqryoi2Iua+fDVMAIeoVuOQ=;
        b=VL6JfR5zxzHHSE0DTtpLoR1j4nGntLur3p0ThSutqbSXpun6TDMyGxFz4kDVnGig3e
         OfnZMHbqDsimrVw3mhkP/n8ssg3tgxcD5l72HNS4qljbDiEe8coCZK9Q6doWUZTfz5J9
         azQgsLQ9YN1q+9NBWHR4oJX62nA/UxI/XeEdp4inuBG64deN/AivSF+M5/ykMMzTfFO4
         RM3icHZiECYxakE6bpDXmdggg+rrmTmvw4FExyLWBb6QoSoJfVmnn78q+L3RzRxf9AK3
         y6zVlT7qTChRHEu6d/gGNegOaqj2hSbFt2u/FLAfaEJ8U9WDP2RqL5yvzFWoByD8MYfU
         acvg==
X-Gm-Message-State: AOAM531WSqO+xm5i/sBB7Uvs4z/F8LhSQt7wA9UBEA9LdNKsk2RWyi1V
        +OEJhy+oShsSZrVxsItitmVKbm5QWDX1sg==
X-Google-Smtp-Source: ABdhPJwt4QNaeJvDvS9qb8mR5jt+CNbUOJvh1K3V5QUCCzEla0LY7BuoFOz7Ydh8EaRZZmvMpLFrcg==
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr855776wmq.45.1644018526568;
        Fri, 04 Feb 2022 15:48:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/12] object API users + docs: check <0, not !0 with check_object_signature()
Date:   Sat,  5 Feb 2022 00:48:29 +0100
Message-Id: <patch-v3-07.12-75abf75a437-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those users of the object API that misused
check_object_signature() by assuming it returned any non-zero when the
OID didn't match the expected value to check <0 instead. In practice
all of this code worked before, but it wasn't consistent with rest of
the users of the API.

Let's also clarify what the <0 return value means in API docs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c | 5 ++---
 builtin/mktag.c      | 2 +-
 cache.h              | 3 +++
 object-file.c        | 2 +-
 pack-check.c         | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 01574378ce2..416f60a98c1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1412,9 +1412,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		if (!data)
 			continue;
 
-		if (check_object_signature(the_repository, &d->oid,
-					   data, size,
-					   type_name(type), NULL))
+		if (check_object_signature(the_repository, &d->oid, data, size,
+					   type_name(type), NULL) < 0)
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 96a3686af53..98d1e66f327 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -97,7 +97,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 				&tagged_oid, &tagged_type))
 		die(_("tag on stdin did not pass our strict fsck check"));
 
-	if (verify_object_in_tag(&tagged_oid, &tagged_type))
+	if (verify_object_in_tag(&tagged_oid, &tagged_type) < 0)
 		die(_("tag on stdin did not refer to a valid object"));
 
 	if (write_object_file(buf.buf, buf.len, OBJ_TAG, &result) < 0)
diff --git a/cache.h b/cache.h
index 98d1ef08579..5d081952121 100644
--- a/cache.h
+++ b/cache.h
@@ -1324,6 +1324,9 @@ int parse_loose_header(const char *hdr, struct object_info *oi);
  * object name actually matches "oid" to detect object corruption.
  * With "buf" == NULL, try reading the object named with "oid" using
  * the streaming interface and rehash it to do the same.
+ *
+ * A negative value indicates an error, usually that the OID is not
+ * what we expected, but it might also indicate another error.
  */
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type,
diff --git a/object-file.c b/object-file.c
index 44e0b32d71a..d628f58c0d2 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2613,7 +2613,7 @@ int read_loose_object(const char *path,
 		}
 		if (check_object_signature(the_repository, expected_oid,
 					   *contents, *size,
-					   oi->type_name->buf, real_oid))
+					   oi->type_name->buf, real_oid) < 0)
 			goto out;
 	}
 
diff --git a/pack-check.c b/pack-check.c
index 3f418e3a6af..48d818ee7b4 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -143,7 +143,7 @@ static int verify_packfile(struct repository *r,
 				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
 		else if (check_object_signature(r, &oid, data, size,
-						type_name(type), NULL))
+						type_name(type), NULL) < 0)
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
-- 
2.35.1.940.ge7a5b4b05f2

