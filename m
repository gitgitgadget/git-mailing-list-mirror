Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E921990A7
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530963; cv=none; b=soyBUAUFJn8bb3T/M9YAH5gt7WqVxb7DLYLhdGpyskO8gxg7vKI0Bnoki3WG/DXWQweUDvA8onaZhrWjLdmvsoHGcwBIDH7ga0qpeCs+8kcXf61lum5pkERhiq0yUF9imMs6ieEwmM6VUqrFHvX1DqfCgz751GNXdGPr3m4lNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530963; c=relaxed/simple;
	bh=FylzJ6t7N4oPQTYzCUApyYbHyDs6GgLd9fem4CdZN4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwTSzmjjdQBUoPL4IYzGesnULJGXGHj9GWQO5xHi4wYsVzU99WlVDHyLptxWxBI/qPsAm6AaOpyhpFLbB0vzky9pMOMESiae7K8P6zRSOYgnQxTSv6+38ev30A2RS3sHARNJ6oor6G9cPl/740oz+EDM7WTtzXvEeM+4weLOiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I2i932pK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+LOqQHg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I2i932pK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+LOqQHg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34CDF11400DB;
	Thu,  5 Sep 2024 06:09:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Sep 2024 06:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530961; x=1725617361; bh=NTxjXGNx1/
	57StEdxRaEzgkrVxehsxakc1i8DSCcFSE=; b=I2i932pKcPci3X7OrFRqKy9mp7
	kttpSeQEdh3mjp1ozkDxqTIgjDfaLs1oBtBdGf5VD20NtTAcB6Z2Hl4z/8zKqDE2
	faELN8xbiL6YVwZ3qLPS3q/EuCJTFV/BvNgE5Z6fOpkpg0CWdZw4mA6PjgGoop3X
	vH3pmcbq7u24f21OXDlXXvvV9dnRbBjxM6JuitDT1+KZ9mSmudnO1gKC8A8PJ5Yz
	1nmKAjTBVB4IN2yNhotdkk5BTjwun8MzEl1+YjVC1SCzDO/AyIxE34ZIarYSsz4c
	y0VAh7igJopkd+9vjPF5I2mqKtEZsf0ShzwU1fkVasMcxA/P8veqcZkPU7Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530961; x=1725617361; bh=NTxjXGNx1/57StEdxRaEzgkrVxeh
	sxakc1i8DSCcFSE=; b=Q+LOqQHg759lMXNbIfaHmtbE1JlmINQXJXaoSxKIjn6t
	iQjFhW4b7yfuMFSD1goKQ4xiK2hoyXVUgOkYTyXnN+lCTUK3NB4OXJVodNz0aj5v
	GU21+RTgoEaKzcNBUM4P54sP28EX/LHqXgyFPx8L20JEoFID0bvTJldoQCIMe6P6
	F38MMfSGWafi5GkACY2SSVjE0AngJq6kW4TGYm9RrN9uc8VpZhkzSRnKRhqafPnS
	9EbMmyPR2i6EbCcW4xZy+a2K3mMv2Qn15+joWK7SaIw9EHQ48Wl0p/xWDcgA7XCw
	+2LEbmx/YbXDg7r2Js/rtjlfX8aEev+g1pcrCHWmSg==
X-ME-Sender: <xms:UYPZZnXmsJvDL8SIb9Frw7lCr_pWdTrzB1ITe69fC-f5C_OTIqpMmA>
    <xme:UYPZZvlZMWvvMWOYadEWPptekop69JhJbCfK0268yVcq85ypTmDpGi_ADOr3jTDEU
    kwNCwP2c2Ccb802zA>
X-ME-Received: <xmr:UYPZZjZdxdF6E26Z40UwEmZW-ra4ovZ1zarsAA89-PTPu-6OfukDVZYmNw6hxqY2ADiSo9bHoxut-dt9nSVvb77WqYgBa9MOhiU7CP0YDzcBgQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:UYPZZiWgcqm0UY1VKXlc_w8x6MANDvJROs3nBr5NAqyxHsSWD2PzUQ>
    <xmx:UYPZZhkyDxYzQWT2ZbvogR6g1ktZVpxT9LyzWD90sVV5QZAGG_HdAw>
    <xmx:UYPZZvdmbWlKm4YiVw_DGnDKGTH7lSK1RtUWHsV8zT4t6PG7EKyZVA>
    <xmx:UYPZZrFSaL5kfscqhkJ_HOH6Ne6i-3bH-zNxanaGR3GwnbUcJR9e8w>
    <xmx:UYPZZvbSKOIQcJKPs9aiAbxVrYC25tdQGGfAB8gG4d2SRicbwh0C_QCO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5f610f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:08 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 14/22] shallow: fix leaking members of `struct
 shallow_info`
Message-ID: <d3996c92d801dcd0bae463e04d4197b4d619482e.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

We do not free several struct members in `clear_shallow_info()`. Fix
this to plug the resulting leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 shallow.c               | 9 +++++++++
 t/t5538-push-shallow.sh | 1 +
 2 files changed, 10 insertions(+)

diff --git a/shallow.c b/shallow.c
index 7e0ee96ead9..dcebc263d70 100644
--- a/shallow.c
+++ b/shallow.c
@@ -489,6 +489,15 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 
 void clear_shallow_info(struct shallow_info *info)
 {
+	if (info->used_shallow) {
+		for (size_t i = 0; i < info->shallow->nr; i++)
+			free(info->used_shallow[i]);
+		free(info->used_shallow);
+	}
+
+	free(info->need_reachability_test);
+	free(info->reachable);
+	free(info->shallow_ref);
 	free(info->ours);
 	free(info->theirs);
 }
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index e91fcc173e8..6adc3a20a45 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -5,6 +5,7 @@ test_description='push from/to a shallow clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit() {
-- 
2.46.0.519.g2e7b89e038.dirty

