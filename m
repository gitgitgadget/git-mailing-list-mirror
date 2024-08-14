Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096391B1500
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641769; cv=none; b=ljV7jOg+66vhPztCVIrhY5ejHWPLqqN6LOh8ecpR/IvmVv1TnvxxbrgtoAHYCXXe7gbxSLHqun1sZmDqeqKiOpDYPwd9mdCaoYs+2l4MGX3VZRZvzD+LcFiEhe+yZ88sfNmre5F1fNMQbeYNM1iY7VqhKvLhx6w4UWOwTgRJwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641769; c=relaxed/simple;
	bh=UpAlBSqIAJIpMu8J2u5EahvDWzpl9hnzUvCAQFFGDKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0G6dr+bgu7F9EUakfbKO+D3cw2/OacJvs5jWjqhJyPH5rkx5MqHMi22ap0UsesyKPxaDhsPKF7JIHI/uf9VRQ0GkEdvGGTMkAwR/POQMAdB8M36aabHmvR5xV9TW2yxtWO5ihnQsT0E4RU5r+zIhzfuiS6CnKc/8RRp5mAbQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KVOmd5yG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ksIK46sR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KVOmd5yG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ksIK46sR"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 309A9114EA06;
	Wed, 14 Aug 2024 09:22:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 09:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641767; x=1723728167; bh=ISM+OyIsFj
	cXsFWN8SP+YOmX15fIP+fBmMlyP2t1JY4=; b=KVOmd5yG2cfSnwYR1Rqeny9rCB
	vBAvzBFynADTycG6Ivz1tg68vYuJTXiCy1s51UADmmLnDNhlASw0+Me4LmKcNSgk
	aM3BQKMd6z2jjW/9tI2qixm89HcVv01zQJtJkKkCFTmQOv6ks3GCCa0ZQSryhcRR
	adfFmr9kw9mRxtjoJlMPdac528eR9I5LUuIFCwcAd3JCrzrQSFKrthDI5kms4cBt
	boEhlOQ8IHpInFAWy94f28PLnLOkGNkNGeBKDavtPdWYMFRoUun04J3lajOyecJq
	qdK7p5NtwRQAyKiOmNq8lXhcn8J/dLr86jWJiGfk66ZCZbo5UL0zhno6jr7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641767; x=1723728167; bh=ISM+OyIsFjcXsFWN8SP+YOmX15fI
	P+fBmMlyP2t1JY4=; b=ksIK46sRG4TUMTjpj6uGd48UBGY++opAqwcCjiEuiXow
	TtA9/kpI2c13NlEtvI2lPpS16uPK6OEHGkeW2icMhfnei0Ae9kLgtx9R2smywQ2B
	vNG5Ghiu1r760nOn4i0J2uqs9k1hK07ah/JXqjynyymDnMw9/VnFKUvJuWOTHowb
	Jik9tjRJBK2xSo5XHyJCIPS0lRHS3r0w5WZWrC30H3wUyv5SbkkRGgxlRvIc/sIK
	GOsXsmDE1GVUfxGoiUGlpWlHKhIIqLLp62I6E+LnA5z5zR+uRcz66TkvgSDae2Pf
	nZ18RtOkRCpewUmpnDAb8K0T1S+7NCLCqe6cDIOQhA==
X-ME-Sender: <xms:p6-8Zry_z1E7b2RMbcekoJCCTRxGO22WZDuFfA7nYkyy4ivVlJHkAQ>
    <xme:p6-8ZjSn_YzKSHjWxCQX_mxfjlZTv8BF9CcYxdxl2mzexNLYr3hSYP3pQqexHudc3
    iookDzPDh-vkfk-xA>
