Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01352C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 13:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9498206ED
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 13:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdQXRD/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgAINai (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:30:38 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35408 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgAINai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 08:30:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so5626974edv.2
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 05:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=d+zrzkgKKbuhxjeIWQDUPN5tx7IQA3CGaoj2P95UFm0=;
        b=mdQXRD/2F+JHWU+hXac4Hmdh4RTOF4RzMR20YEn+M5vrrCPPRBvKfXd3Rol72Hop7D
         CiaEZX2sxAMYfMQ6fzgDGVn8x8pSLkhxhWnPOB+vJlSniPQgziLfraCaR4IQcVFSbEy1
         Sw34UN+Lb4lkK5i+jzu5yGwbAgAEq7/kgrukD2FKarVh7jSi3oU+R2K5Q6w/yC/tQuzw
         chftUoWWIX1xisXMBTasayF0d69LDCZuGl3r76aDIUmF37gVlCZ/sKmEMXP3yPpHnG3H
         6PlMZfrk+JzCSxmbH7ro81EDhJRikPmMRGZAS9nF55hllXz8E8wygeETaQwAzO9XeS1S
         Mq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d+zrzkgKKbuhxjeIWQDUPN5tx7IQA3CGaoj2P95UFm0=;
        b=V9wmOTzCPuMaQ6N8VDDtY8F/U+ABw9tc0BOy1vx+NdGuth6HeFQTLRbyA31quGPsz/
         xd+LegV21ZNd+xEZ64Y9cJxYYmDfZtRiAdXzDboXk6tfVvmSOYSOyCGc/9GED0ipGAq+
         DxiY+/Pynb12sNzRSXfLaPn5XLNqSASFU339xZ8ux2RLIIT1bNWOwT/+rbZpnZJFaCe/
         +kWzYjxzUom6NP4CfyuN8U/BmFiS70c0dZ8xQYPs93eMab52MgtO/q5wpOOombjvHt3C
         rdKB0wT9MnKQCNnXRGNLECsUQgCnHNrcIfVPQJoNzuHJ1O6NlFitkoUTDiZ5dg1YxoWr
         caXQ==
X-Gm-Message-State: APjAAAVUL3EIcDoJZy9ScZ/2YKoJFYug+wdngMMjazpjMhdEAEH4rrAe
        s01YzOPI1WkAgjqAHQApGGy0/hm7
X-Google-Smtp-Source: APXvYqxrYXqyuZ55j2e0mkacW2wpiksMLDHcXrg9wdEsIh2p+plzG/qRJOUQQ3UmcT9Cx30zwjrh1w==
X-Received: by 2002:a05:6402:221c:: with SMTP id cq28mr10972860edb.110.1578576635984;
        Thu, 09 Jan 2020 05:30:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm135455eds.32.2020.01.09.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 05:30:35 -0800 (PST)
Message-Id: <pull.690.git.git.1578576634678.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jan 2020 13:30:34 +0000
Subject: [PATCH] mingw: safeguard better against backslashes in file names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 224c7d70fa1 (mingw: only test index entries for backslashes, not tree
entries, 2019-12-31), we relaxed the check for backslashes in tree
entries to check only index entries.

However, the code change was incorrect: it was added to
`add_index_entry_with_check()`, not to `add_index_entry()`, so under
certain circumstances it was possible to side-step the protection.

Besides, the description of that commit purported that all index entries
would be checked when in fact they were only checked when being added to
the index (there are code paths that do not do that, constructing
"transient" index entries).

In any case, it was pointed out in one insightful review at
https://github.com/git-for-windows/git/pull/2437#issuecomment-566771835
that it would be a much better idea to teach `verify_path()` to perform
the check for a backslash. This is safer, even if it comes with two
notable drawbacks:

- `verify_path()` cannot say _what_ is wrong with the path, therefore
  the user will no longer be told that there was a backslash in the
  path, only that the path was invalid.

- The `git apply` command also calls the `verify_path()` function, and
  might have been able to handle Windows-style paths (i.e. with
  backslashes instead of forward slashes). This will no longer be
  possible unless the user (temporarily) sets `core.protectNTFS=false`.

Note that `git add <windows-path>` will _still_ work because
`normalize_path_copy_len()` will convert the backslashes to forward
slashes before hitting the code path that creates an index entry.

The clear advantage is that `verify_path()`'s purpose is to check the
validity of the file name, therefore we naturally tap into all the code
paths that need safeguarding, also implicitly into future code paths.

The benefits of that approach outweigh the downsides, so let's move the
check from `add_index_entry_with_check()` to `verify_path()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: safeguard better against backslashes in file names
    
    I investigated again, and I think that there are code paths involving 
    make_transient_cache_entry() that might be vulnerable again after my
    recent change in 224c7d70fa1 (mingw: only test index entries for
    backslashes, not tree entries, 2019-12-31).
    
    This version should help with keeping Git for Windows' users safe.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-690%2Fdscho%2Fonly-error-on-backslash-in-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-690/dscho/only-error-on-backslash-in-index-v1
Pull-Request: https://github.com/git/git/pull/690

 read-cache.c               | 12 ++++++------
 t/t7415-submodule-names.sh |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 737916ebd9..aa427c5c17 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -959,7 +959,7 @@ static int verify_dotfile(const char *rest, unsigned mode)
 
 int verify_path(const char *path, unsigned mode)
 {
-	char c;
+	char c = 0;
 
 	if (has_dos_drive_prefix(path))
 		return 0;
@@ -974,6 +974,7 @@ int verify_path(const char *path, unsigned mode)
 		if (is_dir_sep(c)) {
 inside:
 			if (protect_hfs) {
+
 				if (is_hfs_dotgit(path))
 					return 0;
 				if (S_ISLNK(mode)) {
@@ -982,6 +983,10 @@ int verify_path(const char *path, unsigned mode)
 				}
 			}
 			if (protect_ntfs) {
+#ifdef GIT_WINDOWS_NATIVE
+				if (c == '\\')
+					return 0;
+#endif
 				if (is_ntfs_dotgit(path))
 					return 0;
 				if (S_ISLNK(mode)) {
@@ -1278,11 +1283,6 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 	int new_only = option & ADD_CACHE_NEW_ONLY;
 
-#ifdef GIT_WINDOWS_NATIVE
-	if (protect_ntfs && strchr(ce->name, '\\'))
-		return error(_("filename in tree entry contains backslash: '%s'"), ce->name);
-#endif
-
 	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
 		cache_tree_invalidate_path(istate, ce->name);
 
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index 7ae0dc8ff4..f70368bc2e 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -209,7 +209,7 @@ test_expect_success MINGW 'prevent git~1 squatting on Windows' '
 		hash="$(echo x | git hash-object -w --stdin)" &&
 		test_must_fail git update-index --add \
 			--cacheinfo 160000,$rev,d\\a 2>err &&
-		test_i18ngrep backslash err &&
+		test_i18ngrep "Invalid path" err &&
 		git -c core.protectNTFS=false update-index --add \
 			--cacheinfo 100644,$modules,.gitmodules \
 			--cacheinfo 160000,$rev,c \

base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
-- 
gitgitgadget
