Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3962C033C
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203780; cv=none; b=pepTL2X1qrlLyV2DpQc6SLJxFeiDRdkGL8rG22fbyAwWCVC3XsLd0vUgHySps2x6RoJkpNs6+PJmBJygJcHsF5dsYQLy+Q6X0k0kh9p3FQM30cb5ZJT20PuDxeus2mfVC+1rE8jgBGFONsmGAfd3iox+/h6k5yiH6FEj1QNICYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203780; c=relaxed/simple;
	bh=LoT2OO5kR9AVW0qUTv+mVgd30uT1kPJz9cuOCmQZq24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=X0/nR/Tz2rXmalTxhPbkaKwVQnFz4zEaTx7/1qY0FVe/5OprF+A8XU+Bn+eLRBzYahgVozMarrV+0dlcaMdXxBhFvy/KN1vCOgJn8ycO1ycSCPa3BicwxSzDyQEidxXvhNsbSlUO7Y7MbjoB0HzfU87FiqrZ6IrgTIDYONJZj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qG7qFw91; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wZzEesDp; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qG7qFw91";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wZzEesDp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 652EA138018A;
	Thu, 23 Oct 2025 03:16:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 23 Oct 2025 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203777;
	 x=1761210977; bh=gWbkWGWaCimLWewHl3JKMvYjyi67TnTn34uw1N4btzI=; b=
	qG7qFw91PIOQmvMYcXIQ/mBP4k7emFE/51u+MjfxepnAAYDlrREFnCW0z8G6ts84
	usOxV8McK1pU+SERJHFmjnUQStqwBEtiei2ibZ7+vlwyBcnkWt8rkH6gj1heWLWU
	02Kzcy88boqkY5qHISWAATXR7WVydX/i3nQZEkeQuoBi7BwhOTr4ffk8eUR+RG/r
	lMOcrqDO80EEE0oN6c8Lx4R2QAqcBWKJj5qJlL0mptBIKxUuH8cUDriFqZfc0ULc
	o56RgJt9274hB0OedB8CwiT/VZieLl4KMUmF/zeKFY/uhSuLfrseZ9MNmPk7fs5v
	9wGlbdz8j+ywhEnJprGRFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203777; x=
	1761210977; bh=gWbkWGWaCimLWewHl3JKMvYjyi67TnTn34uw1N4btzI=; b=w
	ZzEesDpHL+neopYyRvRtq+IYOgMtNh5pAaviRu2ViYLN4bAi1opl+aKOGQLVDbp8
	p8HqxJY2emEDO0xlpBo7VQApQuvB3ECXgnjPdJJTyC/AvNQFFXMb/K4U4j5hzqIx
	d8OY6PPvDnq2rtZOWEHiVfivPValOENgCYmWbM/sS0VCBoZJJT7mlyA87fwZbX9D
	gqOcYWCDruhVa/mzqRrrn6lTxrm8kGgI8uHYPi+b7Kk1KgVaLWCZNBtSVagK9/1e
	sV7DEVbGhkl8UAztR7ggeh+syfa6ATovaYi+Hj2DGUU6BHZvF8UElX7Gzi0StyRD
	fynGh7TbnOLmEEO6i0GNA==
X-ME-Sender: <xms:Qdb5aOrlRlb139jHQOiWdxoIiB1FKYwNzZym7ZguixKWwC4SfaQBMQ>
    <xme:Qdb5aFF7O5ca8ltAvV0T9HKkaNyh5mZE9LXT0baZpBXMh3ekwu9031oawWgnLBQxR
    aCPDirPk_ywsj7lWhBnPIcZDEdBMte_6glx03-hRCBgkm7_XGxagw>
X-ME-Received: <xmr:Qdb5aDq3t6WZv1b2MchUy9D2EmRgl6Re69oGLb4onFHgdFzPPtJmK3xJ5neX5vmOoLP_NYs9Cs-czaBlKo9bFsDoS2hWBxWS-FNsdFT2rm04wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeu
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Qdb5aObuxDkaURaO1zahCltW5gy01ptSqIwz-kDobnGnq11Rensm1g>
    <xmx:Qdb5aMV6tMZeA7vndJ5r8DZ3a41Qxw59SUaZbj0FUZ3hzLEYhP45ag>
    <xmx:Qdb5aH-6ydLktx8nco5Ufq5865hpIH8KRiyhMLVBkfjE7wAmPm_ObQ>
    <xmx:Qdb5aF-GVAv0wVmydJDWL7kzhykScpQS3ampQn3hsS6yo3STckFhqg>
    <xmx:Qdb5aAIyVxGP-oOiQ97ZNQB5uz3Y6OwS4NUucmP_BIi2guZiYxOOPF5H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 751a8200 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/14] refs: improvements and fixes for peeling tags
