Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B233B840E
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101183; cv=none; b=HLlJm0tDUKauoG22y9K1e4qWkj83WMscPzwMHRgwEr4P6m8r1t3/k+Tzibxsb7wimXDpmx+4LMSmX26DlixFcsncfjpj/Hq6hc2qUHq2XixdIag4KtHBJwpS3NznqZY35yuLzlY/vRPvXwMEG5I7IBOfj+9YEtNvOISeRQqSjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101183; c=relaxed/simple;
	bh=spg3HXt7RQtWdZ7ufl5/DQ0qnkj5Q0osOK4rvOp2Do4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=TjV2fCjnfd8f944KS0HsXQjzOb/0h/7nzxN4BcOEV0a98NB3oDt4MX02iBOqAc9cj1Jj2zPtsHQs3GDTpz6N4AfLoZ0MBGDyy6GoHxDiUQPa62LrMoCsMpPL7p4asBT4I0lOd4h2dTdaseD/e96A7flNhcos4cuA8LIL9LlNTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SDnyWckN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IR3+Pdfe; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SDnyWckN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IR3+Pdfe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1FC197A0145;
	Wed, 15 Jul 2026 03:39:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 03:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784101180;
	 x=1784187580; bh=ucI6mLam9Xv/HKWkNWtQATRxQNLZyY2bn+9vMfVoZjs=; b=
	SDnyWckND7GamspkgEWVcOTUbvAd7KAKZO04G1QA9mjMZrWo5xZcNCH05cQtN5hl
	4G+mNM/IFYc4+dnZbpDs0YCe9v+SQ9XuoiJEfeIK91puH789AgZqdyjRjgrjpcjT
	9OwrhpYwFl2oZ6tDGiTXQXnLTmJx2Q/cat/+xxHBNdHpB6u72FO8qJiZ3dJknfyB
	5hwR6dUnKxYdB81OS7FM6clptlHI1sHqqw/XivIzTgFbD0nWpXSAdAHgwESKLSge
	AHzfDJpy+MdbtYMYhqhCqb/u+oLxryMBxWUbKeiwfbOg3gfYRJdsrPmTz6MJd/YB
	3k0Vo2TALSRInmRbiv+JHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784101180; x=
	1784187580; bh=ucI6mLam9Xv/HKWkNWtQATRxQNLZyY2bn+9vMfVoZjs=; b=I
	R3+Pdfe+dNQTPiZ3agQQKckVBzE6a1xJk87RgOKs1BgZnL1TKqyrfjZXhWy07CSe
	or3AKb6zQowHxrrag/Ysn+0dBTsf6Ix4OIqoSpYc791o3i9pd0mFU9rf6W7jj+4X
	Whr/xRJIdlwWlEIuozBNroqF46Lbmtg4gwp1RUOfraN5/2F7jgoXq2YMixVDxAf8
	Hj8krSXwHVCTydnpBRflsyQp43AhjHYkxL2enzky5cy7RKpmnAWP4TyYp/ixoIeN
	HrUnNNoxifY7rg1231LE1JndN7EnodGFHzUaHH3YdR/HRVUjwDTLsU+8/YtKGo5L
	zAu8LFbdRMuanZzwOqQnQ==
X-ME-Sender: <xms:PDlXakQb_F0Kmeh70KFgBUvpWFveaOlgHQwM0nXusS73kFE4P9VYCA>
    <xme:PDlXanxTGnjTsWFdsyK1jLm2pMv5H1lATa1lvpybffWS1gGAtzecUdCVN0l5_JdOO
    YfNbkIb6OWHPut_gENvmFA4yU_SdfPbhiJ3sqMQnnjCn-wzKZQYKQ>
