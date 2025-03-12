Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CFC2033A
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794977; cv=none; b=geZ1p8SGZPGICFnTn+W1WZ/4ExHPA9NBE+ntgvWGcbOY/X0LjGWC4PaYkmz19T3N7vEqYNZuVfokflZ4fIJmeAYAGW9HiMBJExqg+qbj0DmmhZ6WqiqhayDZC880OLzBScLyW5z50TRltdzI+kbiXe4fAdAvkLEBSF4IN94kwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794977; c=relaxed/simple;
	bh=oHc2k9Hk6DCtrykY+69slFBzmUnT4jmx72FuBY+CSSs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DXHF7RlK+4Ic2SFY2dQ47eg+OfrE5Rlr4vK/87bbwHnvWgS9d9cvVA1J1yz59omyqb14j7fWbPZ0q+ZJ680oZX9mbx0MC6lzpr/eXWSfuN58zvdgA+urrYkVT9sZMnagZrcK0841hkBNCcRRPVbZz+syRnOhKtvMZCvkkUnPXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M44QreNz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uYB4vX0+; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M44QreNz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uYB4vX0+"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88FB32540278;
	Wed, 12 Mar 2025 11:56:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 12 Mar 2025 11:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794973;
	 x=1741881373; bh=r3DuCf9M9yTjgGkwv9idaOlm87/IsAiqH0lCgwm40Kg=; b=
	M44QreNzzt1wR544kGOlPlbZgEgHf1nkb/dMngTewvYKDsa4by3Jfy9aVcfqmWzx
	wZ2rbB3LTW4h1MI+LEZ8KM+iDqByBRnzSRTxybaL6prDtjlKUIbnxeTgT/HUXGLY
	b6aobXXzdrctpVeV2xcJeNbeVVKBPjVSJBG6Qe5Ni0MlsRTkvWAaCia1eSff5FD8
	4Z4rOCyFFrmEfQBdQa1wNmCDZTJ9bDvvVpzULOQO/6h49abQJQB2OTmJ4QhUgC7p
	QvzLvuUXso/KrN9zwJ/Ev+tehB8j9stqAoihqJuaz6Dg0Am8CVtnCuphgNPiyUpK
	JxRBcD7IGENKQEqs4dwl7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794973; x=
	1741881373; bh=r3DuCf9M9yTjgGkwv9idaOlm87/IsAiqH0lCgwm40Kg=; b=u
	YB4vX0+Yus2X94qlMdccAMx7BcsL9hL5ZmUxkm1ZtKCbG/jTcIbGMr4BmGXofM5f
	cD0gYO4tJRGrUDragWzZMYHgn/Rl8UWoYcEE3xs/dL5Wv6Cv9oCz7Qj/v9FzaqVr
	t83R3MbrYjGqMP6ETFqu00PuBC5lya3S/U9inyHCpW79jgpSAnlKk8eGrrW+ygOF
	9pFp71vW/kPju1WCjalwWVpbKdYb6/xS5outDsdOmibWywKk+GrIeftX+gHJyjqD
	SB1YCU6puaZn/uIsRmyQ3F9HCASPOrARTVxKR7OdJPR6MNOV9cipzyNgx3bN7ShP
	AzGXDQg9rT9CrUIQVowVg==
X-ME-Sender: <xms:nK7RZ3wq8DBHRJhOUXAAaOlwbqCgIxA2DT2YD5eLHYx7OC1MA8pcvQ>
    <xme:nK7RZ_Sas5YkJ7o7cQXa57u9hyU-CdqPyWB4nzuF5JYJwxRWiy7TvF1OHiKu5PP-N
    9I-irAoUxGCTl0D8g>
X-ME-Received: <xmr:nK7RZxWKAPAPFsPkbN3qL0A7JKJDzg3vvsGoRTj7yTJJvm_YCwECHTY6PCsXp-DXJjpIScCnSD1noIkXLZ4MfHN1JuJbYvDQcJTqanyG1hEFcLtJlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeduudevjeffffegjeegheeiteeuffdtvdehleeg
    feefvedtgeetlefhkeevtedtheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptghhrh
    hishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:nK7RZxgViXKQMTtsDOAeTK3pswsdCrx7vRWZt-hO9KN1njKwuT68HQ>
    <xmx:nK7RZ5BPtWvdoOXJnwn_KIuPj0E9NK-Fjv1AgEAF1SoeGMVBVqbgfg>
    <xmx:nK7RZ6LcVHvw3X6RtCYKBTm6UWUSLbLgFAr9CYfoeSRjZAP8LFzW4A>
    <xmx:nK7RZ4AOURW8ZR4EHZCO82Ems2fyYjcbAkDa5et3iVx1HN4vY9xuvQ>
    <xmx:na7RZzDKyVNFH0MCNKF4uD_zU7v0-ipi7U3VmiS0akgUgBNF85zJl1kX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25128928 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 00/16] refs: batch refname availability checks
