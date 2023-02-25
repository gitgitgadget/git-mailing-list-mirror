Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A26C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBYC0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBYC0I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651B426CD4
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:06 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso650810wmp.4
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLzl5Nnmpb6ZWi0HOdk5F4kYn6w/3YalLglkZXtyiUs=;
        b=VozTAqzUDdSxn//bPsQyHE5nPxvMuImdlBKJn25gqh4VYt/iogqcLrXvJVoZKrf411
         y9f94s+sVzAn64lQ7cjNGczezoQoX7sy6Yz1Wro1QkD66pch8qr6muMS5jggdWqQETo5
         etHIZUFZV9O7O91UDau7S70rz5fhMmli8B46a1TXY9yfaOvLAf6wHnghUvBfc8qhYlqP
         i3n5cCCULIAp3FmJyTfX3QL5A2U+VJBHYv1ZetDkrPMDghb/HkyBfIBZj6C3c0X7bnrC
         IYWzmluohlBe9jpInuEqF/zk3TpfBGyW3G0aSl26+C4LVdH03ANc+/yWczf2p/A4FVv+
         WdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLzl5Nnmpb6ZWi0HOdk5F4kYn6w/3YalLglkZXtyiUs=;
        b=e7LRFvX76vhrPDrRawA5kirweTh57vATEsFmItH7vCLe9dlUoOYkSICfkTzQ1AL+ef
         uKsRm/uz0aiAl2Tia2uTxyD5YAVGGUOdxxaOL4/RJGPIu58ZQgqgJG80wNgzypxaZlBn
         aSsSe3GvDj+wRs13UnWOuyyFmR/9ymc6huOlyXalId8B+G9yPqFEY2F5u1ER9sNVSDje
         zN6CBIRPea2wErmLxSwRIu1QYdTTrOgNJgm2F2CPbK6aGcLrNtlkCyUqqHPPghCEKkoL
         UkJuCY+xbXYYFKdV4cFf95d8gV1MFNwhqEwBWQ1nihqBCVufVXicvIflqXqgI9Mw3FOi
         +WYQ==
X-Gm-Message-State: AO0yUKUWv3PU5VwOkA4GazGPlgVtno463b0RPqiBZ5TnUGHcGjx8SCfo
        0jsv4g4UiYH2+D27sz4GV8AL9ejGsb8=
X-Google-Smtp-Source: AK7set9tpktDQPiriQjXfNCHOTeLqn9rrqCGcqDJ33aqoe+EEvjnzBiSwZUM9/QBxc7YB/yX4w0nsw==
X-Received: by 2002:a05:600c:1d09:b0:3ea:d611:f8 with SMTP id l9-20020a05600c1d0900b003ead61100f8mr5095006wms.38.1677291964603;
        Fri, 24 Feb 2023 18:26:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z19-20020a05600c0a1300b003e4326a6d53sm4603521wmp.35.2023.02.24.18.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:04 -0800 (PST)
Message-Id: <239b10e11812d99be587265c0a5e283da45ca315.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:51 +0000
Subject: [PATCH v2 02/11] dir: add a usage note to exclude_per_dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/dir.h b/dir.h
index 33fd848fc8d..2196e12630c 100644
--- a/dir.h
+++ b/dir.h
@@ -295,8 +295,12 @@ struct dir_struct {
 	struct untracked_cache *untracked;
 
 	/**
-	 * The name of the file to be read in each directory for excluded files
-	 * (typically `.gitignore`).
+	 * Deprecated: ls-files is the only allowed caller; all other callers
+	 * should leave this as NULL; it pre-dated the
+	 * setup_standard_excludes() mechanism that replaces this.
+	 *
+	 * This field tracks the name of the file to be read in each directory
+	 * for excluded files (typically `.gitignore`).
 	 */
 	const char *exclude_per_dir;
 
-- 
gitgitgadget

