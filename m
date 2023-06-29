Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1051FEB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 13:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjF2NXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjF2NXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 09:23:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23502707
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:23:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc0609e13so3725895e9.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688044995; x=1690636995;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkBMcYW9zMamuiGqnq/zDSAXpT7QhTVpOCEjUVh70DQ=;
        b=efU2xB1rm7M1HeiDn/A826CP+WkEVTSEXZRJLPP0ldVUc3XFvD1tEUZdVCg/62j3i9
         fLMrRAXN9mlX5u6zA901O3Y1AyvhfTgkj5TUaJO1mry5Fl3YwoNjRM8r84MDlJ+Km544
         cGx9zuN6n+5N4rClogz/dfsRe3fwVvmTX/ajK/acrx7qMvBNa7Z0RAAThIOXEJUDZzKr
         N/vDVCuGyQ4KFP8Ztzuevx+YU0NCWadfgoNAOQ3DoMOe+n/mSj8j6Lbdxx1Q2egnH6/W
         pp93DQ1j/+tWKqnlvlqIyvbMqjvTWzhqN/LgJ+zyOmddBxd3CYw3U6/1Zv9jNFRyp1W9
         G8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688044995; x=1690636995;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkBMcYW9zMamuiGqnq/zDSAXpT7QhTVpOCEjUVh70DQ=;
        b=VokAsNZJteYyA3ElgyrHyiHtjuCzn07kM122fxNohylciuTTBQ7AACM4OjIKRDWYUp
         Mxx0Onn+EMO8oIymAUpbCqwHb+34jakRDLBe1B0rZLBlbwLXOukMXyag4yg1PM+65Fn8
         Us/TFGV+ZjMfAtJzwFMpqNM9VGifsLmUppV1oTmvihUGlR5sjhNwN5C+bnjHe74NMZIy
         ecLD4qOYRMx93KJh8xXO5ALoIqz7y6QFbRNhC3TvOKLRD9dGKHppLdyfmViTTllNvheM
         h7ExA+qwyvPhfcuj7f78ietpkqzi7ph7AUysx6/Ui31CgJUry1YDBij+kjIwuVfbEbL6
         oWBQ==
X-Gm-Message-State: AC+VfDx2acc0usPgWjYSZlZtW6vQ7eNJ2Fp9t/k9DttwdDSqMMyFbFFm
        9xYeRva+iCsKEtHoHe7iq0ScCjnTB/o=
X-Google-Smtp-Source: ACHHUZ7ArvpFXaiDei7CjkkG/6mSd6p3eTmecljlAAMZjf+Dwd0TyRmFi0s66P6VA896WQgwldKoFw==
X-Received: by 2002:a1c:4b10:0:b0:3fb:7724:254b with SMTP id y16-20020a1c4b10000000b003fb7724254bmr7189924wma.9.1688044995034;
        Thu, 29 Jun 2023 06:23:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm5779643wmk.48.2023.06.29.06.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:23:14 -0700 (PDT)
Message-Id: <08c50b64e2a93300eed196505936e58ce8bb639b.1688044991.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1554.git.1688044991.gitgitgadget@gmail.com>
References: <pull.1554.git.1688044991.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jun 2023 13:23:10 +0000
Subject: [PATCH 3/3] commit -a -m: allow the top-level tree to become empty
 again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 03267e8656c (commit: discard partial cache before (re-)reading it,
2022-11-08), a memory leak was plugged by discarding any partial index
before re-reading it.

The problem with this memory leak fix is that it was based on an
incomplete understanding of the logic introduced in 7168624c353 (Do not
generate full commit log message if it is not going to be used,
2007-11-28).

That logic was introduced to add a shortcut when committing without
editing the commit message interactively. A part of that logic was to
ensure that the index was read into memory:

	if (!active_nr && read_cache() < 0)
		die(...)

Translation to English: If the index has not yet been read, read it, and
if that fails, error out.

That logic was incorrect, though: It used `!active_nr` as an indicator
that the index was not yet read. Usually this is not a problem because
in the vast majority of instances, the index contains at least one
entry.

And it was natural to do it this way because at the time that condition
was introduced, the `index_state` structure had no explicit flag to
indicate that it was initialized: This flag was only introduced in
913e0e99b6a (unpack_trees(): protect the handcrafted in-core index from
read_cache(), 2008-08-23), but that commit did not adjust the code path
where no index file was found and a new, pristine index was initialized.

Now, when the index does not contain any entry (which is quite
common in Git's test suite because it starts quite a many repositories
from scratch), subsequent calls to `do_read_index()` will mistake the
index not to be initialized, and read it again unnecessarily.

This is a problem because after initializing the empty index e.g. the
`cache_tree` in that index could have been initialized before a
subsequent call to `do_read_index()` wants to ensure an initialized
index. And if that subsequent call mistakes the index not to have been
initialized, it would lead to leaked memory.

The correct fix for that memory leak is to adjust the condition so that
it does not mistake `active_nr == 0` to mean that the index has not yet
been read.

Using the `initialized` flag instead, we avoid that mistake, and as a
bonus we can fix a bug at the same time that was introduced by the
memory leak fix: When deleting all tracked files and then asking `git
commit -a -m ...` to commit the result, Git would internally update the
index, then discard and re-read the index undoing the update, and fail
to commit anything.

This fixes https://github.com/git-for-windows/git/issues/4462

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c      |  7 ++-----
 t/t2200-add-update.sh | 11 +++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 65a5c0e29d5..4cf2baaf943 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -998,11 +998,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct object_id oid;
 		const char *parent = "HEAD";
 
-		if (!the_index.cache_nr) {
-			discard_index(&the_index);
-			if (repo_read_index(the_repository) < 0)
-				die(_("Cannot read index"));
-		}
+		if (!the_index.initialized && repo_read_index(the_repository) < 0)
+			die(_("Cannot read index"));
 
 		if (amend)
 			parent = "HEAD^1";
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index be394f1131a..c01492f33f8 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -197,4 +197,15 @@ test_expect_success '"add -u non-existent" should fail' '
 	! grep "non-existent" actual
 '
 
+test_expect_success '"commit -a" implies "add -u" if index becomes empty' '
+	git rm -rf \* &&
+	git commit -m clean-slate &&
+	test_commit file1 &&
+	rm file1.t &&
+	test_tick &&
+	git commit -a -m remove &&
+	git ls-tree HEAD: >out &&
+	test_must_be_empty out
+'
+
 test_done
-- 
gitgitgadget
