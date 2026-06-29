Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260A3F9294
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723765; cv=none; b=FvwSQJW80wKr29ZHHFEiCaYSysCB1HX7dXBcLzVXGHhJ8hgU0Snm/IArLOscJzWd+OCWgI1mVNDiOVErmSkH0KX7AWGAa89+dZt3yXkoMTrrZLXWVgUUcOWKhVpCwn+iOaNlecs0tiM1gq1hVA2amikELbFKxNhyUIey7t/cDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723765; c=relaxed/simple;
	bh=TymAawCWCTqp4lWrF4/G5DHC9ONEhF3d1X10CMT2rV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XDXj87iqK4lHzbjrBVI3DNqbUPLNbOmUmprv1t1hUDQaUpIJKHfP1bMWXGHRy76jRizkMoJ+0lZ5gd8wLNx+CDMx8Q5vqTq6CcNOyx3KvjCGG1iX43uSGAaPDh6/OhW/aqh22yh61b536rakFf6TclGX67KjiKVyaR04+9MZMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gwufbXkD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Di8iQ02w; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gwufbXkD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Di8iQ02w"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DB0C61D00069;
	Mon, 29 Jun 2026 05:02:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 05:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723763;
	 x=1782810163; bh=pUaTYX20yK3HLOF/M9LOEwVt1T9UeZvH4GZ4iNe+aBM=; b=
	gwufbXkD+Wk7xA35WGUEY2JdTGGWEwdrASnPtk3oSCEoFSvEsl7oJT1MwY4jEks6
	3cqRw5ddcAKyf46Rn7G/rCCyUa6T2arN4ZIzEJLNFyxArH6mXdtjY7iD5HcBJK2o
	qUk1GWriFfAMrdT2SM6SNGDr0KL38C0KiEn/Y5fzddFsN0y1ectu3fQI8C3IPl63
	qvnyb5nXbtG3mmtHTykiZsLX0pjpNA2QOEMBbYYBiDqqK5id6swVVeNbVE2UZn0K
	sjusAz4tUqWU2PRNQP0NvcNTVQYU25UFPBafWfBC8A5K5bn8hKgzr3sxUmUkbuUG
	PkUgJhi+gy8dA+oSXkGB5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723763; x=
	1782810163; bh=pUaTYX20yK3HLOF/M9LOEwVt1T9UeZvH4GZ4iNe+aBM=; b=D
	i8iQ02wJc8ZqeSuGwl9fUFvFxLQ2sZCJYPawWRYtD1c3ctyxaZVTLegX47sFkt4c
	HDX1B5+aGyGjhke8DcYT7Skh7uVjocgMr0b1i9Md3k0tlLiYjzl8S8FdgNttjml8
	kkMBu57ozB20kIow/maGQV+oML470H90NylG5jclNRkJDhoXloNjf07JHxASXh9R
	9Xn6t1YTgY2LVmVM9kC3HUPyEI/EtgDGwHNH4aCAfpWGyCRG4IVUAeAUga5sHNg2
	ZBMcljJ+ARKcV7/mO/69LaHICkiJrs3vXkcbp0XF0e4te/dBWAPOjkDU4SZXt2jv
	HP/yG94rcqRxVNxT/wl+Q==
X-ME-Sender: <xms:szRCanLl9Lt7dzC3AnreDl7X-03S3a5JYCQpuDR6LoXy75Q6N9Aduw>
    <xme:szRCaikVVCBDonayZhMbnHXVPGLVgg-h5I39zT_aDc7gufauGdZ6KiOcFZ6h2ocFF
    zmbQmSf6L9YZsXma2Zvd7p-sgiABllffkqCExxkif9VXREmYc8En-I>
