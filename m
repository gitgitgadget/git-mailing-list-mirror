Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7AE4968F5
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993738; cv=none; b=Wpe96IaO4LPo+bbpyYAnvz1BD47CzZ+s73yNUjXtQLaNs696tdQq9x00SO70QDNp+mzLzsf2RfswRNHeXFFjym/h0oK12cIutl9zrcZiozP7nO/k7kRMOjETYHbq9JvWMDmpzm9y5Zd8P/UVbTvEsXCt1bxaj4m2IVpJN67Z4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993738; c=relaxed/simple;
	bh=FUNmp9nL+GfSmio6MtSry5UgPAl6KJh2LuN6tBur2Hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgcDA0/jAwYhmYWzM5ZMXGELyqdOmTDPW0nUOSC2vENcTslIx0UNO56edfAzSXn7nOJ/aFGwIfid82cYRqNjc5PO4NMJvytSMIfnG7ZLbETCOQKV220nZt4Tg/oHETI1bVbSQgf/NAu/dZyKmYN9Nz1Y5l7QZx7cVBQqJl0dIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mliek2nT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VXB8B4zh; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mliek2nT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VXB8B4zh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C23E7A00B4;
	Thu,  2 Jul 2026 08:02:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jul 2026 08:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993735;
	 x=1783080135; bh=pw+KJl3V948FP0NFp+sDffTfVZpH94eVZxghsODbCvY=; b=
	mliek2nTnjJE3IpgzPebE1LAoGNr2/L+AhiHgFpEqAJjPpX5OKxtZdwh7tWbzWqX
	zG1GsO9vux8OqBlukDhNk+m853YtO/2hHAdtxPhNSWGdGajwVIqBk6XB+48GLvU/
	Kav9NsHMJBEm8DDt1mCJyf1fKe3/nB7nhaWXY34gZvpuHYr2tdRuO0t1bWSzcjjh
	qtiAgX+Kd8dyM700TsdLCIQ+aSodTrQ+5W7GBa/SK0c+Vfbq/YogOVhpPbWbSHSh
	rHVFW6awi1xwfBNpR3EllLp2j2Z0SuZmTig/3BMMHP2pI9EYmbMYShGyfuFtjbDL
	GvPJqWm7FKfrNEUHquFFAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993735; x=
	1783080135; bh=pw+KJl3V948FP0NFp+sDffTfVZpH94eVZxghsODbCvY=; b=V
	XB8B4zhmzUwV97jkw8zB/WEF9phcy1a/HngHGuMhFfluoNpuQnGFOu79T7DIsVtF
	fBaQxI6Ljmeyn5y3q5VJyEl3ipl2QrnpNidLsXvAYqi7xbASXqe6SMXlX40UHVeO
	nQZLg6nAvtPQKhKNAFxKseZqHI8WKgGKtAudFre4ibIR8bEvJHFmmU+ddyop8Hgz
	yBJKGwfd/HegAv4QmujEGuW6VqDoLOIb4QuUxrC1PV3uI4pdy/xoCk67gKMY+IoZ
	StSJoQdJ0DstYpqrmBaOwjJBdS2XNeFLXFwToacVJgJ0XNkXkbZDojtTXLcxlK3Z
	vWNmEF1DWaH4RBXm/9Vpw==
X-ME-Sender: <xms:R1NGam-I7JKTtR2A4qy9H0_M1bdMQHsija8xqvhOuYlxg2TKj7Sypw>
    <xme:R1NGauLIb8vdG8xpOE9kJsv4jwtOV086XTnk_fBc1YQa1ICWiyZtjdhr14KWah-Qm
    Z9sBPFGMgiEIgk0Oc7aJtWc3czblvCKZSzyR_78JZhL2OxHGvGvtw>
