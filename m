Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2B233939
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303577; cv=none; b=Tvjw7kb987a50CGT6lWadvIaWlgkXEIS+GibLWXoFq6SGqanbC/MyO05gDnJ4xDb1MvPP9Aka7LctbpYBzjxEmjCRXVskXrrXnq6VWSSw29TukTetVM04ruyVVRSgpgDtGJt1n2/jQK48HcKvcvEpU+iXGXqtmokd/yndM8zovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303577; c=relaxed/simple;
	bh=UnIZmh6x8/UvQ5MIOdVjKHm0PgZwQmjaeG0oe95P5Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmTq3AzX6RE7fDSnibojsT166Z59uBVoKVn13fzXgWcoy6ljyJzWdqAumQekdg3kMUP7+f80ni1j1nauiTWNLUvHcmBIwGNfptPWj7phLeYygsIooevgAETmkd9KhdABos8zbJjvSuy/2WDTB3l4DyKOa4UlJv+JcPitI0Ks1qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u9Joc1rw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HHDLbcWK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u9Joc1rw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HHDLbcWK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C26CC7A01F3
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 08:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782303575;
	 x=1782389975; bh=h6ASSlOIXJW6/rMPIsCXlZnn9kO5FbAQkCfPogqOnLE=; b=
	u9Joc1rwJCWKOttvAc60+N/WzBveXIAwQkAq158T0vZHlCiLub2VBO0nROKp29zh
	jEbbSvnJq8rebsavjQwLyompAgD/amlOPNBjSNksNUmUwWu8UJBQh4ffM6G3A8Wr
	IEYekUuH8+X3iivfJzmIs62giodCnWXg7aUiG5pxFm/XnR/2svaaaoCq0tPL6uP8
	1KmEL0kpScBMjx+pIDkELytejE6Q+dZXKag9FaRY8TeCtbNUAN9BNt11O5X1/ZHF
	RQh1BQ/Nzab253IxhkXJBfIiN11YW/lm5ABdkNxTSAdipkxbrGelkE3IG0Whf1J4
	OFofOwDhu6Q6e8WIIsELNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782303575; x=
	1782389975; bh=h6ASSlOIXJW6/rMPIsCXlZnn9kO5FbAQkCfPogqOnLE=; b=H
	HDLbcWKTOOr8+/uJrZUzwSvgPCPsN+hzkNzlwaZhu83nLTNgM8QnHd/WeKX3aofz
	ddc8CxL9uAYgYFmYie8JI0RkJGOWOy2YzPXHhCGBroOEPogTuhxJ1rIgWkP60C2Y
	iU+nDkEEgm5bstgUjG12xzNEsY1Vf8M9AedUd/RtcQf/SomvTa66SM2GeX5hqpL8
	pRcgjyg4cqSY096jIqDYyNKYUoBeXF8dNArDxxDSmFUQyBipj0BBuykts2secTd2
	qYjECWt3ZhOuMrvbf4kgDJYS7h5dA8TOO/zcRVO2GhlvCTHuVX22N4xwwENClkFZ
	RDtyewuaUhYDi/964rx2Q==
X-ME-Sender: <xms:V8s7ars-wXPhkpLiLm7e0fpBIamJF5n0Dx4AJiMfrlXSYXDroXc1fA>
    <xme:V8s7ajbMp4wwAly9yQTzqYdDDsZiYenU0EALjINwD9lJhUaFTTC942SxJHtS8MHHc
    HT2mhSkN0hk1ZeOLEN0zZs4OjY3edHXTGYHhylCyOyUNvExmxFytg>
X-ME-Received: <xmr:V8s7akbi1DbKAENpkbt_Tc4sRW-s6LWtG_YEDoowtdfOORpxKrsXLnZ5CNz_viJ3NNKLbaIaNYDJMHDjcR-SBIgdjejGuiLi6P0OJFHZ>
X-ME-Proxy-Cause: dmFkZTFVh6D862S6VBqcmVEy3LZT7X9Dr9ZcbcC/r8onMxjGBYgXIw+F7qGLbxWtDokSKW
    36bwteS+dolUZGiHwhtiTXHExEhDcH+KBaBCil9fvQttZIR4sCOcDYkkT0XQGnpmcn00IW
    7NYKzieVn9HUx3sKMOsnU60EphryJUs+jHV19qp+IMhJIi0tvGM70CIdqutmp14uptQxRP
    8KzDOfcSer466MfnPRk0k5MUfMdL/nYXPsLQ5HMaS2mgW5VLpddw2xSvwepfJRkqn/IBoU
    4uYP1/q0QT79F7b07nXu1Sw4s78EKUcbnRz0dVpvzCrOY0BrG6BEHRnAihnrK4Tx37yODM
    YvOSXqmootzzOYxNL/0z0fDyOqwBHKP4g3mbBB1rG6i4CwT5cy0pZRhS3FfsQ6nYyJTJGH
    FAW3Zi9lZKNcNPBEKbCpKrcfrh+SG9G4P1ETsO2lKMIEEMXM9MSTuHd10xFscUzcT3eh6c
    vDnN/f71qkchVEqLPjjpQpcFRrSuOJOkAnM6m6QArfZKSf69qyTNSHf9cY1gGqa3f8UR7S
    XqMM/1qH3yHOBiAN9Kb7RagtM213PWq6sa7uQtkwW8ugzBZdeysQgeYvd7d3qsDmALbGzR
    eYEDyqqWITQWZ71keCeNWl58jjwua4sKtyWZWEG+l4FcSzQfuaVF8eANf+1A
