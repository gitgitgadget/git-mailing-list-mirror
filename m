Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0434746C0
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935713; cv=none; b=ruPhlijKDthWFeUzBKvxHRuJSlo/2rfW1lrOi0IZNMzwYOUGXzmzhKRL2n7SPHZlFjGxoCyxtZCUA5NKqgZXhcy8xE+Zskm0pTHAR0BMGPKAltZrY5TjwIuPAn8DCuqHBT63ZQTJABgRJCAkozqjQOm/P15LgeOMMqFl0NDoncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935713; c=relaxed/simple;
	bh=jBVH1DKXwCuHpN/bWOIajoigmP5GpeDuQikVpJojaXA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IIPLuWTl7kNk14vNwNxV8deqssRCdqQQO1mdxVPt2Zb0M0Q3qOphFK3h+wyIMki3zNs9ONs4EzwXTSf2cmquaKWBHI2Mfr17gh5LMR0NMIihrybtWuohLNVyPrOutABES7bheJf7rDpiuKUHcd8vErjH8/4QcVNMUxxduVQ1eyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CwC+e+HH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iPP7P3nw; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CwC+e+HH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iPP7P3nw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ECBFB14000F5
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 06:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1790935709; x=1791022109; bh=xczkAnr/Kk
	V+Y3JmBH2N7oJwfBpi4neAiGRF7AQyLPw=; b=CwC+e+HHKZIiqPTyEQFt0b/2Up
	/d1aTvcM6FxZ6250hxYwOnpLPW84g22ogB2OtpT25ztdLqeNO/Hxy2Rqme8NbJ+9
	dB7JO5qYmfJ9Qf2DRcBttJDmBopZrZIT+S3GmOEPqZ4L8MK+ekjxIMCUsVzYywxQ
	jSISZJGeKldyiOaltKj3FDMvNA2hUi/na5J87DsMrB+dwwXdN2JVYvGOSotGsClC
	NbpFi31pCYMqpJ3f0pHNMmzAL4K7o2GNn713QWeSoBoRZcXFmC2NA3eedq35Aqht
	QIWuyhGtuZAKr1CIfz4MssQ4kfd6L7rwBRRSUSpf3KUuDaktC+3Zqq4yxl1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790935709; x=1791022109; bh=xczkAnr/KkV+Y3JmBH2N7oJwfBpi
	4neAiGRF7AQyLPw=; b=iPP7P3nwUQCy+O3tMhPec6ehe3kr60YmJg7SMcFiBQvO
	G1ZmToOmfkwSTjWeq9WT8CauAdarStj4yW0XOHzaBvqrsANcNlZWFNdV1H1sQXNK
	327MRJYg8g2VggcVc4gETpvaf1z36Q2/s/AmHagdNZNUG3YZVn+y80JI28kJ3vr7
	emZjQu9rxr3qGC1VxPgAmf3/FHgEsnC+YUC6zM4d4ntABNN6uO+t1vjDSwFenta+
	BZR8yR2T+hNi5uH/qV7YmS8yBlf/WtbuYPK0dqyuK5gXRPBD30h0X14EBwVwf0gV
	GbG+tTacXPtgt+8hVRMKJ2xCvc/zRJDkbXAvicwS8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935709; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IjFDLoW7ys0IRZbMUveNvWXfjvDBU0psAWN6UrO4ETo0vPK
	swpe7PqFozCYLjsBikoMXdkkQdKnCY6YGXa/v9SDaYZc5nzu8GG+Pr62iHyLsjv0
	ejVW2ryjLoe1+MHQIyHZFH5CgVAZhmadZH4bmPd2jnCvJk0lE7Otw1X2WDBoqHna
	HrcPrGCQ8XZpM5BJvawDMtbilJDd+AOWPGVjhCvb2nGJyi1FgIc3xudITBw2C0CK
	fVcY3LPSiPPhTniGOpGNJbEKefuXyoNs3I3XGvfmT+6s25fCb/M+jIJ7qVQE6hpn
	7MSUgpc6XHWsdzsR2cn1pDCpjHcSUWXSJEluhuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:+6pL5XLRvRy6GA+3iUtOjT3MvEcsQ86WHQywpbbiJqY=:jBVH1DKXwCuHpN/bWOIajoigmP5GpeDuQikVpJojaXA=;
