Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE601FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 01:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbdFTBDf (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 21:03:35 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35509 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdFTBDb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 21:03:31 -0400
Received: by mail-pf0-f171.google.com with SMTP id c73so1446968pfk.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 18:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YZcIOQkR3N3romrqh23h2oLuWiRceFBKW7FAOnXynJw=;
        b=YezO1FSM4JrIyqO2br+Iy4FO7yH842BxXEGEK3F90rn6kTxJGDDlA25gW1IAorsF/Y
         3ZmYz6VeOl5h84lcVL9I3zW4gr65Zib86N5JJzQcWh8TA9430RYKJmRr+UA1H6/uEEKo
         qpvg3b7NCCzYVXXvi7s6YlpH1w3hNmgv9SPD+8S5bYljn0ebDrhXszgizeNXJ8LvlgAW
         kLZDQxzlvAiJw/ISb3pe9ghDMIAWatGNrVaRBiwCuYe0xlCvzMCR0YwTKpLg84LIDNpb
         7PN0d7/24/hnxZlWN1X3kC2HRGhjw8F1S0oR6uSxBgiu0rW+i2isGkhcepm/7sEesufQ
         V95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YZcIOQkR3N3romrqh23h2oLuWiRceFBKW7FAOnXynJw=;
        b=dhoLCqqPgPlRkRBEakIztufZYWO6kobYFous3ahLOTtKz4zANBWrll0Y8yUfRWOOTo
         0vPpkyhEAKWee6qCRMZxJxN2zunydajaJmo2uqrV7yTGNB1e0+QHr3Sey8o9o6QX8ph/
         5opDa0A52yNFn2oM0QW9vKSNlGrEKBHXeYqhmaSW+llXek9DDgc3sD5L/10Dx4jY6jK8
         D4rQCbbU/RJsqU0Z+/o0EYonYUt8uDWXb+hPwHmy25+Ew72BU33ZYUmzGaGExwi04Cam
         7g/JZ/WS9GFIJ1Sl9hrYI2a7FIkUjsiq/4ov44hqoV3SDtSX1X1rpne5y7pPhf9FLFrg
         vYSg==
X-Gm-Message-State: AKS2vOy/SQrX1tzlfBhB4UmzuzqlmAsyrX5QJKoEVNcvQVMoPkEhxx7m
        OSQWrh7OmDWTtmysad5v1A==
X-Received: by 10.99.153.26 with SMTP id d26mr29072725pge.241.1497920610701;
        Mon, 19 Jun 2017 18:03:30 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l63sm22249819pfc.132.2017.06.19.18.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 18:03:29 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
Date:   Mon, 19 Jun 2017 18:03:13 -0700
Message-Id: <ad3b02bae9db62400f89f387f0a1bb714e0a432d.1497920092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497920092.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497920092.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve sha1_object_info_extended() by supporting additional flags. This
allows has_sha1_file_with_flags() to be modified to use
sha1_object_info_extended() in a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  4 ++++
 sha1_file.c | 43 ++++++++++++++++++++++++-------------------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index 48aea923b..7cf2ca466 100644
--- a/cache.h
+++ b/cache.h
@@ -1863,6 +1863,10 @@ struct object_info {
 #define OBJECT_INFO_LOOKUP_REPLACE 1
 /* Allow reading from a loose object file of unknown/bogus type */
 #define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
+/* Do not check cached storage */
+#define OBJECT_INFO_SKIP_CACHED 4
+/* Do not retry packed storage after checking packed and loose storage */
+#define OBJECT_INFO_QUICK 8
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
diff --git a/sha1_file.c b/sha1_file.c
index 4d5033c48..24f7a146e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2977,29 +2977,30 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
-	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
 
-	co = find_cached_object(real);
-	if (co) {
-		if (oi->typep)
-			*(oi->typep) = co->type;
-		if (oi->sizep)
-			*(oi->sizep) = co->size;
-		if (oi->disk_sizep)
-			*(oi->disk_sizep) = 0;
-		if (oi->delta_base_sha1)
-			hashclr(oi->delta_base_sha1);
-		if (oi->typename)
-			strbuf_addstr(oi->typename, typename(co->type));
-		if (oi->contentp)
-			*oi->contentp = xmemdupz(co->buf, co->size);
-		oi->whence = OI_CACHED;
-		return 0;
+	if (!(flags & OBJECT_INFO_SKIP_CACHED)) {
+		struct cached_object *co = find_cached_object(real);
+		if (co) {
+			if (oi->typep)
+				*(oi->typep) = co->type;
+			if (oi->sizep)
+				*(oi->sizep) = co->size;
+			if (oi->disk_sizep)
+				*(oi->disk_sizep) = 0;
+			if (oi->delta_base_sha1)
+				hashclr(oi->delta_base_sha1);
+			if (oi->typename)
+				strbuf_addstr(oi->typename, typename(co->type));
+			if (oi->contentp)
+				*oi->contentp = xmemdupz(co->buf, co->size);
+			oi->whence = OI_CACHED;
+			return 0;
+		}
 	}
 
 	if (!find_pack_entry(real, &e)) {
@@ -3010,9 +3011,13 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 
 		/* Not a loose object; someone else may have just packed it. */
-		reprepare_packed_git();
-		if (!find_pack_entry(real, &e))
+		if (flags & OBJECT_INFO_QUICK) {
 			return -1;
+		} else {
+			reprepare_packed_git();
+			if (!find_pack_entry(real, &e))
+				return -1;
+		}
 	}
 
 	rtype = packed_object_info(e.p, e.offset, oi);
-- 
2.13.1.611.g7e3b11ae1-goog

