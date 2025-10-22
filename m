Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593122F12A0
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115306; cv=none; b=fUd8jgCmn9OBqU7SGWWo06+sedT/d35iUKs45wEzWdY5uadtp2ZCLx/Hvm7gb9knamNTaZBoLH4LRffrYpE9bZHhY9FF4gU7DwK/8KGlo7h42tbo68X0VdKZPf/pKgPr1e+SXEtbVnnj912uMHz5Aor6C5BGyAcYWuQonHLdBec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115306; c=relaxed/simple;
	bh=h9Pw7tPc521+m53HBDyTBMLUu/OYJslAN+urwuML1FM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2Ia1e/P9KPil0IUrYILL53EaoHzUVxBsL7CiCGbphAHAK161Qt3+zx8Dn/sLUKcEydsLWWaO2NoqlwtatLiv+wdXmB4B4LIHdhXJhNOhFmrVGphVSAU+Ig3twuBiv+A7xZ+CPHLc/VAjzttE+cmU7D+qCkfVrPK8e7dCUme598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GW0tj7dk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uklhkX44; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GW0tj7dk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uklhkX44"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92FB47A008E;
	Wed, 22 Oct 2025 02:41:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 02:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115303;
	 x=1761201703; bh=vRuIKgJSb7/0z6ciHE1Q0Q5q3u+pw1WIXWl/o46F6Qc=; b=
	GW0tj7dknMD1Zx9YqkkFcXGbQ6N+CvmKpvrg2ZezOooTNmEhE4ca1eCspLxU37XZ
	CJuRgrB31TDpqS0zPSTxLbZiQxOLvQ5kJoZIMXSBkiC84FiEq3b0W4axAFd8wcKE
	JBShCc1Wq97H7bNeQx9ezMsGCw/DVBTAXkJfMVZVX12FzBef+HpEWubD3nqTAFjT
	4zpjB5ghJz//Njs36CTv3nnRR9bZ2Ci9ZkUNtw1QDniTrU6gS5G/oe13rItGO/l9
	o7TQNtB2WI/uHDDkFN+x3ox9p+zxESyHvcZHzjM9V1BmJSAeafR+AYpVefd1vdzm
	iv/td9zgIMAWhojUW09cjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115303; x=
	1761201703; bh=vRuIKgJSb7/0z6ciHE1Q0Q5q3u+pw1WIXWl/o46F6Qc=; b=u
	klhkX44VVenWpPZwy5LZHlTvKuY9nt36VVe9EJ4CsCm78Q+d5lhY+ZRQUe0tJoL7
	1C3Gm1NKUhKomPFMfag53dHtU0E/sw3p3kxuz9ut+H88cocdazVxCUnSyzk5qmhe
	SxYA4YxFqOTxToyvhms0hyq+t6mfhxnTGsMUh3PfJFGDFqYdw492coDhOtcnrh8F
	/7u/PTFYQCKjGgBhZVlshxkHRQjjSYCCTwAlrQoks4YquG1fRFFMAYwk+1hSLMUS
	bqrouFPUerSIVMBRoqnbgqB4sEwDEiGuePxgWtezE4bUjbsky1KxRoKTqsgJ8ri5
	1PKQbyJDos+7ccnNl/QlA==
X-ME-Sender: <xms:p3z4aHYOjIDn19YHkUmJ7bA9K7GyiIJxYn9vN8V8dFtb31oMclV34Q>
    <xme:p3z4aKFt2TBvpo1IJpbc_ILOoMGhyBFqrLkmdFRD1tytPJ0ry4CarCQ5kaA_UVGH5
    AYCOEsMkx1KGiKm6vwyEgf11iVhpdcxssO7pmIJDpjBjSjb_qTusQ>
X-ME-Received: <xmr:p3z4aDyuQRwbW3fF28lmiCCa0ZKpvCqdhpfNit16UV_DluXIGT84Cfk4MM_IGagZiZSq8FYw3dRe6e4rx1o1JiblJ5-NUPbCVHSzk9tgcbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeljeekveekkeeljeegleduheekkeetfeefudfgkeffhfelueduteeileejgfen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:p3z4aEmHvpX1M-CObOLZkwpcEE7hmMkUPi4khpAdG__iRN-3UW5-CQ>
    <xmx:p3z4aEn_bFu0Nr0rsduU5bMPMP697LfGRbQYaJLVkVWVJiqMbEjR_g>
    <xmx:p3z4aOxmQA91en6gfw3QZr73yG5auGGIfs4VnTcxtXIXgTAv8XEVxw>
    <xmx:p3z4aBpRfPItJN2rfhZUrxI1vNNXZZuFPbnwrqsK2cg4aBCcb5Sveg>
    <xmx:p3z4aEXelVVWzUM_8cdlreTUlBB3AvXJByJ2Yz7Ahi7Ferrjqo5ZjGac>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d048fde (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:12 +0200
Subject: [PATCH v3 12/14] refs: don't store peeled object IDs for invalid
 tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-12-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
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
index 4752d3f3981..1ab0c503930 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1528,7 +1528,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 		} else {
 			struct object_id peeled;
 			int peel_error = peel_object(refs->base.repo, &update->new_oid,
-						     &peeled, 0);
+						     &peeled, PEEL_OBJECT_VERIFY_OBJECT_TYPE);
 
 			if (write_packed_entry(out, update->refname,
 					       &update->new_oid,
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9febb2322c3..6bbfd5618da 100644
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
index 3dbcc01718e..095823d915f 100644
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
index 3ea5d51532a..6575528f212 100755
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
2.51.1.851.g4ebd6896fd.dirty

