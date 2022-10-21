Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C24C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiJUJWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiJUJV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:21:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FECB25643E
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t4so1761823wmj.5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikwH0ZCyDmVigWp++0TStZaMRC3NsaFyNHVd7o2ShXc=;
        b=fLbdSuEiCVu9C1r9e/UOe+A7EJ19+rsHZ8qmJsJJhiKDvktpc9En65nugMain5l2vU
         ZzJdna+WX7PiVbmI2WvGm/ed+Rb5HHqgbR5+WRn9y1iUsu6alruP8jFSO/46G9cm/G1N
         WC3l3FscVLQZwcBvA11RYNNUQw1U5jE9cZb8mhlakoxkNzVBTIDx4HuTyjJisbyOjqjY
         ciFphgPwp5VmAb5Pgo5Bb4bJMJf9hV6FtzYlTgbBbLEV7vcTtBvwKGfqgQzWlfvJKKMu
         bmlLgPQsSn/CiIfQD5OabNcNmF20J7aysVgUaRoqMzK7NYaEdF/GRgKHlzy8iRhKpUE0
         hmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikwH0ZCyDmVigWp++0TStZaMRC3NsaFyNHVd7o2ShXc=;
        b=IixJTE7duhsVzpd16I/8GZvEe7MCayOFXWdbNA7pEUpMwJ1Y3Wv9rHD3t6Mm7b0miw
         2zuzPRoijwqXZ1dTlKXGiwEmROv9//n5etPaUVc1gqDDKxcdULcNK9GVCXfJC7qxLKuE
         GBTafn50TkZ38iMkVb2I3EDxwr9fQqOWJggYHeXOoig8xVfN4pyS7IBo92FLEcD51Gwa
         edB6OFtM0LkxGkeYR0EDEPAUFLXoUJ4YvD/hkersltjshH6JtlibbHImtt7i8j//SyHM
         /qa7+5R6MumXfJERkhjW313m0ZeSIkYEeXzuawufpw9+wFU0QquI7Gbvq5fZPBQcdCzr
         EghQ==
X-Gm-Message-State: ACrzQf01U+3+YaKuo3nrUnWAXNn1RMsZRp6j1QLUtlDkif4MWQRGUAbJ
        cigigRhlI6vgLfmeIhWtNNj2sPpX+eE=
X-Google-Smtp-Source: AMsMyM4pnGT9fnPIweYDCXULuc5w/f2s7ttMKlgkK99plt0eT2mX0cZ8D2db+ZLzLBrjRF3CO67qZA==
X-Received: by 2002:a05:600c:2f08:b0:3c6:befc:9778 with SMTP id r8-20020a05600c2f0800b003c6befc9778mr12086691wmn.101.1666344115219;
        Fri, 21 Oct 2022 02:21:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020adff452000000b0022584c82c80sm18332205wrp.19.2022.10.21.02.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:21:54 -0700 (PDT)
Message-Id: <17138d910f0019927f0e7686c626ab7ccc33be93.1666344108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 09:21:44 +0000
Subject: [PATCH v4 4/8] rebase --merge: fix reflog message after skipping
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

The reflog message for every pick after running "rebase --skip" looks
like

	rebase (skip) (pick): commit subject line

Fix this by not appending " (skip)" to the reflog action.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          |  2 --
 t/t3406-rebase-message.sh | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 414526f83a8..c1e68173b5f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1297,8 +1297,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 		options.action = "skip";
-		set_reflog_action(&options);
-
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 		ropts.flags = RESET_HEAD_HARD;
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 3ca2fbb0d59..8aa6a79acc1 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -163,6 +163,30 @@ test_reflog () {
 	# check there is only one new entry in the branch reflog
 	test_cmp_rev fast-forward@{1} X
 	'
+
+	test_expect_success "rebase $mode --skip reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --skip
+	) &&
+
+	git log -g --format=%gs -4 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): Q
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual
+	'
 }
 
 test_reflog --merge
-- 
gitgitgadget

