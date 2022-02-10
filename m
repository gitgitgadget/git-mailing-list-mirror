Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4163C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 02:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiBJCmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:42:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiBJCl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 21:41:58 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D68237ED
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 18:42:01 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k17so662743plk.0
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 18:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo1U5Fbok5LxsoYMOXLb80H7ZUPXXxlnw4d7SRVYY8c=;
        b=PsHpCZEweaGPLThlyZ3/gDQRTpQR6JWU4cuQssHzuh0B8MeSbkqgqaWz6cvQUw2BL3
         729oDQxHnV2dMq7WH0RrZf3q4A0729aUfTg2KWcLD5a9e5ombSuRNm0vRwYDZNDmF5W/
         ri43U7k88tJfKAWAW4Y7ufL4LZlf0rpuz6rHqisIWgbb8Rl+LDw9bDk07Ul9a6imn/F6
         NPCzAdWgVpr6PC8lGmIVJIAz48rmKRMKRn8MIJEsoygdmkXvSQTWmnNNKUJThtouU8H6
         vJ6K6EP9mcAa1gftQOmTZZY/J6mP/f0u/HW5QX3n2v/BG+zySzQpOjAO3RW3lSZW083o
         zhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo1U5Fbok5LxsoYMOXLb80H7ZUPXXxlnw4d7SRVYY8c=;
        b=J2vinh/Fx2+rhUzXPwuQruIOqYd9NgWxJzGbzDBIJjJ6ZnGdQ/r7t8F+IAeoY2lmqz
         JFx+CAvXj9A12faiAfxrwVE/SIVPekgWZrDhg2nmqHVXb5w8/MCv3oefNF3gsi9mdDxQ
         KJ8dl/mTEmxPAG8Yvx81/UqzN4rFj3cpLwKpFTwIRK1kpxlYsabVA4h/ccxBwjtt4ZsQ
         Mjt/pHo5cz4P+3cvVjNUK1lV+kbjkOOczuCIQDjGUFGZ2mZWEzS0EYY/7gE7d7HunJU8
         Go3iRhzZwpGPR+DLIIMcje/9zPwUvFzRUAv92InWdx9+hc/IH6/S69cSWmQfS+RSB3SV
         JMyA==
X-Gm-Message-State: AOAM531eKeXPdePGW8ay9dkh5BXsIFEZLswfLenJHtydDbJYdhPyNiEF
        Ppo6O6MUUikl3imBi15e1mTkyuTjptQ=
X-Google-Smtp-Source: ABdhPJx0BZ+JLFkgdpG3wnXl2N3W9tkb2/4RFFEkTrP4P/zcDbx3JkcmilRsv7Od/Qo6VMOTPDc8DA==
X-Received: by 2002:a17:90b:3c1:: with SMTP id go1mr483868pjb.48.1644460920668;
        Wed, 09 Feb 2022 18:42:00 -0800 (PST)
Received: from ubuntu.mate (subs02-180-214-232-73.three.co.id. [180.214.232.73])
        by smtp.gmail.com with ESMTPSA id b20sm2201903pfv.31.2022.02.09.18.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:42:00 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     zoltan.klinger@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Patrick Marlier <patrick.marlier@gmail.com>
Subject: [PATCH] clean: Use past tense for msg_remove, msg_skip_git_dir, and msg_skip_cwd
Date:   Thu, 10 Feb 2022 09:41:38 +0700
Message-Id: <20220210024138.157327-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use past tense form of "to remove" and "to skip". This is especially
true when we had already removed an entry.

Link:
https://lore.kernel.org/git/CAKQMxzSQRL-Q5daxETF+gYhVScmq_n=r2LJAeEuxpM7=jPajZQ@mail.gmail.com/T/#u
Reported-by: Patrick Marlier <patrick.marlier@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 builtin/clean.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 3ff02bbbff..f1cd114ee2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -30,13 +30,13 @@ static const char *const builtin_clean_usage[] = {
 	NULL
 };
 
-static const char *msg_remove = N_("Removing %s\n");
+static const char *msg_remove = N_("Removed %s\n");
 static const char *msg_would_remove = N_("Would remove %s\n");
-static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
+static const char *msg_skip_git_dir = N_("Skipped repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
-static const char *msg_skip_cwd = N_("Refusing to remove current working directory\n");
+static const char *msg_skip_cwd = N_("Refused to remove current working directory\n");
 static const char *msg_would_skip_cwd = N_("Would refuse to remove current working directory\n");
 
 enum color_clean {

base-commit: 2b9c1209706bc2ef0ab09fb0bdc7d405e225ce8b
-- 
An old man doll... just what I always wanted! - Clara

