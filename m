Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0188C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 21:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350318AbiCHVZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 16:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiCHVZh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 16:25:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738884FC4F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 13:24:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j26so125912wrb.1
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8JWPeASzx+YwjpKe+XHsaFeDuKMPE/QP89ayMIT7J+U=;
        b=KOkrsllR4mG0jq+ulIcEhrZPZI05l09wLe0OTnZJUlbDmE8qqlwKa+QOaWwXdJCwaj
         bskd72Z8JMG0nNsvJVdj7bOtbuQFwCVk85wrxWokdCBgsLMVg4cnlU73AaJwOI0mRf1+
         Nxg3w+SCTbGdlkx55ftEwDyvacj/XYeMWyjX5dKhnUEMKJxOu+IbqGyIv78gZMzlS5t9
         fNlGIAfscKzecFBqt5tMkw1TIJ5KbSTRfpZwKb4rWjc+R9u8fTeZAP2xqdIAlsEYv8+R
         XZIQzRX/r5OkIxwEnhElFIjLwxMSA7BBz6B1jBybFUMtWBbxtTMcq9OiIj/iSiigZeNj
         Fl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8JWPeASzx+YwjpKe+XHsaFeDuKMPE/QP89ayMIT7J+U=;
        b=IzSHzRkryapsRcwaKVBmHqGWN1Cpfo2k5KWyp7Tenhpoyy2OU90M/G1FkILWxrRjS0
         j7TZOO0DVYacI3WsMIOJMssTXZCCLfmxNwttE7pDI5zx2HMX4kDV06iOH9zCI1C91mJS
         ZHhPvHP7mTGYNVMm7tMmu+yxB13EAAUvhul6BBNOXER3FNKGbK368tk7oLhH8EH4S9zp
         /0z6PQklh6eIfy4vC8Qmml50YV/Wuunjyx+Nm37yAQMMqAg18LfncmoROr8eYCKM+dk1
         OBvCp7jtb36CdypGwpDAT/3TLOcxm+cshmLuhyy6HX2b3FM/sFPEETGEc8ZEDEgnIabe
         +IwQ==
X-Gm-Message-State: AOAM533FVJsYaMfeBNZTu43vH+JXoCTJ/up+AcDGbTKYP85HkGZg9iAN
        wpQcZXxe43MxnkHSbnjLYVbhVTxRKBI=
X-Google-Smtp-Source: ABdhPJxpKkrOOgoCnfyB76wFtEju7XE4xqrIviz8IIQ/AAtx9q50OVMcxD52POikk2RwlZvx0p0kcQ==
X-Received: by 2002:adf:d4c1:0:b0:1f0:59ad:7fb0 with SMTP id w1-20020adfd4c1000000b001f059ad7fb0mr13714479wrk.288.1646774678693;
        Tue, 08 Mar 2022 13:24:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h36-20020a05600c49a400b00382aa0b1619sm14782wmp.45.2022.03.08.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 13:24:37 -0800 (PST)
Message-Id: <pull.1225.git.git.1646774677277.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 21:24:37 +0000
Subject: [PATCH] name-rev: make --stdin hidden
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In 34ae3b70 (name-rev: deprecate --stdin in favor of --annotate-stdin),
we renamed --stdin to --annotate-stdin for the sake of a clearer name
for the option, and added text that indicates --stdin is deprecated. The
next step is to hide --stdin completely.

Make the option hidden. Also, update documentation to remove all
mentions of --stdin.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
    name-rev: make --stdin hidden
    
    The next step of replacing name-rev --stdin with --annotate-stdin is to
    make --stdin hidden. This patch also updates documentation to get rid of
    any mention of --stdin.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1225%2Fjohn-cai%2Fjc%2Fhide-name-rev-stdin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1225/john-cai/jc/hide-name-rev-stdin-v1
Pull-Request: https://github.com/git/git/pull/1225

 Documentation/git-name-rev.txt | 8 ++------
 builtin/name-rev.c             | 6 +++++-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index ec8a27ce8bf..5f196c03708 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git name-rev' [--tags] [--refs=<pattern>]
-	       ( --all | --stdin | <commit-ish>... )
+	       ( --all | --annotate-stdin | <commit-ish>... )
 
 DESCRIPTION
 -----------
@@ -70,10 +70,6 @@ The full name after substitution is master,
 while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
 -----------
 
---stdin::
-	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
-	They are functionally equivalent.
-
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
 	the name.  If given with --tags the usual tag prefix of
@@ -107,7 +103,7 @@ Now you are wiser, because you know that it happened 940 revisions before v0.99.
 Another nice thing you can do is:
 
 ------------
-% git log | git name-rev --stdin
+% git log | git name-rev --annotate-stdin
 ------------
 
 GIT
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 929591269dd..2389e7f752d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -538,7 +538,11 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				   N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
-		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use annotate-stdin instead")),
+		OPT_BOOL_F(0,
+			   "stdin",
+			   &transform_stdin,
+			   N_("deprecated: use annotate-stdin instead"),
+			   PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,

base-commit: c2162907e9aa884bdb70208389cb99b181620d51
-- 
gitgitgadget
