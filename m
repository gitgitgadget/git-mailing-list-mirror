Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A687C433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhL1N3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhL1N3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:29:03 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E9DC061751
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:29:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j18so38429546wrd.2
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIZ9OE4k0Ms32q0zDiKMVPO8tE2l7e34yLXKxIloqKA=;
        b=Tr1K6kNO5WI6Z9NPr8IOTIXo98UICFQsFDc3BkWa0OFYgW5ONQZYzBVfUtC59z0o5a
         elG5XadveJXgQCtM8yAPArgeKU0ufPgHwUO9T8LgSmq9pJx8LM++mXVTbANKsxTR9wB6
         8wy6HFzCKHIjR3GEyDxrf2FxuELhD8wKDAVWOLuQDpl5C2qRaBdtRYhQyzRSBt8tmQym
         QlcioGJhb5pSUIPDHTu4mHQgkUlupfrAzjTkedPGw+HB3uTz5CT0M6BBAF8PPQKEuKKe
         dHQBeyubyn/VgfRx8gjz70UL7TtipeclMhK/KxlWSP5+cxRVsHdxEo3O3DGWeSp+f9p2
         EijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIZ9OE4k0Ms32q0zDiKMVPO8tE2l7e34yLXKxIloqKA=;
        b=qkHSnJZsqCVfNxQozfhjJF1YB2tM613Orx4mmkv3w1i2jRCQYSYraZ5nTki2Doh/ko
         NivJtvv3CnsIkry1D6jHG2P1KoLcpHo7VG4pQz5/hYavR67e5j4xGl6XGTz/v2saGAf1
         3qbgp2UrejpAebdZGG0mddVE9NPGo9O/oa/8AdpyLWp4LRm/zYnqpL7gGQd5/RQkuvDw
         i4lLLRtG8d3LAnPfy72MW/Ni+LtVPOxRSjeyZcRloFFpdqV3M2xVVAzUHF6v9cbi7/Pv
         ImhtbK/JXgScTQIGz4lU2AjCdJmaUox71kogJFIsfMZOUDOTrtFLoTMFeUMU9Afh4//a
         yp5Q==
X-Gm-Message-State: AOAM530T7x6Q7YMkkTw8E1NUH7sQbs/gRHzF8HAoMmQUGlIei9LNjqR2
        r52/6S60aJOoBaKyxLI7cnMJ7NVRPOqL1NfO
X-Google-Smtp-Source: ABdhPJwsvP2UpcTSXTFQBgG3BPe6ZZyaAQQoFfqCWInuz++gRe1UYznT2oLDRXykemIK6iJzkBc5DA==
X-Received: by 2002:adf:e74c:: with SMTP id c12mr16350099wrn.200.1640698139471;
        Tue, 28 Dec 2021 05:28:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 09/10] object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
Date:   Tue, 28 Dec 2021 14:28:49 +0100
Message-Id: <patch-v6-09.10-7bf5654e8f7-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop having GET_OID_ONLY_TO_DIE imply GET_OID_QUIETLY in
get_oid_with_context_1().

The *_DIE flag was added in 33bd598c390 (sha1_name.c: teach lookup
context to get_sha1_with_context(), 2012-07-02), and then later
tweaked in 7243ffdd78d (get_sha1: avoid repeating ourselves via
ONLY_TO_DIE, 2016-09-26).

Everything in that commit makes sense, but only for callers that
expect to fail in an initial call to get_oid_with_context_1(), e.g. as
"git show 0017" does via handle_revision_arg(), and then would like to
call get_oid_with_context_1() again via this
maybe_die_on_misspelt_object_name() function.

In the subsequent commit we'll add a new caller that expects to call
this only once, but who would still like to have all the error
messaging that GET_OID_ONLY_TO_DIE gives it, in addition to any
regular errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..d44a8f3a7ca 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1795,9 +1795,6 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 	const char *cp;
 	int only_to_die = flags & GET_OID_ONLY_TO_DIE;
 
-	if (only_to_die)
-		flags |= GET_OID_QUIETLY;
-
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
 	strbuf_init(&oc->symlink_path, 0);
@@ -1932,7 +1929,7 @@ void maybe_die_on_misspelt_object_name(struct repository *r,
 {
 	struct object_context oc;
 	struct object_id oid;
-	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE,
+	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE | GET_OID_QUIETLY,
 			       prefix, &oid, &oc);
 }
 
-- 
2.34.1.1257.g2af47340c7b

