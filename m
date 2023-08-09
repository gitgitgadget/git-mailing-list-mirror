Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4065EB64DD
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 07:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjHIHrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHIHrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 03:47:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A591981
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 00:47:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso55169775e9.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691567263; x=1692172063;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6PAuO1q/7dQCX00+PbFPC1+M0Zluagc/CYmGQuzEWA=;
        b=DqZyx00b4gvBzoJgAv7GJzFgGOOpebVfv/rao551od57zGHjyusILZS7Lj3c3ZTXpx
         kPAjKeO2hAUZ7+d9j08LbKzY22LxIcVqfRbWQP2e68UG9pRJPF490jU1g34e7zwP0X1J
         UcFMQ56lO7on/4muoLwdGUSDUeRbDZaj71h5ieEgrMDamnvNVrEhKYk8abeppqkmTFFS
         gCvhSQazNBL1xJG+R1hHVjkeLuXc8RHQ1WgttAL3g/qRVV/0SJGRRlRKRy562qilFBT2
         8XkmfEuanN5xFE4zvE0VjsFOy1ZpL9LopvFOF73woEbkTctDY6dRg85BW7ufIg9+1uci
         PkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691567263; x=1692172063;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6PAuO1q/7dQCX00+PbFPC1+M0Zluagc/CYmGQuzEWA=;
        b=jhkZA3qzUfVxMkGgeWH3ZOuE1rNDRit2vzbCTMgSp+np/EaOAo8kHPEpL8uDtFmEH3
         tlVZPUaVSMrHNkkCVWnyr6eyoQa3fwRorXEbqPk3VinfJrCChfsZNYGlbWoPN9BQYL/8
         s48TcQiqqn7rHuTKcrDojTUZkd9aBE/Q2sE1IIqCo/ZbDwGTXuT31FbPvKJnymbNrAIp
         zutU1q2+myUlxKVbWGdUaPS1vi4fkdBtN3NpQlgYKp4h3gOFaa/5SrRKXtY8QZ+wwMz+
         f1W5K09ucGhB43sKYTnotpV34V7I+1GxnhBimQ690yYWGh+Ka0tkyshvnB/tjMjewHXb
         mWYA==
X-Gm-Message-State: AOJu0YwXnV2JHXdmufikJL5BMfsPT5vuogNiM3F47b0phWZvWIiutjTz
        +mPh5hYYnJUJtPuDUa/zvJLNhvhyvIo=
X-Google-Smtp-Source: AGHT+IHSZdE9fgk/BcysaAvAhCnkbaQCMchRWVtTKo/G7W5tYWX1tLXWtLSSC9Gdk0UmXzKEKUFVnA==
X-Received: by 2002:adf:fc86:0:b0:317:5f04:c3de with SMTP id g6-20020adffc86000000b003175f04c3demr1012775wrr.4.1691567262885;
        Wed, 09 Aug 2023 00:47:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020adfcd8e000000b00314329f7d8asm15931992wrj.29.2023.08.09.00.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 00:47:42 -0700 (PDT)
Message-ID: <pull.1561.v2.git.1691567261701.gitgitgadget@gmail.com>
In-Reply-To: <pull.1561.git.1691506431114.gitgitgadget@gmail.com>
References: <pull.1561.git.1691506431114.gitgitgadget@gmail.com>
From:   "Sebastian Thiel via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Aug 2023 07:47:41 +0000
Subject: [PATCH v2] fix `git mv existing-dir non-existing-dir` in some
 environments.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Sebastian Thiel <sebastian.thiel@icloud.com>,
        Sebastian Thiel <sebastian.thiel@icloud.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sebastian Thiel <sebastian.thiel@icloud.com>

When moving a directory onto another with `git mv` various checks are
performed. One of of these validates that the destination is not existing.

When calling `lstat` on the destination path and it fails as the path
doesn't exist, some environments seem to overwrite the passed  in
`stat` memory nonetheless (I observed this issue on debian 12 of x86_64,
running on OrbStack on ARM, emulated with Rosetta).

This would affect the code that followed as it would still acccess a now
modified `st` structure, which now seems to contain uninitialized memory.
`S_ISDIR(st_dir_mode)` would then typically return false causing the code
to run into a bad case.

The fix avoids overwriting the existing `st` structure, providing an
alternative that exists only for that purpose.

Note that this patch minimizes complexity instead of stack-frame size.

