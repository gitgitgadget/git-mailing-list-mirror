Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB222D9ECC
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834776; cv=none; b=fXwVGslZtWfHSxbz44HtsAKQSHXL+GRDRtI5aL4k+Eo/DWUdiM8/5K198m7Z7LmJz5iwl7rTj/bCM6TjGsyNYCSGK909w4g2vGKho+6Ub6U7WkiykxoUwExV1Di9fXqr0q2HZp7xXQsT5SHYBCkQzyTNuLdD2T9a/TOKMLOVkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834776; c=relaxed/simple;
	bh=QCqb0gqX76K3BXl5Gxl1GLVJofSiddNSEhEsXdVGKLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7a3UfAjzlgIM0+qW4gQbj2yNAo6l4lZAB5ksPF+s3CZbbianXTKQZdxOyFDqD5NtlBf2/Eyvvio1lUYePuttKexjLpLkxPfGAB1HM3t6ELrVtcbU8xvi2dHDzV3OoBgCrTF/NeAS1iq7HYahfgqrxIWVXezqiwSD7LTQ0Lsu3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SgAJiY/1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFxUTft0; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SgAJiY/1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFxUTft0"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E9E01D00039
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:59:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Oct 2025 06:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759834773;
	 x=1759921173; bh=1kKBO1K/Uhhsbjd63ytBMHKP9zWLNkCLKr1DvGh+83A=; b=
	SgAJiY/15hze7CsZuyMJobWrrTXQCX5hfzlRTvxUFt6lXpMP+OASpQimkJMA+J+E
	vDCjDDJrr3da3QMNQtXbNqvclKHPLqOCq0HyBb2S9HmgHdKJi88Dyeucg/5IJwMl
	OVyBqIFc+vn6fkfrYskY/QZXQPpcB7rfBXaCvup6EskGvG1g1XuP400c51sKXcMA
	Ng6jgpugARV1mEgx/8UUBjes3lHzk5uvtQo6JkiKcDJBhonaspWULs1CjQXwbWGt
	N8HINwkHjNEp8Ch7mDTkEygZbXK7eID7pjjs0dNqIjCKnI7DpnGDxISVmwh76x44
	Pbl8FaHbn2lWAtEdN2CzLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759834773; x=
	1759921173; bh=1kKBO1K/Uhhsbjd63ytBMHKP9zWLNkCLKr1DvGh+83A=; b=A
	FxUTft0eTOaiEY+Ertty8cAnPkRxkftEcYHpFvN3KvVLJ3ylZndq/suU3J6GKFOc
	OoQ713aAXN7p8KKRnVeMJMNuBmtKOrDPRW+pI3KrzfHZFg/7UIzSgrxeF6MeBEqW
	Lez28jntflzb7iuciiaYBeM79MTtcytsrHJOhnoBNCV5KLWQ7vBIzNDOI7eMkqHw
	5zP4MeD2G6DPHjnbTUDBE92mjPAfzwGeqWeq/PIRNi53QXkWQf8dsbxOFiG5mxLd
	x8UK7eDicRLhpx49Ue+/rQwcmwqk8ZPdwQfNuvlN5oMkx+ri2ljzTTPHaOi/2BnJ
	WGkeWaPBVCUPz5VbQuUKw==
X-ME-Sender: <xms:lfLkaNPYB9a3ReMJFINyxkQlRRXWBk1zHdXB_RgrNVw2ighDB6cppg>
    <xme:lfLkaG74SLHy3QSQYxBBindQs7NXtYzy6V2qX40c23KN7bR7bQpNIZANtmRB-SKED
    Zgf-4U3xUfvofjW6zjjU-spsc2dBPb7P9LatMghiFBz7wC8cQdeFQ>
X-ME-Received: <xmr:lfLkaB4Gz_BQpPyuGf7BwZxvHxgtRjw3SkDm267zeQlRcwOoaGKqjah_o-VELxNerpL3smLDAIs3DU-vG41jcl6c5DUfgVBSKTMq_chcGOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:lfLkaO0PwpefKCD4phampOjUKUOdFlvSdswqz-m3B6_-WTsBm1TtGg>
    <xmx:lfLkaFWrkM17a3NUn9CNjG6wBp028EgIEIssxGPkBu-Rt2LIAhld9w>
    <xmx:lfLkaB4-jupAVj-HY4TjifVxOJrGsPpP247sTaUB9BWjE5RoqoYxeQ>
    <xmx:lfLkaEJwBgGW4BBfk4DBGBSSbQsidIMMs_eKmQa0Vc-gMlZu-d4PBw>
    <xmx:lfLkaJ80voUTuSG2pE2EJtoiZWfAvtikykQk4Ovjj7dnkK5yDCKgb_4k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:59:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3230661 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:59:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 12:58:49 +0200
Subject: [PATCH 12/13] ref-filter: detect broken tags when dereferencing
 them
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-12-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: 
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