Date: Thu, 23 Oct 2025 09:16:09 +0200
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADnW+WgC/43OQQ6CMBAF0KuQrh3TFijUlfcwLqBMdUSBtKTRE
 O5uYWFwx/JP8t+fiXl0hJ6dkok5DOSp72LIDgkz96q7IVATM5Nc5lyLEuoMhtaDQwuWniM68C0
 NMFTOU3eDvn6gGT1Y3girKptV2rKIDbFA73Xoco35Tn7s3WfdDWK5rhOC82LvRBDAQQtlTGFUW
 ar6HFtHerHFD3Jr7n47yGgWClPe5Ebnmfwz040p5W4zjSbW2hZClzla/jPnef4CuSeJFoEBAAA
 =
X-Change-ID: 20250918-b4-pks-ref-filter-skip-parsing-objects-f0d1f6af4a9f
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Hi,

originally, all I wanted to do was the last patch: a small performance
optimization that stops parsing objects in git-for-each-ref(1) unless we
really need to parse them. But that fix cause one specific test to fail,
and only with the reftable backend. So this led me down the rabbit hole
of tag peeling, ending up with this patch series.

The series is structured like follows:

  - Patches 1 to 8 refactor our codebase so that we don't have the
    `peel_iterated_object()` hack anymore. I just found it hard to
    follow and thought it shouldn't be too hard to get rid of it.

  - Patches 9 and 10 remove infrastructure that we don't need anymore
    after the first couple of patches.

  - Patches 11 to 13 fix a couple of issues with peeled tags that I
    found. The underlying issue is that tags store both the tagged
    object and their type, but this information may not match. We never
    verify the actual object type though when allocating the tagged
    object, so this only blows up much later.

  - Patch 14 was my original motivation, a small performance
    optimization.

I'm not particularly fond of the patches 11 to 13. It feels more like
playing whack-a-mole, and I very much assume that there still are edge
cases where we should properly verify the tagged object type. But
changing it in `parse_tag_buffer()` itself causes a bunch of tests to
fail where we intentionally create such corrupted tags. So I didn't
really dare to touch that part, to be honest.

If anybody has suggestions for an alternative approach I'd be very open
to it.

Changes in v4:
  - Improve `get_or_parse_object()` to have better ergonomics.
  - Link to v3: https://lore.kernel.org/r/20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im

Changes in v3:
  - I've rebuilt the topic on 133d151831 (The twenty-first batch, 2025-10-20) with
        - tb/incremental-midx-part-3.1 at 935ab44a0a (builtin/repack.c:
          clean up unused `#include`s, 2025-10-15)
        - jt/repo-structure 16a93c03c7 at (builtin/repo: add progress meter for
          structure stats, 2025-10-21)
    merged into it. This is done to fix a couple of merge conflicts with
    "seen". Both of the topics are only in "seen" right now, but they
    are close to be merged.
  - Link to v2: https://lore.kernel.org/r/20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im

