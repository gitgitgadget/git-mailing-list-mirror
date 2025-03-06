Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DAA2114
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273834; cv=none; b=gwohaeE70C/Wjd91UK0gY4fqv2Ut+9w0EI7grN/JGBMgRv8H6V5GAx8yYzT8OsPdPwb5BVuftE04M2zDSq3xO2fYEJHtt4mBI2w/+qR+bFKZM1a3xEiGiipjhxQRFM3/QKc4fdtYGNCCumJ/Dd2ZTutOR36e9uL7jbmba4NpqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273834; c=relaxed/simple;
	bh=l2IBxoo7uK9sqzwBvAbDgG1EXqFkI5SXOJaJkGgKUjU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=RhNvX1LwO19Gvh9g8XZ0K+gi/ExNtpYIPHVSacXTz17hYjoNwn1DdX+YRnaWiWO5ZRQY4xM1C3OYldPv9p2XuCgJWNZNCQ4AsyDPfmQ/c2IAc4VdQi7DTVxGk0aLajOvoEIdkTG6WQYbAsFR3Gqrg9vZnyVCK+y83Tims2SAOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W/uB5Qzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9Tc6lii; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W/uB5Qzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9Tc6lii"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 80F0E25401EF;
	Thu,  6 Mar 2025 10:10:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 10:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273831;
	 x=1741360231; bh=e9XzRTPbWjmVmcsnvhYy5CuV7udmg6OZiJx5LBBYLK0=; b=
	W/uB5QzcY2daiwzldBclbvSC03vEtHJyyHQZeCa19M+AUxm8wzD93mn9t1FYshu+
	cQfuKifOTDQjFpL3UgvPLXEAd+IXDqTXBl7f9GFelTg4X0Y8ofiLMmdYiZAMxYa1
	RJkKp4OsIQL036T54CEr/Mqq2CvtwYg5eiVbCVdiqrFHogoRB2A5pWOR0oUGTOUT
	GaYb5GZ2ZQW6SatPdBhlgQXxiNDVl1IMzwoSm9BoBnGnP2TKTZ7UVFpce1wsiKX9
	/aQfvfX9huxwAoNe3Xba6n5it70sZm3xIkBNNRHD6cNtpAPuIEmU/K4mTy0hD5dw
	6laas5p3DnieuvhQrBRi4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273831; x=
	1741360231; bh=e9XzRTPbWjmVmcsnvhYy5CuV7udmg6OZiJx5LBBYLK0=; b=p
	9Tc6liienWLXCLD+L5K3ViZz/Nn+UDJW0Bd0MRZsGBcZyHL6Z3MrNzfAXFoOUvD+
	eIZnU2H6QAJbdawNY3OvPsMOgys6iRhOMONf6XZIXJDgPattRMWFUZ3hckHblNiQ
	svyTRLcNTK7z5aLiq6lxc8HB828d93nX4ENOTUVs3aaj6Gzmd17P4LOC3X+yfQPt
	dIUU1cDrNgAe1LENgAcC7HJcvabx04E5dCHwGCXffJKrtP4HM8ImHWmVDacUn3yf
	pAKrTPFy62C3IbkOWe7dKoTTQqGMw9VvIRzULMbTlBXyRfRwPHA4u/TKZj/70xlJ
	EqCPeMCGPBPnMGCNp8zUg==
X-ME-Sender: <xms:57rJZ2NqIsSFbu0GkdL96z0QcuJJZQNQaruwA_2k6WIG5Sqex-fbhw>
    <xme:57rJZ09adqMuLFoUUL6NxAFG9GYV55HsjieuXzDnllftH4cUxBQD8ELA7MIPHXkJw
    m_nn-MV5L3-XegFWw>
