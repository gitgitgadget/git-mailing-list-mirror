Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65676148850
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619021; cv=none; b=izcHsUEFbAtEzcZ+HmDJAJDL2WFM23OAZ2VjTOn6DU6rxY2Gbg2HiRWNKKRpnCkHf6EdS4Ekdjs9z+qIysl6UPPN7QEnd2K5mbgwrAUMNKeadYOsOqBUiQW1sLglU9owQiMON4lNHmfv1fXnwATOzTF84Qk2rsk7EiXI8Epoh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619021; c=relaxed/simple;
	bh=Ajh7/AT8XhltXVJ6+sJwOkchVi08jH5C61Fi5IduNEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7QcodcTMvboSogMTAK7yrApyUDX5XW/IciVzGSBFUjYEkSwdINzVP78PwROw2IRI7Q8sjtWLoshH35nvwnAMgHTktmLD2BlRHAapRdjG0/TD3m6PNp5pRI0wl2ksTYevjGDLqqZmuCsPE6NUl+872qXkgGpO/2Xfd/ngqWYAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QqGizliQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VImbD+/4; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QqGizliQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VImbD+/4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C89FF7A00FF;
	Mon,  5 Jan 2026 08:16:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 05 Jan 2026 08:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767619017;
	 x=1767705417; bh=rFPzpokg/R9M2bA+MwmWxx5pxzfkUvywDL7HVHc26Vo=; b=
	QqGizliQcGPp5DJ1r1dTaWc2jT0QYs+gZAfBSFU5DXG+g/dfU7Tk37HFyRaWqZRO
	2qSuqXpcVCys1jGPMbZKBOLu5KyThsNYJW2i6SEUWms3Lcg7d8XnID0m9yKGZ8Dk
	JUWKWsSCrvTvFw8Pqv2cNP0u4/vPnWkSj2T7bNUsYwse/P4wYzd73OW4P9HT/uM3
	yKoo2rwIQC0Gx5tpdiYBm23SFKfAlTzyXONybzn8aUlot9DNMasfesUdhGrItM3O
	N4YMuVeJZNEuXT078rnXmY+sJ2wcmqkpyMQfGO28oozVAF4dIK88B7i7xdIAE+Mv
	GggAS3V9LS6sj1KxQuOuag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767619017; x=
	1767705417; bh=rFPzpokg/R9M2bA+MwmWxx5pxzfkUvywDL7HVHc26Vo=; b=V
	ImbD+/4qWdTNEO0X/crqciDMk9xBcNuw1zF8RyihM2cw/8DTi0Mp4CScB+rH4bEq
	5VU7m+hmFwXfzkL8NxwasBOEb5mW5rOUTQV/CPuYhqM5L5Cmhrtm0bOr0MN/ENnF
	mNCuFN4jcF8yaUH511er4huegmgmjphHQ5tddLQs0GrqHXkZXzVhDy7eeRnPzjXl
	TyyMy91i7nALtm0ddbDiflMVyYm8VBUx+mDnrYaJoawztzlMeqQBUCoJ6O/1O1sa
	Xc5/djTmplxKgjoXP7Gpa+0JSGfSks5e1fJfiGl25ueRvG8eIPpNQa7zihGNLTH+
	m2LlrB2h1SqwLpQIc5Zwg==
X-ME-Sender: <xms:yblbaQlV8yWFM2g2W0buqsTY_Eh6mNM4Hiv-d9GiwtYWciy8hdjDeQ>
    <xme:yblbaV3q4NHTsKqbDA0M2vJM9ZwGviZpH9i7wvFeKPly54oX-rFwbh4Zh82_N15gU
    CZL9jE1dPTNvFrUgHpUurJtUcJqSgn4FgrbNsGmmpXv5mbWu-pT>
