Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F23090FF
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055273; cv=none; b=deDxaxsVVWVnLy5nAFHFBMYO7SI1uI90dcmbiWEnPRJZIANqfY69pU/NPRyOG9YaQAB7DWaYmqvFWLJPw5sAVzEQiqsp9fDoqaRivHkqxIpXmOmPQDscPWLoP3+vt7qgIoE4hNM8uINFAiyGnyUEmriwh8sNlN+zJwnQLTmyW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055273; c=relaxed/simple;
	bh=xgRStkqv5YvBXoghLug3UYdyQvjlhSTPnyQUEsJY1sQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5YGwWs8m2u4gG00paZ4rvIqwCTtLPsb5LFqHE8GjZtIGjruU3Lt4tRucvZiscEJ4My3cbDwnkan9QHXP46pwxPWa+8iXVnkZVLHUtlbU718P0wTsPaUQD1oENLreGILAXY/NEcKqnnpBSXQqlk6/Nm4bwiX/P55YCup/MITFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bJ6fvoqE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKAZIJuE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bJ6fvoqE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKAZIJuE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DB2061D00015;
	Thu, 18 Dec 2025 05:54:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 18 Dec 2025 05:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766055267;
	 x=1766141667; bh=DwjgEL8MCklDyWxY4VLC30/oJ52ZkGsqrOhyiZ2GL6o=; b=
	bJ6fvoqEi913sJXuY+vlytP9zXjJOmMZQWizdvt3EgfyVuHYZFXCFiQZFRnQ01GP
	FIimDuVQT4dr14n66AuRy+0OC6uCaNP23Zad3pztGKYK9+q25hAYnQB/sWRUP6RO
	KUn4ByYKu3w1e/bSQAaNksfXc+bDMJV27wtTq5OgGz3Z5BNh7w+2zkibp4Lbap61
	wWcEe0CdyZglreA/cLedziR2OPlokjXj+j3vKN2N36EbKJ1p6VsQVUIoJ2tnNLjU
	ziGyma1cODCMgH9m2e+1O+eyEOCGVglBlkC6dP9ymFfUv3S4kzUIrUIX7iAqg/go
	k3a+az7eK3INjA5YEvYx9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766055267; x=
	1766141667; bh=DwjgEL8MCklDyWxY4VLC30/oJ52ZkGsqrOhyiZ2GL6o=; b=U
	KAZIJuEB0BtoWd7KGva9DPKllE8ztrrGxDq9DN+iCXXBcKyDBW2n8/ZLJUXpqiBQ
	XRtPmKhBemqmhFM2/oQ7XyqSbYlxSGV7dIA/c8m4p8orPLiTosXOtQWj/p+dLRNI
	CjMQWCGL4fE6R9+VB+OK8bR8v8ZdQz7iC+M3Es3CIlWL4TByx/05GV32V/ov3d+p
	n3z0wtrKMQ8QIs11AYlqXTFURjK4f8Qjhv3jUSE624wdnWX3gBk1ayGwYhUXNxSX
	G1ea4mnqp5/dK9UAXiaLkcSDm73dRg+4MR1r7iLakhLbHhMllbHUuaxVuI4n0cwE
	TDhDjPSMfuNgiSh8BT+JA==
X-ME-Sender: <xms:Y91DafkH7DSdFyo7guLVNQ4cdWoaIIqzOwQO2-4vy9I8oi7NbIF57w>
    <xme:Y91DaaQSB5ED9DdUeof4X0z5Z_GbkxodEU5OfcT6OtCAaUfRKt9JBbwR7I7Fbnk5K
    oBG3L9fZjrBGn3zJAs3FpcX761A7Kl_-TuuZyB6Zg_-Nt-fmw9Whg>
X-ME-Received: <xmr:Y91DaTBQcLYYWRaePYGMUMXDsnwGENOWuE7jqZtnDMYd_o_M-w4Ka1Lo6bHWSwLB0Z629WndVwkLZlZv0c-vI21YESmyK_xLsvrhieuZvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeghedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegrphhlrghtthhnvg
    hrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:Y91DaRTI5wpG-335h8Ph-PXqi4z8Da5MJ_jvpYMFjr4l6pYnqOMgIQ>
    <xmx:Y91DaRqkQxdHrYNYDiMlr5cY5uvZJ1qqcfbsKa7nVFck0ifkUzanUA>
    <xmx:Y91DaTy8xYtEI93xeLun143Rv3kjPIzg4JlYlhAD9qzgtwz4oFJnPg>
    <xmx:Y91DaWIXcifKP6w5l20IlWe1LRZ0n5sbus2LNt1TnhdO80_93lUkfA>
    <xmx:Y91DaY6vL8Jvn7HM8GLwlfkI_Xxt9tnTVXBUxaPpcQ55tS2L0d-fNA1w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 05:54:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef695b8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 10:54:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 11:54:14 +0100
Subject: [PATCH v2 2/7] packfile: always declare object info to be
 OI_PACKED
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v2-2-62e3e49072bc@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
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
2.52.0.351.gbe84eed79e.dirty

