Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C521CEAA6
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797923; cv=none; b=e3xSgzTj+wyNJLPu52MdU6cPEiTDZ8Wuj/vxT/wIb90GhCP8IeSmCM05a/5mpdHOkC76jxReyd9bzbMP5lDdtoJf3Q6WnBJYo2AhuBtJyOadCTTau2i624rfdSz3dGuWLxjyXoRD8Rnuag/p/K6TLMdHdvm+i2RJ+66yTtREQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797923; c=relaxed/simple;
	bh=KxkcDdaCW91tN/PYgN+aOhI1C+JXinN5o9r7+E78k1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQJ+1Z2jFYFoUxYe4ogChWpXE3YvOGhYhEGyqgZasfOZD9IO272plWNElKeJ2KvvalXsvACeHQMaNJvluQy5Rp/TvkoqLoB1+ywvetuHJI16Hfz7UaVdIz9FaSzjSwF90bpiPiRDz3oBMAXKiXTmp3mFxnea/CSSMlqMYsNRdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oKH1cj3b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UFTNUk9p; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oKH1cj3b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UFTNUk9p"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B99F71140171;
	Tue,  5 Nov 2024 04:11:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 05 Nov 2024 04:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730797919; x=1730884319; bh=hFQttqxqC3
	TqiGKj+03BknybMSU8qt/w9i/afeyP3os=; b=oKH1cj3bEJq8fHdqRCGVWYX3Fc
	qoqDTJRXJNkGBL51PBggTkjE+u1mQLRONXIasb0eA8dl75H+9ZpTpE5Uhm0pP5u0
	46oyRsGzeZJx0lw+YI+HXEazmFnuZVtWUcBD735dt/yEy5GiMCn4JFia/Jg+RJql
	hCXIu+7/PGPhxld+40SA42zQecRiO2PwptKhflZswN4X9JA+llhOIAoKL8Q1NH++
	4s8Iki2gmD3k82rUuy7gcuhhRPI1rzld38hKqJ1YHR3nC8UuKYcxbzax1WCXgGav
	ka1mFXQl9bHMz5l0CY3jBEF954tx9N1paWXPhMio5vI/ZVGZWUiw+Ebss9Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730797919; x=1730884319; bh=hFQttqxqC3TqiGKj+03BknybMSU8qt/w9i/
	afeyP3os=; b=UFTNUk9p8vRpfiRsBXHdX/RbVXahqc24lgcCEKrQydafq1DPWw9
	gB2DSnIAWFilPkgolUvuWfYzh3xlDDyUCZjruJxpo+92NJ+Zyd/JdKD44ygPsu/f
	BVtwvkXkkDYU+asX8NSDON8FyrIx1tfyIeEt30kmM9PUq6tiBUqVMjWSNLvYfUar
	wU5993lVpF/RDbRzts+2RcsAqGMwCwYsWqJyf01/jLLyps439DpBKmWGhTlp3g+R
	ShtfqIrsm7Gnv67iI/CzuTQ5zYbqIM/3ECrXbtFqsVa8vJ5J3U7+vUj1Fn4xMc1V
	LhMyW+0eCKFDIJCycAmncXiEoxwVAOGqHww==
X-ME-Sender: <xms:X-EpZ9ULO9x_ZWNi9u-mnTmOlzlk5TrqeU5EUh0KNUr9Xu-GnnO7sA>
    <xme:X-EpZ9mDF7h0BN63NGZEkNUR2b8Tl6dpKjtTy46sbx53wVtiARxPxWzcoeiX46Q-b
    gjT99uZvRQGtmgRqQ>
X-ME-Received: <xmr:X-EpZ5Zx5DOKuN6xoHYuq5JUUNEaocOFA885BXogUaAFTEyWeEgLFazi2xdwi-aSZqgsisJ3Wey4Rm0oL8oPQB7I7_krDxM7kF5pQCyGqINrrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:X-EpZwWNfGVbkI_QG1Ep5BlDVHkmuW0JWJJf7eIV-o31vQLlIAQfSA>
    <xmx:X-EpZ3lNmq_geCUVvWwddhvrkwEViHjEEmUXgWvRhFwpe9ylWiMYaw>
    <xmx:X-EpZ9dOwEDS_aBLtIxKfTCRMuI0MWGxd5ALwrw3NsMSP3VlwLjlIw>
    <xmx:X-EpZxFNiOtPHWsf_PrbZdSaa69qx5IhcePs9JCC5yg0c6mNmbmdiw>
    <xmx:X-EpZ8wwSo8ptwNVUTHlr6ZM_p9qhuNCHY4FWdJMd5wyeadxXy_vBw35>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 04:11:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b1283ada (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 09:11:34 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:11:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/8] refs/reftable: reuse iterators when reading refs
Message-ID: <cover.1730792627.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730732881.git.ps@pks.im>

Hi,

this is the second version of my patch series that refactors the
reftable backend to reuse iterators when reading random references. This
removes the overhead of having to recreate the iterator on every read
and thus leads to better performance and less allocation churn.

The only change compared to v2 is that I've rebased the series on top of
8f8d6eee53 (The seventh batch, 2024-11-01) with ps/reftable-detach at
3740325472 (reftable/system: provide thin wrapper for lockfile
subsystem, 2024-10-23) merged into it. This was done to fix textual and
semantic conflicts with that series.

