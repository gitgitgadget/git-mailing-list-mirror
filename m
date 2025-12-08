Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0D2D7DC7
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181099; cv=none; b=HkwkRLKsyV7eSffAJ0g0SMTxuNQ8Cj496yTvZKuI+MNI0UXSvfqj/uyQSoLLYyuZXc2VS/HxLOjozmeqyFFXYu5hsO+Di1/tt6r9RSaFN6F03BDQOMhYGqH5wvoaWzObPtVmB5n3L9yMJooTi8yIHBfS/verLrEVxfnHN1o1i3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181099; c=relaxed/simple;
	bh=aSih4icMWia/jTnsw864sZv/5J55223c1slk4ptvsZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQcusmPj5tfv4Y89FknyzsKUrgDSVYMD0sIq1BMJO9EgWLpCGoO18GqpVu3EuWijTBdrAqjY4+GNXkZtb8BOIB67H/Y9szLpbv35k7YxY5dG+5jpiL+Ehf6x9UFBHEzGGdlyhZQKXrI67aRgc6AOFFaE7cLa+r+FLae6tH0rfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QZfF+2pi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YYxC6xYj; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QZfF+2pi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYxC6xYj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83D977A01E0
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 03:04:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 08 Dec 2025 03:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765181097;
	 x=1765267497; bh=Pv3d/vgcvfyeHCrDrpWEzwxs6UqaaSuctHTipbeAls0=; b=
	QZfF+2pieYX29l0sXdpnzSx2lhGLpVfoQvuSENX9B1M5crFK4vf04TLS0PYnV8BH
	WkNz1ck8FFJ4CJwgFeDo8/Azdvdvm6jbL/DQVIdehNFAQKyDtYi3YImI8gB7B9bE
	Gsjrh1Z11DewPdzydshdb0IYw4nfEc3b7sE2zMRKchUhof8xE78m0IYOevzZZLQH
	uu/Wa0sFCiPdj+JbzZz/Pl85rFMQ+zcB9tcTjrq2AfwoykMN6hAZ4QHwTOUuIwVh
	CzUfGAfsX4SerV5b5I0eyhDritRS+mv0C3mSwYVNnC7rJpMLHn+wbIS8y98Xa6fT
	+OnRbydMzz+2ibtr9Dbfwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765181097; x=
	1765267497; bh=Pv3d/vgcvfyeHCrDrpWEzwxs6UqaaSuctHTipbeAls0=; b=Y
	YxC6xYjHq5+gChVLOs/Zv7kSAOVFV6ZMHcI56gURAAzqSEgtRHGbrwiAtTfsor3z
	u2n7jMqWmr9YCje8Y5Jwm2oO2HVDS+NvKzx6oD1noVfzWm2MJ7u1FW9Pxl66aFN+
	/M+RjCgBSikUNagqLDsw94ZlRXbXMcl+NkG2af5EmClPMN/u2IULGksh97x54moz
	egJDuGhDy3+bQE3mhrdMjRzU6sVXiha9kE5pVkEiSEhegDW866hdrpKsVlo/axnG
	oF+SX+cbcXKvjOf/bVPOuXRkpx+hKViAkCs3qga6llSX1hEbpHLmjrv5S+UymCsW
	F2BFpaMH+bhYisW2OO6jA==
X-ME-Sender: <xms:qYY2aUxavphCZEGzVYYxUVdO58FN28DleDIODpp-UxQQgbdF2Xnjmw>
    <xme:qYY2afPO3Npos96J38OYHC-iOQe_2PMql13ZhE1VOtn99hRid8nxJkegGkjhnshkS
    9chTPZzAbCoNeyQSTNqL77X_I1Aes2Yt9raszcvwEBMa21nSOR7>
X-ME-Received: <xmr:qYY2ab_aGJA5XhXR7IFsMpKNeQigNbeVmaCBxxzwl4tBqCQK7cxdaY8weV-h7WPU8ItZL1PgnobRq0MF2IjTs9N1HKdHG3SXHTYNZRguwOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:qYY2aXo-pmHZojaePjKHESRmx_u-E16eRMc7_JKRHvzBWxZKlp7esQ>
    <xmx:qYY2aV4rh_WEO-mXqKNW6RfPvgUQuj77BAMfZtcE4DMPL_HHLq6BKg>
    <xmx:qYY2afPX1jvdGngUou5jAHS4ZEfgsuhaKDTptQBg2rDNd8u2zHIFzA>
    <xmx:qYY2afNNgV3R-sse--72KoJJuXRJOOYj2700Ov-ZW1t-PshFCYEC_w>
    <xmx:qYY2aWwg74hBPL4vCFOzomtSekNGS6gxCmbsXwDAkPASCxPY3Z0yieH7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 8 Dec 2025 03:04:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d33757d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 8 Dec 2025 08:04:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 09:04:24 +0100
Subject: [PATCH 7/8] odb: read alternates via sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-b4-pks-odb-alternates-via-source-v1-7-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Adapt how we read alternates so that the interface is structured around
the object database source we're reading from. This will eventually
allow us to abstract away this behaviour with pluggable object databases
so that every format can have its own mechanism for listing alternates.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/odb.c b/odb.c
index 1d83a915e3..bf364fe3dd 100644
--- a/odb.c
+++ b/odb.c
@@ -199,19 +199,19 @@ static void parse_alternates(const char *string,
 	strbuf_release(&buf);
 }
 
-static void read_info_alternates(const char *relative_base,
-				 struct strvec *out)
+static void odb_source_read_alternates(struct odb_source *source,
+				       struct strvec *out)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *path;
 
-	path = xstrfmt("%s/info/alternates", relative_base);
+	path = xstrfmt("%s/info/alternates", source->path);
 	if (strbuf_read_file(&buf, path, 1024) < 0) {
 		warn_on_fopen_errors(path);
 		free(path);
 		return;
 	}
-	parse_alternates(buf.buf, '\n', relative_base, out);
+	parse_alternates(buf.buf, '\n', source->path, out);
 
 	strbuf_release(&buf);
 	free(path);
@@ -257,7 +257,7 @@ static struct odb_source *odb_add_source(struct object_database *odb,
 	kh_value(odb->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */
-	read_info_alternates(alternate->path, &sources);
+	odb_source_read_alternates(alternate, &sources);
 	if (sources.nr && depth + 1 > 5) {
 		error(_("%s: ignoring alternate object stores, nesting too deep"),
 		      source);
@@ -599,7 +599,7 @@ void odb_prepare_alternates(struct object_database *odb)
 		return;
 
 	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
-	read_info_alternates(odb->sources->path, &sources);
+	odb_source_read_alternates(odb->sources, &sources);
 	for (size_t i = 0; i < sources.nr; i++)
 		odb_add_source(odb, sources.v[i], 0);
 

-- 
2.52.0.270.g3f4935d65f.dirty

