Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818A20E016
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273735; cv=none; b=F26E85nUrC51c4KMe2QV+UXRtZ3HQemkaERwz4BGyjwLqY9YVoxHN9nHDUGGe6ByB9V1cIKn00/RIunc6drmzTmJOmbsxev6qudRaRI60C12zfsYiGczeXkVhMUZQuCvFsGbUemMLfAO8Q565OvOO1reVm2SO67EMj+kmzBu9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273735; c=relaxed/simple;
	bh=PR1MErk/1XGCuIs7qu1Fqh6lkyJK6Tq5J9PksgCtn8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qo3qSGtsheYmpoN0JVRIulCsx3xZELOLQZhb/UnXoHgDJP56V+/ndwomzSusJA46fseSR3uwqkPLlk09I6MQYDAH65c4pf5X0yIssCMt7yhz2EkSstmgDFvcGP9TiI+pZlzq2W96V7IFBFqJTj3V1ppSc0z58/zzr7YaVQjCTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CC6XDP8o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O727ChwN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CC6XDP8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O727ChwN"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0475711400C9;
	Thu,  6 Mar 2025 10:08:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 06 Mar 2025 10:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273732;
	 x=1741360132; bh=ipS1Td7FVfRKKTDTQ5uQxSakqlyxgsFYjSxQkX/1X+Y=; b=
	CC6XDP8oH9hwMtTcK92ivBYRBdyE/b4WYXxnO+Q2Q1qmUBhOsIgq6QqtxzHQCWsx
	5xnRJH0N0EMc6ISRQfhD+QP8bgHOKMqL94YqFLHCuKZ+bg3Um3pqewZRNkyqn0NG
	AVgYf+XXACtKqlqUf55o51BYCgKkvSI4koCST3ad15PHoUAD25Qd2gBxU6dIVNQB
	RsGT6eHboDLg+O8LNbtNGkF9u23ltwMGLf3EaND2jQsQ0wug5nUtma0h15XK9XuC
	el/JZ4PjY1oOFDxvC0wVz4X5sfrqsFGmydOiVPJC637pAMcTPEm+PJRKJWBOF1qe
	fs3cUSRopgAFciGZDthQZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273732; x=
	1741360132; bh=ipS1Td7FVfRKKTDTQ5uQxSakqlyxgsFYjSxQkX/1X+Y=; b=O
	727ChwN3PvTpU+SHLxEW2QYcC3OAWFxCMFc/mg3iwm91MU5x5mduhj2r22qwXohX
	NtOY2wKlglpzvJiZkJK7AWCou0E5qAOoVC4Gmq+8X8WZ+pZPYYN1VEKTpwXg0tjN
	sRp/D7rIYkIuB9XdPBBGePYEZ2LsMBRLCQ0UAyxUJs12v7BQW/XrAKPb81/E5KRY
	/XMr4k8/QvrMuG6PHqj9Rhjg6pLtUgijWcUZSmuOt7SqMCZ8XtWEQz+11D1b0eA6
	gybxQreJmErWu5rL6JzSSkILjXVuGj5cAT/vGR5mh1G2uzw59irnvuEmzf3K9RF+
	HVv3UTTnzeI9utobBD0HA==
X-ME-Sender: <xms:hLrJZ2QL02fQ2s7v5lxOVdpUX_VM3lE-qnaBYHUg33z7qxT3rChzdQ>
    <xme:hLrJZ7zNPVEsUPbO-ia1_gqft1hhrqlEeFbbsyD4gwYHzWwyS8y6j1gSszGOq5UZ2
    ePAa3AcQ-bGp_ySnQ>