X-ME-Received: <xmr:PDlXavfpz3wmUzrf7sWjka6FSB-9MFB1RdkxV6Jk9XLlXkJukkU_GzEIfSy-lU83dJNaUxlSPtEAJiuR7wM3inDYs5-MYhgGL5lcx7V89W4>
X-ME-Proxy-Cause: dmFkZTEzS/jgR00b5+DXoPUP3mtI43VjrUGozDTexj+td1SQBI/NFq+e6k1/FXlhXBhpfr
    IwimbypJRQg6+4vUqZ921Plhe1XpjbOpj2TFs4+aMc97OC7dJ1hErcdTLx3V/xTQjMXelJ
    CfGDuvTtNM697k7PuTrRWBK5dK+qmIFf4N7vj5wtMnAcR5mM7cY5dCwAvFDQz8OCAkmkMZ
    eCI5y37XSPXB6ghrfD9eI/gB5VMjaFRi27U0s7vt84E1FTedblkGB+44lUdW7s4Y13O8Ml
    3VYLOOEk5BLw2VkpR59eKJvdGDD0NPIBnZzSRF1mBEh0PIgLUKdeqytfmpIBqjD2JxiVO9
    1Rri5fYsaY10YSHX5nWSeZCPznEq0oi4maFhI8oYNEibGcC++kvgq/ddS0SKM/GCV57+wp
    +QBOyicbwOa7xi92NeqhDRNv4DEThW+H+M/dxA+8DgYFNIPkTJNOVjMwYzcMoJBZnM+C2Y
    k4qIA06TDAbe4tQRU1Y3t1GzGJFIQxCc2UQPFzCiOCrHWFByEnp6pM2zawyGE44eEk+PWX
    FQOBxWU9ktwZEPE4NGolKnWRM7xI43vTP2Cmk+LksIG0IWoUkh6++ZrJbx2NWf8ollDcWh
    Wgbaiy5YZUCe0kp6GGCUeA5bD4yaw79r8NaH2tL4iyYD8giiLpYNr2DtElvA
X-ME-Proxy: <xmx:PDlXajLRSPrqsJWeQhZMe2tDc2ob-CTV2dh3ivRhMGAhqZtYVxKA6w>
    <xmx:PDlXagF80hzHR67p-S2GM9HsX1Y487b4P3s-GEFRMcQo6W9WPg3rIA>
    <xmx:PDlXatqdiy1qHSDaQY0ZpBMHJfKmztoUxwmugNXoa_DQaZ0GHPf04g>
    <xmx:PDlXapTE0EAQtiAnLGwxny8hw-p_q9Av_x7Rh7g_oRTmBCFYY_YCtA>
    <xmx:PDlXanobdJrEMT8Dx1U2HQNsBfKlNoYm9yFbT97ZI82Moy6AKQNQ4oCn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 03:39:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffb70c8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 07:39:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] refs: remove use of `the_repository`
Date: Wed, 15 Jul 2026 09:39:33 +0200
Message-Id: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0K6dkxblFpW3sOwwDLIaKSkg6gh3
 N0W9u7mJW/enwVjIGRRZrMIOBGT7yPoXSZcV/c3BGoiCy11IQt1guHBELBleHsYO4z34JlGH75
 g8JCjtrlRtRMxMESPPmv8Um3Mr+sd3ZiKyeiI0+e6PqnkbUNG2n9DkwIJqm6KVpujts6eo7ynp
 6iWZfkBQOaqONMAAAA=
X-Change-ID: 20260618-pks-refs-wo-the-repository-7e43e29371ac
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this patch series refactors the ref subsystem to drop uses of
`the_repository`. These patches were part of a discarded attempt to
make the initialization of the refdb eager. I guess they make sense by
themselves though, so here we go.

Note that these patches contain a slight tangent to also adapt
"worktree.c". This is one of the subsystems that caused problems with
eager refdb initialization because of `has_worktrees()`, so I refactored
this subsystem while at it.

The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
2026-07-06) with ps/refs-writing-subcommands at 002fe677ca
(builtin/refs: add "rename" subcommand, 2026-07-06) merged into it.
Despite that, there's a small set of conflicts with "seen" that can be
merged like this:

diff --cc lib/setup.c
index 505e8d7bf2,d31808130b..0000000000
--- a/lib/setup.c
+++ b/lib/setup.c
@@@ -2822,15 -2847,16 +2848,16 @@@ int init_db(struct repository *repo
  		if (!exist_ok && !stat(real_git_dir, &st))
  			die(_("%s already exists"), real_git_dir);
  
- 		set_git_dir(repo, real_git_dir, 1);
+ 		apply_and_export_relative_gitdir(repo, real_git_dir, 1);
  		git_dir = repo_get_git_dir(repo);
 -		separate_git_dir(git_dir, original_git_dir);
 +		separate_git_dir(repo, git_dir, original_git_dir);
- 	}
- 	else {
- 		set_git_dir(repo, git_dir, 1);
+ 	} else {
+ 		apply_and_export_relative_gitdir(repo, git_dir, 1);
  		git_dir = repo_get_git_dir(repo);
  	}
