Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B502D3ECA
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181103; cv=none; b=Ran/g7AScZSBMtJUmKqAMGQZX8J8ZN8m0AXXSplUhZC5Dmv+FXPX9NuFX8DUf7Ve4LeHOG8JcvE8UineHN30f1Aji5fVYDkCUXMcHLMev/4yO/UZgtcihvAIK+FWLemAZ5Wz+UOAFzWUbqvWFSFger401KMj1zvwzvKH2cqFtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181103; c=relaxed/simple;
	bh=Xf7J3uCTL6UXNjHbuzrfiqkAfeYSJdJa6eFVz1TG4Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2l+K7dSEZbk4FcZTQFcKdykPJz8c1K/q93FYWyoxz31jnpvkZFxomi+7xAgYoZpuCDWqnmqXf8ORUrOQx2adoTMNWS5/okwQlXU4unTqMbf4RMk1CtWcruj9IdKiz3DkwvCO3ROYoQoW5o993GcRp/JgytIYkgw/pZ4jcRtIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TbNPCxRp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YUHGQzQu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TbNPCxRp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YUHGQzQu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D7B57A01E0
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 03:05:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 03:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765181101;
	 x=1765267501; bh=+sEyb3mR2MbBP+r5w3b1kGWdlTmVrmnnwMHEJvGg5gE=; b=
	TbNPCxRpl20vmNaQQNPi37iVnjfOpY9QXSOVIS6mSIeP+15l4b0KkSgAjxyhOBx3
	zWXb39SWruft/wM5wF4mzZlqSJM0mF2IgX+rfezw/STCb/0HcWbyFA6vDzkrVa7y
	+MrHXk2ZWfQP5466L2GMeXhp9yI8DHyxtuaYuKIjpi2Rsavwmf6Nba1VVq+rZxfU
	N7kxWcsWlWeUIaBEAPq9GWsRFarlN5GuKRCd5ZhK3FXYzC9hoTFNmUO9Jz/ZX+pL
	OiHwoQDJ86UT0gf0ZIKQLBCeKn1KsU5j4xWO9pnZpT1w84HuENwj0P84nlGnCTpY
	ZUcs3ryRin+twJtS0AP1nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765181101; x=
	1765267501; bh=+sEyb3mR2MbBP+r5w3b1kGWdlTmVrmnnwMHEJvGg5gE=; b=Y
	UHGQzQugBO1RT670yoEtbF6E1phEmQSKoewfaovoeVgJO+COh55Cub4yQ6vP7PNN
	k8ruYJBDwNP20ty8DoyIj2a0WITZj0iQpxHi/zgT9BibWK6TuZkeilaMTPwtKNDy
	3B8H/RuKwhmVD4pjwONolRS3OMSXigl+YLeBWXanlE0UvEsYrJEYfODTO2OxuaOv
	sQvDWwTo/fj1i6NjwC4QXKytilsLhwiIBzkTxhfVQ4E29n1bP515l7IrUaMAjcqH
	fXj40aq04zWyOMA2OD+bEvs+DpqyMHrJHNhdla+odSxYqv3hIlgqRk2UmTy/t/Vu
	uSOJjhy9lSNal1XBZ3k+g==
X-ME-Sender: <xms:rYY2acTbs5SSwarCzKQDZ-oY8Fe-jT0R_lZUyq1nRxg2RBjAl6yJNw>
    <xme:rYY2aQu_Vh_AJLpUDSP5jRF4-OorTWVG4m3jPaoSFBok9gm0NEzvwLv99BYdZsa8w
    Me7bRN-EDfm3YGg15sbSSHwuNsCKDRehAHfccK-1ueMBuUQPt61GA>
X-ME-Received: <xmr:rYY2afek2WsAuolBo48MAxjY2spmTWUPUVHbDFURQG5Ua_hPvVyXMJnu0Bsf6HiUMhbVSZ6BN1Tbvka4_3cG5rVUL4JvpSofDIorK1nJAL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:rYY2aVKoCiRH3XBLMeh26ExiGGacyVPRou6kbOWJ2w-j5-0jYxIXUA>
    <xmx:rYY2aVZMgNTx2e8aUR6RGnL1_sWKF_d9Jh9CcIa_8BoCMYzUpQn5Dw>
    <xmx:rYY2aYuxKHS6jY8AClREzWRvWAXxrowzlhktqrC1gqf_S2cjIpJ0-w>
    <xmx:rYY2aauD-UkOhtVnXZCYBdSiNJlkQN8ULG1ZDqckHxgOWO-AWX_0Ag>
    <xmx:rYY2aUSwIaOy7kdomctkqPVUeOrkMBidUbsSkr_YrQDjOHQl0tfcvss0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 8 Dec 2025 03:05:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90f15cf7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 8 Dec 2025 08:04:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 09:04:25 +0100
Subject: [PATCH 8/8] odb: write alternates via sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-b4-pks-odb-alternates-via-source-v1-8-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: 
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
index bf364fe3dd..9e7d078a46 100644
--- a/odb.c
+++ b/odb.c
@@ -271,25 +271,28 @@ static struct odb_source *odb_add_source(struct object_database *odb,
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
-			odb_add_source(odb, dir, 0);
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
+		odb_add_source(odb, dir, 0);
 }
 
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,

-- 
2.52.0.270.g3f4935d65f.dirty

