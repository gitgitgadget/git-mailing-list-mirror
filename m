Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D56BC54FCF
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 17:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1649B206F8
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 17:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/K0mte+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCVRgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:36:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34567 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgCVRgU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 13:36:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id s13so11981740ljm.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7up52TQ9QgbAv5+8qpeigJZxDFGAXYPpATERt0s7aHc=;
        b=M/K0mte+ehJjv4Qv+Y7Xh/i2Ga9S0MqB55lXxX48T66yBXB8/iY9OIlC9dT/yXnps7
         wfkBbBDjcr1Kd53nXNN0NkD/TQt8tJvhkBeOxJ6wKoeE6hLaHFBhE7L/SjjQ9vTZOnVj
         UB0KAECMktxCeFPMKPcMNE5v/sJ7elm3OjpeUAzj0Tw08OZ9ygBXWcQhgT9tvPLZLDx0
         mCXqcRAJUeqhqmgogNuMKF4TmhCKtIJJsrkND4GfmIqo2jQTJkQplFaK7KsXhsIxyIkd
         Y1Y51G1OKPErRBgHJozS97hXv14ysa0WCxobfGVSabetNOoMsD1QEsWeLyej6JQGnoqb
         HWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7up52TQ9QgbAv5+8qpeigJZxDFGAXYPpATERt0s7aHc=;
        b=KCxaxjMoIvMHV7EdJZ2yp0PiS514Nt1Ozy6SxZBxJK8jPLLjiyUdpM7AMbH6ZHs6UH
         oHWh+hDjKyD07xGGM/8TKZcGd2++yvORrzGSI0MCq0OlbezuoCCZH0I5a25ddj9l1gqP
         hcnZLT5b45kHOmM/IR867VWW4Ra3u/hX1Ib856IBOYJmmfpdKL+FUPt//n7XYg2pi1Ne
         gQ4d+yg05A77onNRRTzWaB0xI/wVhIwZWOymo7n0dCk8L8sHPaiCL4wXeC150URdYOsN
         +TGsFuqPBYIBzauBwOdaG4as5x6NL/PQK3XUF9yMU4MZdZrutpCEbosdchWDRq7ESON5
         wXSw==
X-Gm-Message-State: ANhLgQ038TgMEfW5mnPOlgAJHX8JJGizTZsxyUvAEXr23/qKnS5wyQVX
        pYdcS/KJ1HHrR40tF10C/kb4lHLO
X-Google-Smtp-Source: ADFU+vsMC3Ea4pXUOPN6VWnlQQYoMEHI0BYxPLf/1E7tkA7Oh972Bre6hDIhnf1lw8HIh5X1TxZ/EQ==
X-Received: by 2002:a2e:a554:: with SMTP id e20mr10966536ljn.88.1584898576914;
        Sun, 22 Mar 2020 10:36:16 -0700 (PDT)
Received: from mehroz-HP-EliteBook-8470p.Home ([119.155.9.66])
        by smtp.gmail.com with ESMTPSA id q14sm5250877lji.79.2020.03.22.10.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 10:36:16 -0700 (PDT)
From:   sheikh hamza <sheikhhamza012@gmail.com>
To:     git@vger.kernel.org
Cc:     sheikh hamza <sheikhhamza012@gmail.com>
Subject: [GSoC] cache.h: change READ_GITFILE_ERR constants group to enum
Date:   Sun, 22 Mar 2020 22:34:53 +0500
Message-Id: <1584898493-27180-1-git-send-email-sheikhhamza012@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <sheikhhamza012@gmail.com>
References: <sheikhhamza012@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this patch is my microproject for the GSoC i converted
the group of constants in cache.h on line 573 to an enum
named read_gitfile_err to follow newer coding convension
i intend to contribute as much to git as i can and this is
my initial contribution i hope to get guidance for future
contribution. i would be working on the GSoC proposal any
help would be appreciated, Thank you

Signed-off-by: Muhammad Hamza <sheikhhamza012@gmail.com>
---
 cache.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 37c899b..6aae035 100644
--- a/cache.h
+++ b/cache.h
@@ -570,14 +570,17 @@ static inline enum object_type object_type(unsigned int mode)
  */
 int is_nonbare_repository_dir(struct strbuf *path);
 
-#define READ_GITFILE_ERR_STAT_FAILED 1
-#define READ_GITFILE_ERR_NOT_A_FILE 2
-#define READ_GITFILE_ERR_OPEN_FAILED 3
-#define READ_GITFILE_ERR_READ_FAILED 4
-#define READ_GITFILE_ERR_INVALID_FORMAT 5
-#define READ_GITFILE_ERR_NO_PATH 6
-#define READ_GITFILE_ERR_NOT_A_REPO 7
-#define READ_GITFILE_ERR_TOO_LARGE 8
+enum read_gitfile_err {
+	READ_GITFILE_ERR_STAT_FAILED = 1,
+	READ_GITFILE_ERR_NOT_A_FILE = 2,
+	READ_GITFILE_ERR_OPEN_FAILED = 3,
+	READ_GITFILE_ERR_READ_FAILED = 4,
+	READ_GITFILE_ERR_INVALID_FORMAT = 5,
+	READ_GITFILE_ERR_NO_PATH = 6,
+	READ_GITFILE_ERR_NOT_A_REPO = 7,
+	READ_GITFILE_ERR_TOO_LARGE = 8,
+};
+
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
-- 
1.9.1

