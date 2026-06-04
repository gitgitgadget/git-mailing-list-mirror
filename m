Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3084BC036
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593321; cv=none; b=h/DneOMg5Td3Rm/QqchuRBemp8TmftbI+uBronoJ6Mh3CovtXNwhsByfSlBK22i1XqZFbr/6ZJU8u0iee5HObCwWPMcoi8NS7zR9mgk8Gy0g6DAJDuPNmSEXloH0rP3Rp3gQxxLFEAwkBo+Fz9dCm31DQhz2i6HlGoVr4cV3Px0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593321; c=relaxed/simple;
	bh=NkC+pKOb4grZ+3v5rXoBARnmebrJo+cryj+gCQVFZRo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gCsU9cZ7b9t6YU2a/b9gFZD9RGOAGTW+bCUa5xYc2chDUw8RZ5IVWift11PRNjNw7vxz/2yTBNmAPBbd8w7bfGsjVvhyg8PzrF89XgNoT/il8J3hosx3sckVHtuPgFcHaiJ1apTDRq/wCHoSWuUKFVCTim1yfA2lu0lYnvYv7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKx1Ep5L; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKx1Ep5L"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1363fe80fe8so1459411c88.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593319; x=1781198119; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geppmrt1N/jF7ZRXnkYzronuzEANpzjVP5bYRhBCa/8=;
        b=aKx1Ep5LssjMf2IP3W47UvCg4NaSi3x1TGreZUOA/X8HfCUddSZ9LVyV4yk97n5Gmm
         BSYypTz99Zt//0GywTbMZ7ELRuK8tGYyfiNI+pqNu2iaxIlffEUoB01G+iLLpcdonNLP
         ErY51M7BaFhwzQtIhXQ/AJsr0e9W1aV89h5IF96VD3c1i41SgqWikTpqVMnBVy5ldFfs
         GEPObu4dxb/01cfP8iREptD0NBmrQgsnX0yt8IIvBoLZPZB6VuBTSmj505Ka0g6njfFs
         a/wCkrAOci3LxOWbvvsN1Koi3DmouVDygwsOoAZTTxMnQL4o0d3BfDLqBveZc5udRvWL
         8qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593319; x=1781198119;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=geppmrt1N/jF7ZRXnkYzronuzEANpzjVP5bYRhBCa/8=;
        b=TW+b+SE74uGapl4b/l4Rxhfk59APvuuyhnEhW7BuiO2vDE8JbZc32urZygxach66Oz
         wtb5hzFH3n1jrqMjUqA6i86y9e8H3B3dD9jnMGbRUrXPBz1/eX+ZT4DWIkAl2ZiDRqlS
         YiAsvJwTJnpuk5sHbDi/xclxTFp8+r4N8h4oj11rA/IZWH8tDo+Aek7OmygfvCyHu3n5
         lzbpYAgwq6rZw35CYCM0ZEttZ5lMmbd23NzI1MxHxv3ZKJ9LuUUIcFPcKCmSTeLSTeyt
         1i2yneFlid7J1foqQFw6mtLqB4RlqCrww/gJ+EKbPk4bsQzrQs8uXdG0CNsXG/228vox
         A8tg==
X-Gm-Message-State: AOJu0YxaYMwZfSBXnutg07n/sEYCp/EC9nXc30pJz5wmrOBrboorFBKj
	dYDOch5m5+XRYZQCsKnBZ0hAMzSqNhEYnS+X9K4bSnaxep12k6q81dW/4PxyTg==
X-Gm-Gg: Acq92OENXtygxqCOrUNk7AU6UwDMJ+905I+CDj2Sq+miZg+Cj6ZNNDSbql2luRD6FHC
	kkXJ+Yb6QATSOPa0exIOGo9oacKTCroqGeCPY99q7lTyvXNkrJIm2vdh4cn61w9wIjwSHe174KO
	bKsvrNG8tUNFuCvj5F/RhcSMYL1Bb6ldEtLBm47ip2L21cBNrGxTyx7lXM0GMoBDU9eZsqRs91J
	sNpVPDJvLXtNy/bZ4oHbgtvObLvjzSHT4+EUhmSvQSYLk+FvegwnGwGAAwBIdm52X5XkSWBa4b+
	NcoN+umlo/Et1EuwdNsDEMLoTtVqhxZSQoJvFacr8onjsw7L/4i28GvRuTzLe9uOc7AeA2FOxJg
	EqZXZP2u+o0QCWLD2N17drN6QefKO0xlaRpCSFBGdFuwbEyCVMOtI5fccbnKUnWOqxrHYUpdF2J
	bbpyPyPyVG2QCEVKzb0OerY/TIl3XPvNuH9v1Yc6cCyDog9Zq0
