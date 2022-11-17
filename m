Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7583FC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 13:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiKQNs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 08:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiKQNs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 08:48:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C135C69
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:48:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f7so2597152edc.6
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgBRMbcy7J17ZTVoNNpXUJAszIia2bvIj23DBCCChn4=;
        b=YWTJ7IlTN7ntCqkU246rUXp6rXyj0jaRj/rhIpC9rvuK7VdgMjqFCiE6j31qQnaCnw
         llxkb8GPCq096+Z8i/mgsSP+7RLs/AbGt/bCS2V1jTx3sBJ2wIgZwA7JavVI5ud8UU1/
         uubIklgcuNXtrdKx8Ym0CwRJuFgh1ka8TbeaOrRdtShYUey8mkTNZyzbnygFJCGxS9PD
         HQwQ+waVKjpAHip55krAZ1YDGl/yPhX8IpcmqVVVeoJGgTZP+W0gUVt6NjhXGre0AUYU
         NIgIR7L8ohmxC9/79ZiR7aBpGf2qZfA6e0GthZuSaEjZOJ9M27zQPrmvGsvRNhukPbOA
         RbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgBRMbcy7J17ZTVoNNpXUJAszIia2bvIj23DBCCChn4=;
        b=xPA+qcf3hqGLOTlcbq6GjjFLmLAdEdGUcxBxoLfegFwR+fLbecX/q4vjtyie/8U1GX
         rH1aDumu9w2zB2KECpp7knuu0qiNmn1ZR4LFOWSUFfcjycMHiIvhSODFLvERSi/9DjWm
         R+MgQXzbdMSYFL3XLt6NdV3koFpyJ5XGSjK2GLeoMTy/t++HSCQV1BSzWbToiXHVAfEB
         OyvYjULj/GkX2bUaT/iSbWajzrUZ1hsV71bFhhQaFWLTuevmeqSHEX7hWlzSe0MW4fox
         i5bBS1cTzfh8AQI2eoXMAbUpljqov7k7tdaom4pRNADCsqvo4t/WCm+ov4WhgH8Aow9s
         ONuA==
X-Gm-Message-State: ANoB5plhcyNiBk/pkSpR5hJohEcN+7UPKOAsAKN9WfMzdeLRkuSNxJ9Y
        KDYAhIDhcs6eMgSH+COHapUVnwXXHcTNzQ==
X-Google-Smtp-Source: AA0mqf4Wns9l9Hu4Fz9pnIJ4JzFtFZTkCDFVgP+Vru8ZL8rRyyIGxT15eKKJVl2grQVh/3IKLBb7bg==
X-Received: by 2002:a05:6402:288f:b0:460:d1f6:2917 with SMTP id eg15-20020a056402288f00b00460d1f62917mr2250984edb.207.1668692902463;
        Thu, 17 Nov 2022 05:48:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a170906581b00b007ad9adabcd4sm379257ejq.213.2022.11.17.05.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:48:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/4] ls-tree: don't use "show_tree_data" for "fast" callbacks
Date:   Thu, 17 Nov 2022 14:48:14 +0100
Message-Id: <RFC-patch-1.4-2d8bcfe2cab-20221117T134528Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1473.g172bcc0511c
In-Reply-To: <RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com> <RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in [1] the code that made it in as part of
9c4d58ff2c3 (ls-tree: split up "fast path" callbacks, 2022-03-23) was
a "maybe a good idea, maybe not" RFC-quality patch. I hadn't looked
very carefully at the resulting patterns.

The implementation shared the "struct show_tree_data data", which was
introduced in e81517155e0 (ls-tree: introduce struct "show_tree_data",
2022-03-23) both for use in 455923e0a15 (ls-tree: introduce "--format"
option, 2022-03-23), and because the "fat" callback hadn't been split
up as 9c4d58ff2c3 did.

Now that that's been done we can see that most of what
show_tree_common() was doing could be done lazily by the callbacks
themselves, who in the pre-image were often using an odd mis-match of
their own arguments and those same arguments stuck into the "data"
structure. Let's also have the callers initialize the "type", rather
than grabbing it from the "data" structure afterwards.

1. https://lore.kernel.org/git/cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com/
---
 builtin/ls-tree.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c3ea09281af..cbb6782f9a5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,19 +173,11 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 	return recurse;
 }
 
-static int show_tree_common(struct show_tree_data *data, int *recurse,
-			    const struct object_id *oid, struct strbuf *base,
-			    const char *pathname, unsigned mode)
+static int show_tree_common(int *recurse, struct strbuf *base,
+			    const char *pathname, enum object_type type)
 {
-	enum object_type type = object_type(mode);
 	int ret = -1;
-
 	*recurse = 0;
-	data->mode = mode;
-	data->type = type;
-	data->oid = oid;
-	data->pathname = pathname;
-	data->base = base;
 
 	if (type == OBJ_BLOB) {
 		if (ls_options & LS_TREE_ONLY)
@@ -217,15 +209,15 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 {
 	int early;
 	int recurse;
-	struct show_tree_data data = { 0 };
+	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	early = show_tree_common(&recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
-	printf("%06o %s %s\t", data.mode, type_name(data.type),
-	       find_unique_abbrev(data.oid, abbrev));
-	show_tree_common_default_long(base, pathname, data.base->len);
+	printf("%06o %s %s\t", mode, type_name(object_type(mode)),
+	       find_unique_abbrev(oid, abbrev));
+	show_tree_common_default_long(base, pathname, base->len);
 	return recurse;
 }
 
@@ -235,16 +227,16 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 {
 	int early;
 	int recurse;
-	struct show_tree_data data = { 0 };
 	char size_text[24];
+	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	early = show_tree_common(&recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
-	if (data.type == OBJ_BLOB) {
+	if (type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(the_repository, data.oid, &size) == OBJ_BAD)
+		if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
 			xsnprintf(size_text, sizeof(size_text), "BAD");
 		else
 			xsnprintf(size_text, sizeof(size_text),
@@ -253,9 +245,9 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 		xsnprintf(size_text, sizeof(size_text), "-");
 	}
 
-	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
-	       find_unique_abbrev(data.oid, abbrev), size_text);
-	show_tree_common_default_long(base, pathname, data.base->len);
+	printf("%06o %s %s %7s\t", mode, type_name(type),
+	       find_unique_abbrev(oid, abbrev), size_text);
+	show_tree_common_default_long(base, pathname, base->len);
 	return recurse;
 }
 
@@ -266,9 +258,9 @@ static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 	int early;
 	int recurse;
 	const size_t baselen = base->len;
-	struct show_tree_data data = { 0 };
+	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	early = show_tree_common(&recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
@@ -286,9 +278,9 @@ static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 {
 	int early;
 	int recurse;
-	struct show_tree_data data = { 0 };
+	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	early = show_tree_common(&recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
-- 
2.38.0.1473.g172bcc0511c

