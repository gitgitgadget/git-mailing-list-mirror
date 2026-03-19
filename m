Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5EB38A71A
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903213; cv=none; b=Ebf+hUEnQN/oQuO8G5WPkuRgCmtzDeswTCDsfI1RB6FlhmF1rCrCTCxVToIyyGh4R/P5w4uUkExclTpZ1yvLzjIXArErwbUSUXRCUQZxyE/NL1qSEtmFm1ZzhPmrr5jBhsbKaWPWv4LEHXgO2XbMZ3TX2Uc7QlZXpUHUJux4Cvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903213; c=relaxed/simple;
	bh=3hG5YkSt8OY4IJKiAi4f2Dj3Y5gYB2deqPJ9kic5wdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGlpvTqQLIdXxqQkkIlOZ5LCpawcNnfakGedCFhVmo3Qf94X+G63LBw3dUaw2A18zZv93ynokXlFYftUmGnWGnnPvcWUNEfL7GBMzIpg75E9rG5CGdka1J/Gdo1MXMcxIUtUMrhWiQTG8/x4D+4ZWsYAzLf4bOSX5xo7PAeRnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ialR49/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pxqjTemj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ialR49/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pxqjTemj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B785140021C
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 02:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903210;
	 x=1773989610; bh=4hlk680jubrd5iksA5QWjm8oUn/VTy3Z0wEw6KDFTLc=; b=
	ialR49/NoiJZBclN+qndygvhk7oX7c+y6iLjObT91DgnMKrkTra6ugaSitsczadZ
	MgUlnKquIkUwajdW6nnE6w/TdeoMLyZY9d2y+QU3qDAqJvYPbfSr2ax+pnHDC2AN
	7z6AdaLkyjLpSoR+A1/DAbw63pa+7Oo6R2nx0BS0ZBnFEzrnO5sV+mUUxCAxM5AV
	8P4Mn/hlh0xQuMixYGLRN5sqcvCcJ/Phf7k0OfY5Xt23MSpZdIjbPJM3Mc6YM54q
	ZausfASlSyfE1KkD/9DvST+cTobwSZH5UOAMXEMvbvNnlzmqVs5CHgZlud1cZOoj
	qVAG6rkq0NpSNUYtCiyY2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903210; x=
	1773989610; bh=4hlk680jubrd5iksA5QWjm8oUn/VTy3Z0wEw6KDFTLc=; b=p
	xqjTemja9gfoT2JpqsF35Ysk7c4GyxVbhOJibCBeYNiq+1I+5cxtQMq36ApTPaTA
	gJ67kxePGxZidRhSHbqYMAeGf0MDDaslYUVYFTk8VhXmPy1T4i4L6pT0fB5IiDmk
	pQlknxLO4XD3SW+i5bc1yYSrLa26Dznj/ocJODANUnpzeN/gyUi6q0xD9RDRvtwR
	vx2+P9dGmZTbFx7XyoLlRxpVckhDFXFnOIvfJlklwP2PVMwGOoGjxmHH+yW88+To
	5gZwM6cVmXgZGWRrWGAeGdvECqBUb92hofoGsVv6raEw5+J7YqwYS+ag1niN24lM
	M+xMsi094W8+1i8hhFvXw==
X-ME-Sender: <xms:ap27afhUT75z-JGswtQ_lmbH4beMj-ShMR1S7hueC9xtw2Edpvy6iQ>
    <xme:ap27aS8SXllKVtt585buREyu6raqMuF0vYVX3Nzj7Gku6juNA8mm2u8VPlSaeJknj
    qyNNt58V2E7L7gqXX-aloiPep5SuUOzz4Mp1Fi9TRfICjkBq5_fJg>
X-ME-Received: <xmr:ap27aUtj2pK5kSWiOFqrexEOPQK0RWJjQQyr4WtRB80zbGccR4rwI_hQ-Xtg6xYjgGXy2isqJvt3qy6Mv9vWGnePZcBBh0keOfuvP6XE2-37>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepheenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ap27aRYqy7eneIIuE8eujEnk9qCfTKmgpXljBVoP0mQSa5SjrGm74g>
    <xmx:ap27acqkvUqEgyJR6iM-jZhLjNpR1FDO-4Fflz1GxrbAi7Fl871NNw>
    <xmx:ap27ae-SrwxxElifiJahUZBOMJx6VOO-3eLYC7LFjPpra4oBw8a7nQ>
    <xmx:ap27aT9TF-prx_2YdPVnYKYX1jUPezBLMy5nmLB94D0VW37306YWyw>
    <xmx:ap27aQgr1vRrNVsBvZ13o2km3_gJDctnmiBeCk2ogMaTw84sb9CJS4Rz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1b942c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:08 +0100
