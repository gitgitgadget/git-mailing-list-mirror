Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A622367B4
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564950; cv=none; b=b0ebEbA3huMkOc/rUQPyVvFwdKYKeGIbSqZWFfFuRLUsmoefX4wF28UhHNNqDDHPN0f/yjDDO/lD0XwaKidPLS5127rDTAMNoSfu112w01KJuABtYThsOIxzg8rjcvZP8+ByNxu31LhVGN80XPV/Pp2ydHlbzjvikE0nG3zAHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564950; c=relaxed/simple;
	bh=tPwsqBWVd7UigTNwonnsy70h2fvTcq4XQrU7JKlO2O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdullBrQVD9ub892n2cjsFx9oCJeVLS9yi3A52MxG1DMwI2TFXYUFoR4hTPm2cRWox7sRbW1CCy5cVVHf3jHpKJhMcI9+wPyaEMQBADl0/QC3oG+fJzWOHBiBPLg/tUWYLdbNHnywBOd1rQ69xxqGYxcJMGl+bfGqhPYDSV8vy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fAVzH5+T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ald/ZSJ3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fAVzH5+T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ald/ZSJ3"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 779E713801FF;
	Fri, 25 Apr 2025 03:09:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 25 Apr 2025 03:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564948;
	 x=1745651348; bh=CGFU0trwFL7qSSy4KNpQN2fIXHHrDr64ccoCf/+NXiI=; b=
	fAVzH5+TRdh38g5XiiVd8MbTULH3NcVnFFiS+zxVAkQZIsjgS5MgEskFO3hdxxMc
	PkDU0034ocEpI+WC+IsaZ7MIbgvL0Tfm9ELvmV+Sirb22Gf9FmiawkpolMV5Kd5x
	Uo4/WX/b0mnhFqdcc8bR+1ULP8cHS6qIFjyA+BwkWTUb6UCIJTUrqSxlaXoUnYhg
	cpfkAwOjbko2TomG0tQ7q12BEaXyclAQtehUz7c8cT8Fn2kX2b2fPs33WdMYhVzt
	iIUlnNSrBrNBdlr5VdBhSVAmmZLsJwH5WOTmTNdyu6iClxmVYqq/MZu6M6S+pFXY
	XQw8ozoZSwmF3FfNim7IYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564948; x=
	1745651348; bh=CGFU0trwFL7qSSy4KNpQN2fIXHHrDr64ccoCf/+NXiI=; b=A
	ld/ZSJ32BBSZ6i+oOuYUVXQCqesv0cqxsXTBHs6pqw0CtaLuJ15KxOmashp7mqF2
	rDNpOHpjLCKtM0jKNnN1Jauh99ZTD59II4Ibhsjo/bqBShTu4AM6KZi/HdBlppDf
	5EIYIJW5enrdJNdWF7Cik7mdK/ImDH7TfcmMZCGOPlCntn//AxNUEq6uIiT+3y46
	CyyKfbhNmTRXHDZq6QvJ8jGdAWOvEEQn7m+MpGUfKEOY6WGH9qBSgezJC2HPt/f3
	yjFofYbdZfMk6dK5OcNHV3UakEKHN8+98iBR3sGDpI1WSaDPgFq9FDwuAK8NAZbR
	Dhf+uLs/y+Z2XZlZI3AGQ==
X-ME-Sender: <xms:FDULaMPY3rBAR2FBQsgH_RwWwrbSdxu7eDmEoQn8PBahrQYnQa_tIw>
    <xme:FDULaC-ZW7tHQbEu6cysP9jJPN9kmDugwU9nx7oM3vJgEy5NvWtbA_sS0KiN7veh_
    FOOb9oYkTADExLagA>
X-ME-Received: <xmr:FDULaDTLVAIj62TG0ZZ3wNY_cEa-OALZxCD30x72D5-izspi83oj9vbBSui0XaPxl41ndTpGtrbHD52d3ZR84MH6ccFBCzwGy-ocEwFz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:FDULaEupft0ZM3uVnd1dbiQE6Iya7IIPW8BUdciEAjb6oyLkHSl1IQ>
    <xmx:FDULaEc7b3JT5i5NFqRKJzw30bu0qnuWevW9AL-jBmizPpT342xw-Q>
    <xmx:FDULaI2j-GCvSs0TkdQnv-oVfQF-TlU-UErbwQafFh15yjvobK0OzQ>
    <xmx:FDULaI_iZyv4GnfuFDX3YvmyBuysitLtl5_fPguGZRfUdSe1567X0g>
    <xmx:FDULaL5CCYAhDdQBnNQSQ1c355Xmfq-JWjNKOJv8E2GbT86L-aG5sxol>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cce68bfc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:09:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:09:02 +0200
Subject: [PATCH v2 11/13] list-objects: clarify how promised blobs are
 excluded
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-11-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

When "--exclude-promisor-objects" is passed by the user, commands like
git-rev-list(1) will exclude any objects part of a promisor pack. For
blobs this logic is handled in `process_blob()` with the following
logic:

    if (ctx->revs->exclude_promisor_objects &&
        !repo_has_object_file(the_repository, &obj->oid) &&
        is_promisor_object(ctx->revs->repo, &obj->oid))
            return;

It is somewhat puzzling that we use `repo_has_object_file()` to check
for existence of the blob because this function will cause us to fetch
missing objects in case they are part of a promisor pack. As such, one
may wonder whether the logic to exclude promised blobs is completely
broken.

As it turns out it's not broken: when "--exclude-promisor-objects" is
set we also unset the global `fetch_if_missing` variable, which causes
`do_oid_object_info_extended()` to not fetch any promised objects at
all.

Clarify this logic by using `has_object()`, which doesn't fetch promised
objects by default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/list-objects.c b/list-objects.c
index 1e5512e1318..cae4f7aff8c 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -74,7 +74,8 @@ static void process_blob(struct traversal_context *ctx,
 	 * of missing objects.
 	 */
 	if (ctx->revs->exclude_promisor_objects &&
-	    !repo_has_object_file(the_repository, &obj->oid) &&
+	    !has_object(the_repository, &obj->oid,
+			HAS_OBJECT_RECHECK_PACKED) &&
 	    is_promisor_object(ctx->revs->repo, &obj->oid))
 		return;
 

-- 
2.49.0.901.g37484f566f.dirty

