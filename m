Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E44F881
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720423; cv=none; b=EG4XG5wRKqZ+Mwt2ydBurzoeGVF50DbSjwg0lNrm93+CW+QnUAKvy+9xzPdeq0a41CwD6bk8ZkqMJVg1Ac05xrO49Pnrcz6PfJoaFXpIgBqdcvMogxyCuA+1SCj5mVH1f+L2H56U7Dgvt1K2RTuz3jVvRmWEU4oGxNmJqCBv3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720423; c=relaxed/simple;
	bh=Eflm+MKUGU5CcwU5mP/0LsS09JeWpT2KBOXkOhU4Hd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APXjl+Ss3ADul8WoHmBx6hlRpOHDU6qqapdFk6cn9T4F6P1gnX8M7yNeW49dEVUKKieYC2xALuFXdv9QZa0CImt8BSnj8DWzZduPN0AiuZntmfrtQPgJTXND6qWehlxHS5mSbFFLiLI1cGHlwcZFVAHZMxiqBxBVP/gdOO0upjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GD22BpkZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvaY+bxj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GD22BpkZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvaY+bxj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 319667A027E;
	Thu,  5 Mar 2026 09:20:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 09:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720421;
	 x=1772806821; bh=kjs/26OifjaAC5HMCSDKNUDS2BZru2fnAkgC9OvYlXg=; b=
	GD22BpkZk2mKUibfQS0SGFrCjSYrz1rGk/L4iub9VsR7E8At1zrUJfEvQH9d5zAO
	NzoW9h6MJZrPc5JdN8UW/ERMureaPtNKZpXi0v8vEztlqNUmTboZ9xmD6b3Tx1tN
	mRAAlMU22lUjzmb181Iveno2GEuqBIhYpcuroctm18vH3O/eRIf2IYZsiGqGjzFK
	4pJiBmDkGrrDKZKJHLnvxgpIs5LQBIgczoAMok2mxq9evwrZpIx56zDD5EvtjLAg
	DkoSBEJ55AlrlOmMiH9CD627/h5aV7zNQn5xuRwDWwoUdR6tESeBJfO5ilAyqYt7
	e/l1cwzsx6myoCdHbA5qiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720421; x=
	1772806821; bh=kjs/26OifjaAC5HMCSDKNUDS2BZru2fnAkgC9OvYlXg=; b=m
	vaY+bxjMIYVAzj6FJvbneo4CPFZpajxXx559tFbBalalvNXcD1l/ZvhJUqcKzZfO
	tk54hTMNu8B+bCy0k0rVop1j+D6/NaLsQs27T+JjZ4059gr3rtXQ/zpxHwTjOtx+
	KkGyOTPbNXDJFL6stqCzS26eJU1UXyEE1atQfyKt24Pj3AkgkDHnN7CyK3zkfFVd
	H/S7kZmgQCAQXi9yV5nwkq7Xs4kfYhm7+kyIlAliAjy1uMqn5j3l/JNbwIy473xL
	ok0ZuvL1KANdC/qwvjZTx3iE5aNH2P736jH3t92Kdgrv2hrkb8JVOuwUrS8ivnx7
	tkGJWO/xBGEBANe/5OVAg==
X-ME-Sender: <xms:JJGpaWhQ7oxW4j8cD82VVnI6eAaVcdHq3YYMcImkErccAa20dGVlfw>
    <xme:JJGpaeBsxNAjw2ynwldWtdMVASCNsVXKAxU8h0X1pUx_dbQZ51ADy2JdP3djL9g8Z
    AZw2q1THaNvrrJTxJvthyQo8R41H7faQUd6msweUIo_mkejZCnB>
X-ME-Received: <xmr:JJGpaTGp3Wk7lNP1yAGWUav9OjPHWkCuBMKbGBjXMh1TotzW_-UGPtMX76RlsyWjFKGT6upahS1OvO7DWJHkzUe0mpT26LMgshNZurUUSLzX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JJGpaeIdr4n-n7nEhknVVJz9_ab_TNas0uhDqwDCqvAHgqH5C4Ha5Q>
    <xmx:JZGpafn6ASo2PHVPMe6FXV7ZeO84FLn731qfx2XA095ig-lLhOTJYQ>
    <xmx:JZGpaeTfdURoEyOjTkexW1yXdou1ef4SHEm_Ofd_L0kciA-1NeDRiA>
    <xmx:JZGpaZI_crMknn742L9jrpZIeO-gA_aleb9rPZuJC1dMN6WNYWzXbQ>
    <xmx:JZGpaSy6t_OAN8qM3uN6xx-cerMGba44fzxHjSkEtLR2wI3yNW1KfDmH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78af60f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:52 +0100
Subject: [PATCH v2 12/17] odb/source: make `freshen_object()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-12-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              | 12 ++----------
 odb/source-files.c | 11 +++++++++++
 odb/source.h       | 23 +++++++++++++++++++++++
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/odb.c b/odb.c
index 494a3273cf..c9f42c5afd 100644
--- a/odb.c
+++ b/odb.c
@@ -959,18 +959,10 @@ int odb_freshen_object(struct object_database *odb,
 		       const struct object_id *oid)
 {
 	struct odb_source *source;
-
 	odb_prepare_alternates(odb);
-	for (source = odb->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
-		if (packfile_store_freshen_object(files->packed, oid))
+	for (source = odb->sources; source; source = source->next)
+		if (odb_source_freshen_object(source, oid))
 			return 1;
-
-		if (odb_source_loose_freshen_object(source, oid))
-			return 1;
-	}
-
 	return 0;
 }
 
diff --git a/odb/source-files.c b/odb/source-files.c
index d8ef1d8237..a6447909e0 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -88,6 +88,16 @@ static int odb_source_files_for_each_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_files_freshen_object(struct odb_source *source,
+					   const struct object_id *oid)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	if (packfile_store_freshen_object(files->packed, oid) ||
+	    odb_source_loose_freshen_object(source, oid))
+		return 1;
+	return 0;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -105,6 +115,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
 	files->base.for_each_object = odb_source_files_for_each_object;
+	files->base.freshen_object = odb_source_files_freshen_object;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index be56995389..7f2ecf420b 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -186,6 +186,18 @@ struct odb_source {
 			       odb_for_each_object_cb cb,
 			       void *cb_data,
 			       unsigned flags);
+
+	/*
+	 * This callback is expected to freshen the given object so that its
+	 * last access time is set to the current time. This is used to ensure
+	 * that objects that are recent will not get garbage collected even if
+	 * they were unreachable.
+	 *
+	 * Returns 0 in case the object does not exist, 1 in case the object
+	 * has been freshened.
+	 */
+	int (*freshen_object)(struct odb_source *source,
+			      const struct object_id *oid);
 };
 
 /*
@@ -297,4 +309,15 @@ static inline int odb_source_for_each_object(struct odb_source *source,
 	return source->for_each_object(source, request, cb, cb_data, flags);
 }
 
+/*
+ * Freshen an object in the object database by updating its timestamp.
+ * Returns 1 in case the object has been freshened, 0 in case the object does
+ * not exist.
+ */
+static inline int odb_source_freshen_object(struct odb_source *source,
+					    const struct object_id *oid)
+{
+	return source->freshen_object(source, oid);
+}
+
 #endif

-- 
2.53.0.797.g7842e34a66.dirty

