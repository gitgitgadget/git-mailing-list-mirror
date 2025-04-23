Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962426A1DE
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394512; cv=none; b=hUp9NUAeD3jspYXRFz3LFlMq0/k808GI+9E1ai/7aBFP9ypVauex8ACEtv2lMAn33mwKmNSdQLaw79l7G3VLRlXOINomvsdbEJ3gI4KTLxXHGgmHmEzMPftxQO+E2Kqv8nsXaw2rmmFZPtpRvRH1/pCR7Xdh0MkplupL8VF/EZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394512; c=relaxed/simple;
	bh=UXF7QFSwawSWOcKNkU2W8ncLUAMdAI5NFrzi9SrvCEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQkYq7ZlzcwN+LUjwEFi18kEZJcbiT3pxGYdGy1op5dpWh6gRvu3mzRYQ0Vofo/rmtvc9zlidDZ0YaDnuhAm56s3iNE5pNTz16jQgkwms3wevHD18Nv6SqisNFcL/VS0eOO4ns2NbOfQ6o6WKEzR+E/9guqwFgQcRoBjBBhysa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J1P6lxoa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDQvJnmG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J1P6lxoa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDQvJnmG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEEF51140106
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Apr 2025 03:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394509;
	 x=1745480909; bh=tFzL3DT6LaNx8c3sN5tVUVRo1X4NA12pN9OWcRsiUGg=; b=
	J1P6lxoaoC3f+NheQF7AM7Ec0rOp4O0i8YVktLKKQ1fwMDvP3wIWC/oM42L5uqDh
	hGfgt1c65lSpGqXaB1ToI9ygNggEZO+vrQuSj/LIrqTfwOi7lUmI4XOAirSu5yOW
	WrAlaSeO9+dRm1gw/28k4Mxt1oT05PfLPj1/uXMbKCuw+im+Jh5g1DDHcJWNHCq9
	0BDqM9jqXaTOqZ5AX3uOBnBt0pV0pmxLc3iOTwl0ZFQayVlcKgnXqEm5KX1BQ9an
	fcTqnq1MANxLChh3N5mQkZPutDj1Q0DZ6CYXaDFbWCO8rmRThlxSTbOgoffEZ+M3
	+BrbKufGUbT7NHVP1mEagA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394509; x=
	1745480909; bh=tFzL3DT6LaNx8c3sN5tVUVRo1X4NA12pN9OWcRsiUGg=; b=T
	DQvJnmGRpJtRFERDFV8DABcvtcXARAmaF8nGeDwW+1+fYmP87H860MnzJBJ/UDr8
	VqbJ50nKYO7YcKMStSNFpjhu814ZlYVnYBoVRu9Nl95EfJuyritJprHVshbCCXJq
	Ftg/M+Zxox6HY5AxhRSaj5aQ9Tdr9MoWzvHRI5uTSPOv2Gd1TNFMLwmsVywe7lxW
	sIiqfrVZor41fxY8MO0RYvx4DwLg+5V02As70J91Yo+AnOpuGc2wtraubWvkD9eD
	7qpd9a0wmfs6PVc+2+QxVanDajKQtIWqenc/nyy23d5OwGdSBC91lnVOeXyS8Dlv
	igXg2kSBd2PHAjncT8zRw==
X-ME-Sender: <xms:TZsIaDug2T0lPOX9804AduRmYp0zRZ7gzg6bc67F2EldbgtfvTNIqQ>
    <xme:TZsIaEdX-APO6Wu5Rg8TUgoEJ93LbbeGjFNAvieghNjKGDmbj0iXy01k_DKth2lXY
    HTCTwJBqzf7hYX6kQ>
X-ME-Received: <xmr:TZsIaGxL-82zhwvpI2rLyDLOseuqZgiy0tzyYbuR2VbkFu4mbQDwI9QKDcUqBE5WH58M11eVQUStv8mWGb-_bIG4lOOexYW6huzWlGqNlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TZsIaCORNe5m7OenOiEGXHMP_kcRNAhsm9Ao2F9XONY19vGoeDBZXw>
    <xmx:TZsIaD8CvO981p2uB8EzzhjZ_B0DaJvgh_UYNt62j6KA6d67Z-q5FQ>
    <xmx:TZsIaCUrDDITU4mtjnFsdBUrxcCiIsVoqfjsgjz89DoptsBKQE8SQw>
    <xmx:TZsIaEcuq4zMvv_-B3UT8LjeiOegRltN4dogQ2_OvuKq0yW5D3w9uA>
    <xmx:TZsIaKZAredvd3WlLAxuAvwlTESd5D8VmK-5NdHJIrTWhH2O_4Fg3UBZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a141c096 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:17 +0200
Subject: [PATCH 07/13] builtin/index-pack: don't fetch promised objects for
 collision check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-7-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Any packed objects indexed via git-index-pack(1) are subject to a
collision check. This collision check has the intent to determine
whether we already have an object with the same object ID, but different
contents in the repository.

The check whether the collision check is really needed is performed via
`repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)`. But unless
explicitly told otherwise via `OBJECT_INFO_SKIP_FETCH_OBJECT`, this
function will also cause us to fetch the object ID in case it is part of
a promisor pack. As such, we may end up fetching the object only to
check whether the fetched object and the object that we're indexing have
the same content.

This behaviour is highly dubious and more likely than not unintended.
Fix it by converting to `has_object()`, which knows to neither reload
packfiles nor to fetch promisor objects by default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/index-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f49431d626b..805b7aa1e28 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -892,9 +892,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 
 	if (startup_info->have_repository) {
 		read_lock();
-		collision_test_needed =
-			repo_has_object_file_with_flags(the_repository, oid,
-							OBJECT_INFO_QUICK);
+		collision_test_needed = has_object(the_repository, oid, 0);
 		read_unlock();
 	}
 

-- 
2.49.0.901.g37484f566f.dirty