X-ME-Sender: <xms:nYK_amXgsSRe3cBES2TmfcJcXAAEpf8n5FsrnXpG6NUA0kfMP7Fw9A>
    <xme:nYK_aphdE4knVAlYpyTRCP1DafZ_Ikjam0XRrNX3zOZXvJAavkHwqY_VvJw3wlpxL
    7kLXsHU4rSZS6chhYnhbJmJaGrJNcoi_Hzyfw8XkYWGVIpDstE6Ig>
X-ME-Received: <xmr:nYK_agDVl1euHu_NrfWTmrwjJ0yDj0IknLE_SHr04kdjMOrhrc57fw>
X-ME-Proxy-Cause: dmFkZTGavh3sbDXKcd0I1wZZMV6gUpbXyhLEzjlzRibAi3aOSLelFXHV6WBdebpWYQdxwV
    iVGdMRUpZSrVahjq9vKXrDQyDq6aqNtBAJQUTBiesVgeQlRMYtKGBpwEperwBoB2SC55Ui
    9pf/+mzenx9fZf3LpMushIekll/ns9X3XvSQVODiQGtCrDdHNfrMCJFMwgDhCV4GavokW7
    JLAe+26VLH1QqyLW413CjjMOXUESBf1vasoNs+653eH+MlugDNXufPLrEiHNIGauvgz7PA
    2j1qLXDBYrZCzdsSbsXFktKKuReyZ17po3Vo/NVxH87zQTFGUA8aLb67CX4TVCwftlvPZp
    xnL0mz6LJUGWPMCx8y7BjleP3uHduJC4Ex8XAryg44br6DnCDWlIRB2daqnxiLU6xNtL/M
    RD9igvK9fR/MVgihKVpByV9GLpspLiKG14uooWO989VGULCYUW7IAtW9eqJdhnGsRxXqMN
    wa6Rdx2KkJ7weDlQbbukjqPEHpkXXF+xCKf6Sif9VmVYM05I9w5qQ4zJVSY+ww6OH3SNQR
    Owk0p2aOHDARrBOwaoCFixl00KXG5BsyHQ6mR4L009ePGzfI7noXsc4M+fnh/1i1pGH/fZ
    8QcWEv+8dp6il+ns2RoOeFc2XtCNbLJT/Y84YfjVUZCs3gfChV7TIY/4tpQA
X-ME-Proxy: <xmx:nYK_aicyeXnbl5qPx-OkpnM0Py5qCMgPrIPevDDi2Bb8HuiEXXUZvg>
    <xmx:nYK_agdawkqNxig3Z6SGeRnaFB76cANTNhbJpZgFZ3Gx-gIuqCiBDw>
    <xmx:nYK_auiLwUOb33v4Syy8vIZREiaS2O91WhX_JJQ9jqn7PO2CnxBsNw>
    <xmx:nYK_akQL-vX9Q2JBTOXQQDysyHuTe1P0qDkFb8BO4SokUkmCy5khSg>
    <xmx:nYK_allZyoV6rm86yHxxY-POK632hVrR0NbzvjnpItEqh0aAOnmYYboP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b59d6ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/13] odb/source-files: move alternates into the backend
Date: Fri, 02 Oct 2026 12:08:11 +0200
Message-Id: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBBG4Vcps3YgxiDoq4iLmfavxktSMrEIp
 e9u1OW3OGchQ4kwOnYLFczRYk4N201H/VXSBRyHZvLO793BB57uxnlQfuYZLI+KkqTCOIhTUQR
 1445aPRWM8f07n85/20tv6Ot3R+v6AePMoe57AAAA
