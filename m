Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557602D94B8
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834773; cv=none; b=Z/4RbVNH+2PY+7qMkHa5x3oraUbHJuxf7tSdefx/qsUQm59ZWqSwmw7LRhrsXA8AIA+1/GDuZHAd1wyYbErwuHcl70QrEW17IByj+MTnFYqReJXQTZJ7FsYAKH6HcgHtjC2ejo01+Sms8YNpkz8GGTZpj6YPXDYNoweCaXbdc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834773; c=relaxed/simple;
	bh=2Ws1posGWEa4SILsTBlZ6Th95cAfYVy0jNHe/p5liPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAbFVXg59IRcXETp+bROr4oC2fCo4d++/GkRX50hWvsgd+EN53jYafk00XN7EbQoKDV9UAIHYsXPcp1bxSfvSa94/RoKp28FsYEYT8okrnELRXWawymAP7y4qyRGhK8c5Pc5RCreHouvK4ME6Fb+ppwiIb3NjDXWOwhnSLWE+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gps7wZSD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w2j1dm5d; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gps7wZSD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w2j1dm5d"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A5981D00039
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:59:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 06:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759834770;
	 x=1759921170; bh=ltN/U0sA6mVdAgnRfTlV0mu9s1y3fP0C3T/OeE7lA8I=; b=
	gps7wZSD1E/M7AFuV+fi6i+OhFRd6krchKE67XQdSOydnuEfaNmep1GOX+hGrgUe
	GMf1tBeQAJ2r+0ZBgLqNqsR/edriSbP9DgBUehwH6AsEAivo0AZvZBTJJFjZEbGI
	yVg71yTrejB6Xdr5EFiw+dz5ZXrgFr6LVbBKKpM8ZxKKWdEF14E5K6sFJX6nMcOf
	FiphPgCWbt03WL0o+AabzZy4AW4cFdwlyyks9ZNm4VwH3+ZpBRgm0VPnNZyJDbva
	TjMPMtiTqKTMzTLM42UXsU/nZSge1Zsp0SvIPci3Rcjt2p2iURp19gNY57ZdyHvz
	eAk7+T7s1Q2Sd49cJvgtWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759834770; x=
	1759921170; bh=ltN/U0sA6mVdAgnRfTlV0mu9s1y3fP0C3T/OeE7lA8I=; b=w
	2j1dm5dshvMA2xB5zAp4cKxdGkUgJSOw3AVTt/0o5ODsq1GhSF6MAHo27XxBi5v9
	uJgqu71PBUaE0F2GMFB9edljiVCymtyZV+9+Acg07n6vUcLlebniJ0xX9n2i5fMC
	QgnFy41dA+VNqj8L9pOM4lbX11JZ3FY2hIiYm7K/xG9MOwtyo4IWVHHts9rN+Hug
	1mBOP6oGrmA3/0UufZ4XzO67FOFejG0mI35L/V29W3L7Y3V0FtS+Bwi6m2FWPfKb
	mip4w7R0tf/rORhFfoN5BHAtvNcPhOiKh4XPhJs6kMBZo4eUZuQk/Nbdvgepwh5M
	Yw7AWoKDOjg1dzLYYelIA==
X-ME-Sender: <xms:kvLkaCWHblTltI7F_2D0a-seG2lo01OFJvPSmWhEur5y_0Ez35ExLQ>
    <xme:kvLkaFjdNpP3k4HWlP38-_5OjA4NPFR1NWg8K7VEhPU-LPcIMUHgjaT50Aghz2sho
    KvwQW6n3eNidN_4QgvfGyMJR-YwiqE4iq9gU-1AzRPaEWxvFjR7>
X-ME-Received: <xmr:kvLkaMC5e9KfQpJe4ksaLF6vsUW5i3pddIgPJh3vGL1IhSgIZZqJe3n8x9jYL867SYyuwCBVvLd_SQrCDzuSmZARW4ayx8utciVqEJ3M0j4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeffueeljeekveekkeeljeegleduheekkeetfeefudfgkeffhfelueduteei
    leejgfenucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kvLkaOcXBu0Sq92tdTqmOeNA9XIUuo1pArTWJ1RRR6oMgpgrALVlng>
    <xmx:kvLkaMesKmGd7FKN7fVD24UwvAtn2ufcSXRRQt--hsAcN0QXW4kGkQ>
    <xmx:kvLkaKhHhVHZ4HQebb4r7fll0vQDAfR8ngXI4b_AmataI0w4NHK4rA>
    <xmx:kvLkaAR8_0F0poCJ7E_Upn1qjQzuQ43mo1xLVb_wJOjUW3lG8nPLug>
    <xmx:kvLkaBkvXBHI_UNAMKcCv_Kzc4sqc8Vz3mxHW1hxWGfBqPXQT_p7L7Wy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:59:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7de5e2d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:59:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 12:58:48 +0200
