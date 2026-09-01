Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D6476CEA
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260977; cv=none; b=JXXEWmVrGy2L7txKFE07p/NJkVTTuNilyiC9/fCQwFq0hAkYu8aDocV7cc3NpYj0ajTrMNzk9uCa8iYrvAtwYhbp0rePU0wS8T9cFJn3ngaaiL9yNgh/y5ZNq7zUn0KKcXdE3pwd3K/CTusKXE22vues5+9GHOQOCCc9J47qc5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260977; c=relaxed/simple;
	bh=ZCzEhC0letUVBCVVWSmnbpiAbDnBmU8TnWsiWng9VIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rK5CFDN/fE1BZ/b+6KmC/har7gO0PW2js7aICYPtj3ZYxSGA9MmcMcnav26lua92/u/fp3/4HuBx4hoZvD+mOidbwuwS4+QoER3O9hazBrKd5WZ/s99wZo7YJjoAHl9nt83zrEMu/Ww4Opkjr+pQK2xwZqpLx3Jwqc/uIu+ew6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jF8g+/og; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kqWh8zmj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jF8g+/og";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kqWh8zmj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7CA014000B0
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Sep 2026 07:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1788260974; x=1788347374; bh=JAP6qpoGAd
	H9Au8McGBkEIwFso50400kWHtWtL2+Pz8=; b=jF8g+/oggV04PJMV30Wxll6/ms
	H7EXSq/t3yS+YiuH2e8k1TjXkhZY+8zPAkJ1+pYVHcPfuN/gGwd76veLOUHU33+q
	w30Wdx6DGzG3Ub5Ll72cxeoD1p6diz7kUF6f54wovA8+z+WJGF1oCfykfRh4v5nQ
	kqURul+i0tjs/mJrCBrQ6p4cj+cA/tuuR9OYAAFyKxOi2liWuzla7ikBdmYXUHFU
	WCK9yaGVVkK8jXTb7Pyo457DbwV1Aq+KNGvHFUVlEfIP9OhXQuIi0P2bRvdOs8dT
	i1gVb1/glUy/NlRUljy/knvv3bPUweox7JeMA7uF2/p5RmUNCmVYcCKijGew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788260974; x=1788347374; bh=JAP6qpoGAdH9Au8McGBkEIwFso50
	400kWHtWtL2+Pz8=; b=kqWh8zmjgAWYJqSRAdOaRq18cCYQOUld/Lmc0I2ZJLf2
	+UcsEnza+0nWEjkdJyHu3Mz664mcm3PP2p9g+QOdlMmREqMEsGzfkS0uoIUCGYG5
	n5yPOgm2v/eNwdOJjfvjuzLdQL6E/xn2pmQvv0QuLG7z3ssv3hfDU8lEhLw3Nnd4
	/tHgZGFGPo/D2+JNBwvJ22tE+4snJdNgto3+EeR2vWZ0xV6OUW1A1xYB+xUwe83c
	3QC7W0G0nlS3k/lajj4zRKSmDCIU//tJZcUtWsdjkNP3cXFyNAIBfB4aNFXcOBKX
	GeCiFbNSOWwFzwEYryuA8CXplBV0G0TrmNlw9bTCJg==
X-ME-Sender: <xms:brKWanxo8JVDrTRAWSevyn77bs9zd3bviwZ_1D57flWOL_GDko6tuQ>
    <xme:brKWamP5K1ZnD-cFm1BUuYDt-nbPgJ_0kFHZ2pRQHdFaw6UBurXtJwn33BxMFJxoU
    Ojd_XCGeOqw28--IiJH-0yYs6lcsIg0fGb3eXvtyRi7o4-usZm1VHg>
X-ME-Received: <xmr:brKWam-MLnDks_Ir-difhaaZUVDAPW4b-Gn5YCYTHBmvp8hNPHMl1w>
X-ME-Proxy-Cause: dmFkZTFOajwBC/jH03XiAdbytK9oKj2OGSQ0bNqD+QTI0+yYUmNp61f4ntwsm+rmTTfaT2
    wxoLZ0ouLrTTZ+OY8F2h6M9IdeCLgJJs8CXFb7By6pAnrvzA2HuMm5ft8e2lbzkBAVKrar
    iePwmBVpS2PclJOEfn5lrLdxjgRxbX8xbkwxseSJUnLfGGSo57K/KrLeZmHa2FQEniEAdY
    7CVS3kz/lHR/Ugad9lilukr6h5GGA9AYlGU1a+Sql4R8U762vTfevyw98rcmMrvNJqydDs
    luzZidUuJX1HT5+QUPDCoYhK8vWAqaLDGcrnqws/cwTmbE6NPvc5lePNxwLpVUXsHt0VRx
    uzPL9JA3YLVNraX3jNWk4z/NZQvY8mfddvJlIx+qtEDxJDF9WRGRkrIctR2heywhcCFjA9
    ycihFv/pDlK1TAU1fMgGo2mbxsWtOaeuoL2KC80vj2ATnN2T/Lf+Ncrs9jaMdvKa47gweW
    eT4g5KLVL8Sy+Pmu/XEJ/B05kN9TTAKkFObuekJAELKRfe+SRVlXDLwUyWsmCyyGXtQY1E
    liiDx8nFzngEPt6T9loQYs6XBhngEc7Za2ERCfdoTGndkFRP883cROZM9jaUtx45MnF3VJ
    RmiYMIr3Jbx8Lk8irASofDuZK+BFrbR1IQuUwUvd9mVwRWB7xMrPjvNeZ/4w
