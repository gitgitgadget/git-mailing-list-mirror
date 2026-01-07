Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694A315D2A
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791312; cv=none; b=W5d/nb/YIM8QcSOcSWJvTqG/u3VVG1d/EOHCrXuulhzkBSwv0e8xRvd7KMdJtwJvFDqv94cdORJHgsRBcY14KKSZhpTBlpPH4PbgU/a8Xgn4yU0znweu9L9skIeC7w+AtySE8Jn4aOArc5xmM95nxwg9b9PbnoBBSILeHCIdQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791312; c=relaxed/simple;
	bh=EZaAdP3xdhD507KLyYkOjspLg7dXAtOg4kveRSnsmK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rF5sRYxr9O582rKkS+yKzXxRo6cOB3H3+5jOM6OzeKtCtmoNoESERcBf4X3d5af4RDT3ipahwPNiQxiEmn2nKJ2IsCQdE3SpqBktJCTKJ5pCwFAD0b7l8384Ld4+Z0SUlM9DYC6+wFvQnYjanRGtQ9NC2RECiWBmd+Soogl9g/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WeV01zpq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SWAqXqDY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WeV01zpq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SWAqXqDY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C8208EC026E;
	Wed,  7 Jan 2026 08:08:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 08:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767791309;
	 x=1767877709; bh=+Of+5teqrUJb3PJBCugXm7F0qnppp5DuRfT6Tz1fquU=; b=
	WeV01zpqAkm7xCAEwuaHKM4hfwVavnf88l3McBWR6JRwhEs2BhxDfNZpAYlVtQk/
	VMb5CacgYj8qinYLTfmOxQRKTtDjF8qkCZrkWeBI4FENTLPyTIGaI6jkngVo0WsC
	98MBRy9xsr3zIUTOatVvkFnlYj+7xUH9t1mZ4vxEGD41npZd9jJL2Ws1V4q47GSW
	TGFhTt2x6ptyZO0r0SztX92PbHtJ029lRI55lYFnyqzTEmkV0BzEtFbUdHr7dDo1
	nyAkVNAiLdGc3NpPIRJCECvLcRBBqOuAYGM8DQvgl3FflUAXlYfi5JwVx3KFc3Z7
	RVE5Dztjyt2LxDBK6aXlOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767791309; x=
	1767877709; bh=+Of+5teqrUJb3PJBCugXm7F0qnppp5DuRfT6Tz1fquU=; b=S
	WAqXqDYNVcMhOLxLPx6+B0teTJxcNupAVGShiD08DKrkmt4FVgE70XBMGi49/9Nc
	D0kCptGd//o4fxdD7JYq7E11Gx6S/mYizPCzftDQsBq34s9SIQGQ4Z4CUEzsKGNd
	MnpCQfpRqRR12oTNWDUXVxjQnSoNvpA1a2E+zE07MUR2d6IgpnHMqNqhfoSNFrau
	08VWLOnXRf8rfBfhZTR4A8SJRDkW9sXGZfzE+ytvsqMuS5DwA8BNDX+wy9MejmRK
	llDnqqsAB5bVIlUUR6pDLICI1o0sTN11W1OclxSx1tv5gJ0Ohgrj+UVzs5BKqMMn
	RS1IFrGk9UVnJALkgGlPw==
X-ME-Sender: <xms:zVpeaQihEE8D3zxSpYHF32lN1S9wsDrulcvnUbU3t7hUChDPw52eTQ>
    <xme:zVpeacsBk_VW7Vf5Fh5rec_eiqwRVi0jCm2jSZZaMfmNSNEaTWJYE5IftH2lf5CSV
    _2DNURAg7SfJeseRWJ6Mjgu2Lg3C_QclO-OfW-uRLQbVQWcwvDYQV0>
X-ME-Received: <xmr:zVpeaR6AG52cdwGH9mbuSSUy9EQWhlAroD5dT0OItF5getMMrVfvmXUJzjPUhKjz-2kOZVO6GenQSg1nFGNvVF0wjk60jv1WBp0Ffvyyn4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:zVpeaYPwZZ0knLFqpWgWH5jK7AxgXIC24SLBppzWL_TjKCaJDmRfaA>
    <xmx:zVpeafvotlO0MG7MA1M6NajvLc8X0RieeaCoLpb-jH5Oa141hGDubg>
    <xmx:zVpeabbTxvoFbh4ZHQhluVzr4EHYDEjQbtMrnmx6b7_ZlzEWpMCakQ>
    <xmx:zVpeaRwfrna23vjbmt09gJ8jpg72wd7m9cpK_qPTjfaYGfi_i-4ckA>
    <xmx:zVpeaRAhtyDb50CVX2M4FwVLGnowWMBkpOsLr38Qe5bBNmo5Ad-dCm9Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 08:08:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b3966b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 13:08:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 14:08:05 +0100
Subject: [PATCH v4 6/7] packfile: skip unpacking object header for disk
 size requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260107-b4-pks-odb-read-object-info-improvements-v4-6-b5d55c47082a@pks.im>
References: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
In-Reply-To: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

While most of the object info requests for a packed object require us to
unpack its headers, reading its disk size doesn't. We still unpack the
object header in that case though, which is unnecessary work.

Skip reading the header if only the disk size is requested. This leads
to a small speedup when reading disk size, only. The following benchmark
was done in the Git repository:

    Benchmark 1: ./git rev-list --disk-usage HEAD (rev = HEAD~)
      Time (mean ± σ):     105.2 ms ±   0.6 ms    [User: 91.4 ms, System: 13.3 ms]
      Range (min … max):   103.7 ms … 106.0 ms    27 runs

    Benchmark 2: ./git rev-list --disk-usage HEAD (rev = HEAD)
      Time (mean ± σ):      96.7 ms ±   0.4 ms    [User: 86.2 ms, System: 10.0 ms]
      Range (min … max):    96.2 ms …  98.1 ms    30 runs

    Summary
      ./git rev-list --disk-usage HEAD (rev = HEAD) ran
        1.09 ± 0.01 times faster than ./git rev-list --disk-usage HEAD (rev = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 8c6ef45a67..a2ba237ce7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1586,7 +1586,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
 	off_t curpos = obj_offset;
-	enum object_type type;
+	enum object_type type = OBJ_NONE;
 	int ret;
 
 	/*
@@ -1598,7 +1598,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
-	} else {
+	} else if (oi->sizep || oi->typep || oi->delta_base_oid) {
 		type = unpack_object_header(p, &w_curs, &curpos, &size);
 	}
 
@@ -1662,6 +1662,9 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	oi->u.packed.pack = p;
 
 	switch (type) {
+	case OBJ_NONE:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
+		break;
 	case OBJ_REF_DELTA:
 		oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
 		break;

-- 
2.52.0.542.g9473a8513b.dirty

