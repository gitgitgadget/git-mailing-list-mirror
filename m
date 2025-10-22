Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5F02EFD8A
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115309; cv=none; b=BfjIiTJRPwajLvx7Vigxs15PKfHOn79quh7xs4SCYkRPmTosLaVlvfVieNnxDR9Q3hd5kfox+PWd61ZoQmSjUnYMX0c+F/Q2+7S57gNS/gJTc97zmkOKJ21nVmhqW/69i4LPdy/fw9S5MUb9qL9e+qUbsftIiuDZVuaaoZvTL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115309; c=relaxed/simple;
	bh=HRUR8RRFI7bccCzNXnxRQaPcx6ueGtzEaBVxBC84onQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lP8F2AFiN6IF7btCKl/LDUOyjLhQe3ll4B+qSR/QdewY7kssgS8hdYrRN4X+PP11+VXZ9mhPaVRp6zFn25Znw2fumuiKasYz1tQucSoMStTc9XnpI2fRM2/V6JZrm+uy3cj+nIIB+LIS7dT0kLdxHXqOJmxrnG/Qe2yB613ju9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hxEC0Xcq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bf3UcboY; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hxEC0Xcq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bf3UcboY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 721C77A008E;
	Wed, 22 Oct 2025 02:41:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Oct 2025 02:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115306;
	 x=1761201706; bh=s/W4JTlicYzZ+sCA9VR+/wT0qh3ysOkozzuvJ/WvNJQ=; b=
	hxEC0XcqQDNdM1deV+4PbtgyblRU9lEay8X+m5wAvsqBEgI9DO3gGq4JDcZyfPtz
	5B8bPLAWPT9WVdv2p+B4SUrCTsd97cEQEI83JIxcock5RfTc1vlLX0YD7xQ9Czgu
	cnxMTbS1RkLWTokdzF83tQT05776GgdjVYH9dkdmy9OMI/oQ7RprEjpvbxyeKP7P
	8G7LpSSh9T9Y9G6KQYzHe81SHMcveMJFquAfKSZWpC7oVXCyJ5cBLsR5Rnpc2wYq
	f/PnxoE8SgmdB7EgXeTF0WB6e8FQg6VZ9axZHSz37flPnkxbnxS69yccqvqkb6ZP
	277Kno6tfQpsWZ/aa6beWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115306; x=
	1761201706; bh=s/W4JTlicYzZ+sCA9VR+/wT0qh3ysOkozzuvJ/WvNJQ=; b=B
	f3UcboYMgCuZglPYWHlOmjBlQbotdiSxvZSY/qf8/r1VgqsgD9lrM/LBjPcAm7Uf
	NssQ2d111DozsC7rXTFv9/D5KZcIFRpvMIWvl4mzDFNmjPY0UOEbtEiTrG1Aut0x
	IVHS+H1dM93RDgXqGZ9m6sa5wZsItUmOm6WX9bYnsktpdXkXSUPWzKgPcjX0gB+0
	L8gTQYB/+5frrhdQrCmpM7E9IILZbqRStj3uhd30aniPewkYES3eTCfZbZ8wq34U
	1ug0Sl7Ii1T0Wk/5LCAQAR7yjv68h41aGMkmje1cSnjK8J7HqizLlp6oSkK92dUr
	02u1psyfKTvl99Ok7Ds/g==
X-ME-Sender: <xms:qnz4aDoIljf7tbJ1U_1odCo0RnIVf9v1Qfn_FVGJVDrUQAuc1XDaeQ>
    <xme:qnz4aBXeLk_pOE1Sc4QoW2TFHjT4tP8zLdIs9iBfTd0FgSkBrgGnp4D0r8k_pH8TP
    EFEwxMZ5iPTP_eL3vpUrjzhxGy0ZUnMl9UMA02nf8fiMGJrakvLFw>
X-ME-Received: <xmr:qnz4aKDHmgzNN-2zpk8rAjkxlId3XVFF5HMYmA21Rhg-jFXTbhQj9QLhhZzWYA3CAHJ3eIxLy-cZgdXb8RSRqAHD_pfrouer9207Y-SxEKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:qnz4aN0urhjRGtoRFw4kM670QF3WnIVpN2uy9ehh_ppBz7OhPt7tUw>
    <xmx:qnz4aE1RdkDlU2DnqqVmfGuunv4f-TFDNi9_RAOpWaYsccV8-wn5GQ>
    <xmx:qnz4aKDqlweZi5X0lpKzP532j6Um8HJrpsmDH6_47-Al2KSOjoIf7g>
    <xmx:qnz4aL4cA9JxArVUG_h_j4Rmo0k0uP2-9WFmenViw5R9grjQ-3uvsA>
    <xmx:qnz4aMnLw62q4_9H62PWdvYN2NxrXhmtCT5Nkl50RhzRgCvzaaPScaGY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db552a4c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:13 +0200
Subject: [PATCH v3 13/14] ref-filter: detect broken tags when dereferencing
 them
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-13-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
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
index 9a8ed8c8fc1..c54025d6b4c 100644
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
index e3ad19298ac..4593be5fd54 100644
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
2.51.1.851.g4ebd6896fd.dirty

