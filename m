Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB50CD4F59
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 10:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjIVKmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 06:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjIVKmR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 06:42:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46EBFB
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3215f19a13aso1912345f8f.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695379329; x=1695984129; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/S9X51ky9R1A0o9cD3mMV3oliZlab7h6BmSv+K4liI=;
        b=Vsli4UawCLivgrsWSdklK8gak7Wf75sOCM6P3TAR/g+njkQPAxZj2bR7YCsD0sKm52
         fyy8kQIvpebwKdSb6Pu51EDpgyCkTZEPI9MUPJJFboK8olYlAsv6ker2suS58chEHtXD
         v/umVMoXVeheg4hdhhm3KY0nRk9Mw0vtjtxou1vTQOukGXamBWqha+kGv0cixCl1RgvM
         +koWBGLg5ETQ30NR+vaokc9+wABYkOolwesDdFl99ajn1KHmvjhg5Ra4jAYCgvfeOdrE
         3k7tKxeNsvcl41l0UNXcANcACzYQAUix7GW3JFZaPElAiQN8paFznj7r583i1n+Tc8gI
         VGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379329; x=1695984129;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/S9X51ky9R1A0o9cD3mMV3oliZlab7h6BmSv+K4liI=;
        b=sUqFQK5XW3dNuDLSmYcUxlvNf2HvVF5SPpteHDCLbxkiRhEim1uUIroXx9DUK4T+db
         dotPVIrAH+be6dQu/G9KNFQZXShea6677XjgbSFYfkjtWHFt+M3mrx8+g6ahl1xEsjNl
         qAUpSWhITeMvoHQP8EKEYjLRGyVhTW04nS6SIAtZeW41AI3X7PeHPdMIMpCQtZj55+45
         MF+H3Uwo/J6roMjDQwHduqHNt9Yi/dSyZtEhwFVToVzJGq2T3SZ+UnFRKJNX1UoygtO5
         w2wV7lT7qvaTa72zuAN8gGQTEOmLNFJQ18uZvLjeeqIs4pAkIvWf3pFGAaYQ9lv0wEy5
         zE0A==
X-Gm-Message-State: AOJu0Yyb7Bf9BiDYFs4o6NZyFCDrAeiDZTDD6ft724wpeq9OCZ1qUzsq
        mxc8aTrsCEeo61fWgUQTGQ6zOkqoaKw=
X-Google-Smtp-Source: AGHT+IGmcJDSbDmc75XZYc2jQZbt/EMhxSj7duyjgg7huvsl9moqKDj+X17cwxUXpUDjoDa0WPSr/A==
X-Received: by 2002:adf:f642:0:b0:321:4d1c:425f with SMTP id x2-20020adff642000000b003214d1c425fmr7165699wrp.47.1695379328970;
        Fri, 22 Sep 2023 03:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d4a8b000000b0031ffb51f6f9sm4139419wrq.30.2023.09.22.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:42:08 -0700 (PDT)
Message-ID: <458bc2ea91faf88a3e1d21945f12f314d1a7b78e.1695379323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 10:42:03 +0000
Subject: [PATCH 6/6] coverity: detect and report when the token or project is
 incorrect
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When trying to obtain the MD5 of the Coverity Scan Tool (in order to
decide whether a cached version can be used or a new version has to be
downloaded), it is possible to get a 401 (Authorization required) due to
either an incorrect token, or even more likely due to an incorrect
Coverity project name.

Let's detect that scenario and provide a helpful error message instead
of trying to go forward with an empty string instead of the correct MD5.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index ca51048ed9d..12cdbaf7ffd 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -76,7 +76,20 @@ jobs:
           echo "COVERITY_TOOL_FILENAME=$COVERITY_TOOL_FILENAME" >>$GITHUB_ENV
           echo "MAKEFLAGS=$MAKEFLAGS" >>$GITHUB_ENV
           MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
+                   -D "$RUNNER_TEMP"/headers.txt \
                    --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT&md5=1")
+          http_code="$(sed -n 1p <"$RUNNER_TEMP"/headers.txt)"
+          case "$http_code" in
+          *200*) ;; # okay
+          *401*) # access denied
+            echo "::error::incorrect token or project? ($http_code)" >&2
+            exit 1
+            ;;
+          *) # other error
+            echo "::error::HTTP error $http_code" >&2
+            exit 1
+            ;;
+          esac
           echo "hash=$MD5" >>$GITHUB_OUTPUT
 
       # Try to cache the tool to avoid downloading 1GB+ on every run.
-- 
gitgitgadget