X-ME-Received: <xmr:57rJZ9TFu6jqXnlr77m0agWtNIGxBSYRoj29v7HD9fYxoVhi1f1v8BdkG7PlejqI78mLOQph6ZagjdyQcwf__b1ZHlihhTbIZBTLHgSDuRlHwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:57rJZ2sfAwjBvwYxRhbKa_ENZ_XO1YIf-mkzTHCJaGjbVd7sRl1VhA>
    <xmx:57rJZ-dGdjSkudAyzKMNnW14xglXuzWuR-k5sXpDQtZ4LArtH18gQQ>
    <xmx:57rJZ61W6skylMuzpsyAv9tydeRfNqKMeVBl3xySwk-rSEpwuTCDSQ>
    <xmx:57rJZy_nv-KGw7kcA5ZY-k0cGYNxRXv5kx55GMtrkczohaVTljXviw>
    <xmx:57rJZ-4EtHK4WhChTXn48oNHa0QioB130vS8mX6fmgd2auLEMEiRPuqT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:10:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 48c9e2d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:10:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/12] Stop depending on `the_repository` in
 object-related subsystems
Date: Thu, 06 Mar 2025 16:10:24 +0100
Message-Id: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOG6yWcC/42NTQ6CMBCFr0Jm7ZjS8icr72FYQBnsaKSkragh3
 N2CF3D5vbz3vgU8OSYPdbKAo5k92zGCPCSgTTteCbmPDFLIXMhUYJfhdPdouxvp4PHFwdhnwGA
 IHU3Wc7Dug0XXVupUDaXWAuLX5Gjg9+65NJEN+623a+d0S38GJdSfhjlFgTrv+0wNMisLOsfRk
 R/QrOv6BdRqCGfXAAAA
X-Change-ID: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is another step to remove our dependency on the global
`the_repository` variable. The series focusses on subsystems related to
objects.

The intent here is to work towards libification of the whole subsystem
so that we can start splitting out something like an object "backend".
It is thus part of a set of refactorings aimed at allowing pluggable
object databases eventually. I'm not discussing that bigger effort yet,
mostly because it's still taking shape. So these patch series contains
things that make sense standalone, even if pluggable ODBs never get to
be a thing.

Note that this patch series stop short of dropping `the_repository` in
"object-file.c". This is a bigger undertaking, so I'm pushing that into
the next patch series.

The series is built on top of cb0ae672aea (A bit more post -rc0,
2025-02-27) with ps/path-sans-the-repository at 028f618658e (path:
adjust last remaining users of `the_repository`, 2025-02-07) merged into
it.

