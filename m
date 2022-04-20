Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AE0C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382190AbiDTUrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382189AbiDTUqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE34551A
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso4526124wml.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CHXUh21TwGifOMZAMmF5DZKmuMch+8bTNMzfHHNtpjM=;
        b=ktqETLvEYPHqjEvoVyqoWEUYc/MLXn/figIDxuzUmSm+XkjKSJFWVN94YwG4NELtyi
         Rerssg/WgeNYGFwlx81NhhMyXYKd+FvjHwII9obwD3E62M8uMpD9jeeEVnZDAyxSfV/r
         l1OiILO5/aZRPihHRsOhntRzP2sjFWEYV+g1LVvLIk5pJ3gQmMga20oty86NZO/EAiRg
         X8QhBJLK38lgvJY54NTkLB0Kv18j6bRgXw2J9SmHTXFvRR8fUpuO4MD64L1JY3XruV/5
         +Iihg3r9aefQHHRnKj4H26be5Ca9jGOjIeGNPcAYhgwrOdv9nxSW20tYyBxoHZBXzLOy
         LDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CHXUh21TwGifOMZAMmF5DZKmuMch+8bTNMzfHHNtpjM=;
        b=m5j8xVGfkNiBewn89Zv0lyW6QO6LHUGm78SvVKo3kvQjo1q+dMnpJ76JE3ZcmWs8b3
         bGYEzhlmFYSBtg5CGarLAfdz+RwHSx5nqxhBgj4d9A0ztzthU3JyLR+u792IhInfqIlM
         arJKhpNwpz20QYTb88Q8R40E7J0Ha6WJceOKrF4W3NoMDPwxFNM3Tnm8Tv8SNqI+u5yF
         YkRKjOtVjQ9hEBSCX5XcZScOojfPNj/AvqkqiXabPVPewFmY47i4QUbHo2r9/UUNx5Ev
         QLLH3DEYs3Eb817larMgCzK1nzqf3EI0MxgdIk9rtI9HvgC9X/BQAPVcv9FmMe7f5NmH
         KPcw==
X-Gm-Message-State: AOAM532cpwUO6dDp4CPAuQBtuEwUeOYVaDID89m+mVzWbGtQ9sVGqd88
        buIncfwyoJRhsGN2I04P/+j6jwRlBv8=
X-Google-Smtp-Source: ABdhPJy0EQhtuZ57DKS7Ae4M9MzkzqAFCeEyXUG95mcAY3+En/oh8uaYs6G309FgOrx7N1ZTUxY/jg==
X-Received: by 2002:a7b:c0c8:0:b0:392:ad9a:5d91 with SMTP id s8-20020a7bc0c8000000b00392ad9a5d91mr3531472wmh.37.1650487430302;
        Wed, 20 Apr 2022 13:43:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c4e4100b00392910b276esm345254wmq.9.2022.04.20.13.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:49 -0700 (PDT)
Message-Id: <5db241f7d2f654d46d4858ce9e9413032705abf3.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:13 +0000
Subject: [PATCH v5 23/28] fsmonitor: never set CE_FSMONITOR_VALID on
 submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Never set CE_FSMONITOR_VALID on the cache-entry of submodule
directories.

During a client command like 'git status', we may need to recurse
into each submodule to compute a status summary for the submodule.
Since the purpose of the ce_flag is to let Git avoid scanning a
cache-entry, setting the flag causes the recursive call to be
avoided and we report incorrect (no status) for the submodule.

We created an OS watch on the root directory of our working
directory and we receive events for everything in the cone
under it.  When submodules are present inside our working
directory, we receive events for both our repo (the super) and
any subs within it.  Since our index doesn't have any information
for items within the submodules, we can't use those events.

We could try to truncate the paths of those events back to the
submodule boundary and mark the GITLINK as dirty, but that
feels expensive since we would have to prefix compare every FS
event that we receive against a list of submodule roots.  And
it still wouldn't be sufficient to correctly report status on
the submodule, since we don't have any space in the cache-entry
to cache the submodule's status (the 'SCMU' bits in porcelain
V2 speak).  That is, the CE_FSMONITOR_VALID bit just says that
we don't need to scan/inspect it because we already know the
answer -- it doesn't say that the item is clean -- and we
don't have space in the cache-entry to store those answers.
So we should always do the recursive scan.

Therefore, we should never set the flag on GITLINK cache-entries.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c                  |   2 +
 fsmonitor.h                  |  11 ++++
 t/t7527-builtin-fsmonitor.sh | 111 +++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/fsmonitor.c b/fsmonitor.c
