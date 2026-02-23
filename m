Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F432364EB9
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848023; cv=none; b=Gh3VxsLhagj75JPMxNgolA03En/ssZtja4/aWn00v1lp2zUs/is1M6eHUfFAAlDO+LYRBzqmc2a3YmV0X6+YVf7+xU0BiOzBEA2FqqRPI9BrDrdSpJlskE2nvWDzDzAA30tfmB/SsSU1N8llgOcwJeBA3PWN3lscBPpjM9x6ViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848023; c=relaxed/simple;
	bh=sdWfJ/e/QxBSKwJTN68jMB47sv7eNTaG3krYOtdt84U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0jFEuMDCz0CnHBjYioaADAOGciJoPfALti9pXMZTTvB4VDEjOp3QXJb1sMHASPMGP24ey6pGFbxvvfRp7K/lUjkSo65Ym2dLM3mGk7Z4k/shUHj26nKSj6ttkcjroMUpvmqK7CAiVjZcY5sSTrwdsIBfhVcm+k0bR+gRC0JGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gPgsB+7V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H7a9Qrt4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gPgsB+7V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H7a9Qrt4"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id E0093EC05C2;
	Mon, 23 Feb 2026 07:00:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 23 Feb 2026 07:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848017;
	 x=1771934417; bh=Io1eojwVeKwRd6sHNTmgLkD9KgugVGrscQrF7pJvhZ0=; b=
	gPgsB+7VW3BNGSMLQYeDInwJBVq4Cs4qAPd08b4mU4kvd/vbOOgumKcEujD+I6yT
	921DaCjYu/aVpEb9H7sLLUbUMeRxNq6BWpDJYxUv10/I7Rp3HNqiIYLdTerJvE9x
	ovTVF7ZFAoIOusj9LvUnSe/DVlHwWtnM+PaChPJo29SzDrPAmA1feypSkfbI9TdH
	8ykXZ2plqwopCTGSGUOdw9J9mNYiHjytYSGPZZBOlpJNct99X2sy/uZx8YjXrDWt
	EHgIm3b9bLOYjNtEePEfKOD/0bUNKktTHoax4F8uXZ7g5zEmGfc0Dt3VVtQGoW7H
	l/48dsdC28sdMqSfGopmMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848017; x=
	1771934417; bh=Io1eojwVeKwRd6sHNTmgLkD9KgugVGrscQrF7pJvhZ0=; b=H
	7a9Qrt4aJQSqr127GVUuIKNk1CZyZzXV6O71e+cp5nX5MIcCfIcaMAwKMvcuo7ec
	u4DfoDBjKDDOV6uxU1OsSeXr1HBFIYBzq4lirS34+gly5ao7VKKqrtOpfD4NsTsu
	Swl6DWZmiJWNU94Q7NUp/OaQqrfM6SlMuE4UdjVPI11BLNQIqVtyQ8U/PF0WE9Bl
	+bSuzjrRuaRSXcEKuS1zhISRzYFH/Jp2AxkKv2DbiFeEkwge3MbL3Y7pK4r50Xpk
	sWzgGsoZ6AuKrvRzgXX68eqP64kBeK5kggdID6c5k/CVuY9apCXmLuSM7r45LXcj
	4MQmtNqvG3sHeuVvKB/0Q==
X-ME-Sender: <xms:UUGcaYgbXl1KJnz4hGtNWvJ8M8JWwfcm5jFhBc2nVx4RxoqU1Wf0AA>
    <xme:UUGcaYfg_1CFLT0c9Wf1GhIhWs4kvXqrJel01lp-sHu_QdXToB0lNNGZxIGYJhe50
    7RjaLa3xDgUhQXjqI1TxR9iONRKUL5JReBg6TV4Sm42i5LZGrhM>
X-ME-Received: <xmr:UUGcadfrnaOTMe-R9AeKdPcdln0KEqOmJmMlJxeWvWCpajuucH5AlwvjPwU6mpQ9E5FG8IU6bgCeFtzkomipSltU8gRJ53MRA9UBwa00nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UUGcaS8YH1HR5WFRVvzZ1-F19BMq29vF_soAl6KWoyh5ht6U69lo3g>
    <xmx:UUGcaZkBrfGYyNDmD1V-zg6kcxEHpf8NlIpl03EuI7VjNe9WN0L15Q>
    <xmx:UUGcaU-ltodZHiE5J39qEeXornsRSjSMB1VL8zvsxGNwBZlRxoC4Cw>
    <xmx:UUGcaXlm8DX722SHtjGSksHhkrw6Z0riMJqXYiDu8lYXC5tW7lQ5zQ>
    <xmx:UUGcac84bP-1x5icaKJV1C_eRpX0_ZrEuyElL-YBDgq6zys4FHREF1k6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e019f7ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:47 +0100
Subject: [PATCH v2 13/17] refs: replace `refs_for_each_rawref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-13-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_rawref_in()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c |  8 ++++++--
 refs.c           | 10 ----------
 refs.h           |  4 ----
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index ace390c671..0fddaa1773 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -912,6 +912,9 @@ static int mv(int argc, const char **argv, const char *prefix,
 						old_remote_context.buf);
 
 	if (refspecs_need_update) {
+		struct refs_for_each_ref_options opts = {
+			.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+		};
 		rename.transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
 							       0, &err);
 		if (!rename.transaction)
@@ -923,9 +926,10 @@ static int mv(int argc, const char **argv, const char *prefix,
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/remotes/%s/", rename.old_name);
+		opts.prefix = buf.buf;
 
-		result = refs_for_each_rawref_in(get_main_ref_store(the_repository), buf.buf,
-				rename_one_ref, &rename);
+		result = refs_for_each_ref_ext(get_main_ref_store(the_repository),
+					       rename_one_ref, &rename, &opts);
 		if (result < 0)
 			die(_("queueing remote ref renames failed: %s"), rename.err->buf);
 
diff --git a/refs.c b/refs.c
index 791654a0f6..172d4cf941 100644
--- a/refs.c
+++ b/refs.c
@@ -1982,16 +1982,6 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
-			    refs_for_each_cb cb, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.prefix = prefix,
-		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index 01dc3c2fd4..673d4ccce5 100644
--- a/refs.h
+++ b/refs.h
@@ -542,10 +542,6 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 const char **exclude_patterns,
 				 refs_for_each_cb fn, void *cb_data);
 
-/* can be used to learn about broken ref and symref */
-int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
-			    refs_for_each_cb fn, void *cb_data);
-
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.

-- 
2.53.0.536.g309c995771.dirty

