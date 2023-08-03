Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABCCC001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 10:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjHCK2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjHCK2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 06:28:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00A2109
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 03:28:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso7860025e9.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691058501; x=1691663301;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV/5ooSiOeSiBEP29cxcMJLnbS/fejhlBcxpxe2OT9E=;
        b=gDT9U+zfWeQ1RX4KPdomU5jNqhdAQuiTV9P2i1m8jWJ9fgjqltWil6eLtlxoy1TtJF
         ddNOq/zt2JgRQEkkJQuICkIIa67R1tbyb4JWTrSqkojzsAseGt2W4XVUNSrjTyt9sPPj
         Jq+QXpH0IH/PvlF3gb6BLpYfwK0jWpRZDSygwD6Bpdb4ZiZx4C2IgeDK76B8sVoKDs/v
         86q35H1o7wjVGmt2nTbkXWQz2BbOARUxdzKapaUH0h2EaIZM7Uq5uMJJ5UzFjWbFdflO
         35iWPMvy/2MpZLMdMGwOj+9MNZ26TglKOag3jyDXhR/gZyreW6QHQork9eXsPeD2oHLV
         4MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691058501; x=1691663301;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cV/5ooSiOeSiBEP29cxcMJLnbS/fejhlBcxpxe2OT9E=;
        b=VN0VV2EZzGhoH1lk2eeZJi8GtxQSk1476sHiIuqPCq+pg74dqGILpm3L+AI60Pthsg
         Vn+FvKnK9HCq2Xns6uSsz277fb4c8yKzcTAO9OhFAvAHX/QgfiWyYX/ssjKKQk8N83w0
         +pP2PJ+ZyNJxvrvOztGwM6v+2mOSw5FagjLU+Tb+QkZqGFHCIvz5zw7xhFYrKnMlHQ6a
         hdWiM+bMI1ou9OaeT+FSbEwRXHvjSxYue9ODaaZOX8ywDt3UsxsqTL0VvVTzBBNfj/Cj
         DqpKRF1Imb1ZBrr/VQcRTx5kX7rc7mZ8xNXD61sy7H1ewHkR+VIrkyqkHKk9SsduIbxv
         QCSA==
X-Gm-Message-State: ABy/qLbuf2FwvIW7mYt/S2b1VWtEM/8N8X4r8lSWmWsLmIpPGhf71FTt
        T3acHh9mwc8Ikh9eELU3tFKgaj4KFvo=
X-Google-Smtp-Source: APBJJlGg8Fit3LQE4LiC3M9GSYU5SB7y0WuAKfifRB0PpYpQlkSYl1KQwyaCP//krD4nEr/p+1JKBQ==
X-Received: by 2002:a1c:6a0a:0:b0:3f5:878:c0c2 with SMTP id f10-20020a1c6a0a000000b003f50878c0c2mr6791928wmc.3.1691058501206;
        Thu, 03 Aug 2023 03:28:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c294400b003fbe4cecc3bsm3965091wmd.16.2023.08.03.03.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:28:21 -0700 (PDT)
Message-ID: <bf8b34aaef32a64b85f778ab219aeb41238f2bf2.1691058498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 10:28:17 +0000
Subject: [PATCH 2/3] run-command: teach locate_in_PATH about Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

since 5e1f28d206 (bisect--helper: reimplement `bisect_visualize()` shell
 function in C, 2021-09-13) `git bisect visualize` uses exists_in_PATH()
to check wether it should call `gitk`, but exists_in_PATH() relies on
locate_in_PATH() which currently only understands POSIX-ish PATH variables
(a list of paths, separated by colons) on native Windows executables
we encounter Windows PATH variables (a list of paths that often contain
drive letters (and thus colons), separated by semicolons). Luckily we do
already have a function that can lookup executables on windows PATHs:
mingw_path_lookup(). Teach locate_in_PATH() to use mingw_path_lookup()
on Windows.

Reported-by: Louis Strous <Louis.Strous@intellimagic.com>
Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 run-command.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 60c94198664..8f518e37e27 100644
--- a/run-command.c
+++ b/run-command.c
@@ -182,13 +182,10 @@ int is_executable(const char *name)
  * Returns the path to the command, as found in $PATH or NULL if the
  * command could not be found.  The caller inherits ownership of the memory
  * used to store the resultant path.
- *
- * This should not be used on Windows, where the $PATH search rules
- * are more complicated (e.g., a search for "foo" should find
- * "foo.exe").
  */
 static char *locate_in_PATH(const char *file)
 {
+#ifndef GIT_WINDOWS_NATIVE
 	const char *p = getenv("PATH");
 	struct strbuf buf = STRBUF_INIT;
 
@@ -217,6 +214,9 @@ static char *locate_in_PATH(const char *file)
 
 	strbuf_release(&buf);
 	return NULL;
+#else
+	return mingw_path_lookup(file,0);
+#endif
 }
 
 int exists_in_PATH(const char *command)
-- 
gitgitgadget

