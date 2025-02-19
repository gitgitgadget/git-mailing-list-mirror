Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE7E1E102E
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971428; cv=none; b=R89B/q3D02XGzj4gXb/qPjAPxAQvk1U6v1wJQLk6JZs6VMnqinJ85agU7Y8pv3/f5UCdxELPTp4RvlUamErniKElWY9tKEteFsHsNDUvE7C1KtQ/iJp3J+w5VmVmRqPsPgQ/iOd/Phk1HVZgWEbgh01UA1YRbd/Ym4Mwwjt06u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971428; c=relaxed/simple;
	bh=0zHcZOxDb0Kb/F5yBUHz9NgAYrwJG5JWT9P62FZIbZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V99EJcFCsS1QOxGSqnzoSnxJxJmQQm60Hs/rHlfNy0OC746jcKUTngCnHm/6IPO/nt2M1QOPvH8Sik31+jIB9/ritMpsJxlpahs9qvpgKQ6fOPBwVKRgzwYW3wSSY3ziUb/nG3N1+aXisUblnvDZvkuIPzotbrczsIBMIngIT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ceHygWZf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wuIq3E1b; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ceHygWZf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wuIq3E1b"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AE73D114014F;
	Wed, 19 Feb 2025 08:23:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 19 Feb 2025 08:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971425;
	 x=1740057825; bh=F1CNDRJSF1Zu32KpuOClz6Hlv2XNcnlaoeYzhIGELbg=; b=
	ceHygWZfcyfnNv6xBSyRYtHwq+dVfUDsRv5p0rEjZ7aMgElO7f6OorvtWtsIaH43
	tgxliykaieTl3XAHpuPpQv/CqUBVgmUp6SM0VsgoYXfHUy+7t37H/DWGrq4bleD1
	Avx0AYtvp1DiuL2nDdFk8+FCBDuxWtOw4oXzUWgqjzjZrExqYgU5Ihjgoo/9b83v
	7vCefhULQRNwN0Euvq/8ytb6ZTjADmqsOnunSw0DrpTlnl27x5oG2NXZ206R8c9Q
	GkAWJ5sZTp5ojK7B4LpA+MZs5+MVWC2pYPA7ErNsOYCHCH50XsL068NwbLc8Bjqa
	3kMeALssj9oxoQirx1li1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971425; x=
	1740057825; bh=F1CNDRJSF1Zu32KpuOClz6Hlv2XNcnlaoeYzhIGELbg=; b=w
	uIq3E1bQUcaYeA2VkJKoQr5ep5FfTx5EZIIgJLQk7pqUijeuCSia3zhG34mPXGi3
	B+whfyLD3MIT79quIAYvpqo0vyFd9oiwElJ7Ti9yV2dLW6WtJKDFO5j0VmzBwwLm
	qyqYlSiGdIkrQAr3m3pvTS6Ia+cmIhqKCoyyt+bCIcUHFvftYLFBsPmhWZ57NiGt
	Rir6ysnI1G+apVH+ktKMswhCEEMoEeK/ccFl+UiiWkRG52W626FDmAHn0CJfwl5z
	dNW7mvYyEATvGmELg8n7PeOj8FodRMvXJGgonxRxLiOdox9GG0LoFiaUYqxy25Gq
	yEJbhkbvuzd5ijryTU/9A==
X-ME-Sender: <xms:Ydu1ZwSp4eDOknUAXGlpS4pKWYPVIQZnSxBRZj_NZMxvfMQZTfCI7Q>
    <xme:Ydu1Z9yqlA3vpG20L4MWZK9Zj2JEPl-lEqQzjSK9WK8kNVAkbA_n2XS_a8fk_yJrg
    U17ErwX79EOXke_SQ>
X-ME-Received: <xmr:Ydu1Z92__ptjZou9pVS2g1_xpAxQeYqhBtXdw6hQ2GfPWdbkhPLVSOcjWuJ_eGYfLnKME_Uu8Rbdj5KQHJ7Eijrhp35PA8QpD8xX1SzCSoC_C0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ydu1Z0CrdxZS0BB5_uMYtn-HielHeoLLA9JQKqk4suFeMTEtpQTvUQ>
    <xmx:Ydu1Z5guE7B1jc59nOVjuSR3DjDrWclkwu_4m8YEHfvGuSOki8oR-Q>
    <xmx:Ydu1ZwoDDnkODVyBS8X7QEC8J6tdKiGZzMLtdD2HZKBe2eZvRkIOLg>
    <xmx:Ydu1Z8jYhw3OD9r6yYHzA8RsGsaL9z5WbW7W1T2i85899fsZ1JMiwg>
    <xmx:Ydu1Z6VZAaEB_jynCaatmmTP2G3hBm1e5dXv2ipn6w4Qf9nEnAt2NFhw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78130c2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:34 +0100
Subject: [PATCH v2 07/16] refs/files: batch refname availability checks for
 initial transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-7-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The "files" backend explicitly carves out special logic for its initial
transaction so that it can avoid writing out every single reference as
a loose reference. While the assumption is that there shouldn't be any
preexisting references, we still have to verify that none of the newly
written references will conflict with any other new reference in the
same transaction.

Refactor the initial transaction to use batched refname availability
checks. This does not yet have an effect on performance as we still call
`refs_verify_refname_available()` in a loop. But this will change in
subsequent commits and then impact performance when cloning a repository
with many references or when migrating references to the "files" format.

This doesn't yet have an effect on performance as the underlying
logic simply calls This will improve performance when cloning a repository with
many references or when migrating references from any format to the
"files" format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6ce79cf0791..11a620ea11a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3056,6 +3056,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	struct ref_transaction *packed_transaction = NULL;
 	struct ref_transaction *loose_transaction = NULL;
 
@@ -3105,11 +3106,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		    !is_null_oid(&update->old_oid))
 			BUG("initial ref transaction with old_sha1 set");
 
-		if (refs_verify_refname_available(&refs->base, update->refname,
-						  &affected_refnames, NULL, 1, err)) {
-			ret = TRANSACTION_NAME_CONFLICT;
-			goto cleanup;
-		}
+		string_list_append(&refnames_to_check, update->refname);
 
 		/*
 		 * packed-refs don't support symbolic refs, root refs and reflogs,
@@ -3145,8 +3142,19 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		}
 	}
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, err) ||
-	    ref_transaction_commit(packed_transaction, err)) {
+	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
+	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
+					   &affected_refnames, NULL, 1, err)) {
+		packed_refs_unlock(refs->packed_ref_store);
+		ret = TRANSACTION_NAME_CONFLICT;
+		goto cleanup;
+	}
+
+	if (ref_transaction_commit(packed_transaction, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
@@ -3167,6 +3175,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		ref_transaction_free(packed_transaction);
 	transaction->state = REF_TRANSACTION_CLOSED;
 	string_list_clear(&affected_refnames, 0);
+	string_list_clear(&refnames_to_check, 0);
 	return ret;
 }
 

-- 
2.48.1.683.gf705b3209c.dirty

