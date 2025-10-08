Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD72FB968
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938669; cv=none; b=PV5qDfd8rKtS8YV2U1EG3TeiFajCNhhexKBoj0by3cLDojckn1+O+im613klKno6CwZ9NAYmeO2C1xz/iQkKbrkNtgWDBDVO1C92b7FYkfIdYGTms9cp2MsurmZpWpT7rRVqjbmJcbxN8uGryOMHESJM/rDo6c/MkWRiIjL1S6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938669; c=relaxed/simple;
	bh=QCqb0gqX76K3BXl5Gxl1GLVJofSiddNSEhEsXdVGKLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAIyxSMbRpnHIEttk2YmHFSVeGcc55o2jRqNdJ0i50L/Fz4gAngbWcHlosc2yAnfLubOa29rIEf7Xm5xWOZA1c0PXy3UvxJX6YW4itOW8TxEOKaME7iNgJAP38wvvZfAgcHEfNR4lTGCF5AqUcv1jlC6ECbmpKX5Dco22JNEs2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TRdYnjp3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlJFfCGf; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TRdYnjp3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlJFfCGf"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DF5381D00563;
	Wed,  8 Oct 2025 11:51:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 08 Oct 2025 11:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938664;
	 x=1760025064; bh=1kKBO1K/Uhhsbjd63ytBMHKP9zWLNkCLKr1DvGh+83A=; b=
	TRdYnjp3PID3MjhHUAqVzy3NBabZNfcR4lriEqQtma0iDtzeQmSu+LhURZNv2AM0
	ELnNwrik1wjHPDM+6u0MIRiLiF7t0N2N6cq2Ei4HTjgavLyxlGqTfsuxTpBuxFEn
	22OraMY9qZJKfPSQBg8mmM3t+JZzG7JhzrEXyzrtucNORDT0/M/YORbHrOKsh/Na
	oT/YAHapehIfz6cTTwleIOSXVAzkV2fRHNrb3NoV/NGzirlMeXGcPHUnyBIF5flY
	tu/nnSYPaB5CrcTzXQPMBZPc1Sp/r8CcwJDg0QKKLxJccEGpqm/RfsHKg55pEL7M
	nxuApPW6zCwktdJ2f6bh7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938664; x=
	1760025064; bh=1kKBO1K/Uhhsbjd63ytBMHKP9zWLNkCLKr1DvGh+83A=; b=T
	lJFfCGfWRGoC9nJHpWx/X6GZUH8+IIae6434mXY7fMYHhq36p6hgs4oSOssRBIvs
	iy4R/+e6S6S0keBdaHzLYkbZlquEwG04M/XPcIrD+0UXkOdtXiSz8xx4VlB62n/1
	Kfh3x6wfhGCEG+ET7MzkGZEq3KtikrgrrHLOQGAb5JTILytcrC94iVpd38YXV364
	yTGbE5c34u4qKtalrZF3i4POVzjMor2LfF1/m/CfTApNAoyEm7zGznOkqtD89XM8
	aYdCX5D7AVzzDGz8sYhQ10ZeZx9zEO0aSDAD9MlZUKYsbSVWOu8Y5yC+GDfpFnWu
	YMTvl7+zUFmUw9hCjPd3A==
X-ME-Sender: <xms:aIjmaPY2ZElkg8vrhcjywFMOQZNACUdxtiXf4Eq9sAYQQrUQ4bAO3g>
    <xme:aIjmaCGsRT_NO8oJ62POjUH8acnunb243xFzYXz0zVXj08ceOt0t_TLN_BuA5UzzW
    cUFsF2OYk6w6dLsSnQQCzHinFfjKgk67n8vDEBKFPM7QC1G5qEM-do>
