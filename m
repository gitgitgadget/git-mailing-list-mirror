Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FB25783A
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682508; cv=none; b=dOLWU1rzwPQ4xCfUorTfef5qSRbRVt93mnKrApJ+6SLzmKK7xvX90YWk7yN3A9lbX6fwM8fBHvYquuNBurBKa7DF70wjObSj7VXtopNhruArAZbN9YRFJQEh4ZVtIJrK0yiFsHP35RKFE3+Jmv5B9r0DpP/aSFv3L5QP7yvckAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682508; c=relaxed/simple;
	bh=yQYaAdW0KEjpuC1Z8dFbFQSC44zbQYMnJBiPCh9UXcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OD7IGaqYEx7ETGAkpifWuGKm8ItdjxtkKCPJizh7CPTTSjR21uxHy1MzanBbk1GDMCQM/3+V45E/5jMbiyqhUXeiNqPoIF0MPMVBpe3JireQ5GTNO2VOX+0gATAB68BQNhEGrTytjtJly2hWZqpU1YbOcvRYeTVCb+ODZ/DNy4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C/hXMnzB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IGafZuHN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C/hXMnzB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGafZuHN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FC9A7A00E7;
	Tue,  6 Jan 2026 01:55:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 06 Jan 2026 01:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767682505;
	 x=1767768905; bh=KGESEHB4+82xdwk0HgzRtchqQHc60HZhbvFQHSaWpr8=; b=
	C/hXMnzBItUL1NPP2fueLrt9U1MWbYe+lGgCx62LSApT0O80QhfIntS7DG4lg0pC
	6afcxMEWrsy6tuMnmVoEPcHv/f2b90SbCKGvbhspmD+6CEQSfiHAzSY9DCH9PMZY
	zdmQ9F3ehqiSxd2sgnVpzmy4mAj4zDQk0+vDDoYnSc6OKzLBAOdpxbczue4V4vHD
	xD32a9JdkWmB8ipTqdJmf3mrRE6pt2cSX4+JgOGZci8lxkVSBqT94ficWREUvJDe
	RQMEkGT8Zcm/nimntVmwDklCJQl2gNcXYYj2a6m4Yi7ywijGN68PqM2euDLpEOGz
	qjsgVbtDSPU6EaZT99VIbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767682505; x=
	1767768905; bh=KGESEHB4+82xdwk0HgzRtchqQHc60HZhbvFQHSaWpr8=; b=I
	GafZuHN4RZGqsFrxqDTqSIaFoY3FdHwSc+ZckR/Mma4nz1hJaDKnCODetfFCkkOT
	LM3df+EDEX76vIWSF/eYSebu4gXd38pUds+gGYh3D1A+p8Q5/coM7jO5x5jxRO53
	iM4J5tlMSsSfB7mah2DcogcCbvKBuXKY0unwPaLFouyELBWvZr82YP9wxBYLJnET
	Y1rSYUQmURm31PupFCeUEwj0tBxMuFvyDjqGJVKhIh7PupLk1owBO9ji7Pj/Ud+G
	L3MUUJFcaGs/lcT7uHVI8gj95w2qqvfTZhLqvgl84bM/ImhXnJfJT+/4z4pGeDdf
	dn76mmTCtTN1NwvhpZf0g==
X-ME-Sender: <xms:ybFcaYrX4O7_09Y-poZg8LCQOvZxL5Wqcs9bcZiHyv-psiDsjoCYhA>
    <xme:ybFcaVioxjFHyS3mlaMPrsVHYUw4S5iYkkkbOmChc5mAXtkb8GPT-l6xDiEE38umO
    E0vZj6fo870kJBxWUKCP-fyM3KZ4-Yd9DRT5czatXYMH3p154oMoQ>
X-ME-Received: <xmr:ybFcaVhQB9EofW7ROsskuDkx3yS6JZJWEIuS9CRA34Y-UB-6E-hNesbB4LTphsaAVWwvnDA0kDVgAjO2C6y-IGDwyKFYWOhxHqq0ljn1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtgho
    mhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ybFcabhvDXkBGCwclclGRiYowyzRXMyhp-kE1XjoHVBB6_0ieZthsg>
    <xmx:ybFcaVKezV-wi_wku2tUd91jy6RtxYbPq2JagC_v1Z3pD_9EnBgiJg>
    <xmx:ybFcaaFuXpoz4BdJvSTa9OrVoRdDSPMlK9a599HL2n2ogN_mXIWAVQ>
    <xmx:ybFcaZQIP4Jko3H07i_42gZYjafcc1aWgpt39eYmnUupdeTc23romg>
    <xmx:ybFcaSE2iG0SAgPo0AETaOMerlcMir-0M4_4kT2F7prZUehE9-OzYpGM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:55:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 11cf4406 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:55:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Jan 2026 07:54:57 +0100
Subject: [PATCH v3 1/7] object-file: always set OI_LOOSE when reading
 object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-b4-pks-odb-read-object-info-improvements-v3-1-b5e02fae1fb0@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

There are some early returns in ``odb_source_loose_read_object_info()`
in cases where we don't have to open the loose object. These return
paths do not set `struct object_info::whence` to `OI_LOOSE` though, so
it becomes impossible for the caller to tell the format of such an
object.

Nobody seems to care about this right now, but it's a bug waiting to
happen. Fix this by always setting `whence` on success.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 6280e42f34..d566df427a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -439,12 +439,23 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	 */
 	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
 		struct stat st;
-		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
-			return quick_has_loose(source->loose, oid) ? 0 : -1;
+
+		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK)) {
+			status = quick_has_loose(source->loose, oid) ? 0 : -1;
+			if (!status && oi)
+				oi->whence = OI_LOOSE;
+			return status;
+		}
+
 		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
 			return -1;
-		if (oi && oi->disk_sizep)
-			*oi->disk_sizep = st.st_size;
+
+		if (oi) {
+			if (oi->disk_sizep)
+				*oi->disk_sizep = st.st_size;
+			oi->whence = OI_LOOSE;
+		}
+
 		return 0;
 	}
 

-- 
2.52.0.508.g883dcfc63e.dirty

