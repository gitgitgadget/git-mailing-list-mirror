Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058FDC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347862AbiEJRTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347855AbiEJRTe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:19:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBF72BF31B
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:15:36 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dv4so13051047qvb.13
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Np0aRJLrrLK5daoTKKZ6bcJDck3XgFkkNDp0ss/9BJk=;
        b=OgJT407Wn20tjNKd9AAbmQOYPFSFAbR5qeOSD4o3WF5kNxrJCthXPRV3uuJ0enwdtT
         mNLFuecBGpx4Gxy+bILkbr3NXFuxloLB1AGCO2SFOoZZ2yauH9BwJJt2KzQj1vM68PI2
         FvE0Ex/unc+J9xMaYbBO5D2O0Zq/mQhDS2++NcplTR3pgoeC8rC0Ltx+I+lnkfcQNm23
         yOQ5367cazrCvs/vT85uEy8Xf4wusDSmZjQrAd77KgFyPsFgJsIRMY9CJgaAa1EdOlXb
         bROuznMt1i9Nz5b528sOjkXzJZzP7CeWiTOqM+fz/0uMpM8pJQ+Lfw7rmZZ36FIwxTCM
         Qe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Np0aRJLrrLK5daoTKKZ6bcJDck3XgFkkNDp0ss/9BJk=;
        b=CHiD9Oj3A8Hvy/rCAy0hfueTdUg5W73G04z1+0QB6Kcs1umuMzTTdvphr1irbcN2tD
         qOxd6eO/dyUBd01dNyadx1phpm02wJoJB88Yhc0rZ28/UORixuqTUvyRPVCpqXbpCKTW
         VUyNO7Anamy+glWIjJMGKjmsQpSRIT5u1eBhKHsMVUphL/S1itiqljOqdWEWelzDUWYq
         p/gwk/eauJ/m3L/0pY9DIqUC28X350RCZBtj+SdRMrc1b4gy1pO3VCZJ0N/C51QKbvEd
         12s6ZhNEzONgm5KHecne0RlrCmQ/xD3SbOsSPV+sPZmc8qhT5oDaHQBk3tgKBHX+E6g8
         B2Bg==
X-Gm-Message-State: AOAM530kiuxkaW15j4u2l1hS5+dx3U2Jxx2TcLXs+8veHsAPdwFhNuQB
        R9SG6HuqsleJ/ITX7uujHoG+jvUksd+FfQ==
X-Google-Smtp-Source: ABdhPJw0g5aUtGfVoe+XhWAHFv6/cxiDpgahDJXJ94OsIZBMNmvH9u2MltHoKS3tYZ2lMpdfsb/XnQ==
X-Received: by 2002:a05:6214:2aaa:b0:45a:b0e2:fe37 with SMTP id js10-20020a0562142aaa00b0045ab0e2fe37mr19034785qvb.24.1652202935827;
        Tue, 10 May 2022 10:15:35 -0700 (PDT)
Received: from localhost.localdomain (pool-100-33-115-203.nycmny.fios.verizon.net. [100.33.115.203])
        by smtp.gmail.com with ESMTPSA id x74-20020a37634d000000b0069ff51425a2sm8963787qkb.120.2022.05.10.10.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:15:35 -0700 (PDT)
From:   Goss Geppert <gg.oss.dev@gmail.com>
X-Google-Original-From: Goss Geppert <ggossdev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 2/2] dir: minor refactoring / clean-up
Date:   Tue, 10 May 2022 17:15:27 +0000
Message-Id: <20220510171527.25778-3-ggossdev@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510171527.25778-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
 <20220510171527.25778-1-ggossdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve readability.

Signed-off-by: Goss Geppert <ggossdev@gmail.com>
---
 dir.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index a1886e61a3..329db72999 100644
--- a/dir.c
+++ b/dir.c
@@ -1861,7 +1861,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 */
 	enum path_treatment state;
 	int matches_how = 0;
-	int nested_repo = 0, check_only, stop_early;
+	int check_only, stop_early;
 	int old_ignored_nr, old_untracked_nr;
 	/* The "len-1" is to strip the final '/' */
 	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
@@ -1901,6 +1901,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		 *    configured by the user; see t2205 testcases 1a-1d for examples
 		 *    where this matters
 		 */
+		int nested_repo;
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addstr(&sb, dirname);
 		nested_repo = is_nonbare_repository_dir(&sb);
@@ -1919,12 +1920,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 			free(real_dirname);
 		}
 		strbuf_release(&sb);
-	}
-	if (nested_repo) {
-		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
-		    (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
-			return path_none;
-		return excluded ? path_excluded : path_untracked;
+
+		if (nested_repo) {
+			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+				(matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
+				return path_none;
+			return excluded ? path_excluded : path_untracked;
+		}
 	}
 
 	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
-- 
2.36.0

