Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E2334695
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429881; cv=none; b=CI8pmlvmzxlNi0I6dX6LAJA+AgLk93sgM282eHyBAZ8iJx8+cNxWqIdvEFVwnPEJKgmWYPLXXkIwdxXQuCgsOcQELZaP20VQF3Yz87i27kuaw3PVe5tyz3zLNElC13McRdQEORlFQFeVKGnqLugsaBoW+eQkDXZQQ1DC16atZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429881; c=relaxed/simple;
	bh=lAZfWQDLHyqlepoeXTau+Eckm+YL+C+zGZA7VQ0jO0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBaRX+U01JQ8GRNNdWSRlSv8kTyhiuWsSrwtgjFxPuO2DSrRiuVJR+w2FPNn1Lps1li3JVUKPlg6YGc9phFoV4h51GXV6jvx6ZoYYtx3l2VfpktJO2bC5o+/td4BVrtqAs28y+dJ1m/FA7Vz/g5Lv1A2C/ReGt0C/Cd5Mgtod8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fHxH4uvN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LILDmMsb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fHxH4uvN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LILDmMsb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ECA00140002E
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 07:17:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Jan 2026 07:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769429876;
	 x=1769516276; bh=djN9NQYQXT9vN+4ezNGS9c5ZAAO8uIbRuIb804I7QqQ=; b=
	fHxH4uvNIL9wRD4B5sNzNJy7Dp3UsBpcT5lIkNdn6PZW3HN4+osNPt/LrVFnFzW1
	THY5n23jx5mRZUhO1LVTx4BLHLGGAKh3Nz1gjL9CwptTYQ7pO7rbRtKY3/cr89/L
	eIa4h+6C5HHVHBmWkV0gxnAqgiV+UDcRrCUFrokC6wcRZQI6X9iUezFj4BYnjXco
	NZHrRB/YZuY1qR20yPKdvysAEMZb52/52V2L5mDAnyzpS4YgUNIu4KUmcim7Z3uA
	r+7ZRzxOwLH91FqLhD4JDUvCK5rFomd0ZHpBukJ/c5pzdHujx2AGZ6PhWCB9TZ64
	2/GTKMhzLelvSsAwQsRkeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769429876; x=
	1769516276; bh=djN9NQYQXT9vN+4ezNGS9c5ZAAO8uIbRuIb804I7QqQ=; b=L
	ILDmMsbK15c/k6PkcnVd6c5w8xX0f8h+zAeq4wco6wkt5INAEVPGM8ot62O3cnXl
	UoOLGcgFlzvjVsc8CeLnNEDl4aNkA49dSE5RSKrlWKrTlZNFQq5lfTRer+O9MMPj
	vJqAEQ9ad5DXzqMsL7V7i+cIas9yBsjtVzy6qSEjtIcMo+axplgOSCI+Kgp7urbt
	IhoGC8v/HMUqj5ELRHQ6EQzNPBkRJ9DMdyxA5KskU5YURmA6faCMk2VOlmZI4UKN
	RCfdyfawQSeETRutssKG3IdKgo8mutDQeJ6qlV32ojPpmJYf3gqHyj9JU3xAI+Y9
	nAzI+MiZWTOGe0D30J6SA==
X-ME-Sender: <xms:dFt3aeh97dPLYATWloEjSLqi8cSbpnBWaLh03e7IDGR_Mp40cIFUwQ>
    <xme:dFt3aV8gvYN1VmnXvSQrs1sxANz7-Na9u_sQ26Vb45V6_7-6ROhXRnEkzE1jVXmbG
    LURQbA1gYfN9y5JOkZ4cApBBbluAcsBR2VqaMUorLSbSmUIS80-Dw>
X-ME-Received: <xmr:dFt3abuNUrhdQx8GTM8X7NtUX2IAt3bbmz77Tdoq9TJA18RaxOtaeVEEGzMljOI7RwYXUgpd2J7KLMtuZ7D5LImcaoEHxS6rFJ5_zDq99jSLCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:dFt3acbbVeGyWEbGPV1W36m1fW8RHR3_7XxyPjk6tjedEUkWmTdULg>
    <xmx:dFt3abpsrwSltXZUIntK87GZ9i1sbuGMXiosAMqXUgOJV-7zjEB-HQ>
    <xmx:dFt3aR9Ug-NVd0CzhPW7o1yphAr9yiye-WbjEN5ZF2FdNr5DqSK1eg>
    <xmx:dFt3aa-0EVqaqulZUzK7sIyzbf4mKRzVVFDxDi-VFkTRyeZwxTvcKA>
    <xmx:dFt3abioMBo5uo2uLixk4fz_auYsaHcbcSXhxK4F2gLPdpW4HkVnPkIl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Jan 2026 07:17:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b1417c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Jan 2026 12:17:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 13:17:42 +0100
Subject: [PATCH 2/3] builtin/fsck: fix flags passed to `odb_has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-b4-pks-read-object-info-flags-v1-2-e682a003b17c@pks.im>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In `mark_object()` we invoke `has_object()` with a value of 1. This is
somewhat fishy given that the function expects a bitset of flags, so any
behaviour that this results in is purely coincidental and may break at
any point in time.

The call to `has_object()` was originally introduced in 9eb86f41de
(fsck: do not lazy fetch known non-promisor object, 2020-08-05). The
intent here was to skip lazy fetches of promisor objects: we have
already verified that the object is not a promisor object, so if the
object is missing it indicates a corrupt repository.

The hardcoded value that we pass maps to `HAS_OBJECT_RECHECK_PACKED`,
which is probably the intended behaviour: `odb_has_object()` will not
fetch promisor objects unless `HAS_OBJECT_FETCH_PROMISOR` is passed, but
we may want to verify that no concurrent process has written the object
that we're trying to read.

Convert the code to use the named flag instead of the the hardcoded
value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0512f78a87..1d059dd6c2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -162,7 +162,8 @@ static int mark_object(struct object *obj, enum object_type type,
 		return 0;
 
 	if (!(obj->flags & HAS_OBJ)) {
-		if (parent && !odb_has_object(the_repository->objects, &obj->oid, 1)) {
+		if (parent && !odb_has_object(the_repository->objects, &obj->oid,
+					      HAS_OBJECT_RECHECK_PACKED)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
 				  printable_type(&parent->oid, parent->type),

-- 
2.53.0.rc1.267.g6e3a78c723.dirty

