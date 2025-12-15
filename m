Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31510271468
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784199; cv=none; b=UXcUfTrWOsGapyKyXpxeyCs7jjkvgLaHYZhOhxfIP1diYp/al2McTReldKla0lMrANOu0tETcrT+sUv80kBXxvFsTghhIGxgEvxXEwByO+6zS77A49CGMGyCpBO22d4Q8vEbw20PgqQO0vRyKAkCysfkOcw0W43ZfhFPJnQ+Puc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784199; c=relaxed/simple;
	bh=547FGJ9dj5qca1Ur2AovH24ciDwqApBdzx5/QkFXHmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UD9TD1rDIgHF8DrIZpwjQ9eKZ4K+C5sUtNeSoB6IGJjHAjQQroO/Gt4DIf4vUNZZGyFTUbqV9bUmOFS3RlqTjogVkrAUI1XnQhtcmX/93QDqw9UR+ejm8wj1XopfgAXZiWLAoENy9H14wT2SzJ7jMg4jpJMuMG36XFEMnKPXPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ublrpNkF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJmerxwm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ublrpNkF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJmerxwm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D1B2EC0077
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Dec 2025 02:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765784197;
	 x=1765870597; bh=5o/QQPH4yOGz57JRIHC/c6qoPqezyKVoczjeQsv9uJg=; b=
	ublrpNkFLlDo5oowTJ1b6RTfyN9fJ5JlPUybRev//kO+VACXl1erbWYcNqsTHjeL
	/lvZqv/HMDAnx+Jw1nJ6DClUxUhQrfvxrr1rohZ04ORyT3wiXaYm2MbpdpIfrz8K
	P8pDmNdvW0wkLbSIpFdfOqjqM7sBwTzm+vpUYcuNXkz0xbrCQCywEgDeNew4iJMr
	/WXc6YlJYQLL0GJj9JN4cf46cS1YgETwwjR+J7J0LVy+vdZwaZouGGG4a4ZfJzpS
	byxJXD7xcDew498RViY4+jPQx+gpEelCjXrO17ciD0fNXaOHs5XpdgWA4/RwYqpR
	Dv7dFC80KyJPewQpRTBSNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765784197; x=
	1765870597; bh=5o/QQPH4yOGz57JRIHC/c6qoPqezyKVoczjeQsv9uJg=; b=P
	JmerxwmWp3aanhFy81tdnDbmCvu6+lpU8NjIHTnGacEHnl5cPEIxxvu74P8F8mbk
	RjyULwUSUPBwkMW7+ULRJthnTd+ibLmVRUXihql0gFuZbYIPIeg1w6m3oUizJlTq
	bPJUulNV15hSYwwrJf78z7Y24XlLLj/8MZL0tWlIbqHeFEgKP/0bHRluHn5RmM3/
	bzfuZQ3fjD1gruB1OIr+2H74FIDOwZ6vzxth4z8G9tOztHinOn5XAA/9wGqHYPPJ
	nRNcDJBSPJPAQjMln2JjGpkzeT4e87EdkBeTks6F/6dt7bVMgfHARxQ02Iq6X7fa
	in5gT2bscdAky/FJTmA+A==
X-ME-Sender: <xms:hbo_afIMT4v-kn0suJbxr5jo9CKichjgyDyTmnHBM8ygADZBwS2V_w>
    <xme:hbo_aaEDAsifpK1C0klV7SJiSNwOQC37O9MLQx1iGC1gkiYXi4b2eL62MrULTUCjy
    FiWpeSodf-jIkpj5IUhktsFX7_xDwxEETI2YC7r0Y-RCXWVtkrpeA>
X-ME-Received: <xmr:hbo_adWcrGpBMLnOWGQLqa5bVxVRxgd8H65TdV-cOlh6ICwEmfF8y1G0agHdjlngaIgtRqnho2KJqYAFgYCl0tHLOCKIAAf4iJo6tMGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:hbo_adilNzMUjhaWrFrvtmVfVJZv3kW7VIzGhzmX165WkKyMdEnkaw>
    <xmx:hbo_aWSi9qG6E_k6KgkyGjyYLvMysxQxNJMw686TM0hw5DBAMN-7pg>
    <xmx:hbo_aYHpw7mAli6EbPpCSYo0wXJV7qI6N9lNDtgwiu25bq1yD8EIWw>
    <xmx:hbo_aWlbH0xbWj-RqueRR4o4cA2bsILoTT8EWEzX7sAMBWys-oyqsA>
    <xmx:hbo_aUobQfiHo_AYsZN_tH3_SK7kmUmE7njJLpFHMUcVITXG0zetKk_O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 370c13de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Dec 2025 08:36:23 +0100
Subject: [PATCH 04/10] packfile: refactor misleading code when unusing pack
 windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-4-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `unuse_one_window()` is responsible for unmapping one of
the packfile windows, which is done when we have exceeded the allowed
number of window.

The function receives a `struct packed_git` as input, which serves as an
additional packfile that should be considered to be closed. If not
given, we seemingly skip that and instead go through all of the
repository's packfiles. The conditional that checks whether we have a
packfile though does not make much sense anymore, as we dereference the
packfile regardless of whether or not it is a `NULL` pointer to derive
the repository's packfile store.

The function was originally introduced via f0e17e86e1 (pack: move
release_pack_memory(), 2017-08-18), and here we indeed had a caller that
passed a `NULL` pointer. That caller was later removed via 9827d4c185
(packfile: drop release_pack_memory(), 2019-08-12), so starting with
that commit we always pass a `struct packed_git`. In 9c5ce06d74
(packfile: use `repository` from `packed_git` directly, 2024-12-03) we
then inadvertently started to rely on the fact that the pointer is never
`NULL` because we use it now to identify the repository.

Arguably, it didn't really make sense in the first place that the caller
provides a packfile, as the selected window would have been overridden
anyway by the subsequent loop over all packfiles if there was an older
window. So the overall logic is quite misleading overall. The only case
where it _could_ make a difference is when there were two packfiles with
the same `last_used` value, but that case doesn't ever happen because
the `pack_used_ctr` is strictly increasing.

Refactor the code so that we instead pass in the object database to
help make the code less misleading.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 191344eb1c..3700612465 100644
--- a/packfile.c
+++ b/packfile.c
@@ -355,16 +355,15 @@ static void scan_windows(struct packed_git *p,
 	}
 }
 
-static int unuse_one_window(struct packed_git *current)
+static int unuse_one_window(struct object_database *odb)
 {
 	struct packfile_list_entry *e;
 	struct packed_git *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
-	if (current)
-		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (e = current->repo->objects->packfiles->packs.head; e; e = e->next)
+	for (e = odb->packfiles->packs.head; e; e = e->next)
 		scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
+
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
 		pack_mapped -= lru_w->len;
@@ -740,8 +739,8 @@ unsigned char *use_pack(struct packed_git *p,
 			win->len = (size_t)len;
 			pack_mapped += win->len;
 
-			while (settings->packed_git_limit < pack_mapped
-				&& unuse_one_window(p))
+			while (settings->packed_git_limit < pack_mapped &&
+			       unuse_one_window(p->repo->objects))
 				; /* nothing */
 			win->base = xmmap_gently(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,

-- 
2.52.0.351.gbe84eed79e.dirty

