Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF70205ACF
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430832; cv=none; b=lGmXI0+R6Jta3vj7qO9IIZ7v6IWswPn3a8fLP22izNPZjpbzCmhK6i9GA9WO1O3mVC6JyCa3LOEN7JMvdhtrQNns1IA4HxwfOACi354v4H5e6DDNWu3TD501/JohqRSHtn1mzx5oEhVYYlbTEOGUQ1cAQ6Sqm8wyel9Q9L0z+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430832; c=relaxed/simple;
	bh=gF6tv5REreb1qPt/8e7LAozBlVWtd9LkXXowWgelQ5Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QowhESGySe9fK2zRSVq7ofTe6MsB2PjdlYQITf++AWmRA5FxzlW1zhw5Ionenz7+e2JALqzPMLv0MZzsvL2xMNQhupQzAucr/FzLBpykE5tmH2R2+0OcvCCqrJyxZaXdYCqWU2PTiC90lMMvVyCCSKCe3cVP1H6INs1ZmHHO1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H8EHpcFS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJcfcBS6; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H8EHpcFS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJcfcBS6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70641254019A;
	Thu, 13 Feb 2025 02:13:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 13 Feb 2025 02:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739430828;
	 x=1739517228; bh=+ODzj9ov/fAWEE4AaoNCmj5ufeb91KfCjfj/mKPBR+M=; b=
	H8EHpcFSXi2nYmRxpSoaMltvFgCbAFaYkNMn1qsapYN7mZLGLiZKeBj849zq9BnR
	2ziN3vUaHi9L7OBB1U05aLIiiQyrHlSZrjzwfwWSUfXXMwU8TxDHPImk8DflGZu5
	RGGu5RC4CvVlL4s0UmUUBfNmVj/ojpAhbOQLCFzdXySouPZhfyVjiLZnrxpBRxfT
	iq+f8IvJrmx9IMVCpSOkY0Nzw+NXXUnWn2nKVtQEgH/YhzlTmUvbP8o2+k2IyYL0
	vMQnAuQqBiKgMLbw2xi32ysBiRkngBy0P6yYXgwbSQspSNc00aJtOfxhIxIzg0IB
	5WP28gPKAAtS2HrnX4R6Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739430828; x=1739517228; bh=+
	ODzj9ov/fAWEE4AaoNCmj5ufeb91KfCjfj/mKPBR+M=; b=KJcfcBS6GXZq0VlLX
	WQsHWXj37G7+dW730+pdduaeX0P/fXNNdhG3RslgiHZ4av4zbECoSR84MKnJinri
	JzmMvLa8ui597Wru7RqPUat8/bolb7mg4ByGrVnyCO2l4KWR162VxD6Y89e41naF
	W3GFDwVdn9UlHLsp7ooclMGyEysUGG7mLIJn+KVX6jfhC5Vd/PD8DhxIHrw7DlTK
	Ey49QDHZCK5jaj9++tqc7iEjGylFvbC+XL8xkRpyWi/DYQ8EEOTvqWxor9fxfORR
	cO8JY/tAwuR7qe/CC7niP7k8Z+4rUMF1u/zNFuOwjN74vPhyMY53PsR2mJGnTo0k
	7VyPQ==
X-ME-Sender: <xms:rJutZ3zRQV8yG7UhHwyouPhqdwaVAxfZf96y8dKVyafoAtfd1eQvOw>
    <xme:rJutZ_S1gZ_6FP3byes_UxPTXTudCElm6pnx7Vdlt4NpmXKtq7P-83FLzq8RjLOxm
    bvxo06hsKoUqtj2Tw>
X-ME-Received: <xmr:rJutZxUJBMAKbF4TH8K7TGoTeXNHrnJSeGCQU29jgkopqcx-6k-OQIKjdg1blMT4_14EKDFWsY6CQTDyqLDbH_DbqHkBG0yopgJl4FRwwQvNUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegiedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeelheffgfegieeufeehieethfegveejvddvjedtuedu
    vedvvddtkedtgfegjeffkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:rJutZxgoIDxg89_nQYL4Gd4DFcNKgm4kjzzGy1GjzoaD1GDxR6i1Vw>
    <xmx:rJutZ5BmGoBvigtpRehgSqYkymHGrN1YbajypIy1GTgpLY76kMWalQ>
    <xmx:rJutZ6KnCTG4zT-Z5xN0qOpSSd_cFHWnGOD2BGDG78skWJ5Rfe_o5w>
    <xmx:rJutZ4B9rQWe4kZfXAXI3Fus89sdq6o9LSFu80HJ3PLe5tP2nHt3OA>
    <xmx:rJutZ4Ofbg83w8xwjlYK0YJ0DCcde0R1i86b2kxkD-wnv6pt6NgbpI8O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 02:13:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d44b5a91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Feb 2025 07:13:43 +0000 (UTC)
Date: Thu, 13 Feb 2025 08:13:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
Message-ID: <Z62booOOXODOl_sZ@pks.im>
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
 <Z62NFXja4CkrxSil@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z62NFXja4CkrxSil@pks.im>

