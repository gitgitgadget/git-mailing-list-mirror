Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EC9C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJLJfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJLJfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:35:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA93F4B9A5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w18so25381185wro.7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxEsvSkDYLHED1mTisNm5Ze7OCeeJZRDcAy6Ltwch8Y=;
        b=XBoPqfznjLLZrH3Edrf6fqSbICLofRMc7JR07adzcg2FWg9oLLtJcc8qzGwvfaUGfh
         /kaAMyrzAg/0wlEuKXxtsZy3Hb0bTCfT/bSFSslZzKduKDO/CAiE44CmB4v2OUSJQTpL
         w2N5yfF+y8qOZEi5C1LH3CqIMcnA/dabnxFZ8BVbhXX9lkBDwWe8DbdR5oKsGQOOH8mp
         geg305fIpz+OiZ13VHlG56mQQOc3oERLwMCuE/Rm7489xSDsbr5R6I16cTWHpSYzhogc
         3IAmJEeOsUC6/ymUnTguyZvohZT4GiAc4iUcqnYiHr0IfsaAgOLBkdIgpgRPpMqGd23h
         rQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxEsvSkDYLHED1mTisNm5Ze7OCeeJZRDcAy6Ltwch8Y=;
        b=11JNheDFofg3uN1Y/8+EzVFciY0S3ozC+Zh0kB0y3tZkVxdSeZlrgbLFGTstRvo9Fw
         VgCUHqgY9Ouv7nrSyNTQuGhEfT7QOGp7DbAGm+l4DZjhFLgtPkyFcfQuZ+sQKAgjCohH
         j8dI00CnP6hKVCa+ht9FjtwbqM+jDFaNGtsV6s77+nDFHIPNQENm0IWrkDIElSacswdU
         1XkIi5BjfZaZokGwPREOXwsJ0KkXHgLk/FK+FkvdjMcOF0Wjvo+Zg/Eecx+6+wSQbIPr
         1nXm3dQs/dO7Yn3k1GM7Kh1S2dxBwsN22I+gf/bd72i3MhAJGS9TnoANnkn/4tZtVsIn
         DpAw==
X-Gm-Message-State: ACrzQf3K1GaZl3usqWxb8ndDSD9FK6mrurwgUc3cHMbsHOqGMAU0PnjE
        o/SVIvq/6cuYe9LvfyaK69JGvgNg7lk=
X-Google-Smtp-Source: AMsMyM7NRX6Fm2SXRvxX5j+xyDC06rJOFL79675vgR17gLtcclomT/yx7pg2qS5K3f06Wacx90qHfA==
X-Received: by 2002:a05:6000:18a5:b0:231:e0c5:1322 with SMTP id b5-20020a05600018a500b00231e0c51322mr2268096wri.376.1665567320037;
        Wed, 12 Oct 2022 02:35:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020a7bc343000000b003b47ff307e1sm1259763wmj.31.2022.10.12.02.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:35:19 -0700 (PDT)
Message-Id: <a5338e6bdd8cc783f01653cf4b668273bc2abec2.1665567312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:35:10 +0000
Subject: [PATCH v3 6/8] rebase --apply: make reflog messages match rebase
 --merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The apply backend creates slightly different reflog messages to the
merge backend when starting or finishing a rebase and when picking
commits. These differences make it harder than it needs to be to parse
the reflog (I have a script that reads the finishing messages from
rebase and it is a pain to have to accommodate two different message
formats). While it is possible to determine the backend used for a
rebase from the reflog messages, the differences are not designed for
that purpose. c2417d3af7 (rebase: drop '-i' from the reflog for
interactive-based rebases, 2020-02-15) removed the clear distinction
between the reflog messages of the two backends without complaint.

As the merge backend is the default it is likely to be the format most
common in existing reflogs. For that reason the apply backend is changed
to format its reflog messages to match the merge backend as closely as
possible. Note that there is still a difference as when committing a
conflict resolution the apply backend will use "(pick)" rather than
"(continue)" because it is not currently possible to change the message
for a single commit.

In addition to c2417d3af7 we also changed the reflog messages in
68aa495b59 (rebase: implement --merge via the interactive machinery,
2018-12-11) and 2ac0d6273f (rebase: change the default backend from "am"
to "merge", 2020-02-15). This commit makes the same change to "git
rebase --apply" that 2ac0d6273f made to "git rebase" without any backend
specific options. As the messages are changed to use an existing format
any scripts that can parse the reflog messages of the default rebase
backend should be unaffected by this change.

There are existing tests for the messages from both backends which are
adjusted to ensure that they do not get out of sync in the future.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 9 +++++----
 t/t3406-rebase-message.sh | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f7b00efeb92..ed612c2d0c3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -582,10 +582,10 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
+	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
-	strbuf_addf(&head_reflog, "%s finished: returning to %s",
+	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
@@ -615,7 +615,8 @@ static int run_am(struct rebase_options *opts)
 
 	am.git_cmd = 1;
 	strvec_push(&am.args, "am");
-
+	strvec_pushf(&am.env, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
+		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
 	if (opts->action && !strcmp("continue", opts->action)) {
 		strvec_push(&am.args, "--resolved");
 		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1789,7 +1790,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		printf(_("First, rewinding head to replay your work on top of "
 			 "it...\n"));
 
-	strbuf_addf(&msg, "%s: checkout %s",
+	strbuf_addf(&msg, "%s (start): checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid,
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index bb2a4949abc..5c6cd9af3bc 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 write_reflog_expect () {
 	if test $mode = --apply
 	then
-		sed 's/(finish)/finished/; s/ ([^)]*)//'
+		sed 's/(continue)/(pick)/'
 	else
 		cat
 	fi >expect
-- 
gitgitgadget

