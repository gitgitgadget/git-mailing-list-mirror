Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F421C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbhLVENY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbhLVENU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739DAC06175B
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:16 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l4so711961wmq.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Gtk/qKnYbWtKhWgD/EG2qxRMlwLzYamPO19uKXxlV8=;
        b=D9ysn0E4RvZVyuPCM9YKsilnvXKj5lJCWYgMOhqC1IZA4pZWlElKRF+wHKw59z3vca
         NKuHa2MJCuCEGADEA6cSkWyrTISI9IWzSuvkuGACLKJYaRO8fO7CftIjspYcBdvLUf/d
         u8BLZp/r7kUjfYfgbf4l1A7RhyHQcLFwB55GJR5OMivhhJfsyk0A/lPHO+6WdUPLy3ei
         RRB0Q1F2wvlHnG3L6hVE2peZQXj5SsoR+wwUUBnZmo2j6MH/8fWdcBFV9YSIj1yQiP0D
         V1Ed2oSLkj5LYIvdmgPNJfUJ+5ZTME9EaPLROhRP323b19hKLuPB5xAj5yr0hr5KHGJc
         gBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Gtk/qKnYbWtKhWgD/EG2qxRMlwLzYamPO19uKXxlV8=;
        b=HOhyGSUSFMN3YsbouETl0Hbq06FUudVm9L4pQho2gqh5ul5/3R8TMPxg9dIk6hkYR8
         SlW5r/0446TVnMS5L8sD5kqJQk/ICEvY35D2NjX/PlUOYsdp4JWDvENFp0F9EGSoe5z0
         oBoBNVARCOKhY2Jk/4Ukkv2bbGRhhUINfgU12SyfBEIyBPewpZjJAiwEe6WofD8Q2Ak9
         MAjOJKHfO4gw0vWhA6X1mNyN3qiHGpTzL58hzakECLWBaOoZm88EblYT/BEccthkHhQk
         aw8tM442+61FBICUpNeo3VBUAM4Zktz0xgRO1gG5xiCT1SLk+NT4BGMS0kysPUNpiIO7
         bx9A==
X-Gm-Message-State: AOAM531Jfg3uq0O+Lbc8+W/pcBjhzp0NT1zZ6yQImguDwFNoeUMjlQSa
        LjM4s4DLO3SuYXNqOSx5TVmSHoIp+KO5jA==
X-Google-Smtp-Source: ABdhPJxFFRXqi9McS6H4DA86ocCxSBF8ADdhXTI6Bf5cRPOPmMuJXbeu6K/w19btUYPq/RM1YXJeng==
X-Received: by 2002:a05:600c:3485:: with SMTP id a5mr781195wmq.181.1640146394799;
        Tue, 21 Dec 2021 20:13:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/10] cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
Date:   Wed, 22 Dec 2021 05:13:03 +0100
Message-Id: <patch-v5-10.10-63920969ca8-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the cat_one_file() logic that calls get_oid_with_context()
under --textconv and --filters to use the GET_OID_ONLY_TO_DIE flag,
thus improving the error messaging emitted when e.g. <path> is missing
but <rev> is not.

To service the "cat-file" use-case we need to introduce a new
"GET_OID_REQUIRE_PATH" flag, otherwise it would exit early as soon as
a valid "HEAD" was resolved, but in the "cat-file" case being changed
we always need a valid revision and path.

This arguably makes the "<bad rev>:<bad path>" and "<bad
rev>:<good (in HEAD) path>" use cases worse, as we won't quote the
<path> component at the user anymore, but let's just use the existing
logic "git log" et al use for now. We can improve the messaging for
those cases as a follow-up for all callers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c           | 16 ++++++----------
 cache.h                      |  1 +
 object-name.c                |  3 +++
 t/t8007-cat-file-textconv.sh |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b5b130d79c1..ad9b3eef4f4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -73,14 +73,17 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
+	unsigned get_oid_flags = GET_OID_RECORD_PATH | GET_OID_ONLY_TO_DIE;
 	const char *path = force_path;
