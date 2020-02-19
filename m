Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FEDC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696BA24656
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5gMzT43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgBSREQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:04:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39704 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSREM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:04:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so1405798wrt.6
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 09:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KwkqKCjyh5AaybDYrDl6R8Jd5+6IQPCQKXoBUqO9dcE=;
        b=h5gMzT43rBwwSEQjCvvwGND90e3i6b2q5oostq5htca4Rd+Ru8VllW84gHclumhYoH
         VnEXYnsYF1se+gtPbl7apokUewC23BJZMso9wtK3bSWsvqpqFYErxjU1OmbjrQdWdwAf
         O3JTngEgyTLdQzGaVdLHFEf5qirJInKk6uK/cueJ+cgPuLbCIQssO55tqrlylo0na8a9
         GHdmWYqL93l3ZbzJBTNI2jKmk35MYfaJMoBk7byHVtfHdQ/F8SluS3AGroOJrHeMZFr7
         N3qL0ANwbN5xwbmT7w3Qwmk7L/J8t3WCfepjWXkmmAb9PGhBIRFNbi9ADH+H7Eak3h5r
         kzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KwkqKCjyh5AaybDYrDl6R8Jd5+6IQPCQKXoBUqO9dcE=;
        b=jQmKegslr47KP6UhvaqsOCPQ62pq6G2mKz7gKxml8OEiIZFb0ltbySUP29sx8dEEj7
         Ipd/y3Jz0jPHMphf0hi5ol+tpWEcQM2/Zt/SYSb0hG0rs0vMvnlq7HzUkOYAcVM7akek
         qOrMz6BIN1ZPt532JlV/uvNf61p8lDQp0A+YAe1EE2ZEOBPT5J7s3jizAWQfGQRHZIt2
         gAp/q/5ZWFRYXQxz2xErUnbDQW3RFFlyBTGT1QEbkGuBrku03ai2vpuDANScpgs0czaY
         AJZpC0ejJgr/YQmbuex94Phj/IyVQUZCCqpVx2hPKUTn30JH5fboV8p5WY1f5/KgMojj
         y3jQ==
X-Gm-Message-State: APjAAAXnWZMyrNFSNf3aVGqELtvL+DEKn5K2nKRzPaToQSJabQRcQJU7
        zP+Km1AyMennNgU5r3M/yOhb8x5d
X-Google-Smtp-Source: APXvYqxzdJyR5JBaNtC8jBXLHQ+EE4fbcivFIflxKbd8jTlsWrVJt68b0b/AzyM8mSUuEuoSmQWoDg==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr36873274wrv.197.1582131850670;
        Wed, 19 Feb 2020 09:04:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm430044wro.77.2020.02.19.09.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:04:10 -0800 (PST)
Message-Id: <ba297fd67bb98bd06408241030cf42f410d5d366.1582131847.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.712.v4.git.git.1582131847.gitgitgadget@gmail.com>
References: <pull.712.v3.git.git.1582064105813.gitgitgadget@gmail.com>
        <pull.712.v4.git.git.1582131847.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 17:04:07 +0000
Subject: [PATCH v4 2/2] merge-recursive: fix the refresh logic in
 update_file_flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If we need to delete a higher stage entry in the index to place the file
at stage 0, then we'll lose that file's stat information.  In such
situations we may still be able to detect that the file on disk is the
version we want (as noted by our comment in the code:
  /* do not overwrite file if already present */
), but we do still need to update the mtime since we are creating a new
cache_entry for that file.  Update the logic used to determine whether
we refresh a file's mtime.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    | 7 +++++--
 t/t3433-rebase-across-mode-change.sh | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index aee1769a7ac..e6f943c5ccc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -998,10 +998,13 @@ static int update_file_flags(struct merge_options *opt,
 		free(buf);
 	}
 update_index:
-	if (!ret && update_cache)
-		if (add_cacheinfo(opt, contents, path, 0, update_wd,
+	if (!ret && update_cache) {
+		int refresh = (!opt->priv->call_depth &&
+			       contents->mode != S_IFGITLINK);
+		if (add_cacheinfo(opt, contents, path, 0, refresh,
 				  ADD_CACHE_OK_TO_ADD))
 			return -1;
+	}
 	return ret;
 }
 
diff --git a/t/t3433-rebase-across-mode-change.sh b/t/t3433-rebase-across-mode-change.sh
index f11fc35c3ee..05df964670f 100755
--- a/t/t3433-rebase-across-mode-change.sh
+++ b/t/t3433-rebase-across-mode-change.sh
@@ -33,7 +33,7 @@ test_expect_success 'rebase changes with the apply backend' '
 	git rebase side1
 '
 
-test_expect_failure 'rebase changes with the merge backend' '
+test_expect_success 'rebase changes with the merge backend' '
 	test_when_finished "git rebase --abort || true" &&
 	git checkout -b merge-backend side2 &&
 	git rebase -m side1
-- 
gitgitgadget
