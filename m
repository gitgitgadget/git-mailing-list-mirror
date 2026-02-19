Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073C2F549F
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482340; cv=none; b=TQRVfjXFSRNzBoQ9/MWkvWbOrhK4/AOOnwfrVbUAm74YItMFVFIh0SeK6w1x264NmtlhObbxoXyeedL4eruLPpR1m+HqyPr8mJZgqQ19FkGLBvKVbRC4IenwdPkiLx1E2lc1k6QUqNrog97b/KoVrubPhCltZyN6aPzrs3Kdu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482340; c=relaxed/simple;
	bh=iCdYlYewLnCC57WbLDhZ80W5F5iQU9UifhLZUMWrNeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bU1xXXXwqnVPi5SgqXItP7Iwsnrq1Gjpal3xpt+Ii+SECzyoMn2GKcyWB7nETSn2YmlmLM8hfe47LezJWbD+L31BIO2mXvaJBvdChRSoRH4kzrhxxVPY1wc3qrS8hthLkY4bvXsnVSZU6MElGkw0s3fjZbRNx5ZtjqOva44IcbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RmFagxXw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nMgP8+Al; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RmFagxXw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMgP8+Al"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 441B01400143;
	Thu, 19 Feb 2026 01:25:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 19 Feb 2026 01:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771482338;
	 x=1771568738; bh=4YuRi5WOcCpargaXNQsbOa4I00fhFVVwezhNEhnthQw=; b=
	RmFagxXwO2vcoI2tmL6m2DDFElsFgxu7vybBi+7qSiIOlXQ37yIDT3WaHy0GG2um
	FmOIpQxHjTurg5eqoYBqKdqs2iDdAYyKPBwjoKhgUVp8t3QCpx+RFEvwqL7xMayJ
	l8+nt/tO1XWA8DMIp4lXZ1BqtZoljvh69E08c5rlHFaSzqtbWjvtQcQ175ZJx9fD
	hqzFcwp7nY1vzvozLzttxuf7l+d8rh38I1k1rw89/XfSzh++MMGp+XikjjaV/G16
	LcIRJJUYmHflAutRiN1iNP9NOm4aZ8feF36nTyItV2dqlq8BM4jpa6reeObSCgd6
	7vw3mr2hdW784/Tzv6DOJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771482338; x=
	1771568738; bh=4YuRi5WOcCpargaXNQsbOa4I00fhFVVwezhNEhnthQw=; b=n
	MgP8+AlcvRe38dpvZ0LM8MFaBIEWtDkN9vJ6lcO2ojirhzWCoKN0BGtolaItuUnF
	/nkjxYkxcb6NeZC+H8Sa87SZbrIBVEdFwFh59p2Q8WzN6tMWvvvl6/vpngUHVeUe
	3b3QG7oUvaeqweTl4n3w00i8d+x3JMm96MgGZZjFxZ18Q0tcV5ZAMoUP3f5VxEnr
	fiw7NkjBv1EC2QBg78N3ZSYiteG4PzkOG9OXj2FjHCbOxEcghYKY2vlWYWVoFkYZ
	/P99hcyN4aVh0keC6COstUqXisG5w/0lX5u0d8XLuPY4HNu0C/xstbBexDjlgMXx
	wIAZpLg+sbRiv8gAunU6Q==
X-ME-Sender: <xms:4qyWaVtvAWsCmOc4xQ88Ff-JqgQ1Co2vs8962zr9ApFQnoW4Ckv0Bw>
    <xme:4qyWaZ--ng4XQX6-PBhWcPEcSUIWH-WeE0tgSRcfrIKuA5FdwoG-jNe25IGiR77Yj
    ui6aPPPKuNJ0bQUlP50BkZc1GHrSm7AjVLpli_QDplhWFXefbzt>
