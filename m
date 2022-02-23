Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B23C433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243945AbiBWScS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243906AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536EC4B853
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l13so90836wrt.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9JjItsrO9AFu5slq2QOt5nLhfyq3iogPwFsHJ47dvPk=;
        b=hkhV3vWuVYrmRIr60JXJsV/5/4bozgwkIyaX0EiUqKpeIhsVLA4hkGXWu3Y85Zjme/
         ToLvi5OLk1iUALuDXBS4nseSydpoda5uJi0CoJZ07hZ5Uq9bl/ejiJvuUPFTfaTVd9fY
         kh+HyfGFgtcSkezTb1ZxlmPDgIHcq6/n8SkCW+VtrMfo1T8xRfdQ2ZJlpTHldBtB2SU+
         +73rij1xUHKj8TuhdVCUteGTkUkW7S/2UYDYlX/9WQzH4V0JJxfpqSBOTpGnPtZv2chz
         xRUWclTsBoQ9/hBp7gPn4gS1OTZ2sHEkF1/nnawsZ35l7Vj5LDGADMesGUk9IFxdUF/P
         zGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9JjItsrO9AFu5slq2QOt5nLhfyq3iogPwFsHJ47dvPk=;
        b=YWgQohxpnymPrwHmiGfvrkAp3eiune7p2oWN2xb1JP2fSApEh5F++A4/rgTFXfwulk
         wv4u1DP2YDUhJ/HKEQhOd6bbSvBdPKpDKRXaQvkOrsSeLqaJcYSyh4W1QifZ/iRbnyZE
         IjeaSBtffzF5NiNi5OKCDMKOaM+313Vhma8cgfWExzOc5dVf6FD/7kD8bPai3u7QlmL3
         5COOEpOKowaNc4VVdKxZN1MDyaKoz8sy09jcaQ6bApmxxgcVL9qvB3EXBoFspU5tNbnE
         kGKvvhwReSJK3UeitapeYc+Mk6nJvMQKqX17u2fiwJhGsQdYcEzuQ2+Bn4Wx80U32U6K
         wvmQ==
X-Gm-Message-State: AOAM533dwRH1qSc9uP8Mo5QJajmmb6w0phb/8SO8x3ns14fZ9xTxjzZt
        +nHuqY92v7Q/I+BtuvwBoBO1yvMbQ1Y=
X-Google-Smtp-Source: ABdhPJwrExarnw/31iiqE8ZL73MHOmFOAiRwrWnIHk94EnB+GaIMAB4/QL/+U6n4Z2rjxepPG9/7KA==
X-Received: by 2002:a5d:6106:0:b0:1ed:b56f:73f7 with SMTP id v6-20020a5d6106000000b001edb56f73f7mr693681wrt.601.1645641080751;
        Wed, 23 Feb 2022 10:31:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm314976wrq.117.2022.02.23.10.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:20 -0800 (PST)
Message-Id: <7ec7ba3f328f9d6fa7f919ce18a138840d44ee49.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:53 +0000
Subject: [PATCH 15/25] config: add git_config_get_timestamp()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The existing config parsing methods do not include a way to consistently
parse timestamps across all platforms. Recall that "unsigned long" is
32 bits on 64-bit Windows, so git_config_get_ulong() is insufficient.

Adding a new type requires quite a bit of boilerplate to match the style
of other types.

RFC-QUESTION: Would this be better to use uintmax_t, which could be cast
to timestamp_t or other types more robust than "unsigned long"?

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 config.c | 39 +++++++++++++++++++++++++++++++++++++++
 config.h | 14 ++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/config.c b/config.c
index e0c03d154c9..84021b7d504 100644
--- a/config.c
+++ b/config.c
@@ -1228,6 +1228,15 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 1;
 }
 