Subject: [PATCH 10/14] object-name: abbreviate loose object names without
 `disambiguate_state`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-10-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `find_short_object_filename()` takes an object ID and
computes the minimum required object name length to make it unique. This
is done by reusing the object disambiguation infrastructure, where we
iterate through every loose object and then update the disambiguate
state one by one.

Ultimately, we don't care about the disambiguate state though. It is
used because this infrastructure knows how to enumerate only those
objects that match a given prefix. But now that we have extended the
`odb_for_each_object()` function to do this for us we have an easier way
to do this. Consequently, we really only use the disambiguate state now
to propagate `struct min_abbrev_data`.

Refactor the code and drop this indirection so that we use `struct
min_abbrev_data` directly. This also allows us to drop some now-unused
logic from the disambiguate infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 54 ++++++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/object-name.c b/object-name.c
index f55a332032..d82fb49f39 100644
--- a/object-name.c
+++ b/object-name.c
@@ -48,7 +48,6 @@ struct disambiguate_state {
 	unsigned candidate_ok:1;
 	unsigned disambiguate_fn_used:1;
 	unsigned ambiguous:1;
-	unsigned always_call_fn:1;
 };
 
 static int update_disambiguate_state(const struct object_id *current,
@@ -58,10 +57,6 @@ static int update_disambiguate_state(const struct object_id *current,
 	struct disambiguate_state *ds = cb_data;
 
 	/* The hash algorithm of current has already been filtered */
-	if (ds->always_call_fn) {
-		ds->ambiguous = ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
-		return ds->ambiguous;
-	}
 	if (!ds->candidate_exists) {
 		/* this is the first candidate */
 		oidcpy(&ds->candidate, current);
@@ -107,19 +102,6 @@ static int update_disambiguate_state(const struct object_id *current,
 	return 0;
 }
 
-static void find_short_object_filename(struct disambiguate_state *ds)
-{
-	struct odb_for_each_object_options opts = {
-		.prefix = &ds->bin_pfx,
-		.prefix_hex_len = ds->len,
-	};
-	struct odb_source *source;
-
-	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		odb_source_loose_for_each_object(source, NULL, update_disambiguate_state,
-						 ds, &opts);
-}
-
 static int finish_object_disambiguation(struct disambiguate_state *ds,
 					struct object_id *oid)
 {
@@ -632,11 +614,26 @@ static int extend_abbrev_len(const struct object_id *oid,
 	return 0;
 }
 
-static int repo_extend_abbrev_len(struct repository *r UNUSED,
-				  const struct object_id *oid,
-				  void *cb_data)
+static int extend_abbrev_len_loose(const struct object_id *oid,
+				   struct object_info *oi UNUSED,
+				   void *cb_data)
 {
-	return extend_abbrev_len(oid, cb_data);
+	struct min_abbrev_data *data = cb_data;
+	extend_abbrev_len(oid, data);
+	return 0;
+}
+
+static void find_abbrev_len_loose(struct min_abbrev_data *mad)
+{
+	struct odb_for_each_object_options opts = {
+		.prefix = mad->oid,
+		.prefix_hex_len = mad->cur_len,
+	};
+	struct odb_source *source;
+
+	for (source = mad->repo->objects->sources; source; source = source->next)
+		odb_source_loose_for_each_object(source, NULL, extend_abbrev_len_loose,
+						 mad, &opts);
 }
 
 static void find_abbrev_len_for_midx(struct multi_pack_index *m,
@@ -752,9 +749,7 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 {
 	const struct git_hash_algo *algo =
 		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
-	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
-	struct object_id oid_ret;
 	const unsigned hexsz = algo->hexsz;
 
 	if (len < 0) {
@@ -794,16 +789,7 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 	mad.oid = oid;
 
 	find_abbrev_len_packed(&mad);
-
-	if (init_object_disambiguation(r, hex, mad.cur_len, algo, &ds) < 0)
-		return -1;
-
-	ds.fn = repo_extend_abbrev_len;
-	ds.always_call_fn = 1;
-	ds.cb_data = (void *)&mad;
-
-	find_short_object_filename(&ds);
-	(void)finish_object_disambiguation(&ds, &oid_ret);
+	find_abbrev_len_loose(&mad);
 
 	hex[mad.cur_len] = 0;
 	return mad.cur_len;

-- 
2.53.0.1055.ga2ffed1127.dirty

