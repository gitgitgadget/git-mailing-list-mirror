Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771B378D8C
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592152; cv=none; b=leCWl88roPpP8Aze2imXw3ppjtcMwetCfMzKn+/ruDSnAmpRj0wa+IrdxdpMlyY7GL2/QuaPBeQTiw0UXWs2Kgq37ygg/DdA0Zc1yIr2/ngbLo24Op+U0uRce4yzpRp56+iPZxJp62fMRM8wRln85LGSth0GMDluhxj4wN0Hkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592152; c=relaxed/simple;
	bh=b7OHC+53SZL9/fgaci6jW0z0YASDBBGBY5tPq78AbKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3mmq3MF3Bu6CaCKt0RGSwh8lje8fntnEMLV8kn2dvyrxZN7ZGVxj1N804L+8CfoIDZQUFjiOFlONRo99ylvShvGAz46fm1LwR/o3udRAmcX5W4rdK7BMLrB052i1L+Ns1ZFL33qo6CnNFa1jRbyz7i2oEc6ylfafTd2kdhGPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Zcs/A73N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OaHQrNkI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Zcs/A73N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OaHQrNkI"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4FF7314000B8;
	Mon, 28 Sep 2026 06:42:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 28 Sep 2026 06:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790592150;
	 x=1790678550; bh=CPmyLMKWM51/DrJQANcXIaSpU1BNpkjzykFIadIFqWA=; b=
	Zcs/A73NiUXWq9WgW2NsvTquoHf1ERO2TBU8Zmopi1dkX0Hgr/rrrYBzspZEbiBk
	iYgPUKMtbtNcFiO+9vf75D8e/xuC576tlWYeorOQu/1xop8eP/ZVcXZn2oB1soo4
	sCd8HCSXkiAfKo5WUlOpz7qHLWSAOp+fbg46ZOg8z3H068VIrf+UKUb4M3Wo/xa9
	chGQT+DZcf1aej6rwI9tbZR7N5RYmiglw4axxxsTgyrLsKloVJqLefgyEx4ybHsR
	z/gedwLAcZy5B2ian2y9mJoKNYC0LhXFxRkrbDuRWN1Ily7TEcEc1RKAUvMjKcwy
	xgceOlnkPzu41OHTem542g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790592150; x=
	1790678550; bh=CPmyLMKWM51/DrJQANcXIaSpU1BNpkjzykFIadIFqWA=; b=O
	aHQrNkIAu0fR/X6QAADBaJeej2y4Xa5eV7VSEJ5y585SwzNxhzyo1xquivv6qdR+
	ClNPT//M2CHXPvBx949nfzbFCYuWftvHrtgZ7IWEgEo/0y/D5z3uDOFHA6T6XwSr
	6x2fveziJ6Ju4oh+D7NeWxkdN8E+XVE1BhTVCJKxGrGmnSLpvM+dG8Gxtox7EpAl
	ybkV4K0+kQRCcbXav9lumaMFuUoFlpsPwxn7vvhlzX59NzqKkwFfNc6fAC3PZ8XY
	pCGEFJG1OuYQt8dPdHUPJY8XkmT3UulDZJAfDmXX+1yUI/dNHFvuccCE1cp7Vi27
	Tuk9uz+1nB2SX89EmvgbA==
X-ME-Sender: <xms:lkS6alTgzWdTG1x-53DijlcAc-_02lNU65uCw8lou1pWZMtpWT_pT3s>
    <xme:lkS6amPzdYEIr1OtbEdzXuwlJ6DRdaAxYfAeTsR4-rLyzhjbxdB_Z_FS-oqZO85z5
    FI_LikHohP9no3JbFcyvUpRyRNcTq8a0VUXulRYYf2d8PgbonRPhsY>
