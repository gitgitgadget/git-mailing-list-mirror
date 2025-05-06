Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B62798EC
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529767; cv=none; b=lp2A/DcFb0Z7IgK+12qqG8Wo6gVi68Hl6qZtzrYJ9/RtICtThcsQdd/ixdyUHWd/R5TkLUWOFfBL4Xh3F+Zn/Nf/9coRgF5SihdWbltV5McuQg1Rj9EnBGOPAiCFeD0JTrM1vwInk5vZNrGvuemtI4ei5eFDpVOjrF+tG3lYDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529767; c=relaxed/simple;
	bh=NpQoqrvzJW9abilEGcfTA+RBf9C2DTPT54FeUvitfYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEX2KSfIVpMbc8pdeVyIzCjmLKfQrin5aRw1aRjONxXAPbxTqen4SL6t4VfA3ThT90HKBmaYXeHTrI8P1zS9tP9VMJFy1YUkj9WT7SFBeFxOyJnV4zQ8Ez3Aq2tgQ2gQYNys1Hq3vvK5fNWTMohGys5Ar5hlpO0TEwbYC1JFx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ovJDuH/3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFG3WnJs; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ovJDuH/3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFG3WnJs"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B1401138148F
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 07:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529764;
	 x=1746616164; bh=+rS+4J5yuOeldfJ8JJ7UgMQgSt5H3yTidxVf/Lbviu8=; b=
	ovJDuH/3Dz7Nibo8xZFJBWvo6McppJWXr+3P8M6QxTEUNKaFMFO5BsRg+F29zgcD
	fizjy02vWNdkLaNCz+nVIZhi7eUe2wZTZw/cFQixMhv0LvNlgohBpzqZ5BKIkd4B
	9DgHdHhNEP8biWE9mE5O0xGBBZH7wPTI0yYZ0Afsnovt12Hkm2ABYLnc6NXEL3ow
	SRMJntKidqTfPt3PUeZ+dA1+u7YX8mbNvNl+wHlYubOLLfaV9Tu290/5CoxAhbsr
	j3wMUsoqUqTOdvgZmHtHMVWhetiao/DWV33lzcc7YpBq4ALHjmga3oaHGRk3ReJR
	IWGZ9YQPuy3rfjOlPbB1Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529764; x=
	1746616164; bh=+rS+4J5yuOeldfJ8JJ7UgMQgSt5H3yTidxVf/Lbviu8=; b=c
	FG3WnJs9wQTH46AlcjlW/HvYCex4eAqydkLbCP+2AbMSjd1Om5fW8qZ+fbvqH3lb
	D0esG0T4bFJhEtozzM5MuW5ZkPJ1K/sHg+FUKbsXo2ECfWuNfhyCLXvBFwLDe8Na
	hla9TCWlhIUdcJJUQXXbIazPhmhlQsEszEfVMZMYQ1R+Y6CjcdoQqSqo1qM0EnGk
	pK4/cPTOrBohlypqGFMJCd4XI1O+QH8DsA8Ok3w9pVkWH8B946tV6GD7HkipfVQP
	e/z0ysuHYOYMIqxQPNQbKBwSmBU/6aHqH7ajIBeheOGKpANf5xPaNqzFO8JlI9vD
	tQQ7JIyYollExudS8O3lQ==
X-ME-Sender: <xms:5O0ZaKB53y2-ME0qLpBJz6MEXwSN3j0TBXMBuv9h4teZOKZcv2_a0Q>
    <xme:5O0ZaEil4nbNTcrtIyjxKgm1RNURq3eKsFtpLy9TuIAfaTm6Ge0MnC2qX0IhneBHe
    tAJjE2yZY3IVsxtPA>
X-ME-Received: <xmr:5O0ZaNlnvwSZe0y7wHgoiuW8Tdr8CeLy2cat0yyApziyOaA_dzanbIwx1-HeFIcGORC5hRP8Zm-WHlPl5kKXT4sYabGIq7WSJYf_hSBe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5O0ZaIyZuytbbbTU2cg7NlYgQxFcDrTzxf1TkIZlOx-QJkXOKmTY4Q>
    <xmx:5O0ZaPTsJ1xGkUTgzLI1YssYG8JAm7sozYXmNCEa2Qi7Hk2Ddp7Q4g>
    <xmx:5O0ZaDa4uaVvbUHObmXTrdrvVWM5JsziIpvjzcWE0Zs86RIehHyxbQ>
    <xmx:5O0ZaISE-YMoPjOHZIMqn_ovsB5Q965IIVEB1aRIU2QWJThowQ1Wtg>
    <xmx:5O0ZaE81WsLN4My4ijcL54jjwnB8rCzc-zninMUYUfv2xx1Kj3R72Vq8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f8fde00 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:19 +0200
Subject: [PATCH 06/17] odb: get rid of `the_repository` in
 `assert_oid_type()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-6-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 6359c541d78..b4265da2993 100644
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
index a8c0f788969..7e634db16f2 100644
--- a/odb.h
+++ b/odb.h
@@ -293,7 +293,8 @@ enum {
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags);
 
-void assert_oid_type(const struct object_id *oid, enum object_type expect);
+void odb_assert_oid_type(struct object_database *odb,
+			 const struct object_id *oid, enum object_type expect);
 
 /*
  * Enabling the object read lock allows multiple threads to safely call the

-- 
2.49.0.1045.g170613ef41.dirty