Changes in v2:
  - A couple of improvements to commit messages.
  - A new commit that ensures that `struct ref_iterator::ref` is always
    zeroed out to protect against stale state.
  - Link to v1: https://lore.kernel.org/r/20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (14):
      refs: introduce wrapper struct for `each_ref_fn`
      refs: introduce `.ref` field for the base iterator
      refs: fully reset `struct ref_iterator::ref` on iteration
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
 builtin/fsck.c              |  33 ++++---
 builtin/gc.c                |  15 ++-
 builtin/ls-remote.c         |   2 +-
 builtin/name-rev.c          |  17 ++--
 builtin/pack-objects.c      |  28 +++---
 builtin/receive-pack.c      |  13 ++-
 builtin/remote.c            |  44 ++++-----
 builtin/replace.c           |  21 ++---
 builtin/repo.c              |   9 +-
 builtin/rev-parse.c         |  12 +--
 builtin/show-branch.c       |  35 ++++---
 builtin/show-ref.c          |  50 +++++-----
 builtin/submodule--helper.c |  10 +-
 builtin/tag.c               |   2 +-
 builtin/verify-tag.c        |   2 +-
 builtin/worktree.c          |   6 +-
 commit-graph.c              |  14 ++-
 delta-islands.c             |   9 +-
 fetch-pack.c                |  16 +---
 help.c                      |  10 +-
 http-backend.c              |  20 ++--
 log-tree.c                  |  24 +++--
 ls-refs.c                   |  36 ++++---
 midx-write.c                |  17 ++--
 negotiator/default.c        |   7 +-
 negotiator/skipping.c       |   7 +-
 notes.c                     |   8 +-
 object-name.c               |  10 +-
 object.c                    |  20 +++-
 object.h                    |  15 ++-
 pseudo-merge.c              |  21 ++---
 reachable.c                 |   9 +-
 ref-filter.c                | 225 ++++++++++++++++++++++++++++++--------------
 ref-filter.h                |   5 +-
 reflog.c                    |   9 +-
 refs.c                      |  85 +++++++++--------
 refs.h                      |  88 ++++++++++-------
 refs/debug.c                |  17 +---
 refs/files-backend.c        |  71 +++++---------
 refs/iterator.c             |  73 +++-----------
 refs/packed-backend.c       |  71 +++++---------
 refs/ref-cache.c            |  18 +---
 refs/refs-internal.h        |  25 +----
 refs/reftable-backend.c     |  47 +++------
 remote.c                    |  27 +++---
 repack-midx.c               |  16 ++--
 replace-object.c            |  16 ++--
 revision.c                  |  12 +--
 server-info.c               |  12 +--
 shallow.c                   |  16 +---
 submodule.c                 |  12 +--
 t/for-each-ref-tests.sh     |   4 +-
 t/helper/test-reach.c       |   2 +-
 t/helper/test-ref-store.c   |   5 +-
 t/pack-refs-tests.sh        |  32 +++++++
 t/t0610-reftable-basics.sh  |  28 ++++++
 tag.c                       |  12 ---
 tag.h                       |   1 -
 upload-pack.c               |  49 +++++-----
 walker.c                    |   8 +-
 worktree.c                  |  11 ++-
 66 files changed, 783 insertions(+), 834 deletions(-)

Range-diff versus v3:

 1:  3c95bfae6a0 =  1:  a8aafa4392b refs: introduce wrapper struct for `each_ref_fn`
 2:  f8a24267571 =  2:  cf5faae21bd refs: introduce `.ref` field for the base iterator
 3:  e4e576977bf =  3:  c0715cf44d8 refs: fully reset `struct ref_iterator::ref` on iteration
 4:  ea00af0721f =  4:  52f65b25e89 refs: refactor reference status flags
 5:  c3254472ddc =  5:  230cc4e7431 refs: expose peeled object ID via the iterator
 6:  9df9622a93c =  6:  bca033ba86d upload-pack: convert to use `reference_get_peeled_oid()`
 7:  b09a02a7f53 =  7:  fa914f4cede ref-filter: propagate peeled object ID
 8:  160788e6a7c =  8:  1d9ba79bcf7 builtin/show-ref: convert to use `reference_get_peeled_oid()`
 9:  f5793b2f1af =  9:  8451059caff refs: drop `current_ref_iter` hack
