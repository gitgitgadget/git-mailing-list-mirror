Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0B34D3A7
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192919; cv=none; b=udGBWkFStTeSyXrK3GRDzD2ZL99S47Y6FHk6nKVeseVuFHShmfR0BwRWjzZokkN+NT2Xf4FfxZa6j52La7PyS7sB901zxAcUFAW/1z2hGqeARsNWUdMDOULKjNb4yAtiaGpGXVNFUPLCEfUMyuoWKF3WZlH7ARb2Qwu4h80hHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192919; c=relaxed/simple;
	bh=Jc0Qy3SgZR3XDEETE00LUHz/F83anXHH49NSh8vPum0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pl4Pv2p+aEmJ0rioI0Pje7LH7kitOycnsUYhn/r1OLhM3Pi/Q01fXEWNXibMvNdArxIrEARS5DxeaOme2XmgRPD8LobROAze9WeBc/D6kkoLpBSlxhc8dq7ti+1DMXv8hKYFVrl+XoO/UNKiJsdgUSGUMCQQflxpOOXy2Tf02us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBETyKgw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBETyKgw"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85a4ceb4c3dso471705485a.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 10:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762192916; x=1762797716; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NbDYAyUdhPbxddzegDCEqqEqXSwU5Mwx6Ru6eh6HIs=;
        b=XBETyKgw2bFhtP/Qz4IbdgNDhEz81IDS9QnNL+hK5CfWdRAK1AW9B2CRRqUk9fohrs
         C00WXI0SiW4dErsG/+BZjve31878yRHlEADujhySIBJA7t+Ddl2yzdcwA3qQsDSgu6/N
         ippOfNw/hd8kM73asW8hs+1O1RyZgkZ6VlfkGNtMCU9hningaVGyZqFhaTjdRJQD/rwP
         qVk0sETZ9kJvtlAIVcCmCmfc2JyqKYhNqm69y8UXHL8kD+gQ5aP6DfOlqowgMj7whsSg
         ILEvo6USXiK7DwMmfclNHlsSiKSkI6uSbQK8kO7LWQUddfs23mnj+gZTFWIY52admg6t
         zqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192916; x=1762797716;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NbDYAyUdhPbxddzegDCEqqEqXSwU5Mwx6Ru6eh6HIs=;
        b=HC8s5+ImsYewTv+trUyaUAvTDlLBzpcvHx/h4YsaGmtjJsFFLE75ETacrGiBIJPgzw
         dvcAxk5yuIva7JB+pClm/nLA14LQtvoH/Sb71jGEahmS+4U6/UGUETGLtlJ8e0tqLalA
         f7YCMsh9ebYd6HJH0RIzGGrBItHGuk3xc1KQK2+QoJPeTptzzthX++VqaRHVTAUOJlmh
         DhtQb/IxjGYbqLiwdOUyvXcpxnuB9Q2GYdz/9LgI5BML6hn3dTDs6Wy4mEPYEsD+WoJC
         ERTWp7E9HuRKnNYfbaUDLQc9b/DCPdeZqoXldFS5B4qoXkaJ5QjV6jE0/vnuT8HONvgf
         uEvQ==
X-Gm-Message-State: AOJu0YxmXqXD+V97O+LcsCDpfcbUPb1sD10iSkHkR/ZnjLnzxBONal1Y
	7Ew+p+93Z+aVjVTwd0aRHNohNrqbQBM7FzZPmNnm/hoHcFSzrAcAc0YWB7lnW99f
X-Gm-Gg: ASbGncswzRyZ4+2XIFcZNMxwm3VXbSdkPt4W9f+Y2qWnvbwVLHczaxCzAKy3rdMsxrg
	NxUjvrHCuN4D9FrBNAK6gr/XXoaV9u1gLXGoATmg7ZyiCJ/EQBCpHHClbTe+R4od42A75iDcGP6
	CMihRPSX0dvPPnDEDM4nq2mn32txVS/wmjRubmCAHD/WbakzpBd1lf9jI+qKUkgeAariMUuBgqr
	r4UpVCFsihnZIdaNhR0ixDlyVu/4WNz6nAchZo0fWQWpFS4p9HLjbqS3w/dnc0w+ciwDuKwQS7p
	JV+ghRezP6K0tHD4uldKosT3Aa1mI/BJKymac+XCZ2jY5HmiDWHv38hmfobfdzH3donfeKJ440Y
	RYIziG4YhyXE9Ptg4FD0UoSViPhG9LPI+v1L4Q+SMjigp404QOPS6QZiy8oGcNg9GGAICaBj4Fg
	UxeAM=
