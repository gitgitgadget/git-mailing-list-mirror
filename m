Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC05282F0F
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278212; cv=none; b=YLzvVsiEgvG6l4T7+A/EWvPnax1V+XqmDEiO78iOF+UP2wZ4qKHnVxDeqlMM51QkO0VjMxoeYfW4vd2PndNHrqyzZI4lzy9SLt4nYRbCjYfdNZbk348FX8DAqh9kWpQYqeyQ5Td+F83/AXdBHJCXLuKqhHfy1Fda7slgCBOk6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278212; c=relaxed/simple;
	bh=iOn7KnfqHVDlw2i3Q7/RCKyWa0+Xj4BWyGpB8qtJaq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQVpPuTmYcN/9bIfm3zAjE3L/LHTz1b/hgzNU5IN/xOozmI1HzNajEIPZlqZusqpthIhnyJkgP41qCl0pWVUS9S0bxSVceEOKsQ7kTbbw/8YmsHYKesU42JUHUEGHIbGqmkeQR5P1VJ5J2Ov/GE6ywZZk+2OnURifhSrFtBcPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AkQzejVw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jOEb4L0f; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AkQzejVw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jOEb4L0f"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5FCF67A0150;
	Mon, 23 Mar 2026 11:03:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Mar 2026 11:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278210;
	 x=1774364610; bh=qw07NiOWQIFAkE3LwiYLQS0doo0iF51iQWTQnWl9Ur8=; b=
	AkQzejVw/8rsUu60K35EBw/5PrlN848qtt3SN6bqrOJi1BoJy4W3IBUxTOUJkKw1
	kN0LjjxpGTSGdbpIxg4u0FFVqKhzTcWe+W2TkzS2VnxoNgl1TLA1Qca33G3D6gHs
	Gf6zujdyAuImNCiYMts1yP+u8Xg9SCs95pa4xZtxz8BGOe9P6LoKwpgF4z6GPOTX
	k0Ajdd0aVYXD9eR3uu2dt5sFHYJ5oBMmqHGT2/RmBIIMX6GTpCMvqGB4MWfr11bm
	pwaK9gFJCwZZpRRQxAr6cgzUFDbi7oI2tAu7RxIidohectrVQf95oK8U8B/Zdm7I
	xF+ByjsAE2GVpYmcSAmeQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278210; x=
	1774364610; bh=qw07NiOWQIFAkE3LwiYLQS0doo0iF51iQWTQnWl9Ur8=; b=j
	OEb4L0fKyR0yCQJkU4JZGDFwbTnbtVzmALCSA2qB/t9H7I3gNpSwfV77WEPgu8UO
	PFGyb90+rnVEZtU9pQMC+63dbtDWjO24FHvLNhZyLg4HJ5RBG4fr/SDk21PanRTA
	POw37U1rBbvnk2KkycmU8aBQ7X49cET5++eBrzf30RKd98ko7yCelmlnlKyfcv4+
	whvPjxUOYWeVL/LtS71rMtbDatFe6WBThk0SnMjyTvwC/QmOEx8kmGybQpPaHTeO
	ywy4uQuUJ6Gdd8oeD8LRhTqPwGpi8glSQVKQoGw9YM11+f+/EEzPVSKYRWQefqkO
	Kba60IiK0P8Uz7T2S3HPw==
X-ME-Sender: <xms:QlbBaeJRoKIcOLDXsqkRHyIqy-6nhgt3Jo2TiUKot0BGnAACcxAKHA>
    <xme:QlbBacKIv5i41h6JM894B1Ia8aOTKdQK3ipkxdciuXftWp0FAUYBtky4-SoZexzri
    WuxBOsXEEfjk93RwwvkzYzOfEDgnyb80x_hd_3jEIXmyxZU3Flqfw>
X-ME-Received: <xmr:QlbBacV8jKHiSRlSF9pd0-RPh30UH8XkIJ5nwqp2msXyuXPDELvjdw4pu9o7dodBFJ3WLvv87AKK89Z7vQ_JNsIp8_qIFWYvcYuFN5v3cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QlbBaehmYASj9ToHJgn0Gw07Lsjwxwoa2LFQaTuX51IBUGQ8LpfpaA>
    <xmx:QlbBaX--JnGtvdQwzPLhQX5-3pp5hPEKeJ-zyh22RxKOLS_fxsAivg>
    <xmx:QlbBaYAhUVnYxgCg626mWlXO2IFRF8hPivVr0vmM8oWcGcS_Limsgg>
    <xmx:QlbBaUL2OKkxiBH6jhd-k4E2jspofflB6fSIfrINdITbYUFUyH8WRQ>
    <xmx:QlbBaRj5vUHd80smT8I8QdNji0bmL72APW9dowjxFXOjqQe1LlPiL9WJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b9f79ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:02:59 +0100
Subject: [PATCH v2 08/12] builtin/fsck: stop using `the_repository` when
 checking reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-8-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We implicitly rely on `the_repository` when checking reflogs. Refactor
this to instead inject the repository via the callback payload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index efc60862ae..be9dbba2da 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -468,13 +468,14 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 
 static int default_refs;
 
-static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
-	timestamp_t timestamp)
+static void fsck_handle_reflog_oid(struct repository *repo,
+				   const char *refname, struct object_id *oid,
+				   timestamp_t timestamp)
 {
 	struct object *obj;
 
 	if (!is_null_oid(oid)) {
-		obj = lookup_object(the_repository, oid);
+		obj = lookup_object(repo, oid);
 		if (obj && (obj->flags & HAS_OBJ)) {
 			if (timestamp)
 				fsck_put_object_name(&fsck_walk_options, oid,
@@ -482,7 +483,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 						     refname, timestamp);
 			obj->flags |= USED;
 			mark_object_reachable(obj);
-		} else if (!is_promisor_object(the_repository, oid)) {
+		} else if (!is_promisor_object(repo, oid)) {
 			error(_("%s: invalid reflog entry %s"),
 			      refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
@@ -494,8 +495,10 @@ static int fsck_handle_reflog_ent(const char *refname,
 				  struct object_id *ooid, struct object_id *noid,
 				  const char *email UNUSED,
 				  timestamp_t timestamp, int tz UNUSED,
-				  const char *message UNUSED, void *cb_data UNUSED)
+				  const char *message UNUSED, void *cb_data)
 {
+	struct repository *repo = cb_data;
+
 	if (now && timestamp > now)
 		return 0;
 
@@ -503,19 +506,20 @@ static int fsck_handle_reflog_ent(const char *refname,
 		fprintf_ln(stderr, _("Checking reflog %s->%s"),
 			   oid_to_hex(ooid), oid_to_hex(noid));
 
-	fsck_handle_reflog_oid(refname, ooid, 0);
-	fsck_handle_reflog_oid(refname, noid, timestamp);
+	fsck_handle_reflog_oid(repo, refname, ooid, 0);
+	fsck_handle_reflog_oid(repo, refname, noid, timestamp);
 	return 0;
 }
 
 static int fsck_handle_reflog(const char *logname, void *cb_data)
 {
 	struct strbuf refname = STRBUF_INIT;
+	struct worktree *wt = cb_data;
 
-	strbuf_worktree_ref(cb_data, &refname, logname);
-	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+	strbuf_worktree_ref(wt, &refname, logname);
+	refs_for_each_reflog_ent(get_main_ref_store(wt->repo),
 				 refname.buf, fsck_handle_reflog_ent,
-				 NULL);
+				 wt->repo);
 	strbuf_release(&refname);
 	return 0;
 }

-- 
2.53.0.1118.gaef5881109.dirty

