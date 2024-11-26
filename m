Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814801885A5
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603395; cv=none; b=BNtOVD+a1GdinUuHrtCFwkD4c5pK51oQphMAs7A9vttBJ7FstLkqqjwruhR03dVfscTJWDX4QFAjgXalsskT0Eo5xZFZvTQjBkVfZRsteibC0HqgAg4zKeAgJ4y8tkc91SqBQgVJyrmP6amupOxvOtGBf8gsd7Q1gRJsiyKQbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603395; c=relaxed/simple;
	bh=RFo09bCeKwC1AMnDNbDWDRKTr8sVVUaA8jbeX9CH+IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIzqUmDPcnp1VXcRQLVZEwvn3wpgZWnlvbl6Rape3oDajI6IHVBT4tN/gyJqQfkLCNn6rNUzn5b2J1LZOtZlqdPrn5Wt+FJAnV8xBBgbd7WJprRE31Ca5lmq7gnsvlZr26EVFGc9vbthkAAK+AXLJ0a6VPgFw0kzEn1yHWPV4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rNZPklbq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uh2ayCXA; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rNZPklbq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uh2ayCXA"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0E9811401CA;
	Tue, 26 Nov 2024 01:43:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 26 Nov 2024 01:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603392;
	 x=1732689792; bh=jFhBmt/arKudzy7yUBrJ0sfTMcPZZePIlJUtd9irujI=; b=
	rNZPklbq130aZIfcLQBWda53VRNfmCjXJkWTRDuLkJjlKxE9n6ANVo7zK0nMRBdp
	Edd1s3lvC5QFtOhUVHENLp7a+kO2ATxOfkbBhoAaosdoceXV3zXfxZw/6FjCxYde
	KOkwlXYM4eXsZLmHY+y33RpVZ6g62FUpAh+MIBiHUWDaShJWuKUBJiyiwlUsuqMP
	PXqOkCvaALTPw2pvQHHLgXCBBSzCuOsR8WGDN6UPzj4tiLjqkjzDFnSu/db5cm9a
	WH0y6PgafJjUgqPkXPTkEfpep23PmdwBMxgzw5Vpg5QFo1sdwcJNHkZtwxFUE0DN
	THz691b2QOHa9mvExYlohg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603392; x=
	1732689792; bh=jFhBmt/arKudzy7yUBrJ0sfTMcPZZePIlJUtd9irujI=; b=U
	h2ayCXAtJY7ZBXlSSuu9PAZ4yCzTN7xEgP6Tu97YDzCU3HK3Dbd6y6fITIaq7KXf
	KRVJPV6FRuMmH+rwFANEjnTEvs+ndOuvDpRlV91cpPtArjbfTWohusloo4ODeDRo
	kKxeSCJRZDfne9ndWxWaliGPdpid6W9fjkwb3OtP07LDIrpy4ZHZdKqFK3BijVBS
	8AOZJgowZbBisjlRRkNdpcKnyR/dsGVrWtxbhyu531LjF+Xs6zsoWUUl2aNpzSqw
	+r+5L5FghIHVF1rgI5THHPggj46Ry2W+mjKzPiqjbz6ogQMTmDHm7wUzNWGb4guu
	Tx4Z9FMgc8Ios9uVDZu0g==
X-ME-Sender: <xms:AG5FZwLxwWcuJIdRfKhjE4zv0Wet8dEs8qmICYnb0Y-eFt25NPLarg>
    <xme:AG5FZwKG6Z1X94G-kNlcRJ3t0beCOvj69_4oMezKh0Ydg9SiwafB8DcQqZErT3jcQ
    XxdqRhBhBZmHPNWfQ>