index e1229c289cf..57d6a483bee 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -580,6 +580,8 @@ void tweak_fsmonitor(struct index_state *istate)
 		if (fsmonitor_enabled) {
 			/* Mark all entries valid */
 			for (i = 0; i < istate->cache_nr; i++) {
+				if (S_ISGITLINK(istate->cache[i]->ce_mode))
+					continue;
 				istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
 			}
 
diff --git a/fsmonitor.h b/fsmonitor.h
index 3f41f653691..edf7ce5203b 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -68,6 +68,15 @@ static inline int is_fsmonitor_refreshed(const struct index_state *istate)
  * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
  * called any time the cache entry has been updated to reflect the
  * current state of the file on disk.
+ *
+ * However, never mark submodules as valid.  When commands like "git
+ * status" run they might need to recurse into the submodule (using a
+ * child process) to get a summary of the submodule state.  We don't
+ * have (and don't want to create) the facility to translate every
+ * FS event that we receive and that happens to be deep inside of a
+ * submodule back to the submodule root, so we cannot correctly keep
+ * track of this bit on the gitlink directory.  Therefore, we never
+ * set it on submodules.
  */
 static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
 {
@@ -75,6 +84,8 @@ static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
 
 	if (fsm_mode > FSMONITOR_MODE_DISABLED &&
 	    !(ce->ce_flags & CE_FSMONITOR_VALID)) {
+		if (S_ISGITLINK(ce->ce_mode))
+			return;
 		istate->cache_changed = 1;
 		ce->ce_flags |= CE_FSMONITOR_VALID;
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index d0e681d008f..1cf0ffa5676 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -721,4 +721,115 @@ do
 	'
 done
 
+# Test fsmonitor interaction with submodules.
+#
+# If we start the daemon in the super, it will see FS events for
+# everything in the working directory cone and this includes any
+# files/directories contained *within* the submodules.
+#
+# A `git status` at top level will get events for items within the
+# submodule and ignore them, since they aren't named in the index
+# of the super repo.  This makes the fsmonitor response a little
+# noisy, but it doesn't alter the correctness of the state of the
+# super-proper.
+#
+# When we have submodules, `git status` normally does a recursive
+# status on each of the submodules and adds a summary row for any
+# dirty submodules.  (See the "S..." bits in porcelain V2 output.)
+#
+# It is therefore important that the top level status not be tricked
+# by the FSMonitor response to skip those recursive calls.  That is,
+# even if FSMonitor says that the mtime of the submodule directory
+# hasn't changed and it could be implicitly marked valid, we must
+# not take that shortcut.  We need to force the recusion into the
+# submodule so that we get a summary of the status *within* the
+# submodule.
+
+create_super () {
+	super=$1 &&
+
+	git init "${super}" &&
+	echo x >${super}/file_1 &&
+	echo y >${super}/file_2 &&
+	echo z >${super}/file_3 &&
+	mkdir ${super}/dir_1 &&
+	echo a >${super}/dir_1/file_11 &&
+	echo b >${super}/dir_1/file_12 &&
+	mkdir ${super}/dir_1/dir_2 &&
+	echo a >${super}/dir_1/dir_2/file_21 &&
+	echo b >${super}/dir_1/dir_2/file_22 &&
+	git -C ${super} add . &&
+	git -C ${super} commit -m "initial ${super} commit"
+}
+
+create_sub () {
+	sub=$1 &&
+
+	git init "${sub}" &&
+	echo x >${sub}/file_x &&
+	echo y >${sub}/file_y &&
+	echo z >${sub}/file_z &&
+	mkdir ${sub}/dir_x &&
+	echo a >${sub}/dir_x/file_a &&
+	echo b >${sub}/dir_x/file_b &&
+	mkdir ${sub}/dir_x/dir_y &&
+	echo a >${sub}/dir_x/dir_y/file_a &&
+	echo b >${sub}/dir_x/dir_y/file_b &&
+	git -C ${sub} add . &&
+	git -C ${sub} commit -m "initial ${sub} commit"
+}
+
+my_match_and_clean () {
+	git -C super --no-optional-locks status --porcelain=v2 >actual.with &&
+	git -C super --no-optional-locks -c core.fsmonitor=false \
+		status --porcelain=v2 >actual.without &&
+	test_cmp actual.with actual.without &&
+
+	git -C super/dir_1/dir_2/sub reset --hard &&
+	git -C super/dir_1/dir_2/sub clean -d -f
+}
+
+test_expect_success "Submodule always visited" '
+	test_when_finished "git -C super fsmonitor--daemon stop; \
+			    rm -rf super; \
+			    rm -rf sub" &&
+
+	create_super "super" &&
+	create_sub "sub" &&
+
+	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
+	git -C super commit -m "add sub" &&
+
+	start_daemon -C super &&
+	git -C super config core.fsmonitor true &&
+	git -C super update-index --fsmonitor &&
+	git -C super status &&
+
+	# Now run pairs of commands w/ and w/o FSMonitor while we make
+	# some dirt in the submodule and confirm matching output.
+
+	# Completely clean status.
+	my_match_and_clean &&
+
+	# .M S..U
+	echo z >super/dir_1/dir_2/sub/dir_x/dir_y/foobar_u &&
+	my_match_and_clean &&
+
+	# .M S.M.
+	echo z >super/dir_1/dir_2/sub/dir_x/dir_y/foobar_m &&
+	git -C super/dir_1/dir_2/sub add . &&
+	my_match_and_clean &&
+
+	# .M S.M.
+	echo z >>super/dir_1/dir_2/sub/dir_x/dir_y/file_a &&
+	git -C super/dir_1/dir_2/sub add . &&
+	my_match_and_clean &&
+
+	# .M SC..
+	echo z >>super/dir_1/dir_2/sub/dir_x/dir_y/file_a &&
+	git -C super/dir_1/dir_2/sub add . &&
+	git -C super/dir_1/dir_2/sub commit -m "SC.." &&
+	my_match_and_clean
+'
+
 test_done
-- 
gitgitgadget

