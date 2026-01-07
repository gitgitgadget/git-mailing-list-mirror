Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06331AAA3
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791302; cv=none; b=JVJhpHwbW2cFoCaJwqK/cau5jeI+pU3pyGmDcl1Z+ls6AczpbliCiuEEYGW9pDxdyJ7V4vtFKlhNvVG6zVzaE1fhSrSrGQUi55qgjMRPOx6aOLP45dXXY7BG1Q01OUbLcExWqN2m3VdHyqgymii6lvTX65IRhsJf1B3Rl55fLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791302; c=relaxed/simple;
	bh=nXbBsCxnaPdLnDOtNEhvEjb4NmmWZCtI7BcNqoYnlsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbzeHjVvnH8TBYU0Mb8RhcO3xbtSyw4iQ0GzkFOmZmMnDbUr8Er7iUiz3qHIk/9uYzp67CY0hepfRtnW5iu1pc6lbDVP5O4Kpjo989xBqS2MpmPVDzzAnY6cZQp1TqNajx5THurfYluFThqyA88RZyidc9Sbzv39Zah9lJbvrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UzU/D79H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wZX2VHlx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UzU/D79H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wZX2VHlx"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7624C14000F8;
	Wed,  7 Jan 2026 08:08:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 07 Jan 2026 08:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767791299;
	 x=1767877699; bh=Uj4ebfLz0TINQeWVoCm+OULcR1Lfca/A5/4Y+7id2EA=; b=
	UzU/D79HVXzUgGFod3t8VIdhqb7DtkwgNQUZFLgRgQHOOf09XKhDz2TOzkV3CDZA
	iRU/r+ia+puRCHMTTIeUvz2Hk9gmUCddbNzdQoGPsNJndRieUd5Te6IF6YZjLYdH
	HMxzR4IyRUGtwELBievRhiVl051yGgNrcayKRutUgXdQ5UDJiPDUK6nV+1lB0zKD
	XgewL8znRb+BM4A8foHJqC9XVp3gU+P8E98O/wc5rrIDNxpN9lUZEAy6dYkVB8XJ
	FLe1TRviSDN+lW3TkgnY6Ra+ZcOt476R2BFY/xUywCVWm3yCdC7NstGU3yIbAypm
	XdTXGTq8z3oZWWqxQ253pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767791299; x=
	1767877699; bh=Uj4ebfLz0TINQeWVoCm+OULcR1Lfca/A5/4Y+7id2EA=; b=w
	ZX2VHlxxDa2XLchYX034i33YKHMKUHH5D4QZX2MwR1EwyNsqFtt9s9GLxarPQoHs
	VbjW4REjfHJ8K2Fif6MVPWxrhrVjCpq6p0b7ifkPy2Cdp/QTBAbPMfA9uNLl7Fon
	KDXp28B9hYQopZBFr2G17Y9VoIOcpCV263XzqXw5SKLdvfzKbcnxAKFRMOxT5pem
	LErW4WU6aGK+GofCgFWnTucgFANBp4DJN0H2In5K+j+yXwzqlCvV7RzGZuxibKZe
	j5b26oNb59n8VT6oVR1leIUhe8dHjVE3Ifo1oLyfTQ/tzDUKO/iCgn3ds93gMg6x
	Yp4xozQl9s+RLAIptpWtg==
X-ME-Sender: <xms:w1peaVNfkDw20lbx6hpiajnusWgY5kiFSMjmctuwG3lxAWQUPH-rBw>
    <xme:w1peaQaDZKJ4tfDZXn1ZE4VttI9IgKMKz-WungmgjV_X1knGZq4m_rmzsl18gCejs
    Dmk17mYfyHt_Yzz2mibZaX7XvcWPaZboKAxJTA06Ath5b_HRjLCbg>
X-ME-Received: <xmr:w1peaUud-FMaRDxREFmbcC_CKi7SNxQL5NBYtuIuRrpBqpMirQfO89J9SFSbwSgr_UUU2CDpFOXT6Mm_tHKqN79wCpgMUab6NU6cNGySJ1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlh
    drtghomhdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:w1peaSMqxo_6u--HBzU1EZxpyKTuTMk8y6TFi31LmhdPovDN7WUMgA>
    <xmx:w1peab6BrwJHt3N97sMNGgiMpK7ebnqE3-GjW3Obj5bt4nUVH0DqXg>
    <xmx:w1peaYRoe0BLLPcKolwxlBvhLIn_F-TqnPOwHUPQHIfRtP_mumb82Q>
    <xmx:w1peaYAc8CToSGb6TUAf1XRbY_RuR--OArriPrKl8ynFk9VS_Iv5Ag>
    <xmx:w1peadqEvKkvW6Vzlzz7Vg9WhCGzeIbpsX_LSb3fFLfellAPvN_lHH_B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 08:08:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7280cea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 13:08:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 14:08:01 +0100
Subject: [PATCH v4 2/7] packfile: always declare object info to be
 OI_PACKED
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-odb-read-object-info-improvements-v4-2-b5d55c47082a@pks.im>
References: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
In-Reply-To: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
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
2.52.0.542.g9473a8513b.dirty

