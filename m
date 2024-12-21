Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B957136341
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734781845; cv=none; b=XNAlj36+VWcZtmPaw2fUi5JZg6gnzD7Cudn0scee4Vc3hOXNLg5lyU41XE+xOLr3qJhJxxt3FwCDpG6o+irYO+6kowYXJxeTzDhJL78EfnwR98H+v4AXANclUVhVFiZLt/MxZDyblBZIvXl3KU6MiuKlNyLoqvXxiDyhqf2pzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734781845; c=relaxed/simple;
	bh=7sPWZDTZ3msS4yrlwNDnR9znuRi3FhizkmSGCtQh4i8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyzs9ZlMMvSKZ/ehwS5DtU3p5r1zXbivAcGKE4DU0wvgl4VVjlnggzdX2+FcOj+Gmg812Xl1VE6FrUJbNaFaAmezRALsVP5Ka785//RHef7Diia+iawcv+nQamuu+zDaVY3C03XTnpWW3wAsYVTBfPZ94eTuo+bXOPop7G8yVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xvx5jhMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FcvR2Y6r; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xvx5jhMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FcvR2Y6r"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9387911400AF;
	Sat, 21 Dec 2024 06:50:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 21 Dec 2024 06:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734781842;
	 x=1734868242; bh=cxVpHCEn+aRS0Ttq6rzbempLToXkqG6bsjfCOUo6fQY=; b=
	Xvx5jhMgNoB0AFvixHznOplNGKDC57H225VCPFPSdAvY5c/u7oLAnW99DF2NxeZ+
	7g8npkf44WGUkjj7nOUuGlkQFc9ClPDU0qDeZCUyoes/HpmQ6fmXw0P+wI8PbR7b
	skhwlziE2glwC2KU5/VjpKgdSE90IknOz3YebTZKmgwToFAQvJmX323R7Vx9DUCw
	SWbgYFtoGPL+mbl/taEtlnro9bmtoKe6EKN+Gnj/YE3j03XmdAe97P0k7NiGjfHB
	ev13e+HY+OvSMqKEgoQGWX3YWErlUTDCvPz0b2kfdlTW5cBWo33wroUiBw4bHgjN
	Et5ZyEq/BCgng+kFIV7kdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734781842; x=
	1734868242; bh=cxVpHCEn+aRS0Ttq6rzbempLToXkqG6bsjfCOUo6fQY=; b=F
	cvR2Y6rf/LF1s9v11GtvmmCkEtZDGmcG90vYNT8DYFd/iAjZEnpbOC3EFsKuiJhc
	9mKy7Jlqwdo/l2hn6sTindTHqkKScp2ESzNUbRCJ9trrWKtxm3trXRSSklIw/qbn
	lihKgvRiiBCMbqK6g3dPPJCtCZxWwbEP0nflOJn5DhPKFwrEASisRi+CWcmW7a5M
	aYLgweBCqZv7EZjmH56juMI1cKx8txQhMAlgdbkdSgjsI57PqhdS+09s/qOiCfjh
	aoM2RSSRukN1ZJ7aADpgKa2/zo/wlqZyZn/+qKIIY/u/QyIf3gkl9wAk+BinvekS
	w0/3jfCxMBcK49IxKUiwQ==
X-ME-Sender: <xms:kqtmZ7ylvP5l_gyMMTkPihMt_RNd8RfSi4Gp6FTg5jpW5oUlWJVhZw>
    <xme:kqtmZzSVfwyLQZoezCTi6ztjQJqZ3QVLHiaNciLr6aLMY4jE_WEbwvj67-97NtKbN
    XU2j3BKvdv5zPHPZA>
X-ME-Received: <xmr:kqtmZ1WXr420qp5owrmdTsAzB-I12uo5xPQI3maaVg9en75snYg_lCzwcTM85xE3lFMJOlq1nSm4Vx0Iy4rGW0Ir7MG6QuuDqpSSEpODzoeKl8sVQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghn
    uggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggr
