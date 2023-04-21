Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B7C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjDUTNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjDUTNf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24291FF6
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f191c1a8a7so7405985e9.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104405; x=1684696405;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug6N0lXLlD10R2gkLAtlCgygX6Ohv02n1hnop4ghWo8=;
        b=WaZ4XCORsju+6sRfMc4LHoI5Zo1Ftlc5U/uDaj/0b1vjTYsRMVze2uPScBdtoNlzsX
         lrUPT7iaYDmj+/Cr8rKqAUcPOjvk9p/zsttXSL+VyDQb3j16RCpriTJVef6UtyZBkOgt
         XHTWU6jNnpj5bAy8/jQI9ocK2v4iVGNDa5jHre2fZkpHmX57/k4DjiyB6mnVh7LVyuT0
         IH+3mRwTIHTJmGErjFcOY7m2+mmwoMwusEkMPsdtSbCKmg6k6PQYmkwpKZErD2GNzXR3
         ZgYh0bpcldH1S0WZQDDN6sDi+ePmhIKYcNguKadm2844VdUdxyUP6xJv7b7QJVqetTLE
         KVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104405; x=1684696405;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug6N0lXLlD10R2gkLAtlCgygX6Ohv02n1hnop4ghWo8=;
        b=kZT3KyNNLAvr7afB8l9PWt4o0ZhcGKDPX7FjTqkwUCdQNu3N+ptaOyAI5CHcARKNiP
         wb7o5VEOJ8+CExfIzfRcA0Tzbci31VnglxAx6Xv0oUxzNUdS4gMTaMp8xmPEpLGWk7KC
         +Jf3b++ahiAg6Ij+t8UKg7cJ5ojUmc4xiHEmklSYFV/gV4qj9QsktDpYLhSuRgxyySnw
         Xd8mUaQaaU0nRW5TvOrpXSDieXLg8nIEQDkZejQj7wFrlwr/YoeZ/TsoasU6mEbk91yb
         rOI4nvNaNVk2Y/01pYydXPTxrD/0Uun0wpyQE0RF+5XEPxIvDnN3A0cOopHCU01cdohR
         JI4w==
X-Gm-Message-State: AAQBX9fxOp4UlzuL8lxZUCxoXwSAjCP+a2cQOEg+vfqFnUj8TFZij6pr
        iHWxOYSP1C1oP0X1BvD0GlemEnHIDPM=
X-Google-Smtp-Source: AKy350bNlWCEPho1WrYz1Co9chSlZqh2BSA+2CIozngOxmvbE3v7l/cDc4o1ZqZtT7+XnAVuDH5qKA==
X-Received: by 2002:a1c:730a:0:b0:3f1:7517:803d with SMTP id d10-20020a1c730a000000b003f17517803dmr2558144wmb.4.1682104405112;
        Fri, 21 Apr 2023 12:13:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003f195d540d9sm1151846wmo.14.2023.04.21.12.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
Message-Id: <961d06f89cb667c31a4a2c8f41fdd9a2bfda04f8.1682104399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:12 +0000
Subject: [PATCH 08/14] (RFC-only) config: add kvi arg to config_fn_t
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

..without actually changing any of its implementations. This commit does
not build - I've split this out for readability, but post-RFC I will
squash this with the rest of the refactor + cocci changes.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c                                      |   2 +-
 config.h                                      |  20 +--
 .../coccinelle/config_fn_kvi.pending.cocci    | 146 ++++++++++++++++++
 3 files changed, 157 insertions(+), 11 deletions(-)
 create mode 100644 contrib/coccinelle/config_fn_kvi.pending.cocci

diff --git a/config.c b/config.c
index 147e422a27b..758d6a5cc3b 100644
--- a/config.c
+++ b/config.c
@@ -617,7 +617,7 @@ static int kvi_fn(config_fn_t fn, const char *key, const char *value,
 {
 	int ret;
 	config_reader_push_kvi(&the_reader, kvi);
-	ret = fn(key, value, data);
+	ret = fn(key, value, kvi, data);
 	config_reader_pop_kvi(&the_reader);
 	return ret;
 }
diff --git a/config.h b/config.h
index 525fc0d5e03..2c7b7399691 100644
--- a/config.h
+++ b/config.h
@@ -117,6 +117,15 @@ struct config_options {
 	} error_action;
 };
 
