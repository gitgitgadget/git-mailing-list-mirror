Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140C199EA2
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603401; cv=none; b=JgckDnXFixSHkkbr189/tHUvH/0OFPok4Qj0mjfV1CvlAHkg6pikS9bHbeL6cQvewBOkNci6MHcPUpFw/FIP1sVVXrBHnEGT86JRGY+pTsuD9rS7phFNhb//M5aoF7x4qn7XLD6qOXF48nTv2GJH9sXv/H7xZWLRElQQe6T/Yls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603401; c=relaxed/simple;
	bh=GS29QW5K5eJC2D3Q8zHhdR1bVjNFUz8vKrFJz4uzKPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UZDVD97UMTvf/oxMon33wUkRbOYlvAVqESL8weO4EilbqsOu1ZjfsqJsDNALsEapCokyvRPC2P2MtcF4P84fv34cjTM3LUtpFd4buLvZ4sYx0rPltw2toKxRFVEgUDGG6mG9T5zg6S1xEH+9YBpefRJMByy2WZj+ibnYQWq3AYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nmM0n7v6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJtI6/zY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nmM0n7v6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJtI6/zY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75A2E1140195;
	Tue, 26 Nov 2024 01:43:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 26 Nov 2024 01:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603397;
	 x=1732689797; bh=tXpqkJU3/48Dq0e5hPz42ubC41ZA//uEhX92CRN7jsA=; b=
	nmM0n7v6aO4hgDO36gkBw/iv8gtsH/TMymjPD01/i2Kx9laAIf4AQf2YWZu8mlNE
	PFxPxTGM+C6viGdm7yVdOIDXxB0tJuojLrwEUzU3ANTY5xo63LhvT2FW4dOyLZPc
	N/d5wCR6hMjB08svjNYajyorj8wGCWb5Z/1PZ8dPyxDJ1CAPSL8/9Ja8/9gJyHPR
	pml1BYNAfKvdqf/Fjn7zN/r/yBqG53Pb/K86SWNuPr+f8Nmy3yb+ajrehHy9XQ1x
	bM6RsuhMCMlIrvsoGKNun8fDzRz9HMlWj+S7+lG4w3+fINMvPO5GsT21dTZ0xZ1K
	5UemFkI1o4mGKR4qmeShRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603397; x=
	1732689797; bh=tXpqkJU3/48Dq0e5hPz42ubC41ZA//uEhX92CRN7jsA=; b=f
	JtI6/zYOTT9ngzWz69/K+IRgyrwzaPWTCut2/3CgQPJ/3+0KHy1EZV97ultWK7aY
	gp1NZE9qAmDPb6EG+L0rKSCzHvMc1qXGXLlbXERGb/I/aa1wEW690CzadZGM5cwS
	unj6JOqlzu8jiE/J8nf6aVA2zcA0U4CHbOcuCIGKgx6L5SjgxtrLpJiXLmk5Af1G
	ZcxWWMh7RvZlKPd2AnmWzNA2lytjhMFh1WjhenwFzNMuqT5lZ1eM9JyzTgzbzsA/
	nNAXcQpgfJfVj6J2MVMNoiSnhK294Ba6I+Dwd3hE92XoEhRHK5fuIYwTGajori7K
	ZkgUffW+F7M4Xhj7LLUWQ==
X-ME-Sender: <xms:BW5FZ5XNQkJQPtC-Xpzwf2oY7Q1OE2lCMJ4hppYBh5sG_SLag_QpzA>
    <xme:BW5FZ5mCdz6hc85L4_CXPh1H6YYZYUsCW3O4PzVpH-J-5gmWUvDuNwbYDzO4EFb_g
    -5adFMZG7iP82_7rQ>
X-ME-Received: <xmr:BW5FZ1ZppAKVsY_jqFYik4f11wSuYyh70bfQyOIv57qNMaLAuxVXWwHYqF3luMfIgOVgHXoHN1KjmX3pYDyWyqwL-qvvolM_EpPazKSrHRh3BTcZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtdduffdu
    veevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BW5FZ8WJz8oYjCwXU2U3EiZ08ASN_Qdm-0D7fLJN0Wmli3PEfrA6qQ>
    <xmx:BW5FZzlrBOTnWjoBZb1BL0WMORY50noAvBKfcU33qY38Jqb3-izpqA>
    <xmx:BW5FZ5d5qdWA1I2ZbgM7va9pUDw5Ti9i4aEHB3BRfF-H_hqMEw78uQ>
    <xmx:BW5FZ9EAOLifbzhv6DPB8hJ0NySp4JYeU5dqlAXOE6Lc1gDl1IPqNw>
    <xmx:BW5FZxjb2A6_D2Y0FQXziz4LSS1MCL1yi1mqLBrn079zdwOen7hpMyJG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7fa5a86c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:43:01 +0100
