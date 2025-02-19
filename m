Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578451DFE36
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971421; cv=none; b=EV8X2tALMJGuMu0kFXRzthGm1UopG1thDoLPPqZdd1fGZCttByvbFDE4vKOqqPlsb07WKg8cm3TmaNMuqHFHMKkxXl8cjHFRHUNU47q1AOO7U9/DpKpU7gMT69cbyUfgMp4CmGo1Lzy1qkrI00nm+qb83N4Z+6zTcobdHxsudqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971421; c=relaxed/simple;
	bh=7Px36V9Y81uhJLdmYnEvH9yIPHiFGkduNf83x/+ILck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=VDYyI+gQrWdqejuqz8yY50UfxUmbqlhKXz60QAizLMaXNUAGJLhIIxiN+dmao5B4RvAPOQMeH77mk/QFPsqNTtrg2aB204mwkbrH8JsvN8bR5WvDf3HD/ioo2AJty5wXVz9gt/UdQQGTTLuKeRcu1CkFHdgO1mI7KqeeUpCYbT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V9aIRfF7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i6RZpbzD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V9aIRfF7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i6RZpbzD"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 503E7114014D;
	Wed, 19 Feb 2025 08:23:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 08:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971418;
	 x=1740057818; bh=NZRw8R4ftjUQtrgB5J2CxR6woZvo6cAEwLWgTts4FnI=; b=
	V9aIRfF7ygNTTPziFvUct9se6CH9Y2dWmEoaOIm0x/8z0w97XwY0d9cRp1d8D7TS
	YD3Jr0kt410gmSjBWbeo1HaP0s1P4+YZhRCdBEfObxt+PO9AIoG04KssAYzndCwR
	ckij+XpsLVGNsqwq3u8ak1XeyQK4ecolW47uJY6c8VISJpWg8L+gHg1b7I/fcjsS
	1nxXgD7pspb/au4vZ6FwRL/by5WiDdukDiyzMyayUESfyMddcV9pXDyDyMv9p2uY
	jYyr00iJsHQpyUn6N312xq9191KLp21whnlDwnwFfAtNHwRvaJQ8Ht4EvZjSTrvg
	L0Bn2+5TYvBz+tZSbHAc0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971418; x=
	1740057818; bh=NZRw8R4ftjUQtrgB5J2CxR6woZvo6cAEwLWgTts4FnI=; b=i
	6RZpbzD6/iEcFRCrHL9VTEkD/CPMQ/tskp42VG194Iyp5RNyma7oibHRYaj8PaPO
	PmIRZc0uYurGPrcu8oWFoTBgEtYh1RBG1MljreAvmyh3FM5hZeIzzSIoG+orJtvL
	Swb9TmnIPG1umt/AesV+DQK36kYWY0rtgDvG9uIP4VdQy4y5Ue4A5Qz6b7GRrm25
	MXXy5QhwQMlLnjDZvUF9sWoxRNo+pScMhdUtwVvyy9C+jCWDxUoHZNocHpYwQ7er
	/2egBjMA6XAiAUFw4ZryzTG1mTspGsqLYhzWwlFon4gm1bsGeA6rLl5JN8Ctthow
	GY+gvs+Ti4kZ+2I0krJjQ==
X-ME-Sender: <xms:Wdu1Z-8sxMjSTM4KP4Ri1AB1vc9Gd5C_n7RuEnlVUlJbGXiQjLZ-TA>
    <xme:Wdu1Z-v3L7Jgj6o5c8NlP8Y8gyj8CydbzPqE22xybRz4u30Njbkkcag6l3BEsKvm0
    RjplzxZHFpKOn1JDg>
