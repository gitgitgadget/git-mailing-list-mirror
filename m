Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B9BC77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjDUTN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjDUTNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:23 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8DE10DA
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so21817835e9.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104401; x=1684696401;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZjpw2+PooEFjE8q5ZJgDTuQ/OQCgx3h9r6kEL09ybI=;
        b=B0o4y7iJnkPsjcCdt0BFpQd9XpFftJ8MDtwewe3l0c+nwGo6H2Dw9SSz2LrmJOsF1/
         5iljxRqjjW5t5L9TbG5RWnVmNhRvhoLI0VqVcq4NwYI3RKutBgGHC796+FSJuGj8pXrt
         YJYUCalQwKnBNoONmsal/wEft6CInU93x/NvavMbQADbgTaTJuvuOrrkHtCDzp2X3+vU
         9vDfwEJ+QMpkNm8+IHkRIPWlKtfhKa3UpAvSIu8b1cYXG3C8jlxV83dx7uxUv7j7FUen
         gXXSMeFBeLG/OKsHFUpvFOG3nx468ERCQXG6XMcmFmgpLs8OgAZq+CWEu5dfV1+wk7YE
         YCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104401; x=1684696401;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZjpw2+PooEFjE8q5ZJgDTuQ/OQCgx3h9r6kEL09ybI=;
        b=BvRPVYzPW3eCOeq93ubwZdQm4r1a6fDmQIhizCbSOreyg5/RTs9GzJR/Oeqmn/i1oZ
         hV+zjiC05FdlMwMcEM5p85lqnukIjXtqFFoYC9yV3m6RuMrEdWMFeM/8bKqd4Z49lC3s
         Zks0h5NJBF7UxzPAZGa0T7BDk/rDOV9RxANVXHe4QhmseT1iXd1JZFTnD4ARTKlvo5+T
         Na8XISaoNzLnjRn5SNfktSjrd6SEWw6RLZvQ15JvZ0t36kZXwWQx4N2nb4mnHexyBDOh
         13MlGG4B1VGk6APynzkm14gPGTvy/DMDilAJpw1lNc9hD/JtXKCHVmdIKMa3icRpLkha
         Nrqw==
X-Gm-Message-State: AAQBX9fwvtqMp+EH96UpZoA87iBiGNnV5Xq/Q7VdKXdwhcjmowXBzdiR
        91cNkeYOweaz+zCXnUl2zZDPuoXhfx8=
X-Google-Smtp-Source: AKy350YIYPEgBR/Q67eem3OQAOApXuoZAJ+YckaWRzWcHaN3ZxzcfPP0B1UTlp2CjXKYsOrDdpgFyw==
X-Received: by 2002:a05:600c:b5a:b0:3f1:979f:a734 with SMTP id k26-20020a05600c0b5a00b003f1979fa734mr275156wmr.11.1682104400917;
        Fri, 21 Apr 2023 12:13:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003f17848673fsm5527988wml.27.2023.04.21.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:20 -0700 (PDT)
Message-Id: <49bc2f6eedc923be631379c9b65956855ec25f35.1682104398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:05 +0000
Subject: [PATCH 01/14] config.c: introduce kvi_fn(), use it for configsets
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

In order to pass "struct key_value_info" to config callbacks in a future
commit, we want to make sure that a "struct key_value_info" is available
in all code paths that invoke a config callback.

Enforce this by introducing a helper function, "kvi_fn()", that sets
"the_reader.config_kvi" before invoking the config callback, and
trivially use it in "configset_iter()". This closely simulates passing
an extra "struct key_value_info" such that making the switch will be
trivial.

This breaks our rule that no underlying machinery uses "the_reader", but
"struct config_reader" will be gone by the end of the series so there's
no point plumbing it as an arg.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/config.c b/config.c
index 493f47df8ae..daad892e4fd 100644
--- a/config.c
+++ b/config.c
@@ -660,6 +660,17 @@ out_free_ret_1:
 	return -CONFIG_INVALID_KEY;
 }
 
+static int kvi_fn(config_fn_t fn, const char *key, const char *value,
+		  struct key_value_info *kvi,
+		  void *data)
+{
+	int ret;
+	config_reader_set_kvi(&the_reader, kvi);
+	ret = fn(key, value, data);
+	config_reader_set_kvi(&the_reader, NULL);
+	return ret;
+}
+
 static int config_parse_pair(const char *key, const char *value,
 			  config_fn_t fn, void *data)
 {
@@ -2288,27 +2299,24 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-static void configset_iter(struct config_reader *reader, struct config_set *set,
-			   config_fn_t fn, void *data)
+static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &set->list;
+	struct key_value_info *kvi;
 
 	for (i = 0; i < list->nr; i++) {
 		entry = list->items[i].e;
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
+		kvi = values->items[value_index].util;
 
-		config_reader_set_kvi(reader, values->items[value_index].util);
-
-		if (fn(entry->key, values->items[value_index].string, data) < 0)
-			git_die_config_linenr(entry->key,
-					      reader->config_kvi->filename,
-					      reader->config_kvi->linenr);
-
-		config_reader_set_kvi(reader, NULL);
+		if (kvi_fn(fn, entry->key, values->items[value_index].string,
+			   kvi, data) < 0)
+			git_die_config_linenr(entry->key, kvi->filename,
+					      kvi->linenr);
 	}
 }
 
@@ -2696,7 +2704,7 @@ static void repo_config_clear(struct repository *repo)
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
 	git_config_check_init(repo);
-	configset_iter(&the_reader, repo->config, fn, data);
+	configset_iter(repo->config, fn, data);
 }
 
 int repo_config_get(struct repository *repo, const char *key)
@@ -2815,7 +2823,7 @@ void git_protected_config(config_fn_t fn, void *data)
 {
 	if (!protected_config.hash_initialized)
 		read_protected_config();
-	configset_iter(&the_reader, &protected_config, fn, data);
+	configset_iter(&protected_config, fn, data);
 }
 
 /* Functions used historically to read configuration from 'the_repository' */
-- 
gitgitgadget

