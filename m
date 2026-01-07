Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3731AF3D
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791304; cv=none; b=PjVyM+kLa6nniYUOODNlW8V5KnPnHuls38Fy+9u8Q2ZSjHUEUchR7FV+I0qhX0OZYsbkkqdcCUIu4gegWWh2ld5+nPEMLV1X4JCquZV5foeF3L98Hqwyi6uBmAKICbG82zZ0dl+eh3OdLkShrypL1dC+0yjsyUoCwn2WTcykaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791304; c=relaxed/simple;
	bh=i3Ut2EZunG6uKm1P1ydVxCMWxK57p47JxvbvXrNRj1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKbDPQ+gryd72ZilhiY8jVidKWY/LenzRrGeriaH/PfhzbwZzZ6ryvy8Vds9r7kK9iwydgfD98nilh2SwkwTBdh6zDbspRWZhRLMIND33/jt9vhoFUmscUdv1eBoHouuwBoWjBLUPgz+CzhNbq05CONuTpZGbjdNHvTzxlN+ydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=asceMGvY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jozZBu7x; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="asceMGvY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jozZBu7x"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5B261400109;
	Wed,  7 Jan 2026 08:08:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 08:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767791301;
	 x=1767877701; bh=192rbICapFyGrEVVTdyMtkZwzHkkLehaZi3H0oVJDu4=; b=
	asceMGvYvgjHToE3WtQrTebBkCsAbxp+f7Lkk9HI3WwMSoYw9IyLZUBjwvzabYZt
	+IUHb+M0XMLITiOApNXP7S1g686NqGm0y6i6j0bV9Ns87DCAxZQO2sTA6fQrr0cF
	v7MbOsL43Gf3mdEpOWmi0yJBMja4kYCfhglUSgNDe05XMZopHpQjCoXjfgzpvYvC
	2YFnAGjYMZGgaV6Q+aD/hTQtdAxg9g6mehMrBcO9AYV8V1jFdW3ZUFn6SjvmZza+
	qcZFD6Oo7G61lLspuNjLHRdEjExaEXREImJejnpMi42wvFaDAbF1BTdHOZhggNIS
	nYgiS5AvhrMnnmP7PdFLSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767791301; x=
	1767877701; bh=192rbICapFyGrEVVTdyMtkZwzHkkLehaZi3H0oVJDu4=; b=j
	ozZBu7xVnIea7jiGIthTxPNEAPs1dcRlURuUXSyHSmDLzPTQf5IqZ8hSSKNKF0zu
	1ZV7z9+fkXtRZCh+xpkFZ2xpTjMZWiFFy7LOCtoYIKNewQjomZEUPAY6ptLdOdv9
	wGpueCXdibRfOWJa4fEC5vu3XlBXwkCUO2uPDhMvtXwpcT0rwmUqLF588vqR9frS
	woD03XL5dCX4AkbdHzsUYdgPKWWqwpOzjxmdpgiJ/GRs6AbCGWDm0Za/wFEZ59N0
	3eKxkU2E+X1itoDn2BdIOxp5q7IcQDypGy1vz6GoEWXT7ugjB9DQ3+dJe02wjM8/
	Zalic8Al147rgg2sDB99w==
X-ME-Sender: <xms:xVpeaWVL-tvum5apoYyXVMqzKaJEMVXTlhwUuWgw2kTMBtOwsqzEPg>
    <xme:xVpeaWQZ3JednRbCGP4XZkJE4LEmybHKCp2IZOE3_POc_SPj0PTOFFvFThUF5uO6Z
    RKTW3d9kc6yg1elVKqgaD5hEieNP8YVXUSEtYRb8ydwKAUaffXB>
X-ME-Received: <xmr:xVpeaUMCetDZgYF4lArkQPID9V8MKVjUhJf8tbD0xiZj8dsXtkVZjHJu2BhTEQvvUeojn0FucuVQFSDxoVFqO4AvvVbj7jrc9RCQd9PXEs4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xVpeaUSYrHX-gia8Uq7O8kzg67HGAoVcWa3Sj41qftWIrFB8iQnz4A>
    <xmx:xVpeaSi8b-h9GofyTGcC89NIIpWfeM7llOM54wpwv1pCL2lo2eqq_w>
    <xmx:xVpead8rrw754N08cZzGMquQkvkTMQHqesv0usF5dF5x9G4abFd0NA>
    <xmx:xVpeaZF-nIOGBQonakfJHt_BOQ6B5zBc_ZGMDs31dHVfJbxLgK-QZA>
    <xmx:xVpeaVV2U2M9hDeapiU325um5Mrb79xTNWdsqlonJfsOfRKytl3dxbRn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 08:08:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c220279 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 13:08:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 14:08:02 +0100
Subject: [PATCH v4 3/7] packfile: extend `is_delta` field to allow for
 "unknown" state
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-odb-read-object-info-improvements-v4-3-b5d55c47082a@pks.im>
References: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
In-Reply-To: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The `struct object_info::u::packed::is_delta` field determines whether
or not a specific object is stored as a delta. It only stores whether or
not the object is stored as delta, so it is treated as a boolean value.

This boolean is insufficient though: when reading a packed object via
`packfile_store_read_object_info()` we know to skip parsing the actual
object when the user didn't request any object-specific data. In that
case we won't read the object itself, but will only look up its position
in the packfile. Consequently, we do not know whether it is a delta or
not.

This isn't really an issue right now, as the check for an empty request
is broken. But a subsequent commit will fix it, and once we do we will
have the need to also represent an "unknown" delta state.

Prepare for this change by introducing a new enum that encodes the
object type. We don't use the "unknown" state just yet, but will start
to do so in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      |  7 ++++++-
 packfile.c | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/odb.h b/odb.h
index 73b0b87ad5..afae5e5c01 100644
--- a/odb.h
+++ b/odb.h
@@ -343,7 +343,12 @@ struct object_info {
 		struct {
 			struct packed_git *pack;
 			off_t offset;
-			unsigned int is_delta;
+			enum packed_object_type {
+				PACKED_OBJECT_TYPE_UNKNOWN,
+				PACKED_OBJECT_TYPE_FULL,
+				PACKED_OBJECT_TYPE_OFS_DELTA,
+				PACKED_OBJECT_TYPE_REF_DELTA,
+			} type;
 		} packed;
 	} u;
 };
diff --git a/packfile.c b/packfile.c
index b0c6665c87..cc797b2b6a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2159,8 +2159,18 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
-		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
-					 rtype == OBJ_OFS_DELTA);
+
+		switch (rtype) {
+		case OBJ_REF_DELTA:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
+			break;
+		case OBJ_OFS_DELTA:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
+			break;
+		default:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
+			break;
+		}
 	}
 
 	return 0;
@@ -2531,7 +2541,8 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 	oi.sizep = &size;
 
 	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
-	    oi.u.packed.is_delta ||
+	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
+	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
 	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
 		return -1;
 

-- 
2.52.0.542.g9473a8513b.dirty

