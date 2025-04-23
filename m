Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65626E176
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394516; cv=none; b=WCPxW4683EODnRfUdPWRpNCQQv1BsvE32ZimW/fUdjcfZSvMiCAxVNP58X4pIns51Inb7JXYqWlvWkR4VVQADjVT+CRmTwBclkW+AaC/RSvHyp7f2NlmghS2UZketZdXhRX4io/M10AoCKaPybSiv/m6O8aXBKAwvVH8ED4hoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394516; c=relaxed/simple;
	bh=tPwsqBWVd7UigTNwonnsy70h2fvTcq4XQrU7JKlO2O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvR+F6buQiagjCuRLV7u88cSwE4L67YdDbDfG76DknWSYHzOZ1Iiz0R7f1wMAEOJryOg+U0DMLf4XhRZkP6Od7yxmKfFTc+kV4dMlnc18UuU4cww/uTJVd8X2n/XCdMojNQqhhjxKnLycYEgI2/o6Zt7Jf92FApvm8otgG5SuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S1GzcUZz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZu/trJR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S1GzcUZz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZu/trJR"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61A2311402AE
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 23 Apr 2025 03:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394514;
	 x=1745480914; bh=CGFU0trwFL7qSSy4KNpQN2fIXHHrDr64ccoCf/+NXiI=; b=
	S1GzcUZzyuRhNi8tRvJNqK1/dP8a2LWVrJ0LZRCtUlLsT1ibZQG1miV+HoOkvU+G
	IL6jDHOg57cYd86tbRRiV9eWwmOwqsQnesqe9SYZIH5zVsmT4j4ir4NzpY+0WzvJ
	ifScCui5wA7d0EchjS0b4ODvWh2x9omgL2f9vIoRF9ODK9n5FjusuUmbpmJNSBuY
	XsI/SSjiEECMIJiCZ7jGAiy3gtNVn4hVTJg+D1TahMYjE5tJv9udAAT2QJ9DJQyg
	PXfdHyYB6tN0q0m84zxLP73XLValyLyhcIowMjlaio9izkCfMR1+96VyYP/Bh0eT
	AbsHYkfyldMPUkhwnP3hrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394514; x=
	1745480914; bh=CGFU0trwFL7qSSy4KNpQN2fIXHHrDr64ccoCf/+NXiI=; b=E
	Zu/trJRLl/BWrPdF/3Ud7yWWimHouu/S1c/nhojyZrQ+YAv1MPJ68U9w3s8HCGml
	8zZe3s68Mzhh5Nyp5YSxlGm2SnHQ8r0Qztw47YRCMhztc4ZX7BcAqceQkEk/ekhY
	fr14FKFvsU0nMPTQMEojtEgjuyDg0eAEuA3FHGtaC8/l9nq4en0YDVH57AJqmYEb
	lTp/7yenXO9Fx0j2jjocqDVORJfVb7obyuTfrNqFH7JF1HbbmUSyR+Gxu7YVPIAk
	XpsVWaNFsg/uVFgPqjSwvV1qSF6o+Z8Ngvvgl+LPyhSHWcPE0migiq89/ARUevqd
	yIdMxxapOWWm2EB3kVEpg==
X-ME-Sender: <xms:UpsIaDNJBnT18FpVRkyLx5MpmdADP1R7kepxrMZPDVQcuaRq83diJg>
    <xme:UpsIaN8YawlTdN1AN7JDlcL3BMW-PVFIPm7vCg4EFizOklz6NVy9ZJhgeckcgribm
    5bhbE5-D8Kqw9ZVAQ>
X-ME-Received: <xmr:UpsIaCRJ5oGXMIh_9ska3GqBTbPDHXcciPXSQGuCaWNNJRdByx3jX-amLRaN8-4Zr6u81g6yzx9i8YJNu-NSzwkU5lGiBTj78Kf519gupA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UpsIaHvo1h4qtswKGL5FFYBKwAzKjMrcCI7qhacel4n7Cati3RVztw>
    <xmx:UpsIaLdCB2495o899hDHmR3Pdhzh7-9srB_lMye1f5n80EJcbbDF3A>
    <xmx:UpsIaD1uohIiDdlsRLbW95wWR7iUpf31ORgr258vidK-0VbD2miGNA>
    <xmx:UpsIaH9PDddv40DhRx-b9pMLcagyEKyozjg3IdUA4gcM-JY_Mfh4OA>
    <xmx:UpsIaP4dMxfAaBWGAb1coiRYVkSOLEcWSCOYec-aH6zE16DAnt6n2pqp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2d1ad5e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:21 +0200
Subject: [PATCH 11/13] list-objects: clarify how promised blobs are
 excluded
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-11-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
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