Date: Wed, 12 Mar 2025 16:56:06 +0100
Message-Id: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJau0WcC/43NTU7DMBAF4KtUXmPkjO2ZhBX3QCz8M6UWahPFI
 QKq3J1pF5BsIpZv9N43V1V5LFzV0+GqRp5LLf1FAj4cVDqFyxvrkiUrMOANNKSH96o/hhwm1iM
 fdT9M5Vy+wyQ73fhEnWdEhqhEGKRRPu/6y6vkU6lTP37dn83N7fo/d2600QEi5pYCuHB8lvZjO
 asbOsMa6vYhEIixQyYAEwE2kF1B4PchKxBRsthSyoH8BnJrqN2HnEDowCfjANu4hfwfZA3uQ16
 gnCIwG0vc0S+0LMsP8nli4+cBAAA=
X-Change-ID: 20250217-pks-update-ref-optimization-15c795e66e2b
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Hi,

this patch series has been inspired by brian's report that the reftable
backend is significantly slower when writing many references compared to
the files backend. As explained in that thread, the underlying issue is
the design of tombstone references: when we first delete all references
in a repository and then recreate them, we still have all the tombstones
and thus we need to churn through all of them to figure out that they
have been deleted in the first place. The files backend does not have
this issue.

I consider the benchmark itself to be kind of broken, as it stems from
us deleting all refs and then recreating them. And if you pack refs in
between then the "reftable" backend outperforms the "files" backend.

But there are a couple of opportunities here anyway. While we cannot
make the underlying issue of tombstones being less efficient go away,
this has prompted me to have a deeper look at where we spend all the
time. There are three ideas in this series:

  - git-update-ref(1) performs ambiguity checks for any full-size object
    ID, which triggers a lot of reads. This is somewhat pointless though
    given that the manpage explicitly points out that the command is
    about object IDs, even though it does know to parse refs. But being
    part of plumbing, emitting the warning here does not make a ton of
    sense, and favoring object IDs over references in these cases is the
    obvious thing to do anyway.

  - For each ref "refs/heads/bar", we need to verify that neither
    "refs/heads" nor "refs" exists. This was repeated for every refname,
    but because most refnames use common prefixes this made us re-check
    a lot of prefixes. This is addressed by using a `strset` of already
    checked prefixes.

  - For each ref "refs/heads/bar", we need to verify that no ref
    "refs/heads/bar/*" exists. We always created a new ref iterator for
    this check, which requires us to discard all internal state and then
    recreate it. The reftable library has already been refactored though
    to have reseekable iterators, so we backfill this functionality to
    all the other iterators and then reuse the iterator.

With the (somewhat broken) benchmark we see a small speedup with the
"files" backend:

    Benchmark 1: update-ref (refformat = files, revision = master)
      Time (mean ± σ):     234.4 ms ±   1.9 ms    [User: 75.6 ms, System: 157.2 ms]
      Range (min … max):   232.2 ms … 236.9 ms    10 runs

    Benchmark 2: update-ref (refformat = files, revision = HEAD)
      Time (mean ± σ):     184.2 ms ±   2.0 ms    [User: 62.8 ms, System: 119.9 ms]
      Range (min … max):   181.1 ms … 187.0 ms    10 runs

    Summary
      update-ref (refformat = files, revision = HEAD) ran
        1.27 ± 0.02 times faster than update-ref (refformat = files, revision = master)

And a huge speedup with the "reftable" backend:

    Benchmark 1: update-ref (refformat = reftable, revision = master)
      Time (mean ± σ):     16.852 s ±  0.061 s    [User: 16.754 s, System: 0.059 s]
      Range (min … max):   16.785 s … 16.982 s    10 runs

    Benchmark 2: update-ref (refformat = reftable, revision = HEAD)
      Time (mean ± σ):      2.230 s ±  0.009 s    [User: 2.192 s, System: 0.029 s]
      Range (min … max):    2.215 s …  2.244 s    10 runs

    Summary
      update-ref (refformat = reftable, revision = HEAD) ran
        7.56 ± 0.04 times faster than update-ref (refformat = reftable, revision = master)

We're still not up to speed with the "files" backend, but considerably
better. Given that this is an extreme edge case and not reflective of
the general case I'm okay with this result for now.

But more importantly, this refactoring also has a positive effect when
updating references in a repository with preexisting refs, which I
consider to be the more realistic scenario. The following benchmark
creates 10k refs with 100k preexisting refs.