X-ME-Received: <xmr:hLrJZz3Z18bCsFh_-zm2KvqDX0wD-OzIJCbI2Rq5Bk-OLk4SIl5OzbxyNvCtbr1-mrbvMpNpB9GxFPse6DSiale3gWXhznGbfBnGP6nA8mtrpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:hLrJZyC5MwbLnT_E6hLjp0X4dISck-drlvyy6h1vUALOYdANdobThQ>
    <xmx:hLrJZ_hWHMIJfnn7WLN8dy7A01XnUAaYCo-GVdaHY69t7-_anOq3YQ>
    <xmx:hLrJZ-pzutmgKqRcR2X-QQI-kP8rZZgc_foJTiTvOHcRstObRat-Pw>
    <xmx:hLrJZygo3XIh9dQB4ZJFnZxpCQsck2LKKMWrKMT4_1dzvYM2wePSxA>
    <xmx:hLrJZ_g-5sfSw5xBDO0eAtHrumjr_aVXP731AZgi8YeF_tea9gOy-B9a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b7a2a87d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:42 +0100
Subject: [PATCH v5 11/16] refs/iterator: implement seeking for merged
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-11-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking on merged iterators. The implementation is rather
straight forward, with the only exception that we must not deallocate
the underlying iterators once they have been exhausted.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/iterator.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index 757b105261a..63608ef9907 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -96,7 +96,8 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator)
 struct merge_ref_iterator {
 	struct ref_iterator base;
 
-	struct ref_iterator *iter0, *iter1;
+	struct ref_iterator *iter0, *iter0_owned;
+	struct ref_iterator *iter1, *iter1_owned;
 
 	ref_iterator_select_fn *select;
 	void *cb_data;
@@ -160,13 +161,11 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	if (!iter->current) {
 		/* Initialize: advance both iterators to their first entries */
 		if ((ok = ref_iterator_advance(iter->iter0)) != ITER_OK) {
-			ref_iterator_free(iter->iter0);
 			iter->iter0 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
 		}
 		if ((ok = ref_iterator_advance(iter->iter1)) != ITER_OK) {
-			ref_iterator_free(iter->iter1);
 			iter->iter1 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -177,7 +176,6 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		 * entry:
 		 */
 		if ((ok = ref_iterator_advance(*iter->current)) != ITER_OK) {
-			ref_iterator_free(*iter->current);
 			*iter->current = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -206,7 +204,6 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (selection & ITER_SKIP_SECONDARY) {
 			if ((ok = ref_iterator_advance(*secondary)) != ITER_OK) {
-				ref_iterator_free(*secondary);
 				*secondary = NULL;
 				if (ok == ITER_ERROR)
 					goto error;
@@ -226,6 +223,28 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_ERROR;
 }
 
+static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct merge_ref_iterator *iter =
+		(struct merge_ref_iterator *)ref_iterator;
+	int ret;
+
+	iter->current = NULL;
+	iter->iter0 = iter->iter0_owned;
+	iter->iter1 = iter->iter1_owned;
+
+	ret = ref_iterator_seek(iter->iter0, prefix);
+	if (ret < 0)
+		return ret;
+
+	ret = ref_iterator_seek(iter->iter1, prefix);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -242,12 +261,13 @@ static void merge_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct merge_ref_iterator *iter =
 		(struct merge_ref_iterator *)ref_iterator;
-	ref_iterator_free(iter->iter0);
-	ref_iterator_free(iter->iter1);
+	ref_iterator_free(iter->iter0_owned);
+	ref_iterator_free(iter->iter1_owned);
 }
 
 static struct ref_iterator_vtable merge_ref_iterator_vtable = {
 	.advance = merge_ref_iterator_advance,
+	.seek = merge_ref_iterator_seek,
 	.peel = merge_ref_iterator_peel,
 	.release = merge_ref_iterator_release,
 };
@@ -268,8 +288,8 @@ struct ref_iterator *merge_ref_iterator_begin(
 	 */
 
 	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable);
-	iter->iter0 = iter0;
-	iter->iter1 = iter1;
+	iter->iter0 = iter->iter0_owned = iter0;
+	iter->iter1 = iter->iter1_owned = iter1;
 	iter->select = select;
 	iter->cb_data = cb_data;
 	iter->current = NULL;

-- 
2.49.0.rc0.416.g627208d89d.dirty

