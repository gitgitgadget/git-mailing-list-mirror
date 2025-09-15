Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7D2F363B
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926481; cv=none; b=bhBNgx/R9ZJLNV3iFN4tM+kETP87GQdnxfDO9iR6HG9c8ta9pThwud8Oox6e6YFip3GyIvQ9Yemsk8IrxkFefZcu5lisSKGV/ggaiCc5+786qEyAkOj7Fhf+Ftus5mtwR220fL+omVRKhOhPH7xDL0KjPwTOPp8TaM6Jtv1u1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926481; c=relaxed/simple;
	bh=Ntjre8LVao8FkApxYYJq7b0MLC7/oand345zv8/67Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIBaM/eIvpGUDls+7kUyhqPn506CfRvqPdMbK/hUmppo/W4fY9uaH4TstCSw2GlU51jenE0QbFSgp1WBI8bDkFZqGeuAgV/6s8X28II8M3Iij3u5R5bnbx3DFu2AwoCWfg8K99nUrznW2f8h9u+sSfD6YvUSDa53Fv6684ywFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gc3A0Shk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YB2F4A5Z; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gc3A0Shk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YB2F4A5Z"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D7E5140002D;
	Mon, 15 Sep 2025 04:54:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 04:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926478;
	 x=1758012878; bh=04P//v9elUGfCGONIKzDlrSJMSs+X8n/ADaZBfP4vJQ=; b=
	gc3A0Shk6avU94pKqnZbf/f+3IZSjIcSLhk74CmGYu9CsduLY7M45z7hgJa5Z+kl
	tX86DmHQrY6gM84ZiI1E62pwWQQ0a2iGr2yPI7iLbq+tJ3pJ04LeWBVjp1i3IoTU
	RIBpFgxYb2e0iQjlWSRh7pwguMrxVrHG0yf/yTQep3dTW4rqQk7NldDzH8VSzrUS
	cDbr5xGFd0gfUbcFXHJ4wQ1HIsotyoOZM/uUKO1MJndoMLs8M+YYEZ/FlK+zDKv/
	r7CeTtl2CKIC79vAdJBbHpGH6Piwwym1iiQpSpZOqMAahHhZtt1ETYbhLTXBmUaU
	TWeUWkw8TF/opqhQl4t4IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926478; x=
	1758012878; bh=04P//v9elUGfCGONIKzDlrSJMSs+X8n/ADaZBfP4vJQ=; b=Y
	B2F4A5ZD13W/YJctbI+gJhvLGZLG15GLB9ATcHm+V0WM4uaF+CRHhBHgBeQ0l+ik
	DAdEj1G308bpzH++7Q9DwbEnYAkeG/TbBfbMTJGD17FRNxaij++yoVQdEWTvQWOk
	YOlYFhOnyPTrpduZwOMH9wQMDFLsG8HAFDmjV6xBEIIGhXw34M8DDTCs+uPYomYq
	fuwaQfmlqJq9exlPSu+71WGLpB6HHwqoiBC/CVMJxOE83DwWv9NcWilllEH0vKwD
	p5thdD3ZCpkyraC+DjcFlYwX4EyuIbfRZJct5DU/UpcfncTbTEY//x9RnON/AeQk
	qpgiTMZR1FxSVgkX6U+0w==
X-ME-Sender: <xms:TtTHaH_W0tGDSZJWm12466XT6Or-Ox_Loxwf2YthG-Mgu2NUzpnUpw>
    <xme:TtTHaPMAokWE5YmpfqsrptSZ9zgBM8Jfkgd_yxdJvL4TTup8pLDf2U7FbXN3EzPxf
    MN_GPCcl5EtuhRkxQ>
X-ME-Received: <xmr:TtTHaLfjeVJ2oK3f8F-MiZQZzuPChhMSejAIuxywV2_reKakUJ5KQDP1RqEL9HbpEORb8gnil-c8zjQ0O-sNGP_piij6QZqndn-AbjEjj-xykw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TtTHaOUbRnSTsKoKFO0XdxmfClJxReFuDWLKroQQ5erxf2gNjRpAjA>
    <xmx:TtTHaDj4AdDmwY2PvhrxOm-0IZfqHHeh3USSat77jYmzDXjXULAWSA>
    <xmx:TtTHaN9Hsg-USpkMvBmhSCJPd9d62uTyQjvERr3bqvk8SwIAvXuSJQ>
    <xmx:TtTHaFY1gHZxSNo3u_9czEgJXytC5hnHzU2yFE9iHlEX52Ze1Ol3Zw>
    <xmx:TtTHaBi4Nm1Pw9dYPIKIDp4rUrL2Tm-d5KNZpJO_7zxL4nAT2PZkeilE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2841b84a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:21 +0200
Subject: [PATCH v5 03/15] odb: move initialization bit into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-3-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The object database knows to skip re-initializing the list of packfiles
in case it's already been initialized. Whether or not that is the case
is tracked via a separate `initialized` bit that is stored in the object
database. With the introduction of the `struct packfile_store` we have a
better place to host this bit though.

Move it accordingly. While at it, convert the field into a boolean now
that we're allowed to use them in our code base.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 6 ------
 packfile.c | 6 +++---
 packfile.h | 6 ++++++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/odb.h b/odb.h
index 22a170b434..bf1b4d4677 100644
--- a/odb.h
+++ b/odb.h
@@ -169,12 +169,6 @@ struct object_database {
 	unsigned long approximate_object_count;
 	unsigned approximate_object_count_valid : 1;
 
-	/*
-	 * Whether packed_git has already been populated with this repository's
-	 * packs.
-	 */
-	unsigned packed_git_initialized : 1;
-
 	/*
 	 * Submodule source paths that will be added as additional sources to
 	 * allow lookup of submodule objects via the main object database.
diff --git a/packfile.c b/packfile.c
index 36bc240107..f37557eac5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,7 +1027,7 @@ static void prepare_packed_git(struct repository *r)
 {
 	struct odb_source *source;
 
-	if (r->objects->packed_git_initialized)
+	if (r->objects->packfiles->initialized)
 		return;
 
 	odb_prepare_alternates(r->objects);
@@ -1038,7 +1038,7 @@ static void prepare_packed_git(struct repository *r)
 	rearrange_packed_git(r);
 
 	prepare_packed_git_mru(r);
-	r->objects->packed_git_initialized = 1;
+	r->objects->packfiles->initialized = true;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1060,7 +1060,7 @@ void reprepare_packed_git(struct repository *r)
 		odb_clear_loose_cache(source);
 
 	r->objects->approximate_object_count_valid = 0;
-	r->objects->packed_git_initialized = 0;
+	r->objects->packfiles->initialized = false;
 	prepare_packed_git(r);
 	obj_read_unlock();
 }
diff --git a/packfile.h b/packfile.h
index d7ac8d24b4..cf81091175 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,12 @@ struct packfile_store {
 	 * the store.
 	 */
 	struct packed_git *packs;
+
+	/*
+	 * Whether packfiles have already been populated with this store's
+	 * packs.
+	 */
+	bool initialized;
 };
 
 /*

-- 
2.51.0.450.g87641ccf93.dirty