X-Received: by 2002:a05:7022:6898:b0:132:6877:eea with SMTP id a92af1059eb24-138066a5982mr7938c88.12.1780593319004;
        Thu, 04 Jun 2026 10:15:19 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f548ade9sm3918635c88.2.2026.06.04.10.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:15:18 -0700 (PDT)
Message-Id: <253d6f8004e710d05b5de1f8279d67d2220f83de.1780593313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 17:15:09 +0000
Subject: [PATCH 3/6] hash algorithms: use size_t for section lengths
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

Continue walking the code path for the >4GB `hash-object --literally`
test to the hash algorithm step for LLP64 systems.

This patch lets the SHA1DC code use `size_t`, making it compatible with
LLP64 data models (as used e.g. by Windows).

The interested reader of this patch will note that we adjust the
signature of the `git_SHA1DCUpdate()` function without updating _any_
call site. This certainly puzzled at least one reviewer already, so here
is an explanation:

This function is never called directly, but always via the macro
`platform_SHA1_Update`, which is usually called via the macro
`git_SHA1_Update`. However, we never call `git_SHA1_Update()` directly
in `struct git_hash_algo`. Instead, we call `git_hash_sha1_update()`,
which is defined thusly:

    static void git_hash_sha1_update(git_hash_ctx *ctx,
                                     const void *data, size_t len)
    {
        git_SHA1_Update(&ctx->sha1, data, len);
    }

i.e. it contains an implicit downcast from `size_t` to `unsigned long`
(before this here patch). With this patch, there is no downcast anymore.

With this patch, finally, the t1007-hash-object.sh "files over 4GB hash
literally" test case is fixed.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 object-file.c          | 4 ++--
 sha1dc_git.c           | 3 +--
 sha1dc_git.h           | 2 +-
 t/t1007-hash-object.sh | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1f5f9daf24..c648cecd80 100644
--- a/object-file.c
+++ b/object-file.c
@@ -561,7 +561,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 }
 
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
-			     const void *buf, unsigned long len,
+			     const void *buf, size_t len,
 			     struct object_id *oid,
 			     char *hdr, size_t *hdrlen)
 {
@@ -581,7 +581,7 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 	/* Generate the header */
 	*hdrlen = format_object_header(hdr, *hdrlen, type, len);
 
-	/* Sha1.. */
+	/* Hash (function pointers) computation */
 	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
 }
 
diff --git a/sha1dc_git.c b/sha1dc_git.c
index 9b675a046e..fe58d7962a 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -27,10 +27,9 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
 /*
  * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
  */
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, size_t len)
 {
 	const char *data = vdata;
-	/* We expect an unsigned long, but sha1dc only takes an int */
 	while (len > INT_MAX) {
 		SHA1DCUpdate(ctx, data, INT_MAX);
 		data += INT_MAX;
diff --git a/sha1dc_git.h b/sha1dc_git.h
index f6f880cabe..0bcf1aa84b 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -15,7 +15,7 @@ void git_SHA1DCInit(SHA1_CTX *);
 #endif
 
 void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, size_t len);
 
 #define platform_SHA_IS_SHA1DC /* used by "test-tool sha1-is-sha1dc" */
 
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 7867fd1dbf..10382a815e 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -261,7 +261,7 @@ test_expect_success '--stdin outside of repository (uses default hash)' '
 	test_cmp expect actual
 '
 
-test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 		'files over 4GB hash literally' '
 	test-tool genzeros $((5*1024*1024*1024)) >big &&
 	test_oid large5GB >expect &&
-- 
gitgitgadget

