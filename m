Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06B5C77B6E
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCZWp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCZWpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:45:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB83059D3
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m2so6837119wrh.6
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679870746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8QhUNEFReiCSgkZDDHAbi0jGT1Xpb/cllleVu/3f1k=;
        b=RmarioEhfthl1oGAhk+iZHx+Gk72q0v9lvvx/gQQtoAHeWWFNMbAH9aqu1vaYUCAe2
         yaFy7+0HeF/wazjiHTzdDW1ykw66zvGVsMiH3iJoTna9kxnZRz/weyzOawrB/NH5+Fjo
         +N9+2iDomL9uWTkUUUoUQlbpSGUXVSvWWXyO3qYRcSHsQJvJ1fqA5LEMBLzJuw0XeMpT
         Miz+qThpRFAYtLIEzL+Xaq/fAPpSccN/SocZikrOYBXLhnHer7Kf4E2WYTCC97Dz+cLU
         NYA00SJqcMQ62lgYF+l4QUPLggMoQQL56WXWqzGxgg+GUJp+UgYBgiPcfwyPQU6nO0fi
         blyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679870746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8QhUNEFReiCSgkZDDHAbi0jGT1Xpb/cllleVu/3f1k=;
        b=2wJvHXOP+qNSgDecVOncNXf6wriZH17LyH8Gtsu/JTtY0xrmagVWyDQXGIs/gYJsyf
         0L66h6xDP3nAmRaLVItP8mdY3ZuTLRUKZZdiMp7BJs4JZliBgLZvLU6UOHPDbjJe6Rkn
         viPs4gFLnwXjpIvOg4GxA7uxERE7kgxwN+0OwuNEkL5CcYKAZQNGayl8SfL2UUdUQhBR
         ly/9bMKfsVMhnN1qM429wtWAqDqDQUhxka/1kfkipOIua8geCNKeSL2d8ZkBZJKjXvha
         nVbrMoC4oGAIjRhT+JkHmp2Rcr+Xo4Wz3LqNZO77wIm9l+Bge5WSrKfYsOr4aQtRh09S
         4IDA==
X-Gm-Message-State: AAQBX9drUm2QOmyLpeMQpoAsXmFN1YG76QSb9RAJ1ckidBchcPLBBu0g
        L3Tb/WOqVom/HbkSxGyzv8vjGzP0eCE=
X-Google-Smtp-Source: AKy350a2Fvqv1gKKvnDOWcDi4Si3y/EOVnQSykpE4IFabHUTKtEXMAxWvUrhCgWxAeqJ9dByh75Xzw==
X-Received: by 2002:adf:f18c:0:b0:2c5:5687:5ed5 with SMTP id h12-20020adff18c000000b002c556875ed5mr8004475wro.18.1679870745952;
        Sun, 26 Mar 2023 15:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d4a08000000b002c3f03d8851sm23389249wrq.16.2023.03.26.15.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 15:45:45 -0700 (PDT)
Message-Id: <c025fccbdde1a4df11ba36552f86369ed74d37d2.1679870743.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
        <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Mar 2023 22:45:40 +0000
Subject: [PATCH v2 1/4] split-index & fsmonitor: demonstrate a bug
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

This commit adds a new test case that demonstrates a bug in the
split-index code that is triggered under certain circumstances when the
FSMonitor is enabled, and its symptom manifests in the form of one of
the following error messages:

    BUG: fsmonitor.c:20: fsmonitor_dirty has more entries than the index (2 > 1)

    BUG: unpack-trees.c:776: pos <n> doesn't point to the first entry of <dir>/ in index

    error: invalid path ''
    error: The following untracked working tree files would be overwritten by reset:
            initial.t

Which of these error messages appears depends on timing-dependent
conditions.

Technically the root cause lies with a bug in the split-index code that
has nothing to do with FSMonitor, but for the sake of this new test case
it was the easiest way to trigger the bug.

The bug is this: Under specific conditions, Git needs to skip writing
the "link" extension (which is the index extension containing the
information pertaining to the split-index). To do that, the `base_oid`
attribute of the `split_index` structure in the in-memory index is
zeroed out, and `do_write_index()` specifically checks for a "null"
`base_oid` to understand that the "link" extension should not be
written. However, this violates the consistency of the in-memory index
structure, but that does not cause problems in most cases because the
process exits without using the in-memory index structure anymore,
anyway.

