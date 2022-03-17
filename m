Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76775C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 03:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiCQDS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 23:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244548AbiCQDSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 23:18:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB421246
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 20:16:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so4256540wmj.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q7v2mLorAec+4joH9KxenWTWCzFmP6q0r+BgYKi/NWc=;
        b=KBLqgzjsk/cD1/mJmnzSGGi8EHm7lBpi8pMtYt0khdYalHpwY/MTyUM0It/8BgXXI5
         eCKm+LvhAli2zmuygaHwUXUlXmUzfyWSMgad3Jb8DbWvxjP44nuULSM/Cd99cK/FPu3b
         /ljrxHxuzCaIpCc2SZIVSbGRv/SaLBmcf8pwSvECPPdD2+gCd8wTY0c8yXc+8vzXkwlE
         JUqZuIDqN8NiJ8GoHzOWf4uJS1RGhiUOsx698I6jv9arnKoqXLnwukBSX0nC0L94hLVA
         sngfMQ/IZW6KWChmZ6guThOx9Y0hTX3XQ4Gz127k+FSsH1+P5ws+vl2Ti27fIk3CvzjS
         pSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q7v2mLorAec+4joH9KxenWTWCzFmP6q0r+BgYKi/NWc=;
        b=DZ51b5b5Y5/bSrqpVZWzSi7UxlSOUDZMIx4GYI7UibMDpj+xNI4T9/ZlwWOgtrwN4g
         dICdnGB2/fMb/91OJ6dL/Ts0Ffhm3KcihUxWldCMkptQJwf8DNamx6J/SnGzN+60mpO9
         7GJX3nMKG/3rgubTOrXDtLc4GLUGCZjTZXTLZByLbEV+1KUjUN+RLlznf5qb5bhsf78E
         rRdH4RVl4ynIRWdpZH+8RpBV+ZznAsL81jtpBnsIajAQPZFdS+vuumAbBAVTiaeFmT6d
         aMrjE9k+PjT+l+pFEp1rZRpTNe0NgoiAljOhu8amM/f8D1oXQeWbV8txKj7HBuLZ4qqn
         PGdw==
X-Gm-Message-State: AOAM533dawl9Sa/m/+X6JSKb3+44BhhR1ugcDiszsdaEeiDbrMjZeLBC
        Y3QnQcEQUldiQU8cmnJDO6sCm9SnzyQ=
X-Google-Smtp-Source: ABdhPJxnD857xOo19/pSMahlo4jErVH3dBNwI9zH5Om0wHRlL6MszhLkdGO72EFDdV3W0WBLlWlt9A==
X-Received: by 2002:a05:600c:3c9c:b0:389:cc3b:9462 with SMTP id bg28-20020a05600c3c9c00b00389cc3b9462mr9766194wmb.105.1647487004413;
        Wed, 16 Mar 2022 20:16:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b00389cc36a3bfsm6573856wmp.6.2022.03.16.20.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 20:16:43 -0700 (PDT)
Message-Id: <bd1c9537ffc503707690ed173b9e6e808d58ce5d.1647487001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
References: <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
        <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 03:16:41 +0000
Subject: [PATCH v3 2/2] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Fixes a bug whereby rebase updates the deferenced reference HEAD points
to instead of HEAD directly.

If HEAD is on main and if the following is a fast-forward operation,

git rebase $(git rev-parse main) $(git rev-parse topic)

Instead of HEAD being set to $(git rev-parse topic), rebase erroneously
dereferences HEAD and sets main to $(git rev-parse topic). See [1] for
the original bug report.

The callstack from checkout_up_to_date() is the following:

cmd_rebase() -> checkout_up_to_date() -> reset_head() -> update_refs()
 -> update_ref()

When <branch> is not a valid branch but a sha, rebase sets the head_name
of rebase_options to NULL. This value gets passed down this call chain
through the branch member of reset_head_opts also getting set to NULL
all the way to update_refs(). update_refs() checks ropts.branch to
decide whether or not to switch brancheds. If ropts.branch is NULL, it
calls update_ref() to update HEAD. At this point however, from rebase's
point of view, we want a detached HEAD. But, since checkout_up_to_date()
does not set the RESET_HEAD_DETACH flag, the update_ref() call will
deference HEAD and update the branch its pointing to, which in the above
example is main.

The correct behavior is that git rebase should update HEAD to $(git
rev-parse topic) without dereferencing it.

Fix this bug by adding the RESET_HEAD_DETACH flag in checkout_up_to_date
if <branch> is not a valid branch. so that once reset_head() calls
update_refs(), it calls update_ref() with REF_NO_DEREF which updates
HEAD directly intead of deferencing it and updating the branch that HEAD
points to.

Also add a test to ensure this behavior.

1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

Reported-by: Michael McClimon <michael@mcclimon.org>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/rebase.c  | 5 ++++-
 t/t3400-rebase.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e7..5ae7fa2a169 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -827,8 +827,11 @@ static int checkout_up_to_date(struct rebase_options *options)
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    options->switch_to);
 	ropts.oid = &options->orig_head;
-	ropts.branch = options->head_name;
 	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	if (options->head_name)
+		ropts.branch = options->head_name;
+	else
+		ropts.flags |=  RESET_HEAD_DETACH;
 	ropts.head_msg = buf.buf;
 	if (reset_head(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 0643d015255..d5a8ee39fc4 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -394,6 +394,15 @@ test_expect_success 'switch to branch not checked out' '
 	git rebase main other
 '
 
+test_expect_success 'switch to non-branch detaches HEAD' '
+	git checkout main &&
+	old_main=$(git rev-parse HEAD) &&
+	git rebase First Second^0 &&
+	test_cmp_rev HEAD Second &&
+	test_cmp_rev main $old_main &&
+	test_must_fail git symbolic-ref HEAD
+'
+
 test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
-- 
gitgitgadget