With the "files" backend we see a modest improvement:

    Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = master)
      Time (mean ± σ):     478.4 ms ±  11.9 ms    [User: 96.7 ms, System: 379.6 ms]
      Range (min … max):   465.4 ms … 496.6 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     388.5 ms ±  10.3 ms    [User: 52.0 ms, System: 333.8 ms]
      Range (min … max):   376.5 ms … 403.1 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.23 ± 0.04 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = master)

But with the "reftable" backend we see an almost 5x improvement, where
it's now ~15x faster than the "files" backend:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = master)
      Time (mean ± σ):     153.9 ms ±   2.0 ms    [User: 96.5 ms, System: 56.6 ms]
      Range (min … max):   150.5 ms … 158.4 ms    18 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      32.2 ms ±   1.2 ms    [User: 27.6 ms, System: 4.3 ms]
      Range (min … max):    29.8 ms …  38.6 ms    71 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        4.78 ± 0.19 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = master)

The series is structured as follows:

  - Patches 1 to 4 implement the logic to skip ambiguity checks in
    git-update-ref(1).

  - Patch 5 to 8 introduce batched checks.

  - Patch 9 deduplicates the ref prefix checks.

  - Patch 10 to 16 implement the infrastructure to reseek iterators.

  - Patch 17 starts to reuse iterators for nested ref checks.

Changes in v2:
  - Point out why we also have to touch up the `dir_iterator`.
  - Fix up the comment explaining `ITER_DONE`.
  - Fix up comments that show usage patterns of the ref and dir iterator
    interfaces.
  - Start batching availability checks in the "files" backend, as well.
  - Improve the commit message that drops the ambiguity check so that we
    also point to 25fba78d36b (cat-file: disable object/refname
    ambiguity check for batch mode, 2013-07-12).
  - Link to v1: https://lore.kernel.org/r/20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im

Changes in v3:
  - Fix one case where we didn't skip ambiguity checks in
    git-update-ref(1).
  - Document better that only the prefix can change on reseeking
    iterators. Other internal state will remain the same.
  - Fix a memory leak in the ref-cache iterator.
  - Don't ignore errors returned by `packed_ref_iterator_seek()`.
  - Link to v2: https://lore.kernel.org/r/20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im

Changes in v4:
  - A couple of clarifications in the commit message that disabled
    ambiguity warnings.
  - Link to v3: https://lore.kernel.org/r/20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im

Changes in v5:
  - Improve a couple of commit messages.
  - Align `GET_OID_*` flag values.
  - Link to v4: https://lore.kernel.org/r/20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im

Changes in v6:
  - Use `for_each_string_list()` instead of manually iterating through
    the string list.
  - Stop sorting refs passed to `refs_verify_refnames_available()`.
  - Revive a comment that has been deleted during one of the
    refactorings.
  - Link to v5: https://lore.kernel.org/r/20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im

Thanks!

Patrick

[1]: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>

---
Patrick Steinhardt (16):
      object-name: introduce `repo_get_oid_with_flags()`
      object-name: allow skipping ambiguity checks in `get_oid()` family
      builtin/update-ref: skip ambiguity checks when parsing object IDs
      refs: introduce function to batch refname availability checks
      refs/reftable: batch refname availability checks
      refs/files: batch refname availability checks for normal transactions
      refs/files: batch refname availability checks for initial transactions
      refs: stop re-verifying common prefixes for availability
      refs/iterator: separate lifecycle from iteration
      refs/iterator: provide infrastructure to re-seek iterators
      refs/iterator: implement seeking for merged iterators
      refs/iterator: implement seeking for reftable iterators
      refs/iterator: implement seeking for ref-cache iterators
      refs/iterator: implement seeking for packed-ref iterators
      refs/iterator: implement seeking for files iterators
      refs: reuse iterators when determining refname availability

 builtin/clone.c              |   2 +
 builtin/update-ref.c         |  15 ++--
 dir-iterator.c               |  24 +++---
 dir-iterator.h               |  11 +--
 hash.h                       |  23 +++---
 iterator.h                   |   2 +-
 object-name.c                |  18 +++--
 object-name.h                |   6 ++
 refs.c                       | 187 ++++++++++++++++++++++++++-----------------
 refs.h                       |  12 +++
 refs/debug.c                 |  20 +++--
 refs/files-backend.c         | 117 +++++++++++++++++----------
 refs/iterator.c              | 150 ++++++++++++++++++----------------
 refs/packed-backend.c        |  92 ++++++++++++---------
 refs/ref-cache.c             |  88 ++++++++++++--------
 refs/refs-internal.h         |  53 +++++++-----
 refs/reftable-backend.c      |  84 ++++++++++---------
 t/helper/test-dir-iterator.c |   1 +
 18 files changed, 544 insertions(+), 361 deletions(-)

