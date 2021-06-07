Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5684C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD29561208
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhFGMhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:37:17 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:47045 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbhFGMhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:37:14 -0400
Received: by mail-wr1-f50.google.com with SMTP id a11so15541402wrt.13
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HVK7x9ytblDj8iy4lmiMNtwNDpdpLC/uAkky1UzqoLw=;
        b=aSInP3ilRr1tDZqtgIQMi80zEIcR85QGbYpblwuc6Yh8LnCzeY17dd1e9Z9KnvE1Rg
         l5bvX+0PIwUOM1AI8bQRHTW7F0e7vVZUrpG0/JAFvbq6eS47TkbtCLYMMeKxNGIU7lXr
         EtA4DcvbhHPeo94yWcYAnFdvGEdrR7qMZvGbq8o2W5HsYke61U08HyWZMPnuaiy9fXDJ
         GjckFJMHXbi3ypZf6GaNiDjl3D4IL5TAiN4FVoxNvghoOE9k988TSy0h86KOgjaCdRtn
         DqXc9A+VCGPT/iFJhoNSjqZYyhxet2xBpHiV2X+q3+plJnRA1fkJZvKq569Dx4B6ojka
         R4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HVK7x9ytblDj8iy4lmiMNtwNDpdpLC/uAkky1UzqoLw=;
        b=PE2QcDebtbJIGfy6lzUI33pZso1wRCrCUzXFkd8egP5iwp7S8UMKCeO7RmAMp3ixZw
         GL9TeD4G65jx96TLwdnaZgBikO6+8RRqhmON9Vs9IxiKL/dyGSfqz/VkotJpQ5AM7eDm
         kqyAWx9mpMKWhJP8hZAm/b1jCDHopi/1F7RWIPrA9YTsE3dRlJmPuFkes4JNixwd8BmH
         eO11vU+dRmb5PiDgvf6OU9TEJ5HZpSCmpv/d5Ice4seNF3B7ozMvnIThh09XeXmUYK+9
         0NYmSDFSNT0p74c73USQG/A+PiIVrJ29T2CPr6kjDwGjbLLq6GvzmF06IAx6xp5qZs+B
         ouBg==
X-Gm-Message-State: AOAM533TEF611Pk0jdECDzS0sRX4Y1zy0r/sUM9iDHOQuKFVyQvPe90O
        tzdqKNmsKcSvAbvhZLyb2r+gA0GlegE=
X-Google-Smtp-Source: ABdhPJwSNLUTumNDVl9ssY08bFXrHLT8R3WYlSPYmLsGAoC5qJ3pbt6bt+g0nHSYZCAfJHtQccq8Ig==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr16509196wrf.130.1623069262434;
        Mon, 07 Jun 2021 05:34:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm15535437wrp.21.2021.06.07.05.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:22 -0700 (PDT)
Message-Id: <46ca150c35486f6d760f03a5e1f896ac9d4e93d7.1623069253.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:12 +0000
Subject: [PATCH v5 14/14] fsmonitor: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If we need to expand a sparse-index into a full one, then the FS Monitor
bitmap is going to be incorrect. Ensure that we start fresh at such an
event.

While this is currently a performance drawback, the eventual hope of the
sparse-index feature is that these expansions will be rare and hence we
will be able to keep the FS Monitor data accurate across multiple Git
commands.

These tests are added to demonstrate that the behavior is the same
across a full index and a sparse index, but also that file modifications
to a tracked directory outside of the sparse cone will trigger
ensure_full_index().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c              |  7 ++++++
 t/t7519-status-fsmonitor.sh | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index b2b3fbd75050..32ba0d17ef7c 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -195,6 +195,10 @@ int convert_to_sparse(struct index_state *istate)
 	cache_tree_free(&istate->cache_tree);
 	cache_tree_update(istate, 0);
 
+	istate->fsmonitor_has_run_once = 0;
+	FREE_AND_NULL(istate->fsmonitor_dirty);
+	FREE_AND_NULL(istate->fsmonitor_last_update);
+
 	istate->sparse_index = 1;
 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
 	return 0;
@@ -291,6 +295,9 @@ void ensure_full_index(struct index_state *istate)
 	istate->cache = full->cache;
 	istate->cache_nr = full->cache_nr;
 	istate->cache_alloc = full->cache_alloc;
+	istate->fsmonitor_has_run_once = 0;
+	FREE_AND_NULL(istate->fsmonitor_dirty);
+	FREE_AND_NULL(istate->fsmonitor_last_update);
 
 	strbuf_release(&base);
 	free(full);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 45d025f96010..f70fe961902e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -73,6 +73,7 @@ test_expect_success 'setup' '
 	expect*
 	actual*
 	marker*
+	trace2*
 	EOF
 '
 
@@ -383,4 +384,51 @@ test_expect_success 'status succeeds after staging/unstaging' '
 	)
 '
 
+# Usage:
+# check_sparse_index_behavior [!]
+# If "!" is supplied, then we verify that we do not call ensure_full_index
+# during a call to 'git status'. Otherwise, we verify that we _do_ call it.
+check_sparse_index_behavior () {
+	git status --porcelain=v2 >expect &&
+	git sparse-checkout init --cone --sparse-index &&
+	git sparse-checkout set dir1 dir2 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git status --porcelain=v2 >actual &&
+	test_region $1 index ensure_full_index trace2.txt &&
+	test_cmp expect actual &&
+	rm trace2.txt &&
+	git sparse-checkout disable
+}
+
+test_expect_success 'status succeeds with sparse index' '
+	git reset --hard &&
+
+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
+	check_sparse_index_behavior ! &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+	EOF
+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	check_sparse_index_behavior ! &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1/modified\0"
+	EOF
+	check_sparse_index_behavior ! &&
+
+	cp -r dir1 dir1a &&
+	git add dir1a &&
+	git commit -m "add dir1a" &&
+
+	# This one modifies outside the sparse-checkout definition
+	# and hence we expect to expand the sparse-index.
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1a/modified\0"
+	EOF
+	check_sparse_index_behavior
+'
+
 test_done
-- 
gitgitgadget
