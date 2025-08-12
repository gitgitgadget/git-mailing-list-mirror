Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1892857C1
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006578; cv=none; b=J7E1EFlom5jG2rLOnRfzjHW/potGKtYOLSGDEwe5+Q0noW03Su0enRKJo+0Y+T3bii2QsTdFoLwZKqGq172rZkkKvikwLvOl/dqpwl55r8gnCl2BcnI7kFXFU3ESAjU/tHJApxs4EZZNf3CiHYgHUgDi92vN4YNTYhdn4Zt3vCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006578; c=relaxed/simple;
	bh=i7xQ9dPeJP6Z233vz22t30qZh1Jn/SxFxPz/w05I+lo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PDcpXX7MHTEo7mn3NOTgMKiVPXb70raRgxq+cJrrO8TuM3eQS3QqKRfV83PBzqZThPWqiqreLqILsLUzSjiyLSJzqlfGMiTpSqyCrOCUK5igphDWLG9iwpDbuLcMfN2N15HXnghlUxpfrU3S3UrYKDVcmBTUZ2v27BUvonFn5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbQOZmlo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbQOZmlo"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b790dbb112so3393766f8f.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755006575; x=1755611375; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVtFXCrD2Hhg66dPalYzbMe94hN2YJ/DAw9/EP8IgAE=;
        b=BbQOZmlo3Ys8HiTOPvz3zf9yxIA9le3vuvVCZ2LTuZQrxixo3EM2lCG+8hlzrFRPiq
         Lk4Q5HDHxI3WMQmxFwb9WySWi9vtGY+aUSxm2iarACQwfkEsL43tubEbkiS5WVnKJiGC
         IPHbmdJDXaIka6RVer1U52MrnWd8rOAstrAiYieGhpmLP4YGHWcFkOcvb7hWAnWu6yeu
         2rVPRkzvIiAm35kyT1HuE2rH+218TJ+fXGjSCKN5A4ZdRy0BniST/TcDq3cHQ2OsCVEy
         mZT9phYRrbxnsc02epZaBHUlHZfU7Pjc3yoZfSJp6ESW0s7KwDERB79zyGlMx/Qv6MxE
         MDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006575; x=1755611375;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVtFXCrD2Hhg66dPalYzbMe94hN2YJ/DAw9/EP8IgAE=;
        b=XfptyGp0zPfibvuXeHIliGfDEottDqxJGs9Q8egrF7898VslLv/ZC1xyQ+oL75gmm5
         YUXvBcUJ4PxSDm7U6XYAirr+VtAhp9GmaV/8dZk8zLO+QhyvM6CXSut22pkwGUl60gk0
         ziRjBBJytSnYfOsAl6p0bTOfA82lIr4EEKxcBe2+K+iAVUEOCAIwUeVq8K35tROpzQD5
         PcsdQ9LxFsMfS0ODCdh9RgOnzCHB7kx5mcleFNDrIiH2w6Z9bM0o3AzQiIp0iUWuvrAA
         YK5ONXi2dpNBnMtC8jYVdjwMw2yyKVkIwNWeWztw+qBXuG6+6mfkTq2qc4Nt+guzalVr
         y4jw==
X-Gm-Message-State: AOJu0YzubYsOLlXM1bJGSWGGIgu4WSgk/NH78UBi7PxVoL+sOWVR9LJK
	AVGAsZ9ch+eA9yOKhwdQGsx4O99qpmuvFMEkSCFIureORycZr2Q1vr6XqR8Exg==
X-Gm-Gg: ASbGnct0DNdv/khPnsUffVaaQwhTGEIE5FBXaFv/SJu2C1w8OxxN4Eua1XRFU/fxjgq
	ULteU19yyV0ALNQXz573hiBaGhIO+gk10FXy+l2728TCAEYwF1wxj0VlzFpjJ0sJlxfw51N/F9T
	Hsc4AhmOmiUU9/2QiFm7v0G9TovfBL8tAx0/KKjtBe0xSyv17QPgy4HwK1m/v7jQnbyw8NXcNIr
	FwSAR9foPt+V9vhW54uwWhK9V+NlBu2KWcbC3hbGAWkZ6FavxFg+YLNNosNkNBsvpHDSQF2fsVI
	pcrxKAQ3qJU2k0TS6WKfNbUgBgWuuX73a/3Bvl3sFzekPWOyYxxDxU6xahLv5FS1h15WIOFtpBd
	pMCs/W/OAgJBf7syZT7sGWew=
