Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFAFC1F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfJSKgD (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:36:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51630 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfJSKgC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:36:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id q70so1368321wme.1
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJFoM6gd2X7T/Qy34F3uqPb94w5OpKQr+aW9LuJgN18=;
        b=Cg6fec1MGSLkQvXKX4XJ9yrq6YAXm10HvHwqfcd0DkpXXrE8M9IhPxpswBOv3Zzgt7
         I9s6Yn9lHuBq//ROnFnMApdya0GctoZluX99z/mopiEWTshOIPVrWHvB+XT4YcbPJc4r
         WDmbqdaG26k6hWAAnMYUQApcYyvF+g6OF6maHqI3/mViKqowzdSzuhIj9txTxRmx5OZJ
         DB+17HV2iSMSFqBco3F4AV/j1Smf7SBOHlLTo2/cYbAGUSABdBuTKZBUcuBowajiWRhB
         anSqSRfCEeyJbQ+0sSylW7p1vJeF2ZxV8YmR8xM6dIXoYXkStEHF2sN4ajSKHhhswkZs
         3fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJFoM6gd2X7T/Qy34F3uqPb94w5OpKQr+aW9LuJgN18=;
        b=XYXEMe5QfXTAL8ozXwIGJsLPd6Vzt98xtjWnNok+DLkTQYg7afqJmUS6m5xWAdGpaZ
         XH6qYh0XnuRwkCW9uyPG2dYzaI7KJMNZHD/HVOY1CFhjmBcONZH1IzF+IkUMsCkKnxVT
         srYvmpMs3BTrgesD+qCxVRu3rlWB3zx+t8mWxpwnmT2RLW/v7Hm5FIrHsM+DjuwhlZT3
         sSVBGyM+fCcyc8lCdpyYJe1TxF1r/LZUIGNph2OGYRIeKxXUhdokxnVZsKA+Erm3yPUu
         cR6rf7ZI5l/nVzyDYOCIKC5pnSb6d1I1XmC7/BaSHnGXXHKMWg3n6hn33iZFY3Gah2dH
         u+NQ==
X-Gm-Message-State: APjAAAUghYnrGKr4b33hnfo7mFqjLcxaRVlVzZSzEVCpspeGd1kgZRy/
        yUeORMsYPp7nm/+QQoyGS/lA2x7CFiubcQ==
X-Google-Smtp-Source: APXvYqxGLKHvi6qbBnqGWIvSA2Uko8QdX1FAOT6ZAUESaqkuCwpPRrOxA/i0upqxSf9XbCErkBRWiQ==
X-Received: by 2002:a05:600c:2107:: with SMTP id u7mr11694684wml.86.1571481358694;
        Sat, 19 Oct 2019 03:35:58 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:35:58 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 7/9] pack-objects: introduce pack.allowPackReuse
Date:   Sat, 19 Oct 2019 12:35:29 +0200
Message-Id: <20191019103531.23274-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.rc0.9.gef620577e2
In-Reply-To: <20191019103531.23274-1-chriscool@tuxfamily.org>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's make it possible to configure if we want pack reuse or not.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/pack.txt | 4 ++++
 builtin/pack-objects.c        | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 1d66f0c992..58323a351f 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -27,6 +27,10 @@ Note that changing the compression level will not automatically recompress
 all existing objects. You can force recompression by passing the -F option
 to linkgit:git-repack[1].
 
+pack.allowPackReuse::
+	When true, which is the default, Git will try to reuse parts
+	of existing packfiles when preparing new packfiles.
+
 pack.island::
 	An extended regular expression configuring a set of delta
 	islands. See "DELTA ISLANDS" in linkgit:git-pack-objects[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f2c2703090..4fcfcf6097 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -96,6 +96,7 @@ static off_t reuse_packfile_offset;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
+static int allow_pack_reuse = 1;
 static enum {
 	WRITE_BITMAP_FALSE = 0,
 	WRITE_BITMAP_QUIET,
@@ -2699,6 +2700,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.allowpackreuse")) {
+		allow_pack_reuse = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
@@ -3030,7 +3035,8 @@ static void loosen_unused_packed_objects(void)
  */
 static int pack_options_allow_reuse(void)
 {
-	return pack_to_stdout &&
+	return allow_pack_reuse &&
+	       pack_to_stdout &&
 	       allow_ofs_delta &&
 	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
-- 
2.24.0.rc0.9.gef620577e2

