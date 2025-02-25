Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A226656D
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473778; cv=none; b=EauSFqhwJdyzzbjD0R45Nn3+/NYj0wlV9cNpbKmi2FuVd9SzDT6XMPN93BoT3H7mCjW/Z8QcCp6V0/hAJ4HepOiL8jSfTWsIsUxWEM76bZRFxjBiStfK/nyAcWJVX9UiXSZ8APxUV137ArpE2WkFh95S1zE3ncGIX83UPgXQHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473778; c=relaxed/simple;
	bh=gf5XcntSHq4tygDKcASbHcosADwNd2ifuC/aSuPtvho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwhese5CUENUJxh8xSE6uVoBsi6WRG3x9liy1PzC6Ors1XrVWEMuJY/4T/Iud3vNam3xBKbvMEOihGgOBKv1eOgv6dLchPoZ5yoxf08eSWfzyt/6GwzPSwaXQ7on/dSIoJqZIazfF098ycsZfM1NLLBUTpukC4F26A+76W+hZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ir75jZ8O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4DX815z; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ir75jZ8O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4DX815z"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A45E01140117;
	Tue, 25 Feb 2025 03:56:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 25 Feb 2025 03:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473773;
	 x=1740560173; bh=pTNe9ddajIHL5/9XXPG1GUJ51x4aMkEBVV2IPVlXJMA=; b=
	ir75jZ8OWFaw8OwCMjA90/vPpcD3LGskuR3s2RMgHue1/aHFG3Hif/JMqwxEi9Sq
	XKJE0QUQhrTsJD4n5xa2YmPs0GYTwBkQkv2USRRfihjI+tBT7jV8wkkYRaYyBgvJ
	bP1ka5Jrm3Z9Y/dRBYlcZkOeXC5m9zC9mcUzLmqzgAZ7zkrj2Q+Ly72h4GmLKge4
	K31FaAGQExanRSBjrBH2Dnyf0CugcF7xw4+p+xKyRTkemyzXyVZSPPWf2Tdpt04R
	g0gh3AMjWFb+d34FhJ3JmbtGQ65Ag8mOqdtr0e8p+k4ng6T0fgEFAvtLcExK9LBM
	3zPPPNJlMEEbur4vSXsRUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473773; x=
	1740560173; bh=pTNe9ddajIHL5/9XXPG1GUJ51x4aMkEBVV2IPVlXJMA=; b=e
	4DX815zrY6Mh2O6WMb5LdlcWnFXySE2ToAerVfEOtR4GH2W3jbXylPT1hHYcW1rb
	7IE1U043AWodfSYW8KUyPDeCtDENwciCVEaFhGV1SycyP8HGd6sHKdMXJ8JtxDe/
	VSABQbWbo8m92up+sGaKqAeByUftkjBF8ZGmdjjZaos1TiOzX4/bLdOO4gCULUUG
	+WF7vfCJnS5lw+Unxk7KCpAZVzgRBjTo1CO5/mquMan6Y6Yd74nsDRD9z3rQTwv2
	BRdypenP7J+LuydlYR15benleXizrEBC7K8XDfdHMfyOyO29GBzVZ1DTN/dKOEgZ
	64JROh8yan/lfoW72IcjQ==
X-ME-Sender: <xms:rYW9Z1aD0UPju_12E4SbrRHSyXma6gIBv5WZQFSz32DPjOZiztvj-A>
    <xme:rYW9Z8ZLcgt99RHpr3-A5QlrreJUYw7Dzwj_j-X_v-PLjJ04m7YLsifV8eQuvwdFi
    xIls_EFkx_ATYCcMg>
X-ME-Received: <xmr:rYW9Z39_phW6Z5MDbp4v1b7GDsP0XlRNKnDmaRoINooX4MiA57294-GKeoiULnvMrj2TmU1OQHDcNUIe30nldHuKwitz3yvypKS1V7qSqulOtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehs
    hhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rYW9ZzrPZ76kgX2Lnnl0wu9fi6fG3lqT2mbxTKnXafDtm9DAH1eLnA>
    <xmx:rYW9ZwocHejNtoN6mHIyt20w7Rqg9eWl3NwqZANkzJEDqgZ8eQz1rg>
    <xmx:rYW9Z5SItAF4PPp9EMJ5A2Steh88JlLHoLbsf0jJOl9J0QTEGigJqA>
    <xmx:rYW9Z4qwoJ8k1lA1ib6tVE1Y9KynX_X-hHyoA-LkyBJ9wbqme-7Seg>
    <xmx:rYW9Z4JTvlQaC6pwVfqNo-LiTzNFze8UmafFx1okq2DBefAxTKqo03ak>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f67e03b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:56:02 +0100
Subject: [PATCH v3 16/16] refs: reuse iterators when determining refname
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-pks-update-ref-optimization-v3-16-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

When verifying whether refnames are available we have to verify whether
any reference exists that is nested under the current reference. E.g.
given a reference "refs/heads/foo", we must make sure that there is no
other reference "refs/heads/foo/*".

This check is performed using a ref iterator with the prefix set to the
nested reference namespace. Until now it used to not be possible to
reseek iterators, so we always had to reallocate the iterator for every
single reference we're about to check. This keeps us from reusing state
that the iterator may have and that may make it work more efficiently.

Refactor the logic to reseek iterators. This leads to a sizeable speedup
with the "reftable" backend:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):      39.8 ms ±   0.9 ms    [User: 29.7 ms, System: 9.8 ms]
      Range (min … max):    38.4 ms …  42.0 ms    62 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      31.9 ms ±   1.1 ms    [User: 27.0 ms, System: 4.5 ms]
      Range (min … max):    29.8 ms …  34.3 ms    74 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.25 ± 0.05 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)

The "files" backend doesn't really show a huge impact:

    Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):     392.3 ms ±   7.1 ms    [User: 59.7 ms, System: 328.8 ms]
      Range (min … max):   384.6 ms … 404.5 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     387.7 ms ±   7.4 ms    [User: 54.6 ms, System: 329.6 ms]
      Range (min … max):   377.0 ms … 397.7 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.01 ± 0.03 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)

This is mostly because it is way slower to begin with because it has to
create a separate file for each new reference, so the milliseconds we
shave off by reseeking the iterator doesn't really translate into a
significant relative improvement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 8eff60a2186..6cbb9decdb0 100644
--- a/refs.c
+++ b/refs.c
@@ -2555,8 +2555,13 @@ int refs_verify_refnames_available(struct ref_store *refs,
 		if (!initial_transaction) {
 			int ok;
 
-			iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
-						       DO_FOR_EACH_INCLUDE_BROKEN);
+			if (!iter) {
+				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
+							       DO_FOR_EACH_INCLUDE_BROKEN);
+			} else if (ref_iterator_seek(iter, dirname.buf) < 0) {
+				goto cleanup;
+			}
+
 			while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 				if (skip &&
 				    string_list_has_string(skip, iter->refname))
@@ -2569,9 +2574,6 @@ int refs_verify_refnames_available(struct ref_store *refs,
 
 			if (ok != ITER_DONE)
 				BUG("error while iterating over references");
-
-			ref_iterator_free(iter);
-			iter = NULL;
 		}
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);

-- 
2.48.1.683.gf705b3209c.dirty

