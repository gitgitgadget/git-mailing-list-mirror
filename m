Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3E1AE02A
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641783; cv=none; b=U0/HAbnEOswehj+N2Qre6Eb0H64/xVhP/up+6+aa6gosx8yMmPbq2eo2tyLX72mq7d8dnSHCy/RNEHP7iugfkSFMC7XbtY8aOR1hIMMcxZ0JA9nXMBJ3SaQB8yK5cSiheMLNFRLTo8pBXV9O3ca8whxFwwpKq0JTHv9em40bBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641783; c=relaxed/simple;
	bh=ChkEB29B3K1d+R4FrFf3sR2XGAvKbolMkPB9Bt0FKQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyJC/rQHRBTNBAWDeIiz98G+uHuxLsiIeH8dPQsT3SBW/LFdFnib24DNzW1XgA7aPdSdPP0FgwiQfdi+sa9DK7QVPAX6gXFpXw8lq7b6Qnq7P/YUFFadVnGHRjip3CWq7OkhxEDqcEL0QQHlLgpGeCulTiol6m7jkB6RUPpDe18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R1WazNGW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYZcjKv1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R1WazNGW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYZcjKv1"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5C521138C92C;
	Wed, 14 Aug 2024 09:23:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 09:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641781; x=1723728181; bh=+Q8fJJwbuP
	mC1VxplRl9eEkQYqsXie4x2pUcpvfWVkE=; b=R1WazNGWbks/sJIm44EwZs/vOC
	WEAr5yZAos1fV0tSvWwmASNR5YMGhFFyLH3NiGe9kZLVkFR/7lRGsHIQmg+9PhAw
	zvzqh8JZMv1Rd266+ny23MwYX2ux1zj0LpU66SatIXg0IemywE9O4mi436rnBAjS
	db6aSdetOx5dpo7f5AHwZeHpIrkJXfqgur8lBZxY3ASZ7Vmo31BhoaGrwdmkLfmQ
	3IhP9LXfbEo9+ASVa1rcv/vFr6+kYbgJ8TZogdWym7QIZM+D4LFsS+5iWthjrzTk
	hSscFO287oZuto8YKHAJ8pxBio5bea+cY7+B6bgpfBklAd60bPCFGgC2wA6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641781; x=1723728181; bh=+Q8fJJwbuPmC1VxplRl9eEkQYqsX
	ie4x2pUcpvfWVkE=; b=lYZcjKv1Gq3NPSzozDGJn5SF91oelsr+opSNnU6YmvvC
	uVKMIQsk9iPZ3/wJJUmgBTgjYVpMy7jCT1GYU/GTgb8T+PtBS4/EGBQXvy8hvrAR
	HK9All0fSxzYrIhGd6ZqEHjOS0sLe6r/kJKz9EKWtVAKT82ueVKUQlUZaUTuRmSH
	DrN0X3wJ+ACDcAe8Fp0lzsuB594eaqR7EmZx71z+vQfy/S8xvnHPDBI+v7wDKorV
	7YkJ5plba3/s8V2pTXmUR5wYS4lxFXIVV4FMz3zAfnsUHHEQFB4yB9F3woTFTpdq
	lMz6+4Vyv0IiawJhM5bkk5gjUpF9pcw/Nlgl1qFtXQ==
X-ME-Sender: <xms:ta-8ZhnOedjBmVc6zNjQqcXGnZls7Q8WRtry5C7GBEHWYmvC4vabWA>
    <xme:ta-8Zs1SCZDGgc079i2_fa6juJv1EyBReKyaV3rMCKCRXyrGo3ZliTPN4iwh90mza
    vxHpapVeu5i8KcEaA>
X-ME-Received: <xmr:ta-8ZnrHuMZ-a2j2WMGCYR2Fd643bpvO2QKISCUAdz4bfirk3uX-l36SwWC6o09_G1UTWJztf74L-kwKDmDxpFMLqEsue27GjssxGnh2-yuYzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffelgefhueefteeutedvffekgefggfetveejvddvkeei
    gfdvieeuuddvkeevkeetnecuffhomhgrihhnpehvrghlvddrthgrrhhgvghtnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ta-8Zhn3P5V2EQFDPaiXwA7l1wFq5EmJkcTgiu6fyxYpVko85iuLaA>
    <xmx:ta-8Zv1vjLlC_VvRVjXAjFepXZhGY6suqscaJ1FEy8BVJNgKAmNl8w>
    <xmx:ta-8ZguZi1G2JJMvj5tass-R7qi9Jr1qz7serdkloHG5pgM3UvaZSg>
    <xmx:ta-8ZjWdsTZRgCQq5IRTpGbhW-n6XEGlLDoVydpXHkxo0R7y5ueSvw>
    <xmx:ta-8ZtCfBDRdCRAUVa-39yMueQp0B4AwRq-D-DbVJpPTD8GhOwN5a39o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63441770 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:41 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:22:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 05/15] reftable/iter: drop double-checking logic
Message-ID: <cac08a934c58f9e31c2139251722fbff8fb84e1d.1723640107.git.ps@pks.im>
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

The filtering ref iterator can be used to only yield refs which are not
in a specific skip list. This iterator has an option to double-check the
results it returns, which causes us to seek the reference we are about
to yield via a separate table such that we detect whether the reference
that the first iterator has yielded actually exists.

The value of this is somewhat dubious, and I cannot think of any usecase
where this functionality should be required. Furthermore, this option is
never set in our codebase, which means that it is essentially untested.
And last but not least, the `struct reftable_table` that is used to
implement it is about to go away.

So while we could refactor the code to not use a `reftable_table`, it
very much feels like a wasted effort. Let's just drop this code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   | 20 --------------------
 reftable/iter.h   |  2 --
 reftable/reader.c |  2 --
 3 files changed, 24 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index fddea31e51..a7484aba60 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -42,26 +42,6 @@ static int filtering_ref_iterator_next(void *iter_arg,
 			break;
 		}
 
-		if (fri->double_check) {
-			struct reftable_iterator it = { NULL };
-
-			reftable_table_init_ref_iter(&fri->tab, &it);
-
-			err = reftable_iterator_seek_ref(&it, ref->refname);
-			if (err == 0)
-				err = reftable_iterator_next_ref(&it, ref);
-
-			reftable_iterator_destroy(&it);
-
-			if (err < 0) {
-				break;
-			}
-
-			if (err > 0) {
-				continue;
-			}
-		}
-
 		if (ref->value_type == REFTABLE_REF_VAL2 &&
 		    (!memcmp(fri->oid.buf, ref->value.val2.target_value,
 			     fri->oid.len) ||
diff --git a/reftable/iter.h b/reftable/iter.h
index 537431baba..b75d7ac2ac 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -18,8 +18,6 @@ license that can be found in the LICENSE file or at
 
 /* iterator that produces only ref records that point to `oid` */
 struct filtering_ref_iterator {
-	int double_check;
-	struct reftable_table tab;
 	struct strbuf oid;
 	struct reftable_iterator it;
 };
diff --git a/reftable/reader.c b/reftable/reader.c
index f7ae35da72..e3f5854229 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -735,8 +735,6 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	*filter = empty;
 
 	strbuf_add(&filter->oid, oid, oid_len);
-	reftable_table_from_reader(&filter->tab, r);
-	filter->double_check = 0;
 	iterator_from_table_iter(&filter->it, ti);
 
 	iterator_from_filtering_ref_iterator(it, filter);
-- 
2.46.0.46.g406f326d27.dirty

