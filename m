Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681783EFFDB
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585768; cv=none; b=HjZC5ISri9MnpFGDRu6A1pJrgDkDPAALc425PZHSTqoVesPE4jjj3bqd+5ji69z461gMJvtwgExQSAcRB5bCUEnahUmVJ0QvRcrmCHmcSmMxFQYilBVj7sxKEhRw+aRTCUOyqAnyxcOf5YAxFOMnXB7XLaJ4NLsmiFLd/hq56r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585768; c=relaxed/simple;
	bh=R1oF3Pm0KD7428zbpe5xJWk8Hdsl838kGXTXN4+qHqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yzdkp92yB15eflhLG/ODss0wC3rbehcuoeTPuA8EYc2PY+oizoU4cmgRrXn67oWUUiS18E9eAPz4D9a+oRP9ihAv5trwcyMe9+1m3tlMT7TVAnHEIuSSqw3FP7ga9T1B90jaW6xKoUzMUqxLzScfuhbnwmOrUuJnC2pl5nZxloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WBFyNWVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pzUB9lvs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WBFyNWVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pzUB9lvs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA18E7A003E
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:29:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 04:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1783585765; x=1783672165; bh=/qvwUYgLgc
	lGx4kjdT+72r6VrlwTey1sMeumnzlYcCU=; b=WBFyNWVOnOyGmDeueVFkzvUpgp
	6EezFIiIoqpA7l6bPJ5r7M5ZnxmTKcVIUwSkd+oQcXzKCurajnxZy1+DEp9MSl7x
	7koEwPHxw2R2kINuwBbxRqICP8dG7qBs19cMcbevrwGpl18zpzuK89RwgKVGeZQe
	5SHRBpy9Nkrzehtjj+ykOWamnCa+lmrRbog5PXfZqSp2cq57J+VOg9Bqe8WPDkpe
	+lq4fz7P6AVYRd1c2fq2kincVGVSEOJQN3v9LQY/bqss1SohbuvQxZhIkNCue3i9
	mQeReaze92xnkZ0wmFEBpOLQL6WJSZ14IOCEB6wChGHXqi6fr6L+9hP/p3bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783585765; x=1783672165; bh=/qvwUYgLgclGx4kjdT+72r6VrlwT
	ey1sMeumnzlYcCU=; b=pzUB9lvsmnY3Ls7A8uIzJh3Xzx/TirIOWvhwM/LZThdi
	N9+fr8OS7/CbipTfRP3veUka3ARgdLSp9GCQCp/Z63+LdNsQIjYixXmt1T9fXQck
	2DumfrtenTwCQ7G/wakwRMIh6qiZKfm/MQxaIQ3yfGJj+0pRR5jJWbOHCw2+gDFg
	+rkusxc9Ctmy48gth4iFv4Qk5vVYN2liJLuw6iu3zb0J+Pox3GjiTRpJ2UDwPx+n
	eR4/nsi6MeqexC+n+6F3xYdIbpX0sxLR2nHBausLB/ngdiR9qmpeeknXn5JH0/yr
	zo4T0ESAbHm+AZ6wvGVTkPMm7fCrHwa+OW0sv/hTVw==
X-ME-Sender: <xms:5VtPamZdRaC9kLmXCAV1fzhWgqafWbzMYK0OitJluphgF6se3u99gw>
    <xme:5VtPagV9GsQvi6mH5moCBJMdMvZHljyyNqqC41jKMwUklUsWm6t-DUho3MRYl4xYP
    NKzelYZ1E028cIZUtROzhdIafFKP3mHlBMImciflX06jQLPffqG-mE>
X-ME-Received: <xmr:5VtPamkkWF4w5I5NxAoFypxeXN2CFxxp8LhaKafVPJ51Giqry6uBTj9pT6HA3q6h8m8JktKQ0MPpEv3VUN0XEpRx0FzMEnG-jYO4kPugRQ>
X-ME-Proxy-Cause: dmFkZTGLCw0T2PGMz/e4YVAn56un0EH907CbRf48VFS/X5fqhVN2nW99AYnVd70fGoge7v
    jfhEQCNtRk6FoMMaAVMrLvfnMYg4QtRmq9C6KB8DawwtNW9IZQWyHMd/fSqbr2MXitCcAG
    cTQXr1SKaXwTCaPz+yPLiOgC9p2iV6KLEOnBJQT8AiX1YBNsz05ESJQ4fCQCHo3m+wI0br
    pKuPuA87H/fWfHlMjbWmNy9UjwUBgzfOm5qmWIJjl50L4joRHKMQET5fXBrKougBrEkQxP
    S5sAsp3jUa0Rho4u1ONFNnKxAuK53LsFA0r008m6DmVn+qmyz1kE4nTkj10jHkXGpv7VBq
    UlpOATR0fl6mKxMYcn/G22nHWjfc9Y1D5rBtQaHq3Ex8XYt4XfAjckQBp1pwJmHYVLxHGN
    X41z50ksBKxua1pYTDqoTbyQ/GvbG1X9eq3BGgZAz4V961L/a03x3gmEEoTiUrkpXH+tOZ
    wEX3o8vDvI4KNIBcuMsQxvTqzCjm0G23T+yux2Zer8DsxyVsNlpzsYyfSIBZLpZQBlT51C
    NdT252Xe1r+Ivy3/5oKI5N7ETvzlK1kmm1BtDFjve2zfvYP3/kXM7I8rTSa6C7q7Lc5dhx
    08DTn0c5SRz60f8xn6eNouhmzgEI4dCJQQd/c6TinSspliqnKutHtUpq71Dw
X-ME-Proxy: <xmx:5VtPatxXf2NkUaAKVZ7vRIEinsHNBNqtMJlan7_gf7Eu__kHqurwAg>
    <xmx:5VtPahgGHS5nveWFN9t6rg4uf1Rw6JP6wlH8i4OW0DwkhYXPSwDcAA>
    <xmx:5VtPaiUVoOWr2Srzr_uVTDxWilK5B5NL-GHKNl_65Yk4Py5WDogYPA>
    <xmx:5VtPaj1IQzvQOO3Mvb99TIDVP_JjijLwH1QzY16mOlPMD-G_EmCrgg>
    <xmx:5VtPak5WqfMs0wBLD3Dz8wTlOux3-aMs9bKeGaRHbzUw0vnCTSrPjIxI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:29:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ddf93a87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:29:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] refs: remove use of `the_repository`
Date: Thu, 09 Jul 2026 10:29:11 +0200
Message-Id: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdbT2oC/yXMUQrCMBCE4auUfXahSaVVryI+tHG0q9CEbNRK6
 d1d9W0+GP6FFFmgdKgWyniKSpwMblNRGPvpCpazmXzt27p1O0535YyL8ityGWE7RZUS85s7bBv
 4fdO5PpAFkv1k/sWPp7/1MdwQyrdI6/oBvexjnH4AAAA=
X-Change-ID: 20260618-pks-refs-wo-the-repository-7e43e29371ac
To: git@vger.kernel.org
Cc: 
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
 refs/packed-backend.c      |  18 +++--
 revision.c                 |   6 +-
 setup.c                    |   7 +-
 submodule.c                |   2 +-
 t/helper/test-ref-store.c  |   2 +-
 worktree.c                 | 166 +++++++++++++++++++++++++--------------------
 worktree.h                 |  27 +++++---
 25 files changed, 204 insertions(+), 169 deletions(-)


---
base-commit: f035246f779167db3506394141b59472d544af65
change-id: 20260618-pks-refs-wo-the-repository-7e43e29371ac