10:  a467e8f55d1 = 10:  de3e67c31d2 refs: drop infrastructure to peel via iterators
11:  49f45d1d680 = 11:  8782d6729df object: add flag to `peel_object()` to verify object type
12:  4e355684a9a = 12:  ba7f85c8fef refs: don't store peeled object IDs for invalid tags
13:  1f709cd4b9c = 13:  74ad4413535 ref-filter: detect broken tags when dereferencing them
14:  ef24fc33852 ! 14:  e833e9943e2 ref-filter: parse objects on demand
    @@ ref-filter.c: static void grab_common_values(struct atom_value *val, int deref,
      	}
      }
      
    -+static int get_or_parse_object(struct expand_data *data, const char *refname,
    -+			       struct object **object, struct strbuf *err, int *eaten)
    ++static struct object *get_or_parse_object(struct expand_data *data, const char *refname,
    ++					  struct strbuf *err, int *eaten)
     +{
     +	if (!data->maybe_object) {
     +		data->maybe_object = parse_object_buffer(the_repository, &data->oid, data->type,
     +							 data->size, data->content, eaten);
    -+		if (!data->maybe_object)
    -+			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
    -+					       oid_to_hex(&data->oid), refname);
    ++		if (!data->maybe_object) {
    ++			strbuf_addf(err, _("parse_object_buffer failed on %s for %s"),
    ++				    oid_to_hex(&data->oid), refname);
    ++			return NULL;
    ++		}
     +	}
     +
    -+	*object = data->maybe_object;
    -+	return 0;
    ++	return data->maybe_object;
     +}
     +
      /* See grab_values */
    @@ ref-filter.c: static void grab_common_values(struct atom_value *val, int deref,
     +			   struct expand_data *data, const char *refname,
     +			   struct strbuf *err, int *eaten)
      {
    --	int i;
    --	struct tag *tag = (struct tag *) obj;
     +	struct tag *tag = NULL;
    -+	int i, ret;
    + 	int i;
    +-	struct tag *tag = (struct tag *) obj;
      
      	for (i = 0; i < used_atom_cnt; i++) {
      		const char *name = used_atom[i].name;
    @@ ref-filter.c: static void grab_tag_values(struct atom_value *val, int deref, str
      			continue;
     +
     +		if (!tag) {
    -+			struct object *object;
    -+
    -+			ret = get_or_parse_object(data, refname, &object, err, eaten);
    -+			if (ret < 0)
    -+				return ret;
    -+
    -+			tag = (struct tag *) object;
    ++			tag = (struct tag *) get_or_parse_object(data, refname,
    ++								 err, eaten);
    ++			if (!tag)
    ++				return -1;
     +		}
     +
      		if (deref)
    @@ ref-filter.c: static void grab_tag_values(struct atom_value *val, int deref, str
     +			      struct expand_data *data, const char *refname,
     +			      struct strbuf *err, int *eaten)
      {
    --	int i;
    + 	int i;
     -	struct commit *commit = (struct commit *) obj;
    -+	int i, ret;
     +	struct commit *commit = NULL;
      
      	for (i = 0; i < used_atom_cnt; i++) {
    @@ ref-filter.c: static void grab_tag_values(struct atom_value *val, int deref, str
      			name++;
     +
     +		if (!commit) {
    -+			struct object *object;
    -+
    -+			ret = get_or_parse_object(data, refname, &object, err, eaten);
    -+			if (ret < 0)
    -+				return ret;
    -+
    -+			commit = (struct commit *) object;
    ++			commit = (struct commit *) get_or_parse_object(data, refname,
    ++								       err, eaten);
    ++			if (!commit)
    ++				return -1;
     +		}
     +
      		if (atom_type == ATOM_TREE &&
    @@ ref-filter.c: static void grab_person(const char *who, struct atom_value *val, i
     +			  struct expand_data *data, const char *refname,
     +			  struct strbuf *err, int *eaten)
      {
    --	int i;
    + 	int i;
     -	struct commit *commit = (struct commit *) obj;
    -+	int i, ret;
     +	struct commit *commit = NULL;
      	struct signature_check sigc = { 0 };
      	int signature_checked = 0;
    @@ ref-filter.c: static void grab_signature(struct atom_value *val, int deref, stru
      
      		if (!signature_checked) {
     +			if (!commit) {
    -+				struct object *object;
    -+
    -+				ret = get_or_parse_object(data, refname, &object, err, eaten);
    -+				if (ret < 0)
    -+					return ret;
    -+
    -+				commit = (struct commit *) object;
    ++				commit = (struct commit *) get_or_parse_object(data, refname,
    ++									       err, eaten);
    ++				if (!commit)
    ++					return -1;
     +			}
     +
      			check_commit_signature(commit, &sigc);

---
base-commit: 5c120f01eb88f4be8b06fd4bc6893763204b78c4
change-id: 20250918-b4-pks-ref-filter-skip-parsing-objects-f0d1f6af4a9f