Signed-off-by: Sebastian Thiel <sebastian.thiel@icloud.com>
---
    [PATCH] mv: handle lstat() failure correctly
    
    When moving a directory onto another with git mv various checks are
    performed. One of of these validates that the destination is not
    existing.
    
    When calling lstat on the destination path and it fails as the path
    doesn't exist, some environments seem to overwrite the passed in stat
    memory nonetheless (I observed this issue on debian 12 of x86_64,
    running on OrbStack on ARM, emulated with Rosetta).
    
    This would affect the code that followed as it would still acccess a now
    modified st structure, which now seems to contain uninitialized memory.
    S_ISDIR(st_dir_mode) would then typically return false causing the code
    to run into a bad case.
    
    The fix avoids overwriting the existing st structure, providing an
    alternative that exists only for that purpose.
    
    
    Note that this patch minimizes complexity instead of stack-frame size.
    ======================================================================
    
    It's worth pointing out that the test demonstrates this case only if one
    happens to execute it in one of the environments that happen to have an
    lstat that writes into stat even on error. Thus it already worked for me
    on MacOS, even without the patch applied, which matches my observation
    that a certain script works there but doesn't work on the VM.
    
    Even though the patch now minimizes size, I can imagine one might
    instead want to rather copy st.st_mode to protect only the relevant
    field from being affected by potential rewrites of st later on.
    
    Changes since v1:
    
     * replaced previous title with recommendation by Junio C Hermano
     * improved formatting of commit message and renamed gix to git. Let's
       call that a typo
     * apply Junio C Hermano's suggestions to test-case
     * I refrained from changing the error message as this would mean all
       translations need adjustment (and I don't know how this is tracked
       then)
    
    I also want to apologise for the possibly terrible formatting and the
    repetition - it feels strange but is what gitgadget seems to suggests.
    Further, it's my honour to submit a patch to git and interact with the
    maintainers, it's like meeting my idols!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1561%2FByron%2Ffix-mv-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1561/Byron/fix-mv-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1561

Range-diff vs v1:

 1:  ad0e6754e2d ! 1:  8908fd228fe fix `git mv existing-dir non-existing-dir`*
     @@ Metadata
      Author: Sebastian Thiel <sebastian.thiel@icloud.com>
      
       ## Commit message ##
     -    fix `git mv existing-dir non-existing-dir`*
     +    fix `git mv existing-dir non-existing-dir` in some environments.
      
     -    *in some environments.
     +    When moving a directory onto another with `git mv` various checks are
     +    performed. One of of these validates that the destination is not existing.
      
     -    When moving a directory onto another with `gix mv`
     -    various checks are performed. One of of these
     -    validates that the destination is not an existing
     -    file.
     +    When calling `lstat` on the destination path and it fails as the path
     +    doesn't exist, some environments seem to overwrite the passed  in
     +    `stat` memory nonetheless (I observed this issue on debian 12 of x86_64,
     +    running on OrbStack on ARM, emulated with Rosetta).
      
     -    When calling `lstat` on the destination path and
     -    it fails as the path doesn't exist, some
     -    environments seem to overwrite the passed  in
     -    `stat` memory nonetheless.
     -    (I observed this issue on debian 12 of x86_64,
     -    running on OrbStack on ARM, emulated with Rosetta)
     +    This would affect the code that followed as it would still acccess a now
     +    modified `st` structure, which now seems to contain uninitialized memory.
     +    `S_ISDIR(st_dir_mode)` would then typically return false causing the code
     +    to run into a bad case.
      
     -    This would affect the code that followed as it
     -    would still acccess a now
     -    modified `st` structure, which now seems to
     -    contain uninitialized memory.
     -    `S_ISDIR(st_dir_mode)` would then typically
     -    return false causing the code to run into a bad
     -    case.
     +    The fix avoids overwriting the existing `st` structure, providing an
     +    alternative that exists only for that purpose.
      
     -    The fix avoids overwriting the existing `st`
     -    structure, providing an alternative that exists
     -    only for that purpose.
     -
     -    Note that this patch minimizes complexity instead of stack-size.
     +    Note that this patch minimizes complexity instead of stack-frame size.
      
          Signed-off-by: Sebastian Thiel <sebastian.thiel@icloud.com>
      
     @@ t/t7001-mv.sh: test_expect_success 'do not move directory over existing director
       '
       
      +test_expect_success 'rename directory to non-existing directory' '
     -+	mkdir dir-a && touch dir-a/f &&
     ++	mkdir dir-a &&
     ++	>dir-a/f &&
      +	git add dir-a &&
      +	git mv dir-a non-existing-dir
      +'


 builtin/mv.c  | 4 ++--
 t/t7001-mv.sh | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index fa84fcb20d8..05e7156034e 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -184,7 +184,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	int src_dir_nr = 0, src_dir_alloc = 0;
 	struct strbuf a_src_dir = STRBUF_INIT;
 	enum update_mode *modes, dst_mode = 0;
-	struct stat st;
+	struct stat st, dest_st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
 	struct cache_entry *ce;
@@ -304,7 +304,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			goto act_on_entry;
 		}
 		if (S_ISDIR(st.st_mode)
-		    && lstat(dst, &st) == 0) {
+		    && lstat(dst, &dest_st) == 0) {
 			bad = _("cannot move directory over file");
 			goto act_on_entry;
 		}
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 898a9205328..f136ea76f7f 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -174,6 +174,13 @@ test_expect_success 'do not move directory over existing directory' '
 	test_must_fail git mv path2 path0
 '
 
+test_expect_success 'rename directory to non-existing directory' '
+	mkdir dir-a &&
+	>dir-a/f &&
+	git add dir-a &&
+	git mv dir-a non-existing-dir
+'
+
 test_expect_success 'move into "."' '
 	git mv path1/path2/ .
 '

base-commit: 1b0a5129563ebe720330fdc8f5c6843d27641137
-- 
gitgitgadget
