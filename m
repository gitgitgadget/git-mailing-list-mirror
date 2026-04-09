Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121C379ECC
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719482; cv=none; b=Eif1sciccxJjXuzR5JIJsrrFCw60059oY2+B27WoyMXR34cTa/xjRs+usvIS1aLZunMMkhN+vMod1Gw0Jtomm/1hDvT/FS5SD5L4Nw1XKvFc0HNLgFRzsWW0zbpyEb2/A7KTGUEGTcfNJQMc4llyyTZ2AaTOItr4HgXzfGsSEiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719482; c=relaxed/simple;
	bh=miALHPZOlZ/mNMqQacdxnjqbRiNzIJbsGyHEAtt42Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=umJPq/udpj+x3FOUXNGZEFStwN7OyExGzygp88cgExEj8rPtGtmrO2jWvjHdf0leECKx3OtE1FQ3uq7aT6eDOrzDiiJI36DUoYAuvB3gG5behW81WuzQu/XDOC+YVsRCZ3h105OPNSqbkKMP/ycXsyFQF3zYXDQSAaxMZAZssEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kl1KEk+9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3S/Z1Rx; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kl1KEk+9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3S/Z1Rx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BFC71400272;
	Thu,  9 Apr 2026 03:24:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 03:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719480;
	 x=1775805880; bh=Quexn3WqWlu87nNv25VRN0bgKke2xjgMd2vi785/Tn8=; b=
	Kl1KEk+9Vn2geQIRlur5nqR3aPPq8W6a7prGPvXiGDzRYakEdWyLTJYfoIsUCQkF
	NrlhAbZwTcf5zzVPZwg8Qrky6R8/XHxeRldfvSsG2ywuEqaKbIOxDAMyHMp5mhKs
	UYcWQcERutpzJGmD3wNOxZnifkjLVbkQtTVyAq/kfeDYEhE0667NFpTNZ1W9dpLG
	9DfYj/ZyayJwVgVD080rCNhmVfwY2GKv0K/4Gl029qgKl5DdvcLc1mHgrRenget2
	TeAJ65zwwJuASnYHYAZRlMGMsTHySKa4lx/r7lRmBm3FoqMxyNfryUjVHZmSpmAV
	DyUwCHVjkuZpJFaO3+g+JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719480; x=
	1775805880; bh=Quexn3WqWlu87nNv25VRN0bgKke2xjgMd2vi785/Tn8=; b=A
	3S/Z1RxlMnxmhNSCgu7siRYBK/FlVdg3nYobTfUuwFZDIZdsUQWXoBQOqwT/fPfL
	hoxuaL3rp07SQUwmM88PWXJ+BQHjZK8DiFndhmX6tLkhI5zV8vkY1vZeI+ODmu55
	OJsreiJ6He5VSrRpvUlDjxCtm7Sh9slnEmreriuYgAQBHDY6/dZXwdZp1ILSURoC
	SoyviIGw2uwRuTQRBT7mEGBbCcWZ/uauecuKT6n9hJFFM+gAKnnVGsB/spGZdoQt
	lQaYnRBGTbWvBVcdidvpD+6rdVCqMhCKITDRENxZKsqzZ4NCE8VzSqIUiCnJaTnX
	fhI2ttLNiRnPo+OKvE9Rg==
X-ME-Sender: <xms:OFTXabrECyr89_Y8t22qKC2ks6Ra88KWWnY_DqQuOJPEmSApTOfDaA>
    <xme:OFTXadHWC9NPaj-vIsoC0vlDYhPIzTk-oS_G6qZpAGRbyI-eeZvSQNDtfFv14pHTP
    Z2Y0_GVMMkMISA1gYc3QxEOLx2mTvQUFUHTJYEd3yxgJU9X_d2WIms>
X-ME-Received: <xmr:OFTXaVlFNPraoU4gyGfJ8pQsFX2PpgaNH4QJGyuofAbMrIbKKHxZEddqOTp8Povzf21wbh27jXjLuRcWdvUusRi8R2P_xzWdMnznR8dyBQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:OFTXaYkAZoN3_L4JFWd_Mdj9IJUzLpGgahnxO_b6IKDFa8RAAQACTA>
    <xmx:OFTXaevLlk2jNZnrfaiqsIyNW9B9pXGcn1tcHs0sQMSWH-WQHbAW7A>
    <xmx:OFTXaTl2n1Wc9qobOYH86maRoxOhEhCRTCvHSeJ-B73BwfXvT-Bh0Q>
    <xmx:OFTXaRuWe5FwuYA5YjRJAFQOqPEb_TAFlGVMrNuIhdS1VWzGo7j57g>
    <xmx:OFTXaVHQal4Ix2FUpTzyF5RMkgG2l-QPtZkyRwyg23By3cfo3P4BHRig>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1770ada (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:24 +0200
Subject: [PATCH v2 03/17] odb: fix unnecessary call to
 `find_cached_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-3-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

The function `odb_pretend_object()` writes an object into the in-memory
object database source. The effect of this is that the object will now
become readable, but it won't ever be persisted to disk.

Before storing the object, we first verify whether the object already
exists. This is done by calling `odb_has_object()` to check all sources,
followed by `find_cached_object()` to check whether we have already
stored the object in our in-memory source.

This is unnecessary though, as `odb_has_object()` already checks the
in-memory source transitively via:

  - `odb_has_object()`
  - `odb_read_object_info_extended()`
  - `do_oid_object_info_extended()`
  - `find_cached_object()`

Drop the explicit call to `find_cached_object()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/odb.c b/odb.c
index 1d65825ed3..ea3fcf5e11 100644
--- a/odb.c
+++ b/odb.c
@@ -774,8 +774,7 @@ int odb_pretend_object(struct object_database *odb,
 	char *co_buf;
 
 	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
-	if (odb_has_object(odb, oid, 0) ||
-	    find_cached_object(odb, oid))
+	if (odb_has_object(odb, oid, 0))
 		return 0;
 
 	ALLOC_GROW(odb->inmemory_objects->objects,

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