Subject: [PATCH 11/13] refs: don't store peeled object IDs for invalid tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-11-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Both the "files" and "reftable" backend store peeled object IDs for
references that point to tags:

  - The "files" backend stores the value when packing refs, where each
    peeled object ID is prefixed with "^".

  - The "reftable" backend stores the value whenever writing a new
    reference that points to a tag via a special ref record type.

Both of these backends use `peel_object()` to find the peeled object ID.
But as explained in the preceding commit, that function does not detect
the case where the tag's tagged object and its claimed type mismatch.

The consequence of storing these bogus peeled object IDs is that we're
less likely to detect such corruption in other parts of Git.
git-for-each-ref(1) for example does not notice anymore that the tag is
broken when using "--format=%(*objectname)" to dereference tags.

One could claim that this is good, because it still allows us to mostly
use the tag as intended. But the biggest problem here is that we now
have different behaviour for such a broken tag depending on whether or
not we have its peeled value in the refdb.

Fix the issue by verifying the object type when peeling the object. If
that verification fails we simply skip storing the peeled value in
either of the reference formats.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c      |  2 +-
 refs/reftable-backend.c    |  3 ++-
 t/pack-refs-tests.sh       | 32 ++++++++++++++++++++++++++++++++
 t/t0610-reftable-basics.sh | 28 ++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6b8e5247a9..acf87a61b1 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1529,7 +1529,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 		} else {
 			struct object_id peeled;
 			int peel_error = peel_object(refs->base.repo, &update->new_oid,
-						     &peeled, 0);
+						     &peeled, PEEL_OBJECT_VERIFY_OBJECT_TYPE);
 
 			if (write_packed_entry(out, update->refname,
 					       &update->new_oid,
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index fff17f9ef4..5f4c903b3f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1632,7 +1632,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			ref.refname = (char *)u->refname;
 			ref.update_index = ts;
 
-			peel_error = peel_object(arg->refs->base.repo, &u->new_oid, &peeled, 0);
+			peel_error = peel_object(arg->refs->base.repo, &u->new_oid, &peeled,
+						 PEEL_OBJECT_VERIFY_OBJECT_TYPE);
 			if (!peel_error) {
 				ref.value_type = REFTABLE_REF_VAL2;
 				memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 3dbcc01718..095823d915 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -428,4 +428,36 @@ do
 	'
 done
 
+test_expect_success 'pack-refs does not store invalid peeled tag value' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty --message initial &&
+
+		echo garbage >blob-content &&
+		blob_id=$(git hash-object -w -t blob blob-content) &&
+
+		# Write an invalid tag into the object database. The tag itself
+		# is well-formed, but the tagged object is a blob while we
+		# claim that it is a commit.
+		cat >tag-content <<-EOF &&
+		object $blob_id
+		type commit
+		tag bad-tag
+		tagger C O Mitter <committer@example.com> 1112354055 +0200
+
+		annotated
+		EOF
+		tag_id=$(git hash-object -w -t tag tag-content) &&
+		git update-ref refs/tags/bad-tag "$tag_id" &&
+
+		# The packed-refs file should not contain the peeled object ID.
+		# If it did this would cause commands that use the peeled value
+		# to not notice this corrupted tag.
+		git pack-refs --all &&
+		test_grep ! "^\^" .git/packed-refs
+	)
+'
+
 test_done
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 3ea5d51532..6575528f21 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -1135,4 +1135,32 @@ test_expect_success 'fetch: accessing FETCH_HEAD special ref works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'writes do not persist peeled value for invalid tags' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty --message initial &&
+
+		# We cannot easily verify that the peeled value is not stored
+		# in the tables. Instead, we test this indirectly: we create
+		# two tags that both point to the same object, but they claim
+		# different object types. If we parse both tags we notice that
+		# the parsed tagged object has a mismatch between the two tags
+		# and bail out.
+		#
+		# If we instead use the persisted peeled value we would not
+		# even parse the tags. As such, we would not notice the
+		# discrepancy either and thus listing these tags would succeed.
+		git tag tag-1 -m "tag 1" &&
+		git cat-file tag tag-1 >raw-tag &&
+		sed "s/^type commit$/type blob/" <raw-tag >broken-tag &&
+		broken_tag_id=$(git hash-object -w -t tag broken-tag) &&
+		git update-ref refs/tags/tag-2 $broken_tag_id &&
+
+		test_must_fail git for-each-ref --format="%(*objectname)" refs/tags/ 2>err &&
+		test_grep "bad tag pointer" err
+	)
+'
+
 test_done

-- 
2.51.0.764.g787ff6f08a.dirty