X-ME-Received: <xmr:R1NGapac6W36knYL56KjDijWLcLdWfYtsfp1ytMHRg85glMWbO8xh_NBXUE9PgM5XRRrre1uy-u65vmvtPAeYvlZlenUkijYuXYt5zUuK7hMKQ>
X-ME-Proxy-Cause: dmFkZTFlt9Rf6ZPm4FJ30zy8A7UckBfB9PVo/ce9iCW6nU6SKUQInzslAS2ARtvWW4e5Uq
    No7KJPrUSmZKNKmaWceEzM0wMVvHpWRAP9XrBoCtBd9tdIk8dhrKw1jErkCbSBq6CVMVFy
    Wz0tB9Bzq8t+v0FZ98XQ6booojgvHN9fKl9ydnaJDuq3nwwaPjVqFL6GSWIkWVsV+SNED7
    6WwMq89or9Awd9WyuGrddpG2do+QeZmMJJ6h+PyTzik10k2/PPDnbqg4umG5EQXOlzCEst
    Zxxt+NtZpOc2IVZ/t0s5jgwCGTBdtFPuB64kluzmXIbkt980mLVd/glx43CJPJZEuTvzFF
    hXdB0pIJfxtyJxwry6Qxf5BkEi6L7zzcXwaNWLkzHLA2MDezq6wAEND3jXriFWzAzBOoSO
    GmEl+9spSiz7zmeQRWeB+vZ9C1HnEvSRKILkbrl7FBbJf39hs8gvutiVKEuvwIflo0mPsE
    BhO8zQzzX6lg/49b8DEVjXoO9WHlfefbIXBpCanegB7xh5o9tzbTJNCFZeEfv+8Pzfln5A
    a+4MWSBsoMPq8Nkq5woqvSeVOsqwJ29RxaH4n9yiF7r3Zvd2Rzb2bov6uz5IuKPi3jXH9h
    MfC3WOO2Jwc799dBsOrF1e0yRDfiAmK8ZyutABC4jNZP9+IKoSTFjFxxwUWw
X-ME-Proxy: <xmx:R1NGaoLzOAb7YVleX35PLPynGN79mhUcTTRnMQvP0ansMJUaUvzlzQ>
    <xmx:R1NGavD1P3OMEurNBBcM-KUXZWDIjeWux8GmdhQ0aJXKOdPIOimV9g>
    <xmx:R1NGalrYAm2bSQvTPPFxqu_hvm7mxrP5WcHslHiUUI5EEIFuOuIddQ>
    <xmx:R1NGaigEYuU52A9RGLh2MFTDosjFvyUdWussbMQXwFGRfutjP-so6w>
    <xmx:R1NGaqKhuoFLBXr-pOaWdWBZAgVht6uPzq1CujvoiZ8oKSid9eV3H7NT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:02:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24b0cf1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:02:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:02:02 +0200
Subject: [PATCH v2 4/6] treewide: convert users of `whence` to the new
 source field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-odb-drop-whence-v2-4-b0af7468ad95@pks.im>
References: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
In-Reply-To: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The `whence` field has become redundant now that callers can learn about
the exact source an object has been looked up from via the `struct
object_info_source::source` field.

Adapt callers to use the new field. Note that all callsites already set
up the `info.sourcep` request pointer, so the conversion is rather
straight-forward.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     | 2 +-
 builtin/index-pack.c   | 3 ++-
 builtin/pack-objects.c | 2 +-
 reachable.c            | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0aca6acb75..758f8fc736 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -834,7 +834,7 @@ static int batch_one_object_oi(const struct object_id *oid,
 			       void *_payload)
 {
 	struct for_each_object_payload *payload = _payload;
-	if (oi && oi->whence == OI_PACKED)
+	if (oi && oi->source_infop->source->type == ODB_SOURCE_PACKED)
 		return payload->callback(oid, oi->source_infop->u.packed.pack,
 					 oi->source_infop->u.packed.offset,
 					 payload->payload);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fe6e70522d..7af1aea6f9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1833,7 +1833,8 @@ static void repack_local_links(void)
 		if (odb_read_object_info_extended(the_repository->objects, oid, &info, 0))
 			/* Missing; assume it is a promisor object */
 			continue;
-		if (info.whence == OI_PACKED && source_info.u.packed.pack->pack_promisor)
+		if (source_info.source->type == ODB_SOURCE_PACKED &&
+		    source_info.u.packed.pack->pack_promisor)
 			continue;
 
 		if (!cmd.args.nr) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b7ef90f67c..4fdb6dbf6f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5010,7 +5010,7 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 
 	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
 		BUG("should_include_obj should only be called on existing objects");
-	return info.whence != OI_PACKED || !source_info.u.packed.pack->pack_promisor;
+	return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
 }
 
 static int is_not_in_promisor_pack(struct commit *commit, void *data) {
diff --git a/reachable.c b/reachable.c
index bf76b48fc5..caadacc02a 100644
--- a/reachable.c
+++ b/reachable.c
@@ -234,7 +234,7 @@ static int add_recent_object(const struct object_id *oid,
 
 	add_pending_object(data->revs, obj, "");
 	if (data->cb) {
-		if (oi->whence == OI_PACKED)
+		if (oi->source_infop->source->type == ODB_SOURCE_PACKED)
 			data->cb(obj, oi->source_infop->u.packed.pack,
 				 oi->source_infop->u.packed.offset, *oi->mtimep);
 		else

-- 
2.55.0.795.g602f6c329a.dirty