Range-diff versus v5:

 1:  d23737dfca2 =  1:  07ebc2f03d9 object-name: introduce `repo_get_oid_with_flags()`
 2:  33f4548d2c0 =  2:  b722efbe3dc object-name: allow skipping ambiguity checks in `get_oid()` family
 3:  ea0234047ab =  3:  a0171a61808 builtin/update-ref: skip ambiguity checks when parsing object IDs
 4:  3dfef6655f3 !  4:  91f0c75ac7b refs: introduce function to batch refname availability checks
    @@ refs.c: int ref_transaction_commit(struct ref_transaction *transaction,
      	struct strbuf referent = STRBUF_INIT;
     -	struct object_id oid;
     -	unsigned int type;
    ++	struct string_list_item *item;
      	int ret = -1;
      
      	/*
    @@ refs.c: int refs_verify_refname_available(struct ref_store *refs,
     -		int ignore_errno;
     -		/* Expand dirname to the new prefix, not including the trailing slash: */
     -		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
    -+	for (size_t i = 0; i < refnames->nr; i++) {
    -+		const char *refname = refnames->items[i].string;
    ++	for_each_string_list_item(item, refnames) {
    ++		const char *refname = item->string;
     +		const char *extra_refname;
     +		struct object_id oid;
     +		unsigned int type;
 5:  671ef35018c !  5:  8caf4f99ecd refs/reftable: batch refname availability checks
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		}
      	}
      
    -+	string_list_sort(&refnames_to_check);
     +	ret = refs_verify_refnames_available(ref_store, &refnames_to_check, &affected_refnames, NULL,
     +					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
     +					     err);
 6:  4ff7d2b821e !  6:  a10538db712 refs/files: batch refname availability checks for normal transactions
    @@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
     -			ret = TRANSACTION_NAME_CONFLICT;
     -			goto error_return;
     -		}
    -+		string_list_insert(refnames_to_check, refname);
    ++		string_list_append(refnames_to_check, refname);
      	}
      
      	ret = 0;
 7:  901664612bd =  7:  dccee563e60 refs/files: batch refname availability checks for initial transactions
 8:  1ddc9372a77 !  8:  c7b2ce15afe refs: stop re-verifying common prefixes for availability
    @@ Commit message
     
      ## refs.c ##
     @@ refs.c: int refs_verify_refnames_available(struct ref_store *refs,
    - {
      	struct strbuf dirname = STRBUF_INIT;
      	struct strbuf referent = STRBUF_INIT;
    + 	struct string_list_item *item;
     +	struct strset dirnames;
      	int ret = -1;
      
    @@ refs.c: int refs_verify_refnames_available(struct ref_store *refs,
      
     +	strset_init(&dirnames);
     +
    - 	for (size_t i = 0; i < refnames->nr; i++) {
    - 		const char *refname = refnames->items[i].string;
    + 	for_each_string_list_item(item, refnames) {
    + 		const char *refname = item->string;
      		const char *extra_refname;
     @@ refs.c: int refs_verify_refnames_available(struct ref_store *refs,
      			if (skip && string_list_has_string(skip, dirname.buf))
 9:  b3cd0baed29 !  9:  22730c09f01 refs/iterator: separate lifecycle from iteration
    @@ iterator.h
     
      ## refs.c ##
     @@ refs.c: int refs_verify_refnames_available(struct ref_store *refs,
    - {
      	struct strbuf dirname = STRBUF_INIT;
      	struct strbuf referent = STRBUF_INIT;
    + 	struct string_list_item *item;
     +	struct ref_iterator *iter = NULL;
      	struct strset dirnames;
      	int ret = -1;
    @@ refs/iterator.c: static int prefix_ref_iterator_advance(struct ref_iterator *ref
     -			ok = ref_iterator_abort(iter->iter0);
     -			break;
     -		}
    ++		/*
    ++		 * As the source iterator is ordered, we
    ++		 * can stop the iteration as soon as we see a
    ++		 * refname that comes after the prefix:
    ++		 */
     +		if (cmp > 0)
     +			return ITER_DONE;
      
10:  c1ceade2ba2 = 10:  e65b53f5b52 refs/iterator: provide infrastructure to re-seek iterators
11:  77642dfdade = 11:  66b8aa94cd7 refs/iterator: implement seeking for merged iterators
12:  fae0048ced3 = 12:  42192c4d4b6 refs/iterator: implement seeking for reftable iterators
13:  ff9384ee7b0 = 13:  76078359277 refs/iterator: implement seeking for ref-cache iterators
14:  105a01b3a59 = 14:  83d6f90c90a refs/iterator: implement seeking for packed-ref iterators
15:  1bf2e76b4c8 = 15:  b66bf0a9966 refs/iterator: implement seeking for files iterators
16:  24548c33e5c = 16:  67457a1c03f refs: reuse iterators when determining refname availability

---
base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
change-id: 20250217-pks-update-ref-optimization-15c795e66e2b

