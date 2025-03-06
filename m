Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA31DE4EC
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273725; cv=none; b=WLU3bfwUTX4eL8XhG+rlKrX2EJDGFHSiRycx26EHAGsrC+BVR0pWphWZeEQ8NLYeV1n0SjQX2iB90hl+6bVK7xeqCETzUsS19m8RruuTjvwMT87gftnkCqRdJnPPGxm3Em3QSQcrWOQ2DEVhLkmZVPJwl4OVoqFnbFVdq3DNMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273725; c=relaxed/simple;
	bh=2Ljxulho/Xmv7XaTUtJLrvZk0fXcglLyLNyCBSgz/i4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=UYQcJ122OYXjPA6HhiBDxm04ZuJme3ISALV7eoe1kWs7uTvWWbEgV2A1w2UoQkHWGJII2tlCrzU5Kc4lb8MuIycdcDrGfnvNJp+2FJVNfSFBTtXmq+GCRzAMgPZFvmMfPh53CjskAU1gszR4Oqy4SZfqW3Ws+gpkaKeu7e7emPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KoWPCzu7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3ZSx2RT; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KoWPCzu7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3ZSx2RT"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B01441140106;
	Thu,  6 Mar 2025 10:08:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 06 Mar 2025 10:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273722;
	 x=1741360122; bh=8kQv+Eia+uNWbN+Tjmk8+gPKZiXn1j5ql18CZSZx8PA=; b=
	KoWPCzu7auYi4kqTJnpUOZO9lFt5vno32fXrY+u4SJZlAVD/Z3qfwsHSqwP80xCw
	wbALo5EKc7z944Xm2rb3qhw/UypeIrIz/jyj4MO7ZnDXN6Z0uc66Q/x6Eo9wAsYb
	NaaA4O6NZDQqeaM5VYfHMe1lMqKAgEBkAeMlGqHHFBc+AEixphG1o9bNHsKJIWcd
	7A2l+mCvDiPRRpXvwciSTtGETFa3Wd1IE/xoxtIdUdm6YIuqZhUv7xljjXil3aG1
	4+sJRjeCbJneBRWgp8AUqTC9aZrUs5sMFjlKjCJXEsiA/1wPGgywU8btTAEoWXXX
	Tr5Cz7NTOHbNkwVBEBM6BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273722; x=
	1741360122; bh=8kQv+Eia+uNWbN+Tjmk8+gPKZiXn1j5ql18CZSZx8PA=; b=l
	3ZSx2RTkTQq5Ajp6XQpv9BgFgyK4mvfh0fOboi64VuS1HuDnMX4cCzLS3FTTzUIv
	NevHU0RqDHBluodkCTsJVHMjkcoytpUgbbq4VyqvmigbYP22iX0oM0DZZlNeph8Q
	gL2yBDaFybgF/XxbyADIavI3XuBG9fdpcyTTr4dfd6min1geVf7WY5HkDAntgVjE
	7U0mCYE5Q+/MSF/EgMGZm8d7uIasfW34I6q+Uycb7zJhby+tJk3x0YQBhWxO1lej
	Rihmd+BXTux58Up0b/6sWMZaqsyvF7iQZ9XDD1/ayWmi/2S3nYHO51txIj6xvrGc
	DSTo1eYnroyGvvnI8W00w==
X-ME-Sender: <xms:errJZ6cLnMfdou66DtGH7fsFVA7gi-WLGQHOBdKxRVYQxioRguZsGw>
    <xme:errJZ0Mc0wfxBE_B7Osbj8xF4xF1dDaVDaxmDswmZFAlRkygPYyFGb0UJYgIQvXCd
    j4Q0053WjQitaVhlA>
X-ME-Received: <xmr:errJZ7iSax8WyyvY-jg40oEPIfXa_6x3guzywOBZTfDJP0Gz6JJB01aVzFtLHX9LZni637Hl0rZglVOE7gGcxRl5D2V6jvPNbfOBbki1gGjemA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeduudevjeffffegjeegheeiteeuffdtvdehleeg
    feefvedtgeetlefhkeevtedtheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgt
    phhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:errJZ380Ih3FCRS5Lv5iJWc2MhRRcIeIymndZKLbAquc_-sWMdN70Q>
    <xmx:errJZ2s4Eubi3tRUkr1pxAyjMp5nL36BkL_yNvmNJ4xrnMm2fIVtIQ>
    <xmx:errJZ-HD_KFp5_2ra-_ciCVEokjV2BkeiZNeHhwBVZo_MR0agtYokw>
    <xmx:errJZ1MepTSU72-ppIe2f8VQ6YXkuYn6ffNTuiOKpC0ZTfsUDKMnrw>
    <xmx:errJZz89mIMQho38zuovSZX2oDnEj_9FNuGo-v4JSY3sSrdbUTwMDujH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7fa8263f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/16] refs: batch refname availability checks
Date: Thu, 06 Mar 2025 16:08:31 +0100
Message-Id: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG+6yWcC/43Nyw6CMBAF0F8xXVtThj7Alf9hXJQy6sTwCEXiI
 /y7IxthQ1zeyb1n3iJiRxjFfvMWHQ4Uqak5mO1GhKuvLyip5CxAgVGQONneory3pe9RdniWTdt
 TRS/f804mJrjcoLUIhWCh5QY9Jv144nyl2Dfdc3o2JN/rf+6QSCU9FLbMnAftzwdu76gSX3SAO
 ZSvQ8AQ2tyiA1AFwAJKZxCYdShlyLmQ2syF0juzgPQcytYhzZDVYILSYLPiB43j+AFK8SRongE
 AAA==
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
 refs.c                       | 186 ++++++++++++++++++++++++++-----------------
 refs.h                       |  12 +++
 refs/debug.c                 |  20 +++--
 refs/files-backend.c         | 117 +++++++++++++++++----------
 refs/iterator.c              | 145 +++++++++++++++++----------------
 refs/packed-backend.c        |  92 ++++++++++++---------
 refs/ref-cache.c             |  88 ++++++++++++--------
 refs/refs-internal.h         |  53 +++++++-----
 refs/reftable-backend.c      |  85 +++++++++++---------
 t/helper/test-dir-iterator.c |   1 +
 18 files changed, 539 insertions(+), 361 deletions(-)

