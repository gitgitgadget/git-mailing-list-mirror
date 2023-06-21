Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C3AEB64DC
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 19:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFUTfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 15:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFUTfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 15:35:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8394E10F0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 12:35:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f9b258f3a2so38696725e9.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376116; x=1689968116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6iFA5QpQ5Vgtxv7M7VdAjTSwHnZdAXcengbYZ6PXX4=;
        b=OmqvMDfkKd3nYRPOxdzEh1JkAup/nqjGd4UCm/oz7kUZbNd0bvng31sPXpPWiIJQWb
         Rr97Tdeq1QZlXptssKdGAyBc+x4PrG81EP7EZ3ym7c79CXMnRq2Ul9G5cwFDSrzpe/lm
         Kp0hiJrv/QUA6CqoNOJF2Ihgr/TH7N10GSRG23jrxxBC4d9b99aJx6gUkixWD3bGKni8
         WKkrmS+LWgN7zgJ+h78Gop2a3F4pEtdq8MoMWaF06UpxrPxo3yct61sr10NpxqzZCkZS
         FwIbNR/ypr+bL04OEutvrRe+QDKBRwtanRWGOu1lyNRth8AcYfI4KcwbkjVjlsZwc7t9
         fRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376116; x=1689968116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6iFA5QpQ5Vgtxv7M7VdAjTSwHnZdAXcengbYZ6PXX4=;
        b=XMOUwdkIvyxnJ+1L0wvP2ifkFHTIFRo9HxqqUC2LA6e80T+VmjyhcIsy2e0GVt4kSp
         +tWxw89Yo4pE9NCQb2uG4jIARMHSWT+S7oHeO/LNA0vGxPYlNpsboPzQRRAgGcUVrQP6
         TpBIMexj6XHFhoO+by9cNgxvzh9LfpgCciudTwB8RMYlmf7CfYqwfRNp0yYaGIDcR7Bb
         Uj4hoi22uSc4o9eQgNQlV0luncJGK4MdMtNIgKuIZScLfNyHxTLdtDYvpe9ltv5o9j5z
         KRlB53HPb3aC3xMuF2SHr3mm6zX2loG2UaBj44vugLhUdN+MNXV5CS0bmYI2I2/GfY8/
         MjHA==
X-Gm-Message-State: AC+VfDx3tcMmpImPh+KY/R5vMMcbf6kEPhSEomcm6gdZVu7Xp1m/AXVv
        M98OBFSuE7n17BPsq16t/AtKUKrW4nc=
X-Google-Smtp-Source: ACHHUZ7VUtKkVqyZh3FsXTQZYISslq7SbHj9xe+ik6SU1U7g3rB/gwSOCZ+rwe3MOt8X0r+lFQ8gDA==
X-Received: by 2002:a1c:e90d:0:b0:3f8:f663:921d with SMTP id q13-20020a1ce90d000000b003f8f663921dmr15391857wmc.41.1687376115626;
        Wed, 21 Jun 2023 12:35:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10-20020a1cf20a000000b003f9b0cfbe30sm5770428wmc.36.2023.06.21.12.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:35:15 -0700 (PDT)
Message-Id: <70f4797d9d629ab7088e05050f82f5807d30680c.1687376112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jun 2023 19:35:11 +0000
Subject: [PATCH 2/3] revision: add ref_visible() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In addition to helpers that check if a ref was excluded, teach the API a
ref_visible() function that takes into account both included
refs, excluded refs, and hidden refs.

Since exclusions take precedence over inclusion, a ref_included()
function is not necessary since a caller would always need to check
separately if the ref is excluded, in which case it would be easier to
call ref_visible().

Signed-off-by: John Cai <johncai86@gmail.com>
---
 revision.c | 32 ++++++++++++++++++++++++++------
 revision.h | 21 +++++++++++++++++++--
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 13e86a96498..54709e3f6fc 100644
--- a/revision.c
+++ b/revision.c
@@ -1533,20 +1533,34 @@ static void add_rev_cmdline_list(struct rev_info *revs,
 	}
 }
 
