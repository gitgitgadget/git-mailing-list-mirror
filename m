Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CACAC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 14:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiBPOIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 09:08:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiBPOIa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 09:08:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C5F4D0D
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 06:08:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k1so3669638wrd.8
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 06:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=i3NcR0E2qYE6IWwpmjlcAMRpVPzTXeU3MJL3vcZSWIs=;
        b=m0lHDrcqzorFkIuDxUWOHUrVncuWPGzl8CGPfvfKNio7IHqge822BbeY70MT1SJLkU
         45rM4JPB+UjiMORh0XwxMuuZO4xmxVKv9QiXHtLL+IqBbvbYVvgnidvOPCXg53Yh+XU6
         sDBZQ8e3J1QPiWmxUbzmSCbckZ6UwocaAZapdLX9A+7ksECHKapQYTP99gT1eqoqa5AC
         TekEoiXv9VwIouQpdy8CffYmkZbIjmYlRLOe9GxvQBwEdrmL6yZR8x3QvNUVN45EcU6n
         SW6chVKcfFBWxUqM/rmSD4ie19HAdyRWD5m1D1HH14mhGRat0xz4OtKGa/5lENHDB2EU
         uVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i3NcR0E2qYE6IWwpmjlcAMRpVPzTXeU3MJL3vcZSWIs=;
        b=je1npWTBlJ4c8MK3mQEQJELDNL/E19vJ1/R57Edja9avS+Q1PKn5qKJC29EQkT36B2
         897eSgk5BscCVARhM3VsIi3J1kJ0Kgqd+lbpM4u8MIBXlUQFZS9X71oZSaPqiZ/aRCMC
         zC+rePIaAVfw4smNOYGO1/FP5HfsC/gj1QvYNT0TTDq77gyPH0XGLmyZk8+bkNIJXPfC
         kbpYIpbTnauhutu9rtXeZn0xxP8T+kz4LlPaZvKxadIawWjllIUqVoOV649L92fLQUHY
         WhD1L5VGT1+5mRqmD2jbeb0YP91hlF6BUL6a5/do/bs6R5IKknY5+EBGlhO5BRFHDya4
         Kwig==
X-Gm-Message-State: AOAM53038D4M7Y4waDwG3P70T4x1qR5X8tXIzkxg+rQMIYPmkjBrdd4c
        m8T9Yytp0Pa+OGejmC+fxi98Gm6D/8Q=
X-Google-Smtp-Source: ABdhPJzuHWqwu8aSTDWFT6EIvHOsxvX6Dd8NzdwPLloIas4tc+Ke9UW7qv6LDp/G/iDFcgqNLFk2Xg==
X-Received: by 2002:adf:ec0b:0:b0:1e4:f1be:b62a with SMTP id x11-20020adfec0b000000b001e4f1beb62amr2485617wrn.487.1645020496225;
        Wed, 16 Feb 2022 06:08:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4sm15986800wrp.25.2022.02.16.06.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 06:08:15 -0800 (PST)
Message-Id: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
From:   "Erlend Egeberg Aasland via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 14:08:14 +0000
Subject: [PATCH] branch: delete now accepts '-' as branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erlend Egeberg Aasland <erlend.aasland@innova.no>,
        "Erlend E. Aasland" <erlend.aasland@innova.no>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Erlend E. Aasland" <erlend.aasland@innova.no>

This makes it easy to get rid of short-lived branches:

$ git switch -c experiment
$ git switch -
$ git branch -D -

$ gh pr checkout nnn
$ make && make test
$ git switch -
$ git branch -D -

Signed-off-by: Erlend E. Aasland <erlend.aasland@innova.no>
---
    [RFC] branch: delete now accepts '-' as branch name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1217%2Ferlend-aasland%2Fbranch-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1217/erlend-aasland/branch-name-v1
Pull-Request: https://github.com/git/git/pull/1217

 builtin/branch.c  | 6 +++++-
 t/t3200-branch.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4ce2a247542..f6c876c09d2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -236,7 +236,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
-		strbuf_branchname(&bname, argv[i], allowed_interpret);
+		if (!strcmp(argv[i], "-")) {
+			strbuf_branchname(&bname, "@{-1}", allowed_interpret);
+		} else {
+			strbuf_branchname(&bname, argv[i], allowed_interpret);
+		}
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 1bc3795847d..6afb7150534 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -71,6 +71,14 @@ test_expect_success 'git branch -d d/e/f should delete a branch and a log' '
 	test_must_fail git reflog exists refs/heads/d/e/f
 '
 
+test_expect_success 'git branch -D - should delete branch @{-1}' '
+	git switch -c j &&
+	git switch - &&
+	git branch -D - &&
+	test_path_is_missing .git/refs/heads/j &&
+	test_must_fail git reflog exists refs/heads/j
+'
+
 test_expect_success 'git branch j/k should work after branch j has been deleted' '
 	git branch j &&
 	git branch -d j &&

base-commit: b80121027d1247a0754b3cc46897fee75c050b44
-- 
gitgitgadget