X-Google-Smtp-Source: AGHT+IErSANdr0NdxpDB29R/PMx1mHouV7UWklJ/vXikJE3Vf3nYysSSJEbRBYOxuKtpWvIuXeeE2Q==
X-Received: by 2002:a05:620a:2913:b0:8a5:7b51:f93 with SMTP id af79cd13be357-8ab9b598e6bmr1553462485a.68.1762192915486;
        Mon, 03 Nov 2025 10:01:55 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f51ecf93sm30033885a.3.2025.11.03.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:01:54 -0800 (PST)
Message-Id: <9095098ab22cea89d38d7d538b21e3cf8d834df0.1762192908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
References: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Nov 2025 18:01:48 +0000
Subject: [PATCH 3/3] merge-ort: fix failing merges in special corner case
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

At GitHub, we had a repository that was triggering
  git: merge-ort.c:3032: process_renames: Assertion `newinfo && !newinfo->merged.clean` failed.
during git replay.

This sounds similar to the somewhat recent f6ecb603ff8a (merge-ort: fix
directory rename on top of source of other rename/delete, 2025-08-06),
but the cause is different.  Unlike that case, there are no
rename-to-self situations arising in this case, and new to this case it
can only be triggered during a replay operation on the 2nd or later
commit being replayed, never on the first merge in the sequence.

To trigger, the repository needs:
  * an upstream which:
    * renames a file to a different directory, e.g.
        old/file -> new/file
    * leaves other files remaining in the original directory (so that
      e.g. "old/" still exists upstream even though file has been
      removed from it and placed elsewhere)
  * a topic branch being rebased where:
    * a commit in the sequence:
      * modifies old/file
    * a subsequent commit in the sequence being replayed:
      * does NOT touch *anything* under new/
      * does NOT touch old/file
      * DOES modify other paths under old/
      * does NOT have any relevant renames that we need to detect
        _anywhere_ elsewhere in the tree (meaning this interacts
        interestingly with both directory renames and cached renames)

In such a case, the assertion will trigger.  The fix turns out to be
surprisingly simple.  I have a very vague recollection that I actually
considered whether to add such an if-check years ago when I added the
very similar one for oldinfo in 1b6b902d95a5 (merge-ort:
process_renames() now needs more defensiveness, 2021-01-19), but I think
I couldn't figure out a possible way to trigger it and was worried at
the time that if I didn't know how to trigger it then I wasn't so sure
that simply skipping it was correct.  Waiting did give me a chance to
put more thorough tests and checks into place for the rename-to-self
cases a few months back, which I might not have found as easily
otherwise.  Anyway, put the check in place now and add a test that
demonstrates the fix.

Note that this bug, as demonstrated by the conditions listed above,
runs at the intersection of relevant renames, trivial directory
resolutions, and cached renames.  All three of those optimizations are
ones that unfortunately make the code (and testcases!) a bit more
complex, and threading all three makes it a bit more so.  However, the
testcase isn't crazy enough that I'd expect no one to ever hit it in
practice, and was confused why we didn't see it before.  After some
digging, I discovered that merge.directoryRenames=false is a workaround
to this bug, and GitHub used that setting until recently (it was a
"temporary" match-what-libgit2-does piece of code that lasted years
longer than intended).  Since the conditions I gave above for triggering
this bug rule out the possibility of there being directory renames, one
might assume that it shouldn't matter whether you try to detect such
renames if there aren't any.  However, due to commit a16e8efe5c2b
(merge-ort: fix merge.directoryRenames=false, 2025-03-13), the heavy
hammer used there means that merge.directoryRenames=false ALSO turns off
rename caching, which is critical to triggering the bug.  This becomes
a bit more than an aside since...

