Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6BB1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756482AbeDYSYS (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:24:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32999 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756152AbeDYSVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:23 -0400
Received: by mail-pg0-f67.google.com with SMTP id i194so13903947pgd.0
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tgmyI7EXLa/QggdEmZ5EjECxXb7xepgvxLY2N8Q7i0c=;
        b=qq2ak8yRYwqQyfDmuyyazxygMpi/XSKOwABXCFpvFRdl9Kr5sm8fLw3Ecz3k+hIbkN
         Wyta6vp2A4Gnl/UZE+Vhxa/Em5za7t6JVaU3q7JXH6gMLMoFxFixV5oH4YXg4R9aksLW
         WWixEh7mpesTA/z+zqG+THvZTfw6sNt2H7mxTRN6bh+riR3O4SSbhofvSqx9CfFkZXFa
         obhAV7W4yUuE2MqRgQPhmp6O7EfF6bn2EoPR0cHCZstYeMVOnd3S5MRyr3iZs5Vy1v+e
         BBjPDiflNutiBDbFNqYqhldXN3R5c6jJLNvaydHZJppFnGLDxBxnhT+fuPMGHL+wrhLX
         4qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tgmyI7EXLa/QggdEmZ5EjECxXb7xepgvxLY2N8Q7i0c=;
        b=sBkjwqd2a4UileC1skqHYANdSACdLTKMHeWbKE6L+SDC2yOR1mLxe2YJLvSn3xoQq3
         F394dbJJYleigIkNG1zLIhVi5W43pE+c/rrpMgYNKJZUdExiYqRiLuTECWsxeN4gbCtz
         79sSR1ag1lYonT4Y8eHHk3y9cbQyPiioYBqtvho5GLb811S2QMa/vQR2CnxF0ujmhLno
         /RjJ1Aj9RlNIvfxDG1ZmIBNP3syrsAka5WUcZWt287jGRay/eI0uzlU5HiZXz5SWiRor
         YBZ/fHsEQr7Upo5FXVtcFzhIqjhOnEbQH7Ej3OSWgQ/RMhk8tQwnXKudCJ5XuNmAzzSq
         0GtA==
X-Gm-Message-State: ALQs6tDBqXA0nqwjnKNWGeFpwY7x3GluUpdK5frB9nwCqFjQpl4DTaRu
        sHNjtvufVFhXBnZuCN4DElGCn0HVVow=
X-Google-Smtp-Source: AIpwx48JxlObSERQbpphxs20TzHotyH8x8oX7KTlNS8pWuoobgKtkKl59EWPh2lPmMGWpGNedlNZbg==
X-Received: by 2002:a17:902:529:: with SMTP id 38-v6mr30459846plf.64.1524680482319;
        Wed, 25 Apr 2018 11:21:22 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id g64sm43484905pfd.75.2018.04.25.11.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 11:21:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv3 8/9] packfile: add repository argument to cache_or_unpack_entry
Date:   Wed, 25 Apr 2018 11:21:05 -0700
Message-Id: <20180425182106.162972-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180425182106.162972-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
 <20180425182106.162972-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of cache_or_unpack_entry
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index d5ac48ef18..8de87f904b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1272,7 +1272,8 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 	free(ent);
 }
 
-static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
+#define cache_or_unpack_entry(r, p, bo, bs, t) cache_or_unpack_entry_##r(p, bo, bs, t)
+static void *cache_or_unpack_entry_the_repository(struct packed_git *p, off_t base_offset,
 	unsigned long *base_size, enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1346,7 +1347,7 @@ int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(p, obj_offset, oi->sizep,
+		*oi->contentp = cache_or_unpack_entry(the_repository, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
-- 
2.17.0.441.gb46fe60e1d-goog

