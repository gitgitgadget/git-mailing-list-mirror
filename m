Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61303C7EE2D
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 10:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCAKUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 05:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCAKUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 05:20:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9022312BD7
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 02:20:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso7493674wmp.4
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 02:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2SpxY5V72QCigE9NmI/7YatY7OyQ1Myu+A0oI2O9Jo=;
        b=iw6CYMOlf+3fWP8Eg1JU6g5NEdMXUcglqqIfhN7xGcv8DSo9hNjkTew/DzygUl2rWB
         yuB314IKYReY7Ag0chaQM5FcstjI/TlzI4K8esg2Zp+0zk1kiYHqH7vd5YIFOmRaVOsS
         ScofxeItyKD4cQACLx9IOXg2+MU6iGFSPmw1W0fXItMSPHhyBWnGBrYd72TWy8JVAsP1
         LSPUspP5aL3cGI+XC5BMbR3dUqdQHjUy+JTthF+BrH74rxmg8QT7tE5OrdIZK1N6Q31u
         pwDaz7l/YFb68GbaZI94SEZbEpCN4uLzNps7u29V+MGvP43fDzr4LJuZ5l2M9p29x2lj
         KeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2SpxY5V72QCigE9NmI/7YatY7OyQ1Myu+A0oI2O9Jo=;
        b=ztKNUT8vrxoQLLhIywkKEw3ScOqDcenb61Pu7GxsuUYjI7B5WQ9Ld8tRrzsFYFb+nL
         FrS5/ISbvLzobIl5HYy3c4QZ5Mve665cpLJVf4LujRUXaaOcOVuEkjT8WOzgBdvrAfVY
         PWnfYcf7Ufh9dUwDuQ8j47A8XJvEFQtC/WtGN5Dze6/YJeSB6dlHL2sEyBUWbWi1q4c7
         AieHD0MZyEd9dgbdS/J0Clmp7uYMR7Yj8g0Y5j2NwsPevRC7QaMf2wjSfA2lTw3SvfcE
         oblIB5Za0kX0mVzvrWkYmBnq/LBhDP1kvLGAqbsz3G6ojrAf9icyNL3IxZ6QrH34n0Kd
         oJ6Q==
X-Gm-Message-State: AO0yUKW5ZQdjucm0LM0Sv1bF/HVnED6ugwDE/2BDDVPSCEWY5Gtdx/oH
        /zFuZZkV/ryzY0NNgzVKahndSenCM/U=
X-Google-Smtp-Source: AK7set8XeZ8hL2JfBrw/ApxPtaaJsUgpHOke9CwpQGhx9oT9IvJwTERfhIfqVLGY/wNUJbUypwb8pQ==
X-Received: by 2002:a05:600c:3093:b0:3eb:3104:efef with SMTP id g19-20020a05600c309300b003eb3104efefmr4400705wmn.31.1677666032367;
        Wed, 01 Mar 2023 02:20:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003e0238d9101sm17453294wmb.31.2023.03.01.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 02:20:31 -0800 (PST)
Message-Id: <022818f0e9f130b62e856722d0db9818c0a1bcdd.1677666029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.v4.git.1677666029.gitgitgadget@gmail.com>
References: <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
        <pull.1465.v4.git.1677666029.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 10:20:29 +0000
Subject: [PATCH v4 2/2] push: allow delete single-level ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

We discourage the creation/update of single-level refs
because some upper-layer applications only work in specified
reference namespaces, such as "refs/heads/*" or "refs/tags/*",
these single-level refnames may not be recognized. However,
we still hope users can delete them which have been created
by mistake.

Therefore, when updating branches on the server with
"git receive-pack", by checking whether it is a branch deletion
operation, it will determine whether to allow the update of
a single-level refs. This avoids creating/updating such
single-level refs, but allows them to be deleted.

On the client side, "git push" also does not properly fill in
the old-oid of single-level refs, which causes the server-side
"git receive-pack" to think that the ref's old-oid has changed
when deleting single-level refs, this causes the push to be
rejected. So the solution is to fix the client to be able to
delete single-level refs by properly filling old-oid.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/receive-pack.c |  4 +++-
 connect.c              |  3 ++-
 t/t5516-fetch-push.sh  | 12 ++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c24616a3ac6..af61725a388 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1463,7 +1463,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		find_shared_symref(worktrees, "HEAD", name);
 
 	/* only refs/... are allowed */
-	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (!starts_with(name, "refs/") ||
+	    check_refname_format(name + 5, is_null_oid(new_oid) ?
+				 REFNAME_ALLOW_ONELEVEL : 0)) {
 		rp_error("refusing to update funny ref '%s' remotely", name);
 		ret = "funny refname";
 		goto out;
diff --git a/connect.c b/connect.c
index 63e59641c0d..7a396ad72e9 100644
--- a/connect.c
+++ b/connect.c
@@ -30,7 +30,8 @@ static int check_ref(const char *name, unsigned int flags)
 		return 0;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
-	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
+	if ((flags & REF_NORMAL) && check_refname_format(name,
+							 REFNAME_ALLOW_ONELEVEL))
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 98a27a2948b..19ebefa5ace 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -401,6 +401,11 @@ test_expect_success 'push with ambiguity' '
 
 '
 
+test_expect_success 'push with onelevel ref' '
+	mk_test testrepo heads/main &&
+	test_must_fail git push testrepo HEAD:refs/onelevel
+'
+
 test_expect_success 'push with colon-less refspec (1)' '
 
 	mk_test testrepo heads/frotz tags/frotz &&
@@ -898,6 +903,13 @@ test_expect_success 'push --delete refuses empty string' '
 	test_must_fail git push testrepo --delete ""
 '
 
+test_expect_success 'push --delete onelevel refspecs' '
+	mk_test testrepo heads/main &&
+	git -C testrepo update-ref refs/onelevel refs/heads/main &&
+	git push testrepo --delete refs/onelevel &&
+	test_must_fail git -C testrepo rev-parse --verify refs/onelevel
+'
+
 test_expect_success 'warn on push to HEAD of non-bare repository' '
 	mk_test testrepo heads/main &&
 	(
-- 
gitgitgadget