Re-reading that old commit, a16e8efe5c2b (merge-ort: fix
merge.directoryRenames=false, 2025-03-13), it appears that the solution
to this latest bug might have been at least a partial alternative
solution to that old commit.  And it may have been an improved
alternative (or at least help implement one), since it may be able to
avoid the heavy-handed disabling of rename cache.  That might be an
interesting future thing to investigate, but is not critical for the
current fix.  However, since I spent time digging it all up, at least
leave a small comment tweak breadcrumb to help some future reader
(myself or others) who wants to dig further to connect the dots a little
quicker.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                              | 29 ++++++++-
 t/t6429-merge-sequence-rename-caching.sh | 78 ++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 23b55c5b92..a1f3333e44 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2912,6 +2912,32 @@ static int process_renames(struct merge_options *opt,
 		if (!oldinfo || oldinfo->merged.clean)
 			continue;
 
+		/*
+		 * Rename caching from a previous commit might give us an
+		 * irrelevant rename for the current commit.
+		 *
+		 * Imagine:
+		 *     foo/A -> bar/A
+		 * was a cached rename for the upstream side from the
+		 * previous commit (without the directories being renamed),
+		 * but the next commit being replayed
+		 *     * does NOT add or delete files
+		 *     * does NOT have directory renames
+		 *     * does NOT modify any files under bar/
+		 *     * does NOT modify foo/A
+		 *     * DOES modify other files under foo/ (otherwise the
+		 *       !oldinfo check above would have already exited for
+		 *       us)
+		 * In such a case, our trivial directory resolution will
+		 * have already merged bar/, and our attempt to process
+		 * the cached
+		 *     foo/A -> bar/A
+		 * would be counterproductive, and lack the necessary
+		 * information anyway.  Skip such renames.
+		 */
+		if (!newinfo)
+			continue;
+
 		/*
 		 * diff_filepairs have copies of pathnames, thus we have to
 		 * use standard 'strcmp()' (negated) instead of '=='.
@@ -5118,7 +5144,8 @@ static void merge_check_renames_reusable(struct merge_options *opt,
 	 * optimization" comment near that case).
 	 *
 	 * This could be revisited in the future; see the commit message
-	 * where this comment was added for some possible pointers.
+	 * where this comment was added for some possible pointers, or the
+	 * later commit where this comment was added.
 	 */
 	if (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_NONE) {
 		renames->cached_pairs_valid_side = 0; /* neither side valid */
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index dcb734b10b..15dd2d94b7 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -768,4 +768,82 @@ test_expect_success 'avoid assuming we detected renames' '
 	)
 '
 
+#
+# In the following testcase:
+#   Base:     olddir/{valuesX_1, valuesY_1, valuesZ_1}
+#             other/content
+#   Upstream: rename olddir/valuesX_1 -> newdir/valuesX_2
+#   Topic_1:  modify olddir/valuesX_1 -> olddir/valuesX_3
+#   Topic_2:  modify olddir/valuesY,
+#             modify other/content
+#   Expected Pick1: olddir/{valuesY, valuesZ}, newdir/valuesX, other/content
+#   Expected Pick2: olddir/{valuesY, valuesZ}, newdir/valuesX, other/content
+#
+# This testcase presents no problems for git traditionally, but the fact that
+#    olddir/valuesX -> newdir/valuesX
+# gets cached after the first pick presents a problem for the second commit to
+# be replayed, because it appears to be an irrelevant rename, so the trivial
+# directory resolution will resolve newdir/ without recursing into it, giving
+# us no way to apply the cached rename to anything.
+#
+test_expect_success 'rename a file, use it on first pick, but irrelevant on second' '
+	git init rename_a_file_use_it_once_irrelevant_on_second &&
+	(
+		cd rename_a_file_use_it_once_irrelevant_on_second &&
+
+		mkdir olddir/ other/ &&
+		test_seq 3 8 >olddir/valuesX &&
+		test_seq 3 8 >olddir/valuesY &&
+		test_seq 3 8 >olddir/valuesZ &&
+		printf "%s\n" A B C D E F G >other/content &&
+		git add olddir other &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch upstream &&
+		test_seq 1 8 >olddir/valuesX &&
+		git add olddir &&
+		mkdir newdir &&
+		git mv olddir/valuesX newdir &&
+		git commit -m "Renamed (and modified) olddir/valuesX into newdir/" &&
+
+		git switch topic &&
+
+		test_seq 3 10 >olddir/valuesX &&
+		git add olddir &&
+		git commit -m A &&
+
+		test_seq 1 8 >olddir/valuesY &&
+		printf "%s\n" A B C D E F G H I >other/content &&
+		git add olddir/valuesY other &&
+		git commit -m B &&
+
+		#
+		# Actual testing; mostly we want to verify that we do not hit
+		#     git: merge-ort.c:3032: process_renames: Assertion `newinfo && !newinfo->merged.clean` failed.
+		#
+
+		git switch upstream &&
+		git config merge.directoryRenames true &&
+
+		git replay --onto HEAD upstream~1..topic >out &&
+
+		#
+		# ...but we may as well check that the replay gave us a reasonable result
+		#
+
+		git update-ref --stdin <out &&
+		git checkout topic &&
+
+		git ls-files >tracked &&
+		test_line_count = 4 tracked &&
+		test_path_is_file newdir/valuesX &&
+		test_path_is_file olddir/valuesY &&
+		test_path_is_file olddir/valuesZ &&
+		test_path_is_file other/content
+	)
+'
+
 test_done
-- 
gitgitgadget