+int git_parse_timestamp(const char *value, timestamp_t *ret)
+{
+	uintmax_t tmp;
+	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(timestamp_t)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 int git_parse_ssize_t(const char *value, ssize_t *ret)
 {
 	intmax_t tmp;
@@ -1296,6 +1305,14 @@ unsigned long git_config_ulong(const char *name, const char *value)
 	return ret;
 }
 
+timestamp_t git_config_timestamp(const char *name, const char *value)
+{
+	timestamp_t ret;
+	if (!git_parse_timestamp(value, &ret))
+		die_bad_number(name, value);
+	return ret;
+}
+
 ssize_t git_config_ssize_t(const char *name, const char *value)
 {
 	ssize_t ret;
@@ -2328,6 +2345,16 @@ int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned lon
 		return 1;
 }
 
+int git_configset_get_timestamp(struct config_set *cs, const char *key, timestamp_t *dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		*dest = git_config_timestamp(key, value);
+		return 0;
+	} else
+		return 1;
+}
+
 int git_configset_get_bool(struct config_set *cs, const char *key, int *dest)
 {
 	const char *value;
@@ -2471,6 +2498,13 @@ int repo_config_get_ulong(struct repository *repo,
 	return git_configset_get_ulong(repo->config, key, dest);
 }
 
+int repo_config_get_timestamp(struct repository *repo,
+			      const char *key, timestamp_t *dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_timestamp(repo->config, key, dest);
+}
+
 int repo_config_get_bool(struct repository *repo,
 			 const char *key, int *dest)
 {
@@ -2544,6 +2578,11 @@ int git_config_get_ulong(const char *key, unsigned long *dest)
 	return repo_config_get_ulong(the_repository, key, dest);
 }
 
+int git_config_get_timestamp(const char *key, timestamp_t *dest)
+{
+	return repo_config_get_timestamp(the_repository, key, dest);
+}
+
 int git_config_get_bool(const char *key, int *dest)
 {
 	return repo_config_get_bool(the_repository, key, dest);
diff --git a/config.h b/config.h
index ab0106d2875..a6e4d35da0a 100644
--- a/config.h
+++ b/config.h
@@ -206,6 +206,7 @@ int config_with_options(config_fn_t fn, void *,
 
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
+int git_parse_timestamp(const char *, timestamp_t *);
 
 /**
  * Same as `git_config_bool`, except that it returns -1 on error rather
@@ -226,6 +227,11 @@ int64_t git_config_int64(const char *, const char *);
  */
 unsigned long git_config_ulong(const char *, const char *);
 
+/**
+ * Identical to `git_config_int`, but for (unsigned) timestamps.
+ */
+timestamp_t git_config_timestamp(const char *name, const char *value);
+
 ssize_t git_config_ssize_t(const char *, const char *);
 
 /**
@@ -469,6 +475,7 @@ int git_configset_get_string(struct config_set *cs, const char *key, char **dest
 int git_configset_get_string_tmp(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
+int git_configset_get_timestamp(struct config_set *cs, const char *key, timestamp_t *dest);
 int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
 int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
@@ -489,6 +496,8 @@ int repo_config_get_int(struct repository *repo,
 			const char *key, int *dest);
 int repo_config_get_ulong(struct repository *repo,
 			  const char *key, unsigned long *dest);
+int repo_config_get_timestamp(struct repository *repo,
+			      const char *key, timestamp_t *dest);
 int repo_config_get_bool(struct repository *repo,
 			 const char *key, int *dest);
 int repo_config_get_bool_or_int(struct repository *repo,
@@ -558,6 +567,11 @@ int git_config_get_int(const char *key, int *dest);
  */
 int git_config_get_ulong(const char *key, unsigned long *dest);
 
+/**
+ * Similar to `git_config_get_int` but for (unsigned) timestamps.
+ */
+int git_config_get_timestamp(const char *key, timestamp_t *dest);
+
 /**
  * Finds and parses the value into a boolean value, for the configuration
  * variable `key` respecting keywords like "true" and "false". Integer
-- 
gitgitgadget

