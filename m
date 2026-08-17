Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992203F5BF0
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964981; cv=none; b=Z4Ekzkts20vXuZqyQ/YAzZ5fgievSxsjuaFCBUYtpbK1Wnrzco74ysAVgfKSUtWdPazBqqo50Mwo+MoWPYW5RlE4pibQJDk/oj193ZgVYZqxPre217eTbPn+90MxjSSnmEn1p8oIA/6iRouCcK3IuYxmbYjhgfan9p6Nyosl/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964981; c=relaxed/simple;
	bh=1oY4Z2cden+ooQ1tVHZ7HHX280nZ9/ugLN0oNPBO2+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SR1Z+TQw/+T2oz4oPhValsl5UsnxYOmDpwF6b5EhRp0WbIxuK3pATDWXB1kGFh42Tkp2PaJGq4GHSmkLlS1ygtv1BgGmy5BmDOoC7UMjomy6+TNNGLg0MDcyzOu9C3zqegRVciQr/TTZnSQaW6QmVxJUz03Lt4zdIgYX3n/8WFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TyRLGilV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQnXogUn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TyRLGilV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQnXogUn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D0E3AEC01C3;
	Mon, 17 Aug 2026 07:09:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 17 Aug 2026 07:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786964978;
	 x=1787051378; bh=0/LjFHharSJP1bl7DxwmZrsJBYmieN6Dfcds+2YFmyI=; b=
	TyRLGilVg1qVxQxVjsx7I3vCt6nimHAwnYeYvbLfKPFYD/whEhg5FJzNl07P2uYX
	fmC+CiVMxDGmc5MDTRAAN8Iox+m11SxtvhYoAG6P9tNDAKueZe1TEPdxf6kGNwGU
	zUQJXlleGHCA8T2a/RLlQnvUqlvpKNLhDg8MPziPDQvriEStHicNBNsWyF4slLmC
	W4bi0UFAA70leq52GnJoVgLESqaYeXlH5esI5TqqWCxbmFEaOZOfQtjsPKSx+6Dy
	XWY/QMLxUBMqhP2N1okxcFLOly5xe8lVhILALQBC+ZDVqnRxxPRyj2zZNlv2qcM4
	wa8ggE0K+t4NMnXdu7HQKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786964978; x=
	1787051378; bh=0/LjFHharSJP1bl7DxwmZrsJBYmieN6Dfcds+2YFmyI=; b=T
	QnXogUn5e5IM3wScog7evAe90XQFMv5ayJfRU4hqDfN0yhnQv/hUekMuAPmQzCRd
	cqldCiol+9i17Jqmo//ZmmKBGg6ZngPf6j+ic+7iXSg1Bdq8UhRfzsxZLDLuSPtj
	xWtnHAP8mBB0rY3YmiHCqR8XqL66638gOv0B2xcciYwEjaN6OvtAqEgEfLGaRRr0
	wO5JDU6jir1c3ZhigY/SxRtoVczJ6KlIMZ0XK9P7zWv8MUu2T4gC7NvPCzU/jiNm
	vQ1btxZQoirpVheZFoSsfGT+JEkbRKWmWbD/wvl7TtcQrcsoL3YIBPdFHtALsIFI
	plUjNBicgMoGYk6io06wg==
X-ME-Sender: <xms:8uuCasgqw_G1SQxEPKQ0GRJwB_FodipX2TyXybJtKWoYxBRtiXOaTw>
    <xme:8uuCasCnF4yHLiW7CCBs3yDp-yMnDsx8bFcSquEfYydxsF7cITlGw0Je6SOQv_ybF
    bJuiJuYMDZ32175cdEkuUXmXBjV0zqOe5DK6spwFnwgOaE1LWGwN-o>
X-ME-Received: <xmr:8uuCapH6snmoxkGADOFxY52R6hUCO9mc_OYPe3-BGskuZukPxT5mnzyZGEXTIAXieMo27kVcoJ-y3_Vr_kgz8unszZD-SR0HqSZwQ5eTSA>
X-ME-Proxy-Cause: dmFkZTEL6cLDDLIx4QbmzJYC0Z/4awgbXXc9dd8oOjgQbbD+v94gpW/np/TpQlRxlH9FwU
    Iu5LJIu6dT8GhfnYMDUnIaQlRDtqSqS5I91bb+D3sEfE4WHq8gZw4uPCXbdr3IN6N86ABy
    EG37GpCz7DR2TAO6+AtjtnfPG19eb58JSS55ixKZCin8G+Kul/uKIOnlTP5MVBqRjX4Sgg
    MI3kChZZmHbMb/AqiKECmmjdOkbJN5vWqyP/AaM+IkMu4gdqJV/MRFCg7avT0d8iGdHyWM
    effpQURPnUyuLkl8bVsvSzN4ex5DuO/4ZPijEKD48i9PmdU24p8Grsn6T3JBpTFYoFJQgv
    fKAqmrJQo/Gabt4OP/uyxLYbHdiWAfn0DDVqLKqb29BPjR3qgqbFGmtfn6H2M6aMTDC3S1
    aEVw5TFGh9mxVQByOoayIMey7HXHw3zUtl2Nhrg+ZPj0CMdHt+l8DXC6//R52VcYTizrNz
    VpoJyHPRotIQLA8DvmN+UqDhrS7y3iNgEzUTtLOB8oEWDQ1vrgmlfc0iNl3jdbIdx6m9Vk
    cmUJyRHixcviQBSo+tVsKd8duzNPhzJckq1ZBrpqV6yFilCNZZcD0CMwGpccEYGAwqC1Jj
    LlB4i74p0LhYzwR5M5zhXLAcqj0pe6crUn8fmznDU2ecf5sL/Vti+1sPhJmA