X-ME-Received: <xmr:aIjmaLxKfx5J_3EQkJ-x5vOstpvZ8crRz97E1gs6OkRERfKt9ryUE4tOr8zR3qa8gED6H5LtJXnPTo_JutXTCNmDVRwbl975npQ0SALM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aIjmaMkplSpOfq5ryMLOpvJKBBTNHG9wEbBZjg4MTaHzuwI7lXjHNA>
    <xmx:aIjmaMkvz17z8TNYlPaYJA8NXbTfECzy5d5LRVABqa7pAcjC5PYjzw>
    <xmx:aIjmaGwNom3_JCqJPR_xrw-sG0vlsJF69C3c6oqix6xMtCqJbjx28A>
    <xmx:aIjmaJo1p1vnczl-BLBp4mIQpLshNPczTGuURpaC2yhXDiQZmQS4iA>
    <xmx:aIjmaMV-Hbs4zK546bczuTUkyOBlUEWnO09I2znXDsPBEDFpJyZHB5vq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:51:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8fd7b002 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:51:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:28 +0200
Subject: [PATCH v2 13/14] ref-filter: detect broken tags when dereferencing
 them
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-13-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Users can ask git-for-each-ref(1) to peel tags and return information of
the tagged object by adding an asterisk to the format, like for example
"%(*$objectname)". If so, git-for-each-ref(1) peels that object to the
first non-tag object and then returns its values.

As mentioned in preceding commits, it can happen that the tagged object
type and the claimed object type differ, effectively resulting in a
corrupt tag. git-for-each-ref(1) would notice this mismatch, print an
error and then bail out when trying to peel the tag.

But we only notice this corruption in some very specific edge cases!
While we have a test in "t/for-each-ref-tests.sh" that verifies the
above scenario, this test is specifically crafted to detect the issue at
hand. Namely, we create two tags:

  - One tag points to a specific object with the correct type.

  - The other tag points to the *same* object with a different type.

The fact that both tags point to the same object is important here:
`peel_object()` wouldn't notice the corruption if the tagged objects
were different.

The root cause is that `peel_object()` calls `lookup_${type}()`
eventually, where the type is the same type declared in the tag object.
Consequently, when we have two tags pointing to the same object but with
different declared types we'll call two different lookup functions. The
first lookup will store the object with an unverified type A, whereas
the second lookup will try to look up the object with a different
unverified type B. And it is only now that we notice the discrepancy in
object types, even though type A could've already been the wrong type.

Fix the issue by verifying the object type in `populate_value()`. With
this change we'll also notice type mismatches when only dereferencing a
tag once.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ref-filter.c            | 3 ++-
 t/for-each-ref-tests.sh | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 72e5a221ff..72cf85c8c6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2581,7 +2581,8 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	if (need_tagged) {
 		if (!is_null_oid(&ref->peeled_oid)) {
 			oidcpy(&oi_deref.oid, &ref->peeled_oid);
-		} else if (!peel_object(the_repository, &oi.oid, &oi_deref.oid, 0)) {
+		} else if (!peel_object(the_repository, &oi.oid, &oi_deref.oid,
+					PEEL_OBJECT_VERIFY_OBJECT_TYPE)) {
 			/* We managed to peel the object ourselves. */
 		} else {
 			die("bad tag");
diff --git a/t/for-each-ref-tests.sh b/t/for-each-ref-tests.sh
index e3ad19298a..4593be5fd5 100644
--- a/t/for-each-ref-tests.sh
+++ b/t/for-each-ref-tests.sh
@@ -1809,7 +1809,9 @@ test_expect_success "${git_for_each_ref} reports broken tags" '
 	bad=$(git hash-object -w -t tag bad) &&
 	git update-ref refs/tags/broken-tag-bad $bad &&
 	test_must_fail ${git_for_each_ref} --format="%(*objectname)" \
-		refs/tags/broken-tag-*
+		refs/tags/broken-tag-* &&
+	test_must_fail ${git_for_each_ref} --format="%(*objectname)" \
+		refs/tags/broken-tag-bad
 '
 
 test_expect_success 'set up tag with signature and no blank lines' '

-- 
2.51.0.764.g787ff6f08a.dirty

