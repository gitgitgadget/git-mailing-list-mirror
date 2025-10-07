Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0F1922F6
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834741; cv=none; b=d2RCKAHYtAl6inIuswxTyzQBBM4xGomT1Bd9YUtMuBFTovN1SFE9pj++jdKOPY8RmZjSB6CIzBteWjBvUMC8VzcHgmKxm9INN5qST7EyXVEu4Se+jE78GHrY/oB+Imi4rfCTI3Fzl4paaxM8X/7PSAqJrSYF0zQ3GDX+gA9ynCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834741; c=relaxed/simple;
	bh=BPynyckD5DV42BBgfTWI9VipEPfm2qf8KnZMllHsTjg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hoah1ULPuWZhaY7mmel/kRT8WR2G+Q0JRhxCtiraRsumxbA5jOMdFm9FUZ3voY/Sai1qyRsuUE3BIlHrjZ2eUWWtLLUiJtXDwuKk4P93Of0sPYlNSWlMOXotXHXNKnt6vDsIlz97lEB3H39pK/8RoSB2K+xdsN/NPZS6rsAJDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kvo9sYjG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=toF1iFyf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kvo9sYjG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="toF1iFyf"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 646477A00C0
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:58:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Oct 2025 06:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1759834738; x=1759921138; bh=OpkazQ/qeg
	i9QibcFjqB6Zc+zop61wIbLCz2ih6Lm8k=; b=kvo9sYjGkGj9Mly30Q/KytZQaE
	4qECsWHwzhXAOqLaxt6Dkq5/RCOOkVOnYf6R+skQKVmqIID3UcRL0ZKs2yFC4q7Y
	cxBSIj6+2I+gHD97x5plXXIJ2nrKsFMtoyMdIp/US3B5lWvhfJCNPcYoieY2H4OM
	IKxMIkb8uQ+7Y2UsAhTH3ChLb6XTzqxDnvi0NqZkGgvHYYX29sDcJad3Tzazj4Wl
	FdBemjFk9LxeR7vgr1l+7G3505z8A4+9GN6SDnD1XWslE3lh+wYeLa9fOv0Qpy+7
	J0Cj6Nnib/BWXV3TquZHhmcPeKOd2CllAGoVcT+qI6Y5JpnvwPqSLimGpQPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759834738; x=1759921138; bh=OpkazQ/qegi9QibcFjqB6Zc+zop6
	1wIbLCz2ih6Lm8k=; b=toF1iFyfeD7tEuWf2kNXAvAIHvH27HCV8ClCGdF5Zryq
	hDMY2EnUAu8aUGmoO8YnP3JM8FZ2iydCtSqzLi+sDc5Ie+0H2i7jeJQOemUCT9s0
	REmpJVsY89bjFQhJH3dH5GSCegkC745GknHHKhA8nyy4VHibtGCi/owaWFVueCX0
	pfLk0iz1Gn9jFiopcklcWJnOk5/4LjtE6FrQ6QcuL4YDHplw/sdmwQvAjqpbm+Nc
	WTmeDh2A5xM1gUdTJTAroRvuaojtbQ+2APBYGFEpljFEOSLS87wyFu0i9SN0rYEk
	c19WkfHn/tuKMIxFL6rp0jlDNfD+sVkhGCHDfvhzlQ==
X-ME-Sender: <xms:cvLkaIXiEfZwBr6J21NgsbT8Kbw0YVE5O_-psqXaIo_bKVk6L2FwdA>
    <xme:cvLkaDgFXaYVaDmUe4ZUgYBFHtp1W20kSxiC84H_WjfLoq5FM69dc8P3FmXiWhAJ4
    8-vx3p57aG0eMDF9TAPnRR0YcZiEOzoHuvLcr1mfKkNnoAAmsnMMw>