On Thu, Feb 13, 2025 at 07:11:33AM +0100, Patrick Steinhardt wrote:
> On Thu, Feb 13, 2025 at 12:01:59AM +0000, brian m. carlson wrote:
> > It takes about 30 times as long to perform using the reftable backend,
> > which is concerning.  While this is a synthetic measurement, I had
> > intended to use it to determine the performance characteristics of
> > the reference update portion when pushing a large repository for the
> > first time.
> 
> Interesting, that's an edge case I didn't yet see. I know about some
> cases where reftables are ~10% slower, but 30x slower is in a different
> ballpark.

Well, I just cannot resist and had to investigate immediately. I can
indeed reproduce the issue with "linux.git" rather easily:

    Benchmark 1: update-ref (refformat = files)
      Time (mean ± σ):     223.0 ms ±   2.4 ms    [User: 76.1 ms, System: 145.6 ms]
      Range (min … max):   220.2 ms … 226.6 ms    5 runs

    Benchmark 2: update-ref (refformat = reftable)
      Time (mean ± σ):     17.472 s ±  0.153 s    [User: 17.402 s, System: 0.049 s]
      Range (min … max):   17.390 s … 17.745 s    5 runs

    Summary
      update-ref (refformat = files) ran
       78.35 ± 1.09 times faster than update-ref (refformat = reftable)

Oops, that indeed doesn't look great.

Turns out that you're hitting quite a funny edge case: the issue comes
from you first deleting all preexisting refs in the target repository
before recreating them. With "packed-refs", this leads to a repository
that has neither a "packed-refs" file nor any loose ref, except for HEAD
of course. But with "reftables" it doesn't:

    total 368
    -rw-r--r-- 1 pks users 332102 Feb 13 08:00 0x000000000001-0x000000000001-d8285c7c.ref
    -rw-r--r-- 1 pks users  32941 Feb 13 08:00 0x000000000002-0x000000000003-f1a8ebf9.ref
    -rw-r--r-- 1 pks users     86 Feb 13 08:00 tables.list

We end up with two tables: the first one has been created when cloning
the repository and contains all references. The second one has been
created when deleting all references, so it only contains ref deletions.
Because deletions don't have to carry an object ID, the resulting table
is also much smaller. This has the effect that auto-compaction does not
kick in, because we see that the geometric sequence is still intact. And
consequently, all the checks that we perform when recreating the refs
are way more expensive now because we have to search for conflicts.

A "fix" would be to pack references after you have deleted refs. This
leads to a significant speedup and makes the reftable backend outperform
the files backend:

    Benchmark 1: update-ref (refformat = files)
      Time (mean ± σ):     223.1 ms ±   0.6 ms    [User: 71.2 ms, System: 150.8 ms]
      Range (min … max):   222.5 ms … 224.2 ms    5 runs

    Benchmark 2: update-ref (refformat = reftable)
      Time (mean ± σ):     129.1 ms ±   2.1 ms    [User: 84.4 ms, System: 44.1 ms]
      Range (min … max):   127.2 ms … 132.7 ms    5 runs

    Summary
      update-ref (refformat = reftable) ran
        1.73 ± 0.03 times faster than update-ref (refformat = files)

I don't really think there's a general fix for this issue though, as the
issue comes from the design of how tombstone references work.

That being said, I found an optimization in how we parse ref updates in
git-update-ref(1): when we see an exact object ID, we can skip the call
to `repo_get_oid()`. This function is quite expensive because it doesn't
only parse object IDs, but revisions in general. This didn't have much
of an impact on "packed-refs", because there are no references in the
first place. But it did have a significant impact on the "reftable"
backend, where we do have deleted references.

So optimizing this edge case leads to a significant speedup for the
"reftable" backend, but also to a small speedup for the "files" backend:

    Benchmark 1: update-ref (refformat = files, revision = master)
      Time (mean ± σ):     224.7 ms ±   2.9 ms    [User: 79.4 ms, System: 143.5 ms]
      Range (min … max):   220.2 ms … 228.0 ms    5 runs

    Benchmark 2: update-ref (refformat = reftable, revision = master)
      Time (mean ± σ):     16.304 s ±  0.429 s    [User: 16.216 s, System: 0.051 s]
      Range (min … max):   15.865 s … 16.862 s    5 runs

    Benchmark 3: update-ref (refformat = files, revision = pks-reftable-optimization)
      Time (mean ± σ):     181.3 ms ±   2.4 ms    [User: 69.5 ms, System: 110.7 ms]
      Range (min … max):   178.5 ms … 185.0 ms    5 runs

    Benchmark 4: update-ref (refformat = reftable, revision = pks-reftable-optimization)
      Time (mean ± σ):      5.939 s ±  0.060 s    [User: 5.895 s, System: 0.028 s]
      Range (min … max):    5.875 s …  6.026 s    5 runs

    Summary
      update-ref (refformat = files, revision = pks-reftable-optimization) ran
        1.24 ± 0.02 times faster than update-ref (refformat = files, revision = master)
       32.76 ± 0.55 times faster than update-ref (refformat = reftable, revision = pks-reftable-optimization)
       89.93 ± 2.65 times faster than update-ref (refformat = reftable, revision = master)

I will continue digging a bit to see whether there is more to find in
this context and will send a patch to the mailing list later today or
tomorrow.

Patrick
