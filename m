Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B121146C
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300774; cv=none; b=uyWvT7L2qbJkVfn6/EycJF1blWj7IEdeKscey6yi97LbMf2naXnGq9/Ji0GidPZUnoTUlrqV74AdfniMhUJMahRsWAAmRl76krLquhrVE8sPMl6rvdE2R7X7XUCf2IWleerM9DqZIo/316KkRpM/RHjGSs7Mh2EOXwcqV7w03jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300774; c=relaxed/simple;
	bh=z3OmaVxFNXUgH37kTjsGzoe+Nj4xI+3KNkXr9xuoxpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=peuOz5yD2o8YCfMmlPPMOGpop1awOBpWuVegGWbE5sGIKbdBS37onkV2nDzckAmK46sLGi3sXc2wvZEEjd408NM4ppijYWqI44IJqdQ95BbrM6kVDpeX2JfNsn+j0M5det01YKw5SnRUTksCcaPEIKd1NdcyesMW195xCPqiALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=frfrryLN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQUFBIgo; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="frfrryLN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQUFBIgo"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1DC2E1D0008E;
	Mon,  4 Aug 2025 05:46:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 05:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300771;
	 x=1754387171; bh=Lnj3wac14QjCxMNkgb7vSlRGq/fvWC8yhAsl616v7bg=; b=
	frfrryLN0v+10aM775UUxvAlQ9okH9cNuJYSld5Kcu3Ep637QqiExBazVJ+ATFMp
	ROyUlBUFQUh57oPZffXUiYY1+v6KXikR4Yj18OmoMosyPOWdiTnKs3tJCwNRmqUs
	98gkVfZYO2gVHBwfOK8oh2VFG5bhihhVze7u7J0Ozrx34VsIyCrC7UHzS4sGwyNy
	D6LAMDknFRe3DG53SYQFpPiaOwZCAnlYZUD51D4JR+s6fO2JrIBseTFb72WC/PK0
	bsbXuMea8GR5stXStKNRVvAuTkY5xKs2k/JvrQly3QSFoevVfd9fG3ZVbaZW+l22
	ks/3FyncF2blcYSXN9fSRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300771; x=
	1754387171; bh=Lnj3wac14QjCxMNkgb7vSlRGq/fvWC8yhAsl616v7bg=; b=a
	QUFBIgoXowK85K9klOx7wYKygE84t5lkMHqJtNFNDIuG/WOtK+lVGYydJcjyBAfx
	9dHyunz0ycY7VAzVL8uYR5D8zeoDPbPZJ482ykRDv9YJ5ie1IV8h812MqeuOIcmD
	g5GZ8kVN48Rvo7RfONrhzValFmUFnM8GxAC/4W4DIphhJkMWCWAez7RVZ3BTNesm
	3Fd2zYnbxno10y57yxpcAXzmVu8jfqISmKxF//Ko6mdmJR9wCto/F/usGWGf4TCc
	v5ytfKX/gVl9ylQmy9r0QOVaDA77vw4zo2nSijeeGZTAhQQRZHh1GZkvdwl5ovBV
	9ltA7GgYjyOHkb7VPbrHw==
X-ME-Sender: <xms:Y4GQaGZOQo-wyQqrpPrgbRe69yJK-oyaFPPDqeoJs9slmbOKc2Bb7g>
    <xme:Y4GQaGTa0NIkMOL9OksMqqjS_-noPjCP6doX-sgSuT7qE_xKPnlukKjMAsYWeTGgf
    DEgLgguL94MV-AuvQ>
X-ME-Received: <xmr:Y4GQaAuK34Dt1CBUzEnpDChAOZ53vJdLa0_OAfjNKHR3e_926KnvlBrmf3ubK9QYe-1eDxFBEq8uLMl_KHZk8CoOxLXIxC0NbJxXi42_VMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Y4GQaIHY1wKkfHUlW7n7myP77y2lGIWzy-bevlKvxcqCDTqdZE4gDw>
    <xmx:Y4GQaBzL-Kjn1gnP7iBKfX8ajT5mpDCXcRFs45w7W2cXoH9TT9-Osw>
    <xmx:Y4GQaC2fQMenQ8clYZTFrsWubs6sCZiXVGYiJPQ4gzcexcaDtXOa1A>
    <xmx:Y4GQaBobziAIfSbQNN37qBKGyFCe2bKgpQcqL_z2zeFP6D3U7uE8VA>
    <xmx:Y4GQaDOr3ri5ieSlWoXS4z0WfeDhjMDNuQjzjzJOgoFdY1y60SZ1S7sz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a119f56d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/9] refs: fix migration of reflog entries