X-ME-Received: <xmr:cvLkaCD0DUQjmFiClCRC2l9bDbAUyiOP24zd5EJ_hpx_MX3VHG4PWzTnhaLc3R23iWuNqjrmJ0uTnoOz1rXDP6iESr8ILHsxkT_RnEi-DbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeehteeihfegfffgveejvdehtefffffhudetheeivedtgeffvddthfdtjefghfdt
    feenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cvLkaMcyO7k3Z8tujqzzaT81ii0ErisHT3mgq7TuJE0_cvOUc8JTeQ>
    <xmx:cvLkaCdebBCmWLvGNojEE7bPQyHTg9oFXU_z770t8lMP7YNZDwiesA>
    <xmx:cvLkaIgNWrrfZTziNijm2_RUD5lPkpzmoi-MPwA328mbyTDdG-9Q3g>
    <xmx:cvLkaGT83rgakYNrPJMBAZ30r3qC3lfU5ah-2fNZrldWbWxsytJ-5g>
    <xmx:cvLkaPnBjYJt7QmRHQ-f0U--JUTiBoYewDt415eXtAXR5IYGKhAdb6jT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:58:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8cc80be9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:58:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/13] refs: improvements and fixes for peeling tags
Date: Tue, 07 Oct 2025 12:58:37 +0200
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF3y5GgC/x2NwQrCQAwFf6Xk7IPdUsX6K+Jh2yY1VrZLUkQo/
 XcXj3OYmZ2cTdnp1uxk/FHXNVeIp4bGZ8ozQ6fK1Ib2HPp4xdChLA5jgeh7Y4MvWlCSueYZ6/D
 icXNImKJcknSpF6qxUgX9/kf3x3H8ABz3myp4AAAA
X-Change-ID: 20250918-b4-pks-ref-filter-skip-parsing-objects-f0d1f6af4a9f
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

originally, all I wanted to do was the last patch: a small performance
optimization that stops parsing objects in git-for-each-ref(1) unless we
really need to parse them. But that fix cause one specific test to fail,
and only with the reftable backend. So this led me down the rabbit hole
of tag peeling, ending up with this patch series.

The series is structured like follows:

  - Patches 1 to 7 refactor our codebase so that we don't have the
    `peel_iterated_object()` hack anymore. I just found it hard to
    follow and thought it shouldn't be too hard to get rid of it.

  - Patches 8 and 9 remove infrastructure that we don't need anymore
    after the first couple of patches.

  - Patches 10 to 12 fix a couple of issues with peeled tags that I
    found. The underlying issue is that tags store both the tagged
    object and their type, but this information may not match. We never
    verify the actual object type though when allocating the tagged
    object, so this only blows up much later.

  - Patch 13 was my original motivation, a small performance
    optimization.

I'm not particularly fond of the patches 10 to 12. It feels more like
playing whack-a-mole, and I very much assume that there still are edge
cases where we should properly verify the tagged object type. But
changing it in `parse_tag_buffer()` itself causes a bunch of tests to
fail where we intentionally create such corrupted tags. So I didn't
really dare to touch that part, to be honest.

If anybody has suggestions for an alternative approach I'd be very open
to it.

The topic is built on top of 45547b60ac (Merge branch 'master' of
https://github.com/j6t/gitk, 2025-10-05). There is a merge conflict with
tb/incremental-midx-part-3.1, which moves code from "builtin/repack.c"
into "repack-*.c".

The conflict can be solved by accepting "builtin/repack.c" from
tb/incremental-midx-part-3.1 and adding the below patch to
"repack-midx.c". I can also rebase on top of that series, but given that
it is rather huge it may take a while before it lands.

Thanks!

Patrick

diff --cc builtin/repack.c
index 873e21c35d,ad60c4290d..0000000000
--- a/builtin/repack.c
+++ b/builtin/repack.c
diff --git a/repack-midx.c b/repack-midx.c
index 6f6202c5bc..74bdfa3a6e 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -16,25 +16,23 @@ struct midx_snapshot_ref_data {
 	int preferred;
 };
 
-static int midx_snapshot_ref_one(const char *refname UNUSED,
-				 const char *referent UNUSED,
-				 const struct object_id *oid,
-				 int flag UNUSED, void *_data)
+static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
 {
 	struct midx_snapshot_ref_data *data = _data;
+	const struct object_id *maybe_peeled = ref->oid;
 	struct object_id peeled;
 
-	if (!peel_iterated_oid(data->repo, oid, &peeled))
-		oid = &peeled;
+	if (!reference_get_peeled_oid(data->repo, ref, &peeled))
+		maybe_peeled = &peeled;
 
-	if (oidset_insert(&data->seen, oid))
+	if (oidset_insert(&data->seen, maybe_peeled))
 		return 0; /* already seen */
 
-	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
+	if (odb_read_object_info(data->repo->objects, maybe_peeled, NULL) != OBJ_COMMIT)
 		return 0;
 
 	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
-		oid_to_hex(oid));
+		oid_to_hex(maybe_peeled));
 
 	return 0;
 }

