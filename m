Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F23720899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbdHIBX1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:27 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36905 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbdHIBXW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:22 -0400
Received: by mail-pg0-f41.google.com with SMTP id y129so21570871pgy.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Q6PMFLfdfFnDqDm/Q0ByaxJL7AxHcERdgJtOlTiQ2Ac=;
        b=Mk7q3iNBCYNASXygJYbb4hKPdIo4UhCCnSLAcFLWPwOhElpccwhlcSzmW4d+5arlPu
         kz3htREpTKPNkYe4dU60zQVG1ayeZf44f0kLMuJ3eo1FBkyfoPn60vf9xUko7jBx35Ie
         uFnDfFfX+kWDd9cm8EjKd+AU0pJfjKiebpr6E1GQxs6Acz7EHD3MV7NOZ6c184v1+V7i
         HAERBROfIttVwOvrCCgSSLgxsXM85Sqib6E47mNqTJ5x3UImrZ2nTKxodn7TC8S2Ywuc
         g2JrEQR+3KLe2plDiBI6+hAyfJmJWrZwgpHlna8WJr5irmcR1JZz6DsLlxsWV/nxJoJH
         /I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Q6PMFLfdfFnDqDm/Q0ByaxJL7AxHcERdgJtOlTiQ2Ac=;
        b=qDQklAS7P5a4+RyjX+FODgCmTzj/wlevSDLFjYii+AP0hEHLaa+eCj7ucDZbD0kmO9
         W/vjSoEEj7UTF/ES3wTPqBzL0BrIkL0nDh4Qu4iGSK3y/7IFz/92LKsL8BEoBO2dtnwD
         a3FaYO5NxIna5T+Cdbhx9UVLQE6K9yswCrb1ZKJoBqt4Z7bxdXhamhPI8y13bogLAKvN
         u7B80kIigl9Gc7DimxBnCZGW+r+GItVw0yA6Tz4O8wWb/LiAYiChPvb08sifitWbk8dH
         /C1HS/io5eQ+gF+NfJ6AvoZ22azOgm5jq2FoXhSGJrNrn/uEZjdMkV2zgWXAZhdO2yCC
         ZK/w==
X-Gm-Message-State: AHYfb5htKVrOHwqNdqrh78rVLxRbmCYOBUs/KlI79Qk24RgYeUy2XT72
        D2+1Eot8KryJ9s3anrklhQ==
X-Received: by 10.84.131.105 with SMTP id 96mr6892694pld.226.1502241800933;
        Tue, 08 Aug 2017 18:23:20 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:20 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 16/25] sha1_file: remove read_packed_sha1()
Date:   Tue,  8 Aug 2017 18:22:48 -0700
Message-Id: <daff41cb37b1385e34a92b08ba1109a943586a70.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use read_object() in its place instead. This avoids duplication of code.

This makes force_object_loose() slightly slower (because of a redundant
check of loose object storage), but only in the error case.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9eadda388..9e5444334 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2091,30 +2091,6 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 	return type;
 }
 
-static void *read_packed_sha1(const unsigned char *sha1,
-			      enum object_type *type, unsigned long *size)
-{
-	struct pack_entry e;
-	void *data;
-
-	if (!find_pack_entry(sha1, &e))
-		return NULL;
-	data = cache_or_unpack_entry(e.p, e.offset, size, type);
-	if (!data) {
-		/*
-		 * We're probably in deep shit, but let's try to fetch
-		 * the required object anyway from another pack or loose.
-		 * This should happen only in the presence of a corrupted
-		 * pack, and is better than failing outright.
-		 */
-		error("failed to read object %s at offset %"PRIuMAX" from %s",
-		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
-		mark_bad_packed_object(e.p, sha1);
-		data = read_object(sha1, type, size);
-	}
-	return data;
-}
-
 int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 		      unsigned char *sha1)
 {
@@ -2497,7 +2473,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 
 	if (has_loose_object(sha1))
 		return 0;
-	buf = read_packed_sha1(sha1, &type, &len);
+	buf = read_object(sha1, &type, &len);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
-- 
2.14.0.434.g98096fd7a8-goog