X-ME-Received: <xmr:p6-8ZlVBiR-uliQWaQmmwV8gO4RCWF1N2uq6Y7pJxLY6L2tKKUL78QRcUpeuk_CtavzLLUA3V5BBjQvL0_j6enKfj-MojhnkyzXK4u87gFG_bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:p6-8ZlibYvNcVVPgNefTJDM2ayE8Dno_DzwBGb9-0QZE62fT0JxGCA>
    <xmx:p6-8ZtD48PmRvWm9c-rYoVF_Bv2tS07cmuqbFR5Opqt3NqEOCZMF8g>
    <xmx:p6-8ZuJsyyvxnJl9Cr2SrL9Wh69P_kA-nW4Fl-sGhpKsiJw4r_yUpg>
    <xmx:p6-8ZsD5ZTgxM1QC_fley3YgyCd7twNe6zBN30ueu2y5JgYJk6f8aw>
    <xmx:p6-8ZgNQdMXTmPqZ1UAHcvlV2r2RKVGOLlkOh1IKZVuiLuOYIJlIuPLM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:22:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a883aa1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:27 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:22:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 02/15] reftable/merged: rename
 `reftable_new_merged_table()`
Message-ID: <bc6f1cd8c1b3b6f0e6f2c60eed15c6626fa8ff0f.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

Rename `reftable_new_merged_table()` to `reftable_merged_table_new()`
such that the name matches our coding style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                | 2 +-
 reftable/reftable-merged.h       | 9 +++++----
 reftable/stack.c                 | 4 ++--
 t/unit-tests/t-reftable-merged.c | 8 ++++----
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 8d78b3da71..25d414ec41 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -192,7 +192,7 @@ static void iterator_from_merged_iter(struct reftable_iterator *it,
 	it->ops = &merged_iter_vtable;
 }
 
-int reftable_new_merged_table(struct reftable_merged_table **dest,
+int reftable_merged_table_new(struct reftable_merged_table **dest,
 			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id)
 {
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 4deb0ad22e..72762483b9 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -29,10 +29,11 @@ struct reftable_merged_table;
 /* A generic reftable; see below. */
 struct reftable_table;
 
-/* reftable_new_merged_table creates a new merged table. It takes ownership of
-   the stack array.
-*/
-int reftable_new_merged_table(struct reftable_merged_table **dest,
+/*
+ * reftable_merged_table_new creates a new merged table. It takes ownership of
+ * the stack array.
+ */
+int reftable_merged_table_new(struct reftable_merged_table **dest,
 			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id);
 
diff --git a/reftable/stack.c b/reftable/stack.c
index 2071e428a8..64c7fdf8c4 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -272,7 +272,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	}
 
 	/* success! */
-	err = reftable_new_merged_table(&new_merged, new_tables,
+	err = reftable_merged_table_new(&new_merged, new_tables,
 					new_readers_len, st->opts.hash_id);
 	if (err < 0)
 		goto done;
@@ -924,7 +924,7 @@ static int stack_write_compact(struct reftable_stack *st,
 	reftable_writer_set_limits(wr, st->readers[first]->min_update_index,
 				   st->readers[last]->max_update_index);
 
-	err = reftable_new_merged_table(&mt, subtabs, subtabs_len,
+	err = reftable_merged_table_new(&mt, subtabs, subtabs_len,
 					st->opts.hash_id);
 	if (err < 0) {
 		reftable_free(subtabs);
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index b6263ee8b5..210603e8c7 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -111,7 +111,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 		reftable_table_from_reader(&tabs[i], (*readers)[i]);
 	}
 
-	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
 	check(!err);
 	return mt;
 }
@@ -289,7 +289,7 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 		reftable_table_from_reader(&tabs[i], (*readers)[i]);
 	}
 
-	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&mt, tabs, n, GIT_SHA1_FORMAT_ID);
 	check(!err);
 	return mt;
 }
@@ -441,9 +441,9 @@ static void t_default_write_opts(void)
 	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
 
 	reftable_table_from_reader(&tab[0], rd);
-	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA256_FORMAT_ID);
+	err = reftable_merged_table_new(&merged, tab, 1, GIT_SHA256_FORMAT_ID);
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
-	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
 	check(!err);
 
 	reftable_reader_free(rd);
-- 
2.46.0.46.g406f326d27.dirty

