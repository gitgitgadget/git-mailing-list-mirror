Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94519FA7B
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555474; cv=none; b=LdVLtTYDi0lbljQv/TH4saO/A3mnrWrpNi+NhDyjSPdphbGXjNHstw4g2uxJpIh2Pi9puxoAhWPoqBi+EOI7QRY1gt/m4KLcdsWwfMoitWs8J5DzxQ1HUE3W7jIJnnrag49PtAmVMtDpvPTvZEA2IfruID48ZKYw9814gtDZmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555474; c=relaxed/simple;
	bh=PDSZNNtd6ydxByPbRZsKpP5lv186dABB6ZPjDs+54+o=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=l5qD5nnZD5DC/QO8Co4s80Xd9ap93EkyJ25zdjsUOrUecRZqr86h8JhtllkmTb3e1EDr/E/oxEcL+6P177m+JuPZmjqJk+f4jouV5MTxFsxedDPlgydIQ+RbJmEBJNB+DDYh+Vrf+S6KmmvrfeTEKtKIJPEsdaWX59SjnDCXpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaAqF7su; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaAqF7su"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86e5e9ff05so130936466b.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725555471; x=1726160271; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GE+gtUpl80CZLkOc0Piisg56KralkeaSyqLY4zazicY=;
        b=UaAqF7suY3sjoNpfKXjbbvKRiLVz4epVFsZp2w7rHO7PqSh+fpDBtoBSMVLt29tmqS
         vdHUt+ARnCp4XlaItbNJXTHlFpd8oexNgjdjz6UKfz00qVPs2D2nlk73po0u0hNXl9eN
         XtCG2Tnm1K/GJbkyWKHEG5j0sF5Q0ONzf92m5qS5Jm40Zh9M30ihcHKMF5LRrzsN7b7/
         HUISQLj4manvbxRCp/fY/8okocAKHbwuYUpdzquMRh99FPaaHV2OADXcZamLI8Gl+iob
         dkD58d9CMIk2LHm+SKwlkNFq2Dmld+r1Au0oDzIBHGY1WbL24rsgBr+Pnfrh8UF4o6AR
         5yCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555471; x=1726160271;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GE+gtUpl80CZLkOc0Piisg56KralkeaSyqLY4zazicY=;
        b=kg55Ztu/jIi8TIyXAMY8WJKrRZzg5WxBu0jX90Z0ToPXjKA2hXN60K0VolnjXMyFAw
         6nnBxeJk0kdHQk+VYudcgJPz5XYfln2XDrFGbPEya13SbHBcr+0BK8Y+bplnIJaLsQ2p
         qvOXErUmIt770W3eCnNGxUMpfr1cbGHUDHDup6WBavKFOHXKyH66kWqEWlqrFjtsbUK7
         579elCT1Sg/Uaz1sGwE+knsetTJz8evPDegGSBfEyit3ieYGFuXfNOPqKmuJQLhgSsWc
         2zCFdTZyRHHtykmRIDpPwqkLJZd6YoW5cBs3NCPAFJUGX/Vxxaje0RMbKmSeAapyQPds
         JnNw==
X-Gm-Message-State: AOJu0YyUSK4UiGoD+z5sDKtA6clmKB79J3heTMK26rXxMW7jQqwWJsV+
	iBk8wWIJDapk7SGnVbaPzvA0qFB3e8RIS6qRBAMeOhP7UehEi/suMNrcPg==
X-Google-Smtp-Source: AGHT+IElKolsHaRMKTaYdsFHwv+igi4jINFnL3pk4ifIN2K7q6ht1zv3IWWkgH+WhACg481EXVOFRg==
X-Received: by 2002:a17:907:3e20:b0:a7a:aa35:409e with SMTP id a640c23a62f3a-a8a32e744ebmr748906866b.25.1725555469927;
        Thu, 05 Sep 2024 09:57:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a61fbae0bsm159778866b.41.2024.09.05.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:57:49 -0700 (PDT)
Message-Id: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 16:57:44 +0000
Subject: [PATCH 0/3] Add repository parameter to builtins
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
Cc: John Cai <johncai86@gmail.com>

As part of the effort to remove global state of the_repository, add a
repository parameter to builtins so that a repository variable can be passed
down. The patches are ordered as follows:

 1. Changes the signature of builtins and passes the_repository down in
    git.c to be called by all builtins.
 2. Remove USE_THE_REPOSITORY_VARIABLE from builtin.h, and instead add it to
    each individual builtin. This paves the way for a migration process
    whereby each builtin can be migrated away from using the_repository.
 3. As an example, migrate builtin/add.c to get rid of the_repository by
    instead passing the repository argument down into helper functions.