X-ME-Proxy: <xmx:brKWamoGx7af7u2CoClwN6T_qvC71zeJhPNjYprZLwDYHARm9FqE8w>
    <xmx:brKWao7sXRkyDrShcKvxhjwe-Z2x_9PB1nvwbTN-_nugGv60CBLDsw>
    <xmx:brKWamM5GCigoIVZ0fePXayJ-4VWYabDPeyq9Kkrp9q_5VgroJBe1g>
    <xmx:brKWaqNqIqYus3x8g3G6DA0j0aLNkR4I2ikBqOX7GS67o2OMjXsCIg>
    <xmx:brKWalzEkQD-OJoq0OFM2cqc1vPXlw65h7JmAi9uj0i7v2v4dXnTp1RI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf0aab23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:09:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/12] odb: stop registering in-memory sources
Date: Tue, 01 Sep 2026 13:08:59 +0200
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBCF4auQWTsJRcHqVYwLaYcyGloyA0ZDu
 DtFl9/i/W8BJWFSuBYLCL1ZOcUMcyjA9Y8YCNlnQ1VWTWmNwfGlmHyLQoF1yuMYkCMONCT5oqZ
 ZHCla25ys85f6fKwht0ahjj+/n9v9b53bJ7lpj8O6blLbLEmJAAAA
X-Change-ID: 20260811-pks-odb-registering-in-memory-sources-88648cd95735
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

the object database has a list of sources that is used for two
different purposes:

  - We use it to track the list of alternates.

  - We use it to track temporary in-memory sources that we create for
    various purposes. Most importantly, this is used to link object
    database sources from submodules into the main store.

This dual-use is quite awkward, as it mixes two different levels of
concerns and thus as a consequence makes both harder to reason about.
It's also a source of bugs: we make assumptions about the ordering of
sources all over the place, and we furthermore assume in other places
that the sources only contain alternates in the first place. I don't
think this surfaces in the form of real bugs, but I've long disliked
this dual-use.

Furthermore, we want to migrate handling of alternates into the "files"
backend itself in a subsequent patch series. This is most importantly to
fix a performance regression by making the backend own all of its
alternates, but it also fixes a couple of longer-standing design issues
that I've been struggling with [1].

Most importantly though: this whole machinery is not even needed at all.
A couple years ago we have already refactored our codebase so that
submodule sources don't even have to be linked into the main object
database anymore. And all the other use cases where we link sources into
the main object database can be trivially converted, too.

So this patch series does exactly that: it removes the mechanism to link
ad-hoc sources into the object database entirely. This ensures that the
list of sources is exactly the list of alternates, and that makes it
easier to move them into the "files" backend in a subsequent patch
series.

There is one exception though: creating transactions still creates a
temporary quarantine directory. This mechanism is left as-is for now,
but as it's an implementation detail of the "files" backend anyway
that's not conflicting with our above stated goals.

This series is built on top of 1630431f32 (The 21st batch, 2026-08-31)
with ty/repository-fetch-if-missing at 508ec9837c (repository: move
fetch_if_missing into struct repository, 2026-08-15) merged into it.
There's still two merge conflicts, but these are trivial to resolve: in
"odb.c" and "odb.h" you simply remove both ours and theirs, and in
"builtin/multi-pack-index.c" you only need to munge the parameters a
bit. I've attached a patch below that shows the resolution.

Thanks!

Patrick

[1]: <amLgMqkqxR8mKIbT@pks.im>

diff --cc builtin/multi-pack-index.c
index dc8561a83b,84d2467cc7..0000000000
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@@ -230,11 -224,10 +230,12 @@@ static int cmd_multi_pack_index_write(i
  
  	}
  