Changes in v2:
  - Point out why t1050 had to be adapted.
  - Drop the rename of `get_max_object_index()` and
    `get_indexed_object()`.
  - Fix a couple of commit message typos.
  - Link to v1: https://lore.kernel.org/r/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      csum-file: stop depending on `the_repository`
      object: stop depending on `the_repository`
      pack-write: stop depending on `the_repository` and `the_hash_algo`
      environment: move access to "core.bigFileThreshold" into repo settings
      pack-check: stop depending on `the_repository`
      pack-revindex: stop depending on `the_repository`
      pack-bitmap-write: stop depending on `the_repository`
      object-file-convert: stop depending on `the_repository`
      delta-islands: stop depending on `the_repository`
      object-file: split out logic regarding hash algorithms
      hash: fix "-Wsign-compare" warnings
      hash: stop depending on `the_repository` in `null_oid()`

 Makefile                                     |   1 +
 archive.c                                    |   4 +-
 blame.c                                      |   2 +-
 branch.c                                     |   2 +-
 builtin/checkout.c                           |   6 +-
 builtin/clone.c                              |   2 +-
 builtin/describe.c                           |   2 +-
 builtin/diff.c                               |   5 +-
 builtin/fast-export.c                        |  10 +-
 builtin/fast-import.c                        |   8 +-
 builtin/fsck.c                               |   6 +-
 builtin/grep.c                               |   4 +-
 builtin/index-pack.c                         |  16 +-
 builtin/log.c                                |   2 +-
 builtin/ls-files.c                           |   2 +-
 builtin/name-rev.c                           |   4 +-
 builtin/pack-objects.c                       |  17 +-
 builtin/prune.c                              |   2 +-
 builtin/rebase.c                             |   2 +-
 builtin/receive-pack.c                       |   2 +-
 builtin/submodule--helper.c                  |  36 ++--
 builtin/tag.c                                |   2 +-
 builtin/unpack-objects.c                     |   5 +-
 builtin/update-ref.c                         |   2 +-
 builtin/worktree.c                           |   2 +-
 bulk-checkin.c                               |   4 +-
 combine-diff.c                               |   2 +-
 commit-graph.c                               |   9 +-
 commit.c                                     |   2 +-
 config.c                                     |   5 -
 csum-file.c                                  |  28 +--
 csum-file.h                                  |  12 +-
 delta-islands.c                              |  14 +-
 delta-islands.h                              |   2 +-
 diff-lib.c                                   |  10 +-
 diff-no-index.c                              |  28 +--
 diff.c                                       |  14 +-
 diff.h                                       |   2 +-
 dir.c                                        |   2 +-
 environment.c                                |   1 -
 environment.h                                |   1 -
 grep.c                                       |   2 +-
 hash.c                                       | 277 +++++++++++++++++++++++++
 hash.h                                       |   4 +-
 log-tree.c                                   |   2 +-
 merge-ort.c                                  |  26 +--
 merge-recursive.c                            |  12 +-
 meson.build                                  |   1 +
 midx-write.c                                 |  12 +-
 midx.c                                       |   3 +-
 notes-merge.c                                |   2 +-
 notes.c                                      |   2 +-
 object-file-convert.c                        |  29 +--
 object-file-convert.h                        |   3 +-
 object-file.c                                | 292 +--------------------------
 object.c                                     |  21 +-
 object.h                                     |  10 +-
 pack-bitmap-write.c                          |  36 ++--
 pack-bitmap.c                                |  15 +-
 pack-bitmap.h                                |   1 +
 pack-check.c                                 |  12 +-
 pack-revindex.c                              |  35 ++--
 pack-write.c                                 |  55 +++--
 pack.h                                       |  11 +-
 parse-options-cb.c                           |   2 +-
 range-diff.c                                 |   2 +-
 reachable.c                                  |   6 +-
 read-cache.c                                 |   4 +-
 refs.c                                       |  12 +-
 refs/debug.c                                 |   2 +-
 refs/files-backend.c                         |   2 +-
 repo-settings.c                              |  20 ++
 repo-settings.h                              |   5 +
 reset.c                                      |   2 +-
 revision.c                                   |   3 +-
 sequencer.c                                  |  10 +-
 shallow.c                                    |  10 +-
 streaming.c                                  |   3 +-
 submodule-config.c                           |   2 +-
 submodule.c                                  |  28 +--
 t/helper/test-ref-store.c                    |   2 +-
 t/helper/test-submodule-nested-repo-config.c |   2 +-
 t/t1050-large.sh                             |   3 +-
 tree-diff.c                                  |   4 +-
 upload-pack.c                                |  14 +-
 wt-status.c                                  |   4 +-
 xdiff-interface.c                            |   2 +-
 87 files changed, 676 insertions(+), 613 deletions(-)

