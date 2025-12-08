Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715822D9EC2
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181093; cv=none; b=h7l5jgxcsx6A2FX+9Ulms56/Kh5w/gr/dNj3RVqtIEfowoRUOdMePRB0A3SZtksnOliE449qLLhnd314w4y5aBNu45zTAJcaB1xwh7gkfbCL16u4TfWJ5xu9rYmkDCKq9X8PiDutPYJO/35WPufVvjtVTeJgyakebgeg38GEQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181093; c=relaxed/simple;
	bh=lrgoNJSqmbV5YnqWKgxqczhV7fwYrFsBmoYNiPeWW9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKF5sJgzX9DQRY0Wlc3HWePhbophWCiVZv/NURuiXWO2ey5Ha7sXbFR7tFrk9KwucaKA2PfdbDl6CKrViCBroR4hjs2BrRH2nHO30LdS1qx32v87KQg2RmdnaGb69J+Rak4uXhi2zNYsgk4nXJ56xa0zjP4UtfbVC12VhlGx2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m29dibGN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yTCbCQAX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m29dibGN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yTCbCQAX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB48D7A01E0
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 03:04:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 03:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765181089;
	 x=1765267489; bh=mOwsT+jCI2eomj5V0NLca3pMsMVLks3KzI9H8Petou8=; b=
	m29dibGN97DQNY6YHxoroe6R7yrUh577x8skqzYxwFpF1Cun5DQoRFdxbBZaSfYt
	JAfUlWPFbT69O4yK7t/MVNFG2TMP4pcMKgw/JPBu0NygmUA8V+TQmCIH5UHuT+8E
	orG/BFjkORqpyb+/Ia+pGssjGPcjB4YosN9xnHqDKL9ExEcM/lhz2FHYbqSEi1EY
	sdTAQB7JTrY+HC7VYATi9cPJ0mBSxHXXUTQ6B08QUAWrTWhH6t6hmrga/u1Y6o/7
	QMHzrnNABHuRQnQzvep11ShMSKSeITQWwBrXsFnYpR4BQY9Aeu6vPucd6BxO3939
	UdIlZkELAhppCV+LMt0s0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765181089; x=
	1765267489; bh=mOwsT+jCI2eomj5V0NLca3pMsMVLks3KzI9H8Petou8=; b=y
	TCbCQAXg3PD4w76jloAKzMMQT5pcz6a86hKWJCeIpJPqmJnbrMalB6nSuEb4CEFl
	vzQWCw3uogcHECo97MGwTgw5NvZfv3cq/7zqvP9QSmf3ZoIOr5A9lco/l8HVBsgY
	OlVLm458r0z8kciWEbweyL+6ydwCa6yLVZ67bUapp6PjSCiczKZyaWXQw603Xx+7
	2hh/mNByx5ehYl7j/qcZEvuoCe7yLSBpvYrlTZsgkyjTgkDK3qTmAdc1yKDLXpOb
	gFVKS6P+nwxljU+dYfiNoSMx6+9xADt97GwdAdI5d7893CzCEI2KqCuPpdCU59Jb
	tXwIAfICq8g2Hh9TRm1tw==
X-ME-Sender: <xms:oYY2aZZqALlhj9a3Jq1L76HqLAhyCbuAqHMUmeCl4UWAE9hhcP3eAQ>
    <xme:oYY2aXU62CHC1lUh7a0akSAfSO4hiKv-fWTpj8qaas8naAaAmSGaZSBc7Jy-KgcT2
    p71sbkJwhdr9Zixt4ceNSzSgq2s6X7lzTgKdEIRweIwWXGlpCF8>
X-ME-Received: <xmr:oYY2aRltlIMyHcgjduXyT5vE1jrxocz_ugqM3xFDo-BdH7d4NmrCg1N9tvFNu37B2gklcCdQ1jDc8N0wATW35Wbt9lSUapo_-i4s6KQgWbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:oYY2acxquAmPbpVnTNjoJVRVKJSrbJUBsGj4hrpbHbbMZLf26_iMxg>
    <xmx:oYY2aUi2rdDRcaBZ41VhpwAQwwUhZnI1TDHLP-P46dCHZcnRovbAJw>
    <xmx:oYY2aZU5xidQXl39w6iXDhL0qw89tq9R8zw9WgPfIKlBtGdFFupa-Q>
    <xmx:oYY2ae1rfWEEbymCyj8z1zMZ7skXBHD6DXUiyNAoCeKOVji0lZxAUQ>
    <xmx:oYY2aT4FDS_IntdwKO43ecPEa5i1S8htFhFLye4gv0g3tiqnLJ1MAemB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 8 Dec 2025 03:04:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e612cbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 8 Dec 2025 08:04:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 09:04:22 +0100