X-ME-Received: <xmr:yblbacRNWFeRt5MH-6mm_hNKke8nhLSMw1Fau3QVxQfdPNWI9bx3XrCFFydasEolac7CnLG6BezcJBRPn22g_Je7k92kxkIXDl2B0eiS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:yblbaXt9AVeIY9ImhC0dEeHoWG33tDck1ntkajxM6hWAUyXqZvh_Mg>
    <xmx:yblbaRZtiaOmeC1D8h0WAdp_n356iMDeuWSw8NCPZEQE3cnYf3A2Bw>
    <xmx:yblbacshZVvkSJb_PNQ7xywTL7L3J60jIXxH17qFwgs2PZGmfrkd5g>
    <xmx:yblbaTF4JNMj51nextfbP5-yzBpGAvdQssqpZHjM3sBVQ-oD8kw6fQ>
    <xmx:yblbaaueHbF_INOpVulmxvUR9QCQla9GO3Nf5S8mYv92RxfHMRi2ebpa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 08:16:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e82fba81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 13:16:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 Jan 2026 14:16:43 +0100
Subject: [PATCH 3/5] repack-promisor: extract function to finalize
 repacking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pks-geometric-repack-with-promisors-v1-3-c4660573437e@pks.im>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
In-Reply-To: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We're about to add a second caller that wants to finalize repacking of
promisor objects. Split out the function which does this to prepare for
that.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repack-promisor.c | 69 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/repack-promisor.c b/repack-promisor.c
index ee6e0669f6..125038d92e 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -34,39 +34,17 @@ static int write_oid(const struct object_id *oid,
 	return 0;
 }
 
-void repack_promisor_objects(struct repository *repo,
-			     const struct pack_objects_args *args,
-			     struct string_list *names, const char *packtmp)
+static void finish_repacking_promisor_objects(struct repository *repo,
+					      struct child_process *cmd,
+					      struct string_list *names,
+					      const char *packtmp)
 {
-	struct write_oid_context ctx;
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	FILE *out;
 	struct strbuf line = STRBUF_INIT;
+	FILE *out;
 
-	prepare_pack_objects(&cmd, args, packtmp);
-	cmd.in = -1;
-
-	/*
-	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
-	 * hints may result in suboptimal deltas in the resulting pack. See if
-	 * the OIDs can be sent with fake paths such that pack-objects can use a
-	 * {type -> existing pack order} ordering when computing deltas instead
-	 * of a {type -> size} ordering, which may produce better deltas.
-	 */
-	ctx.cmd = &cmd;
-	ctx.algop = repo->hash_algo;
-	for_each_packed_object(repo, write_oid, &ctx,
-			       FOR_EACH_OBJECT_PROMISOR_ONLY);
-
-	if (cmd.in == -1) {
-		/* No packed objects; cmd was never started */
-		child_process_clear(&cmd);
-		return;
-	}
-
-	close(cmd.in);
+	close(cmd->in);
 
-	out = xfdopen(cmd.out, "r");
+	out = xfdopen(cmd->out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		struct string_list_item *item;
 		char *promisor_name;
@@ -96,7 +74,38 @@ void repack_promisor_objects(struct repository *repo,
 	}
 
 	fclose(out);
-	if (finish_command(&cmd))
+	if (finish_command(cmd))
 		die(_("could not finish pack-objects to repack promisor objects"));
 	strbuf_release(&line);
 }
+
+void repack_promisor_objects(struct repository *repo,
+			     const struct pack_objects_args *args,
+			     struct string_list *names, const char *packtmp)
+{
+	struct write_oid_context ctx;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	prepare_pack_objects(&cmd, args, packtmp);
+	cmd.in = -1;
+
+	/*
+	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
+	 * hints may result in suboptimal deltas in the resulting pack. See if
+	 * the OIDs can be sent with fake paths such that pack-objects can use a
+	 * {type -> existing pack order} ordering when computing deltas instead
+	 * of a {type -> size} ordering, which may produce better deltas.
+	 */
+	ctx.cmd = &cmd;
+	ctx.algop = repo->hash_algo;
+	for_each_packed_object(repo, write_oid, &ctx,
+			       FOR_EACH_OBJECT_PROMISOR_ONLY);
+
+	if (cmd.in == -1) {
+		/* No packed objects; cmd was never started */
+		child_process_clear(&cmd);
+		return;
+	}
+
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+}

-- 
2.52.0.508.g883dcfc63e.dirty