X-Google-Smtp-Source: AGHT+IEH5+QdStU3TyAxVSrPH+gFT06/vBZNtOPJ51jzOU4BxNMSn1Fie45CJfGz12FNPN1dsKbNFQ==
X-Received: by 2002:a05:6000:2283:b0:3b8:fa8c:f1ac with SMTP id ffacd0b85a97d-3b910fdb89amr3405523f8f.24.1755006574463;
        Tue, 12 Aug 2025 06:49:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530a8sm44237463f8f.38.2025.08.12.06.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:49:33 -0700 (PDT)
Message-Id: <79f29ad1e683f312cd3bbe71909fe5d552b4ae15.1755006568.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
References: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
	<pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 13:49:28 +0000
Subject: [PATCH v7 5/5] doc: git-rebase: update discussion of internals
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- make it clearer that we're talking about a multistep process
- give a more technically accurate description how rebase works with the
  merge backend.
- condense the explanation of how git rebase skips commits with the same
  textual changes into a single bullet point and remove the explanatory
  diagram. Lots of things which are more complicated are already being
  explained without a diagram.
- remove the explanation of how exactly `--fork-point` and `--root`
  work since that information is in the OPTIONS section
- put all discussion of `ORIG_HEAD` inside the note

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 65 ++++++++++++-----------------------
 1 file changed, 22 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index d041d87f270b..cce2577a8ade 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -68,51 +68,30 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
 branch does not have a configured upstream, the rebase will abort.
 
-All changes made by commits in the current branch but that are not
-in `<upstream>` are saved to a temporary area.  This is the same set
-of commits that would be shown by `git log <upstream>..HEAD`; or by
-`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
-description on `--fork-point` below); or by `git log HEAD`, if the
-`--root` option is specified.
-
-The current branch is reset to `<upstream>` or `<newbase>` if the
-`--onto` option was supplied.  This has the exact same effect as
-`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
-to point at the tip of the branch before the reset.
+Here is a simplified description of what `git rebase <upstream>` does:
+
+1. Make a list of all new commits on your current branch since it branched
+   off from `<upstream>`. This is the same set of commits that would be shown
+   by `git log  <upstream>..HEAD`. You can use `--fork-point` or  `--root` to
+   change how this list of commits is constructed.
+2. Check whether any of those commits contain the same changes (according to
+   `git patch-id`) as a commit already in `<upstream>` and remove them from
+   the list.
+3. Check out `<upstream>` with the equivalent of
+   `git checkout --detach <upstream>`.
+4. Replay the commits, one by one, in order. This is similar to running
+   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
+   are handled.
+5. Update your branch to point to the final commit with the equivalent
+   of `git checkout -B <branch>`.
 
 [NOTE]
-`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
-at the end of the rebase if other commands that write that pseudo-ref
-(e.g. `git reset`) are used during the rebase. The previous branch tip,
-however, is accessible using the reflog of the current branch
-(i.e. `@{1}`, see linkgit:gitrevisions[7]).
-
-The commits that were previously saved into the temporary area are
-then reapplied to the current branch, one by one, in order. Note that
-any commits in `HEAD` which introduce the same textual changes as a commit
-in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
-with a different commit message or timestamp will be skipped).
-
-If the upstream branch already contains a change you have made (e.g.,
-because you mailed a patch which was applied upstream), then that commit
-will be skipped and warnings will be issued (if the 'merge' backend is
-used).  For example, running `git rebase master` on the following
-history (in which `A'` and `A` introduce the same set of changes, but
-have different committer information):
-
-------------
-          A---B---C topic
-         /
-    D---E---A'---F master
-------------
-
-will result in:
-
-------------
-                   B'---C' topic
-                  /
-    D---E---A'---F master
-------------
+When starting the rebase, `ORIG_HEAD` is set to point to the commit at the tip
+of the to-be-rebased branch. However, `ORIG_HEAD` is not guaranteed to still
+point to that commit at the end of the rebase if other commands that change
+`ORIG_HEAD` (like `git reset`) are used during the rebase. The previous branch
+tip, however, is accessible using the reflog of the current branch (i.e. `@{1}`,
+see linkgit:gitrevisions[7].
 
 MODE OPTIONS
 ------------
-- 
gitgitgadget