---
Patrick Steinhardt (13):
      refs: introduce wrapper struct for `each_ref_fn`
      refs: introduce `.ref` field for the base iterator
      refs: refactor reference status flags
      refs: expose peeled object ID via the iterator
      upload-pack: convert to use `reference_get_peeled_oid()`
      ref-filter: propagate peeled object ID
      builtin/show-ref: convert to use `reference_get_peeled_oid()`
      refs: drop `current_ref_iter` hack
      refs: drop infrastructure to peel via iterators
      object: add flag to `peel_object()` to verify object type
      refs: don't store peeled object IDs for invalid tags
      ref-filter: detect broken tags when dereferencing them
      ref-filter: parse objects on demand

 bisect.c                    |  24 ++---
 builtin/bisect.c            |  17 +---
 builtin/checkout.c          |   6 +-
 builtin/describe.c          |  18 ++--
 builtin/fetch.c             |  13 +--
 builtin/fsck.c              |  33 +++---
 builtin/gc.c                |  15 ++-
 builtin/ls-remote.c         |   2 +-
 builtin/name-rev.c          |  17 ++--
 builtin/pack-objects.c      |  28 +++---
 builtin/receive-pack.c      |  13 ++-
 builtin/remote.c            |  44 ++++----
 builtin/repack.c            |  16 ++-
 builtin/replace.c           |  21 ++--
 builtin/rev-parse.c         |  12 +--
 builtin/show-branch.c       |  35 +++----
 builtin/show-ref.c          |  50 ++++-----
 builtin/submodule--helper.c |  10 +-
 builtin/tag.c               |   2 +-
 builtin/verify-tag.c        |   2 +-
 builtin/worktree.c          |   6 +-
 commit-graph.c              |  14 ++-
 delta-islands.c             |   9 +-
 fetch-pack.c                |  16 +--
 help.c                      |  10 +-
 http-backend.c              |  20 ++--
 log-tree.c                  |  24 ++---
 ls-refs.c                   |  36 ++++---
 midx-write.c                |  17 ++--
 negotiator/default.c        |   7 +-
 negotiator/skipping.c       |   7 +-
 notes.c                     |   8 +-
 object-name.c               |  10 +-
 object.c                    |  20 +++-
 object.h                    |  15 ++-
 pseudo-merge.c              |  21 ++--
 reachable.c                 |   9 +-
 ref-filter.c                | 239 ++++++++++++++++++++++++++++++--------------
 ref-filter.h                |   5 +-
 reflog.c                    |   9 +-
 refs.c                      |  85 +++++++++-------
 refs.h                      |  84 ++++++++++------
 refs/debug.c                |  17 +---
 refs/files-backend.c        |  71 +++++--------
 refs/iterator.c             |  73 +++-----------
 refs/packed-backend.c       |  72 +++++--------
 refs/ref-cache.c            |  18 +---
 refs/refs-internal.h        |  25 +----
 refs/reftable-backend.c     |  48 +++------
 remote.c                    |  27 +++--
 replace-object.c            |  16 ++-
 revision.c                  |  12 +--
 server-info.c               |  12 +--
 shallow.c                   |  16 +--
 submodule.c                 |  12 +--
 t/for-each-ref-tests.sh     |   4 +-
 t/helper/test-reach.c       |   2 +-
 t/helper/test-ref-store.c   |   5 +-
 t/pack-refs-tests.sh        |  32 ++++++
 t/t0610-reftable-basics.sh  |  28 ++++++
 tag.c                       |  12 ---
 tag.h                       |   1 -
 upload-pack.c               |  49 ++++-----
 walker.c                    |   8 +-
 worktree.c                  |  11 +-
 65 files changed, 791 insertions(+), 829 deletions(-)


---
base-commit: 45547b60aca32b45d2f1ef93462cf9df28637c13
change-id: 20250918-b4-pks-ref-filter-skip-parsing-objects-f0d1f6af4a9f

