Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB129B783
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445444; cv=none; b=LGYE5xRXknzlICvEm6q/xb2lzZg6XWsiqs53VrPmCNgnTvi3eCrBy+lQU7INF5sqWd+TXOLEbHp2zUEaA1IA8Nns8DuSmRmzP/MJ/nf0DNLGkPRy9WVSW9RpjGeOHKu23KlICWAd4j4VH9QVUavpaPRrgUv6p+1iEf4+4fEkmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445444; c=relaxed/simple;
	bh=rpErHCiapoS2HvhbWBHpmTtUtL5R1iy5M1XV3YUk5rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkyQx0CUK1wJtGia1GwCfBL8sstNlPZPAYkRj68PlZNxuwKB2XoWyfyb++ZrUFvUo6a5NFg9YV0JfsRbyfB5S2E3PQG29AYBqIlTTi8rq5pQi0kCd3qU76BTvrPkugJViUMTQXC1oJRIE/vGnsYpwfKELF19+5kD7X6xJGmgecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ax3CbT4N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I+TNLbGv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ax3CbT4N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I+TNLbGv"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 77B0F1D0011A;
	Thu, 11 Dec 2025 04:30:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 11 Dec 2025 04:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445442;
	 x=1765531842; bh=c20Gln6CYVnVVEVWtSP7z2CFoXl3ZpmgQthj2w4cucA=; b=
	Ax3CbT4NLEjvwPqC0UzzT0neAbJI1YEeQX3RcP5z2IGLn9sF6mTwFF+KhMv6WrRQ
	VUgM4zl6AeeL/eZLPid1ZZ+kMvCsB+LHaa4w1kEHG1y6vrJdz0CDpVvnyXMnFTV6
	ASGlfB2hs7nnfez7MaDaNrKc1FkZm/MwQi8qTzeVYS145Rm+4vF9MXoJcuPsi9Gu
	wjFdGXD78gvMIGVd35UNbk0iauzpaWjRU8QQ4V653VSPNQLE/WEcotZGX/b8mJ1b
	1aNMdo8quBW3I5wRQYEqMfgiY+ezj1rRvSUCg6QVaTZokLNbotof8rvaNeaZ6HdY
	F1LuODLQUivNqgZPJFhzww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445442; x=
	1765531842; bh=c20Gln6CYVnVVEVWtSP7z2CFoXl3ZpmgQthj2w4cucA=; b=I
	+TNLbGvY3SqERxV0XIzSviKjzVUDNFdTgeqmbSi5knug7LdpWB+QinsB4CjF1GED
	HXPajvqfjdaFSKwqgdAiXQE1Fczvb/w4rk8fu+PCEFz3YatRmmrTYJf50aUnOJTK
	CghqnfFDFW694CFrRZvKOazVLH5tLxouvx7IIVX4AaR9GQrHQiR6HPtNPdBtFovk
	6yDHkTSDu4wHk096O/Du2v/YgXrK7AGJrU59lUnR9B9JZC62dF/CYUBBmv5qKkH3
	ibc3MeqxdKPtzi2U6TitIIYz62n33SBYdBkKT8itXsp09wJbahkYYfCbAhVwDXab
	FdT8TTGowuSmvjRlBi7gQ==
X-ME-Sender: <xms:Qo86aU-CSJTlnhyX6w3P70j0Vnygv6nSj0opgZX7K5PEt6cPnrNcbw>
    <xme:Qo86aUJtmJy-S-IgfbHX5_uSwXfE7dn5sp1Px3FQ8ARtahjzmpYZfj3eacyygcOIN
    PwwI4f8ttwluTZOK3jOSqISiV2kKwAV0r3kaJavH81YDUTIsEsv0Uc>