John Cai (3):
  builtin: add a repository parameter for builtin functions
  builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
  add: pass in repo variable instead of global the_repository

 builtin.h                          | 285 ++++++++++++++---------------
 builtin/add.c                      |  99 +++++-----
 builtin/am.c                       |   3 +-
 builtin/annotate.c                 |   4 +-
 builtin/apply.c                    |   3 +-
 builtin/archive.c                  |   3 +-
 builtin/bisect.c                   |   3 +-
 builtin/blame.c                    |   4 +-
 builtin/branch.c                   |   5 +-
 builtin/bugreport.c                |   3 +-
 builtin/bundle.c                   |   3 +-
 builtin/cat-file.c                 |   7 +-
 builtin/check-attr.c               |   3 +-
 builtin/check-ignore.c             |   3 +-
 builtin/check-mailmap.c            |   3 +-
 builtin/check-ref-format.c         |   2 +-
 builtin/checkout--worker.c         |   3 +-
 builtin/checkout-index.c           |   3 +-
 builtin/checkout.c                 |   7 +-
 builtin/clean.c                    |   4 +-
 builtin/clone.c                    |   5 +-
 builtin/column.c                   |   4 +-
 builtin/commit-graph.c             |   3 +-
 builtin/commit-tree.c              |   3 +-
 builtin/commit.c                   |   9 +-
 builtin/config.c                   |   3 +-
 builtin/count-objects.c            |   4 +-
 builtin/credential-cache--daemon.c |   5 +-
 builtin/credential-cache.c         |   2 +-
 builtin/credential-store.c         |   3 +-
 builtin/credential.c               |   4 +-
 builtin/describe.c                 |   5 +-
 builtin/diagnose.c                 |   2 +-
 builtin/diff-files.c               |   3 +-
 builtin/diff-index.c               |   3 +-
 builtin/diff-tree.c                |   3 +-
 builtin/diff.c                     |   5 +-
 builtin/difftool.c                 |   5 +-
 builtin/fast-export.c              |   4 +-
 builtin/fast-import.c              |   3 +-
 builtin/fetch-pack.c               |   3 +-
 builtin/fetch.c                    |   3 +-
 builtin/fmt-merge-msg.c            |   3 +-
 builtin/for-each-ref.c             |   3 +-
 builtin/for-each-repo.c            |   3 +-
 builtin/fsck.c                     |   3 +-
 builtin/fsmonitor--daemon.c        |   5 +-
 builtin/gc.c                       |   6 +-
 builtin/get-tar-commit-id.c        |   2 +-
 builtin/grep.c                     |   3 +-
 builtin/hash-object.c              |   4 +-
 builtin/help.c                     |   4 +-
 builtin/hook.c                     |   3 +-
 builtin/index-pack.c               |   3 +-
 builtin/init-db.c                  |   2 +-
 builtin/interpret-trailers.c       |   4 +-
 builtin/log.c                      |  13 +-
 builtin/ls-files.c                 |   3 +-
 builtin/ls-remote.c                |   3 +-
 builtin/ls-tree.c                  |   4 +-
 builtin/mailinfo.c                 |   2 +-
 builtin/mailsplit.c                |   2 +-
 builtin/merge-base.c               |   3 +-
 builtin/merge-file.c               |   3 +-
 builtin/merge-index.c              |   3 +-
 builtin/merge-ours.c               |   3 +-
 builtin/merge-recursive.c          |   3 +-
 builtin/merge-tree.c               |   3 +-
 builtin/merge.c                    |   9 +-
 builtin/mktag.c                    |   3 +-
 builtin/mktree.c                   |   4 +-
 builtin/multi-pack-index.c         |   3 +-
 builtin/mv.c                       |   3 +-
 builtin/name-rev.c                 |   3 +-
 builtin/notes.c                    |   4 +-
 builtin/pack-objects.c             |   3 +-
 builtin/pack-redundant.c           |   3 +-
 builtin/pack-refs.c                |   3 +-
 builtin/patch-id.c                 |   3 +-
 builtin/prune-packed.c             |   2 +-
 builtin/prune.c                    |   3 +-
 builtin/pull.c                     |   3 +-
 builtin/push.c                     |   3 +-
 builtin/range-diff.c               |   3 +-
 builtin/read-tree.c                |   4 +-
 builtin/rebase.c                   |   5 +-
 builtin/receive-pack.c             |   3 +-
 builtin/reflog.c                   |   7 +-
 builtin/refs.c                     |   3 +-
 builtin/remote-ext.c               |   2 +-
 builtin/remote-fd.c                |   2 +-
 builtin/remote.c                   |   3 +-
 builtin/repack.c                   |   3 +-
 builtin/replace.c                  |   3 +-
 builtin/replay.c                   |   3 +-
 builtin/rerere.c                   |   3 +-
 builtin/reset.c                    |   5 +-
 builtin/rev-list.c                 |   3 +-
 builtin/rev-parse.c                |   5 +-
 builtin/revert.c                   |   5 +-
 builtin/rm.c                       |   4 +-
 builtin/send-pack.c                |   3 +-
 builtin/shortlog.c                 |   3 +-
 builtin/show-branch.c              |   3 +-
 builtin/show-index.c               |   3 +-
 builtin/show-ref.c                 |   3 +-
 builtin/sparse-checkout.c          |   3 +-
 builtin/stash.c                    |   3 +-
 builtin/stripspace.c               |   3 +-
 builtin/submodule--helper.c        |   3 +-
 builtin/symbolic-ref.c             |   3 +-
 builtin/tag.c                      |   5 +-
 builtin/unpack-file.c              |   3 +-
 builtin/unpack-objects.c           |   3 +-
 builtin/update-index.c             |   3 +-
 builtin/update-ref.c               |   3 +-
 builtin/update-server-info.c       |   3 +-
 builtin/upload-archive.c           |   5 +-
 builtin/upload-pack.c              |   2 +-
 builtin/var.c                      |   4 +-
 builtin/verify-commit.c            |   3 +-
 builtin/verify-pack.c              |   3 +-
 builtin/verify-tag.c               |   4 +-
 builtin/worktree.c                 |   3 +-
 builtin/write-tree.c               |   4 +-
 commit.h                           |   3 +-
 git.c                              |  14 +-
 help.c                             |   3 +-
 128 files changed, 477 insertions(+), 366 deletions(-)


base-commit: 4590f2e9412378c61eac95966709c78766d326ba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1778%2Fjohn-cai%2Fjc%2Fadd-the-repository-to-builtin-signature-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1778/john-cai/jc/add-the-repository-to-builtin-signature-v1
Pull-Request: https://github.com/git/git/pull/1778
-- 
gitgitgadget
