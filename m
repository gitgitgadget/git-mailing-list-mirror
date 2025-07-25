Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FC28A72F
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426723; cv=none; b=i5opcXVZVkR3tqohok02qHnhKz/eunFYGyM9BvaamBJZgmKxbhI87nKdamFfuIlVwg10OHthplrZK77mAfAiztD9CyEBWm6VWDYDR/LPYskzc6pmawpDjqftzcx20rGDwFOcbhu8VHz9eUpd/lU84stU7QZgXXbLD6wEF+bymP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426723; c=relaxed/simple;
	bh=dJfewAHQY3qoJVsMlpmT/Ma+LiPArcLVKOj8HAa/nsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/7PUz93bp2bMed9sIzI1wrUJ6idFpyUAa0hYFVBOoe2kgeaTDf71txbMHXO2/PUtLLbvCPJl1mYe9RkJm0U66pgEf+WAd+s+/oxkiGT9p2V67VqL3/OcGc0+BkNPau1Vg9gO7S9DwCd8OqWuEq18PyA2/IlBiHB05MhL5aVRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ounxyzrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJpg+nwu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ounxyzrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJpg+nwu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C5A9FEC03D3;
	Fri, 25 Jul 2025 02:58:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Jul 2025 02:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753426720;
	 x=1753513120; bh=Ru7NVnEI/VTAqzwY92rQejFsjgrISmWoJJvvsZoGyo8=; b=
	ounxyzrLONDgmbLO++xX6SYR0YJZSrY6zYEYeeZUEsKGE2Y+sdN+i3s68qNkHvmf
	wCchDRUGLy3Q6Wb3BLLnuLeTiz4C8EiaqzlyGNruw/uHHJRhwiQBF9BicBMXxLkk
	oF1+eI4HkDfcI6mWJOlUGl0DM0EuAJ/072vzcQmxd1Rpuqn/UsuwcaqNOYcrtwum
	YfECwWUnbapUe4KK5A20BuPqm7Sa6MJLkaAS6TI5EgXnkg48rO14AjTuC8nEQhIM
	EMNiMx5OupxAw2ZIoYtrjSreVqNGqMTo/88SkLMwipGanaIuEwo9jePup9+1LsMc
	SCU5rSIiooEeDc9gjqNMGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753426720; x=
	1753513120; bh=Ru7NVnEI/VTAqzwY92rQejFsjgrISmWoJJvvsZoGyo8=; b=W
	Jpg+nwuDX/F8X5k3JcoW9IlTuVs/8zO2OsRwXoLK69NBwN4apawKWwY22z6goaBM
	Y5Bkx9QLqkFYR54nBJtXQlKT4dK8qXRLI17WMMY98mWIM+w23ih4cKCw1xOkBR4E
	pRpGU1RMXLLSRiFLqO7clI72iCbs6n/I1LN4d4VshR9PeHhpXDxmdTzLDvy244Z3
	PzWtuS26m/thLjczkILUHp29hR5rirDd+hpIbc1VW3oImhaIVuLtGtWB9khu2WZ0
	GF/VL/NeAYjqxH1jRpeJBOsCzK/rpeE4Nar670hn4ng4ct3oo1CKdsatDXr99jsQ
	Dk0artDKpwRNu03Ji1r5g==
X-ME-Sender: <xms:ICuDaAKDW8im2O1pongdXArO3WI6Cr9_m3QHx5PszaxzpIIGAwFrng>
    <xme:ICuDaJcDcOwkV4O3rqRHILlGjFd9CZ_R7RsYfeI2CE2L6QovjYO-52Z40HrPwJItf
    0IodaEi46huHA8CLg>
X-ME-Received: <xmr:ICuDaH8AlfaVG6Ohg7o0e8v0FPDIDjz73TPxnFlRrk6KsgAY7C4kulL6Vvob0ZLLwj6bNxXhJvv8_-mzAtnED5SfUFgyUNRN5znm8YDa8pcm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ICuDaOpuJwL-Rc3JXueDrMsbcJULtYUzUzdB9aRN7vIrSoy_0qtQeQ>
    <xmx:ICuDaEDsMJJVY8xnlQpDXLeWnzYHnbYiz7bKmbFjs9bHDdLFpv3Jbg>
    <xmx:ICuDaIwb5HySbhXT8NDlg0wnyHwMMhmiJI4Ko_KnNjg_N8LGuqer4A>
    <xmx:ICuDaJ1eM9Z08xgQ9s13EfnhbgTOkfzGdyi5Zb77bMlAaWQJ3dKYIg>
    <xmx:ICuDaPA6HcTdkA1h3GSh6ZXCpLS6G8MjIGHSYHH85dw6kH_s-hwuS7V6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 02:58:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2f751f1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 06:58:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Jul 2025 08:58:25 +0200
Subject: [PATCH v2 3/8] refs: export `ref_transaction_update_reflog()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-pks-reflog-append-v2-3-e4e7cbe3f578@pks.im>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
In-Reply-To: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

In a subsequent commit we'll add another user that wants to write reflog
entries. This requires them to call `ref_transaction_update_reflog()`,
but that function is local to "refs.c".

Export the function to prepare for the change. While at it, drop the
`flags` field, as all callers are for now expected to use the same flags
anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 29 +++++++++++------------------
 refs.h | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index dce5c49ca2b..8aa9f7236a3 100644
--- a/refs.c
+++ b/refs.c
@@ -1371,27 +1371,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-/*
- * Similar to`ref_transaction_update`, but this function is only for adding
- * a reflog update. Supports providing custom committer information. The index
- * field can be utiltized to order updates as desired. When not used, the
- * updates default to being ordered by refname.
- */
-static int ref_transaction_update_reflog(struct ref_transaction *transaction,
-					 const char *refname,
-					 const struct object_id *new_oid,
-					 const struct object_id *old_oid,
-					 const char *committer_info,
-					 unsigned int flags,
-					 const char *msg,
-					 uint64_t index,
-					 struct strbuf *err)
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info,
+				  const char *msg,
+				  uint64_t index,
+				  struct strbuf *err)
 {
 	struct ref_update *update;
+	unsigned int flags;
 
 	assert(err);
 
-	flags |= REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
+	flags = REF_HAVE_OLD | REF_HAVE_NEW | REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
 		return -1;
@@ -3019,8 +3013,7 @@ static int migrate_one_reflog_entry(struct object_id *old_oid,
 
 	ret = ref_transaction_update_reflog(data->transaction, data->refname,
 					    new_oid, old_oid, data->sb->buf,
-					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
-					    data->index++, data->errbuf);
+					    msg, data->index++, data->errbuf);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 46a6008e07f..253dd8f4d5d 100644
--- a/refs.h
+++ b/refs.h
@@ -795,6 +795,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
+/*
+ * Similar to `ref_transaction_update`, but this function is only for adding
+ * a reflog update. Supports providing custom committer information. The index
+ * field can be utiltized to order updates as desired. When set to zero, the
+ * updates default to being ordered by refname.
+ */
+int ref_transaction_update_reflog(struct ref_transaction *transaction,
+				  const char *refname,
+				  const struct object_id *new_oid,
+				  const struct object_id *old_oid,
+				  const char *committer_info,
+				  const char *msg,
+				  uint64_t index,
+				  struct strbuf *err);
+
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be

-- 
2.50.1.565.gc32cd1483b.dirty

