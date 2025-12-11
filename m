Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463129E101
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445435; cv=none; b=jOV1Zru1Z/ir00U8KmbpIIDRjdvPtVngZCM5JPi1mHncmDwKedUpz9MC53N80OFb8kBLz6QLyWFeqdQBHwq0IXyXkyqPKNodJi8xCHogbD8ZOX7N4mAKhuoz4Hv2aGv+Atl0UcDcCNEyUxGTQYmVPY0QyhuE0tP5RKmkcdZkZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445435; c=relaxed/simple;
	bh=//G6A3LxWqcV3I8G7WpXoqRX7+lbLYTwZW5PV4IzHHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9Vqg13LTq2RcY39net+qIw3A7uf3iNIL1C9rmdzw+zULmLP9bte1yNFJ9/ZOZ3N+SZTo6A1EWgCHW6i2VwAc29k1LvG57Z/91g9GnOnIAinfshMuovTi4GEapPTNqRyvP5xs2N08MhvR0WlTqU1wcYWwRULrRcYmnn6G4JY4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rd29XUWD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S+HJ5vIL; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rd29XUWD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+HJ5vIL"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id CED5B1D0013B;
	Thu, 11 Dec 2025 04:30:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 11 Dec 2025 04:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445432;
	 x=1765531832; bh=Uo2LZmQUgFvIVqfzO9WD/+v21OCGLWBNsUCM66AdZdU=; b=
	Rd29XUWDhEkpb6uASwYL/p/xrG2IuRRkvNYy8Viibl9/+OtzDaVSO7Vc1DgeDsO+
	Yiyu/rB3k4w1covJsXezO7Jl8hgrjXDMI2AUpmJ6TeF2Jg34bsZROVt30874vyjI
	YKo0k07LEiHzJa48Fysk6oDHKowmw2/SyCPSIn4dEwjf1Dsalqa6MYiAcgY3t7mJ
	etZIqszet7kclkqY6Hk2PvkJFgP8P7hDtEB4lVPovSgzG8dubvAo3ETmFrOFffws
	mBV6SAWXIG28r/PBhTvyZQXNA0nvdE8eFm4V6zKy6kK0G446B1tWx8sGXWHeuWtv
	zc0vczTzvw2q4icsuP/w+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445432; x=
	1765531832; bh=Uo2LZmQUgFvIVqfzO9WD/+v21OCGLWBNsUCM66AdZdU=; b=S
	+HJ5vILveWrArI0yEbLKXI5e31Pvte6yob3KBf2mjn90+L/2HykvbVgcWyLP4avn
	4RWDFNoQ9P6BkYY+5JacJFTJDftpk8ZjQ5/GgUM89hO6D3AK3WY1RTZpGv9k2pOk
	FpwZArtxXBnvBVbLG1zP92g59rkcgeBiF8Kqf1xq3/Uf6itIfU4W4DyR9Hw0u1uu
	hkBuPwGtXz+5jb/Qd+6HXp1Q9oeiTljYc8sLc5aTW/4jI5Z9jLoqT/YSQUP/qUgw
	OqgfB0j80QZ5V2eC+SJ5XYsuufkFyl+RHZkJGIGRjAkD++pTne3mShvqv5ps2P8B
	U+sIhCItSdiRM2ksFuwyw==
X-ME-Sender: <xms:OI86aUYMbou8vdcpPtCw6vZpRUdeoouCxKi7Z3YLwjaswrbM4N6nIg>
    <xme:OI86aW0VPPNJn0iJ0Th36jv2rWwUrlSlu4SVyrsAf_-4ES5ZfiUkoZ_t4J87pe84e
    s9EKOXtfZB5iBe81_zTRFo0fmfCADwQA2gfLAz3_OGAwjJcCJbpDO0>
X-ME-Received: <xmr:OI86acUVzwZqNI9QzxkaKJVhlwzPpuuVekZSoWhIRhrIUYhXALB73hboBLAvmNwMjELvl5Eh2uh04SEOg5p2FNq5_Cr9E9P1mImhjsmePerC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:OI86aYXGIcQPjYDixlH8XZf8zOOxaYNrJj_blCgdKinuQY6VEsN4Yg>
    <xmx:OI86aTeAup2PvBBHOcslQjVQweWJBLtpAnPsdh3MBq2MWz7ng97WIQ>
    <xmx:OI86aZWC36Yp9taF1Kp6hTXS0xleQwiv6oBMDUSFU0SM6kMsAXd85w>
    <xmx:OI86aUeBq-G4cp6dEhglS31kOcnzmjA_6a6GCNMlxbd9iJfEIrY3Rw>
    <xmx:OI86aYS8UleqsY8joM1phATq7QHhoHmoAOVxfqcfrLR98Mx0yXfYfCB9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:30:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da790d4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:30:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 10:30:14 +0100
Subject: [PATCH v3 5/8] odb: remove mutual recursion when parsing
 alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-b4-pks-odb-alternates-via-source-v3-5-00e3f54d07ba@pks.im>
References: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
In-Reply-To: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.3

When adding an alternative object database source we not only have to
consider the added source itself, but we also have to add _its_ sources
to our database. We implement this via mutual recursion:

  1. We first call `link_alt_odb_entries()`.

  2. `link_alt_odb_entries()` calls `parse_alternates()`.

  3. We then add each alternate via `odb_add_alternate_recursively()`.

  4. `odb_add_alternate_recursively()` calls `link_alt_odb_entries()`
     again.

This flow is somewhat hard to follow, but more importantly it means that
parsing of alternates is somewhat tied to the recursive behaviour.

Refactor the function to remove the mutual recursion between adding
sources and parsing alternates. The parsing step thus becomes completely
oblivious to the fact that there is recursive behaviour going on at all.
The recursion is handled by `odb_add_alternate_recursively()` instead,
which now recurses with itself.

This refactoring allows us to move parsing of alternates into object
database sources in a subsequent step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 60 +++++++++++++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/odb.c b/odb.c
index 3112eab5d0..59944d4649 100644
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
@@ -171,6 +170,7 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 							int depth)
 {
 	struct odb_source *alternate = NULL;
+	struct strvec sources = STRVEC_INIT;
 	khiter_t pos;
 	int ret;
 
@@ -189,9 +189,17 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	kh_value(odb->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */
-	read_info_alternates(odb, alternate->path, depth + 1);
+	read_info_alternates(alternate->path, &sources);
+	if (sources.nr && depth + 1 > 5) {
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
+		      source);
+	} else {
+		for (size_t i = 0; i < sources.nr; i++)
+			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
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
-		odb_add_alternate_recursively(odb, alternates.v[i], depth);
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
+		odb_add_alternate_recursively(odb, sources.v[i], 0);
 
-	read_info_alternates(odb, odb->sources->path, 0);
 	odb->loaded_alternates = 1;
+
+	strvec_clear(&sources);
 }
 
 int odb_has_alternates(struct object_database *odb)

-- 
2.52.0.270.g3f4935d65f.dirty

