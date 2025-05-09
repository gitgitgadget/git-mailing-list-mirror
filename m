Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879762957BC
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799942; cv=none; b=SkX674zqNT6uDqzHyMpsP/QXNdYdlIlfBwg+jB4+Oy+5LjRTBjiHTRlsYNlnGv6a9+3Xw+0wBbZvdCI3jQNHnCFMTf91ECkZmStNEZwjwneaUaHIoqa/PsNs6u5w6t13RkXp7uOAlOz4TLkM8O4fgIf17sZEkl5i0V2y6CM2t/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799942; c=relaxed/simple;
	bh=FK+Gmv7UHr1sKfkFI6Z+hN3YpHFgY+41yvj3o+s/mGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qTtjS61R1Um55tJkgC14DOD7cGdmD3SdY6wX52k3iOulDd85a6WCI0kwJ2KhHh9jKPFv+5EY2UuHDxZxYEnAfGG/kimOgLYHkCnB+x6IUgQ5ZuoMe6yUvaGYYCRZcpfUYcJdfoZzuHsuMBQdsRg6DWMYFbxX99TuIYd+zOzWrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j8/eikPb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sXJcqBPT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j8/eikPb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sXJcqBPT"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 697A725400A2;
	Fri,  9 May 2025 10:12:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 09 May 2025 10:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799939;
	 x=1746886339; bh=FE2J4hs8csM1cVlzJUIRdsXHe6qAlrN8pH7wo38FJDk=; b=
	j8/eikPbA8jSru2gbDOGaBvkHfxaZ8FMc7eSwJah+g59y8l3vSkZsNmk3YLURkcM
	1s3Un1/p2cr9aT79JW1xUzjuSwY6LWEf2MVxoNgybakfj5ySMtnz8N7KtfEKDfXS
	VVeogsRIbngdTTXjSwCvaBX3mOhmZ/5PJ9x9dJOpHBiuB4DmnGdOS4LZ3z7MkJQO
	Bx/bU+SrKbp8qJxTbjUdy558/FhArppKWdLknSwZv9UN3nN8MpYH4M+4pBYWsF0C
	Yb6eKX+touDhlbken0PyvkCEv77pvXDUztU5B9BDHSOurT5dm9Oi0rp27jB2I4u+
	PEgIOl1v/Tp/17VTM85vEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799939; x=
	1746886339; bh=FE2J4hs8csM1cVlzJUIRdsXHe6qAlrN8pH7wo38FJDk=; b=s
	XJcqBPTk1hHf5bqBjR3rzeaGaAoBGk4AQE6/MKB/jt0nPO2zV0VPrcmCl7/MA/Ut
	92GivE4VDy2NfMNy/y1bfm7ocT5uo1wUqf8zbzItdy4KJLH3+EhBfE9FTNZDeNdx
	G0bGwFMv98CpJTr0wHPMiK4HSLXJeqdr3NYnOUm1k1RdiBIsToWE1fDOumqIJjrN
	Drtx2jLHbnXMAHO7YtdddL0gkEKD9zCcbVExrE33aZTqyi6XJcmPpTJVOCvlDecC
	FC5/N+RVLpAYRFReSpUXyrExgp7QiLYNcZhVSMdJ79Yc8n2B9lX+dyCxOfIqAUnN
	NqpDP7/9Y7We1e2hulc0w==
X-ME-Sender: <xms:Qw0eaM8JIhOsJRDgJHegeDJ0s7iaQqGvtOO2aCxzwRdGpqrTrRmadA>
    <xme:Qw0eaEtDGI8GVAPOZRwvtHf91GrOciw0OyACl56lTw64ZlWFLiY9bGj_HHFmWJ882
    D8ZzFt6twB7JKgGJA>
X-ME-Received: <xmr:Qw0eaCBhTsTuo27aL7thPYCB0lw3kF_jK5M1ZI2Jy7Ka487e37V71nfDk4mWoYR6vrDvUS3Pyx6Hh_TDWB0nUFBBUH5aolSIzRt9w1wfCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Qw0eaMeGBY-om2XB0HAzhpytaW4QIn9c0Kj3DLvwJLtIfAVJ9ZZg_Q>
    <xmx:Qw0eaBPxKOrysQ8Ir94uzxwUwfeAQsGKZJAnoBexK4paIIct7Jzo8A>
    <xmx:Qw0eaGlTcLS6CYuEXaN3L93HUgbPRT8wqKzjmu0-uBlRgMTy9i0zXQ>
    <xmx:Qw0eaDtrLSTlvjfeSAUD_9ZONZCKOKtJj-RYV3vDmP9zYroPVak2LA>
    <xmx:Qw0eaMaacbx6jjnr3oMZyg5MJoEF98-S9WnIIP4pU7teWaTW-MgYgiiV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4fac165 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:06 +0200
Subject: [PATCH v2 06/17] odb: get rid of `the_repository` in
 `assert_oid_type()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-6-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 60d6358c2c6..39d896ecd3f 100644
--- a/odb.h
+++ b/odb.h
@@ -295,7 +295,8 @@ enum {
 int has_object(struct repository *r, const struct object_id *oid,
 	       unsigned flags);
 
-void assert_oid_type(const struct object_id *oid, enum object_type expect);
+void odb_assert_oid_type(struct object_database *odb,
+			 const struct object_id *oid, enum object_type expect);
 
 /*
  * Enabling the object read lock allows multiple threads to safely call the

-- 
2.49.0.1077.gc0e912fd4c.dirty

