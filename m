Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E03E120D
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001486; cv=none; b=lXx5dijHfoyebnkI/469YHUvvjifZsL60j7nkMecrV19rHDHCgBqHGyYHo+p3ZdNG+/yXHmjxb2fWrmE6DjUI5loQtP/3h62wuF8B7lRX/HyP9h4715KJKkZEXadhyDTx840zujsYjBmfMo06kIGF8zTCJIjuTcihyNwJgi5Enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001486; c=relaxed/simple;
	bh=ZyqBYiPM2umt9CBEjx5CgDpNdApMvNma5Sn3hHnNd6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uW6cVxzhZcyyjik6NPBKDJ98Wy48A1tAatF238UlpgeObfPrsLQjOrpWSMD0GBh9WsgzYir0cHJ3iOZDxKbFK8E0u16qObKfA8wcm49M/8svSo1eFKP0ddc+RA56s+5m4NNlN64om4jdC7jUQ+zpmSBiCCX/wzxs92qL6Kg1rfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tcq11R0m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cuug/CsU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tcq11R0m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cuug/CsU"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id BD08AEC0258
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 19:58:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 31 Mar 2026 19:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775001484;
	 x=1775087884; bh=LE38uM8vOkDBnyg2byVhrunT66uqWr6a2rNT7KnrjhA=; b=
	tcq11R0mLSgqMpP+GOuhq+WiQwSb1+hFhnRWEiAYbJK68VMKK7z8wAPAv3Vg8q67
	1xCOAPLdy35EIY7qkO790AfZ8Ham3DfxOSHQP5FlK6HBayIuI0o9OgdK2v59jQIs
	Sdfja95mX/G1/hF97IHRCVWfCDIS1vs0S67iQKF/sA/At0lycCZGxnhTptRCFnf3
	MyEzUkcr6NikGY4RiRUTWdXdCBxnpKqin1254ODl/qmSszamnWM9lpvN1LT67U5t
	xgXJ47Ioh7mpW6yzSSsv3alq9C3g+bi4uJK6Rm68o39S/LSYzINNASK6GrsBl3G/
	3aX7UKwrS7qUPBZGIj8wrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775001484; x=
	1775087884; bh=LE38uM8vOkDBnyg2byVhrunT66uqWr6a2rNT7KnrjhA=; b=C
	uug/CsUYTsIRGFEzlQ7HLGHYjLJ6R6dFVHyKzwY7alu0HuAEAeHlzpJ20dxqSINQ
	CRwUOHJbWayjcAjl/GoS8mV0GZFl+zLH+pG03t4NvH/bl6NOUEohQtu7V/ZFWFcX
	iYd4HSeuHIVqDU0w9LOBWZK+1eKcHfK9G/9iCABj9hG6IqY7lP0UEOwscXTpI4X8
	t3cG14FBaFChsINOlwN9TOdVD6uUQ3QYrK8Q0r9UQhXxCg920ww2owYuRQ9kA966
	k/5fWew8fMwh2eoRJ4Xe1NiWb46gVdSnQ48EpT3Xm7aCMFiYPpM7o5QMYPpXcpXW
	N6/hwFJyFKesZh85fltdA==
X-ME-Sender: <xms:jF_Mac5a2CONYGXtvByq-HapRxMWpOP1N-_QOxS56PC07pqih92o6g>
    <xme:jF_MaU3SO6XsKKYPA2uxILs0Xuyaq5MS6gfIws7G6gXcgtIVpYAnlM85Jn8DYmKm4
    DvwGsSM1U_NN8pyeiQVuuitTFOfxLhLhznJtesRnlsUcXH4dkZn9ho>
X-ME-Received: <xmr:jF_MaREkiDocot9y4NulM1p-QGbQamvP5l8xO6kAHSxGSyEEo9HapAkhD8li_TcP0F2ZBDMXM8PF3bTksgDNHsKB8gO3dYsBZoeAG-8Nxzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:jF_MaWQigKLJXjM-eFeRf8gWR0V-xxNDe7va8x9leYOZDfQB7-s7Qw>
    <xmx:jF_MaQByyVyA2FThIfp5ZAsaeePP_KNgDjEneyUo-YXEEW41My3kvA>
    <xmx:jF_Mae123FfWxgCKdIur_kJD684H0Prbz9G7U_yXt_hetDIbQ66-mg>
    <xmx:jF_MaWWaMrOIFQSSOXq0mMESxQ3vbxnJ2CoQgP9HFgmju8tlZXBPjA>
    <xmx:jF_MadbSEbqF4OWHgICPh1pHpvWgOOfsn0d48dIXqHnQ7vy4yOZHsI_9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 19:58:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a19c73b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 23:58:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Apr 2026 01:57:49 +0200