Range-diff versus v1:

 1:  48ad4678dd2 =  1:  3fefb9537f1 csum-file: stop depending on `the_repository`
 2:  91843ef439a !  2:  11cf55dfa1d object: stop depending on `the_repository`
    @@ builtin/fsck.c: static void check_connectivity(void)
      
      	/* Look up all the requirements, warn about missing objects.. */
     -	max = get_max_object_index();
    -+	max = repo_get_max_object_index(the_repository);
    ++	max = get_max_object_index(the_repository);
      	if (verbose)
      		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
      
      	for (i = 0; i < max; i++) {
     -		struct object *obj = get_indexed_object(i);
    -+		struct object *obj = repo_get_indexed_object(the_repository, i);
    ++		struct object *obj = get_indexed_object(the_repository, i);
      
      		if (obj)
      			check_object(obj);
    @@ builtin/index-pack.c: static unsigned check_objects(void)
      	unsigned i, max, foreign_nr = 0;
      
     -	max = get_max_object_index();
    -+	max = repo_get_max_object_index(the_repository);
    ++	max = get_max_object_index(the_repository);
      
      	if (verbose)
      		progress = start_delayed_progress(the_repository,
    @@ builtin/index-pack.c: static unsigned check_objects(void)
      
      	for (i = 0; i < max; i++) {
     -		foreign_nr += check_object(get_indexed_object(i));
    -+		foreign_nr += check_object(repo_get_indexed_object(the_repository, i));
    ++		foreign_nr += check_object(get_indexed_object(the_repository, i));
      		display_progress(progress, i + 1);
      	}
      
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
      		int i, max;
      
     -		max = get_max_object_index();
    -+		max = repo_get_max_object_index(the_repository);
    ++		max = get_max_object_index(the_repository);
      		for (i = 0; i < max; i++) {
     -			struct object *obj = get_indexed_object(i);
    -+			struct object *obj = repo_get_indexed_object(the_repository, i);
    ++			struct object *obj = get_indexed_object(the_repository, i);
      			if (!obj || obj->type != OBJ_COMMIT)
      				continue;
      			show_name(obj, NULL,
    @@ object.c
      #include "loose.h"
      
     -unsigned int get_max_object_index(void)
    -+unsigned int repo_get_max_object_index(const struct repository *repo)
    ++unsigned int get_max_object_index(const struct repository *repo)
      {
     -	return the_repository->parsed_objects->obj_hash_size;
     +	return repo->parsed_objects->obj_hash_size;
      }
      
     -struct object *get_indexed_object(unsigned int idx)
    -+struct object *repo_get_indexed_object(const struct repository *repo,
    ++struct object *get_indexed_object(const struct repository *repo,
     +				       unsigned int idx)
      {
     -	return the_repository->parsed_objects->obj_hash[idx];
    @@ object.h: int type_from_string_gently(const char *str, ssize_t, int gentle);
       * Return the current number of buckets in the object hashmap.
       */
     -unsigned int get_max_object_index(void);
    -+unsigned int repo_get_max_object_index(const struct repository *repo);
    ++unsigned int get_max_object_index(const struct repository *repo);
      
      /*
       * Return the object from the specified bucket in the object hashmap.
       */
     -struct object *get_indexed_object(unsigned int);
    -+struct object *repo_get_indexed_object(const struct repository *repo,
    ++struct object *get_indexed_object(const struct repository *repo,
     +				       unsigned int);
      
      /*
    @@ shallow.c: static void paint_down(struct paint_info *info, const struct object_i
      	}
      
     -	nr = get_max_object_index();
    -+	nr = repo_get_max_object_index(the_repository);
    ++	nr = get_max_object_index(the_repository);
      	for (i = 0; i < nr; i++) {
     -		struct object *o = get_indexed_object(i);
    -+		struct object *o = repo_get_indexed_object(the_repository, i);
    ++		struct object *o = get_indexed_object(the_repository, i);
      		if (o && o->type == OBJ_COMMIT)
      			o->flags &= ~SEEN;
      	}
    @@ shallow.c: void assign_shallow_commits_to_refs(struct shallow_info *info,
      	 * (new) shallow commits.
      	 */
     -	nr = get_max_object_index();
    -+	nr = repo_get_max_object_index(the_repository);
    ++	nr = get_max_object_index(the_repository);
      	for (i = 0; i < nr; i++) {
     -		struct object *o = get_indexed_object(i);
    -+		struct object *o = repo_get_indexed_object(the_repository, i);
    ++		struct object *o = get_indexed_object(the_repository, i);
      		if (!o || o->type != OBJ_COMMIT)
      			continue;
      
    @@ upload-pack.c: static int do_reachable_revlist(struct child_process *cmd,
      
     -	for (i = get_max_object_index(); 0 < i; ) {
     -		o = get_indexed_object(--i);
    -+	for (i = repo_get_max_object_index(the_repository); 0 < i; ) {
    -+		o = repo_get_indexed_object(the_repository, --i);
    ++	for (i = get_max_object_index(the_repository); 0 < i; ) {
    ++		o = get_indexed_object(the_repository, --i);
      		if (!o)
      			continue;
      		if (reachable && o->type == OBJ_COMMIT)
    @@ upload-pack.c: static int get_reachable_list(struct upload_pack_data *data,
      	}
     -	for (i = get_max_object_index(); 0 < i; i--) {
     -		o = get_indexed_object(i - 1);
    -+	for (i = repo_get_max_object_index(the_repository); 0 < i; i--) {
    -+		o = repo_get_indexed_object(the_repository, i - 1);
    ++	for (i = get_max_object_index(the_repository); 0 < i; i--) {
    ++		o = get_indexed_object(the_repository, i - 1);
      		if (o && o->type == OBJ_COMMIT &&
      		    (o->flags & TMP_MARK)) {
      			add_object_array(o, NULL, reachable);
 3:  d88c3aa6fc5 =  3:  5f2dcc39b7d pack-write: stop depending on `the_repository` and `the_hash_algo`
 4:  be7bd50c73c !  4:  21677355fed environment: move access to "core.bigFileThreshold" into repo settings
    @@ Commit message
         Refactor the code so that we instead store the value in `struct
         repo_settings`, where the value is computed as-needed and cached.
     
    +    Note that this change requires us to adapt one test in t1050 that
    +    verifies that we die when parsing an invalid "core.bigFileThreshold"
    +    value. The exercised Git command doesn't use the value at all, and thus
    +    it won't hit the new code path that parses the value. This is addressed
    +    by using git-hash-object(1) instead, which does read the value.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## archive.c ##
 5:  349fd4a74f4 =  5:  def4ca73269 pack-check: stop depending on `the_repository`
 6:  dcc76a793a3 =  6:  cb8c7246af0 pack-revindex: stop depending on `the_repository`
 7:  5964138dad8 =  7:  d97ea8590af pack-bitmap-write: stop depending on `the_repository`
 8:  a35396c8981 !  8:  244d21ba448 object-file-convert: stop depending on `the_repository`
    @@ Commit message
         using `the_hash_algo`. All of these callsites are transitively called
         from `convert_object_file()`, which indeed has no repo as input.
     
    -    Refactor the function so that it receives a repository as parameter and
    -    pass it through to all internal functions to get rid of the dependency.
    -    Remove the `USE_THE_REPOSITORY_VARIABLE` define.
    +    Refactor the function so that it receives a repository as a parameter
    +    and pass it through to all internal functions to get rid of the
    +    dependency. Remove the `USE_THE_REPOSITORY_VARIABLE` define.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 9:  fdb9aebb23d !  9:  7f44a1ee7d6 delta-islands: stop depending on `the_repository`
    @@ Commit message
         using `the_hash_algo`.
     
         Refactor the code to stop using `the_repository`. In most cases this is
    -    trivial because we already had a repository availabe in the calling
    +    trivial because we already had a repository available in the calling
         context, with the only exception being `propagate_island_marks()`. Adapt
         it so that the repository gets passed in via a parameter.
     
10:  0db58f487f9 = 10:  df2a72c7a16 object-file: split out logic regarding hash algorithms
11:  0ce33b057d3 = 11:  b5cdfff5719 hash: fix "-Wsign-compare" warnings
12:  e5644afa940 = 12:  36d09bc2707 hash: stop depending on `the_repository` in `null_oid()`

---
base-commit: e2cb568e11f4ceb427ba4205e6b8a4426d26be12
change-id: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0

