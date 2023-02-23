Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42F7C64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjBWJPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjBWJPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9EF42BEA
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:05 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bt28so3405897wrb.8
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJhOI5pH2/X7Uqaz8J/86RgsSNzaLLs6qLmjlPTEmeM=;
        b=X7Ir4n20kTHvkI5fNizfmnd4FXlleAmoisqFkD/Ho6924KfTkZjQKIUJzXHqWi6B2/
         XfUtuqZj12AVR2n4x/HUruYGXDA/bQHDTYP1YmXaAdRVJAWvx+feFS73wCoICeyrQj6R
         nPc2CbApRkoNwgj8MrcdEip5C8jicelYwa8bkOAZ9aA+WxJcz5pe2g86oSgw0+gbTMfc
         QcO2fn2ACcCBgorhvEhM0f4a+JsjA73b7OO8fHHPY5G8FKtxqUfhG/FBuekTsyblQqXP
         L1uq1fCULVRMCp0RPdyDJ+T+J+3Uv7sLzEoI2DcKCPXVnAkkIjSJA+itWQaj8zrXfpAe
         mwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJhOI5pH2/X7Uqaz8J/86RgsSNzaLLs6qLmjlPTEmeM=;
        b=e/eZ89eEEGmwYvyV/hi4TzMesftxflyVdc5xUZbKjew3BFxX+5mOhmAMphjnxZjPwX
         bC/HOqeJ0KduyaK5/uwll3R1HKKwVLMQzEHsojw4wvdE0qeobc3mrkRg/OUnQExo0WUG
         Glxt45een1BmbvvqpUrU7Naryd5tIoJUV/8QIH3qXh7lGhXOGFgl1dtBwDUau3tkEt+D
         hR08r43c/YkQgCsl8d6AhHbDw6QyKCIgwU3t6fwWXNHIizlWpw/iU+Sfrcr0jb17xU2Z
         gq1tzMpO/CciWV6B5Jm5VQBMQFhtZgwp/P8+8MX+OB/WrTq+qaQxbqpJ9s+g+KVv0HmM
         837Q==
X-Gm-Message-State: AO0yUKXoJOq4yHngYWEQUo2VPM/5TS3sI09Up/g90KR9wnFBiAwrrz1I
        PIC/ZsGwbxvC1jjCE4TnlrcMWGPcG4A=
X-Google-Smtp-Source: AK7set/mVBeEoQh+CJ0NsxbG2/H0aIZDiYBodG6J+V/rAPTQMiGTq4Z8zGut5B2CCPZIyFjAZ3q5uw==
X-Received: by 2002:a5d:6808:0:b0:2c5:53e1:7417 with SMTP id w8-20020a5d6808000000b002c553e17417mr10116338wru.23.1677143703476;
        Thu, 23 Feb 2023 01:15:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c024300b003daf7721bb3sm10550816wmj.12.2023.02.23.01.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:03 -0800 (PST)
Message-Id: <b8aa14350d3411f63d6f02c2e2a857fd342cd8ff.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:52 +0000
Subject: [PATCH 03/11] dir: mark output only fields of dir_struct as such
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

While at it, also group these fields together for convenience.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/dir.h b/dir.h
index 2196e12630c..e8106e1ecac 100644
--- a/dir.h
+++ b/dir.h
@@ -212,12 +212,6 @@ struct untracked_cache {
  */
 struct dir_struct {
 
-	/* The number of members in `entries[]` array. */
-	int nr;
-
-	/* The number of members in `ignored[]` array. */
-	int ignored_nr;
-
 	/* bit-field of options */
 	enum {
 
@@ -282,14 +276,20 @@ struct dir_struct {
 		DIR_SKIP_NESTED_GIT = 1<<9
 	} flags;
 
+	/* The number of members in `entries[]` array. */
+	int nr; /* output only */
+
+	/* The number of members in `ignored[]` array. */
+	int ignored_nr; /* output only */
+
 	/* An array of `struct dir_entry`, each element of which describes a path. */
-	struct dir_entry **entries;
+	struct dir_entry **entries; /* output only */
 
 	/**
 	 * used for ignored paths with the `DIR_SHOW_IGNORED_TOO` and
 	 * `DIR_COLLECT_IGNORED` flags.
 	 */
-	struct dir_entry **ignored;
+	struct dir_entry **ignored; /* output only */
 
 	/* Enable/update untracked file cache if set */
 	struct untracked_cache *untracked;
-- 
gitgitgadget