Date: Mon, 04 Aug 2025 11:46:00 +0200
Message-Id: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFmBkGgC/33NQQ6CMBAF0KuQrq1ppy2lrryHcQF0gEYF0ppGQ
 7i7hYXBhLj8M/P+TCSgdxjIKZuIx+iCG/oU5CEjdVf2LVJnUybAQDENQMdboB6b+9DSchyxtzQ
 XkmuwRVlBTZIb09q91s7LNeXOhefg3+uLyJfpv7bIKaO8EKiMNBZ5fk43R/cgS1WELVd7HBJHi
 bquUDRKFz9cbLnZ4yJxk3NpBWcN0+LL53n+ALFNz4MtAQAA
X-Change-ID: 20250722-pks-reflog-append-634172d8ab2c
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Hi,

after the announcement that "reftable" will become the default backend
in Git 3.0 I've revived the efforts to implement this backend in
libgit2. I'm happy to report that this implementation is almost done by
now: out of 3000 tests only four are failing now.

For two of these tests I have been completely puzzled why those are
failing, as everything really looked perfectly fine in libgit2. As it
turned out, the bug wasn't in libgit2 though, but in Git. Namely, the
way we migrate reflog entries between storage formats is broken in two
ways:

  - The identity we write into the reflog entries is wrong.

  - The old commit ID of reflog entries is always set to all-zeroes.
    This is what caused the libgit2 tests to fail, as I used `git refs
    migrate` to convert test repositories to use reftables.

This patch series fixes both of these issues. Furthermore, it also adds
a new `git reflog write` subcommand to write new reflog entries for a
specific reference. This command was helpful to reproduce some test
constellations in libgit2.

Changes in v2:
  - !!! The base of this topic has changed so that it sits on top of
    v2.50.1. This is done so that we can backport this change to older
    release tracks.
  - A couple of typo fixes and clarifications for commit messages.
  - Reorder sections in git-reflog(1) manpage according to the
    reordering we have in the synopsis.
  - Add a section for the new `write` command.
  - Improve test coverage for the `git reflog write` command.
  - Avoid `cat`ing a file into a Bash loop.
  - Remove a stale comment.
  - Make `ref_update_expects_existing_old_ref()` a bit more straight
    forward.
  - Link to v1: https://lore.kernel.org/r/20250722-pks-reflog-append-v1-0-183e5949de16@pks.im

Changes in v3:
  - `git reflog write` now requires fully-qualified refnames.
  - A new commit that plugs one part of the race around splitting of
    reflogs for HEAD in the "files" backend.
  - Link to v2: https://lore.kernel.org/r/20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im

Changes in v4:
  - Improve one of the tests to use an existing abbreviated object ID
    instead of a non-existing one to make sure that we indeed fail due
    to the abbreviation.
  - Don't abort the transaction when HEAD has been racily updated, but
    drop the log-only update instead.
  - Link to v3: https://lore.kernel.org/r/20250729-pks-reflog-append-v3-0-9614d310f073@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      Documentation/git-reflog: convert to use synopsis type
      builtin/reflog: improve grouping of subcommands
      refs: export `ref_transaction_update_reflog()`
      builtin/reflog: implement subcommand to write new entries
      ident: fix type of string length parameter
      refs: fix identity for migrated reflogs
      refs/files: detect race when generating reflog entry for HEAD
      refs: stop unsetting REF_HAVE_OLD for log-only updates
      refs: fix invalid old object IDs when migrating reflogs

 Documentation/git-reflog.adoc |  76 +++++++++++++------------
 builtin/reflog.c              | 103 +++++++++++++++++++++++++++-------
 ident.c                       |   2 +-
 ident.h                       |   2 +-
 refs.c                        |  60 +++++++++++---------
 refs.h                        |  24 +++++++-
 refs/files-backend.c          |  83 +++++++++++++++++++++++++---
 refs/refs-internal.h          |   3 +-
 refs/reftable-backend.c       |  26 ++++++---
 t/meson.build                 |   1 +
 t/t1421-reflog-write.sh       | 126 ++++++++++++++++++++++++++++++++++++++++++
 t/t1460-refs-migrate.sh       |  22 +++++---
 12 files changed, 420 insertions(+), 108 deletions(-)