-int ref_excluded(const struct ref_visibility *visibility, const char *path)
+static int ref_matched(struct string_list refs, const char *path)
 {
-	const char *stripped_path = strip_namespace(path);
 	struct string_list_item *item;
 
-	for_each_string_list_item(item, &visibility->excluded_refs) {
+	for_each_string_list_item(item, &refs)
 		if (!wildmatch(item->string, path, 0))
 			return 1;
-	}
 
-	if (ref_is_hidden(stripped_path, path, &visibility->hidden_refs))
+	return 0;
+}
+
+int ref_excluded(const struct ref_visibility *visibility, const char *path)
+{
+	if (ref_is_hidden(strip_namespace(path), path, &visibility->hidden_refs))
 		return 1;
 
-	return 0;
+	return ref_matched(visibility->excluded_refs, path);
+}
+
+int ref_visible(const struct ref_visibility *visibility, const char *path)
+{
+	if (ref_is_hidden(strip_namespace(path), path, &visibility->hidden_refs))
+		return 0;
+
+	if (ref_matched(visibility->excluded_refs, path))
+		return 0;
+
+	return ref_matched(visibility->included_refs, path);
 }
 
 void init_ref_visibility(struct ref_visibility *visibility)
@@ -1558,6 +1572,7 @@ void init_ref_visibility(struct ref_visibility *visibility)
 void clear_ref_visibility(struct ref_visibility *visibility)
 {
 	string_list_clear(&visibility->excluded_refs, 0);
+	string_list_clear(&visibility->included_refs, 0);
 	string_list_clear(&visibility->hidden_refs, 0);
 	visibility->hidden_refs_configured = 0;
 }
@@ -1567,6 +1582,11 @@ void add_ref_exclusion(struct ref_visibility *visibility, const char *exclude)
 	string_list_append(&visibility->excluded_refs, exclude);
 }
 
+void add_ref_inclusion(struct ref_visibility *visibility, const char *include)
+{
+	string_list_append(&visibility->included_refs, include);
+}
+
 struct exclude_hidden_refs_cb {
 	struct ref_visibility *visibility;
 	const char *section;
diff --git a/revision.h b/revision.h
index 8eaca125cd1..fc26ec70b28 100644
--- a/revision.h
+++ b/revision.h
@@ -91,6 +91,12 @@ struct ref_visibility {
 	 */
 	struct string_list excluded_refs;
 
+	/*
+	 * Included refs is a list of wildmatch patterns. If any of the
+	 * patterns match, the reference will be included.
+	 */
+	struct string_list included_refs;
+
 	/*
 	 * Hidden refs is a list of patterns that is to be hidden via
 	 * `ref_is_hidden()`.
@@ -110,6 +116,7 @@ struct ref_visibility {
  */
 #define REF_VISIBILITY_INIT { \
 	.excluded_refs = STRING_LIST_INIT_DUP, \
+	.included_refs = STRING_LIST_INIT_DUP, \
 	.hidden_refs = STRING_LIST_INIT_DUP, \
 }
 
@@ -485,12 +492,22 @@ void show_object_with_name(FILE *, struct object *, const char *);
 
 /**
  * Helpers to check if a reference should be excluded.
+ *
+ * ref_excluded() checks if a ref has been explicitly excluded either
+ * because it is hidden, or it was added via an add_ref_exclusion() call.
+ *
+ * ref_visible() checks if a ref is visible by taking into account whether a ref
+ * has been included via an add_ref_inclusion() call, but also whether it has
+ * been excluded via add_ref_exclusion(). Exclusions take precedence. If a ref
+ * is hidden, it will also be treated as not visible.
+ *
  */
-
-int ref_excluded(const struct ref_visibility *exclusions, const char *path);
+int ref_excluded(const struct ref_visibility *visibility, const char *path);
+int ref_visible(const struct ref_visibility *visibility, const char *path);
 void init_ref_visibility(struct ref_visibility *);
 void clear_ref_visibility(struct ref_visibility *);
 void add_ref_exclusion(struct ref_visibility *, const char *exclude);
+void add_ref_inclusion(struct ref_visibility *, const char *include);
 void exclude_hidden_refs(struct ref_visibility *, const char *section);
 
 /**
-- 
gitgitgadget

