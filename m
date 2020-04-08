Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3ECC2BA1B
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F7C20769
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4/YCutv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgDHSwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:52:39 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37068 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgDHSwj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 14:52:39 -0400
Received: by mail-ed1-f52.google.com with SMTP id de14so10052906edb.4
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cia+4gb7ffoVaBHoYkVPOoDyC984MvqH9C1MlKZHssM=;
        b=J4/YCutv58Q5O/g8VvOXxWjUBSCC9za4JWt7mSRflLuWnZfmnsTXjx2O8ocxFJXJCM
         FjTu6G83Su99eh02y340OUBW0O6FZJl0DnjtmfMDUTAC7Ev0uTd9ReG4ufU/lRqE5jd1
         mESThdIkdqXl06kG4/9MZ+YvH3F0N/qDOIRiS0iBBwNCePUj+nls2e1qFhuj14GJvXKw
         FY+BToWK51bN8iuXIXzJCcWVE/19YnTubuHaq9UQgTJwKbx58pVQWlfOee4DERORCmJv
         K6Hb6a37SNA98Heq2evLz0rtALu9YiehJUzAFNbKACizFOrR6h6P82Q0I2ZhGjCp5flc
         U61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cia+4gb7ffoVaBHoYkVPOoDyC984MvqH9C1MlKZHssM=;
        b=G/3/sneP7dXYE55dHg/XuGrTSCLliLQ222m+MnqO5q3QiiFC8es1hCDILLbI7mV9mI
         lFcn7Otb/CddFCw6Q19E/IsOihwM+IvWXRlhdEXzS5tswhOHjO5VcTgLEkoBndjjEl2A
         /3fDE97x61CrNi2GR5uHUUOtQ1CdERNJpCFvmGdCM7gADtV39wnCmh4TMkp+todoZNbU
         17Tzbo4sfVAK0YclQR7kqUlJ0EtmKmNgRyWWDUnV3Txz5Ylr7E9VLX6NMOlenW3XsVWf
         pIyHxH157K7lYo9fRnQq+0YG5/jKedVphqDD3JryVg1wFxVKp752aBZgPaasYNah699Z
         qjXQ==
X-Gm-Message-State: AGi0Pua9F83s1FzK5IdUYCfxq6zA0FmdIKyQ25Q5jMvUAOSrE8lYZue7
        73h62F/D7zh7PCwYyTugj1ZKMGVL
X-Google-Smtp-Source: APiQypK2H1Vptt8tKiNcSYboz5nr4c160BUkN3cu/c8Mu0H5e5HTPqfSGlCB1F3G7ZturIVCOirDhQ==
X-Received: by 2002:a50:c850:: with SMTP id s16mr7980730edg.90.1586371956934;
        Wed, 08 Apr 2020 11:52:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm137183eds.55.2020.04.08.11.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:52:36 -0700 (PDT)
Message-Id: <91ad9a99629e8529a4fa82ce721a54e63b29bf92.1586371954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.602.git.1586371954.gitgitgadget@gmail.com>
References: <pull.602.git.1586371954.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 18:52:34 +0000
Subject: [PATCH 2/2] stash -p: (partially) fix bug concerning split hunks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When trying to stash part of the worktree changes by splitting a hunk
and then only partially accepting the split bits and pieces, the user
is presented with a rather cryptic error:

	error: patch failed: <file>:<line>
	error: test: patch does not apply
	Cannot remove worktree changes

and the command would fail to stash the desired parts of the worktree
changes (even if the `stash` ref was actually updated correctly).

We even have a test case demonstrating that failure, carrying it for
four years already.

The explanation: when splitting a hunk, the changed lines are no longer
separated by more than 3 lines (which is the amount of context lines
Git's diffs use by default), but less than that. So when staging only
part of the diff hunk for stashing, the resulting diff that we want to
apply to the worktree in reverse will contain those changes to be
dropped surrounded by three context lines, but since the diff is
relative to HEAD rather than to the worktree, these context lines will
not match.

Example time. Let's assume that the file README contains these lines:

	We
	the
	people

and the worktree added some lines so that it contains these lines
instead:

	We
	are
	the
	kind
	people

and the user tries to stash the line containing "are", then the command
will internally stage this line to a temporary index file and try to
revert the diff between HEAD and that index file. The diff hunk that
`git stash` tries to revert will look somewhat like this:

	@@ -1776,3 +1776,4
	 We
	+are
	 the
	 people

It is obvious, now, that the trailing context lines overlap with the
part of the original diff hunk that the user did *not* want to stash.

Keeping in mind that context lines in diffs serve the primary purpose of
finding the exact location when the diff does not apply precisely (but
when the exact line number in the file to be patched differs from the
line number indicated in the diff), we work around this by reducing the
amount of context lines: the diff was just generated.

Note: this is not a *full* fix for the issue. Just as demonstrated in
t3701's 'add -p works with pathological context lines' test case, there
are ambiguities in the diff format. It is very rare in practice, of
course, to encounter such repeated lines.

The full solution for such cases would be to replace the approach of
generating a diff from the stash and then applying it in reverse by
emulating `git revert` (i.e. doing a 3-way merge). However, in `git
stash -p` it would not apply to `HEAD` but instead to the worktree,
which makes this non-trivial to implement as long as we also maintain a
scripted version of `add -i`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c        | 2 +-
 t/t3904-stash-patch.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 6d586ef06df..a43a92ec743 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1041,7 +1041,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	}
 
 	cp_diff_tree.git_cmd = 1;
-	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "HEAD",
+	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
 			 oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
 		ret = -1;
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index ab7d7aa6de1..accfe3845c4 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -89,7 +89,7 @@ test_expect_success 'none of this moved HEAD' '
 	verify_saved_head
 '
 
-test_expect_failure 'stash -p with split hunk' '
+test_expect_success 'stash -p with split hunk' '
 	git reset --hard &&
 	cat >test <<-\EOF &&
 	aaa
-- 
gitgitgadget