Thanks!

Patrick

Patrick Steinhardt (8):
  refs/reftable: encapsulate reftable stack
  refs/reftable: handle reloading stacks in the reftable backend
  refs/reftable: read references via `struct reftable_backend`
  refs/reftable: refactor reading symbolic refs to use reftable backend
  refs/reftable: refactor reflog expiry to use reftable backend
  reftable/stack: add mechanism to notify callers on reload
  reftable/merged: drain priority queue on reseek
  refs/reftable: reuse iterators when reading refs

 refs/reftable-backend.c          | 369 +++++++++++++++++++------------
 reftable/merged.c                |   2 +
 reftable/reftable-stack.h        |   3 +
 reftable/reftable-writer.h       |   9 +
 reftable/stack.c                 |   9 +
 t/unit-tests/t-reftable-merged.c |  73 ++++++
 6 files changed, 321 insertions(+), 144 deletions(-)

Range-diff against v1:
1:  b599bcdac1 = 1:  ac01c06c41 refs/reftable: encapsulate reftable stack
2:  b81ce63589 = 2:  bab837e373 refs/reftable: handle reloading stacks in the reftable backend
3:  00fdf392a6 ! 3:  1b50655202 refs/reftable: read references via `struct reftable_backend`
    @@ refs/reftable-backend.c: static void reftable_backend_release(struct reftable_ba
     +		strbuf_addstr(referent, ref.value.symref);
     +		*type |= REF_ISSYMREF;
     +	} else if (reftable_ref_record_val1(&ref)) {
    ++		unsigned int hash_id;
    ++
    ++		switch (reftable_stack_hash_id(be->stack)) {
    ++		case REFTABLE_HASH_SHA1:
    ++			hash_id = GIT_HASH_SHA1;
    ++			break;
    ++		case REFTABLE_HASH_SHA256:
    ++			hash_id = GIT_HASH_SHA256;
    ++			break;
    ++		default:
    ++			BUG("unhandled hash ID %d", reftable_stack_hash_id(be->stack));
    ++		}
    ++
     +		oidread(oid, reftable_ref_record_val1(&ref),
    -+			&hash_algos[hash_algo_by_id(reftable_stack_hash_id(be->stack))]);
    ++			&hash_algos[hash_id]);
     +	} else {
     +		/* We got a tombstone, which should not happen. */
     +		BUG("unhandled reference value type %d", ref.value_type);
    @@ reftable/reftable-stack.h: struct reftable_compaction_stats {
      struct reftable_compaction_stats *
      reftable_stack_compaction_stats(struct reftable_stack *st);
      
    -+/* return the hash ID of the merged table. */
    -+uint32_t reftable_stack_hash_id(struct reftable_stack *st);
    ++/* Return the hash of the stack. */
    ++enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st);
     +
      #endif
     
    @@ reftable/stack.c: int reftable_stack_clean(struct reftable_stack *st)
      	return err;
      }
     +
    -+uint32_t reftable_stack_hash_id(struct reftable_stack *st)
    ++enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st)
     +{
     +	return reftable_merged_table_hash_id(st->merged);
     +}
4:  142081cb0c = 4:  0906b04fc6 refs/reftable: refactor reading symbolic refs to use reftable backend
5:  44f4adce9a = 5:  355557ec95 refs/reftable: refactor reflog expiry to use reftable backend
6:  0a294b577f ! 6:  71ad6c80b0 reftable/stack: add mechanism to notify callers on reload
    @@ Commit message
     
      ## reftable/reftable-writer.h ##
     @@ reftable/reftable-writer.h: struct reftable_write_options {
    - 	 * negative value will cause us to block indefinitely.
    + 	 * fsync(3P) when unset.
      	 */
    - 	long lock_timeout_ms;
    + 	int (*fsync)(int fd);
     +
     +	/*
     +	 * Callback function to execute whenever the stack is being reloaded.
7:  45f397b563 ! 7:  93efd11886 reftable/merged: drain priority queue on reseek
    @@ t/unit-tests/t-reftable-merged.c: static void t_merged_seek_multiple_times(void)
     +	check(!err);
     +	err = reftable_iterator_next_ref(&it, &rec);
     +	check(!err);
    -+	err = reftable_ref_record_equal(&rec, &r2[0], GIT_SHA1_RAWSZ);
    ++	err = reftable_ref_record_equal(&rec, &r2[0], REFTABLE_HASH_SIZE_SHA1);
     +	check(err == 1);
     +
     +	err = reftable_iterator_seek_ref(&it, "a");
     +	check(!err);
     +	err = reftable_iterator_next_ref(&it, &rec);
     +	check(!err);
    -+	err = reftable_ref_record_equal(&rec, &r1[0], GIT_SHA1_RAWSZ);
    ++	err = reftable_ref_record_equal(&rec, &r1[0], REFTABLE_HASH_SIZE_SHA1);
     +	check(err == 1);
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
8:  feb4e6a36f = 8:  276c27e770 refs/reftable: reuse iterators when reading refs
-- 
2.47.0.229.g8f8d6eee53.dirty

