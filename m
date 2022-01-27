Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA8C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiA0VV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbiA0VV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:21:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBBFC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:21:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s18so7068467wrv.7
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/OK+M0ZZ8uIP71G80FzxGvf19S6MTTgsbfZVk5BXcRs=;
        b=iZPT7kNaLr61rrPesFzueiviBDYjxcYdLYlR3yvpGnQv4MX35ujqzZr8qT5R1ZNztR
         s+UR3sMcwCuu9cs6UMCV7g7lNXB6sOYDQnJ0O/Rtv93zMNN9l0qLRquWtCRLHTNWh9gy
         TJmABqZyxUao1//gN1puwHbhsyU5C51370mdWDUT9QdkBswI6zo6IqClZorVSxdis6jh
         orsKL6UzjuoxykFjnhXidjc1cFsjijugqpb4+zam+SuQo1qBh64T5zxAF89AtCN2n2M1
         AeQ4UoG6d12Ml6QvMWLPSkP17jyfKK9bHk01d7wLuWt0iIsKJgz7EzU06fhhGXfKnpMw
         MElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/OK+M0ZZ8uIP71G80FzxGvf19S6MTTgsbfZVk5BXcRs=;
        b=js3/RjZpm6iQ2hSwnXHjz+wMKRnJIAteCZ+XTlERjxDurxiCnY2Sa9KA6OSvHHtE/4
         bsyHgjumy03vbxt6jyThQxa0WaAyGZrK++mtW4LX15G8LE0ANeL9ZJfQV/Opnvz71TKt
         C08BtXMjfvP6HE2bTMGX34IX0IkMAJzRS55Lh30zbZmlGBqMYaXhMrnAF7GgS2Jn5JZm
         H/cZF1Nqd8pYD9dYkjJN56iSA2E7Wk5TmFPMJRY3C/qnULSjcMbihWir5W7hjNLFUl2q
         XjGm5VIEJCDrygvwWOVBMiDfS0f5sVa6gBD94MdD5RxU3Uqm6d3LzpYSnU/l9YyXVrs+
         2ooA==
X-Gm-Message-State: AOAM5320rAMiyol6h5TmxNgyQlDr6rqK94O93N8mN829yUE0JEMLJbRT
        fArfEcenTP8WhqJweB3BXNy+2Vu8ggA=
X-Google-Smtp-Source: ABdhPJzCDGyw3QAao/r/WhvLUuKqRH5n/3002n/KZQNSkLJAE8/5arHXpzYcFyygY0A2hibvN5eUoA==
X-Received: by 2002:a5d:6486:: with SMTP id o6mr4502069wri.636.1643318516591;
        Thu, 27 Jan 2022 13:21:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm341233wmj.12.2022.01.27.13.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:21:56 -0800 (PST)
Message-Id: <5bb598a055dd8121ad5c7228b11618b037029478.1643318514.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
        <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 21:21:52 +0000
Subject: [PATCH v4 1/3] completion: add sparse-checkout tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Add tests for missing/incorrect components of custom tab completion for
the sparse-checkout command. These tests specifically highlight the
following:

1. git sparse-checkout <TAB> results in an incomplete list of subcommands
(it is missing reapply and add).
2. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
both file names and directory names. While this is the correct behavior
for non-cone mode, cone mode sparse checkouts should complete only
directory names.

Although the first two of these tests currently fail, they will succeed
with the sparse-checkout modifications in git-completion.bash in the next
commit in this series.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 t/t9902-completion.sh | 75 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 518203fbe07..6004d854102 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1447,6 +1447,81 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	EOF
 '
 
+test_expect_failure 'sparse-checkout completes subcommands' '
+	test_completion "git sparse-checkout " <<-\EOF
+	list Z
+	init Z
+	set Z
+	add Z
+	reapply Z
+	disable Z
+	EOF
+'
+
+test_expect_failure 'cone mode sparse-checkout completes directory names' '
+	# set up sparse-checkout repo
+	git init sparse-checkout &&
+	(
+		cd sparse-checkout &&
+		mkdir -p folder1/0/1 folder2/0 folder3 &&
+		touch folder1/0/1/t.txt &&
+		touch folder2/0/t.txt &&
+		touch folder3/t.txt &&
+		git add . &&
+		git commit -am "Initial commit"
+	) &&
+
+	# initialize sparse-checkout definitions
+	git -C sparse-checkout sparse-checkout set --cone folder1/0 folder3 &&
+
+	# test tab completion
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set f" <<-\EOF
+		folder1
+		folder2
+		folder3
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set folder1/" <<-\EOF
+		folder1/0
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
+		folder1/0/1
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout/folder1 &&
+		test_completion "git sparse-checkout add 0" <<-\EOF
+		0
+		EOF
+	)
+'
+
+test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
+	# reset sparse-checkout repo to non-cone mode
+	git -C sparse-checkout sparse-checkout disable &&
+	git -C sparse-checkout sparse-checkout set &&
+
+	# test tab completion
+	(
+		cd sparse-checkout &&
+		# expected to be empty since we have not configured
+		# custom completion for non-cone mode
+		test_completion "git sparse-checkout set f" <<-\EOF
+
+		EOF
+	)
+'
+
 test_expect_success 'git switch - with -d, complete all references' '
 	test_completion "git switch -d " <<-\EOF
 	HEAD Z
-- 
gitgitgadget