X-ME-Received: <xmr:Wdu1Z0AJLkV_6z59Xp2FcXcMIHa96Jjf6gLXQgW_gUXjWHxQ3skXn3vwBz-BVcbVVqqlZQau7BPVvIN_yk7wAu8pvBMVx8GIhpwosu3K1ylA2sk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepudduveejffffgeejgeehieetuefftddvheelgeef
    feevtdegteelhfekveettdehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:Wdu1Z2fczBxQDlbuFCovOGNKUioZuSXurfOJL4TGWLXxEuzUuUVmJA>
    <xmx:Wdu1ZzMmdg4LF2hNxWoNNXc1OxUGCtXCv70aCN_so8kFv95hYPj_EA>
    <xmx:Wdu1ZwmyikBH-e_vmveJkLXHLhR9rc00m4WM8X9vbXXcLHoLDz2hXQ>
    <xmx:Wdu1Z1t163ccbcE4UoyPougJQydKQqodoDZaIWUhpe_bplXXVmOP1g>
    <xmx:Wtu1Z-dSAwehHiwTkSlsH27N2xnHEEvrOsP93PGlx4mUc_DZHer4APw2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a42600b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/16] refs: batch refname availability checks
Date: Wed, 19 Feb 2025 14:23:27 +0100
Message-Id: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFDbtWcC/42NQQ6CMBBFr0Jm7Rg6EVBX3MOwKHSQiQGathKVc
 HdHTuDy/fz//gqRg3CEa7ZC4EWizJMCHTLoBjvdGcUpA+VU5GQq9I+IT+9sYgzc4+yTjPKxSXd
 oiq66FFyWTC2owWtDXrv91igPEtMc3vvZYn7pf97FYI6W2tKdK0sn29faPsoIzbZtXzKrGm3DA
 AAA
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
      refs/iterator: implement seeking for `packed-ref` iterators
      refs/iterator: implement seeking for "files" iterators
      refs: reuse iterators when determining refname availability

 builtin/clone.c              |   2 +
 builtin/update-ref.c         |  12 ++-
 dir-iterator.c               |  24 +++---
 dir-iterator.h               |  11 +--
 hash.h                       |   1 +
 iterator.h                   |   2 +-
 object-name.c                |  18 +++--
 object-name.h                |   6 ++
 refs.c                       | 186 ++++++++++++++++++++++++++-----------------
 refs.h                       |  12 +++
 refs/debug.c                 |  20 +++--
 refs/files-backend.c         | 117 +++++++++++++++++----------
 refs/iterator.c              | 145 +++++++++++++++++----------------
 refs/packed-backend.c        |  89 ++++++++++++---------
 refs/ref-cache.c             |  83 +++++++++++--------
 refs/refs-internal.h         |  52 +++++++-----
 refs/reftable-backend.c      |  85 +++++++++++---------
 t/helper/test-dir-iterator.c |   1 +
 18 files changed, 519 insertions(+), 347 deletions(-)

