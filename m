Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107126A088
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394513; cv=none; b=TX+yE2XOH1AjsoAT+FPXuIo7D2FQh2gF/RBiTE3WWqxBbprfFhQCi9kImoo/fIK9CDN80YDOl5Z0ha/CTOV+nVdm5lj4xZzbdDXwbKtkHKhezWeorpUQy56ooBwHXgbC797LMhtvn7A/wGDLzX9115qTL2iM1DdylA2ZUcmTxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394513; c=relaxed/simple;
	bh=XhZ/bCkHeb5ZHQymNNyO4nPJyDkMHesb62KPQSPJd68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gN9iVDLdFuxvbZBkjMsGDGwcY+CU9HqGrFMhbhRd4cWnehPnT2vnh0r6sM7nvRTY8E8PyqXIsf598CA0sGMKT4riho0ltPkevyogmKfacukKOanEG2VjnXZFrgFtAAnj6rs3oS9jH5+RT0cy7s3Mjs0MbIpORvaWoiSafMog9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k8i02PdO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KZepnsI8; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k8i02PdO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZepnsI8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C315611400D7
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Apr 2025 03:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394510;
	 x=1745480910; bh=HJEJ9ja2Xdl/bRzje1OJKAZbRbdH7jNUlGhDdlp7DOU=; b=
	k8i02PdO5Z2HkqIJRaCVfiFWIlLsB28Jo8BhAtVioML+kVjrnevuUvdpgBMnmuMx
	1aiK5h5gZdsyYjyRFhOKQDTduIDJWTpLlYRffyqYEXsEjT5s0iybXOl0bW37CR63
	OT+9JmzSr6WjgFL71pDANZx2m/OhCJHmL7qYJUO8DnddNoBCUoibxue7aUv5zoSM
	38VQ5fYoV2hgFOJZZIoF59lVCuA7ehM8/S9BgT2pyQcgKiomCmbTmbAeIyug/6UR
	TSpq+bSKN14CBv0J3gkXi9ms1h3IoOJAbuYyrbrPojmn24ewVazi0G/XPcC9Sy8Z
	c+0Xf1gY93YZYg3yVKiLuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394510; x=
	1745480910; bh=HJEJ9ja2Xdl/bRzje1OJKAZbRbdH7jNUlGhDdlp7DOU=; b=K
	ZepnsI8gXCFwpVyxY5Oy/aETYzXVWBq7u5jR+drltHTYnxxhLT61sNDJg8UgbmA+
	Gz45M6UWS2a3m6Z7EpHbpCHliVmjILK9SkK/zogDNn7pCdTXy2APXHjiWny3zsBu
	y/MSv9swOOTQo0aaI5zHHeF7R4CyT/RTsUozLRG4epPnRfKNOo87hjjp0DELOyiC
	+O7LWtrvHowzftZqFOQzTJJlnXgIhSNzMOltYSiv3M79p92xbwFHMiJNsNjx+ufx
	Zz7Vih4WEBfvDx5d0gJWwX5HYH7MN37bkj8JQVWYOV8iwYUbu0m3l0S9qpGHPCYb
	9f+DUb1kMd6VeNhLSmEIg==
X-ME-Sender: <xms:TpsIaMJRLDL4P0fXiSUZgVWuE5VtNxKwEV-XRhMFAtPdQDkYzFlYdA>
    <xme:TpsIaMI3IRFK3_Jnfs-8-3Mi7Mi0Py44VkWTZB_9dbm2dZ50t1ewjVPZPMnofvqzu
    1EcMq6YuFF7GsC8Gw>
X-ME-Received: <xmr:TpsIaMthdb2CdCANmsqqlp0LcYGDVYtepD616GqzBnl11xbXVMP6y-GTzydRbjv7XiwKD7FveNE_-i0AJaVYYBvyO_LrGQbP1TtjCzyCvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TpsIaJZx3pYdp4E3vGni01j1FppkNkYDI0fYp7JqEoInKC4QDTHJuQ>
    <xmx:TpsIaDblTh0x27ztG4KNj5oytAc6hCqL6W_HkMw8_c5QCMCHDPADCA>
    <xmx:TpsIaFC4NP8wRQAWFUPtHOT_TDoiroqcCxw-MoRqiuLhCnUCeqSmMQ>
    <xmx:TpsIaJbrZ8MydFnZFPILFM4BqSNy5NUYQTT7_TcUxnAkZ8qBPhGXTg>
    <xmx:TpsIaNkja-A3t91YPh9Agfq4k6jxMKPNMVETg_Wodue_zSjyqwnuSzIW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e8111a2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:18 +0200
Subject: [PATCH 08/13] builtin/show-ref: don't fetch objects when printing
 refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-8-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When printing references via git-show-ref(1) we double check that their
respective object IDs point to an existing object. This check is
performed via `repo_has_object_file()`, which knows to fetch missing
promised objects in the background. We shouldn't have a need to fetch
such objects though as no reference should ever point to a missing
object at all.

Convert the callsite to `has_object()`, which doesn't fetch promisor
objects by default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index f81209f23c3..fe592b4c202 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -35,7 +35,7 @@ static void show_one(const struct show_one_options *opts,
 	const char *hex;
 	struct object_id peeled;
 
-	if (!repo_has_object_file(the_repository, oid))
+	if (!has_object(the_repository, oid, HAS_OBJECT_RECHECK_PACKED))
 		die("git show-ref: bad ref %s (%s)", refname,
 		    oid_to_hex(oid));
 

-- 
2.49.0.901.g37484f566f.dirty