X-ME-Proxy: <xmx:kqtmZ1g5-ZLNLVxZ8SuoTD_8kqrn2Mhyetby0T5XzG3xTxNoKjBWMA>
    <xmx:kqtmZ9A-BudshG8YC5r3niSyFC-d2z1VxYhG5iGsPWD31h3Upj9e5g>
    <xmx:kqtmZ-I6vsLD66lF0Ak4HZNdOEnj63cJGyRBVcTpTl4Gsc7WhSg2RA>
    <xmx:kqtmZ8Cv24qYO0vVXofhKvWDoBBdBMjPOvSxWV6WeSwTA5Kdp8mt4A>
    <xmx:kqtmZ8Naagfk5lIufdnGx39yjX72l9lGTU23KI4dfNVqGw52rIxnIcGN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 06:50:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81b8d943 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 11:48:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sat, 21 Dec 2024 12:50:09 +0100
Subject: [PATCH 3/4] reftable/stack: fix zero-sized allocation when there
 are no readers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
In-Reply-To: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

Similar as the preceding commit, we may try to do a zero-sized
allocation when reloading a reftable stack that ain't got any tables.
It is implementation-defined whether malloc(3p) returns a NULL pointer
in that case or a zero-sized object. In case it does return a NULL
pointer though it causes us to think we have run into an out-of-memory
situation, and thus we return an error.

Fix this by only allocating arrays when they have at least one entry.
Refactor the code so that we don't try to access those arrays in case
they are empty.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 6ca21965d8e1135d986043113d465abd14cd532c..8328bfc58e9c207983ce88355d6110c40be3fac1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -270,40 +270,42 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				      int reuse_open)
 {
 	size_t cur_len = !st->merged ? 0 : st->merged->readers_len;
-	struct reftable_reader **cur;
+	struct reftable_reader **cur = NULL;
 	struct reftable_reader **reused = NULL;
-	struct reftable_reader **new_readers;
+	struct reftable_reader **new_readers = NULL;
 	size_t reused_len = 0, reused_alloc = 0, names_len;
 	size_t new_readers_len = 0;
 	struct reftable_merged_table *new_merged = NULL;
 	struct reftable_buf table_path = REFTABLE_BUF_INIT;
 	int err = 0;
-	size_t i;
 
-	cur = stack_copy_readers(st, cur_len);
-	if (!cur) {
-		err = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto done;
+	if (cur_len) {
+		cur = stack_copy_readers(st, cur_len);
+		if (!cur) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
 	}
 
 	names_len = names_length(names);
-
-	new_readers = reftable_calloc(names_len, sizeof(*new_readers));
-	if (!new_readers) {
-		err = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto done;
+	if (names_len) {
+		new_readers = reftable_calloc(names_len, sizeof(*new_readers));
+		if (!new_readers) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
 	}
 
-	while (*names) {
+	for (size_t i = 0; i < names_len; i++) {
 		struct reftable_reader *rd = NULL;
-		const char *name = *names++;
+		const char *name = names[i];
 
 		/* this is linear; we assume compaction keeps the number of
 		   tables under control so this is not quadratic. */
-		for (i = 0; reuse_open && i < cur_len; i++) {
-			if (cur[i] && 0 == strcmp(cur[i]->name, name)) {
-				rd = cur[i];
-				cur[i] = NULL;
+		for (size_t j = 0; reuse_open && j < cur_len; j++) {
+			if (cur[j] && 0 == strcmp(cur[j]->name, name)) {
+				rd = cur[j];
+				cur[j] = NULL;
 
 				/*
 				 * When reloading the stack fails, we end up
@@ -357,7 +359,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	 * file of such an open reader wouldn't have been possible to be
 	 * unlinked by the compacting process.
 	 */
-	for (i = 0; i < cur_len; i++) {
+	for (size_t i = 0; i < cur_len; i++) {
 		if (cur[i]) {
 			const char *name = reader_name(cur[i]);
 
@@ -388,11 +390,11 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	 * happen on the successful case, because on the unsuccessful one we
 	 * decrement their refcount via `new_readers`.
 	 */
-	for (i = 0; i < reused_len; i++)
+	for (size_t i = 0; i < reused_len; i++)
 		reftable_reader_decref(reused[i]);
 
 done:
-	for (i = 0; i < new_readers_len; i++)
+	for (size_t i = 0; i < new_readers_len; i++)
 		reftable_reader_decref(new_readers[i]);
 	reftable_free(new_readers);
 	reftable_free(reused);

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