X-ME-Received: <xmr:AG5FZwszDEgd3LkDdDpPgJkk-BQQBhREzZqridOslML8b38857IMZJPpD32Pvpi35dzy2__NCojs7WHBPFDAdhejOC1qtaASY8xAz_o3R7UnEo9B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfefieevffduhfejvdevfffhudekhfdvkeevveegueei
    teetveeglefghfevtdfgnecuffhomhgrihhnpehuphgurghtvgdrthiinecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AG5FZ9YJFYDqJjEVlB6wQ6kaygupivKWF3wqRf0wcLp6HUmuMaOK4g>
    <xmx:AG5FZ3Y4V1E8ZaSDXeLEhcuAf8ELnmVsF127THdPqHE0aQvEC7LoBw>
    <xmx:AG5FZ5Cqi-AJm7zs9AKp1H14Cn8DrrhhZ0ocGm7CzPLhPor2tQMzkw>
    <xmx:AG5FZ9aQEqa0lg72-B2jJ6bm4OastGHigjv_z10iMrM0Whz0CUDZVQ>
    <xmx:AG5FZzHSaK2NLCWK8-IHNy354mXBrD8UMVDqdGzL1a7oSJisI186cz_z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58ca4687 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:42:55 +0100
Subject: [PATCH v4 04/10] refs/reftable: figure out hash via
 `reftable_stack`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-4-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The function `read_ref_without_reload()` accepts a ref store as input
only so that we can figure out the hash function used by it. This is
duplicate information though because the reftable stack knows about its
hash function, too.

Drop the superfluous parameter to simplify the calling convention a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8be9cc43c990212b0b4f8d0b473f84270ff4787d..302de622d44ccbe8eceee0654f11ad7184791eba 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -243,8 +243,7 @@ static void fill_reftable_log_record(struct reftable_log_record *log, const stru
 	log->value.update.tz_offset = sign * atoi(tz_begin);
 }
 
-static int read_ref_without_reload(struct reftable_ref_store *refs,
-				   struct reftable_stack *stack,
+static int read_ref_without_reload(struct reftable_stack *stack,
 				   const char *refname,
 				   struct object_id *oid,
 				   struct strbuf *referent,
@@ -262,8 +261,21 @@ static int read_ref_without_reload(struct reftable_ref_store *refs,
 		strbuf_addstr(referent, ref.value.symref);
 		*type |= REF_ISSYMREF;
 	} else if (reftable_ref_record_val1(&ref)) {
+		unsigned int hash_id;
+
+		switch (reftable_stack_hash_id(stack)) {
+		case REFTABLE_HASH_SHA1:
+			hash_id = GIT_HASH_SHA1;
+			break;
+		case REFTABLE_HASH_SHA256:
+			hash_id = GIT_HASH_SHA256;
+			break;
+		default:
+			BUG("unhandled hash ID %d", reftable_stack_hash_id(stack));
+		}
+
 		oidread(oid, reftable_ref_record_val1(&ref),
-			refs->base.repo->hash_algo);
+			&hash_algos[hash_id]);
 	} else {
 		/* We got a tombstone, which should not happen. */
 		BUG("unhandled reference value type %d", ref.value_type);
@@ -855,7 +867,7 @@ static int reftable_be_read_raw_ref(struct ref_store *ref_store,
 	if (ret)
 		return ret;
 
-	ret = read_ref_without_reload(refs, be->stack, refname, oid, referent, type);
+	ret = read_ref_without_reload(be->stack, refname, oid, referent, type);
 	if (ret < 0)
 		return ret;
 	if (ret > 0) {
@@ -1091,7 +1103,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 
-	ret = read_ref_without_reload(refs, be->stack, "HEAD",
+	ret = read_ref_without_reload(be->stack, "HEAD",
 				      &head_oid, &head_referent, &head_type);
 	if (ret < 0)
 		goto done;
@@ -1167,7 +1179,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
-		ret = read_ref_without_reload(refs, be->stack, rewritten_ref,
+		ret = read_ref_without_reload(be->stack, rewritten_ref,
 					      &current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
@@ -1733,7 +1745,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
 		logs_nr++;
 
-		ret = read_ref_without_reload(arg->refs, arg->stack, "HEAD", &head_oid,
+		ret = read_ref_without_reload(arg->stack, "HEAD", &head_oid,
 					      &head_referent, &head_type);
 		if (ret < 0)
 			goto done;

-- 
2.47.0.366.gd4f858ca17.dirty