Subject: [PATCH v4 10/10] refs/reftable: reuse iterators when reading refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-10-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When reading references the reftable backend has to:

  1. Create a new ref iterator.

  2. Seek the iterator to the record we're searching for.

  3. Read the record.

We cannot really avoid the last two steps, but re-creating the iterator
every single time we want to read a reference is kind of expensive and a
waste of resources. We couldn't help it in the past though because it
was not possible to reuse iterators. But starting with 5bf96e0c39
(reftable/generic: move seeking of records into the iterator,
2024-05-13) we have split up the iterator lifecycle such that creating
the iterator and seeking are two different concerns.

Refactor the code such that we cache iterators in the reftable backend.
This cache is invalidated whenever the respective stack is reloaded such
that we know to recreate the iterator in that case. This leads to a
sizeable speedup when creating many refs, which requires a lot of random
reference reads:

    Benchmark 1: update-ref: create many refs (refcount = 100000, revision = master)
      Time (mean ± σ):      1.793 s ±  0.010 s    [User: 0.954 s, System: 0.835 s]
      Range (min … max):    1.781 s …  1.811 s    10 runs

    Benchmark 2: update-ref: create many refs (refcount = 100000, revision = HEAD)
      Time (mean ± σ):      1.680 s ±  0.013 s    [User: 0.846 s, System: 0.831 s]
      Range (min … max):    1.664 s …  1.702 s    10 runs

    Summary
      update-ref: create many refs (refcount = 100000, revision = HEAD) ran
        1.07 ± 0.01 times faster than update-ref: create many refs (refcount = 100000, revision = master)

While 7% is not a huge win, you have to consider that the benchmark is
_writing_ data, so _reading_ references is only one part of what we do.
Flame graphs show that we spend around 40% of our time reading refs, so
the speedup when reading refs is approximately ~2.5x that. I could not
find better benchmarks where we perform a lot of random ref reads.

You can also see a sizeable impact on memory usage when creating 100k
references. Before this change:

    HEAP SUMMARY:
        in use at exit: 19,112,538 bytes in 200,170 blocks
      total heap usage: 8,400,426 allocs, 8,200,256 frees, 454,367,048 bytes allocated

After this change:

    HEAP SUMMARY:
        in use at exit: 674,416 bytes in 169 blocks
      total heap usage: 7,929,872 allocs, 7,929,703 frees, 281,509,985 bytes allocated

As an additional factor, this refactoring opens up the possibility for
more performance optimizations in how we re-seek iterators. Any change
that allows us to optimize re-seeking by e.g. reusing data structures
would thus also directly speed up random reads.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b6638d43028d11ae7621dcd4e0dbf1d3174743b7..a80c334f384acd0d72a1c4ef9e59c93600dd6db4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -36,19 +36,30 @@
 
 struct reftable_backend {
 	struct reftable_stack *stack;
+	struct reftable_iterator it;
 };
 
+static void reftable_backend_on_reload(void *payload)
+{
+	struct reftable_backend *be = payload;
+	reftable_iterator_destroy(&be->it);
+}
+
 static int reftable_backend_init(struct reftable_backend *be,
 				 const char *path,
-				 const struct reftable_write_options *opts)
+				 const struct reftable_write_options *_opts)
 {
-	return reftable_new_stack(&be->stack, path, opts);
+	struct reftable_write_options opts = *_opts;
+	opts.on_reload = reftable_backend_on_reload;
+	opts.on_reload_payload = be;
+	return reftable_new_stack(&be->stack, path, &opts);
 }
 
 static void reftable_backend_release(struct reftable_backend *be)
 {
 	reftable_stack_destroy(be->stack);
 	be->stack = NULL;
+	reftable_iterator_destroy(&be->it);
 }
 
 static int reftable_backend_read_ref(struct reftable_backend *be,
@@ -60,10 +71,25 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 	struct reftable_ref_record ref = {0};
 	int ret;
 
-	ret = reftable_stack_read_ref(be->stack, refname, &ref);
+	if (!be->it.ops) {
+		ret = reftable_stack_init_ref_iterator(be->stack, &be->it);
+		if (ret)
+			goto done;
+	}
+
+	ret = reftable_iterator_seek_ref(&be->it, refname);
 	if (ret)
 		goto done;
 
+	ret = reftable_iterator_next_ref(&be->it, &ref);
+	if (ret)
+		goto done;
+
+	if (strcmp(ref.refname, refname)) {
+		ret = 1;
+		goto done;
+	}
+
 	if (ref.value_type == REFTABLE_REF_SYMREF) {
 		strbuf_reset(referent);
 		strbuf_addstr(referent, ref.value.symref);

-- 
2.47.0.366.gd4f858ca17.dirty