Range-diff versus v3:

 1:  5ae2971a55 =  1:  d030117041 Documentation/git-reflog: convert to use synopsis type
 2:  256589c289 =  2:  ad1dd8a226 builtin/reflog: improve grouping of subcommands
 3:  3b9e0a1206 =  3:  d6d6d99421 refs: export `ref_transaction_update_reflog()`
 4:  4fcf540ed6 !  4:  4e5433717e builtin/reflog: implement subcommand to write new entries
    @@ t/t1421-reflog-write.sh (new)
     +	git init repo &&
     +	(
     +		cd repo &&
    -+		test_must_fail git reflog write refs/heads/something 12345 $ZERO_OID old-object-id 2>err &&
    ++		test_commit initial &&
    ++		abbreviated_oid=$(git rev-parse HEAD | test_copy_bytes 8) &&
    ++		test_must_fail git reflog write refs/heads/something $abbreviated_oid $ZERO_OID old-object-id 2>err &&
     +		test_grep "invalid old object ID" err &&
    -+		test_must_fail git reflog write refs/heads/something $ZERO_OID 12345 new-object-id 2>err &&
    ++		test_must_fail git reflog write refs/heads/something $ZERO_OID $abbreviated_oid new-object-id 2>err &&
     +		test_grep "invalid new object ID" err
     +	)
     +'
 5:  18b2f61366 =  5:  92e45f582c ident: fix type of string length parameter
 6:  d140c53224 =  6:  e50c5aaae5 refs: fix identity for migrated reflogs
 7:  91c6a7cbcb !  7:  9380dbfdab refs/files: detect race when generating reflog entry for HEAD
    @@ Commit message
             have already processed. This causes us not writing a reflog message
             even though we should have done so.
     
    -      - HEAD gets concurrently updated to point to not point to a reference
    +      - HEAD gets concurrently updated to no longer point to a reference
             anymore that we have already processed. This causes us to write a
             reflog message even though we should _not_ have done so.
     
    @@ refs/files-backend.c
      struct ref_lock {
      	char *ref_name;
      	struct lock_file lk;
    +@@ refs/files-backend.c: int parse_loose_ref_contents(const struct git_hash_algo *algop,
    + 	return 0;
    + }
    + 
    +-static void unlock_ref(struct ref_lock *lock)
    ++static int unlock_ref(struct ref_lock *lock)
    + {
    + 	lock->count--;
    + 	if (!lock->count) {
    + 		rollback_lock_file(&lock->lk);
    + 		free(lock->ref_name);
    + 		free(lock);
    ++		return 1;
    + 	}
    ++	return 0;
    + }
    + 
    + /*
     @@ refs/files-backend.c: static enum ref_transaction_error split_head_update(struct ref_update *update,
      
      	new_update = ref_transaction_add_update(
    @@ refs/files-backend.c: static enum ref_transaction_error split_head_update(struct
      
      	/*
      	 * Add "HEAD". This insertion is O(N) in the transaction
    +@@ refs/files-backend.c: struct files_transaction_backend_data {
    +  *   the referent to transaction.
    +  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
    +  *   update of HEAD.
    ++ *
    ++ * Returns 0 on success, 1 in case the update needs to be dropped or a negative
    ++ * error code otherwise.
    +  */
    + static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *refs,
    + 						      struct ref_update *update,
     @@ refs/files-backend.c: static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
      
      	update->backend_data = lock;
    @@ refs/files-backend.c: static enum ref_transaction_error lock_ref_for_update(stru
     +
     +		/*
     +		 * Check that "HEAD" didn't racily change since we have looked
    -+		 * it up. If it did we must refuse to write the reflog entry.
    ++		 * it up. If it did we remove the reflog-only updateg from the
    ++		 * transaction again.
     +		 *
     +		 * Note that this does not catch all races: if "HEAD" was
     +		 * racily changed to point to one of the refs part of the
    @@ refs/files-backend.c: static enum ref_transaction_error lock_ref_for_update(stru
     +		 */
     +		if (!(update->type & REF_ISSYMREF) ||
     +		    strcmp(update->parent_update->refname, referent.buf)) {
    -+			strbuf_addstr(err, "HEAD has been racily updated");
    -+			ret = REF_TRANSACTION_ERROR_GENERIC;
    ++			if (unlock_ref(lock))
    ++				strmap_remove(&backend_data->ref_locks,
    ++					      update->refname, 0);
    ++
    ++			memmove(transaction->updates + update_idx,
    ++				transaction->updates + update_idx + 1,
    ++				(transaction->nr - update_idx - 1) * sizeof(*transaction->updates));
    ++			transaction->nr--;
    ++
    ++			ret = 1;
     +			goto out;
     +		}
     +
    @@ refs/files-backend.c: static enum ref_transaction_error lock_ref_for_update(stru
      		if (update->flags & REF_NO_DEREF) {
      			/*
      			 * We won't be reading the referent as part of
    +@@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    + 					  head_ref, &refnames_to_check,
    + 					  err);
    + 		if (ret) {
    ++			if (ret > 0)
    ++				continue;
    + 			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    + 				strbuf_reset(err);
    + 				ret = 0;
 8:  8468947824 =  8:  3c6182c96d refs: stop unsetting REF_HAVE_OLD for log-only updates
 9:  78ca2d46f9 =  9:  eafd8f6d7d refs: fix invalid old object IDs when migrating reflogs

---
base-commit: d82adb61ba2fd11d8f2587fca1b6bd7925ce4044
change-id: 20250722-pks-reflog-append-634172d8ab2c