X-ME-Received: <xmr:4qyWafMtD_uvuyoDPQ2zbX0s-HrrdMRkjib1sw-_H6nFfovAeQ6mE7ixH0Qhx27LSfpZfSXFTO6BIqTktLEtr96WesLxxgMtiqN42Kt-YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:4qyWaXGf2NP25uuEd3JNWAVsrBGBv3KWkFszvOIx0h-4p1fLu1Xa7A>
    <xmx:4qyWadTCo9D22HBKcO7h0ZF6k6dN91Zh78YTzne2BzF6eeTkX-RgdQ>
    <xmx:4qyWaUu0bcDWotnQ6RDAWU7maGy4uKpQO91D0ONSb0j4O7_r6l_tSg>
    <xmx:4qyWaVJnRrVw85VEVc1DoKrICZEniME_CHdxNbXia4kUu68fSdh7Cw>
    <xmx:4qyWaTrCEA8P9wWCm3OoK0lGz7DtyVL6RCl4gXI301PmhQiuZ0cCNjF1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 01:25:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 589e7ff7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 06:25:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 07:25:28 +0100
Subject: [PATCH v2 2/7] ci: don't skip smallest test slice in GitLab
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-ci-meson-improvements-v2-2-6047b8307ab2@pks.im>
References: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
In-Reply-To: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

The "ci/run-test-slice.sh" script can be used to slice up all of our
tests into N pieces and then run each of them on a separate CI job.
This is used by both GitLab and GitHub CI to speed up Windows tests,
which would otherwise be painfully slow.

The infra itself is fueled by `test-tool path-utils slice-tests`. This
tool receives as input an "offset" and a "stride" that can be combined
to slice up tests. This framing can be misleading though: you are
expected to pass a zero-based index as "offset", and the complete number
of slices to the "stride". The latter makes sense, but it is somewhat
surprising that the offset needs to be zero-based. And this is in fact
biting us: while GitHub passes zero-based indices, GitLab passes
`$CI_NODE_INDEX`, which is a one-based indice.

Ideally, we should have verification that the parameters make sense.
And naturally, one would for example expect that it's an error to call
the binary with an offset larger than the stride. But with the current
framing as "offset" it's not even wrong to do so, as it is of course
well-defined to start at a larger offset than the stride.

This means that we get this wrong on GitLab's CI, as we pass a one based
index there, and this causes us to skip one of the tests. Interestingly,
it's not the lexicographically first test that we skip. Instead, as we
sort tests by size before slicing them, we skip the _smallest_ test.

Reframe the problem to instead talk about "slice number" and "total
number of slices". For all of our use cases this is semantically
equivalent, but it allows us to perform some verifications:

  - The total number of slices must be greater than 1.

  - The selected slice must be between 1 <= nr <= slices_total.

As the indices are now one-based it means that GitLab's CI is fixed.
The GitHub workflow is updated accordingly.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml |  4 ++--
 t/helper/test-path-utils.c | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index f2e93f5461..ec1a660981 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -150,7 +150,7 @@ jobs:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: test
       shell: bash
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}} + 1)) 10
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       shell: bash
@@ -237,7 +237,7 @@ jobs:
       shell: bash
       env:
         NO_SVN_TESTS: 1
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}} + 1)) 10
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       shell: bash
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index f5f33751da..874542ec34 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -477,14 +477,20 @@ int cmd__path_utils(int argc, const char **argv)
 
 	if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
 		int res = 0;
-		long offset, stride, i;
+		long slice, slices_total, i;
 		struct string_list list = STRING_LIST_INIT_NODUP;
 		struct stat st;
 
-		offset = strtol(argv[2], NULL, 10);
-		stride = strtol(argv[3], NULL, 10);
-		if (stride < 1)
-			stride = 1;
+		slices_total = strtol(argv[3], NULL, 10);
+		if (slices_total < 1)
+			die("there must be at least one slice, got '%s'",
+			    argv[3]);
+
+		slice = strtol(argv[2], NULL, 10);
+		if (1 > slice || slice > slices_total)
+			die("slice must be in the range 1 <= slice <= %ld, got '%s'",
+			    slices_total, argv[2]);
+
 		for (i = 4; i < argc; i++)
 			if (stat(argv[i], &st))
 				res = error_errno("Cannot stat '%s'", argv[i]);
@@ -492,7 +498,7 @@ int cmd__path_utils(int argc, const char **argv)
 				string_list_append(&list, argv[i])->util =
 					(void *)(intptr_t)st.st_size;
 		QSORT(list.items, list.nr, cmp_by_st_size);
-		for (i = offset; i < list.nr; i+= stride)
+		for (i = slice - 1; i < list.nr; i+= slices_total)
 			printf("%s\n", list.items[i].string);
 
 		return !!res;

-- 
2.53.0.414.gf7e9f6c205.dirty

