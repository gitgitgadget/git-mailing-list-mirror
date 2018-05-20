Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61FED1F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeETKnp (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:43:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36448 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeETKno (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:43:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id n10-v6so21937512wmc.1
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSbc9I6560NqglvZmLX/N+S8zCzpWj7JgyN8JVgP3qw=;
        b=JcB/YAoxyU6Ae/DXAlEhL5X6BRNSdMQ8x7vasU5vm4WlpMBOj0sdzARQmG3PVov8Ct
         drVlT2BP5MdUPF1Hr8CAVF8f/JeDrLSSPHFL05KC284FpNq1ExeI4L3nWFcpCQ89mwoL
         ufvpCgAavEiy+dAyFtaSKgW3yR/JLZxNsQGGPAifGU6erLd5+V6qEzy6oEolJ27owjcw
         vniCnKSavWgdJ36OrocqvFGM3keZXK0VdQlb0i3QOTlGQd8jq1TAyOFLrzxZoE0iOYRK
         0R5bIl7j8L3c3pQHga8C+qMnvtoSdX+wNSvKeUpAJ2m1TAI1xL4QnumVj+Wa8vr/Lfhi
         MNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSbc9I6560NqglvZmLX/N+S8zCzpWj7JgyN8JVgP3qw=;
        b=QZQt8W+lgpjIM2a2MCCyuWnwWvpYIeSL/f8kaa79tg/7ad+DeAyi6h33Y66wRU6yCz
         MQf3T//6WhKMPklsrJfSHtFnsqrbE5ZnwofrzlrhDaKqeUwhRSau58ItJIytE/o7hA4w
         mqZH+8dXk+qCz0oG8B8qiqmjHSbPb4Px1eBe4xZXLkTfR+YYZqzOV0P5IQcvvCgJJpi+
         GqEgBE5jcKw9pZdweT3YIajQLT7unCg2X+aF+229iSrgRa7QAVY7/Albhjk6AHi7qLtC
         ZpFWj2U774XjuS2aCtXctE9GiaZmeb1yUDHRKJfWwIqLjxrMOmqyMJefozjaNcweqA6c
         8+ZA==
X-Gm-Message-State: ALKqPwcxSviS2MYodDQDyNIvvMUZYDQAbKEL87X/FQTW4FNNuY8tEQPw
        vBS4nG8k1Hdhmel9mJjmOxAwQ6jC80g=
X-Google-Smtp-Source: AB8JxZoGZ7xHHNbuMO6BAxLI2TrFFEZQRqUexJHemDYBY7jRMnuTY14Dit4KfPqeSDGsOSjKYfrFAA==
X-Received: by 2002:a1c:ee58:: with SMTP id m85-v6mr8932721wmh.44.1526813022902;
        Sun, 20 May 2018 03:43:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id c21-v6sm13595974wre.81.2018.05.20.03.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:43:42 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 3/3] config: let `config_store_data_clear()` handle `key`
Date:   Sun, 20 May 2018 12:42:35 +0200
Message-Id: <e71b2abd7298de0123a6222186a8faa3fadf50c0.1526812503.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526812503.git.martin.agren@gmail.com>
References: <CAPig+cT1eejizU26mPE+tN+eZR4Wg0jw1DbmShgqRu69EYQutQ@mail.gmail.com> <cover.1526812503.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of remembering to free `key` in each code path, let
`config_store_data_clear()` handle that.

We still need to free it before replacing it, though. Move that freeing
closer to the replacing to be safe. Note that in that same part of the
code, we can no longer set `key` to the original pointer, but need to
`xstrdup()` it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 config.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index ac71f3f2e1..339a92235d 100644
--- a/config.c
+++ b/config.c
@@ -2335,6 +2335,7 @@ struct config_store_data {
 
 static void config_store_data_clear(struct config_store_data *store)
 {
+	free(store->key);
 	if (store->value_regex != NULL &&
 	    store->value_regex != CONFIG_REGEX_NONE) {
 		regfree(store->value_regex);
@@ -2679,7 +2680,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	fd = hold_lock_file_for_update(&lock, config_filename, 0);
 	if (fd < 0) {
 		error_errno("could not lock config file %s", config_filename);
-		free(store.key);
 		ret = CONFIG_NO_LOCK;
 		goto out_free;
 	}
@@ -2689,8 +2689,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	 */
 	in_fd = open(config_filename, O_RDONLY);
 	if ( in_fd < 0 ) {
-		free(store.key);
-
 		if ( ENOENT != errno ) {
 			error_errno("opening %s", config_filename);
 			ret = CONFIG_INVALID_FILE; /* same as "invalid config file" */
@@ -2702,7 +2700,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			goto out_free;
 		}
 
-		store.key = (char *)key;
+		free(store.key);
+		store.key = xstrdup(key);
 		if (write_section(fd, key, &store) < 0 ||
 		    write_pair(fd, key, value, &store) < 0)
 			goto write_err_out;
@@ -2752,13 +2751,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 						      config_filename,
 						      &store, &opts)) {
 			error("invalid config file %s", config_filename);
-			free(store.key);
 			ret = CONFIG_INVALID_FILE;
 			goto out_free;
 		}
 
-		free(store.key);
-
 		/* if nothing to unset, or too many matches, error out */
 		if ((store.seen_nr == 0 && value == NULL) ||
 		    (store.seen_nr > 1 && multi_replace == 0)) {
-- 
2.17.0.840.g5d83f92caf