Subject: [PATCH 5/8] odb: remove mutual recursion when parsing alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-b4-pks-odb-alternates-via-source-v1-5-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When adding an alternative object database source we not only have to
consider the added source itself, but we also have to add _its_ sources
to our database. We implement this via mutual recursion:

  1. We first call `link_alt_odb_entries()`.

  2. `link_alt_odb_entries()` calls `parse_alternates()`.

  3. We then add each parsed alternate via `odb_add_source()`.

  4. `odb_add_source()` calls `link_alt_odb_entries()` again.

This flow is somewhat hard to follow, but more importantly it means that
parsing of alternates is somewhat tied to the recursive behaviour.

Refactor the function to remove the mutual recursion between adding
sources and parsing alternates. The parsing step thus becomes completely
oblivious to the fact that there is recursive behaviour going on at all.
Instead, the recursion is handled exclusively by `odb_add_source()`,
which now recurses with itself.

This refactoring allows us to move parsing of alternates into object
database sources in a subsequent step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 60 +++++++++++++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/odb.c b/odb.c
index 94cff19221..27f3c8e263 100644
--- a/odb.c
+++ b/odb.c
@@ -147,9 +147,8 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
  * of the object ID, an extra slash for the first level indirection, and
  * the terminating NUL.
  */
-static void read_info_alternates(struct object_database *odb,
-				 const char *relative_base,
-				 int depth);
+static void read_info_alternates(const char *relative_base,
+				 struct strvec *out);
 
 static struct odb_source *odb_source_new(struct object_database *odb,
 					 const char *path,
@@ -171,6 +170,7 @@ static struct odb_source *odb_add_source(struct object_database *odb,
 					 int depth)
 {
 	struct odb_source *alternate = NULL;
+	struct strvec sources = STRVEC_INIT;
 	khiter_t pos;
 	int ret;
 
@@ -189,9 +189,17 @@ static struct odb_source *odb_add_source(struct object_database *odb,
 	kh_value(odb->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */
-	read_info_alternates(odb, alternate->path, depth + 1);
+	read_info_alternates(alternate->path, &sources);
+	if (sources.nr && depth + 1 > 5) {
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
+		      source);
+	} else {
+		for (size_t i = 0; i < sources.nr; i++)
+			odb_add_source(odb, sources.v[i], depth + 1);
+	}
 
  error:
+	strvec_clear(&sources);
 	return alternate;
 }
 
@@ -203,6 +211,9 @@ static void parse_alternates(const char *string,
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 
+	if (!string || !*string)
+		return;
+
 	while (*string) {
 		const char *end;
 
@@ -259,34 +270,11 @@ static void parse_alternates(const char *string,
 	strbuf_release(&buf);
 }
 
-static void link_alt_odb_entries(struct object_database *odb, const char *alt,
-				 int sep, const char *relative_base, int depth)
+static void read_info_alternates(const char *relative_base,
+				 struct strvec *out)
 {
-	struct strvec alternates = STRVEC_INIT;
-
-	if (!alt || !*alt)
-		return;
-
-	if (depth > 5) {
-		error(_("%s: ignoring alternate object stores, nesting too deep"),
-				relative_base);
-		return;
-	}
-
-	parse_alternates(alt, sep, relative_base, &alternates);
-
-	for (size_t i = 0; i < alternates.nr; i++)
-		odb_add_source(odb, alternates.v[i], depth);
-
-	strvec_clear(&alternates);
-}
-
-static void read_info_alternates(struct object_database *odb,
-				 const char *relative_base,
-				 int depth)
-{
-	char *path;
 	struct strbuf buf = STRBUF_INIT;
+	char *path;
 
 	path = xstrfmt("%s/info/alternates", relative_base);
 	if (strbuf_read_file(&buf, path, 1024) < 0) {
@@ -294,8 +282,8 @@ static void read_info_alternates(struct object_database *odb,
 		free(path);
 		return;
 	}
+	parse_alternates(buf.buf, '\n', relative_base, out);
 
-	link_alt_odb_entries(odb, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -622,13 +610,19 @@ int odb_for_each_alternate(struct object_database *odb,
 
 void odb_prepare_alternates(struct object_database *odb)
 {
+	struct strvec sources = STRVEC_INIT;
+
 	if (odb->loaded_alternates)
 		return;
 
-	link_alt_odb_entries(odb, odb->alternate_db, PATH_SEP, NULL, 0);
+	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
+	read_info_alternates(odb->sources->path, &sources);
+	for (size_t i = 0; i < sources.nr; i++)
+		odb_add_source(odb, sources.v[i], 0);
 
-	read_info_alternates(odb, odb->sources->path, 0);
 	odb->loaded_alternates = 1;
+
+	strvec_clear(&sources);
 }
 
 int odb_has_alternates(struct object_database *odb)

-- 
2.52.0.270.g3f4935d65f.dirty