- 	ret = write_midx_file(source, opts.preferred_pack,
- 			      opts.refs_snapshot, opts.flags);
 -	ret = write_midx_file(source->packed, opts.preferred_pack,
++	ret = write_midx_file(source, opts.preferred_pack,
+ 			      opts.refs_snapshot, opts.incremental_base,
+ 			      opts.flags);
  
 +	if (created)
 +		odb_source_free(&source->base);
  	free(opts.refs_snapshot);
  	return ret;
  }
diff --cc odb.c
index 5fe081496f,0cf99efe94..0000000000
--- a/odb.c
+++ b/odb.c
@@@ -238,15 -239,12 +239,6 @@@ static struct odb_source *odb_add_alter
  	return alternate;
  }
  
- void odb_add_to_alternates_file(struct object_database *odb,
- 				const char *dir)
 -struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 -						const char *dir)
--{
- 	int ret = odb_source_write_alternate(odb->sources, dir);
- 	if (ret < 0)
- 		die(NULL);
- 	odb_add_alternate_recursively(odb, dir, 0);
 -	return odb_add_alternate_recursively(odb, dir, 0);
--}
--
  struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
  						    const char *dir, int will_destroy,
  						    struct odb_source **prev_source)
diff --cc odb.h
index 9025239df5,862f373467..0000000000
--- a/odb.h
+++ b/odb.h
@@@ -251,13 -302,14 +288,6 @@@ int odb_mkstemp(struct object_database 
   */
  int odb_has_alternates(struct object_database *odb);
  
--/*
-  * Add the directory to the on-disk alternates file; the new entry will also
-  * take effect in the current process.
 - * Add the directory to the in-memory list of alternate sources (along with any
 - * recursive alternates it points to), but do not modify the on-disk alternates
 - * file.
-- */
- void odb_add_to_alternates_file(struct object_database *odb,
- 				const char *dir);
 -struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 -						const char *dir);
--
  /*
   * Read an object from the database. Returns the object data and assigns object
   * type and size to the `type` and `size` pointers, if these pointers are

---
Patrick Steinhardt (12):
      cache-tree: remove dependency on `the_repository`
      submodule-config: remove uses of `the_repository`
      submodule-config: stop using `the_hash_algo`
      submodule-config: stop registering submodule sources
      builtin/grep: stop registering submodule ODB as source
      odb: remove infrastructure to register submodule sources
      tmp-objdir: drop unused function to register alternate
      odb/packed: fix memory leaks when freeing source
      builtin/multi-pack-index: refuse unknown sources with "--object-dir="
      t/helper: adapt read-midx to not link ad-hoc source anymore
      t/helper: stop registering alternates in "ref-store" command
      odb: remove the ability to link sources ad-hoc

 builtin/checkout.c                     |  2 +-
 builtin/commit.c                       |  2 +-
 builtin/fetch.c                        |  2 +-
 builtin/grep.c                         | 28 +++--------
 builtin/multi-pack-index.c             |  3 +-
 builtin/submodule--helper.c            |  8 ++--
 cache-tree.c                           | 88 ++++++++++++++++++----------------
 cache-tree.h                           |  7 +--
 odb.c                                  | 42 ----------------
 odb.h                                  | 22 ---------
 odb/source-packed.c                    |  1 +
 read-cache-ll.h                        |  5 +-
 read-cache.c                           |  9 ++--
 sequencer.c                            |  2 +-
 sparse-index.c                         |  2 +-
 submodule-config.c                     | 59 ++++++++++++-----------
 submodule-config.h                     | 12 +++--
 submodule.c                            |  2 +-
 t/README                               |  7 ---
 t/helper/test-read-midx.c              | 43 ++++++++++++-----
 t/helper/test-ref-store.c              |  8 ----
 t/helper/test-submodule.c              |  4 +-
 t/t5319-multi-pack-index.sh            |  9 ++--
 t/t5526-fetch-submodules.sh            |  3 --
 t/t5531-deep-submodule-push.sh         |  3 --
 t/t5545-push-options.sh                |  3 --
 t/t5572-pull-submodule.sh              |  3 --
 t/t6437-submodule-merge.sh             |  3 --
 t/t7418-submodule-sparse-gitmodules.sh |  3 --
 t/t7814-grep-recurse-submodules.sh     |  3 --
 tmp-objdir.c                           |  5 --
 tmp-objdir.h                           |  6 ---
 unpack-trees.c                         |  9 ++--
 33 files changed, 161 insertions(+), 247 deletions(-)


---
base-commit: e5d60560f61f520e9ea350645a6cc9770b0f1607
change-id: 20260811-pks-odb-registering-in-memory-sources-88648cd95735

