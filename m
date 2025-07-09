Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168A290D8E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059857; cv=none; b=d5kAFflsKiEdP/J20efKqnPGQvkDxCCZvaYEf+ZNujtTixM/pSTz29I2DEYJcufzyNGZ5DnNBEvExejYoznqQA56ugTYLPJ/e0/NFTk6LeuqEhHue5df6YQvXTx6jjJN+KfVmx3bgHDn9eQ41vKFV/wS/XUM8/8J4cWUHZiEfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059857; c=relaxed/simple;
	bh=ko7dPhnhM7Gx8yEPouYxVNlIXoyV7iqFR7QIM5GGsqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSOKRrW4oWREFyUmgJRyn1ZDuRAR2rx70a7/Gp8lKJ446lT89N3RVcM73ekf7DraanLQcZj7itNh5schJG8tyJHqlWXUAWB7gaEf58KIa1Q9YprZf8zlABlUDHIqlQnmEmrFp9N8YAkmrYNZSudJI+Gpzf+V2F/6p33HvXO5emU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xqdA5jly; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ly8ebIB+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xqdA5jly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ly8ebIB+"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 953261400330
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 09 Jul 2025 07:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059855;
	 x=1752146255; bh=x+ZK2anTLFvjCia5RoY91Upsobs1rbtJIE0KoDVV3EU=; b=
	xqdA5jlykCo0c3Bkt3YEbRtFSZedFjQfQ2UuNxeqMW1m3g5Tr9jNFjaLnt5X/Gjw
	pBRFT7JD3rW55RZAyvIV1cAmlh7z5HQ1IhScy/8Xo+o+f5VEZPljRKIjYaMooItJ
	0G75rN34BDyMYGtH1NUlDB2jp4hX4qNQkIFJy8V5rhgNiPopzhaHcWEvBe0MYB82
	6dUM70b4O0warUjc1c3M/tpbbS/6RnBRvyNY+ROeql4RyJWC+aLN5y+eibQ9rNla
	vUFF0nEFAjYhQoRchsV4SckD+a6v2mDoAbnErfITJpXG5oVKBh8XnC2A0fpLI0Zg
	u/QntqZsyAP4MrMup94YOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059855; x=
	1752146255; bh=x+ZK2anTLFvjCia5RoY91Upsobs1rbtJIE0KoDVV3EU=; b=L
	y8ebIB+0LCCpA4CKq6dy59h0sY8FDMpuS/2mdquQGey62slyVvFJEZpPIOpQtXY3
	e9z32CKrgzAMZkCkQQrZiA3UEt7rc7ItEWobXZ++hs9SzIrf0qWN8eLxMFpizAks
	b/8p+niz5MBd1DO4/RIE1iYTATu4MlgF+kL199ukWgHK/HHyperYXC/8R9UR8hG1
	bSyJglTVWF9IzaxFTywJOChtv1ZBIUpenJ9pdJuVbLSKraaXg2Ki80AHxjs7jdJz
	BSf5FeYglNaBM3El328SkOqBtPh3n287uMHg7hGzMnBAADlH/DD9pYwnXmC6fXmR
	OMsjsV6orMhEf6ulUq3bw==
X-ME-Sender: <xms:z09uaD-rni2sEu_taz1Q-CYq-IQ7iNBVgqBtQ0yIeI9nKl3CLHjTtw>
    <xme:z09uaBvvn_bq0OC5jb52CFk9-2-_hR_7pGzvCnOfdsABJJiETAsYnupSPEIlpexmQ
    u7JBRRvWsP8sbiy1g>
X-ME-Received: <xmr:z09uaKaRRPK5F1X686Q9Dh48uQvokZKFAtkMyxKkEC5qPgjeKsRM3eyt3VyiA3UbonD2qfRqKm4MKkREJvOJeHWZHuunwEBG_E1rdGYLQUs2MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:z09uaBodOpwHdp_zjooQ8knSLL3vAn8UidGQVh5BA6XVZtUKcOCv7g>
    <xmx:z09uaP-shtyeaj93uKC_F0nsOCljBmsEVvMhIJEe7YD3Xb1Z64ZScg>
    <xmx:z09uaA_M15CAEH83fiQD5Jw5STgvzBufrGSn4ULG7Q-K__JU5U9ZxQ>
    <xmx:z09uaOv7noXl-nZPHpr56qn4WZB8S7_Va9wpInxyu55LGu93Y6JGHw>
    <xmx:z09uaIm87uCoY3PmajEusiBnheNyhZVfzthhyXBPi5XeMjoWUsA83Sbx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12b79788 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:15 +0200
Subject: [PATCH 05/19] object-file: get rid of `the_repository` when
 freshening objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-5-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We implicitly depend on `the_repository` when freshening either loose or
packed objects. Refactor these functions to instead accept an object
database as input so that we can get rid of the global dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index 9e17e608f78..3453989b7e3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -893,23 +893,21 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
-static int freshen_loose_object(const struct object_id *oid)
+static int freshen_loose_object(struct object_database *odb,
+				const struct object_id *oid)
 {
-	struct odb_source *source;
-
-	odb_prepare_alternates(the_repository->objects);
-	for (source = the_repository->objects->sources; source; source = source->next) {
+	odb_prepare_alternates(odb);
+	for (struct odb_source *source = odb->sources; source; source = source->next)
 		if (check_and_freshen_source(source, oid, 1))
 			return 1;
-	}
-
 	return 0;
 }
 
-static int freshen_packed_object(const struct object_id *oid)
+static int freshen_packed_object(struct object_database *odb,
+				 const struct object_id *oid)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(the_repository, oid, &e))
+	if (!find_pack_entry(odb->repo, oid, &e))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
@@ -999,7 +997,8 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		die(_("deflateEnd on stream object failed (%d)"), ret);
 	close_loose_object(fd, tmp_file.buf);
 
-	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
+	if (freshen_packed_object(the_repository->objects, oid) ||
+	    freshen_loose_object(the_repository->objects, oid)) {
 		unlink_or_warn(tmp_file.buf);
 		goto cleanup;
 	}
@@ -1062,7 +1061,8 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
-	if (freshen_packed_object(oid) || freshen_loose_object(oid))
+	if (freshen_packed_object(repo->objects, oid) ||
+	    freshen_loose_object(repo->objects, oid))
 		return 0;
 	if (write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;

-- 
2.50.1.327.g047016eb4a.dirty