X-ME-Proxy: <xmx:V8s7avW87FDgFWZ1t4N0-ZmroteK6NDsXr1_DJ4u0Wnxtk4wqW0Ocw>
    <xmx:V8s7ar2HkW-fa4PM63UMQc6YCI_ZMJyCsobi5sPmKN7gWs15Ewid2Q>
    <xmx:V8s7amaG0QpnclY--pV2yYv6aGBkBIi_wwX-1V0rvrh8jr1O10Lf-Q>
    <xmx:V8s7aurm_EKiyabZaM6H2gtfqRr3RapZkk6J8YZcNQn8v15_VmBinA>
    <xmx:V8s7aqczjkZjE90fGT2TYbyNkD0JrQ4ILRxQL8dtJaEunbKlw7PyV9cc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e089d02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jun 2026 12:19:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 14:19:16 +0200
Subject: [PATCH 3/6] odb: add `source` field to struct object_info_source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-b4-pks-odb-drop-whence-v1-3-8d1877b790ac@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The previous commit introduced `struct object_info_source` as an opt-in
container for backend-specific information, but for now we only moved
preexisting data into this structure. Most importantly, the caller has
no way yet to learn about which source an object was actually looked up
from. Instead, callers have to rely on the `whence` enum to distinguish
the object type, but cannot use that enum to tell the object source.

Add a `struct odb_source *source` field to the structure and populate it
from each backend's lookup path.

The `whence` enum is still set and used by callers; it will be removed
in a subsequent commit now that `sourcep->source` can identify the
backend on its own.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h                 | 3 +++
 odb/source-inmemory.c | 3 +++
 odb/source-loose.c    | 2 ++
 packfile.c            | 6 +++++-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/odb.h b/odb.h
index 770900289a..330a55879e 100644
--- a/odb.h
+++ b/odb.h
@@ -253,6 +253,9 @@ int odb_pretend_object(struct object_database *odb,
  * more about how exactly it is stored.
  */
 struct object_info_source {
+	/* The source that this object has been looked up from. */
+	struct odb_source *source;
+
 	/*
 	 * Backend-specific information about the specific object. This can be
 	 * used for example to uniquely identify a given object in case it
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index e004566d76..2328e62687 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -52,6 +52,9 @@ static void populate_object_info(struct odb_source_inmemory *source,
 		*oi->contentp = xmemdupz(object->buf, object->size);
 	if (oi->mtimep)
 		*oi->mtimep = 0;
+	if (oi->sourcep)
+		oi->sourcep->source = &source->base;
+
 	oi->whence = OI_CACHED;
 }
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 66e6bb8d3f..5c4e9892b5 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -196,6 +196,8 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 			oi->typep = NULL;
 		if (oi->delta_base_oid)
 			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
+		if (oi->sourcep && !ret)
+			oi->sourcep->source = &loose->base;
 		if (!ret)
 			oi->whence = OI_LOOSE;
 	}
diff --git a/packfile.c b/packfile.c
index 688c410b35..fa22095b75 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1324,7 +1324,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
-int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
+int packed_object_info_with_index_pos(struct odb_source_packed *source,
 				      struct packed_git *p, off_t obj_offset,
 				      uint32_t *maybe_index_pos, struct object_info *oi)
 {
@@ -1424,6 +1424,10 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
 	oi->whence = OI_PACKED;
 
 	if (oi->sourcep) {
+		if (!source)
+			BUG("cannot request source without an owning source");
+		oi->sourcep->source = &source->base;
+
 		oi->sourcep->u.packed.offset = obj_offset;
 		oi->sourcep->u.packed.pack = p;
 

-- 
2.55.0.rc1.745.g43192e7977.dirty