X-ME-Proxy: <xmx:8uuCasIDHzNIWLRleUvAOqp2NT9KXZNGPmd67V2neuyBtEzf-5b_LQ>
    <xmx:8uuCalkbrgGG6gdTBQK8YHSjScxWS2mnNwYzyM5UnG-pHMgue-KkzA>
    <xmx:8uuCasToVdYqfNVUnkDxfi7zlvkBqXn77cPtPrkNDlXtS8OkRK3PgA>
    <xmx:8uuCavJGT4YIPcCHHLa40J7Nolm5KMBU6bn_len63IPuC_kEKuXJog>
    <xmx:8uuCajCq9iJsflmP1WJrBywj5TB0ezVH52oZTRC20AooZMl4IR-M-Uq2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:09:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a532a05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 11:09:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 13:09:25 +0200
Subject: [PATCH v3 5/5] odb: drop `alternates_db` field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-pks-odb-eagerly-prepare-alternates-v3-5-1115a7e02467@pks.im>
References: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
In-Reply-To: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The `struct object_database::alternates_db` field tracks the value of
the "GIT_ALTERNATE_OBJECT_DIRECTORIES" environment variable and is
used in `odb_prepare_alternates()`. It's not necessary to store it as a
separate field anymore though, as we stopped lazy-loading alternates.
Consequently, we can simply pass it to `odb_prepare_alternates()` via
`odb_new()` now.

Do so and remove the field.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 17 +++++++++--------
 odb.h |  7 -------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/odb.c b/odb.c
index ada42f864b..115957e983 100644
--- a/odb.c
+++ b/odb.c
@@ -505,12 +505,14 @@ int odb_for_each_alternate(struct object_database *odb,
 	return r;
 }
 
-static void odb_prepare_alternates(struct object_database *odb)
+static void odb_prepare_alternates(struct object_database *odb,
+				   const char *alternate_db)
 {
 	struct strvec sources = STRVEC_INIT;
 
-	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
+	parse_alternates(alternate_db, PATH_SEP, NULL, &sources);
 	odb_source_read_alternates(odb->sources, &sources);
+
 	for (size_t i = 0; i < sources.nr; i++)
 		odb_add_alternate_recursively(odb, sources.v[i], 0);
 
@@ -1077,11 +1079,11 @@ struct object_database *odb_new(struct repository *repo,
 
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
-	o->alternate_db = secondary_sources;
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
-	odb_prepare_alternates(o);
+	odb_prepare_alternates(o, secondary_sources);
 
+	free(secondary_sources);
 	free(primary_source);
 	return o;
 }
@@ -1115,8 +1117,6 @@ void odb_free(struct object_database *o)
 	if (!o)
 		return;
 
-	free(o->alternate_db);
-
 	oidmap_clear(&o->replace_map, 1);
 	pthread_mutex_destroy(&o->replace_mutex);
 
@@ -1138,10 +1138,11 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
 	 * Reprepare alt odbs, in case the alternates file was modified
 	 * during the course of this process. This only _adds_ odbs to
 	 * the linked list, so existing odbs will continue to exist for
-	 * the lifetime of the process.
+	 * the lifetime of the process. Consequently, we don't have to
+	 * reprocess GIT_ALTERNATE_OBJECT_DIRECTORIES here.
 	 */
 	if (flags & ODB_PREPARE_FLUSH_CACHES) {
-		odb_prepare_alternates(o);
+		odb_prepare_alternates(o, NULL);
 		o->object_count_valid = 0;
 	}
 
diff --git a/odb.h b/odb.h
index aefb34213f..748366a610 100644
--- a/odb.h
+++ b/odb.h
@@ -69,13 +69,6 @@ struct object_database {
 	 */
 	int source_paths_icase;
 
-	/*
-	 * A list of alternate object directories loaded from the environment;
-	 * this should not generally need to be accessed directly, but will
-	 * populate the "sources" list when odb_prepare_alternates() is run.
-	 */
-	char *alternate_db;
-
 	/*
 	 * Objects that should be substituted by other objects
 	 * (see git-replace(1)).

-- 
2.55.0.822.g20453c30eb.dirty