X-Change-ID: 20260924-pks-odb-move-alternates-4a0babe4b0f3
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

Originally, when designing pluggable object databases the goal was that
the object database can have multiple sources, and every source attached
to it could use a different backend. This would have allowed for quite a
lot of flexibility, as you could trivially mix and match different kinds
of object storages in whatever way you like.

But while well-intentioned, this design led to a bunch of conceptual
problems:

  - We're now trying to read objects in source order, whereas we
    previously tried to read objects via packfiles before trying to read
    them via loose objects. This led to a performance regression when
    using alternates or when using a quarantine directory.

  - Some data structures are supposed to only ever exist once, like for
    example bitmaps and commit graphs. At the same time, those data
    structures also span across the union of all objects, so they may
    cross sources.

  - It is unclear how we can extend GIT_OBJECT_DIRECTORY or
    GIT_ALTERNATE_OBJECT_DIRECTORIES to become backend-agnostic in a
    backwards-compatible way. In general, introducing an object storage
    extension into the current status quo where alternates may have to
    be extended to become generic was proving to be painful.

  - Some mechanisms of alternates assume way too much about how exactly
    their backends work. Alternate refs for example assume that the
    alternate is backed by a filesystem path, and that this filesystem
    path may also allow us to read references. This is not a given
    though, as backends may not even have local data at all.

In short, there are a bunch of conceptual mismatches when we have
alternates and pluggable object databases coexist. So while the original
idea was nice, it does not result in a system that is easy to reason
about.

This patch series corrects course by moving alternates into the "files"
backend itself so that they become another implementation detail. It's
unfortunately on the bigger side, and I'm sorry about that, but I
couldn't really find a way to split it up further in a sensible way.

Note that the above problems aren't fixed by this series yet, but it is
the prerequisite to fix them in subsequent patch series.

The series is built on top of c46c1e3772 (Start Git 2.98 cycle,
2026-09-30). Note that there's a couple of small merge conflicts with
"seen". These can be resolved as follows:

diff --cc builtin/multi-pack-index.c
index c48212290c,6b2e58f427..0000000000
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@@ -225,8 -225,9 +225,9 @@@ static int cmd_multi_pack_index_write(i
  
  	}
  
 -	ret = write_midx_file(source->packed, opts.preferred_pack,
 +	ret = write_midx_file(packed_source, opts.preferred_pack,
- 			      opts.refs_snapshot, opts.flags);
+ 			      opts.refs_snapshot, opts.incremental_base,
+ 			      opts.flags);
  
  	free(opts.refs_snapshot);
  	return ret;
