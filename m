Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4643009C1
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682511; cv=none; b=MEzMWf4U920Sgk/1muD2Fp6vn9K83DAb+CCwTREGlB0Aj3ROLal2S3IXa99owtJtJ/kIawvsOsiS3ApyacnBqeQkavZ8QgUdeO7wgnnIzqtP5pk3DYLr1KJhFwN80No7779n931HIvKHWExHY2Q4CrirpcJ98GgtyR0kBlA9A14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682511; c=relaxed/simple;
	bh=l2wajfBtS1/Ljaw/t4rHSeEwYr+JH6v4bQEDhsGOZZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cj6oglsqb9WAo1sq+/12nzqY/EgFmdolmDnTlIomFyplV5YkWselRqggj8xLvYy0EUSWqchVr4bx4OfYA+hJ98UGzvhTZVaZr6WAImIqpIModf/ZLCEq7pbIPiwoBVfG9JNOFmFbyujk1yEM18w6MO/YN+eJkY1ko2GWmqTTWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kIm26cCM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kf9V/o2w; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kIm26cCM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kf9V/o2w"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A23587A00EF;
	Tue,  6 Jan 2026 01:55:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 01:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767682508;
	 x=1767768908; bh=dSFT3F6pcehZLZhh7HS945vOkXjszXYQqtVH6SaNhLc=; b=
	kIm26cCMB5Ub0pMqeqe1tiM1M5bmGwPpC2zASj79YNKdeAv7z6QmCml4T0MB9lWQ
	8mQvJ0KKDj/WIW5vZE0GLPuPRe592QRUwri7XH0SPHv34ttLttEQADf6nXPQP7v6
	m+PKdeCYCaCX2skfDUinZf11spnIYSkytO43pi1ZGr4gqJksuB1udry2aGB4LQGK
	J/XZfp+IVy+/SqVIwQFcKeuWTKqxRdcAmF9NNRhJzyI9uKZO6O5OWD8M563HN42g
	UwHEjIjUnFq6h6c9GwjvwDPWJVa5DfrDtL4r4EdkkRHQNLvHpU+0BwIZDh9Zq8ig
	gNPXeVIMx3cp/vGGtk/leg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767682508; x=
	1767768908; bh=dSFT3F6pcehZLZhh7HS945vOkXjszXYQqtVH6SaNhLc=; b=k
	f9V/o2wMjqjI79y48OYci0RDOw9h/0h6MKSLHXr+VArYo0hhlwylZil0vJAZE7zt
	QYWNcgXMYotA1wuDTyMu9Iv8H44QaLdNmybLr2obgp3s6IbbXe9qOxZkC7+teYut
	7jgNhRuKI+4H6vr3+QfJIUqhAHdXPm6ZfiQ+eYhmQrFlVRcdoECq97lgensURofv
	F3CBMXPiyUMkxPtSdKIewr8K/K+6SRN979PxaoQ3FP1wQvdBdys9SGXCaOnALJDW
	fdK1bhApTDfgzbButUWxKjHVGXfJP8Bv87EmLkPBjeH4jof22oxxdbRgRPnB5k+v
	5ARwQHSkSBpC7oBzsf3jg==
X-ME-Sender: <xms:zLFcaQ4kkjFND7dkyQnrHfHu75Ibw8rSpuqQGeMl2Vmvs6xIc88vKQ>
    <xme:zLFcaYzUsuNEGYPpKEpo5tdsJ2t59UV3Pn51PuJS4_XsWvtDoY6uKfFLztW8IhYkh
    nzi_KPnaTFvGy1egMirbFYPLbHbEUjZz37ydbKFDyFyV9_EVigfHw>
X-ME-Received: <xmr:zLFcaXzaPJrtfhZSRjcHkx7fXP_wVIHyRccto2Mnw8rHGmLkOz-lpyWTm5VCaLgxsWzWS6L18X033TY4M1nv0hztZbJwLyQgAlY9nIf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegrphhl
    rghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zLFcaQyZJdDcGXUtgWYmTVSsBLpC_77_RMmF-d2ijFTQy1IoM29l2g>
    <xmx:zLFcaRavqBtFj_JYOkti-Odc7pMqQFfOcxUm89dMHvK_v6U3FBrGPQ>
    <xmx:zLFcaRWqZNQ0AooM4EaWrwsxQkJB612Wa1msbNV6flfps9Iu57M0qQ>
    <xmx:zLFcafiQQDf9habqHL4ow2gxEvTKAZYTrlbKlBd7MW2T9f5XGoSx-g>
    <xmx:zLFcadUzt-JBKLS1ON-h2g81x-08NyFvIztCZy_OjN7Ddh0oCh0ew4xH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:55:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f11c67d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:55:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Jan 2026 07:54:58 +0100
Subject: [PATCH v3 2/7] packfile: always declare object info to be
 OI_PACKED
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-b4-pks-odb-read-object-info-improvements-v3-2-b5e02fae1fb0@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

When reading object info via a packfile we yield one of two types:

  - The object can either be OI_PACKED, which is what a caller would
    typically expect.

  - Or it can be OI_DBCACHED if it is stored in the delta base cache.

The latter really is an implementation detail though, and callers
typically don't care at all about the difference. Furthermore, the
information whether or not it is part of the delta base cache can
already be derived via the `is_delta` field, so the fact that we discern
between OI_PACKED and OI_DBCACHED only further complicates the
interface.

There aren't all that many callers that care about the `whence` field in
the first place. In fact, there's only three:

  - `packfile_store_read_object_info()` checks for `whence == OI_PACKED`
    and then populates the packfile information of the object info
    structure. We now start to do this also for deltified objects, which
    gives its callers strictly more information.

  - `repack_local_links()` wants to determine whether the object is part
    of a promisor pack and checks for `whence == OI_PACKED`. If so, it
    verifies that the packfile is a promisor pack. It's arguably wrong
    to declare that an object is not part of a promisor pack only
    because it is stored in the delta base cache.

  - `is_not_in_promisor_pack_obj()` does the same, but checks that a
    specific object is _not_ part of a promisor pack. The same reasoning
    as above applies.

Drop the OI_DBCACHED enum completely. None of the callers seem to care
about the distinction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 1 -
 packfile.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/odb.h b/odb.h
index 014cd9585a..73b0b87ad5 100644
--- a/odb.h
+++ b/odb.h
@@ -330,7 +330,6 @@ struct object_info {
 		OI_CACHED,
 		OI_LOOSE,
 		OI_PACKED,
-		OI_DBCACHED
 	} whence;
 	union {
 		/*
diff --git a/packfile.c b/packfile.c
index 08a0863fc3..b0c6665c87 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1656,8 +1656,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			oidclr(oi->delta_base_oid, p->repo->hash_algo);
 	}
 
-	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
-							  OI_PACKED;
+	oi->whence = OI_PACKED;
 
 out:
 	unuse_pack(&w_curs);

-- 
2.52.0.508.g883dcfc63e.dirty