X-ME-Received: <xmr:szRCatHgGZMMbt1Yqf3lEBhm719fZrf0NEkrwChQWxKof9msutyxDbmHcxKU5FTQK-YEsx_kPYVQ_s-zuYvd7XfCEiXJh7KFtPFdzlSDEXzT>
X-ME-Proxy-Cause: dmFkZTG0tQJr0Dzim7xW/Wlh5h8r3Ng3IJZ0xoWJ2fSxm0hnQP54Py0hcQpRpXudxH0AjE
    +Gh2qIU+eIBUKgd03v4Jn89pxIEJBjIsl0OzlGY5rZ0ccnptl4gYN6OsiN+2x3rsKaZbej
    wPKC0R5RVKftaRgW4KJchF33wcgNnHbdYofaEfA5D/lgoNu2tPYc8HEQMgHxO/Z4Ar8yR8
    dqB4OExNN24ofnr3LXS148+ez/BCgB52TT/Oe8XJbc/BPftdsoMJR5fpDIrMm2A4AM9WYt
    IvgYyc+JQHlei9JXF9xaa+P/vc681Cp9lqQBYm8TrjHXFeZfZsVbpVUILdpyBO1jwKSHHD
    fX8/UYrgjaQtFf1Gop7a+2kDmdVCF0RASB1WKOfm3K8E1uWcxsGkz3pcBom/NrwnZcCUtj
    xjWhjDRzyVrsGg+L8IECLpca4J1tu5oVnIbmPAxVYNTEY/6QI+rrzWeS9Kmr77WiDvmxxi
    FSrTFV2168OswOahhkuf9RhhosxrwNw8Xdu34avCj63MKzsYekjHhiS/+KHjuqV/EdWAWc
    ontVIQMjjaZxgpAMkzH5TciWKN5Zg+1w5nWUjzlU+YR/8wrzpjTJe0RrgxxSGhvUBkltel
    1/wry++zn7uUckQJRNclta3DXTz6VdnZSCcgHp/4O1NOz22r8RkAhuPaiIJw
X-ME-Proxy: <xmx:szRCaqECd0lyXOaTWPavQ_BsK1fLiTv9GYZutbbzAub6K5Ozvru9aQ>
    <xmx:szRCaiNA1qhAxWFBmioVI3t2dlKRVDKnoV5K_i3v6bzlfi5LyBSjfQ>
    <xmx:szRCahFCruX0xnu6OPfjBrBYxFiTQWVyUJZmluEVi3hPJNnaOSDPLA>
    <xmx:szRCahNxDG5AzigFGV76UXfu0mJwPq-lqnfaHpsErI8T_PqvJSSKNw>
    <xmx:szRCavjUvpx3BgRWJOILsIVFhuevKaL1sTbz7GZvoX2wd8ISnq76801p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ca9d181 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:22 +0200
Subject: [PATCH v2 09/12] reftable/block: fix use of uninitialized memory
 when binsearch fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-9-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When doing the binary search through our restart offsets we may hit an
error in case `restart_needle_less()` fails to decode the record at the
given offset. While we correctly detect this case and error out, it will
cause us to call `reftable_record_release()` on the yet-uninitialized
record.

Fix this by initializing the record earlier.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 4d285aefd7..89efce8751 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -517,6 +517,10 @@ int block_iter_seek_key(struct block_iter *it, struct reftable_buf *want)
 	int err = 0;
 	size_t i;
 
+	err = reftable_record_init(&rec, reftable_block_type(it->block));
+	if (err < 0)
+		goto done;
+
 	/*
 	 * Perform a binary search over the block's restart points, which
 	 * avoids doing a linear scan over the whole block. Like this, we
@@ -558,10 +562,6 @@ int block_iter_seek_key(struct block_iter *it, struct reftable_buf *want)
 	else
 		it->next_off = it->block->header_off + 4;
 
-	err = reftable_record_init(&rec, reftable_block_type(it->block));
-	if (err < 0)
-		goto done;
-
 	/*
 	 * We're looking for the last entry less than the wanted key so that
 	 * the next call to `block_reader_next()` would yield the wanted

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

