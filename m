Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026713AA2D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179998; cv=none; b=nkROlDqCRu4F1jWJGaKq/IPvLLZpGLsMMNnrcZyuTSzf2y32xIwVmBU8lE2TtBairJZYUyxjCqrUAK9hk88qJvVd1U5qeMf9Imof2akwWwKT82pLGi2pK2xP3jv3ovJujU/pS9jvHhWSjrwNoF5gWYfdLQfFBdAoKNQKRVGY/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179998; c=relaxed/simple;
	bh=V3scYwu7ACFtSgMuHAZfnE0IzhMHjMhYGyk6NPU17Cc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=GnXZJ95djdC+GAFTjayHMLphZNlxRmKETcuITxy0MUR/tuWEEqlNb+uQhieN2ozen6TlhMe2AdP+ohq5Vh2E+sGH4kWd9PlA2etpfG+t7nVZuPnNyjJfYYPq/TIZ8ybiVRxcGARuC+vwJIdZC8/qOzPTl7Gm5LCLBN0txoUViYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mE1fqkey; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmjHsp5Z; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mE1fqkey";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmjHsp5Z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E5811D00114;
	Thu, 16 Jul 2026 01:33:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 01:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784179995;
	 x=1784266395; bh=TOyysMu7r1Ka/hRwiEJkSYpt5XvcTeGvwGEQ/p0LVl0=; b=
	mE1fqkey2tN6wDUMO1eoXsAC6JhQ2Jq45trR2wQ3ZsVB7MarvvoL+jA/eLGZNWC4
	st9blqZAjEm/AybSqe9rVm35LWlLsHrfSf+Q3glcaZlu1Efbz5mqQ9vDCBeZ3Tj/
	Z4NhXIoOFh3sMrC8s0U0AvWbeUfNE83hrGW7GLCIEBCPEZLSojUNZ521koiNvDsT
	WrHig5rqRIAf3w2sY9wyBwVnVUYnz24OL4stXWa6zT+DaA45mhQMbpJryh/Ll6T+
	rzro50wVAAzfuK0dT1HxEOJSg1UXe39L8N3waTi8/gbi1yI9gz8pdcMen0vN317n
	78HsgajD37VN/rQYOMVniw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784179995; x=
	1784266395; bh=TOyysMu7r1Ka/hRwiEJkSYpt5XvcTeGvwGEQ/p0LVl0=; b=k
	mjHsp5Zxfmm63qjj5aNwtZMFVhZmaNA1oKVMMz5Yf+0R5c+nzzPa+O/YkQpzXldZ
	O8Dc5+IrJofZGiaaC0YuRsVDPf7jz4cVdImyymI9E6GySjvuuNsKEzQtBxUePIgf
	ymDh4tLrCMYVqTaku9x5cj5d+OvN9evlixaAmnY4dsfkOjfCiw3joIKzLBtmCFUP
	Wfne9LxOGkG9JqJsgHXfMA1DlD3gKXQLKValXyvGc01zrZzyF2lVA7Q5V/rewgSQ
	6m8IoHyJEFIF3wvtgFFqP5e5BagV3dWtjcKeny+nelHKeRcANQpB4SMUh8AuPrXV
	z4N41cbk9gv+LL3JOWyZg==
X-ME-Sender: <xms:G21YajxcKC6MGej2rM11iGnNjk0vqYMrFMzRjbkcOocTa47qLwTnsA>
    <xme:G21YaislL6vMisddKIEXh8WTUSUhMbFXeX8FW4lONMDkehqzkOe7Hd2kOyHSPCQEp
    V8fMr0VSaUv6_7z3s_jIMqmTC3UfOoVzyMdqMGGLFgMa6J_rKpE1Q>
