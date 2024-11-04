Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F431C174E
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733126; cv=none; b=W7Ewq6Yfrzb/jdfmwI2y3m3cNysO67qz0FpkWIhBJ4TK03Z9z4bLPltClhjPWJa4kWTJtDxH9WxqnJSdmZKQlT4VddRuZdGtslFifRMatNqYGwUI3XRU4INrbDSLbcLxzMT8P67Yrj1X3tiWcOpUh7FVRnFLmRqZn+6NAj4Hczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733126; c=relaxed/simple;
	bh=jKtoGVTbzHHbF+uv5dwT2ETwcP5KhFpeswfMytevXdQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNOW6chLDi5aD5ul+h9Pk86q/IaQGbZnyeyWDxu2j6DcxnIxp73rPBRAvwy1Q2oAjbMUzw8klZqnrorWXfx81FEKBJFXJ5x/FPM0hvfs1Qp14VAiNFHVUM10OPECO7NYW25TaORyAIhJIvytmCdIc2GJOQ/Jv96oVRWSp2XMuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PAAUJL2z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=malmlFHu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PAAUJL2z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="malmlFHu"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E02611400CC
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:12:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 10:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730733124;
	 x=1730819524; bh=nCaWGSuF62W9wDdAO2kqcwglUAild5ASPO+9YQFa5KE=; b=
	PAAUJL2zrmWkmxAlXqIzVjgKyaxoT+K4AW1jmAHHmy6/gOoJfsHM6STCANFLGBg5
	Bmb+LPqG9QL3l638ZE+pw43bzTypUQDt294d2cGH+M7EoXLUDyn/lStbJKgyUr4x
	nhBQVOb4no/SR5JuPOP1atKJVSNgw/vqm481/H1WiUIXF7EnjHN36SsbrXAIZqyO
	qvhcSYP1C04+dV7wdBNyZKtc7AFh4bl9utRKLqMg4I6bWA8+sveX4TunqMLKfaos
	Ukqsv4UlXLyK6rebJS32Y4iS/zD1L4KcwnoKMw2/9RlqZdTH2WJ3Q7wQxCwiCcVR
	26t2XOpmG6AYbKhaMVVPWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730733124; x=1730819524; bh=n
	CaWGSuF62W9wDdAO2kqcwglUAild5ASPO+9YQFa5KE=; b=malmlFHuT1lMagAPR
	tTXWMakYp+6DiSz0gHL9Fuj3PbX+RTmQ0Va4tpH5RWzrHDNw4MED0koHMoSdqgz+
	VV9wRj7DgNckvi6SNO61MZMdjZILezbHl+e0AW5KPGgi+NVJEYEW54/0WLxmHmHZ
	/QOksrM8Y6PcwngHLDhfIDaI0/jAk7PpE7V742WP1IX51ZwrSouG/SO3WkVMIpUo
	HWx+Z7wczenoo3vJttf8DVBDNNSWVu/AbEC/Jx7cm+tuWolqzLmjUovZuh5mX/OM
	/FGO1qJvvvri1uHgCYvTR/l4HJfJFG2+h7Tou6/pQXtOZ6cgrigm3ZYdMM+s9FT3
	PTzLw==
X-ME-Sender: <xms:Q-QoZ9r2_OXzhYPnxAhkaOrJbSs0gFz5BX5InVZZvNf9Hf6FvCUJRw>
    <xme:Q-QoZ_oSaxdBF84JcT7x8eVTm8zoeDzBSHfCPTsk94Jwf-tzd4Np8FC7qm3Qu8Asf
    -aAT2vhgKzm7wL5ew>
X-ME-Received: <xmr:Q-QoZ6MIfG2xdxiBYFrLsLQsgsT4VIArXmRRa3Q-w7LFEVsn93UuABMJjX5-36fgKX7l05UKHw3KytbednztpHVZ3SVJZAQlAMp_fWG7RYElmB3mbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelheffgfegie
    eufeehieethfegveejvddvjedtueduvedvvddtkedtgfegjeffkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q-QoZ46LuaLAHsjqHXSQwH1GVuvufdvz9eAvzza1gSfwtG1Qe6uH6Q>
    <xmx:Q-QoZ87DjQO339opXpdTlKFwn6dKwW_iGqAodszssue9CNEOzVcgVw>
    <xmx:Q-QoZwgPFoiUof0BwDV-ZdY2v7bqF-lXzxuCIKuwEAZqMV9aXZUVeg>
    <xmx:Q-QoZ-4n4wAWDG8aE4RkxSKl5YnZjuBnizH_Q3Gs8TMRK_aKM_CO-w>
    <xmx:ROQoZ6Q6dbDDMkYYWV6bDKdV50iI44RGvpBxbpJjueuCIidIebnWuKSt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Nov 2024 10:12:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b30d6a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Nov 2024 15:11:42 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:11:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 8/8] refs/reftable: reuse iterators when reading refs
Message-ID: <feb4e6a36f960914ee6967b95d877d97065b5384.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730732881.git.ps@pks.im>

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
index 98a070f5a7..e0577d666f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -34,19 +34,30 @@
 
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
@@ -58,10 +69,25 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
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
2.47.0.229.g8f8d6eee53.dirty

