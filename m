Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C81EFFA1
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484805; cv=none; b=gaUmW11DzcJqt6fuZ7ADOqxTB9bPXWECydyJG8XHvpM6CHuKiU5FZANFaMkkwaI+h5xAtIy0sASsgcfThBfu+72/ufQ5a2RKK8wbeeHXZJmm55BcHniBCO2vuYHrHIslvev0VF1yu26HA3uwUKE/XAV4297R0YD21BfKXDV8YAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484805; c=relaxed/simple;
	bh=Zff++2tr4tfwSjORosB6naYOsfcn/w8D//PYDoNPlOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNdMEiIAuPsNDvizIhzZ4X+Y+7DCRaRLcmAm3/JnrFxhB6q6UaDA+FIXELBIZ/SEpSV+z+1U2pXgJH+njcDx9Zzjffq2b9fVUgI/m7usVCv27CCVeKB7IYuRo0aqb5xc76UhDdgRtP4pOUtVNmsGzqPvzdqNZSKGHcMae18t5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=acV26Mig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pbx7Z9Do; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="acV26Mig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pbx7Z9Do"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A7601400080;
	Sun, 23 Aug 2026 07:33:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 23 Aug 2026 07:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787484802;
	 x=1787571202; bh=Shv2Wq7XJRT/clHzLjjwgFZUO6xVmhlD4Y3EdVZSzno=; b=
	acV26MigQ8dPO+bvidTziQBh/ssD9w358zSIZODyGOXqProEBO348AnO24i+W2YO
	/9cHEUFOX4WmZFGuyao8lb+C2LudQyqWL0EQPH1+O6TTDUao3NiIer568kJq7+KK
	OBecJR8c2J402mgYkyZf1kQvE4k/VJKhrD7IHrzxFiNmSxaUDi99U3jxw2pH1y0c
	5SSaAvMkv65CmEtLmA3oniBiEPi2Azr4kUf5q8FRov/TtTWsqOq8/od747YKOR7f
	Cq8jdQ7ii0rSKoMg/TpSc4cYmu5WcaawA+hCmKxy5RdXJvuJVP6T7rm8/WkHtdAX
	fxYJaoQsw/MLiQybvFxiZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787484802; x=
	1787571202; bh=Shv2Wq7XJRT/clHzLjjwgFZUO6xVmhlD4Y3EdVZSzno=; b=P
	bx7Z9DoUa3Z5DerOISvvGvS6p947lBAJ0hlqfOXPyBuW1C4adNbk3ACZ9NQA60H8
	y/h3oWKP6P0GTA0toIPF9sNnuKVhL2Ac6dR5WLXk43woiJxNPY718f4s9dpeljaz
	kSmjSQwBl8FbZ1ga2KQcO3cpehhme4kWbrbQgkaoPht3DT6SCbMzFnk7yZWf4NAI
	hJv9VAbkRd2k13REbselwxSbjigZIH/oBHZgUzmjtW7E53OFZwZBaALDh8ycKiHy
	9BvBHaI7edGZSjwa+OwzgG3nUNfKKYBnKFHSmc3s7jWxDTqNxWowhFtDRWIV4wyT
	o7U6R4U+g33iU2E/nH+ng==
X-ME-Sender: <xms:gdqKaoFbc73-ejhupcDNvUoA8u9euKtQwm3qKQoEEfzmJP-U-NYkhN4>
    <xme:gdqKar7pKfVYggUigdGBgxm-Glo3eo59fOcdY-u5vG3VJbo1i35WJuqHhu1u9w3jS
    Kj9o8Sg9eoGWupAiWdKDGrTwx9qLrswYaZJqXAeTFFXihuLdM7rpMk>
X-ME-Received: <xmr:gdqKautHISMSCpAedFIDhZ3Y3QKbhOC7ayPndtwpOw_28-oiK90DrvqlkjmE-rMbx0hM2atB0rhLtOZ8emNrn4GWKTSuax-74J8zn1U7QwiiUDnENC1iC20>
X-ME-Proxy-Cause: dmFkZTFfJ3LWw51gC+1cNjjS7elSyMDiWlFQmemF9lL0fYBM851lerZ4k4xRpiBSwH+R4W
    451qFezDmEOh/Q2iNE0YpVVEhLqcRZIYIMEfKUsMRYfLsN70n8MCVcKIIP5iNzo/OF9k8Z
    fpkSRYckclG3nWrEIc2nTsZmeGYZacUh/bilZPpsd7/5XNbDlC1z+gpc5B1AqV8g4FBKlh
    qtdJLaaDVn3Lbohj3KaFI2eEBTQAueJYOGHkEvYCEAMAPuP/aGoIJOsCSQlWi4r8M5SVdx
    kruf2sb1J7RaWe1iK1BrrMIOw8tEjP3YPCl0isvLjM8e5VHZGSZQCdPIVrWXokv2cacTIW
    menjFo1K/VvpLf8aERA61PF4GultJBN1JSqfhdpc4Qln2gU1V5gBnbk9HO1XjmFke05Rmb
    CJ8ccu7zYAJ/KcCn9dTdx0FPAy/KZzNQww9hWB7XvASmXk0R8f8qF3C+SBb39lNFl8XTXX
    x/VEAfp7Y603zYi0+B6i2ZMz9GlemMmuxL4mXAr7Lwg7rByJYEmzexCcaEsMfHNDWdYBxA
    R6J7HXjpb87dy7PMBSuy8tTiRHMTY1PxfMcCQfLOxeCzZMO8Zqzj5YS63C+M91T29WHvvC
    17w6hmp1m1Rf6h6DkXjMlEF1ZIU7QWQHAP2vdpXLgsgoKyaztRfztfuJYlFQ
X-ME-Proxy: <xmx:gdqKas72rZ8wagRuXD3TgNmMt2k2nUaS_GKyI-MwI83buFZmJjhW4Q>
    <xmx:gdqKapV3TcH9D6rnMLytC9MzlH05F7zNtM30bpLpYRW08INve9WdEw>
    <xmx:gdqKau_bsuIhjfsZRr3ORVsjdm_6aBJ6DeUesUg7BveEy0X2eOYrZA>
    <xmx:gdqKallFQVVIBgvV5kQNRAcxcXFDvfnc64Df__lrAe_op3lBuKqoxA>
    <xmx:gtqKajeoTfaY6DkcNsF4xhEmtyLyKPSoLhW8Uic0OdJsomOi41k9TLfM>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 07:33:20 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 1/4] doc: git: list gitdatamodel(7) as a concept guide
Date: Sun, 23 Aug 2026 13:32:46 +0200
Message-ID: <V2_git_help_--guide_datam.c21@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz> <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

dee80940 (doc: add an explanation of Git's data model, 2025-11-12) added
gitdatamodel(7), documenting Git’s data model. But it is not mentioned
anywhere.

Let’s start by listing it under Guides in git(1) and with `git help
--guides`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Msg: s/everywhere/anywhere/[1]
      🔗 1: https://lore.kernel.org/git/aohDEKEs82MaWECV@pks.im/#t

 command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/command-list.txt b/command-list.txt
index 21b802c4202..63ae2a67c94 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -217,6 +217,7 @@ gitcli                                  userinterfaces
 gitcore-tutorial                        guide
 gitcredentials                          guide
 gitcvs-migration                        guide
+gitdatamodel                            guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
-- 
2.55.0.13.g85d2d65e389

