Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB6C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 15:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiDMPfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbiDMPfA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 11:35:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40E037A9C
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:32:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e21so3170538wrc.8
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BLQDAXhmfUzAR0ogh5Jsr/0CeMLVX5Pa2WvZyIdyeFk=;
        b=MPOurEe9xcsnxSP+Uam33/L+OlaWebtfiFNU9wvmRpaMdyDyzvOADHCvMm76ODA++k
         rZ2UQOqtzzoPROQMnVDk0ZBaJkDRXHmTEzgQ99TLRHCfg31jxNuEieHLm983axj19WOV
         9Wqcv/9Y2s9kD+3e3Q/77z4+qnIkDMpcJinxjtw5WaR0mhHobx+gDqEFOqPtICgPx+aW
         wPWlIv1hPfqGbd1Imy1JJY2GL3TdH47E0OD7gGU9lI6EwmVZSror66AYc8ZEbuo52oyo
         2op6pv+58WDQEVM8TdUKza4DU/mm3Tw6iZRE88OOvwv5/SuZjqyRjZPJLWMWEEP6KQhk
         6t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BLQDAXhmfUzAR0ogh5Jsr/0CeMLVX5Pa2WvZyIdyeFk=;
        b=4xKUhFQGuhAGWIVvMSICWm1gBEOVCxbEYy761x6imuIeMTQK/xGGedkiVwNGWcZTvT
         8PmUAIQvkfRpFPf0TJA1KPJ4fozjqIeIYN18OqL4xhYayFdJpk5Y++hOW6zqvDmwFzdF
         hEPsRi/agT2UAslBME6nnZ8qrx/4NfLA8I6jhkzSOlhJlCdmnR9SPsnRi9BKgDBW4Htv
         tkJOgTp8v8Ly2XPU6StStxgzkghwF5bHUPC/DJRsOg+xxqBaj9yi+PhwtvHc0dT0dDLL
         6V+iyiO81h4lyiDvCJnVit4qBC8C+WrNWxKNAv6osqeGCNvf5GOF+tjx3wh3GD11fkZw
         5hng==
X-Gm-Message-State: AOAM533ji1E9tR6tWSQp4S7bgY0uIVUUlfGy8N51ihLbkSXWlr+6S/Jo
        KrkdC4LmMi6mwoH2hseA+7OobjX2Y6s=
X-Google-Smtp-Source: ABdhPJwOOIs5q4FVX+y/fQ84KYPAULnWOuU1kO6HRhSSL+iDn0z4MfDd/2zAoZyJgQxNQLzDMdN5nA==
X-Received: by 2002:a5d:591c:0:b0:207:a060:426c with SMTP id v28-20020a5d591c000000b00207a060426cmr16850813wrd.305.1649863956918;
        Wed, 13 Apr 2022 08:32:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1-20020adfd1c1000000b002058537af75sm33780482wrd.104.2022.04.13.08.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:32:36 -0700 (PDT)
Message-Id: <a5faf3a1779b51195313794fa0a48b7e2009c01b.1649863951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Apr 2022 15:32:31 +0000
Subject: [PATCH 3/3] setup: opt-out of check with safe.directory=*
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

With the addition of the safe.directory in 8959555ce
(setup_git_directory(): add an owner check for the top-level directory,
2022-03-02) released in v2.35.2, we are receiving feedback from a
variety of users about the feature.

Some users have a very large list of shared repositories and find it
cumbersome to add this config for every one of them.

In a more difficult case, certain workflows involve running Git commands
within containers. The container boundary prevents any global or system
config from communicating `safe.directory` values from the host into the
container. Further, the container almost always runs as a different user
than the owner of the directory in the host.

To simplify the reactions necessary for these users, extend the
definition of the safe.directory config value to include a possible '*'
value. This value implies that all directories are safe, providing a
single setting to opt-out of this protection.

Note that an empty assignment of safe.directory clears all previous
values, and this is already the case with the "if (!value || !*value)"
condition.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/safe.txt |  7 +++++++
 setup.c                       |  6 ++++--
 t/t0033-safe-directory.sh     | 10 ++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 63597b2df8f..6d764fe0ccf 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -19,3 +19,10 @@ line option `-c safe.directory=<path>`.
 The value of this setting is interpolated, i.e. `~/<path>` expands to a
 path relative to the home directory and `%(prefix)/<path>` expands to a
 path relative to Git's (runtime) prefix.
++
+To completely opt-out of this security check, set `safe.directory` to the
+string `*`. This will allow all repositories to be treated as if their
+directory was listed in the `safe.directory` list. If `safe.directory=*`
+is set in system config and you want to re-enable this protection, then
+initialize your list with an empty value before listing the repositories
+that you deem safe.
diff --git a/setup.c b/setup.c
index a995c359c32..a42b21307f7 100644
--- a/setup.c
+++ b/setup.c
@@ -1103,9 +1103,11 @@ static int safe_directory_cb(const char *key, const char *value, void *d)
 	if (strcmp(key, "safe.directory"))
 		return 0;
 
-	if (!value || !*value)
+	if (!value || !*value) {
 		data->is_safe = 0;
-	else {
+	} else if (!strcmp(value, "*")) {
+		data->is_safe = 1;
+	} else {
 		const char *interpolated = NULL;
 
 		if (!git_config_pathname(&interpolated, key, value) &&
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 6f33c0dfefa..239d93f4d21 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -36,4 +36,14 @@ test_expect_success 'safe.directory matches, but is reset' '
 	expect_rejected_dir
 '
 
+test_expect_success 'safe.directory=*' '
+	git config --global --add safe.directory "*" &&
+	git status
+'
+
+test_expect_success 'safe.directory=*, but is reset' '
+	git config --global --add safe.directory "" &&
+	expect_rejected_dir
+'
+
 test_done
-- 
gitgitgadget
