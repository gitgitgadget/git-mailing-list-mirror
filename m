Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14112653
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603392; cv=none; b=qIM0tpcN8Xx1c7o4stXwDvp0MdwGw0QMg+XQ3PRCSCWYtlp4gcGny/SV0zngNJjeiXz33Ej4GwPEvri951SK9QlHGrWVCuj0LR+q98HM8ACgvRiLoLssBc+R9z5HcleCEpsiplP9ZpsicX5agf/cy/RpcldEExqtBxFrd2rccqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603392; c=relaxed/simple;
	bh=qdP6HRNmyCHCkGwC/TghNYZ68e27BEnGtbveukc2Vdg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=mCkVpIwcyD7aaC3Lv41jbm9neKXT53ZV9geKernrrsZZRcouTs0jaZSiUHSiIVb2I1XdKfj2eyt/loGaQyDR8FxamyeU7oHENXBfIRbjpW1FagOzbfWsSaNhQYSRO9BHRI9DKeglSkGQYSZfIDfZKnaqPkB+imsHjBJp917k+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZAcWcC5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=akwn63sE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZAcWcC5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="akwn63sE"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1FC5C13805E8;
	Tue, 26 Nov 2024 01:43:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 26 Nov 2024 01:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603389;
	 x=1732689789; bh=bjq+SnL6YQATPX6b3aI83+u9FnvptdhuQwZehwiPTLI=; b=
	ZAcWcC5k31OO6GUiu9CXOrmw1hxGKn9lLUfBErSL0QGEsJtabJy+aK41hYR62CLZ
	a/7sg35AVBzuv0QUzgoi1juW6V94dqvLYmyQsVCJT0Qu1atZBQtfK9qyK9jWgFRr
	8qpukwDz+oRB0l9iYzh4oAB1xNbsrDprn6lGc4kN/E57VUhQFecGuAs5kLJU8/7E
	bCNnnb6PYkT0gDIVt4x8Ncb7DigBHWroF344luSXLoR8x69+uoGVdyfC3CwvZCU8
	6mS4KZUcNOgz3/xK4xc9baO3WeDKjFOaiyU7+gsgcWuxLzpdsahbFyMaMgIwYIKG
	SiqThI2QeOzwShVW26YhSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603389; x=
	1732689789; bh=bjq+SnL6YQATPX6b3aI83+u9FnvptdhuQwZehwiPTLI=; b=a
	kwn63sETL3pVqGH+n2qTOxUMAoEGoWf+gC3UbBE/EBbBqIMur3XB50cNW++SUzwy
	IkBbPcSGzfAecOyZdparB+ShLp2bgrQWo2cT0P8ywl8iGQulXrb6AO2vES/eHPgi
	iiDDSrUBcqcReS68eBKtjm8GKWSQG1Xi8IT4at/ugIS2bYDIwQqk8pNHIDFZ7hVO
	g7n4MVYcn9Rae8N09/1qfN5TeODFVvSZzr5RmVT49QS+xz2RVhlKFK9VCAaW+7K5
	+1aP//SuErA9jQb/sskEViAqLVqrD7uRR+fui7QFhRkXWtsDJGuchYRrTiHbJZ+i
	uDBIYfKdn5+WqopqK21PQ==
X-ME-Sender: <xms:_G1FZ9Keb8T95lG3OMfsyYq7r98YZV3twcgo5R_AFMqc5vwzPn6cog>
    <xme:_G1FZ5JnxbmMa0vLdUChIsOs3K_c_Iz4hn7PxwGaKfQgNwL8Pq2EB9EBObcU1DET4
    M3rvzUqkX4jhJjKgw>
X-ME-Received: <xmr:_G1FZ1udEoIVYW8DtDE3012vzp5IUpm4m5SUBupidTHNjH_1X7fm5RkCOT5sSZV5QgK9cQDgnHhTH9pCwVRX0Eu43mzyXWKLIy_pSqECP6rvMhKG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteetleduuefhveegvdfhuddvlefftdffjeeufffgfffg
    ffdtgfdufeeivedujefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuhhpuggrth
    gvrdhtiienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_G1FZ-YtFFoe9OcGwFBrHfbeboSMRFAk0CUwM8S_aJ5r8u6SbbWGTQ>
    <xmx:_W1FZ0bzH3zy2adHXzkEm3jePeXrUgYh4Y36N5sL6FHyVBLOYEkQGQ>
    <xmx:_W1FZyAVmgfN4Cl08L4wmwUqzFLOREc4Eh2YHj1MNzwjSXCzj62Tpg>
    <xmx:_W1FZyZQs1e2AgpLC7A-p-AZ9XHOSs9OaJrHlIXA_YRe_Rh47LW-oA>
    <xmx:_W1FZ8H-Q4Gq5S1lBrM1LrqwkcdtPOi9tO47LeHJTljpRCZiQStrfn9d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c4c0e72d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/10] refs/reftable: reuse iterators when reading refs