- 	startup_info->have_repository = 1;
+ 
+ 	if (worktree)
+ 		set_git_work_tree(repo, worktree);
  
  	/*
  	 * Check to see if the repository version is right.
diff --git a/lib/refs/files-backend.c b/lib/refs/files-backend.c
index f672059333..3ba1b4eac4 100644
--- a/lib/refs/files-backend.c
+++ b/lib/refs/files-backend.c
@@ -859,7 +859,7 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 		} else {
 			unable_to_lock_message(ref_file.buf, myerr, err);
 			if (myerr == EEXIST) {
-				if (repo_ignore_case(the_repository) &&
+				if (repo_ignore_case(refs->base.repo) &&
 				    transaction_has_case_conflicting_update(transaction, update)) {
 					/*
 					 * In case-insensitive filesystems, ensure that conflicts within a
@@ -973,7 +973,7 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 		 * conflicts between 'foo' and 'Foo/bar'. So let's lowercase
 		 * the refname.
 		 */
-		if (repo_ignore_case(the_repository)) {
+		if (repo_ignore_case(refs->base.repo)) {
 			struct strbuf lower = STRBUF_INIT;
 
 			strbuf_addstr(&lower, refname);

Changes in v2:
  - Fix default value for "core.packedRefsTimeout".
  - Link to v1: https://patch.msgid.link/20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      refs/packed: de-globalize handling of "core.packedRefsTimeout"
      refs/packed: drop `USE_THE_REPOSITORY_VARIABLE`
      refs/files: drop `USE_THE_REPOSITORY_VARIABLE`
      worktree: refactor code to use available repositories
      worktree: pass repository to file-local functions
      worktree: pass repository to public functions
      refs: remove remaining uses of `the_repository`

 branch.c                   |   6 +-
 builtin/branch.c           |  16 +++--
 builtin/check-ref-format.c |   2 +-
 builtin/checkout.c         |   2 +-
 builtin/config.c           |   2 +-
 builtin/fsck.c             |   6 +-
 builtin/gc.c               |   2 +-
 builtin/merge.c            |   2 +-
 builtin/notes.c            |   2 +-
 builtin/receive-pack.c     |   2 +-
 builtin/reflog.c           |   4 +-
 builtin/refs.c             |   2 +-
 builtin/worktree.c         |  32 +++++----
 reachable.c                |   4 +-
 ref-filter.c               |   2 +-
 refs.c                     |  23 +++----
 refs.h                     |   5 +-
 refs/files-backend.c       |  31 +++++----
 refs/packed-backend.c      |  20 ++++--
 revision.c                 |   6 +-
 setup.c                    |   7 +-
 submodule.c                |   2 +-
 t/helper/test-ref-store.c  |   2 +-
 worktree.c                 | 166 +++++++++++++++++++++++++--------------------
 worktree.h                 |  27 +++++---
 25 files changed, 206 insertions(+), 169 deletions(-)

Range-diff versus v1:

1:  e2de4a7ae9 ! 1:  5c9df5ce44 refs/packed: de-globalize handling of "core.packedRefsTimeout"
    @@ refs/packed-backend.c: int packed_refs_lock(struct ref_store *ref_store, int fla
     -		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
     -		timeout_configured = 1;
     +	if (!refs->timeout_configured) {
    -+		repo_config_get_int(ref_store->repo, "core.packedrefstimeout", &refs->timeout_value);
    ++		if (repo_config_get_int(ref_store->repo, "core.packedrefstimeout",
    ++					&refs->timeout_value))
    ++			refs->timeout_value = 1000;
     +		refs->timeout_configured = true;
      	}
      
2:  3c96ed5d22 = 2:  39d91a88ad refs/packed: drop `USE_THE_REPOSITORY_VARIABLE`
3:  a724abf676 = 3:  5d3d4c505f refs/files: drop `USE_THE_REPOSITORY_VARIABLE`
4:  ce64ae5edd = 4:  cff8c31110 worktree: refactor code to use available repositories
5:  fa5b6c95e2 = 5:  b53b5f67f7 worktree: pass repository to file-local functions
6:  89b0263583 = 6:  0927572842 worktree: pass repository to public functions
7:  e4ac64f7c2 = 7:  bb3b3b1e80 refs: remove remaining uses of `the_repository`

---
base-commit: f035246f779167db3506394141b59472d544af65
change-id: 20260618-pks-refs-wo-the-repository-7e43e29371ac

