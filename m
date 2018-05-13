Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D591F42D
	for <e@80x24.org>; Sun, 13 May 2018 09:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeEMJ7H (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 05:59:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45047 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbeEMJ7G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 05:59:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id y15-v6so9255301wrg.11
        for <git@vger.kernel.org>; Sun, 13 May 2018 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3R2+IboDDz9Sy0RUlHYQ+UFitHFbBDg3gj4kypNxzJk=;
        b=cMCuU4pAvTXGX8KYV45F/BF1dw7gb97IA7Cphli+hOBExtEVn1BR3ZGLtC4rTL2K0J
         zIJb1Fya/A0y0lruIuHJNN91gEXM2NYMB5Ph0Cu7xZcFzyuN+DFor7qQG/rJUgy7UV5p
         tv0qmhFQZBN0j1cBm9jNmLlR5IUABOGb4xhlRCq1Hy7twRmcW1HGr/zJ6jIZDgdlTeP3
         KW2tljqnKnhuJvQotAgNh9SKYWC1Js3y68BRvdhllIicmuggKkUv3r6YQELc6ljt3s2y
         +iIiICAgyrhjRDNwc/LMyL/IkAEAi6sXVZpS/nVVx09rZsrgJxVgPdVsiqO/yN31gpW0
         maMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3R2+IboDDz9Sy0RUlHYQ+UFitHFbBDg3gj4kypNxzJk=;
        b=bxRdoPAy07sCqyefc+5kpGmyqTo7ydl1AIWG9+QorX5tGrSK8o2y/EKEKJmkJjMF7I
         MAynTFi692/s+wmah+z9N5kOcEhIp0fTN1xOd/mIvf1Tow5OgXKa97WNxR5W6/iHmYzP
         a2lPAucnP3uOakgzdVInWqKRV/QKqeAOdlqWVPjc6rLe6oVtOz4vOAoNVZwtALQqOvNH
         OEiEfIECQQLK4QlpV2GtlOqZ+5W7VhtOA3nbtv+dRD6jjz/L/HQM2f6Hw/fhNVCgg+qK
         jNPAmI6ggCkaQqV7o3ydPk9XKkUmfxNHFb0wXJiBJumJMXaBCV8UK+U5O7BGQGOXbTiI
         +w4g==
X-Gm-Message-State: ALKqPwdBKPk/Ys6u3QQl5U/yHTQm/t2kJgWYW2oHVEQ1ySrJpNDglEab
        DcK5or9Nvh7qVWeMG3vVmjc=
X-Google-Smtp-Source: AB8JxZoQKePT0tSLafpnlC5gS9RC6ik6lfrUOOy6zkxN9Y6TT8Jx50icvLGpX5uHOz3KnzhYNZaX9Q==
X-Received: by 2002:adf:b067:: with SMTP id g36-v6mr3938493wra.128.1526205545307;
        Sun, 13 May 2018 02:59:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id k28-v6sm9986872wrk.46.2018.05.13.02.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 May 2018 02:59:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/1] config: let `config_store_data_clear()` handle `key`
Date:   Sun, 13 May 2018 11:58:38 +0200
Message-Id: <8873a578e1dbc0d1c6566e1a68b7b0a7741b6b0d.1526204440.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.583.g9a75a153ac
In-Reply-To: <cover.1526204440.git.martin.agren@gmail.com>
References: <CAPig+cThT3VVw75VF0wuF-yR-xbnfNOxhviYGZLAksF8HFuOGw@mail.gmail.com> <cover.1526204440.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of carefully clearing up `key` in each code path, let
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
index 2e3c6c94e9..963edacf10 100644
--- a/config.c
+++ b/config.c
@@ -2335,6 +2335,7 @@ struct config_store_data {
 
 void config_store_data_clear(struct config_store_data *store)
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
@@ -2751,13 +2750,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
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
2.17.0.583.g9a75a153ac