Date: Tue, 26 Nov 2024 07:42:51 +0100
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOttRWcC/42OQQ6CMBBFr0K6tg2dAm1deQ/josAIDQqkrY2Gc
 HcLCxfGhcv/8+a/WYhHZ9GTY7YQh9F6O40pFIeMNL0ZO6S2TZlADgXnUNJ58NThNZj6hrQ2zYB
 jm4qHT2RAR4UB1FCAkkqTtDIn2D53w/mScm99mNxrF0a+taSZIjrGpcilAKU462xgsz8lFbN3s
 l1F+CY1VCB/kWIn//43CppT3sq6KhUK1PgZW9f1DckGdpkfAQAA
X-Change-ID: 20241125-pks-reftable-backend-reuse-iter-3a2e92428789
In-Reply-To: <cover.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series refactors the reftable backend to reuse reftable
iterators when reading random references. This removes the overhead of
having to recreate the iterator on every read and thus leads to better
performance and less allocation churn. It also gives us the ability to
further optimize reads by optimizing re-seeking iterators in the future.

Overall this leads to a 7% speedup when creating many refs in a
transaction, which performs many random reads. But this change also
positively impacts other usecases.

Changes in v3:

  - Adapt some comments to refer to the "backend" instead of to the
    "stack".
  - Fix indentation of a statement while at it.
  - Explain why callsites don't want to reload the stack.
  - Optimize `prepare_transaction_update()` by not using `backend_for()`
    twice, but instead reload the stack manually.
  - Split out the change that adds `reftable_stack_hash_id()` into a
    separate commit.
  - Link to v2: https://lore.kernel.org/r/cover.1730792627.git.ps@pks.im

Changes in v4:

  - Split up the introduction of `reftable_backend_read_ref()` into two
    commits: one that gets rid of the `struct reftable_ref_store`
    parameter and one that converts the function to accept a `struct
    reftable_backend`.
  - Fix a comment typo.
  - Link to v3: https://lore.kernel.org/r/20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      refs/reftable: encapsulate reftable stack
      refs/reftable: handle reloading stacks in the reftable backend
      reftable/stack: add accessor for the hash ID
      refs/reftable: figure out hash via `reftable_stack`
      refs/reftable: read references via `struct reftable_backend`
      refs/reftable: refactor reading symbolic refs to use reftable backend
      refs/reftable: refactor reflog expiry to use reftable backend
      reftable/stack: add mechanism to notify callers on reload
      reftable/merged: drain priority queue on reseek
      refs/reftable: reuse iterators when reading refs

 refs/reftable-backend.c          | 409 +++++++++++++++++++++++++--------------
 reftable/merged.c                |   2 +
 reftable/reftable-stack.h        |   3 +
 reftable/reftable-writer.h       |   9 +
 reftable/stack.c                 |   9 +
 t/unit-tests/t-reftable-merged.c |  73 +++++++
 6 files changed, 357 insertions(+), 148 deletions(-)

