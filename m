Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8A41F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKOOQK (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:16:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38707 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfKOOQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:16:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so11150341wro.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIWLkMKJFKnIIAPn8O+rtAi8qCbUQlu156Hxt6sNP0Q=;
        b=ViVz9y/28k/cLvnC5Pq8JulyKqVHM1Arbz2psuRyEY8k4+qfkPZlJf0cVVhYgmXDza
         GjZFDMi7mFoB0SlxfgtxOpGSVKrtf0HYrAzI0ywwbPbU4sXht0GvQzXIhOWz+433O7zY
         lEgtHKQqPoJ15irONmPy735nv03AWmk5GQxDHeO2QWYaW6uZN49LwObhcAdiA+qD/9OV
         pk636NI2aU5bvxAk8EzrEcF6rl3aHPjaOUjsX2XWiRECozFDuHDN/yPyKFd8jl3gQ4p9
         BMJUImWYj13hsL5NlW1w9p86Arq90vaAfH/6QMVvqs4xzgMPkM2AXQ8UWVgd0jh7ggsN
         ZdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIWLkMKJFKnIIAPn8O+rtAi8qCbUQlu156Hxt6sNP0Q=;
        b=lP/9qRXzKZd2rGh7zgkFuH/qJnYqNHdxVQQr4qWp8dUAaAU74hPZWoNXc8PcFoOE2o
         iwSYebvJX4OjvDuvO1kSuvdmqoOAKunW0GGOgrB9bmNH2OxxedcfPYI9BYqwHtQDEP6n
         bfMAsGX6/s1rd3MJGeErMDyMSRarzXQhM66+wr/AqUGeu23C6WhQ5mApE5rPOWpuA2qh
         4l1AFtsTysuKrh60pn+5KcRE9wvr+/7+l/LG4muUomhAJcHp5CFmq760Q3pHr6va0BCd
         xALAcQOBYhcLXAxqstNb5jKoskrw6vA50GJXWOlqM+JEam2tHuhP2i8nGOCWjVDh0It2
         IeJA==
X-Gm-Message-State: APjAAAVEdAPMCtg7DAD5A/Z1jJWmd1OUkhKbBBOu4n0R4mcvh/BGuLPr
        t4YfnKr9scvL4nvY35dFGabdjGxG
X-Google-Smtp-Source: APXvYqzky/GCusMe8haXapGlmcGjcIC1uvM7xHlqO+HVskBie7zIKL5Q33VyLejISXoxc2A43jR5WQ==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr15766509wrx.128.1573827366901;
        Fri, 15 Nov 2019 06:16:06 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1050:ac52:b4cd:f6a2:ba59:f1d4])
        by smtp.gmail.com with ESMTPSA id a2sm7907874wrt.79.2019.11.15.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:16:06 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 7/9] pack-objects: introduce pack.allowPackReuse
Date:   Fri, 15 Nov 2019 15:15:39 +0100
Message-Id: <20191115141541.11149-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0-rc1
In-Reply-To: <20191115141541.11149-1-chriscool@tuxfamily.org>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
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
2.24.0-rc1

