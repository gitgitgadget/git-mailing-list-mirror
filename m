Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6A9C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiDVWjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiDVWiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F7289FDB
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so6076687wms.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a9XvzN3uiiBJPizsWxmzbeud/J9nIlV4ajQeyaLJC8Q=;
        b=oKmho/m45QhZKspTEVbDIpEZNywRXwkv/3afxnms7sGOEUn2Ufyn7Gr8pmulsIFmia
         ICMTch922/jpFcevdOz+JMQ5GskV6CTFy9Pd975DA/ra7YRY8OjynoFGnNWGyqMAaAnc
         LNQkqyz825EPqhB5TaXvwYzIm57ee6LwkYg3ZBa4rzyTdvwAfowRhoKAp8qg2CgFWzgL
         pU4+4dNr/RN4YOnR0I/HV+uVOGu2MrSY0lBf0OJXOmHuCcodb6lt88fby5j01++cZciY
         32+44LRbL1Ub9fjv4Av2y3KXCnPYmn35hNglFb1lzPchmC9LDLD8ChXrx1HUz4S6Ftqe
         9voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a9XvzN3uiiBJPizsWxmzbeud/J9nIlV4ajQeyaLJC8Q=;
        b=4OCyJKdcFLP+RAjUsNjq402LRlIV7DXZHHlopmg2BaMY6qu+VGddH53Ewsz/FY4hRd
         T1VAwphD954gPMSNHKWyH+v3iog8Wrp4SbT5ReThHEL8vwp5qv4RnAZ3Whiq0XN3jgjE
         FTJ6pbSZSLEqbXaYsIiY6dC0KsWsfQZI+QFIQguKPVEPT04CzMxckUKF+uTenlLcDhDS
         zYPQISr0uqG3hfZvT7gbccFH80UgIM+1gZAke1Jf2p4MmcwbdWpM5RhvrRTHc4mjVJV3
         vFvBIR5ZjCQjp2PqFbuSq72pC8uImuTrTpCvSXf09ZmBlEIq3CJk60/ToYQMek2+RPsv
         OI9Q==
X-Gm-Message-State: AOAM533kc8NmPn3OtRgqFxUIpsrX0fJbd0ugZpRlMGgPTOdeRXJ00/dN
        bWJullOJTTFPFzTccBefx4UCS/z92kk=
X-Google-Smtp-Source: ABdhPJxHi3BihRqk6IMln7tHfVZGd98AOia7l4Ei9RYllPSuKgxJMjPbucL9E4UrI2jdtXGrehNrEA==
X-Received: by 2002:a05:600c:4e50:b0:392:8fe7:4700 with SMTP id e16-20020a05600c4e5000b003928fe74700mr15113427wmq.89.1650663020681;
        Fri, 22 Apr 2022 14:30:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020adfa394000000b0020ad1210f9dsm330053wrb.74.2022.04.22.14.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:20 -0700 (PDT)
Message-Id: <d0e25f6bac663e9ae4d63322f102378dd2ecba84.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:49 +0000
Subject: [PATCH v6 23/28] fsmonitor: never set CE_FSMONITOR_VALID on
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
index d0e681d008f..4c49ae5a684 100755
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
+	super="$1" &&
+
+	git init "$super" &&
+	echo x >"$super/file_1" &&
+	echo y >"$super/file_2" &&
+	echo z >"$super/file_3" &&
+	mkdir "$super/dir_1" &&
+	echo a >"$super/dir_1/file_11" &&
+	echo b >"$super/dir_1/file_12" &&
+	mkdir "$super/dir_1/dir_2" &&
+	echo a >"$super/dir_1/dir_2/file_21" &&
+	echo b >"$super/dir_1/dir_2/file_22" &&
+	git -C "$super" add . &&
+	git -C "$super" commit -m "initial $super commit"
+}
+
+create_sub () {
+	sub="$1" &&
+
+	git init "$sub" &&
+	echo x >"$sub/file_x" &&
+	echo y >"$sub/file_y" &&
+	echo z >"$sub/file_z" &&
+	mkdir "$sub/dir_x" &&
+	echo a >"$sub/dir_x/file_a" &&
+	echo b >"$sub/dir_x/file_b" &&
+	mkdir "$sub/dir_x/dir_y" &&
+	echo a >"$sub/dir_x/dir_y/file_a" &&
+	echo b >"$sub/dir_x/dir_y/file_b" &&
+	git -C "$sub" add . &&
+	git -C "$sub" commit -m "initial $sub commit"
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
+	create_super super &&
+	create_sub sub &&
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