But: _When_ the in-memory index is still used (which is the case e.g. in
`git rebase`), subsequent writes of `the_index` are at risk of writing
out a bogus index file, one that _should_ have a "link" extension but
does not. In many cases, the `SPLIT_INDEX_ORDERED` flag _happens_ to be
set for subsequent writes, forcing the shared index to be written, which
re-initializes `base_oid` to a non-bogus state, and all is good.

When it is _not_ set, however, all kinds of mayhem ensue, resulting in
above-mentioned error messages, and often enough putting worktrees in a
totally broken state where the only recourse is to manually delete the
`index` and the `index.lock` files and then call `git reset` manually.
Not something to ask users to do.

The reason why it is comparatively easy to trigger the bug with
FSMonitor is that there is _another_ bug in the FSMonitor code:
`mark_fsmonitor_valid()` sets `cache_changed` to 1, i.e. treating that
variable as a Boolean. But it is a bit field, and 1 happens to be the
`SOMETHING_CHANGED` bit that forces the "link" extension to be skipped
when writing the index, among other things.

"Comparatively easy" is a relative term in this context, for sure. The
essence of how the new test case triggers the bug is as following:

1. The `git rebase` invocation will first reset the worktree to
   a commit that contains only the `one.t` file, and then execute a
   rebase script that starts with the following commands (commit hashes
   skipped):

   label onto

   reset initial
   pick two
   label two

   reset two
   pick three
   [...]

2. Before executing the `label` command, a split index is written, as
   well as the shared index.

3. The `reset initial` command in the rebase script writes out a new
   split index but skips writing the shared index, as intended.

4. The `pick two` command updates the worktree and refreshes the index,
   marking the `two.t` entry as valid via the FSMonitor, which sets the
   `SOMETHING_CHANGED` bit in `cache_changed`, which in turn causes the
   `base_oid` attribute to be zeroed out and a full (non-split) index
   to be written (making sure _not_ to write the "link" extension).

5. Now, the `reset two` command will leave the worktree alone, but
   still write out a new split index, not writing the shared index
   (because `base_oid` is still zeroed out, and there is no index entry
   update requiring it to be written, either).

6. When it is turn to run `pick three`, the index is read, but it is
   too short: It only contains a single entry when there should be two,
   because the "link" extension is missing from the written-out index
   file.

There are three bugs at play, actually, which will be fixed over the
course of the next commits:

- The `base_oid` attribute should not be zeroed out to indicate when
  the "link" extension should not be written, as it puts the in-memory
  index structure into an inconsistent state.

- The FSMonitor should not overwrite bits in `cache_changed`.

- The `unpack_trees()` function tries to reuse the `split_index`
  structure from the source index, if any, but does not propagate the
  `SPLIT_INDEX_ORDERED` flag.

While a fix for the second bug would let this test case pass, there are
other conditions where the `SOMETHING_CHANGED` bit is set. Therefore,
the bug that most crucially needs to be fixed is the first one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7527-builtin-fsmonitor.sh | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index d419085379c..cbafdd69602 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1003,4 +1003,41 @@ test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
 	egrep "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
 '
 
+test_expect_failure 'split-index and FSMonitor work well together' '
+	git init split-index &&
+	test_when_finished "git -C \"$PWD/split-index\" \
+		fsmonitor--daemon stop" &&
+	(
+		cd split-index &&
+		git config core.splitIndex true &&
+		# force split-index in most cases
+		git config splitIndex.maxPercentChange 99 &&
+		git config core.fsmonitor true &&
+
+		# Create the following commit topology:
+		#
+		# *   merge three
+		# |\
+		# | * three
+		# * | merge two
+		# |\|
+		# | * two
+		# * | one
+		# |/
+		# * 5a5efd7 initial
+
+		test_commit initial &&
+		test_commit two &&
+		test_commit three &&
+		git reset --hard initial &&
+		test_commit one &&
+		test_tick &&
+		git merge two &&
+		test_tick &&
+		git merge three &&
+
+		git rebase --force-rebase -r one
+	)
+'
+
 test_done
-- 
gitgitgadget