X-ME-Received: <xmr:Qo86aXbZZchkywvDJhNVYa8x5_Hue-WxH4vJuDTDEwE9v0CRE-MjjqbXA6YH7L0WXzeU7aoX2DmcuYbbboCcF6kMx9tUyCJk7xvgrPDiDqG5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:Qo86aeIeUIpCiLZn-mSeXt9KOYPNsxB-mPgJHGNHOsOyC4bSCU6nCg>
    <xmx:Qo86adCtlb4XHgMi_kYD0o2lzd41dt9V9jGmINA2Z6e2bLNce8rbsw>
    <xmx:Qo86abpiNUbqbs12fATyEa7OvuYb4hUJUBAcnf5CENHmby84u_MWEg>
    <xmx:Qo86aQgvuZg14_1c6B1Y0erbdk6kpERyujT8SVqiYB43Z5q_rCf9Sg>
    <xmx:Qo86aanJzb1j85VAGsQSgOXO-ZB2U-Lds3HpNLUZ3BSBwZsXT0F5Bi46>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:30:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f4f376f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:30:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 10:30:17 +0100
Subject: [PATCH v3 8/8] odb: write alternates via sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-b4-pks-odb-alternates-via-source-v3-8-00e3f54d07ba@pks.im>
References: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
In-Reply-To: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.3

Refactor writing of alternates so that the actual business logic is
structured around the object database source we want to write the
alternate to. Same as with the preceding commit, this will eventually
allow us to have different logic for writing alternates depending on the
backend used.

Note that after the refactoring we start to call
`odb_add_alternate_recursively()` unconditionally. This is fine though
as we know to skip adding sources that are tracked already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 51 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/odb.c b/odb.c
index c5ba26b85f..cc7f832465 100644
--- a/odb.c
+++ b/odb.c
@@ -271,25 +271,28 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	return alternate;
 }
 
-void odb_add_to_alternates_file(struct object_database *odb,
-				const char *dir)
+static int odb_source_write_alternate(struct odb_source *source,
+				      const char *alternate)
 {
 	struct lock_file lock = LOCK_INIT;
-	char *alts = repo_git_path(odb->repo, "objects/info/alternates");
+	char *path = xstrfmt("%s/%s", source->path, "info/alternates");
 	FILE *in, *out;
 	int found = 0;
+	int ret;
 
-	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lock, path, LOCK_DIE_ON_ERROR);
 	out = fdopen_lock_file(&lock, "w");
-	if (!out)
-		die_errno(_("unable to fdopen alternates lockfile"));
+	if (!out) {
+		ret = error_errno(_("unable to fdopen alternates lockfile"));
+		goto out;
+	}
 
-	in = fopen(alts, "r");
+	in = fopen(path, "r");
 	if (in) {
 		struct strbuf line = STRBUF_INIT;
 
 		while (strbuf_getline(&line, in) != EOF) {
-			if (!strcmp(dir, line.buf)) {
+			if (!strcmp(alternate, line.buf)) {
 				found = 1;
 				break;
 			}
@@ -298,20 +301,36 @@ void odb_add_to_alternates_file(struct object_database *odb,
 
 		strbuf_release(&line);
 		fclose(in);
+	} else if (errno != ENOENT) {
+		ret = error_errno(_("unable to read alternates file"));
+		goto out;
 	}
-	else if (errno != ENOENT)
-		die_errno(_("unable to read alternates file"));
 
 	if (found) {
 		rollback_lock_file(&lock);
 	} else {
-		fprintf_or_die(out, "%s\n", dir);
-		if (commit_lock_file(&lock))
-			die_errno(_("unable to move new alternates file into place"));
-		if (odb->loaded_alternates)
-			odb_add_alternate_recursively(odb, dir, 0);
+		fprintf_or_die(out, "%s\n", alternate);
+		if (commit_lock_file(&lock)) {
+			ret = error_errno(_("unable to move new alternates file into place"));
+			goto out;
+		}
 	}
-	free(alts);
+
+	ret = 0;
+
+out:
+	free(path);
+	return ret;
+}
+
+void odb_add_to_alternates_file(struct object_database *odb,
+				const char *dir)
+{
+	int ret = odb_source_write_alternate(odb->sources, dir);
+	if (ret < 0)
+		die(NULL);
+	if (odb->loaded_alternates)
+		odb_add_alternate_recursively(odb, dir, 0);
 }
 
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,

-- 
2.52.0.270.g3f4935d65f.dirty

