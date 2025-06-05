Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7C1FE44A
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106028; cv=none; b=cLA0aeA5nmPZ4OFIWhOT76jlzxw49gawPYt+xU/0o7sMZ4JXCsEb9bmJlfEs6pdPQ1QEQ7VXcsNzeeOzbUTeWjFEKNkgv6sQD+KMwrEWldP2qUT0GUDLFQ6+DY8rRBPN/JYg1CWCuq3CEYOpCgUfqZ7/qTUH547fBxEs1ir/9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106028; c=relaxed/simple;
	bh=nfV5UX3q3rTuzk3DX2cM/UwndnNy8dB8RhnAEkOGt6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CiSkuL5actGaFLtfIJY0sowDtMYKBHzd+cwC07Nydm5LCPxV1biU/oe/aUVdCRpxX5lEtNXkGK9AGV1T2R3D9XdwkEuJcwMMeaKva+STQbyEJAAo9//0sWXZlyOTH3ak7m2sTaT7e/8GujNNXpLAKJvyEFv9sbw65bDQZWWzp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oRpyKqvy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHrOEpOm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oRpyKqvy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHrOEpOm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D75B11400DF;
	Thu,  5 Jun 2025 02:47:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 05 Jun 2025 02:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106025;
	 x=1749192425; bh=cQtlWw90qqk55uKZNatLEF+MDSeBelYWxkizGbRFEp0=; b=
	oRpyKqvyvDSGYbRSfRb8X6sww5EnHqa7aPF6f0EdxaEo3UsxZTK9idqaGCxy+1l6
	oQH3WXeXNHVqfwasYblH+350NimF64JcoBsgQWTAE+P8BUmYmCeeGvKlfrXGEy3y
	sko8jUzIBwjqfBAqOVGQMVqyGaGa8251p3wnnD79VGJ6MVyIHqOZCClvo4lpCnG9
	qgXkrf6bs5aR/Ki+dwWBNeB/cfPLeaVSz2Z4NLqiQWnkEnW89ktRL/igFOMJ++Tg
	Yk4jY+dNmpUaUiP3unJQwEOsJvCBGFdiES4CrWUXjcQV+bSwhCwlGEXtBAWQ64I+
	LJOd3RLXM1gFs11EccJjLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106025; x=
	1749192425; bh=cQtlWw90qqk55uKZNatLEF+MDSeBelYWxkizGbRFEp0=; b=d
	HrOEpOm9rx2DDc3LjvZrfTIMUSPf6mUo3UUHE/36EQ3/OKQIl84V0ZdSNb47qIhe
	hluqsFc/erBt+RG7njyLN2+rRrzanxhkEFbwWUIe8WNNn6oy2680HzD7WLVWuWAF
	/VsalTOZ+eMff4XqCg/DP4xQj0l6eIK/+l1wjUP+fPkNthXiYp2Fvy1pGSldxHkz
	borAFlmxWCeGqifG4zrI4A0olfo+CE0DLWlovsn9NNbORRmV9JiDU3NPmHp/99Qq
	4Lfgxxd7uwXAZ28czpr/AmypiIbswbIx4f7TfpSSfhnFFR+zDjYby5JIuy4+8SAa
	3HoEdY26YbEHc/QlBIvvQ==
X-ME-Sender: <xms:aT1BaBry3hfyGQ2Q9jT7YBnI73H1CqZKsIIYDg-TURsKCvfLKmFVbw>
    <xme:aT1BaDqNXntTUstsxQEIfCKh3haLceSxNMe51ZtUhOB-xXM2cix14CDp0y9Z7kNmg
    ey_g79OAlOCTlRoUw>
X-ME-Received: <xmr:aT1BaOOV_O7A_zQO9CBOuWxXY_Q32NQ3UJmkdYeDf_N2LUuvuU_uPH8f3SpZdPDtxeyLGyp-X-X0vTHCi4AbCNkxJHjbKi_F_vITh7UZEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aT1BaM4vXfwBhVLPNGRMSxQLJDbBaNQzgyW3rq8UnWdkL6vdSYs3ew>
    <xmx:aT1BaA4zzB7lPU1OwQl8IVRNomjHqhF88ubTk5eRBjLSFgujz-raPw>
    <xmx:aT1BaEjtnkgm4i7pFFKYbAGdMpKsveueOnzRXIipp0D6kM78mfkLSw>
    <xmx:aT1BaC5J11V258rI2E5_PrqTkwS5UyMvfdaaKjfBMw4pXxF74y5dIQ>
    <xmx:aT1BaHgcVfBEb0UCR0dSd8kAmVgzxLjxVemGTlu1LWQhJwlWK2tXl-AZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d908cd55 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:46:56 +0200
Subject: [PATCH v5 06/17] odb: get rid of `the_repository` in
 `assert_oid_type()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-6-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
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
index 483b9b38414..3a3ceed5508 100644
--- a/odb.c
+++ b/odb.c
@@ -946,9 +946,10 @@ int has_object(struct repository *r, const struct object_id *oid,
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
index 941329c6943..13f5da45f54 100644
--- a/odb.h
+++ b/odb.h
@@ -302,7 +302,8 @@ enum {
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags);
 
-void assert_oid_type(const struct object_id *oid, enum object_type expect);
+void odb_assert_oid_type(struct object_database *odb,
+			 const struct object_id *oid, enum object_type expect);
 
 /*
  * Enabling the object read lock allows multiple threads to safely call the

-- 
2.50.0.rc1.591.g9c95f17f64.dirty

