Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC3C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AB1610FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbhIGLAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbhIGK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909B0C06175F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so1458435wmn.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0Xz7uqRYV/uB+NfjsY69EBlGmMi3A//UBWiDVbV2CY=;
        b=T7/HcxEDeBqSwgpKvWEFLmB54VRmAEcNGlyrUlUF2B0iYlhGf0uXDeMdIGnZbkiyws
         008XldWBmbY46WKB/yjC9gMfjtuqmq3wdNrKh+zygNk7wMB8zE4sjHUAEKwBFlt95eIi
         S2/YPVsZFD7JvBGWm4NTHuEGRqa07nI8KFiblGvapSQ/dodNre87VWfG+l9aqnIK+A++
         EidKV+sIPsmxsrP9ayaUZg0PqHny9ax6F9u3P1oNru77aJ7DfKS84L/Ny0BfVVzat4bH
         JRy0VA+hiPAn/yj21e1jzk1Oq5IPk1/mFyBlU0gSMcpKLXL1CEMvRgubCYh8mU/4rPu6
         pynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0Xz7uqRYV/uB+NfjsY69EBlGmMi3A//UBWiDVbV2CY=;
        b=bcvyoku2VixlAg8ukt1RMmAF9lKIaU2KRVfWuhSqrKM5bbwgtNHyP8UW+pGgxIRxcC
         7QEXBh/5zapgodwoLXv2RUegwqpL000H7kupHgRl06fQa5Z4Gz700CAOp2Abh/Sci3eM
         1KQ5EV58kg5qvLo+f4L5HJmPOJQk+5yRkhQoUOjft664csBEIt3BbrZgtsqoafxL9mN2
         gC/OttSDvByXiH01ft1zQIsNoDKIh+JhgU0h35BI4v47BD/oXZxvNVAu9L1We2wXJV9a
         pZeUAULf9+lZ5rQiRbkGwHXcxbXUrzmOxF0eDpFv1QL4mT+O9l9SRH0efLfCME7gNZOi
         WYzg==
X-Gm-Message-State: AOAM532CLlG688Do2pGqs4HmAB3VsGO7O+1hTg0HDuREvXrgYcbQ12Wt
        9CJraAHl21yLxz2TwJDPVse+LFgV0+ah2g==
X-Google-Smtp-Source: ABdhPJyVfeRX3VD0vqV02UJA1n4vU3nm9MzBTSD4oAaWu8R7/Duzwzc7h5W2stw+bAP4kJrLyYOTgQ==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr3310603wmc.150.1631012319898;
        Tue, 07 Sep 2021 03:58:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 17/22] object-file.c: return -2 on "header too long" in unpack_loose_header()
Date:   Tue,  7 Sep 2021 12:58:12 +0200
Message-Id: <patch-v6-17.22-f28c4f0dfb4-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the return code for "header too long" from the generic
negative return value unpack_loose_header() returns, and report via
error() if we exceed MAX_HEADER_LEN.

As a test added earlier in this series in t1006-cat-file.sh shows
we'll correctly emit zlib errors from zlib.c already in this case, so
we have no need to carry those return codes further down the
stack. Let's instead just return -2 saying we ran into the
MAX_HEADER_LEN limit, or other negative values for "unable to unpack
<OID> header".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c       | 16 +++++++++++++---
 object-store.h      |  6 ++++--
 t/t1006-cat-file.sh |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 11df4485147..0cb5287d3ef 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1266,7 +1266,7 @@ int unpack_loose_header(git_zstream *stream,
 	 * --allow-unknown-type".
 	 */
 	if (!header)
-		return -1;
+		return -2;
 
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
@@ -1287,7 +1287,7 @@ int unpack_loose_header(git_zstream *stream,
 		stream->next_out = buffer;
 		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
-	return -1;
+	return -2;
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
@@ -1456,9 +1456,19 @@ static int loose_object_info(struct repository *r,
 
 	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				      allow_unknown ? &hdrbuf : NULL);
-	if (hdr_ret < 0) {
+	switch (hdr_ret) {
+	case 0:
+		break;
+	case -1:
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
+		break;
+	case -2:
+		status = error(_("header for %s too long, exceeds %d bytes"),
+			       oid_to_hex(oid), MAX_HEADER_LEN);
+		break;
+	default:
+		BUG("unknown hdr_ret value %d", hdr_ret);
 	}
 	if (!status) {
 		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
diff --git a/object-store.h b/object-store.h
index 584bf5556af..e896b813f24 100644
--- a/object-store.h
+++ b/object-store.h
@@ -489,13 +489,15 @@ int for_each_packed_object(each_packed_object_fn, void *,
  * unpack_loose_header() initializes the data stream needed to unpack
  * a loose object header.
  *
- * Returns 0 on success. Returns negative values on error.
+ * Returns 0 on success. Returns negative values on error. If the
+ * header exceeds MAX_HEADER_LEN -2 will be returned.
  *
  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
  * "hdrbuf" argument is non-NULL. This is intended for use with
  * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
  * reporting. The full header will be extracted to "hdrbuf" for use
- * with parse_loose_header().
+ * with parse_loose_header(), -2 will still be returned from this
+ * function to indicate that the header was too long.
  */
 int unpack_loose_header(git_zstream *stream, unsigned char *map,
 			unsigned long mapsize, void *buffer,
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 98729f1edfc..43a9f4e7f0c 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -440,7 +440,7 @@ bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_t
 
 test_expect_success 'die on broken object with large type under -t and -s without --allow-unknown-type' '
 	cat >err.expect <<-EOF &&
-	error: unable to unpack $bogus_sha1 header
+	error: header for $bogus_sha1 too long, exceeds 32 bytes
 	fatal: git cat-file: could not get object info
 	EOF
 
-- 
2.33.0.815.g21c7aaf6073