X-ME-Received: <xmr:lkS6aoObpYWlofgOo0JXC6DeSiaotBjinAlmvVf-sWbG8UhKL0qLQVwuI1y_NDZA-NXfJyAcj37lqoNFBY0zS9Y9H-OrESWWh2KDxkA>
X-ME-Proxy-Cause: dmFkZTEcQGIQV2SChG9y5UN4yfcO8vYoDxdzDSLJIOh1U9SKfkfEaE3hAZuyE3ECYjEf54
    ghB952nQQadiJxZm24zdXwCT32jGA64OiJPtmcmuBeudviJQUxA7avascDj7R1sbpfcxBL
    CHSnLE0qNpZfNzkrrhorcKf0KwsgfRNLdArgLGS2cyW7gNIq9xsw9dWz81LSzvrk3fI7Sj
    6Gt1mYKSjZOtuz55bE+WDa1kiA+JEHhthUBKAZB/s3xS3QpxiPLhY6zEhxbd1R0jaU8UMq
    Fl8w85Njsnc7IoMoNGfBsQwIzIEIMEMxMdgLULzJB2NDzwyRPflrE7ErmXLSE3kIxMNuih
    mYVDvb3QRbMYsa7Dd8EC2ExoTYu8Z+nene9Nsu4AA84w0DwZb0DoRL6qjh71/8kh8iR+ur
    fEDlFE6ntvDqaDup5Z6XzQ4Y27xD9Ww+1VPy6DyKjZXQdGWDTqkKj053uAU3c5LuQry1d2
    FuAAxxdRQwu4AVHF5KfKHBYjU9CQVKZDVYb2SRZZBw03689HWdNiXPpuH26RBBTl7utNbd
    YVXkvSrO7w2X+qdB6B8X/wc0kZqht/ca7L3cUmLFgDYOkt5mi9o4q0viqNz7FqSkKkv4uW
    dIZdvpHlzLuZbnsyhBAF6nw7Io49T0W12tNOJ20lAgD0ha0MXlXEDdKc6Iyw
X-ME-Proxy: <xmx:lkS6amtsyZDCxuqGOT00AArssPdtIG3b7c5zYS8o9XICJl8iWylW6A>
    <xmx:lkS6aiXHMMRKBGQAYXU6Bt2ETv1qj0_gmhRnexnXRjaCFJLnzUUobw>
    <xmx:lkS6auuJXRJ0a9TifM8fn7Vo2Rf9jzETLnpraVaeU2R04YqLbJyrAQ>
    <xmx:lkS6auXkMzhK8EGXA8p9f_YrClwR_FLZ_WTS8BtrZ0ceB2_WICAbcg>
    <xmx:lkS6auXOVYgMdRHiKJzBlNW2lyqleliv3c2LG8O3yGZX1whDEt4I28zS>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 06:42:29 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 3/4] doc: gitbreaking-changes: add note about living document
Date: Mon, 28 Sep 2026 12:41:27 +0200
Message-ID: <gitbrchanges7_living_doc.d1f@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This document has always stated that it is a “living document”, subject
to change. With that in mind, we should be mindful of a potentially
larger readerbase now that this is a more public-facing page. One could
imagine that someone reads this document on a released version,
disagrees with a point there, and posts feedback to the project—but this
decision could have already been reverted in the live document.[1]

Let’s add a note (admonition) following the “live document” with such
a reminder. Let’s keep it short and simple though and not go into how
to fetch the source. They can figure that out themselves.

† 1: Let’s say that someone on Git for Debian Stable reads about the
     breaking changes for Git 3.0. They don’t like something about it
     so they post it to the mailing list. Then the mailing list informs
     them that Git 3.0 was released two years ago and that the current
     document is about Git 4.0.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/gitbreaking-changes.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/gitbreaking-changes.adoc b/Documentation/gitbreaking-changes.adoc
index 9aba419efc9..410476c7993 100644
--- a/Documentation/gitbreaking-changes.adoc
+++ b/Documentation/gitbreaking-changes.adoc
@@ -73,6 +73,16 @@ over time. If circumstances change, an earlier decision to deprecate or change
 something may need to be revisited from time to time. So do not take items on
 this list to mean "it is settled, do not waste our time bringing it up again".
 
+[NOTE]
+--
+In case you are reading this document from a released version: this
+being a _living document_ means that you might want to consult what
+the current, development version of the document looks like in case
+anything here motivates you to post some feedback to the project.
+Because specific details you read here might have been changed in the
+development version.
+--
+
 == Procedure
 
 Discussing the desire to make breaking changes, declaring that breaking
-- 
2.55.0.793.gc667de3f2c5

