Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AA322B7E
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039324; cv=none; b=DHQsjUFhu1kAvbD8THB4aCC5yotl7yBOcGImHCQrNlxXv4vvU/odr3eTY5ZPoEDtJO2GsyZi4ILQnMGSWz0a3r9tmnB2nqTfZBCg9XP9JYPq5faShm+3h2NPFsI8RGUVFueEuTowDIpz2YlDbxov7RhutcDm11rwyCk3+ks/e9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039324; c=relaxed/simple;
	bh=PHj4AQNcEZQygbdAoLifKggQekMoZ+i1UC05epRUQFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFdXTqTSRFirfE3mriW3qwsPoPudkOGmfb+l1bbVRkaO0oAZqNIpIzoXha4qTEkbNWQKPo8uvVwPahJq7C6AiXAANuPK/1ljkXNO7kyPnKB2a9C98J+UcA8zMNg7uTjMyuhi9dzmur1saBo4ODcI3z/rbBkIUce6fw87l/zd5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UOx68HK+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u9K3R9qy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UOx68HK+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9K3R9qy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE94A7A0177;
	Thu, 18 Dec 2025 01:28:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 18 Dec 2025 01:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766039321;
	 x=1766125721; bh=tVIVzWZnn/lwRk0ruzwOiVlcqvSnggAA5Re/f4Rcq+s=; b=
	UOx68HK+7sL7FNnMNBajM5lnvC759oK/oFJXFnn9NV79BirYMnV0ssbrYRM/LE6v
	QdmXeR5cCBUacQnBuRCSiWQ9JRa5FRIYwo9RBJtRM1OJ23z57XqiX3Z9E+7QBnLf
	3yxzj73IZUEhn7wCEwLLP4rXDv1R1p2sWvBtGwU2G1DXwHfucrupr2MjOTnT1bkv
	gLn1it6xnsRqiz4vgVuXxORey8QzpblG0ajKpw62Y9V5e3C839VAdWDacXHRauz5
	LBopNkvU1pe1Ik04Cdg5JL4GmceDwq/zil+i2q/txjafC70StrLIjAi9z823zPZx
	fmOk7qTJqy0DsswoCdmdew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766039321; x=
	1766125721; bh=tVIVzWZnn/lwRk0ruzwOiVlcqvSnggAA5Re/f4Rcq+s=; b=u
	9K3R9qydesrK9/OeYU7PfoHyf+ysL1iZPqmwHjGPUb05PY9Fd5Sfu7jDlf8GThOu
	1DJpsS7ak/sZUvwGNb0ke7neR14pl2/FfUFWk1cfkiI79plllR3fnwLlemUu6gx1
	kauXe6ACvdwftdHkt/w9ahKvMOIFYQg8rZs18bocGwDzTwdCJp7dOqaii6FjVRcO
	YgOFUzdaM3421tmTSSH9mDHFIWSPdJboOef/heqM3A2aRFKdGf+ub3Ergjlpft7X
	GCk9DIOJvvHRVozhfVIyB+38DFobACByqzx9Z9dJDleNqPpt/CEn4PHnz19O8PM6
	TQRKT74mD8GS5hpwN+efg==
X-ME-Sender: <xms:GZ9DaXXN8JcY0-J84vvwYr9zssDLEW72Bepj2X6Vw_laeOETMaR3tg>
    <xme:GZ9DaXCQzJnn6SY88MGr8yXJNgzDHq8k1RNKWk3B1Ro9yXruCJBsf8iiRHcZeaFzi
    lKTqWo0aVpRkc1OVwprmraGLQaAPbnskuCNRzuP6uiJXtQlct8pVQ>
X-ME-Received: <xmr:GZ9DaQwonMH0AzfZys_FFlSnQvTwEIydcABxnSinv9_ZEa8Fa3ls9hpLR2iYfA9oAfXz2EgiyPXSyZPX-GRPoY7NbRF4P4DHZ6kS-ZuXQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefhueegleehfeejkedtffehvdfhvdetfefgtdduffduveevteegueeutdekhfegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgr
    rdgtohhm
X-ME-Proxy: <xmx:GZ9DacBYUve2aZlV61QWKrOUQ0GkvhH9dwPBAuO-qguXN9gVuNDnPA>
    <xmx:GZ9DaVbFLQX6-vktVsIVd9QY8IVboyIEsURGYsv6hEL__wCFHDe3QA>
    <xmx:GZ9DacjKod0_JVBly_pGRdySWYyu8D4K6P6fyq6NOm5HnvYmfVOtFA>
    <xmx:GZ9Daf4QRoi5RrpCKN70VUYl9ag_Z88Fx94HZp31Dk1vo41674tk8A>
    <xmx:GZ9DabqvpzrfW-SzsAuGRYXK0jIIsj-pu55aRb1N_0Ah7-Yab32snZ5V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:28:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 184b3395 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:28:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:28:16 +0100
Subject: [PATCH 6/8] packfile: skip unpacking object header for disk size
 requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v1-6-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
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
index c141b8a7b1..d2ae2432eb 100644
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
2.52.0.351.gbe84eed79e.dirty

