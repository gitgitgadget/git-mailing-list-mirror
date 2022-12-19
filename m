Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD40BC4167B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 16:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiLSQUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiLSQUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 11:20:30 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D4F133
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 08:20:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i7so9183484wrv.8
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXSB/dfnZXZjH9qaVx2Tou4UhmraPLlafdZJ0IRl9tI=;
        b=N5mytT2Wa5eWrpySaBDz7AdPldKyikQ0m7fLCKb+AEUG9iXDtGCn6bu+xRzGj4+Rgq
         QSjJn/PbIT5n6B3tK55CZSde/fdkAEh9FraaW9efrmUwO6W6VffLTTZKH28R9ng6NCIY
         3Z2prR8JBJHuAMpZCmHzo9vOvXczYo6v747rGiWqZkZr24N1LkJWp65wAdqKDRzP00fh
         taKGEQpJPqMnGQ47WbvriM0YrH7PTiL/EeTAlT0MHlG6LPLECO5lqxxcmgMxb2x0+ZcU
         M4s1tePHeQoFqeLscJpo44f1heofZe4qNASVSbH7W4QRytqtXnqkkqS8uv5gXs48UCb4
         VEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXSB/dfnZXZjH9qaVx2Tou4UhmraPLlafdZJ0IRl9tI=;
        b=q/+51pdh5cceV+NTzwLsTkvDzk3LtOTlppYCJ6AOLuyg51h1fx1bssBTYNWQLmpl/T
         He8WjJLT3R59nTocRYiWS/plH0UXbuCDzia99P9+jx/G345mM2r0eEEdUp5opOOvbx9J
         7FPkRDcwVsvoVmoKR7SFi8UHszdyvwopExcaYk60htoGUSBqOq0hUGllpXhDb0K9pYA7
         +ksl4/gyyTYyzvtKf9DwJ+IruZwHZScAbc/ZPj54EpneCfPcxQmSoFNliytqS2NXKc5g
         hPXscJS0ikVI50rOd/L3yPtAr1F9FwS1MpKEl24KGpAGsx7/JWCv4J6139GSm6NYBA58
         b0CQ==
X-Gm-Message-State: AFqh2kqdfnqxswwPghvZrJVw31WMs7rLLvMdBto+SPlC4/mRAIKas6nB
        qw3htFl/HNHe5tSuOQ/JxZFgbSYgHz4=
X-Google-Smtp-Source: AMrXdXsw+LHp8Cz7Fm/7IFqRhYpT0t4ymX/1IJcqm/A+TCx8oUyr5pwfp7kjUzBSd6XYMDgtZARn7w==
X-Received: by 2002:a05:6000:408b:b0:256:8985:af4c with SMTP id da11-20020a056000408b00b002568985af4cmr8184283wrb.14.1671466827166;
        Mon, 19 Dec 2022 08:20:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay9-20020a5d6f09000000b002425504ae7dsm10452941wrb.80.2022.12.19.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 08:20:26 -0800 (PST)
Message-Id: <pull.1402.v2.git.git.1671466826159.gitgitgadget@gmail.com>
In-Reply-To: <pull.1402.git.git.1671465108414.gitgitgadget@gmail.com>
References: <pull.1402.git.git.1671465108414.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Dec 2022 16:20:26 +0000
Subject: [PATCH v2] win32: explicitly set errno to enoent if err is not
 error_directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

At this point, the only two possible errors are
ERROR_DIRECTORY or ERROR_BAD_PATHNAME.

This code clarifies this and also saves a call to
err_win_to_posix.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: explicitly set errno to enoent if err is not error_directory
    
    At this point, the only two possible errors are ERROR_DIRECTORY or
    ERROR_BAD_PATHNAME.
    
    This code clarifies this and also saves a call to err_win_to_posix.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1402%2FAtariDreams%2Fopendir-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1402/AtariDreams/opendir-v2
Pull-Request: https://github.com/git/git/pull/1402

Range-diff vs v1:

 1:  6e66c0deaf9 ! 1:  bf757aee0be Explicitly set errno to ENOENT if err is not ERROR_DIRECTORY
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    Explicitly set errno to ENOENT if err is not ERROR_DIRECTORY
     +    win32: explicitly set errno to enoent if err is not error_directory
      
          At this point, the only two possible errors are
          ERROR_DIRECTORY or ERROR_BAD_PATHNAME.


 compat/win32/dirent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index 52420ec7d4d..8f94a5ab6db 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -34,13 +34,13 @@ DIR *opendir(const char *name)
 	if (len && !is_dir_sep(pattern[len - 1]))
 		pattern[len++] = '/';
 	pattern[len++] = '*';
-	pattern[len] = 0;
+	pattern[len] = '\0';
 
 	/* open find handle */
 	h = FindFirstFileW(pattern, &fdata);
 	if (h == INVALID_HANDLE_VALUE) {
 		DWORD err = GetLastError();
-		errno = (err == ERROR_DIRECTORY) ? ENOTDIR : err_win_to_posix(err);
+		errno = (err == ERROR_DIRECTORY) ? ENOTDIR : ENOENT;
 		return NULL;
 	}
 

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
