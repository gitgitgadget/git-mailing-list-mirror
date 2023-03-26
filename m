Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE2C77B60
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCZWpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCZWpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:45:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6AE5B8A
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s13so4018848wmr.4
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679870747;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ip7CywczPhNvVMaFViCmVOAya2ruWqCPYxdnY7WPTg=;
        b=YDOGwYVgI3GyKe0G1xMVTJJRr8uUBRf1fuWHXdrCDYtMkObiDEFTtvg5G5Z4XJDUkI
         kZp1Y0DeI5hJu7GTwSYRJeNxVR+5ZwEqcdD6P4X+BfwdW3pOPsa7REzcuqfD2MDdrLl5
         eVBgkCrz0JuCh429i0pXsMAnhwb0ZNOg40XILVSLyntgGBvdeczxnoAx9YkeEaUb6Dn6
         diwNQ9pCaZk6vtinmuC+T9umxSOOIwy5lzw3Kk6fhWKyiH9cdhDe9V4Tm6tDCT3A1cJw
         v7/+LWWEMjbPUAJMveigQfDCG27m0uCunIOYPiJK3sZL2LIgw6+4brDecGR8L0sMPOza
         1yCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679870747;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ip7CywczPhNvVMaFViCmVOAya2ruWqCPYxdnY7WPTg=;
        b=jgCqTyo2dqhPv3hcquinYOCHo+WCD8+vuRxqKTdfnw2NTFce272mDN6JNrBJzMGmZ3
         ZTYqSnJX8hj4wk3ynpT53Ya8NqQuYMCJMnBFs3JGi9r6GApTi+lLZ6j06sshHcV1qdJa
         3mmlCEICxXcgbC/jg6r2qEdOd/a4OEQteLsHzAb+JgfECl2s6UcYUV3x/1XKdMp4TrJE
         yqEknB7RKDdc0qMxgWk+C5ioeYDbK9dHNYA0+2rgRqlm/Evu3gOO6SwD2aGRZHErMhnF
         HVbnBxGvXWfYQnbmeKj0poZXHyJt6zAx6KsG2tFDaaSQdSH4qBmnUEQq1A2Z3KhsiffN
         QFkg==
X-Gm-Message-State: AO0yUKWdR28QSGrfsDleu7283suVySzqaLlarRM0oiQVwfeXJgOKJT3I
        IaKvZvjHcxdOcUO267GTNEFW7Q9V50Q=
X-Google-Smtp-Source: AK7set8F7S66DFVmnL+XCXaclL7h6UvYb2W4yNLK3SnPUKC1XzOei0JgodKhg8J/11dTdD/INlsurw==
X-Received: by 2002:a05:600c:5251:b0:3ee:9652:932 with SMTP id fc17-20020a05600c525100b003ee96520932mr9216029wmb.12.1679870746599;
        Sun, 26 Mar 2023 15:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b003ef7058ea02sm95006wmg.29.2023.03.26.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 15:45:46 -0700 (PDT)
Message-Id: <8cc075f63252206972880d0167b694ed86ec0311.1679870743.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
        <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Mar 2023 22:45:41 +0000
Subject: [PATCH v2 2/4] split-index; stop abusing the `base_oid` to strip the
 "link" extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a split-index is in effect, the `$GIT_DIR/index` file needs to
contain a "link" extension that contains all the information about the
split-index, including the information about the shared index.

However, in some cases Git needs to suppress writing that "link"
extension (i.e. to fall back to writing a full index) even if the
in-memory index structure _has_ a `split_index` configured. This is the
case e.g. when "too many not shared" index entries exist.

In such instances, the current code sets the `base_oid` field of said
`split_index` structure to all-zero to indicate that `do_write_index()`
should skip writing the "link" extension.

This can lead to problems later on, when the in-memory index is still
used to perform other operations and eventually wants to write a
split-index, detects the presence of the `split_index` and reuses that,
too (under the assumption that it has been initialized correctly and
still has a non-null `base_oid`).

Let's stop zeroing out the `base_oid` to indicate that the "link"
extension should not be written.

One might be tempted to simply call `discard_split_index()` instead,
under the assumption that Git decided to write a non-split index and
therefore the `split_index` structure might no longer be wanted.
However, that is not possible because that would release index entries
in `split_index->base` that are likely to still be in use. Therefore we
cannot do that.

The next best thing we _can_ do is to introduce a bit field to indicate
specifically which index extensions (not) to write. So that's what we do
here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c                 | 49 +++++++++++++++++++++++-------------
 t/t7527-builtin-fsmonitor.sh |  2 +-
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b09128b1884..7c9a0eeeac8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2868,6 +2868,16 @@ static int record_ieot(void)
 	return !git_config_get_index_threads(&val) && val != 1;
 }
 
