Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B530C2F616B
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445438; cv=none; b=GrIVFTvrSI8EhBKg9U9UHoo0PmhsluqDCcy/fmZFktmF56ofTvpOXLusOyD87SNDaHfRnkWVe06zoRiB4jidu/BYqFCurOY7zES6szb+sbwRrpF1QcWvlvexRQU9/ucmD4RxFsL3n9SC9olNJNIdHqaRh1tR3f128tNhXMBNqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445438; c=relaxed/simple;
	bh=HEQG4/L8qeqf4+GGj6oP/KJInc0Hx0tQTT7cXjjqVuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXANfsIKAZn9WDoecBaL3WPxBKbR7rT64vYNjdsUTRz1aNjVSPsbYzSKAfpgaAC1rhKVI3h26j3OjMjeTq8FvRie674dDtoanRP9ZNu0zUn76Bdw7ztHf0heBUimN/GsmsvVCwxML7ZeI1I4srvMeONgmWnOIEsxHXqRyVvH+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hIxnYhip; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q1x4A4zT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hIxnYhip";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q1x4A4zT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 091F61D0013B;
	Thu, 11 Dec 2025 04:30:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 11 Dec 2025 04:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445435;
	 x=1765531835; bh=jWzVFElU8oTtkz7D0sr5mQjugoTZTu+R4fOxcZkHCwg=; b=
	hIxnYhipbAzG1KS3riw8U8VzQWzXVdGnYUgRBF3fHkZzDPm1H3wetrBz7zzDKmAc
	x69+7z7v3q22rnUcBKKduQWUfj8XW3wgJt7b0Pm2MYqOKNMh3L38np4trdxD/tL3
	ouHZvlcBLjSOf4Dt+2kSM/QubcVk9Ab+dU2l1Ia48QUPEvxdCqjxs58ANUXIG2li
	lQy+yCJx0N6d7qwjNW60EeflrvblSXnzc65+kMbUMKLUCAGQRLbzZ3n8+HNMCb3Q
	hovfPB5QsTZJFzwK4WSoZzd9AIpQS/fPyTI31TeqJ3RHvqZzNa66CR+EfugsRhcG
	Zv7G3hV51T8V8qmYaJfxuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445435; x=
	1765531835; bh=jWzVFElU8oTtkz7D0sr5mQjugoTZTu+R4fOxcZkHCwg=; b=q
	1x4A4zT3lsYs7zncp0yFqon72wNwA98ACkjdu0QVJLSgRVriDUfyo9tLua6iyPhl
	Qq73eI79beiUzN57h5/JbekthwDiiUwcE8h6jYoMydolh/0Gwf4osqRPX8+wQXlD
	DYcDRfMyYRJlom2qKAWUtJPsvop9cH0ks+X1idaos0cm0yw2bCDJ9iopaTOUTBku
	KAnjNNyYIHEc98JCTVZsy61j7pi/q5TqTVuS8hEaySvk8VIkbphObRjCP9z8ingI
	3dSvxBai+aD2+ZE2w5Yzd81PCsjPoQ6a3Y9w5D3xEWnehLVyw1S6vy+8ibulgtiX
	FoXqObWQqEJ4LROI7OX1A==
X-ME-Sender: <xms:O486aemMB811z2Mcp_63XZh-mVThrN93TlNq7emxssHqQVfHJ2hlQQ>
    <xme:O486adRMbrs6x-zytlSMh9Yv9l_c358mvo4y5kk552A2k5vLVx3G6RMKTOqOevhka
    uHv1a2W83va0RjG2MEcV-_azeHlGFwerJwD9e5rflqQt9im64HCAw>
X-ME-Received: <xmr:O486aaA268bYjFZa6_URsm4td7lwrHTxZ8wqTMrgdH1TeJnW9A7eD32YD1S9eiCnQp9cyTz0DLDWdTUlRz0UsC5RVqXcs6dJ2EO2EjbOeH68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:O486acSFhAkqPfkQ9UktB3MCi0eVM-NefxXdM6AdJJJeIyJLn-Kn_Q>
    <xmx:O486aQqIrNBHiMceJTMy0d5JD8c3diYZhtSAOvGGYKbbt90NCLa0_g>
    <xmx:O486aWxpePuIQIodG2lf7k3LYIj7M3QFpNW5tLsJZCfoaR0MfVhosw>
    <xmx:O486adL0XobM_o9KRObV4ktHHrLhjUvJzL6Jlkvqk6Re-ZtrdMTfEw>
    <xmx:O486aVvSa5QL7vPgu4gUypmCKQHUPjKo2NqzMRWVw--1jswtq_Y-81W1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:30:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ec2e762 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:30:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 10:30:15 +0100
