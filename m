Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF42C21E5
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203821; cv=none; b=ElzxwAneFcAnejr4Tdlpu2ROgChKd0rNIe27SOZslLsOU7RhPGQZVkS5sFPCmjCRcbvxgEVgZmVLG30OhEmKjoBmdt/X/4w50YPb6vXO+6IZDFjgHLj9+NgW4l+TMASzYaR4ytOHRtKP/Uaa7E5lmh5Qs3oCQVJB6yVYgAHWUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203821; c=relaxed/simple;
	bh=8kBlfFvp4d8lCj9ajFMr/1TXqQobTZjE60I1izcmuEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nXQyaLRoztAAbZFNo6fGkyCGJ6Xbifl/NW52Xg/ioLREwBehurAB9d8ERK51NhoCzTBiPhYo2f+ab6TB/jp5XRtrN3l4ZnTfwBDg8wQTC6IObMbCjhy1Qa3s2f5m+h/6DsIPIO+nrMmreXLgz31+yHj7++EXlUyqql2w+NhSzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JWPZT2ED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qcMmhM8K; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JWPZT2ED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qcMmhM8K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5E8314001D0;
	Thu, 23 Oct 2025 03:16:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 03:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203818;
	 x=1761290218; bh=t6RqSH5Dh1O9IRJqokmJNAQ8iNyf0rsygl+K4HpEbto=; b=
	JWPZT2EDy2o1x6U1Y10DPfSrSleBBaCLh1Q29wfmO3PfDRB8AQr7H1dMD55wjq1t
	aA3hwkU0k+/DMETkEaSPUTLVkY+tssCU8qFBx+hB9a9E2bgzC45PoJIsJ4aRc+3G
	b5PrAc+Kp1VKEFO6GPECcclAVwHsT6LLUJ4jKyn6UQE6pZI/xajLRqqzMTIepoQ1
	fzRhQ/rghbbO/wFtfmSjHhD22rEVTL/+yBqQ9EkQsRyyaMzOqPn61utZzPVV4Lj6
	bP60HWkyHwmUxbEIrsuqWDsBNZhx+RjeO5wWLZJ6UZCGgOdfFCb4aDRTG7EiSwgL
	pbvlT138VMoRXx1ROVffSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203818; x=
	1761290218; bh=t6RqSH5Dh1O9IRJqokmJNAQ8iNyf0rsygl+K4HpEbto=; b=q
	cMmhM8KKEWrVG/Wj12GAtOOII5KXX8a9iJs+cceCbtZXM+aF2AJXwYYyZJbTUo/9
	Y4+EYi2vphqNmI3CkNqs9/OEK+nIQAYQ8cmSH8KlohPOSP2oX/BpsJapyQmzvopQ
	+OemCP3ODVLftyW077tNr19jN8O16jUQnY7AiUOmPQIBntN+2rM7EaIwEilaBxqq
	BnX1D91o0BtqwlyzXdlpkKz7qxNMTk1lBBdqarQgIBJLCGP8SE7HoXld+fI7TbZ4
	NprChKTmos0WFYu267IR+yyQfa3JCzkBZ5KmM/bnLgEgDMDZ8fzhgXROCPo5ugw4
	DRqhYqAjnTnwHjzo4SUYA==
X-ME-Sender: <xms:atb5aFZGYLS7NmFvljEfrhID0l_pT98gwvuBfhPo1yggK-4E7j-HWA>
    <xme:atb5aAF46K6Q1oTdTezjAQJzfa9Y3NR8asVmsvWIe0Cr0AhJj2-u-S8qZyfPpaLu5
    d-c7vZCGG18KcHNUjgvaW7g1JBTol4rUUFT8lymJt7HgXhYtuqgXw>
X-ME-Received: <xmr:atb5aBxZexz54UYCSLwGCDKjHJKqxFS_8wa_xD93X8SiEEWnb6EAvKoFLuSFa50gsOh_OCPTQAbjLaeONWQx5ko2BXCbs3MmkehHT-HzCNLM0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:atb5aKmIUUQ7iK34RT-ZX6eOTDG6G4YT-mZavj8ITL6E_vTKhLr0UQ>
    <xmx:atb5aCnVwEezdkxSojhHl9iS0ufPFQQAgnafdR2osoROEY3Nu_y5Xw>
    <xmx:atb5aEy3mWtN7K9XUJFUCw4bI6uDVeQ9pS2rfKtAZGsfg9ukjjiIzQ>
    <xmx:atb5aPrJOdvEmOsXuiFlfBQMzICw7IGjO24b_J4Y443w5ZJhTJ5G9g>
    <xmx:atb5aCUY4iR1mEsrj2hc4KSjdut6Ej8USe5g3pTy6LuwRiPCoBpCUByQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bcadb596 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:22 +0200
Subject: [PATCH v4 13/14] ref-filter: detect broken tags when dereferencing
 them
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-13-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
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
2.51.1.930.gacf6e81ea2.dirty