Range-diff versus v3:

 1:  3db0ba3eb5 =  1:  ec0b7e35c8 refs/reftable: encapsulate reftable stack
 2:  556eb8301c !  2:  437304908b refs/reftable: handle reloading stacks in the reftable backend
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     +	 * have reloaded it, which may mean that it is stale.
     +	 *
     +	 * On the other hand, reloading that stack without locking it feels
    -+	 * wrong to, as the value of "HEAD" could be modified concurrently at
    ++	 * wrong, too, as the value of "HEAD" could be modified concurrently at
     +	 * any point in time.
     +	 */
     +	ret = backend_for(&be, refs, "HEAD", NULL, 0);
 3:  e966b9acf2 =  3:  0bd9aea884 reftable/stack: add accessor for the hash ID
 -:  ---------- >  4:  d8b801503f refs/reftable: figure out hash via `reftable_stack`
 4:  de9f52a5b2 !  5:  a57210ac46 refs/reftable: read references via `struct reftable_backend`
    @@ Metadata
      ## Commit message ##
         refs/reftable: read references via `struct reftable_backend`
     
    -    Refactor `read_ref_without_reload()` to accept a `struct reftable_stack`
    -    as input instead of accepting a `struct reftable_stack`. This allows us
    -    to implement an additional caching layer when reading refs where we can
    -    reuse reftable iterators.
    +    Refactor `read_ref_without_reload()` to accept `struct reftable_backend`
    +    as parameter instead of `struct reftable_stack`. Rename the function to
    +    `reftable_backend_read_ref()` to clarify its scope and move it close to
    +    other functions operating on `struct reftable_backend`.
    +
    +    This change allows us to implement an additional caching layer when
    +    reading refs where we can reuse reftable iterators.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ refs/reftable-backend.c: static void fill_reftable_log_record(struct reftable_lo
      	log->value.update.tz_offset = sign * atoi(tz_begin);
      }
      
    --static int read_ref_without_reload(struct reftable_ref_store *refs,
    --				   struct reftable_stack *stack,
    +-static int read_ref_without_reload(struct reftable_stack *stack,
     -				   const char *refname,
     -				   struct object_id *oid,
     -				   struct strbuf *referent,
    @@ refs/reftable-backend.c: static void fill_reftable_log_record(struct reftable_lo
     -		strbuf_addstr(referent, ref.value.symref);
     -		*type |= REF_ISSYMREF;
     -	} else if (reftable_ref_record_val1(&ref)) {
    +-		unsigned int hash_id;
    +-
    +-		switch (reftable_stack_hash_id(stack)) {
    +-		case REFTABLE_HASH_SHA1:
    +-			hash_id = GIT_HASH_SHA1;
    +-			break;
    +-		case REFTABLE_HASH_SHA256:
    +-			hash_id = GIT_HASH_SHA256;
    +-			break;
    +-		default:
    +-			BUG("unhandled hash ID %d", reftable_stack_hash_id(stack));
    +-		}
    +-
     -		oidread(oid, reftable_ref_record_val1(&ref),
    --			refs->base.repo->hash_algo);
    +-			&hash_algos[hash_id]);
     -	} else {
     -		/* We got a tombstone, which should not happen. */
     -		BUG("unhandled reference value type %d", ref.value_type);
    @@ refs/reftable-backend.c: static int reftable_be_read_raw_ref(struct ref_store *r
      	if (ret)
      		return ret;
      
    --	ret = read_ref_without_reload(refs, be->stack, refname, oid, referent, type);
    +-	ret = read_ref_without_reload(be->stack, refname, oid, referent, type);
     +	ret = reftable_backend_read_ref(be, refname, oid, referent, type);
      	if (ret < 0)
      		return ret;
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      	if (ret)
      		goto done;
      
    --	ret = read_ref_without_reload(refs, be->stack, "HEAD",
    +-	ret = read_ref_without_reload(be->stack, "HEAD",
     -				      &head_oid, &head_referent, &head_type);
     +	ret = reftable_backend_read_ref(be, "HEAD", &head_oid,
     +					&head_referent, &head_type);
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      			string_list_insert(&affected_refnames, new_update->refname);
      		}
      
    --		ret = read_ref_without_reload(refs, be->stack, rewritten_ref,
    +-		ret = read_ref_without_reload(be->stack, rewritten_ref,
     -					      &current_oid, &referent, &u->type);
     +		ret = reftable_backend_read_ref(be, rewritten_ref,
     +						&current_oid, &referent, &u->type);
    @@ refs/reftable-backend.c: static int write_copy_table(struct reftable_writer *wri
      		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
      		logs_nr++;
      
    --		ret = read_ref_without_reload(arg->refs, arg->stack, "HEAD", &head_oid,
    +-		ret = read_ref_without_reload(arg->stack, "HEAD", &head_oid,
     -					      &head_referent, &head_type);
     +		ret = reftable_backend_read_ref(arg->be, "HEAD", &head_oid,
     +						&head_referent, &head_type);
 5:  6e7db8e3fc =  6:  432f75ef01 refs/reftable: refactor reading symbolic refs to use reftable backend
 6:  687afb781a =  7:  1ca28e00b1 refs/reftable: refactor reflog expiry to use reftable backend
 7:  e1d4bdc3e8 =  8:  a95b67f1f3 reftable/stack: add mechanism to notify callers on reload
 8:  8eccf308bd =  9:  cbaf95ff15 reftable/merged: drain priority queue on reseek
 9:  942957447a = 10:  013f05e08b refs/reftable: reuse iterators when reading refs

---
base-commit: 455ddbf8c6a694968c1089fb6c7ffb1d31d97e9d
change-id: 20241125-pks-reftable-backend-reuse-iter-3a2e92428789

