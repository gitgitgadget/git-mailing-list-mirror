Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82930ACF0
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380783; cv=none; b=RlurBHMMB2O8ehxWG9xe105M6HYIr6SNYcYH2olJ32+u0sM/h+H5U53GohqtiWlv/UK7JkIH/0J93QzEUnBLMzfmQ6B24vS06omI4gZy1TtDRsYUWh/L03fQR+zm69xmxFOyJ380IHlhYxQMKH9lb4APFJgmvIybaBc6x3Vl+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380783; c=relaxed/simple;
	bh=fAVdqjaCnuioajahAiVD7SZsmdnVKvORqwqUocqr0Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m1goi7YFi7qw9z8wxar7UT/Mx54tZbH+kfDZ7s7FfejqHtTOAKsvAJOjm8Tev6rII5hdX1hFgpsCEaA10tFET2k2zWKg87dcgta0FaiQ8+8cKvyzg0OuKajTBY4jHjBBKhhj7I6tztT18d122NO/PZOIgAr8agl8ER4aGp8WTWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LMJisw+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k84MI9oz; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LMJisw+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k84MI9oz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 300DAEC0595;
	Wed, 10 Dec 2025 10:33:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 10 Dec 2025 10:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765380781;
	 x=1765467181; bh=dzwmGfN6idNEkpzrD86uVO9/JqJ+P2z6Y5+bQEpyxS4=; b=
	LMJisw+LyvyBYCo1Ro2JDnodtKILfBcl/sMPEd44LRn6cBI98dJiC2LZCbTFPy9v
	OZcUGIYj1LKC5ntNIIHQLcXrEzXdyTRiqC99yO93x8jfc+byAMwmjIvW9lCrZ22b
	obZoetlz3OxdCWFwa/GKLP9PakZ/6HWE2BeN0c5BhVz12ci58uDDhSjXEhDIcBTP
	ExquMaz+30c2wwtcnOlgp+HZfyyFScD5vX1WTfhKjRj9PpXYzxRo9y/tzHy1th6u
	RDlGE0qOtDlX8SWUGU3gxG/IsSgaDJoagK1+LmmAzaP0SPPT1lwPc2wHC+6mvk9t
	e2WAOlYeky+ZHlqLHaUWvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765380781; x=
	1765467181; bh=dzwmGfN6idNEkpzrD86uVO9/JqJ+P2z6Y5+bQEpyxS4=; b=k
	84MI9ozbjCCpyZXEJ9G4SlgPqhZ5b297wDG9aOmfLlA0Oy4zDm/FV0E9mpAdLEry
	ZINqDYh58wjpb2ZMPsXL1+aX2GJquFEnbNKSUQGmjk5YViKgWAFT9kGwi+dJ2eeb
	stQ0Jm9v2tD7LA+nwV/3MBCRF07R/W2PvNUhXcpq2qO/RiqYFsfK0xM/1mbDzBF6
	UOgFiUNO9w8353+QvR3bY4jFEFY6+65d7nKO0iU59/zh432ipbBRokLtAX3NC6VR
	FFZ+DwLwhArU8BPRoW2VWElfd77PdHu8y9ktjwBhyVAS1tGSk/shdpuQLdLvs5CG
	I1HLibnvK+/9u0WyzqxrA==
X-ME-Sender: <xms:rZI5af1hs73DPGWuAmFe5TdwAFvyTdNuHId63vmNfuYVlpUS9a1Htw>
    <xme:rZI5aUGmOYM3qIeNndjh59aIvXEbAs0bPvFtoDilpW_A2rX6T2mcaNQtrESSXlmQa
    qNjhtM7GSq1DIFQ8QOP0sPw506fC73-DihcXcKqLehUlodoic2pLg>
X-ME-Received: <xmr:rZI5adglH4EGgmVJn7gT43lSBJ_C6uyAESTUF1kmYYJM4WgR3LrNHf2CM3jBa2PzQ3FIhSrNDwQilopyL3ku1_Gip8G0WSiz8iZA-mxP2FC_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rZI5af91PVG2-8rWVNzd4RCnGu1aIXsxF2OFd68_k0sV_mLf-cJRkQ>
    <xmx:rZI5aUrVCKL-hU6rqNzaGiAn_3tKLhbL1OFBoWeF5M9GRDc3dPoQ9A>
    <xmx:rZI5ae83M1fJ-fXTDLmqwK8WiaVyraxsISFUqkXBiMtGJ3Kd5bygtg>
    <xmx:rZI5aYU9-NLPgzTbSHqx1VpxTnHAmSY_zF9GiBBbUHJrcOSrx71qEA>
    <xmx:rZI5acl0Fxysbjvc9qpdamsKM0FMptRcq2ivwFQPDmtpop3wAjkMxf_d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:33:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b7cd422 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 15:33:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 16:32:41 +0100
Subject: [PATCH v2 8/8] odb: write alternates via sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-b4-pks-odb-alternates-via-source-v2-8-eb336815f9ab@pks.im>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Refactor writing of alternates so that the actual business logic is
structured around the object database source we want to write the
alternate to. Same as with the preceding commit, this will eventually
allow us to have different logic for writing alternates depending on the
backend used.

Note that after the refactoring we start to call `odb_add_source()`
unconditionally. This is fine though as we know to skip adding sources
that are tracked already.

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