+enum write_extensions {
+	WRITE_NO_EXTENSION =              0,
+	WRITE_SPLIT_INDEX_EXTENSION =     1<<0,
+	WRITE_CACHE_TREE_EXTENSION =      1<<1,
+	WRITE_RESOLVE_UNDO_EXTENSION =    1<<2,
+	WRITE_UNTRACKED_CACHE_EXTENSION = 1<<3,
+	WRITE_FSMONITOR_EXTENSION =       1<<4,
+};
+#define WRITE_ALL_EXTENSIONS ((enum write_extensions)-1)
+
 /*
  * On success, `tempfile` is closed. If it is the temporary file
  * of a `struct lock_file`, we will therefore effectively perform
@@ -2876,7 +2886,7 @@ static int record_ieot(void)
  * rely on it.
  */
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
-			  int strip_extensions, unsigned flags)
+			  enum write_extensions write_extensions, unsigned flags)
 {
 	uint64_t start = getnanotime();
 	struct hashfile *f;
@@ -3045,8 +3055,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
-	if (!strip_extensions && istate->split_index &&
-	    !is_null_oid(&istate->split_index->base_oid)) {
+	if (write_extensions & WRITE_SPLIT_INDEX_EXTENSION &&
+	    istate->split_index) {
 		struct strbuf sb = STRBUF_INIT;
 
 		if (istate->sparse_index)
@@ -3060,7 +3070,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && !drop_cache_tree && istate->cache_tree) {
+	if (write_extensions & WRITE_CACHE_TREE_EXTENSION &&
+	    !drop_cache_tree && istate->cache_tree) {
 		struct strbuf sb = STRBUF_INIT;
 
 		cache_tree_write(&sb, istate->cache_tree);
@@ -3070,7 +3081,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && istate->resolve_undo) {
+	if (write_extensions & WRITE_RESOLVE_UNDO_EXTENSION &&
+	    istate->resolve_undo) {
 		struct strbuf sb = STRBUF_INIT;
 
 		resolve_undo_write(&sb, istate->resolve_undo);
@@ -3081,7 +3093,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && istate->untracked) {
+	if (write_extensions & WRITE_UNTRACKED_CACHE_EXTENSION &&
+	    istate->untracked) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_untracked_extension(&sb, istate->untracked);
@@ -3092,7 +3105,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && istate->fsmonitor_last_update) {
+	if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
+	    istate->fsmonitor_last_update) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_fsmonitor_extension(&sb, istate);
@@ -3166,8 +3180,10 @@ static int commit_locked_index(struct lock_file *lk)
 		return commit_lock_file(lk);
 }
 
-static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
-				 unsigned flags)
+static int do_write_locked_index(struct index_state *istate,
+				 struct lock_file *lock,
+				 unsigned flags,
+				 enum write_extensions write_extensions)
 {
 	int ret;
 	int was_full = istate->sparse_index == INDEX_EXPANDED;
@@ -3185,7 +3201,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	 */
 	trace2_region_enter_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
-	ret = do_write_index(istate, lock->tempfile, 0, flags);
+	ret = do_write_index(istate, lock->tempfile, write_extensions, flags);
 	trace2_region_leave_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
 
@@ -3214,7 +3230,7 @@ static int write_split_index(struct index_state *istate,
 {
 	int ret;
 	prepare_to_write_split_index(istate);
-	ret = do_write_locked_index(istate, lock, flags);
+	ret = do_write_locked_index(istate, lock, flags, WRITE_ALL_EXTENSIONS);
 	finish_writing_split_index(istate);
 	return ret;
 }
@@ -3289,7 +3305,7 @@ static int write_shared_index(struct index_state *istate,
 
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
-	ret = do_write_index(si->base, *temp, 1, flags);
+	ret = do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags);
 	trace2_region_leave_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
 
@@ -3366,9 +3382,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if ((!si && !test_split_index_env) ||
 	    alternate_index_output ||
 	    (istate->cache_changed & ~EXTMASK)) {
-		if (si)
-			oidclr(&si->base_oid);
-		ret = do_write_locked_index(istate, lock, flags);
+		ret = do_write_locked_index(istate, lock, flags,
+					    ~WRITE_SPLIT_INDEX_EXTENSION);
 		goto out;
 	}
 
@@ -3394,8 +3409,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		/* Same initial permissions as the main .git/index file */
 		temp = mks_tempfile_sm(git_path("sharedindex_XXXXXX"), 0, 0666);
 		if (!temp) {
-			oidclr(&si->base_oid);
-			ret = do_write_locked_index(istate, lock, flags);
+			ret = do_write_locked_index(istate, lock, flags,
+						    ~WRITE_SPLIT_INDEX_EXTENSION);
 			goto out;
 		}
 		ret = write_shared_index(istate, &temp, flags);
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index cbafdd69602..9fab9a2ab38 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1003,7 +1003,7 @@ test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
 	egrep "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
 '
 
-test_expect_failure 'split-index and FSMonitor work well together' '
+test_expect_success 'split-index and FSMonitor work well together' '
 	git init split-index &&
 	test_when_finished "git -C \"$PWD/split-index\" \
 		fsmonitor--daemon stop" &&
-- 
gitgitgadget