X-ME-Received: <xmr:G21Yaqt9mQANQkpZu-e3Tk8wmpFn2kRz211TNltEdRAeEGRE4_Wmw6hnb87prnDLQjfXI6NgY5At7fYLI61Dr8pWvNPX9t1ekVZeIC1Q>
X-ME-Proxy-Cause: dmFkZTEDQUX9LiEe6l/FYMyMFTvEJo5UPr4JRQtNBhOx5rKY/hpBVr1pu4k6T6WByJPSmF
    yqPhN3v21incrJiwNUX9A0mn/OsvAxiv+F8pKi8N/gPCaceLaYaTvqno9Cl+VgXRo2cUlV
    Q6uauXNNoX+uZ4YVVXBnOPLfgSWZmo2k6TFUgOM7Y7u4ojbqKutNiq0VlXIoQUXzAhH2TQ
    425LVsN8mHSSmx+jWsr5VliEjHYqYyHp6gVqzIS3pELzBVHVy7+Vnb29VinQGs/nwxF7Ei
    LAF8St4NgoTVmtyHEp69ah3EOehKxeiCLTR5sAOGIfEvyZ5d42ZswEh4gmalXi79oeVKn+
    oMMiJ5wgl0CV7hWE8JGqqQUKwcFL5q6Zb7FZNGydwcvX44MIUKUoLuL4HbaMnKeFkEodHu
    oT22iJVqfMiXpQi3TtQJM8KhWRXp6wPZ8w+ria1OstiJbxWL40idRc+TerbqIvuQ+t/vHc
    9pQaa8VXig/AamX6V3WnWoP2EB53fRJj2MMP5UWxSLGMOv4bp8h6C1VSCdBWpaEVOlNht5
    dpX3TVH4rgP60kuAe/C+eqFwbHhfEnlez9s5XD3agNyh/oAgsbidfwgIaLSR2VCT2X6IDO
    POTqOao7c5jJoemoRFceEO5Gh61fqk8PS5MpQZLM3xij0DrfKMwvRzwvFbLA
X-ME-Proxy: <xmx:G21YanOnsDT-uKqGHcG16Pi8px1vVlhQYskIy9YwoAM2lwhpA6WwSg>
    <xmx:G21Yao0ZDqgmBOzcVChsCFSoLI8GysZv78XZEMZ3u6_UkSyIuWtFTw>
    <xmx:G21YajMQgxf2bimRUDPT_HpzXbyW5oNnxdDagQlZgmeDFGXBRIGwmA>
    <xmx:G21Yao3BMlqAYR-oIickF2MrpRrDtviAN7a-imG30-K9AlacaXC8kA>
    <xmx:G21YapWs3KupZEESxps2ghq2x20FuWHx5_aTXhQcrKZLjFobJSQqTvyP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 01:33:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a070c243 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 05:33:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/6] refs: remove use of `the_repository`
Date: Thu, 16 Jul 2026 07:33:01 +0200
Message-Id: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ7CIBAGX8VwFsNPC+LJ9zAeELYWjaWBipqm7
 y60ifHU237J7MyIIgQHER02IwqQXHS+y4NvN8i0ursCdjZvxAgTRNA97u8RB2gifnk8tJDv3kc
 3+PDBEioOTHFJtUFZ0GfOvWf56bzs+LzcwAzFWIjWxfI51xMt3BKSRK2FEsUEU21Fw2TNlFHHD
 O/cA5VKYn8eWq96WPZYQiwXVVNrDj/PNE1fO7W8YxsBAAA=
X-Change-ID: 20260618-pks-refs-wo-the-repository-7e43e29371ac
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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

Changes in v3:
  - Merge the patch that removes `USE_THE_REPOSITORY_VARIABLE` from the
    "packed" backend into the patch that removes the last use of
    `the_repository`.
  - Link to v2: https://patch.msgid.link/20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im

Changes in v2:
  - Fix default value for "core.packedRefsTimeout".
  - Link to v1: https://patch.msgid.link/20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      refs/packed: de-globalize handling of "core.packedRefsTimeout"
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

Range-diff versus v2:

1:  b0f7389eb2 ! 1:  2e2ec63de8 refs/packed: de-globalize handling of "core.packedRefsTimeout"
    @@ Commit message
         Fix the issue by moving the value into `struct packed_ref_store` so that
         it can be parsed per store.
     
    +    This removes the last callsite that still used `the_repository`, so drop
    +    the `USE_THE_REPOSITORY_VARIABLE` define.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## refs/packed-backend.c ##
    +@@
    +-#define USE_THE_REPOSITORY_VARIABLE
    + #define DISABLE_SIGN_COMPARE_WARNINGS
    + 
    + #include "../git-compat-util.h"
     @@ refs/packed-backend.c: struct packed_ref_store {
      	 * `packed_ref_store`) must not be freed.
      	 */
2:  a36af82b03 < -:  ---------- refs/packed: drop `USE_THE_REPOSITORY_VARIABLE`
3:  136db475ff = 2:  ddba174b0d refs/files: drop `USE_THE_REPOSITORY_VARIABLE`
4:  f0c028a2d7 = 3:  69aa7536f6 worktree: refactor code to use available repositories
5:  42df076903 = 4:  a75b0b7228 worktree: pass repository to file-local functions
6:  8c7fd80674 = 5:  b1a214131d worktree: pass repository to public functions
7:  618fc6497f = 6:  6d83181a30 refs: remove remaining uses of `the_repository`

---
base-commit: f035246f779167db3506394141b59472d544af65
change-id: 20260618-pks-refs-wo-the-repository-7e43e29371ac

