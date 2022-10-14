Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD75CC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJNI5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJNI45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:56:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A2D14EC7E
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a3so6621574wrt.0
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4y2vY8oJnT3QqSSX7L7QvLpZGE3GCu5a59PSNMqS4Y=;
        b=LSPNluqOzErmSUnAaw1h9Fuwx5J0bdU9DBO8CFtGrlmlDe0ZV2qrdT1Szo3vev9OU3
         qqQlTOgkrMEnZVE/q6AE7LdSbKtlejs+bdiWOz4dc6aY4myw77nHrPobTnEbF2UsGELx
         4yD2tDwSzlNBx178ckeQB1a1TqBWaDjtZDR2dNUOIiwEdsyGtXnWiieqeQaFagE1jA1s
         kuRpTjWlFj+fiZ5VUBkaR+n6yo8DypRQnKaDOVKzhEKHd+WUWuvzoiLC57ywywp1ufT1
         q2B+iHqJmn0jSMHVb9prsmGEf0zgSNKcNYZ8fh31hDQBQExVF2WEfL0k/EhobGiX/zKy
         etzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4y2vY8oJnT3QqSSX7L7QvLpZGE3GCu5a59PSNMqS4Y=;
        b=qrVwTYSo4qWltMWBZh0BWwpBQiJccylBFGCC0GwkTGiz5Du3GFX9kwEbxM8Z+8KDgM
         Hj9fWTaNA6swcny+orKJSkV3lpMHCPnaBsIs71hm75v3sKawv4WD8qPCcydqWqY4fms5
         WqiW5lJ1I6fHO7AFcGRCgqt+EVjWJrDqpT15VAAlTbKipTTIgl3IZ1hdWiIUwjupMu9z
         j4X4PHVwdtKIvdD6sM/mOhQ2FuwllcY2waw5Ymd92jf/G+cIqOy7FwFvz0zFyf2HzE6B
         ahFRfHjUSl1g4hu8Sh5cINlIFEi/BPiei4xNg9MxS7z6evI5ZSrAxP++v2Bcph39JOPx
         sWPQ==
X-Gm-Message-State: ACrzQf2PiESfB+g0g+l9ycSEt9prtAGkQIx31KeTTHBCiTdLcZGINI0d
        jRSJhYiDFH9LHNR6WJIden7yF/LU/2c=
X-Google-Smtp-Source: AMsMyM60XmxvnmtvLSpvYH3dsVMmCLEuX0SgWf63wAFqPtaR2EKgZWCB2wo/HEoCgRPNkE2m9vNldQ==
X-Received: by 2002:adf:cd84:0:b0:22e:2ff1:7305 with SMTP id q4-20020adfcd84000000b0022e2ff17305mr2641767wrj.650.1665737812176;
        Fri, 14 Oct 2022 01:56:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d4885000000b0022e55f40bc7sm1396995wrq.82.2022.10.14.01.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:56:51 -0700 (PDT)
Message-Id: <a1f6f36d4878ade4fae1142f03e53d0cc42dfb2b.1665737804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 08:56:43 +0000
Subject: [PATCH v3 6/7] builtin: patch-id: remove unused diff-tree prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <Jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <Jerry@skydio.com>

From a "git grep" of the repo, no command, including diff-tree itself,
produces diff output with "diff-tree " prefixed in the header.

Thus remove its handling in "patch-id".

Signed-off-by: Jerry Zhang <Jerry@skydio.com>
---
 builtin/patch-id.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 745fe193a71..c37b8f573b7 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -74,8 +74,8 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		const char *p = line;
 		int len;
 
-		if (!skip_prefix(line, "diff-tree ", &p) &&
-		    !skip_prefix(line, "commit ", &p) &&
+		/* Possibly skip over the prefix added by "log" or "format-patch" */
+		if (!skip_prefix(line, "commit ", &p) &&
 		    !skip_prefix(line, "From ", &p) &&
 		    starts_with(line, "\\ ") && 12 < strlen(line)) {
 			if (include_whitespace)
-- 
gitgitgadget

