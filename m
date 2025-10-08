Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03E2FB628
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938665; cv=none; b=Rp/bhIFY6r6SmZAUy80lR+unYm0aXKaoyLFaFNOoXiTWK0ukenfpKsLet7pFMz2Ku5uf53kaUsV+kuAERfuLLi70KyOkX/rRds48KwObm3JRio4qVtF7PsPg0aQxWrXsogSwyJJPzM7FTgOnZAf25vB3PntKaT01BcTSg+u4bC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938665; c=relaxed/simple;
	bh=kK7hgemELcYWBEMkocpi3lqLVEZL2ppD4WO/3wmN10s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eoCNPwVGhJ++gChUCY3qyUomc+uqP/Vr1uOmbEXnueqKOGFq05uN2D72MM+JrCBDLgHVuiR0n+IGqx4jsbOGt6JGHPIInCUw0t9ixM+5DCvR4LwtvJ6BN0KTMlmbHdZu7u/buANILpu3n9AOwaR5aluuasxEnIWXUP2EhD9GNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oXm0JOgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Km4GSzzC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oXm0JOgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Km4GSzzC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F8541D0039E;
	Wed,  8 Oct 2025 11:51:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Oct 2025 11:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938662;
	 x=1760025062; bh=VaTB+KO302LVvBcip2uycRtOnWeVwqkDlm+Vs2O5FHo=; b=
	oXm0JOgTLY2oSGnSdjuQd0YS7eczr43iFXRWw2Z1UkpUxvC+fsiHEj/mGzyA+pJs
	f3ZRhWq4M8WRv/QhsAqlTrybudAk4UqfV/eicstlSXnnVbH9SHPdJ2Othc4NgvGX
	0RGEeVWICrEUTIPZSlMv9NsiOCrarjc1NGqsvqYJb20OIevvRXxJNZ5FAWn3pN9j
	GnpWCE+3lMUCyIAoW/mIJXbTkEPW3OTa16dvgKWDVvHMVMKyLdBwMzFYhBV617O0
	ut7nnzvkjTYIuIW8xOMO38VjAdKOp/IeaEQG2E1AH2XiVdxyFrpF0/+I5R9ba+py
	JZkpS9UlU8zcSs7BYPA1kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938662; x=
	1760025062; bh=VaTB+KO302LVvBcip2uycRtOnWeVwqkDlm+Vs2O5FHo=; b=K
	m4GSzzCjXy3ki1k80snHa/6NoX0CF+lzltvnbISSYqxsNOSO0RW7dOjntZyOTuvC
	ZHp9b8CZl/6CwyKyoq/isXlhCoqM6bu6d4ecYuy0zrhnHRwT81YMhZfHYO2PRCJP
	AAhiSvO5tx9UR9rkxnJVDT1fOe5t9t2mWT1yfCYle1QLimqhafyVqYbzNZSgw3/l
	k4cegwtUMYFm1x08ypRefRUnm10UkoN5vjjfzQNYB3NQK//cVe0KO6rLp3N1CGCs
	tH00Faf+Kwh6aR2SO8LB8ztQP3S9NmrHmKVlVi5uVQ/nwtx57jkepnwwPrbtxnnT
	2reXrDPdRpSl/9GD5EaEQ==
X-ME-Sender: <xms:ZYjmaC5lZNNohSb-xXTcCiYt2KHoHO5p0Hw1MOK4NvPAtgdPK5jEHw>
    <xme:ZYjmaPmpf1Y4P2sSJpDriEWHu94OSUHp1MvYPWkf4w9rcM_EeAr-ChY5ZvdgiUcl2
    zo42o7gS7q5YMJZ5RHi4q4d2-u2FlkK8PzX9TJmr4mbAP9k6wItIS4>
X-ME-Received: <xmr:ZYjmaLRvYG-OPs8DsvZU-7WlI0K5sSbl-bJBua1ZjmykcI69lkdlNUQirsp6sJ2R8SaOF9loXjJx8Ovjd2WR6LB3XP0URLrlvhxxNW15>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeljeekveekkeeljeegleduheekkeetfeefudfgkeffhfelueduteeileejgfen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZYjmaGG3SAZymY3wXIFu2wJUxnlhkRMvvde9oqS9_qYhvzagJqfYwA>
    <xmx:ZYjmaIEJmZMLHtqQ3LApBUOk2XXFt01RBu-3XwKdwIg0cK2Liuk-OQ>
    <xmx:ZYjmaMQQz4YBuqQa4TqPK32u0BiL2wzAeojSkmA5cLgHE9WLAMrfSA>
    <xmx:ZYjmaBKy8umKmRKXwOl2En52mcN_yVC6k0tKNsRk7TMZXoWe9C-ovQ>
    <xmx:ZojmaH2pEvplrQGVONp_KNfD_NK-aDXed4puMmp8Zd3Qe6BQuuwNQW7G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:51:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca19b476 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:50:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:27 +0200
Subject: [PATCH v2 12/14] refs: don't store peeled object IDs for invalid
 tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-12-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
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
index 4752d3f398..1ab0c50393 100644
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
index 32ee2ce22a..0b7ec3ae15 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1631,7 +1631,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
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

