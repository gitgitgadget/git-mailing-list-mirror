Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C6C77B73
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjE3Smc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjE3SmY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16D511A
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so34813165e9.0
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472140; x=1688064140;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoK7rHJmznOk7aNEb/vNwVXo7CynwB2gaP25Wtussu4=;
        b=TSv2a7hiDsROflm6Apso5nbBl5e2L9GkFCEvUFkeTA6zpzGbkduKslPi3Bn04FbvIO
         ZJuRU7DMvgB6RKqeQ8Z89iybl9qJU9qcYJbeh6oCIkEX0rMB6YsMPeQb6K5TpewA70nY
         Y0HukNR4i8sL2U+s41ShLSRUo3kUxWd2z2mMwjGPxQJYfpUBPCiRTx7Z4ULD7cegsuBc
         cK38/gmxce10tHzwv6Apkohsu28x/9joPp441W1eGxinTlx6bgom0RlWGWIUN7s3Uv66
         pVofBECDb4ZFDVcWwa19WEjWEcFUMEw916zBrnJHW2HFujDJRJIRWuKZmdmGMsC+v/5i
         OC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472140; x=1688064140;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoK7rHJmznOk7aNEb/vNwVXo7CynwB2gaP25Wtussu4=;
        b=RnFH+KbYJs1F4JpEeoMSL5nv9yKqtkmjVbQB7WDUMPWkpdkHUsbh7cNnMRluvKAUU/
         /+h847fwA1KekryCyT2XzHtHx904FtMCIkHbinrLHvkOBVm0Cd0ncIxZce2sW6VtvE+L
         ECN5Y7V2/LUVHuv7yqvnpk3Z3wRjX8mErg5fINJ3IN4UWDg0TwkOabGi9wTuqnZyHibw
         OprBdS5IV5BEQSF/cQXdZ7h2tUqavrDli1KTAhiqfGMch+/Uym/62T5uDifzVA9C7IVX
         QOaHfQe+Xa7hF56D3DdquzazYyDMWuiK4ZLS6schbfvzelkk6vQ4xZrObgnuK54HGvXQ
         aOKw==
X-Gm-Message-State: AC+VfDz0elNonXlQvcSwJ3tgKFYtAvdbuV6WCdMFUrh94xaAjAkTpLdC
        GFNBIUMTut2zvWQk45qlTUPrhMW0uIs=
X-Google-Smtp-Source: ACHHUZ7VB8NJk9mMNCA9bKiSA+IRKX3c2KdIFTtM7hTzvKog7RnWCun0g4sp2QQ8eJJgGo78EeUK4w==
X-Received: by 2002:a1c:4b0f:0:b0:3f4:2267:10cf with SMTP id y15-20020a1c4b0f000000b003f4226710cfmr2415300wma.32.1685472139658;
        Tue, 30 May 2023 11:42:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c205700b003f42314832fsm18134040wmg.18.2023.05.30.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:19 -0700 (PDT)
Message-Id: <6834e37066e7877646fc7c37aa79704d14381251.1685472133.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:01 +0000
Subject: [PATCH v2 03/14] (RFC-only) config: add kvi arg to config_fn_t
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
 config.c                                      |   8 +-
 config.h                                      |  16 +-
 .../coccinelle/config_fn_kvi.pending.cocci    | 146 ++++++++++++++++++
 3 files changed, 158 insertions(+), 12 deletions(-)
 create mode 100644 contrib/coccinelle/config_fn_kvi.pending.cocci

diff --git a/config.c b/config.c
index 493f47df8ae..945f4f3b77e 100644
--- a/config.c
+++ b/config.c
@@ -489,7 +489,7 @@ static int git_config_include(const char *var, const char *value, void *data)
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
 	 */
-	ret = inc->fn(var, value, inc->data);
+	ret = inc->fn(var, value, NULL, inc->data);
 	if (ret < 0)
 		return ret;
 
@@ -671,7 +671,7 @@ static int config_parse_pair(const char *key, const char *value,
 	if (git_config_parse_key(key, &canonical_name, NULL))
 		return -1;
 
-	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
+	ret = (fn(canonical_name, value, NULL, data) < 0) ? -1 : 0;
 	free(canonical_name);
 	return ret;
 }
@@ -959,7 +959,7 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 	 * accurate line number in error messages.
 	 */
 	cs->linenr--;
-	ret = fn(name->buf, value, data);
+	ret = fn(name->buf, value, NULL, data);
 	if (ret >= 0)
 		cs->linenr++;
 	return ret;
@@ -2303,7 +2303,7 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
 
 		config_reader_set_kvi(reader, values->items[value_index].util);
 
-		if (fn(entry->key, values->items[value_index].string, data) < 0)
+		if (fn(entry->key, values->items[value_index].string, NULL, data) < 0)
 			git_die_config_linenr(entry->key,
 					      reader->config_kvi->filename,
 					      reader->config_kvi->linenr);
diff --git a/config.h b/config.h
index 247b572b37b..9d052c52c3c 100644
--- a/config.h
+++ b/config.h
@@ -111,6 +111,13 @@ struct config_options {
 	} error_action;
 };
 
+struct key_value_info {
+	const char *filename;
+	int linenr;
+	enum config_origin_type origin_type;
+	enum config_scope scope;
+};
+
 /**
  * A config callback function takes three parameters:
  *
@@ -129,7 +136,7 @@ struct config_options {
  * A config callback should return 0 for success, or -1 if the variable
  * could not be parsed properly.
  */
-typedef int (*config_fn_t)(const char *, const char *, void *);
+typedef int (*config_fn_t)(const char *, const char *, struct key_value_info *, void *);
 
 int git_default_config(const char *, const char *, void *);
 
@@ -667,13 +674,6 @@ int git_config_get_expiry(const char *key, const char **output);
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
 int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
 
-struct key_value_info {
-	const char *filename;
-	int linenr;
-	enum config_origin_type origin_type;
-	enum config_scope scope;
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