Subject: [PATCH v3 6/8] odb: drop forward declaration of
 `read_info_alternates()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-b4-pks-odb-alternates-via-source-v3-6-00e3f54d07ba@pks.im>
References: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
In-Reply-To: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.3

Now that we have removed the mutual recursion in the preceding commit
it is not necessary anymore to have a forward declaration of the
`read_info_alternates()` function. Move the function and its
dependencies further up so that we can remove it.

Note that this commit also removes the function documentation of
`read_info_alternates()`. It's unclear what it's documenting, but it for
sure isn't documenting the modern behaviour of the function anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 125 +++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 54 insertions(+), 71 deletions(-)

diff --git a/odb.c b/odb.c
index 59944d4649..dcf4a62cd2 100644
--- a/odb.c
+++ b/odb.c
@@ -132,77 +132,6 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
 	return usable;
 }
 
-/*
- * Prepare alternate object database registry.
- *
- * The variable alt_odb_list points at the list of struct
- * odb_source.  The elements on this list come from
- * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
- * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
- * whose contents is similar to that environment variable but can be
- * LF separated.  Its base points at a statically allocated buffer that
- * contains "/the/directory/corresponding/to/.git/objects/...", while
- * its name points just after the slash at the end of ".git/objects/"
- * in the example above, and has enough space to hold all hex characters
- * of the object ID, an extra slash for the first level indirection, and
- * the terminating NUL.
- */
-static void read_info_alternates(const char *relative_base,
-				 struct strvec *out);
-
-static struct odb_source *odb_source_new(struct object_database *odb,
-					 const char *path,
-					 bool local)
-{
-	struct odb_source *source;
-
-	CALLOC_ARRAY(source, 1);
-	source->odb = odb;
-	source->local = local;
-	source->path = xstrdup(path);
-	source->loose = odb_source_loose_new(source);
-
-	return source;
-}
-
-static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
-							const char *source,
-							int depth)
-{
-	struct odb_source *alternate = NULL;
-	struct strvec sources = STRVEC_INIT;
-	khiter_t pos;
-	int ret;
-
-	if (!odb_is_source_usable(odb, source))
-		goto error;
-
-	alternate = odb_source_new(odb, source, false);
-
-	/* add the alternate entry */
-	*odb->sources_tail = alternate;
-	odb->sources_tail = &(alternate->next);
-
-	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
-	if (!ret)
-		BUG("source must not yet exist");
-	kh_value(odb->source_by_path, pos) = alternate;
-
-	/* recursively add alternates */
-	read_info_alternates(alternate->path, &sources);
-	if (sources.nr && depth + 1 > 5) {
-		error(_("%s: ignoring alternate object stores, nesting too deep"),
-		      source);
-	} else {
-		for (size_t i = 0; i < sources.nr; i++)
-			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
-	}
-
- error:
-	strvec_clear(&sources);
-	return alternate;
-}
-
 static void parse_alternates(const char *string,
 			     int sep,
 			     const char *relative_base,
@@ -288,6 +217,60 @@ static void read_info_alternates(const char *relative_base,
 	free(path);
 }
 
+
+static struct odb_source *odb_source_new(struct object_database *odb,
+					 const char *path,
+					 bool local)
+{
+	struct odb_source *source;
+
+	CALLOC_ARRAY(source, 1);
+	source->odb = odb;
+	source->local = local;
+	source->path = xstrdup(path);
+	source->loose = odb_source_loose_new(source);
+
+	return source;
+}
+
+static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
+							const char *source,
+							int depth)
+{
+	struct odb_source *alternate = NULL;
+	struct strvec sources = STRVEC_INIT;
+	khiter_t pos;
+	int ret;
+
+	if (!odb_is_source_usable(odb, source))
+		goto error;
+
+	alternate = odb_source_new(odb, source, false);
+
+	/* add the alternate entry */
+	*odb->sources_tail = alternate;
+	odb->sources_tail = &(alternate->next);
+
+	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
+	if (!ret)
+		BUG("source must not yet exist");
+	kh_value(odb->source_by_path, pos) = alternate;
+
+	/* recursively add alternates */
+	read_info_alternates(alternate->path, &sources);
+	if (sources.nr && depth + 1 > 5) {
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
+		      source);
+	} else {
+		for (size_t i = 0; i < sources.nr; i++)
+			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
+	}
+
+ error:
+	strvec_clear(&sources);
+	return alternate;
+}
+
 void odb_add_to_alternates_file(struct object_database *odb,
 				const char *dir)
 {

-- 
2.52.0.270.g3f4935d65f.dirty

