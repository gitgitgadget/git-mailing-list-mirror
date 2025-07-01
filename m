Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D619274FD0
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372564; cv=none; b=SE+VR7oVlc2aAWz3MDP1AkSip/zQvoWgoZkVLz1oh7eN5ddFmeToNZDB6nQoAPgi9gA3XxNCFa5cmSTnjRAZ0LC05QFUstVOq4R0FAgz0lnd2a3xIj+uUK8CUOx1QCc7CAxz3Tmi6bmGZHEE920RpXzXxiaYMcwpMfuCGrs6+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372564; c=relaxed/simple;
	bh=h33445rMbLkDzzDG0yy/eqgJVqy4F7rJu0BCmzxYh64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7WSFFzn1WAclpQzn+rDiHEzoMpMx0wPyaNtnn862U3wITSzRf9iG2cFSpLk0zWTOu0ypStxwC4pkhmMhsgCSk0C4qRvSzYxRt1YqXRwPxV538Bd+enLtTfPD3OQyLB8kUosO/Gueks6Bu72hEtrrz1htqu+5of2JCj7Y9LtnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BBF7GAnB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QnLwTSQO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BBF7GAnB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QnLwTSQO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EDF8EEC04DA;
	Tue,  1 Jul 2025 08:22:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 01 Jul 2025 08:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372561;
	 x=1751458961; bh=Ee+RZP1F4LHbul8Qu3dYeXsM43gxfuhZhJFecT1ONLQ=; b=
	BBF7GAnBSwdAngI/JIj6FTEM9x9uTv6Fj+gblb1ddBacxmPGs1u3N8Fk92ELixen
	zvGm+9RglUz9ZF2fikU0NTvG3dqyTKS0OYbwb9BQ4kUTMZ3jVV3shIE/1FXoltCm
	oDezx6JUIihs1OZaQB2HDNJCRHPkjdaSvw5LH3UGwkcDQlzRrY8ga5JRWazX1WEG
	8yNf2uUiiOkgWmdsCGZgkB9qXhYN4tJyUjaUOIPovIq9VdR25zcRUAyR/83/XTET
	h1Cc5Xvdd3iLBmjrmoI/pwSpygKS4bv4Nbp6hRFIxwzcHsgMyh5qRGdOnCfb52x+
	H/C+n4qW/hbtLgpxPzNJFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372561; x=
	1751458961; bh=Ee+RZP1F4LHbul8Qu3dYeXsM43gxfuhZhJFecT1ONLQ=; b=Q
	nLwTSQOBhRIRBMA4EN1aikPLplMc7tKgu5kZsLRtFJWfHdX0bCZlocqw7Hrjxr/D
	QMmMlDjaJ7Lk5ESOA0XwC12f6tmtkGwi+MONBCe8ZoCi30GmnM9UMOOkBA6I9sjY
	xCwtae0cf0gDEXivtGVVaAfBrmlbe99gWFHMI4UeuJcEMAYXgJC6bGE6/rOsJN4p
	HXPyjBVV9eUSh7okqZsQpUhrtz7kn39xBOSVLN7QUVwKP4vON+5hGbZrxYoENvbK
	si5yRMpR/om/xRlEJfUyIVfvJU3kmsWP8P+mMVICFr1oSHNKOTt5dy8Iq0R0FKqr
	ANFGWN3Sw5duSawfTejeQ==
X-ME-Sender: <xms:EdNjaIDJQ7i0UmFBDF-xEKTOnvnx0OcKFC_EoEbO927y2T8G7cVBIg>
    <xme:EdNjaKjn22X_jvL1B7-DpGoMFcQnClX-t1axulvlra9a4zaqJ-KVQau97HkrZtnoN
    DzXJV3_qHLoaiHKQQ>
X-ME-Received: <xmr:EdNjaLnqAie0OOY2RDn3JA5wj6_4Sbu5eVhzUWgPVR14kcuTVOGy99YJQ9526IUt4I4F1yxPqWM6eUZU9ugJCwqq1RhFnkxs-ZKBCgixHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepth
    hoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:EdNjaOySj1AmabyQ_8VMvYLQ-p3D9hXUhyCcxbSMPcfFGp6UpornHA>
    <xmx:EdNjaNRa9aD4x302S4evI9zi9R35-iiZH5Yfgs5zMi69wSYh-UGS9g>
    <xmx:EdNjaJbAaAxLDgU8qpATfdNdii_DO4B56GKDVqmGe5kyX4bp-7bPIA>
    <xmx:EdNjaGRVhnYViKrYbl1D5ws9ZL21w-tsRm2akMmABfuGnBhJNdNrUA>
    <xmx:EdNjaLaOcwKg6R6v-74NILjwr6YX09orD1J2wkhRqu4zni0wlZMyHbOr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:22:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fef88d18 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:22:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Jul 2025 14:22:18 +0200
Subject: [PATCH v6 06/17] odb: get rid of `the_repository` in
 `assert_oid_type()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-6-dbf3894ab4e2@pks.im>
References: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
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
index 240fc62ca2b..d0ca2990774 100644
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
2.50.0.195.g74e6fc65d0.dirty

