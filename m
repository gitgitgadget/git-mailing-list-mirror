Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A0C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 04:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjAMEmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 23:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjAMEmA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 23:42:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC8D3D1CE
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:41:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so258283wmc.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Msu3IqdA0dkf/afSZu4Yy9Z+5SBpqZZgpX+yFxbYlk4=;
        b=qgxZ2Dm7cHnj0FrZcLIYT7BcEpbDFxuFtD4MSU0LxOqowquQwiDyuTa3pMEPa/dX54
         MzUclgv9szYXHeLqYY+ryZU19hiWXQDCOOrjkpKmuTQiAb2S5hOPQH72ELiGqEgPD72r
         X4XXQ21pEh+1IqM4T6T/qMbK9jqpDBAxpIpmdu7nCZ51cXAe4qPF5w0WYK21QI/T1oP5
         0madr3PAsPdsnrLOOiXPaEu9rSKedyNT2uABcdCEsiBkAdBN7kRTf/uxknIyp4TtSyyA
         lPxl7rtsgws4bj8TiEA4OPCthNmXlWNorZIv3GdWOvLyuLYLZZfav8Z1NuAeb3swM5Uh
         C0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Msu3IqdA0dkf/afSZu4Yy9Z+5SBpqZZgpX+yFxbYlk4=;
        b=3gbGqFuCP8BU91qpYUTnlQz22ghLmOOsuOEVwKg7wjhBUdSnnAQIdZAf5dspeao7Wo
         PAlwt8kCdYTRSWfRhw9arpirgrIAwZyuzIE4e6gvpPPHFwrahvhALMWNl8dx0uaDJ/Ke
         qKieCtd8llJWHeiSvQO+qY0aCr8ABBhGNw6E7iQ7sgkGkQBZwx14hTnsrHbXwf1G9DYS
         USYQItZLsix6mQvJ8GH+TLBuaqP3vtA7cpbm4j8Wb73tVDSk6GcTFPR+95UVad/RF5uK
         9Hv/WJWexmmPXHYc/n9HAjxYVIDdB++o9B2a6gzi8GCbPtWihQZgaFCWrOgYCMsBRDAl
         8Jvw==
X-Gm-Message-State: AFqh2kqPgHBEXajRvOJUcSDOOVipha3I1wBWLN8rsgWv9aYWJcrY+JQz
        ZotbfNHkn2yVFdV/WlKVHMglh5FRjfI=
X-Google-Smtp-Source: AMrXdXtgY2As/mRQ0ByKzkFUSf5qkT3iCY9JNpJGYUSOO/Hv+FybAX34GzoK0PMHEM3TErGeUuwK9Q==
X-Received: by 2002:a05:600c:1e09:b0:3cf:b73f:bf8f with SMTP id ay9-20020a05600c1e0900b003cfb73fbf8fmr56054836wmb.7.1673584917990;
        Thu, 12 Jan 2023 20:41:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hg11-20020a05600c538b00b003cf6a55d8e8sm22851826wmb.7.2023.01.12.20.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:41:57 -0800 (PST)
Message-Id: <26406a4d8797e68f0ba4fe097cf0973f60d67114.1673584914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 04:41:53 +0000
Subject: [PATCH 3/4] ls-files: clarify descriptions of status tags for -t
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Much like the file selection options we tweaked in the last commit, the
status tags printed with -t had descriptions that were easy to
misunderstand, and for many of the same reasons.  Clarify them.

Also, while at it, remove the "semi-deprecated" comment for "git
ls-files -t".  The -t option was marked as semi-deprecated in 5bc0e247c4
("Document ls-files -t as semi-obsolete.", 2010-07-28) because:

    "git ls-files -t" is [...] badly documented, hence we point the
    users to superior alternatives.
    The feature is marked as "semi-obsolete" but not "scheduled for removal"
    since it's a plumbing command, scripts might use it, and Git testsuite
    already uses it to test the state of the index.

Marking it as obsolete because it was easily misunderstood, which I
think was primarily due to documentation problems, is one strategy, but
I think fixing the documentation is a better option.  Especially since
in the intervening time, "git ls-files -t" has become heavily used by
sparse-checkout users where the same confusion just doesn't apply.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-ls-files.txt | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index f89ab1bfc98..3886d58d178 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -137,25 +137,27 @@ OPTIONS
 	with `-s` or `-u` options does not make any sense.
 
 -t::
-	This feature is semi-deprecated. For scripting purpose,
-	linkgit:git-status[1] `--porcelain` and
+	Show status tags together with filenames.  Note that for
+	scripting purposes, linkgit:git-status[1] `--porcelain` and
 	linkgit:git-diff-files[1] `--name-status` are almost always
 	superior alternatives, and users should look at
 	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
 	`--name-status` for more user-friendly alternatives.
 +
 --
-This option identifies the file status with the following tags (followed by
-a space) at the start of each line:
-
-	H::	cached
-	S::	skip-worktree
-	M::	unmerged
-	R::	removed/deleted
-	C::	modified/changed
-	K::	to be killed
-	?::	other
-	U::     resolve-undo
+This option provides a reason for showing each filename, in the form
+of a status tag (which is followed by a space and then the filename).
+The status tags are all single characters from the following list:
+
+	H::	tracked file that is not either unmerged or skip-worktree
+	S::	tracked file that is skip-worktree
+	M::	tracked file that is unmerged
+	R::	tracked file with unstaged removal/deletion
+	C::	tracked file with unstaged modification/change
+	K::	untracked paths which are part of file/directory conflicts
+		which prevent checking out tracked files
+	?::	untracked file
+	U::     file with resolve-undo information
 --
 
 -v::
-- 
gitgitgadget

