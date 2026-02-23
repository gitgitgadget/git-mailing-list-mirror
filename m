Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004230C37A
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863511; cv=none; b=lbMHSA9omX6ylG4MIQH34m1LnU/m6z9zMj1qatoxiDfZT1cZG33fl0RtQ96ewTZ2avCInpQE/A94C6CW5q1+UPFt5qWpC+Pbe0uNQy9hiFtBEQyrgia2/0EReQ6qunzovwRTNlEXgntpWFCUSO70cycEpN3fihAvcb6j5BOY3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863511; c=relaxed/simple;
	bh=flPEXSL+5OiWl+/Ps2dTURTS0wZuMXPP41AVhRWx8W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dEcsiRqMPE+w7V2FaKJ+vpU07qF4voeGQGR8BsF1EAd1fVJFeG+Im1v7PqMFSseBCP522e+O63zEhiKy4/i+ZSEdBoMpVz+F0Z7sGn0ujC9eqFxtYsPbs12me8MJBLJNX0LmhYB3UCOMic/8NPeRrygsF209GhPPuS3rUBh67OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CfeDf/0E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qt18x3FL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CfeDf/0E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qt18x3FL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D21AEC05A7
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 11:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863508;
	 x=1771949908; bh=Bn1nRTDpoNgjO7/g0eKbU+mafbr4PCpHfw8h+g1iA7E=; b=
	CfeDf/0E2Y3ppya1ByRCFKt1EU9vrrjIU5kRyedo+QPHtkz4OLdWUKE1kqIKMVuv
	MeoyHeveyfV0hMabqOGnGrmDgrAuvBP5Hi0jpZ1kDJULCpA2rEilcxvK70XdTKko
	dLVdeAo6IGFW558lnTvUSaue5wuOjKct2E3GSo9vfyHpEye26aV6RNTdRxgZNJhZ
	E6tfSjESXkz0eVWszC52qMHGNb1m8qI4ZMGqvefHt80WmZ/2r/uGRW97h2WzS808
	etBplviVZNPLsxpjpC7H/2nnlSqCYTXqgVEOEKykxW+ecFVEpuBi9odoHBu1cjWT
	hKBEMBdzy2J8Dxs8o0ATxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863508; x=
	1771949908; bh=Bn1nRTDpoNgjO7/g0eKbU+mafbr4PCpHfw8h+g1iA7E=; b=q
	t18x3FLC8i80pdWIWvXdm5xB106goTVVIa7R3uo/Zs7KvPzXP44J4JHZgOrWQn0Z
	UXS0r8CihCTw1Gd+KaokQ0Pu8FTBu0saF7lCBj0aLXMQHN52Oo6NNz1Tj8WhHyqI
	L3WPNFpAkDOBueD7pxwwErgaOgC8tybXLSV2M+AGZsqXQgQ5MoGIOBZUl+XF5jrp
	4Q+t1XbPnaEXIZHscvmaNY6EK2HdLOjZLQDSUkUm/fhqOe1CbiYe44Bg09zQ6oxN
	kgXyuKYLl5dYBOQtNBMcAjaP1CajD7rXNA/QxGDliMfEfUcdiPWtt37D1OLiTpWM
	bIetV9ReRHztoimamxf6Q==
X-ME-Sender: <xms:1H2cacLSqIUFPL97OLzFv7YVZZWbJhPB1E2-3N79WK2mSJXiST7niQ>
    <xme:1H2caTEdtMNdCRfSYrC3BYnhV9sNJMWvXiIbdHnUqIONGWimtg-H9Kpa_Nl7zZgf2
    ZHpemL9LkBhWPq5jB_abWM_kxbrRkvb8Xu-k64j34O0eXmFb7cE>
X-ME-Received: <xmr:1H2caSXfOAkBTGN3oqOU1rUDgDzmzQzaPDuw82Wv55pHvs1QfK1AHrK-e5so0m5rDfL8ffQX3eM7gtVPZiURgQ0p2V1FK50QXBiUJW7mYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:1H2caejBQzqk-pK8oNp_1KwtOiJikw7gOI2vRDyIOu4aqygtLpbAaA>
    <xmx:1H2caTT1FEKccu5qljSrrPDWeLAggNm3JSaTafgkwYl13dRALwlW_A>
    <xmx:1H2caREM1NzcEWIAbU6sFwrX6R5MsSN6WE7hVdhcONbpjYtYsiaqfw>
    <xmx:1H2cablyy3UmrkzaCXWgNykRkLkgF_ljk5NvxDnu52sbdVmd1HjRew>
    <xmx:1H2caVpbzJFesW-lcErkEshHNLkQotWK_GAo494OIbF2qSoR1xL4NZUk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 770563ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:17:59 +0100
Subject: [PATCH 08/17] odb/source: make `close()` function pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-8-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              |  6 ++----
 odb/source-files.c |  7 +++++++
 odb/source.h       | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/odb.c b/odb.c
index 2cf6a53dc3..f7487eb0df 100644
--- a/odb.c
+++ b/odb.c
@@ -1062,10 +1062,8 @@ struct object_database *odb_new(struct repository *repo,
 void odb_close(struct object_database *o)
 {
 	struct odb_source *source;
-	for (source = o->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		packfile_store_close(files->packed);
-	}
+	for (source = o->sources; source; source = source->next)
+		odb_source_close(source);
 	close_commit_graph(o);
 }
 
diff --git a/odb/source-files.c b/odb/source-files.c
index d0f7ee072e..20a24f524a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -28,6 +28,12 @@ static void odb_source_files_free(struct odb_source *source)
 	free(files);
 }
 
+static void odb_source_files_close(struct odb_source *source)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	packfile_store_close(files->packed);
+}
+
 static void odb_source_files_reprepare(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
@@ -47,6 +53,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->packed = packfile_store_new(&files->base);
 
 	files->base.free = odb_source_files_free;
+	files->base.close = odb_source_files_close;
 	files->base.reprepare = odb_source_files_reprepare;
 
 	/*
diff --git a/odb/source.h b/odb/source.h
index 2f8132f9e1..7af4900ab4 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -59,6 +59,14 @@ struct odb_source {
 	 */
 	void (*free)(struct odb_source *source);
 
+	/*
+	 * This callback is expected to close any open resources, like for
+	 * example file descriptors or connections. The source is expected to
+	 * still be usable after it has been closed. Closed resources may need
+	 * to be reopened in that case.
+	 */
+	void (*close)(struct odb_source *source);
+
 	/*
 	 * This callback is expected to clear underlying caches of the object
 	 * database source. The function is called when the repository has for
@@ -104,6 +112,16 @@ void odb_source_free(struct odb_source *source);
  */
 void odb_source_release(struct odb_source *source);
 
+/*
+ * Close the object database source without releasing he underlying data. The
+ * source can still be used going forward, but it first needs to be reopened.
+ * This can be useful to reduce resource usage.
+ */
+static inline void odb_source_close(struct odb_source *source)
+{
+	source->close(source);
+}
+
 /*
  * Reprepare the object database source and clear any caches. Depending on the
  * backend used this may have the effect that concurrently-written objects

-- 
2.53.0.536.g309c995771.dirty

