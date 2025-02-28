Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480325E464
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734827; cv=none; b=qXFpg7q1FPDv3JQRjXa1wMjzj5qhQug9y5tTCUnAAUuy1rEldJbUdplzTZjl7qMDKTJP3icL/wbvoRWiG3GMsvl11n9vj6SG93vgyw07XEjCtP9CxKpVgiM/aAf+b3y70s0vIS1646FPoEMDYDVUReDr1mQZpQ9kvPBKwCkZE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734827; c=relaxed/simple;
	bh=dKTEsV3kD3l0HlN5c3KDOj/Vfb60oZLK9QmKojFkX8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZ4/m1NNQtev0D5qdeEvGyPBbfZGR1aFnt1IoZI1DayWHivZt839MNX5i9RcQntHVn4JBlYiPCIfuoJLG7BDNOsB39/G8w653pm89sNX9wwhErFHLx7jThbIeQDhk/FScYme9XQYce8mBDjTvXdJGTjvRqvVLB5R0Z/4R42vLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gtsLE38S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3La7al+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gtsLE38S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3La7al+"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 66235138276C;
	Fri, 28 Feb 2025 04:27:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Fri, 28 Feb 2025 04:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734824;
	 x=1740821224; bh=9HyOt78keD7o3Pqr/Tz0INicS1Fx7q9bSWGyQFBmlrg=; b=
	gtsLE38S7trn+tTS3ivolElu47M++b9Vi9BP866O9iRwofdfJ22UEL852x/HPtWf
	0ukT2bvop1vD2EabxdkboZOKFc22cWlupFEEEPkKAaSkvLrhPiYpIeqz5aCHa+aL
	gqoZvGkj/oSv5farrQ5DBT3EO2w4BUyE3xNw5Uz0gs58vl5HOuq3iQCKWLpx3zi0
	9IntAnx3NUEhI+VW5lmGEKBDv+J4g5A/ppxJ0FuaUeDXVgPBWlfmxDozhEeJNfx0
	4mzLUYN+FhbvTu6q+zIQ+d076YVqR0vhyeaS21m9ZaN5QyYWcrqQIOzHwCTBaB4u
	9Pew3V/cEg0YvlOltMeBJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734824; x=
	1740821224; bh=9HyOt78keD7o3Pqr/Tz0INicS1Fx7q9bSWGyQFBmlrg=; b=j
	3La7al+41pGDIGbZjuDPjYqTuwTrhGBwaSJRFC2TAEqWrYSWOW7PvdtVhu6gpgzG
	Hrzbehe7prqcTl6NOfavwxkjWeKoFHg9ILnCfyNP1ATud8qlz/lNc9MBXRgJG9sY
	aK3+Hqt9CLjXF5zf69L0lRSqua6O+pjUYXv2//urN3+hHJJMcTsKZRp95+3b23xV
	id5eGg6HLVfcfAsU3KJbbDorI296z7PftkxYYfnCudZMzVJhqLD4s+hKIB7OhNqD
	pET7642Uu3xnJ5Zz8oCLKBgOL3FF7u/pfiuzN26GQksnnDOFPH8YcfWLGEDfIZLO
	vVtqKfV0ueHg7zkjIOr3A==
X-ME-Sender: <xms:aIHBZxMwS35IsYZyh70lzPNXo_NlgAnNiwjCpSjU0m-LlaZ5G4bK3A>
    <xme:aIHBZz-mrmYiOoE2VjRQ8SLZPO98-YEsLvHEiwLFkq3S672eLGrNY9xg4h5Xr1ZXX
    XLcKa2f3mrpL_y4-Q>
X-ME-Received: <xmr:aIHBZwS7LX0urpxN1qFJ_wjzfdN7hqhFnj7_0UdDSSdYvVVjCT9ilTp6VjHZmpgnPD6isSYEj0fa1rgaQ3npP-4kH1LypyMSLnLFtsNQNzXeG0Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:aIHBZ9ukEYfhtF093RRJ6DuCK6Sh4s85ZYJFHhbhFaJp_jRnVVIUBA>
    <xmx:aIHBZ5e3x3wmmCQc4o0kMSCadO9VoczSYwtFqJOxFphgtpYt2wfaeA>
    <xmx:aIHBZ51xFUKz8kZiBSGwJlXN2yAArbLyQ87FSitGYjsN1WIg-K-jJA>
    <xmx:aIHBZ1__jbybtdNAV0QhQsc-Atj6y1Yg1k2nN04E5CmU0g6ydwTYqg>
    <xmx:aIHBZzs-mlYhtt1iuLvLV2TPPCTNxwlq0alHUjRSKlrg29QyFbY9_u6j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:27:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac019a9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:53 +0100
Subject: [PATCH v4 16/16] refs: reuse iterators when determining refname
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-pks-update-ref-optimization-v4-16-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
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
2.49.0.rc0.375.gae4b89d849.dirty