Range-diff versus v1:

 1:  313d86f4274 =  1:  22de0f21a9f object-name: introduce `repo_get_oid_with_flags()`
 2:  a0ca8e62a81 !  2:  4aa573a50d4 object-name: allow skipping ambiguity checks in `get_oid()` family
    @@ hash.h: struct object_id {
      #define GET_OID_ONLY_TO_DIE    04000
      #define GET_OID_REQUIRE_PATH  010000
      #define GET_OID_HASH_ANY      020000
    -+#define GET_OID_HASH_SKIP_AMBIGUITY_CHECK 040000
    ++#define GET_OID_SKIP_AMBIGUITY_CHECK 040000
      
      #define GET_OID_DISAMBIGUATORS \
      	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
    @@ object-name.c: static int get_oid_basic(struct repository *r, const char *str, i
      
      	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
     -		if (repo_settings_get_warn_ambiguous_refs(r) && warn_on_object_refname_ambiguity) {
    -+		if (!(flags & GET_OID_HASH_SKIP_AMBIGUITY_CHECK) &&
    ++		if (!(flags & GET_OID_SKIP_AMBIGUITY_CHECK) &&
     +		    repo_settings_get_warn_ambiguous_refs(r) &&
     +		    warn_on_object_refname_ambiguity) {
      			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 3:  7029057b07f !  3:  073392c4371 builtin/update-ref: skip ambiguity checks when parsing object IDs
    @@ Commit message
         object ID that we parse according to the DWIM rules. This effect can be
         seen both with the "files" and "reftable" backend.
     
    +    The issue is not unique to git-update-ref(1), but was also an issue in
    +    git-cat-file(1), where it was addressed by disabling the ambiguity check
    +    in 25fba78d36b (cat-file: disable object/refname ambiguity check for
    +    batch mode, 2013-07-12).
    +
         Disable the warning in git-update-ref(1), which provides a significant
         speedup with both backends. The following benchmark creates 10000 new
         references with a 100000 preexisting refs with the "files" backend:
    @@ builtin/update-ref.c: static int parse_next_oid(const char **next, const char *e
      		if (arg.len) {
     -			if (repo_get_oid(the_repository, arg.buf, oid))
     +			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
    -+						    GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
    ++						    GET_OID_SKIP_AMBIGUITY_CHECK))
      				goto invalid;
      		} else {
      			/* Without -z, an empty value means all zeros: */
    @@ builtin/update-ref.c: static int parse_next_oid(const char **next, const char *e
      		if (arg.len) {
     -			if (repo_get_oid(the_repository, arg.buf, oid))
     +			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
    -+						    GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
    ++						    GET_OID_SKIP_AMBIGUITY_CHECK))
      				goto invalid;
      		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
      			/* With -z, treat an empty value as all zeros: */
    @@ builtin/update-ref.c: int cmd_update_ref(int argc,
      		oldval = argv[2];
     -		if (repo_get_oid(the_repository, value, &oid))
     +		if (repo_get_oid_with_flags(the_repository, value, &oid,
    -+					    GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
    ++					    GET_OID_SKIP_AMBIGUITY_CHECK))
      			die("%s: not a valid SHA1", value);
      	}
      
    @@ builtin/update-ref.c: int cmd_update_ref(int argc,
      			oidclr(&oldoid, the_repository->hash_algo);
     -		else if (repo_get_oid(the_repository, oldval, &oldoid))
     +		else if (repo_get_oid_with_flags(the_repository, oldval, &oldoid,
    -+						 GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
    ++						 GET_OID_SKIP_AMBIGUITY_CHECK))
      			die("%s: not a valid old SHA1", oldval);
      	}
      
 4:  768cb058d6e =  4:  e61aab15188 refs: introduce function to batch refname availability checks
 5:  6eed3559d68 !  5:  ef3df1044b4 refs/reftable: start using `refs_verify_refnames_available()`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    refs/reftable: start using `refs_verify_refnames_available()`
    +    refs/reftable: batch refname availability checks
     
         Refactor the "reftable" backend to batch the availability check for
         refnames. This does not yet have an effect on performance as we
 -:  ----------- >  6:  822bfc7bdee refs/files: batch refname availability checks for normal transactions
 -:  ----------- >  7:  f5dc7eaa97e refs/files: batch refname availability checks for initial transactions
 6:  5d78f40c460 !  8:  20a74a89045 refs: stop re-verifying common prefixes for availability
    @@ Commit message
     
         Optimize this pattern by storing prefixes in a `strset` so that we can
         trivially track those prefixes that we have already checked. This leads
    -    to a significant speedup when creating many references that all share a
    -    common prefix:
    +    to a significant speedup with the "reftable" backend when creating many
    +    references that all share a common prefix:
     
             Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
               Time (mean ± σ):      63.1 ms ±   1.8 ms    [User: 41.0 ms, System: 21.6 ms]
    @@ Commit message
               update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
                 1.58 ± 0.07 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
     
    -    Note that the same speedup cannot be observed for the "files" backend
    -    because it still performs availability check per reference.
    +    For the "files" backend we see an improvement, but a much smaller one:
    +
    +        Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
    +          Time (mean ± σ):     395.8 ms ±   5.3 ms    [User: 63.6 ms, System: 330.5 ms]
    +          Range (min … max):   387.0 ms … 404.6 ms    10 runs
    +
    +        Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
    +          Time (mean ± σ):     386.0 ms ±   4.0 ms    [User: 51.5 ms, System: 332.8 ms]
    +          Range (min … max):   380.8 ms … 392.6 ms    10 runs
    +
    +        Summary
    +          update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
    +            1.03 ± 0.02 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
    +
    +    This change also leads to a modest improvement when writing references
    +    with "initial" semantics, for example when migrating references. The
    +    following benchmarks are migrating 1m references from the "reftable" to
    +    the "files" backend:
    +
    +        Benchmark 1: migrate reftable:files (refcount = 1000000, revision = HEAD~)
    +          Time (mean ± σ):     836.6 ms ±   5.6 ms    [User: 645.2 ms, System: 185.2 ms]
    +          Range (min … max):   829.6 ms … 845.9 ms    10 runs
    +
    +        Benchmark 2: migrate reftable:files (refcount = 1000000, revision = HEAD)
    +          Time (mean ± σ):     759.8 ms ±   5.1 ms    [User: 574.9 ms, System: 178.9 ms]
    +          Range (min … max):   753.1 ms … 768.8 ms    10 runs
    +
    +        Summary
    +          migrate reftable:files (refcount = 1000000, revision = HEAD) ran
    +            1.10 ± 0.01 times faster than migrate reftable:files (refcount = 1000000, revision = HEAD~)
    +
    +    And vice versa:
    +
    +        Benchmark 1: migrate files:reftable (refcount = 1000000, revision = HEAD~)
    +          Time (mean ± σ):     870.7 ms ±   5.7 ms    [User: 735.2 ms, System: 127.4 ms]
    +          Range (min … max):   861.6 ms … 883.2 ms    10 runs
    +
    +        Benchmark 2: migrate files:reftable (refcount = 1000000, revision = HEAD)
    +          Time (mean ± σ):     799.1 ms ±   8.5 ms    [User: 661.1 ms, System: 130.2 ms]
    +          Range (min … max):   787.5 ms … 812.6 ms    10 runs
    +
    +        Summary
    +          migrate files:reftable (refcount = 1000000, revision = HEAD) ran
    +            1.09 ± 0.01 times faster than migrate files:reftable (refcount = 1000000, revision = HEAD~)
    +
    +    The impact here is significantly smaller given that we don't perform any
    +    reference reads with "initial" semantics, so the speedup only comes from
    +    us doing less string list lookups.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 7:  a1da57bf37d !  9:  b6524ecfe0c refs/iterator: separate lifecycle from iteration
    @@ Commit message
         to always call a newly introduce `ref_iterator_free()` function that
         deallocates the iterator and its internal state.
     
    +    Note that the `dir_iterator` is somewhat special because it does not
    +    implement the `ref_iterator` interface, but is only used to implement
    +    other iterators. Consequently, we have to provide `dir_iterator_free()`
    +    instead of `dir_iterator_release()` as the allocated structure itself is
    +    managed by the `dir_iterator` interfaces, as well, and not freed by
    +    `ref_iterator_free()` like in all the other cases.
    +
         While at it, drop the return value of `ref_iterator_abort()`, which
         wasn't really required by any of the iterator implementations anyway.
         Furthermore, stop calling `base_ref_iterator_free()` in any of the
    @@ dir-iterator.c: struct dir_iterator *dir_iterator_begin(const char *path, unsign
     
      ## dir-iterator.h ##
     @@
    -  *             goto error_handler;
       *
       *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
    -- *             if (want_to_stop_iteration()) {
    +  *             if (want_to_stop_iteration()) {
     - *                     ok = dir_iterator_abort(iter);
    -+ *             if (want_to_stop_iteration())
    ++ *                     ok = ITER_DONE;
       *                     break;
    -- *             }
    +  *             }
       *
    -  *             // Access information about the current path:
    -  *             if (S_ISDIR(iter->st.st_mode))
     @@
       *
       *     if (ok != ITER_DONE)
       *             handle_error();
    -+ *     dir_iterator_release(iter);
    ++ *     dir_iterator_free(iter);
       *
       * Callers are allowed to modify iter->path while they are working,
       * but they must restore it to its original contents before calling
    @@ dir-iterator.h: struct dir_iterator *dir_iterator_begin(const char *path, unsign
      
      #endif
     
    + ## iterator.h ##
    +@@
    + #define ITER_OK 0
    + 
    + /*
    +- * The iterator is exhausted and has been freed.
    ++ * The iterator is exhausted.
    +  */
    + #define ITER_DONE -1
    + 
    +
      ## refs.c ##
     @@ refs.c: int refs_verify_refnames_available(struct ref_store *refs,
      {
    @@ refs/refs-internal.h: enum do_for_each_ref_flags {
       * to the next entry, ref_iterator_advance() aborts the iteration,
       * frees the ref_iterator, and returns ITER_ERROR.
     @@ refs/refs-internal.h: enum do_for_each_ref_flags {
    -  *     struct ref_iterator *iter = ...;
       *
       *     while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
    -- *             if (want_to_stop_iteration()) {
    +  *             if (want_to_stop_iteration()) {
     - *                     ok = ref_iterator_abort(iter);
    -+ *             if (want_to_stop_iteration())
    ++ *                     ok = ITER_DONE;
       *                     break;
    -- *             }
    +  *             }
       *
    -  *             // Access information about the current reference:
    -  *             if (!(iter->flags & REF_ISSYMREF))
     @@ refs/refs-internal.h: enum do_for_each_ref_flags {
       *
       *     if (ok != ITER_DONE)
 8:  4618e6d5959 = 10:  d2763859826 refs/iterator: provide infrastructure to re-seek iterators
 9:  527caf0bae2 = 11:  3a56f55e2c4 refs/iterator: implement seeking for merged iterators
10:  61eddf82887 = 12:  33a04cc0a80 refs/iterator: implement seeking for reftable iterators
11:  d6a9792cb4c = 13:  5380a6f57dc refs/iterator: implement seeking for ref-cache iterators
12:  72ac2f31c39 = 14:  7a26532dd1f refs/iterator: implement seeking for `packed-ref` iterators
13:  916ec77de21 = 15:  dad520cf933 refs/iterator: implement seeking for "files" iterators
14:  7d40945d157 ! 16:  c300e7f049e refs: reuse iterators when determining refname availability
    @@ Commit message
         single reference we're about to check. This keeps us from reusing state
         that the iterator may have and that may make it work more efficiently.
     
    -    Refactor the logic to reseek iterators. This leads to a speedup with the
    -    reftable backend, which is the only backend that knows to batch refname
    -    availability checks:
    +    Refactor the logic to reseek iterators. This leads to a sizeable speedup
    +    with the "reftable" backend:
     
             Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
               Time (mean ± σ):      39.8 ms ±   0.9 ms    [User: 29.7 ms, System: 9.8 ms]
    @@ Commit message
               update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
                 1.25 ± 0.05 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
     
    +    The "files" backend doesn't really show a huge impact:
    +
    +        Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
    +          Time (mean ± σ):     392.3 ms ±   7.1 ms    [User: 59.7 ms, System: 328.8 ms]
    +          Range (min … max):   384.6 ms … 404.5 ms    10 runs
    +
    +        Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
    +          Time (mean ± σ):     387.7 ms ±   7.4 ms    [User: 54.6 ms, System: 329.6 ms]
    +          Range (min … max):   377.0 ms … 397.7 ms    10 runs
    +
    +        Summary
    +          update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
    +            1.01 ± 0.03 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
    +
    +    This is mostly because it is way slower to begin with because it has to
    +    create a separate file for each new reference, so the milliseconds we
    +    shave off by reseeking the iterator doesn't really translate into a
    +    significant relative improvement.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## refs.c ##

---
base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
change-id: 20250217-pks-update-ref-optimization-15c795e66e2b

