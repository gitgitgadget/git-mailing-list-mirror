Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A62C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35896124B
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbhI1M5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbhI1M5r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 08:57:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37E2C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:56:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d26so301195wrb.6
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF0rnwVYRFYa2PmQGyz3UORl2ZLo7puwXcmDDuAU9Z0=;
        b=OaM6SAprEiniYQHL+pF2ZrexHNjOaWrwEovknX6dLg6EBJVl3eKI4TY3ec7AzKoREt
         7WT98NGLJLBbPGYvj7q7EeXVsu4Pf/Sl++k0Ih1iMZYvC5JpbQdEB64yWfNJOHHrSxn6
         jevfVWDQ7pOAIm/qLad6GV1hMk492hsqlFL1D+j/Ok07bsH8DdfrJSpaMQtztbXf0Spd
         agNch3vIjpJ2nWlyPnC3NuDg2aWEBM2wTiptUIkHSjh0ih1KxdapvlMj8x5fa6vQiQgJ
         9mzS3VbSKSVeO7anxqyh0wdvOJHuKZBioCU9UT2lBEyAZ2pQAXDo7n7/K3cy623owA8x
         foTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF0rnwVYRFYa2PmQGyz3UORl2ZLo7puwXcmDDuAU9Z0=;
        b=pOlvoVUKouiUJxsSBx+Qlo/59orn6FNt/LF9q/By93EQoRv6MerhrH2zzz2J8AqG/j
         1DGkmOwechKFVyslk1Snhf/Sz6jWbKWeWrlH1CkGRRQ3CZQ0bXs4bYm0EBn4ziZy89eW
         ukLuGw4x5d14bvuPo4YPQ3r5auq9D1Ja3pUiIpYRyPQpE9FAjdYjHN8/LQU0uB9EpUSB
         qSrZ8Hf52gqKTZ72c+Eoo0Qhv6Swl3JnpNkAI7lUvZkgPk9v3llrCjGaJTrSSvLSnPwY
         K18CvFFe5Ihsd4epYYEJCOhRJ9+MLGE4UWpbVCGESW+xyhk6MSP1URYP7WXPiNIsGLYr
         7A5g==
X-Gm-Message-State: AOAM532JgX3isFWQnaeqEDm98+ULUZcJvZJd/n7H75Ix8mt5QpcFY9/T
        CF9vJTWQvL5YoNQlNVZ/WqIOzxFRQWOQEw==
X-Google-Smtp-Source: ABdhPJwAApOSyCBMCk5Bc+89u//zF8UT+tikQ1I32AYHhLx059Wki2Typo7qSvb8KPze/24uruMe3A==
X-Received: by 2002:a5d:6da5:: with SMTP id u5mr6356396wrs.11.1632833765549;
        Tue, 28 Sep 2021 05:56:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm19302858wrt.12.2021.09.28.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 05:56:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] config.c: remove unused git_config_key_is_valid()
Date:   Tue, 28 Sep 2021 14:56:03 +0200
Message-Id: <patch-1.1-ba40601a511-20210928T125516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1340.ge9f77250f2b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git_config_key_is_valid() function got left behind in a
refactoring in a9bcf6586d1 (alias: use the early config machinery to
expand aliases, 2017-06-14),

It previously had two users when it was added in 9e9de18f1ad (config:
silence warnings for command names with invalid keys, 2015-08-24), and
after 6a1e1bc0a15 (pager: use callbacks instead of configset,
2016-09-12) only one remained.

By removing it we can get rid of the "quiet" branches in this
function, as well as cases where "store_key" is NULL, for which there
are no other users.

Out of the 5 callers of git_config_parse_key() only one needs to pass
a non-NULL "size_t *baselen_", so we could remove the third parameter
from the public interface. I did not find that potential
simplification to be worthwhile.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I noticed this while looking at the "env" includes, we can get some
easy dead code removal with this cleanup.

 config.c | 34 ++++++++--------------------------
 config.h |  1 -
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/config.c b/config.c
index 2edf835262f..2dcbe901b6b 100644
--- a/config.c
+++ b/config.c
@@ -425,7 +425,7 @@ static inline int iskeychar(int c)
  * baselen - pointer to size_t which will hold the length of the
  *           section + subsection part, can be NULL
  */
-static int git_config_parse_key_1(const char *key, char **store_key, size_t *baselen_, int quiet)
+int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 {
 	size_t i, baselen;
 	int dot;
@@ -437,14 +437,12 @@ static int git_config_parse_key_1(const char *key, char **store_key, size_t *bas
 	 */
 
 	if (last_dot == NULL || last_dot == key) {
-		if (!quiet)
-			error(_("key does not contain a section: %s"), key);
+		error(_("key does not contain a section: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	if (!last_dot[1]) {
-		if (!quiet)
-			error(_("key does not contain variable name: %s"), key);
+		error(_("key does not contain variable name: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
@@ -455,8 +453,7 @@ static int git_config_parse_key_1(const char *key, char **store_key, size_t *bas
 	/*
 	 * Validate the key and while at it, lower case it for matching.
 	 */
-	if (store_key)
-		*store_key = xmallocz(strlen(key));
+	*store_key = xmallocz(strlen(key));
 
 	dot = 0;
 	for (i = 0; key[i]; i++) {
@@ -467,39 +464,24 @@ static int git_config_parse_key_1(const char *key, char **store_key, size_t *bas
 		if (!dot || i > baselen) {
 			if (!iskeychar(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
-				if (!quiet)
-					error(_("invalid key: %s"), key);
+				error(_("invalid key: %s"), key);
 				goto out_free_ret_1;
 			}
 			c = tolower(c);
 		} else if (c == '\n') {
-			if (!quiet)
-				error(_("invalid key (newline): %s"), key);
+			error(_("invalid key (newline): %s"), key);
 			goto out_free_ret_1;
 		}
-		if (store_key)
-			(*store_key)[i] = c;
+		(*store_key)[i] = c;
 	}
 
 	return 0;
 
 out_free_ret_1:
-	if (store_key) {
-		FREE_AND_NULL(*store_key);
-	}
+	FREE_AND_NULL(*store_key);
 	return -CONFIG_INVALID_KEY;
 }
 
-int git_config_parse_key(const char *key, char **store_key, size_t *baselen)
-{
-	return git_config_parse_key_1(key, store_key, baselen, 0);
-}
-
-int git_config_key_is_valid(const char *key)
-{
-	return !git_config_parse_key_1(key, NULL, NULL, 1);
-}
-
 static int config_parse_pair(const char *key, const char *value,
 			  config_fn_t fn, void *data)
 {
diff --git a/config.h b/config.h
index 147f5e0490e..8b79441ee0c 100644
--- a/config.h
+++ b/config.h
@@ -259,7 +259,6 @@ int git_config_set_gently(const char *, const char *);
 void git_config_set(const char *, const char *);
 
 int git_config_parse_key(const char *, char **, size_t *);
-int git_config_key_is_valid(const char *key);
 
 /*
  * The following macros specify flag bits that alter the behavior
-- 
2.33.0.1340.ge9f77250f2b