Range-diff versus v4:

 1:  0d104cd63d5 =  1:  0fa8574b155 object-name: introduce `repo_get_oid_with_flags()`
 2:  3fc310597db !  2:  9bc87107e05 object-name: allow skipping ambiguity checks in `get_oid()` family
    @@ Commit message
     
      ## hash.h ##
     @@ hash.h: struct object_id {
    - #define GET_OID_ONLY_TO_DIE    04000
    - #define GET_OID_REQUIRE_PATH  010000
    - #define GET_OID_HASH_ANY      020000
    + 	int algo;	/* XXX requires 4-byte alignment */
    + };
    + 
    +-#define GET_OID_QUIETLY           01
    +-#define GET_OID_COMMIT            02
    +-#define GET_OID_COMMITTISH        04
    +-#define GET_OID_TREE             010
    +-#define GET_OID_TREEISH          020
    +-#define GET_OID_BLOB             040
    +-#define GET_OID_FOLLOW_SYMLINKS 0100
    +-#define GET_OID_RECORD_PATH     0200
    +-#define GET_OID_ONLY_TO_DIE    04000
    +-#define GET_OID_REQUIRE_PATH  010000
    +-#define GET_OID_HASH_ANY      020000
    ++#define GET_OID_QUIETLY                  01
    ++#define GET_OID_COMMIT                   02
    ++#define GET_OID_COMMITTISH               04
    ++#define GET_OID_TREE                    010
    ++#define GET_OID_TREEISH                 020
    ++#define GET_OID_BLOB                    040
    ++#define GET_OID_FOLLOW_SYMLINKS        0100
    ++#define GET_OID_RECORD_PATH            0200
    ++#define GET_OID_ONLY_TO_DIE           04000
    ++#define GET_OID_REQUIRE_PATH         010000
    ++#define GET_OID_HASH_ANY             020000
     +#define GET_OID_SKIP_AMBIGUITY_CHECK 040000
      
      #define GET_OID_DISAMBIGUATORS \
 3:  f702ed7ece6 =  3:  345af4b7012 builtin/update-ref: skip ambiguity checks when parsing object IDs
 4:  eead30e64d7 =  4:  f1422bc1ef6 refs: introduce function to batch refname availability checks
 5:  1bd5eb82167 !  5:  1aa1b95b5d8 refs/reftable: batch refname availability checks
    @@ Commit message
         refs/reftable: batch refname availability checks
     
         Refactor the "reftable" backend to batch the availability check for
    -    refnames. This does not yet have an effect on performance as we
    -    essentially still call `refs_verify_refname_available()` in a loop, but
    -    this will change in subsequent commits.
    +    refnames. This does not yet have an effect on performance as
    +    `refs_verify_refnames_available()` effectively still performs the
    +    availability check for each refname individually. But this will be
    +    optimized in subsequent commits, where we learn to optimize some parts
    +    of the logic when checking multiple refnames for availability.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 6:  02d02c9c219 =  6:  2cf0c6a3bbe refs/files: batch refname availability checks for normal transactions
 7:  a3c4a4f751d !  7:  84d7830c5e5 refs/files: batch refname availability checks for initial transactions
    @@ Commit message
         subsequent commits and then impact performance when cloning a repository
         with many references or when migrating references to the "files" format.
     
    -    This doesn't yet have an effect on performance as the underlying
    -    logic simply calls This will improve performance when cloning a repository with
    -    many references or when migrating references from any format to the
    -    "files" format.
    +    This will improve performance when cloning a repository with many
    +    references or when migrating references from any format to the "files"
    +    format once the availability checks have learned to optimize checks for
    +    many references in a subsequent commit.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 8:  595d98a6cd3 =  8:  a0d99e8a3a0 refs: stop re-verifying common prefixes for availability
 9:  7dd99377266 =  9:  b73d1ffa761 refs/iterator: separate lifecycle from iteration
10:  8935bed6fcb = 10:  a1de5c7819c refs/iterator: provide infrastructure to re-seek iterators
11:  c9bfdde3c89 = 11:  90698a9237b refs/iterator: implement seeking for merged iterators
12:  25fe519bff6 ! 12:  420d6e08fa9 refs/iterator: implement seeking for reftable iterators
    @@ Commit message
           - We do not support seeking on reflog iterators. It is unclear what
             seeking would even look like in this context, as you typically would
             want to seek to a specific entry in the reflog for a specific ref.
    -        There is not currently a usecase for this, but if there ever is we
    -        can implement seeking in the future.
    +        There is currently no use case for this, but if one arises in the
    +        future, we can still implement seeking at that later point.
     
           - We start to check whether `reftable_stack_init_ref_iterator()` is
             successful.
13:  8e8d5b4b91e = 13:  0f16f1bc5f6 refs/iterator: implement seeking for ref-cache iterators
14:  1670074af7c = 14:  01c6a5bf45d refs/iterator: implement seeking for packed-ref iterators
15:  537ff4ae54c = 15:  4179771a9cb refs/iterator: implement seeking for files iterators
16:  93084536803 = 16:  e51b3985882 refs: reuse iterators when determining refname availability

---
base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
change-id: 20250217-pks-update-ref-optimization-15c795e66e2b

