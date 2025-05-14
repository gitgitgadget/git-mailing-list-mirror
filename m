Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781F1F5437
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199559; cv=none; b=gHgoAWuRWxjhSlaIr/+uexV0b31nDcetVvjZN7sABQmD+mX49ASlyQSPSiuhl55NFKrG9jxDFTdMiQF2nPmFiixlavOwpjBRROil6j8NJGFN6CON9sWf6rSm7hEJJOh3XmshSRFnFAgCpQTnUfvXtHqBVJ+gS+j4/a2P1hllnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199559; c=relaxed/simple;
	bh=mV3OXVn8xnIPGoJrH7Xl3UoXJLeRG2Gp710rlwXlX1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+4Z80Z0GcJcGYMVk3QFXtUUULT1XR5qkMWJArgI6ZiJkaxQAPS3o4+7RzukTk6+CxNh6FLP/4X56wiGxSs6yy1C/NhstfVJgRWGmtanHnaKKctagQHkmS8ANFU6dPVGn0ZxuOJBH32vjpB3lW2NvJbL1ZkW1LpcZTgEJ2ssLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uQ3Bg4fw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BgBaZlBf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uQ3Bg4fw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BgBaZlBf"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9D091140132;
	Wed, 14 May 2025 01:12:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 May 2025 01:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199554;
	 x=1747285954; bh=+2McLvejsMdDphEar8Qh4VQOLiH/odDtMac0e/2kT0s=; b=
	uQ3Bg4fw2r+NT9VNuwZAyBoVijUVcRENOf/j5MSqp6liWiZyl06D1SeVJPp7ZySy
	dEZ1T2QJOK8JCWIl4sukQwhxkqQqU7GBBdGAY1/gRa9OrsDtpmyRDMuHn/OxhHmA
	KlNDWi2g8h3dtgKmb3JHubjXI7BbWfuxjCyf13YfUVJLl95ewtAK9wiiZ5rEwnv6
	tfdsyGfDfG4SIvex/ae/u2t73ABoptZw9tlknrJQNQPq/GJof2llG6ykchBMXmWV
	jNiwtcnw/QhWR7vxzzalygWiHhwUVBr7+32qqrLcZOpkUNz0EnIevXU+bVZzafhZ
	CBIysR+Zt3a96tG6MXu0SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199554; x=
	1747285954; bh=+2McLvejsMdDphEar8Qh4VQOLiH/odDtMac0e/2kT0s=; b=B
	gBaZlBfxZ4WaLem7xyRpEulBGYafY2s18McxLSxSc7xrdWUEgscbMV1FlSCOe1wI
	9K8KL8rTHzUkv5NiRn4p/5v5Z6aeJfSKdBfIElHDKcKCpFJC85GfjbpcHhGybovy
	s78IewS18WQc2kpPexCSAzHpjHePSWvfxTWIVvKNrnRwx0Vk45N6neT2Q4oP5ZNb
	0GkFkYBcunb5MLpxuJO3qT3gzYSDKVcXI+tOVwU4wAhquIkQyVlZOhNQDq8FN23r
	9xJH2s3VXKh3gs//E38juIhhvst3do/FLtYCYmExPSXDP6lky8ulfuZ+6oY9m5uo
	GuesQ/owKAh0SxhwOapvA==
X-ME-Sender: <xms:QiYkaPw_eiXkWXjwv19sUEk875cSm1FfM6ON0SD9NxP6iX77-GWL7g>
    <xme:QiYkaHTCz5Y2ZBR6uglSLgyGmJ2QqYnpo21NmkxNxMFTwwGWkBWxFSGjq4AQRNrSw
    _J5DouBf10V8RR6jA>
X-ME-Received: <xmr:QiYkaJVberGGGWDie9wdCuflWowke61DO97Sv6LVR1ZnWIkZuqfR1kWn5phcX9-Qwhts98aBjKHKiHIhmXXjuZxYE10_77AABjjjDUniUxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:QiYkaJhIoGf0iT0CGPWJqbsSOpocDa8KQSupCcSw0Dh9RmvGhfsQEA>
    <xmx:QiYkaBA92xinwm-L4xl2hqGwE4VUIFg8Ll946Cdl0Ddhooc1yzGgog>
    <xmx:QiYkaCL82zm4vZ37xuOJhqlGx8p0REMe6rLwXFL_LrB58WiOUmDRig>
    <xmx:QiYkaAB4JqWEJV63FQiN21JJNyroV16M1rWFfLSYmYRHPkDl1HMOzQ>
    <xmx:QiYkaJFQrTlwmlsimQV72c3hyzzs1UT18ENI_uizAD7pIrrcxgtOwrmN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 949e8b10 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:29 +0200
Subject: [PATCH v3 06/17] odb: get rid of `the_repository` in
 `assert_oid_type()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-6-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Get rid of our dependency on `the_repository` in `assert_oid_type()` by
passing in the object database as a parameter and adjusting all callers.

Rename the function to `odb_assert_oid_type()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-tree.c | 2 +-
 commit.c              | 2 +-
 odb.c                 | 5 +++--
 odb.h                 | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 546069f8682..31cfd9bd15d 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -48,7 +48,7 @@ static int parse_parent_arg_callback(const struct option *opt,
 	if (repo_get_oid_commit(the_repository, arg, &oid))
 		die(_("not a valid object name %s"), arg);
 
-	assert_oid_type(&oid, OBJ_COMMIT);
+	odb_assert_oid_type(the_repository->objects, &oid, OBJ_COMMIT);
 	new_parent(lookup_commit(the_repository, &oid), parents);
 	return 0;
 }
diff --git a/commit.c b/commit.c
index 1d30f8ce15a..aa65183d8b6 100644
--- a/commit.c
+++ b/commit.c
@@ -1706,7 +1706,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
-	assert_oid_type(tree, OBJ_TREE);
+	odb_assert_oid_type(the_repository->objects, tree, OBJ_TREE);
 
 	if (memchr(msg, '\0', msg_len))
 		return error("a NUL byte in commit log message not allowed.");
diff --git a/odb.c b/odb.c
index 621a16b35ea..d09b8bf00cc 100644
--- a/odb.c
+++ b/odb.c
@@ -955,9 +955,10 @@ int has_object(struct repository *r, const struct object_id *oid,
 	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
 }
 
-void assert_oid_type(const struct object_id *oid, enum object_type expect)
+void odb_assert_oid_type(struct object_database *odb,
+			 const struct object_id *oid, enum object_type expect)
 {
-	enum object_type type = oid_object_info(the_repository, oid, NULL);
+	enum object_type type = oid_object_info(odb->repo, oid, NULL);
 	if (type < 0)
 		die(_("%s is not a valid object"), oid_to_hex(oid));
 	if (type != expect)
diff --git a/odb.h b/odb.h
index 5c5ce4653eb..e38a46a05c9 100644
--- a/odb.h
+++ b/odb.h
@@ -298,7 +298,8 @@ enum {
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags);
 
-void assert_oid_type(const struct object_id *oid, enum object_type expect);
+void odb_assert_oid_type(struct object_database *odb,
+			 const struct object_id *oid, enum object_type expect);
 
 /*
  * Enabling the object read lock allows multiple threads to safely call the

-- 
2.49.0.1141.g47af616452.dirty