+struct key_value_info {
+	const char *filename;
+	int linenr;
+	enum config_origin_type origin_type;
+	enum config_scope scope;
+	const char *path;
+	struct key_value_info *prev;
+};
+
 /**
  * A config callback function takes three parameters:
  *
@@ -135,7 +144,7 @@ struct config_options {
  * A config callback should return 0 for success, or -1 if the variable
  * could not be parsed properly.
  */
-typedef int (*config_fn_t)(const char *, const char *, void *);
+typedef int (*config_fn_t)(const char *, const char *, struct key_value_info *, void *);
 
 int git_default_config(const char *, const char *, void *);
 
@@ -675,15 +684,6 @@ int git_config_get_expiry(const char *key, const char **output);
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
 int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
 
-struct key_value_info {
-	const char *filename;
-	int linenr;
-	enum config_origin_type origin_type;
-	enum config_scope scope;
-	const char *path;
-	struct key_value_info *prev;
-};
-
 /**
  * First prints the error message specified by the caller in `err` and then
  * dies printing the line number and the file name of the highest priority
diff --git a/contrib/coccinelle/config_fn_kvi.pending.cocci b/contrib/coccinelle/config_fn_kvi.pending.cocci
new file mode 100644
index 00000000000..d4c84599afa
--- /dev/null
+++ b/contrib/coccinelle/config_fn_kvi.pending.cocci
@@ -0,0 +1,146 @@
+// These are safe to apply to *.c *.h builtin/*.c
+
+@ get_fn @
+identifier fn, R;
+@@
+(
+(
+git_config_from_file
+|
+git_config_from_file_with_options
+|
+git_config_from_mem
+|
+git_config_from_blob_oid
+|
+read_early_config
+|
+read_very_early_config
+|
+config_with_options
+|
+git_config
+|
+git_protected_config
+|
+config_from_gitmodules
+)
+  (fn, ...)
+|
+repo_config(R, fn, ...)
+)
+
+@ extends get_fn @
+identifier C1, C2, D;
+@@
+int fn(const char *C1, const char *C2,
++  struct key_value_info *kvi,
+  void *D);
+
+@ extends get_fn @
+@@
+int fn(const char *, const char *,
++  struct key_value_info *,
+  void *);
+
+@ extends get_fn @
+// Don't change fns that look like callback fns but aren't
+identifier fn2 != tar_filter_config && != git_diff_heuristic_config &&
+  != git_default_submodule_config && != git_color_config &&
+  != bundle_list_update && != parse_object_filter_config;
+identifier C1, C2, D1, D2, S;
+attribute name UNUSED;
+@@
+int fn(const char *C1, const char *C2,
++  struct key_value_info *kvi,
+  void *D1) {
+<+...
+(
+fn2(C1, C2,
++ kvi,
+D2);
+|
+if(fn2(C1, C2,
++ kvi,
+D2) < 0) { ... }
+|
+return fn2(C1, C2,
++ kvi,
+D2);
+|
+S = fn2(C1, C2,
++ kvi,
+D2);
+)
+...+>
+  }
+
+@ extends get_fn@
+identifier C1, C2, D;
+attribute name UNUSED;
+@@
+int fn(const char *C1, const char *C2,
++  struct key_value_info *kvi UNUSED,
+  void *D) {...}
+
+
+// The previous rules don't catch all callbacks, especially if they're defined
+// in a separate file from the git_config() call. Fix these manually.
+@@
+identifier C1, C2, D;
+attribute name UNUSED;
+@@
+int
+(
+git_ident_config
+|
+urlmatch_collect_fn
+|
+write_one_config
+|
+forbid_remote_url
+|
+credential_config_callback
+)
+  (const char *C1, const char *C2,
++  struct key_value_info *kvi UNUSED,
+  void *D) {...}
+
+@@
+identifier C1, C2, D, D2, S, fn2;
+@@
+int
+(
+http_options
+|
+git_status_config
+|
+git_commit_config
+|
+git_default_core_config
+|
+grep_config
+)
+  (const char *C1, const char *C2,
++  struct key_value_info *kvi,
+  void *D) {
+<+...
+(
+fn2(C1, C2,
++ kvi,
+D2);
+|
+if(fn2(C1, C2,
++ kvi,
+D2) < 0) { ... }
+|
+return fn2(C1, C2,
++ kvi,
+D2);
+|
+S = fn2(C1, C2,
++ kvi,
+D2);
+)
+...+>
+  }
-- 
gitgitgadget