Subject: [PATCH 4/6] odb: use enum for `odb_write_object` flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-pks-odb-cleanups-v1-4-89adba9ada68@pks.im>
References: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
In-Reply-To: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

We've got a couple of functions that accept `odb_write_object()` flags,
but all of them accept the flags as an `unsigned` integer. In fact, we
don't even have an `enum` for the flags field.

Introduce this `enum` and adapt functions accordingly according to our
coding style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 3 ++-
 object-file.h      | 3 ++-
 odb.c              | 2 +-
 odb.h              | 4 ++--
 odb/source-files.c | 2 +-
 odb/source.h       | 4 ++--
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/object-file.c b/object-file.c
index db1a420ab6..2146104de8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1169,7 +1169,8 @@ int odb_source_loose_write_stream(struct odb_source *source,
 int odb_source_loose_write_object(struct odb_source *source,
 				  const void *buf, unsigned long len,
 				  enum object_type type, struct object_id *oid,
-				  struct object_id *compat_oid_in, unsigned flags)
+				  struct object_id *compat_oid_in,
+				  enum odb_write_object_flags flags)
 {
 	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
diff --git a/object-file.h b/object-file.h
index 3686f182e4..5241b8dd5c 100644
--- a/object-file.h
+++ b/object-file.h
@@ -68,7 +68,8 @@ int odb_source_loose_freshen_object(struct odb_source *source,
 int odb_source_loose_write_object(struct odb_source *source,
 				  const void *buf, unsigned long len,
 				  enum object_type type, struct object_id *oid,
-				  struct object_id *compat_oid_in, unsigned flags);
+				  struct object_id *compat_oid_in,
+				  enum odb_write_object_flags flags);
 
 int odb_source_loose_write_stream(struct odb_source *source,
 				  struct odb_write_stream *stream, size_t len,
diff --git a/odb.c b/odb.c
index 9a11c60048..8220661356 100644
--- a/odb.c
+++ b/odb.c
@@ -1053,7 +1053,7 @@ int odb_write_object_ext(struct object_database *odb,
 			 enum object_type type,
 			 struct object_id *oid,
 			 struct object_id *compat_oid,
-			 unsigned flags)
+			 enum odb_write_object_flags flags)
 {
 	return odb_source_write_object(odb->sources, buf, len, type,
 				       oid, compat_oid, flags);
diff --git a/odb.h b/odb.h
index 083c25609e..9aadc1177a 100644
--- a/odb.h
+++ b/odb.h
@@ -561,7 +561,7 @@ int odb_find_abbrev_len(struct object_database *odb,
 			int min_len,
 			unsigned *out);
 
-enum {
+enum odb_write_object_flags {
 	/*
 	 * By default, `odb_write_object()` does not actually write anything
 	 * into the object store, but only computes the object ID. This flag
@@ -589,7 +589,7 @@ int odb_write_object_ext(struct object_database *odb,
 			 enum object_type type,
 			 struct object_id *oid,
 			 struct object_id *compat_oid,
-			 unsigned flags);
+			 enum odb_write_object_flags flags);
 
 static inline int odb_write_object(struct object_database *odb,
 				   const void *buf, unsigned long len,
diff --git a/odb/source-files.c b/odb/source-files.c
index 76797569de..b5abd20e97 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -161,7 +161,7 @@ static int odb_source_files_write_object(struct odb_source *source,
 					 enum object_type type,
 					 struct object_id *oid,
 					 struct object_id *compat_oid,
-					 unsigned flags)
+					 enum odb_write_object_flags flags)
 {
 	return odb_source_loose_write_object(source, buf, len, type,
 					     oid, compat_oid, flags);
diff --git a/odb/source.h b/odb/source.h
index a9d7d0b96f..f706e0608a 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -197,7 +197,7 @@ struct odb_source {
 			    enum object_type type,
 			    struct object_id *oid,
 			    struct object_id *compat_oid,
-			    unsigned flags);
+			    enum odb_write_object_flags flags);
 
 	/*
 	 * This callback is expected to persist the given object stream into
@@ -405,7 +405,7 @@ static inline int odb_source_write_object(struct odb_source *source,
 					  enum object_type type,
 					  struct object_id *oid,
 					  struct object_id *compat_oid,
-					  unsigned flags)
+					  enum odb_write_object_flags flags)
 {
 	return source->write_object(source, buf, len, type, oid,
 				    compat_oid, flags);

-- 
2.53.0.1185.g05d4b7b318.dirty

