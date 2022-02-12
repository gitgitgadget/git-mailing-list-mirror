Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DA2C433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiBLUf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiBLUfL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BADA606E5
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso4214026wmi.0
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C0DTlc6ft3YAIhbOz3DN1xGI6xoZ/NwSGvkQSaeTJ8U=;
        b=PLLJRIaMdk0GQwhFRshTPICn27N38JoXhFhdxfOCK45GMStnshD9rotXjnqlrRl3p1
         QSwCkmm3LOcRGgkhUNzJDrso8/hzvJCL47/d7+YXzE+7/MmPTXn5a/3IYS0WtgXqAQbK
         y9wGBiPTe3q2AL8hNUQK0yyfzvpG9uVa3r22W13Gma5eouVWl89V+4QZOiRiqBi96YoZ
         4t0zIr1FURm9NUvEx8q9K5PU1hO2iR45VoIUpdGoj8BjHMj00CVLuadjDZ7bI0D8T+mS
         BkL/n9b0pcFbvvNuxrt5V2Xmcun82eQldXG21kpPRSd9YrS+ZYvWbwu+gKwfDn7G3kP2
         Vk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C0DTlc6ft3YAIhbOz3DN1xGI6xoZ/NwSGvkQSaeTJ8U=;
        b=79F3CEsEf1EUfauzLrqIM2ZJVuxby/iEyleFd5EUBsjKLNSV0bNarGRQDP8wMY/LSH
         xPJWaHRM75XenKDtMPNQpZMFWPiKscOBDWRY/JaaVVl/A+2agFFAfwCYEcx1g05eOtHT
         h+YI+OqCiZP7MUXiuNos24hjzIN94Hzx1X30DdHFzDMZPCPLNPRB873b9lhSdDO4Rwbl
         expIO/WQqbv5qVV0jGFZ7MRCXAF9F01mDqrdf406yI0YGWP+YDfcuxb45QzT972pd4Bf
         0cWGKng2wH+v0tScN2uvDzJwCg77hnAuoELPgNVyoYMj5lbnz1Gi3iMu3ErRzngzGVd7
         9Vaw==
X-Gm-Message-State: AOAM532K/Vyhda1ia32OtcV06cleOtK+GaWEOF6EppQGHo7tJtYZiuu/
        850gtWDpzQbQEjXpXQhpgeEZNCOqaTE=
X-Google-Smtp-Source: ABdhPJygkGMYMuoqfxPSimotlwy5AqXeju6MB9DQ7OgQJAX+YdABhPwXLAouRmB4iRKDAKHcDb7XUQ==
X-Received: by 2002:a7b:ce90:: with SMTP id q16mr5223813wmj.91.1644698103717;
        Sat, 12 Feb 2022 12:35:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t187sm7245116wma.22.2022.02.12.12.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:35:03 -0800 (PST)
Message-Id: <e706cf31c6eec8e54b8791a19efa3388c662f711.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:52 +0000
Subject: [PATCH v4 11/12] merge-tree: add a --allow-unrelated-histories flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Folks may want to merge histories that have no common ancestry; provide
a flag with the same name as used by `git merge` to allow this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  5 +++++
 builtin/merge-tree.c             |  7 ++++++-
 t/t4301-merge-tree-write-tree.sh | 24 +++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index ada4595b4fc..3f566477dcb 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -69,6 +69,11 @@ OPTIONS
 	default is to include these messages if there are merge
 	conflicts, and to omit them otherwise.
 
+--allow-unrelated-histories::
+	merge-tree will by default error out if the two branches specified
+	share no common history.  This flag can be given to override that
+	check and make the merge proceed anyway.
+
 OUTPUT
 ------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 825255667b1..911504ad694 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -399,6 +399,7 @@ enum mode {
 
 struct merge_tree_options {
 	int mode;
+	int allow_unrelated_histories;
 	int show_messages;
 	int name_only;
 };
@@ -436,7 +437,7 @@ static int real_merge(struct merge_tree_options *o,
 	 * merge_incore_recursive in merge-ort.h
 	 */
 	common = get_merge_bases(parent1, parent2);
-	if (!common)
+	if (!common && !o->allow_unrelated_histories)
 		die(_("refusing to merge unrelated histories"));
 	for (j = common; j; j = j->next)
 		commit_list_insert(j->item, &merge_bases);
@@ -502,6 +503,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.name_only,
 			   N_("list filenames without modes/oids/stages"),
 			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "allow-unrelated-histories",
+			   &o.allow_unrelated_histories,
+			   N_("allow merging unrelated histories"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index fe476ed1bcc..5cb546083d7 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -44,7 +44,13 @@ test_expect_success setup '
 	git checkout side3 &&
 	git mv numbers sequence &&
 	test_tick &&
-	git commit -m rename-numbers
+	git commit -m rename-numbers &&
+
+	git switch --orphan unrelated &&
+	>something-else &&
+	git add something-else &&
+	test_tick &&
+	git commit -m first-commit
 '
 
 test_expect_success 'Clean merge' '
@@ -213,4 +219,20 @@ test_expect_success 'NUL terminated conflicted file "lines"' '
 	test_cmp expect actual
 '
 
+test_expect_success 'error out by default for unrelated histories' '
+	test_expect_code 128 git merge-tree --write-tree side1 unrelated 2>error &&
+
+	grep "refusing to merge unrelated histories" error
+'
+
+test_expect_success 'can override merge of unrelated histories' '
+	git merge-tree --write-tree --allow-unrelated-histories side1 unrelated >tree &&
+	TREE=$(cat tree) &&
+
+	git rev-parse side1:numbers side1:greeting side1:whatever unrelated:something-else >expect &&
+	git rev-parse $TREE:numbers $TREE:greeting $TREE:whatever $TREE:something-else >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