diff --cc builtin/pack-objects.c
index ca3a891dfb,fb603059a9..0000000000
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@@ -4566,10 -4624,10 +4616,10 @@@ static int add_loose_object(const struc
   * add_object_entry will weed out duplicates, so we just add every
   * loose object we find.
   */
- static void add_unreachable_loose_objects(struct rev_info *revs)
+ static void add_unreachable_loose_objects(struct stdin_packs_context *ctx)
  {
 -	for_each_loose_file_in_source(the_repository->objects->sources,
 +	for_each_loose_file_in_source(the_repository->objects->source,
- 				      add_loose_object, NULL, NULL, revs);
+ 				      add_loose_object, NULL, NULL, ctx);
  }
  
  static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
diff --cc builtin/repack.c
index 5d06872d77,87f03b66d9..0000000000
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@@ -775,7 -809,7 +809,7 @@@ int cmd_repack(int argc
  
  		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
  			flags |= MIDX_WRITE_INCREMENTAL;
- 		write_midx_file(files->dirs->packed, NULL, NULL, flags);
 -		write_midx_file(files->packed, NULL, NULL, NULL, flags);
++		write_midx_file(files->dirs->packed, NULL, NULL, NULL, flags);
  	}
  
  cleanup:
diff --git a/repack-midx.c b/repack-midx.c
index d805802f04..7281003473 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -575,7 +575,7 @@ static int midx_compaction_step_include_packs(struct midx_compaction_step *step,
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, "%s/%s", opts->packdir, item->string);
-		p = packfile_store_load_pack(files->packed, path.buf, 1);
+		p = packfile_store_load_pack(files->dirs->packed, path.buf, 1);
 		if (!p || open_pack_index(p)) {
 			ret = error(_("cannot open index for %s"), path.buf);
 			goto out;

Thanks!

Patrick

---
Patrick Steinhardt (13):
      commit-graph: require resolved packfile paths for `stdin_packs`
      commit-graph: stop depending on `struct odb_source`
      odb/source-files: introduce `struct odb_files_dir`
      odb: refactor `odb_for_each_alternate()` to yield dirs
      odb: refactor `odb_find_source()` to yield dirs
      odb/source-files: add the ability to have multiple object dirs
      tmp-objdir: absorb logic to set and restore primary sources
      tmp-objdir: manage quarantine as an object directory
      tmp-objdir: replace primary source at creation time
      odb/source: make `will_destroy` an implementation detail
      odb/source-files: extract reading alternates
      odb/source-files: move alternates into the backend
      odb/source: drop `read_alternates` callback

 builtin/commit-graph.c      |  41 ++--
 builtin/commit.c            |   2 +-
 builtin/count-objects.c     |   6 +-
 builtin/fast-import.c       |  20 +-
 builtin/fetch.c             |   4 +-
 builtin/fsck.c              |   6 +-
 builtin/gc.c                |  15 +-
 builtin/index-pack.c        |   4 +-
 builtin/merge.c             |   2 +-
 builtin/multi-pack-index.c  |  48 ++---
 builtin/pack-objects.c      |  66 +++---
 builtin/prune.c             |   2 +-
 builtin/repack.c            |   4 +-
 builtin/submodule--helper.c |   7 +-
 bundle.c                    |   2 +-
 commit-graph.c              | 150 +++++++-------
 commit-graph.h              |  31 ++-
 diagnose.c                  |   8 +-
 fetch-pack.c                |   2 +-
 http-walker.c               |   4 +-
 http.c                      |  12 +-
 log-tree.c                  |   3 +-
 loose.c                     |  18 +-
 midx.c                      |  43 ++--
 object-file.c               |   8 +-
 odb.c                       | 439 +++++-----------------------------------
 odb.h                       |  62 +-----
 odb/source-files.c          | 482 ++++++++++++++++++++++++++++++++++++--------
 odb/source-files.h          |  65 +++++-
 odb/source-inmemory.c       |   7 -
 odb/source-loose.c          |   9 +-
 odb/source-loose.h          |   3 +
 odb/source-packed.c         |   7 -
 odb/source.c                |   5 +-
 odb/source.h                |  57 +-----
 odb/streaming.c             |   8 +-
 odb/transaction.c           |   2 +-
 pack-bitmap.c               |   8 +-
 packfile.c                  |  28 ++-
 packfile.h                  |  21 +-
 path.c                      |   2 +-
 prune-packed.c              |   2 +-
 repack-geometry.c           |   2 +-
 repack-midx.c               |   6 +-
 repack.c                    |   6 +-
 repository.c                |   4 +-
 setup.c                     |   2 +-
 t/helper/test-read-graph.c  |   5 +-
 t/helper/test-read-midx.c   |   8 +-
 t/t4216-log-bloom.sh        |   4 +-
 tmp-objdir.c                |  67 ++++--
 tmp-objdir.h                |  18 +-
 52 files changed, 883 insertions(+), 954 deletions(-)


---
base-commit: 2f92b2890ddaf3d7ea29470c02418271c1a4cd79
change-id: 20260924-pks-odb-move-alternates-4a0babe4b0f3

