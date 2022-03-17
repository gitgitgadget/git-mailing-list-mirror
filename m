Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3A7C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiCQTzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiCQTzO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 15:55:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49B21593E
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:53:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so2896636wmb.4
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ziQ91RNazjwTIQyvEbsgGE6LoYOwbXNj2YyU1ILBdSI=;
        b=hoq+71LSDiJUUsl4bzxCzNUUNQGn76CffkGjFOYO6jtRY72y7nnImMsZx7MZBGy8sH
         RV5zJtwWJpwt7BQ9bsZ1MDdI+cbs3PbC9ppWu5NNq7rEk6ZhzdtPveY/qMgCM2eakZXS
         xg7vQJrZrJtwWHzRhGOHODDawOISE0b9cChEwPzUC05phTjPiM1G5M4fc0tzmKM3gezO
         q67NwCk8BRL25NdeCp0fwlq/XXZGWx6f8N3dWVTCRfvn8yBzJfKEg2Z2fSajxdQDm1rZ
         8yIGleZuoN6ipcXPhJIHc55HU6enECyagzkp3MB9ok6ECt+Xc/J8ysdEV1Y3nuv8rmRL
         1dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ziQ91RNazjwTIQyvEbsgGE6LoYOwbXNj2YyU1ILBdSI=;
        b=Vgpmv9gpzf3tmG2neayBJxtBy0uxCIRa2c8UlrXi9Al/GkDwjvxKjYPAo40SbAIIds
         QF/I33zwyc6UGFvY8aPD4g5UWC+txf6cxwaJcmfUR7X5hi1+eXF9ShVYIRzauHYngjz4
         VzWRUzs89tuTwPv4bsY2d+BdMGFFrcq0g42j2p57FFn23UmZ4nhiFrOxBaJ990Ku3rQk
         m8qeIDH5OXREopyQIVA0u9KLpMuo2M0S2/8JMimn0FRGNlR14gAl4V518fEMJX1SDmQd
         n9DqxyMIZzjAOPpt6avcXhhMKS70yrf8G574KS3RJmE9qGDG05Te0NL+bxIC97eEF/e8
         3khA==
X-Gm-Message-State: AOAM531/y2I6npXeYMWC1f1eBYSbo7xVhRdysThDSW2siu0dGz6z7Rn+
        Vk3mrAKnrYIWFOox22x1O5qo2AuOOGY=
X-Google-Smtp-Source: ABdhPJxi0MJwS3/e5V26uVQtozD9W8/hYMahJImiG6QXXfea6lh+XQSCsOBtHdgvTx52YAkNga1b9Q==
X-Received: by 2002:a05:600c:3b26:b0:38c:8358:4b84 with SMTP id m38-20020a05600c3b2600b0038c83584b84mr2271059wms.185.1647546831623;
        Thu, 17 Mar 2022 12:53:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm2240487wme.39.2022.03.17.12.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:53:51 -0700 (PDT)
Message-Id: <13c5955c317713bbc6a91b9f44081395880abb67.1647546828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
        <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 19:53:48 +0000
Subject: [PATCH v4 3/3] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
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

When <branch> is not a valid branch but an oid, rebase sets the head_name
of rebase_options to NULL. This value gets passed down this call chain
through the branch member of reset_head_opts also getting set to NULL
all the way to update_refs().

Then update_refs() checks ropts.branch to decide whether or not to switch
branches. If ropts.branch is NULL, it calls update_ref() to update HEAD.
At this point however, from rebase's point of view, we want a detached
HEAD. But, since checkout_up_to_date() does not set the RESET_HEAD_DETACH
flag, the update_ref() call will deference HEAD and update the branch its
pointing to, which in the above example is main.

The correct behavior is that git rebase should update HEAD to $(git
rev-parse topic) without dereferencing it.

Fix this bug by adding the RESET_HEAD_DETACH flag in checkout_up_to_date
if <branch> is not a valid branch. so that once reset_head() calls
update_refs(), it calls update_ref() with REF_NO_DEREF which updates
HEAD directly intead of deferencing it and updating the branch that HEAD
points to.

Also add a test to ensure the correct behavior.

1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/rebase.c  | 2 ++
 t/t3400-rebase.sh | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e7..27fde7bf281 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -829,6 +829,8 @@ static int checkout_up_to_date(struct rebase_options *options)
 	ropts.oid = &options->orig_head;
 	ropts.branch = options->head_name;
 	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	if (!ropts.branch)
+		ropts.flags |=  RESET_HEAD_DETACH;
 	ropts.head_msg = buf.buf;
 	if (reset_head(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 2fb3fabe60e..cf55b017ffc 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -389,13 +389,13 @@ test_expect_success 'switch to branch not checked out' '
 	git rebase main other
 '
 
-test_expect_success 'switch to non-branch changes branch HEAD points to' '
+test_expect_success 'switch to non-branch detaches HEAD' '
 	git checkout main &&
 	old_main=$(git rev-parse HEAD) &&
 	git rebase First Second^0 &&
-	test_cmp_rev HEAD main &&
-	test_cmp_rev main $(git rev-parse Second) &&
-	git symbolic-ref HEAD
+	test_cmp_rev HEAD Second &&
+	test_cmp_rev main $old_main &&
+	test_must_fail git symbolic-ref HEAD
 '
 
 test_expect_success 'refuse to switch to branch checked out elsewhere' '
-- 
gitgitgadget