+	const int opt_cw = (opt == 'c' || opt == 'w');
+	if (!path && opt_cw)
+		get_oid_flags |= GET_OID_REQUIRE_PATH;
 
 	if (unknown_type)
 		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
-	if (get_oid_with_context(the_repository, obj_name,
-				 GET_OID_RECORD_PATH,
-				 &oid, &obj_context))
+	if (get_oid_with_context(the_repository, obj_name, get_oid_flags, &oid,
+				 &obj_context))
 		die("Not a valid object name %s", obj_name);
 
 	if (!path)
@@ -112,9 +115,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		return !has_object_file(&oid);
 
 	case 'w':
-		if (!path)
-			die("git cat-file --filters %s: <object> must be "
-			    "<sha1:path>", obj_name);
 
 		if (filter_object(path, obj_context.mode,
 				  &oid, &buf, &size))
@@ -122,10 +122,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		break;
 
 	case 'c':
-		if (!path)
-			die("git cat-file --textconv %s: <object> must be <sha1:path>",
-			    obj_name);
-
 		if (textconv_object(the_repository, path, obj_context.mode,
 				    &oid, 1, &buf, &size))
 			break;
diff --git a/cache.h b/cache.h
index cfba463aa97..fae55cfcb33 100644
--- a/cache.h
+++ b/cache.h
@@ -1377,6 +1377,7 @@ struct object_context {
 #define GET_OID_FOLLOW_SYMLINKS 0100
 #define GET_OID_RECORD_PATH     0200
 #define GET_OID_ONLY_TO_DIE    04000
+#define GET_OID_REQUIRE_PATH  010000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index d44a8f3a7ca..92862eeb1ac 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1799,6 +1799,9 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 	oc->mode = S_IFINVALID;
 	strbuf_init(&oc->symlink_path, 0);
 	ret = get_oid_1(repo, name, namelen, oid, flags);
+	if (!ret && flags & GET_OID_REQUIRE_PATH)
+		die(_("<object>:<path> required, only <object> '%s' given"),
+		    name);
 	if (!ret)
 		return ret;
 	/*
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index 71ea2ac987e..b067983ba1c 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -29,7 +29,7 @@ test_expect_success 'usage: <bad rev>' '
 
 test_expect_success 'usage: <bad rev>:<bad path>' '
 	cat >expect <<-\EOF &&
-	fatal: Not a valid object name HEAD2:two.bin
+	fatal: invalid object name '\''HEAD2'\''.
 	EOF
 	test_must_fail git cat-file --textconv HEAD2:two.bin 2>actual &&
 	test_cmp expect actual
@@ -37,7 +37,7 @@ test_expect_success 'usage: <bad rev>:<bad path>' '
 
 test_expect_success 'usage: <rev>:<bad path>' '
 	cat >expect <<-\EOF &&
-	fatal: Not a valid object name HEAD:two.bin
+	fatal: path '\''two.bin'\'' does not exist in '\''HEAD'\''
 	EOF
 	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
 	test_cmp expect actual
@@ -46,7 +46,7 @@ test_expect_success 'usage: <rev>:<bad path>' '
 
 test_expect_success 'usage: <rev> with no <path>' '
 	cat >expect <<-\EOF &&
-	fatal: git cat-file --textconv HEAD: <object> must be <sha1:path>
+	fatal: <object>:<path> required, only <object> '\''HEAD'\'' given
 	EOF
 	test_must_fail git cat-file --textconv HEAD 2>actual &&
 	test_cmp expect actual
@@ -55,7 +55,7 @@ test_expect_success 'usage: <rev> with no <path>' '
 
 test_expect_success 'usage: <bad rev>:<good (in HEAD) path>' '
 	cat >expect <<-\EOF &&
-	fatal: Not a valid object name HEAD2:one.bin
+	fatal: invalid object name '\''HEAD2'\''.
 	EOF
 	test_must_fail git cat-file --textconv HEAD2:one.bin 2>actual &&
 	test_cmp expect actual
-- 
2.34.1.1146.gb52885e7c44

