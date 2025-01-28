Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2431DDA09
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053697; cv=none; b=FGbPL6QEoEtLhtTH6kKdiDO/VvIJqOfEz7zruvCgK7E1V3KLDxLqKSHfbKFMf/kcA4Tb9M7wxkFb7fSi0fDkMkiwhpG/XHMe2SSkdW7k7Zraa2Ugp5ItauQmKnHhzF1J16IJq612P6L8uSGW7aqnLZVsf4MB2YgeSXeaL8142Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053697; c=relaxed/simple;
	bh=bcERtp5CTujJnCyv2osmDwvtIWIgD37QpbVNEKQtW8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9T/Bmb+IOFILn6fJYC3GRp8LV3VVdHr7BHGWERUI9uVo/QjJXzlMBlXW+DckLczXyQUowfJjPiDjoxGufwcA86rYWld5dANanot5o/rWsRUbcI2fiyLIIhmxpBhGdvEWh8vBXVJgMr3IzoPwEeie4f7/Ob5mazmTjHx7+CLYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kPEeJnj7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQLBNea1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kPEeJnj7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQLBNea1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2AEC02540225;
	Tue, 28 Jan 2025 03:41:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 28 Jan 2025 03:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053695;
	 x=1738140095; bh=+q5iTlbbkTNZleju2hevzSbZuMfU/guOc2bXjkrp0tA=; b=
	kPEeJnj7Se3oyTYBHjlKTLdCqndENrdVYbjzBjnDgtLzeqknTVI8grbD3au2iInc
	DoI+3Q0RJmh1tKmTU9B0LcFn6LAJr0k0Y4mh0VaBAHojSB8ocZQZliQQ0JeJqp/k
	33viJlsuRvZr35DhOiPStQbAYP5eYWvFe491X2Akg+sCJB5KZmn+U3bRA7ws0BhB
	s2c40oiFgih2+CZSC9Gg5HAPbAAfNwyuDD9km60AIAqveAfWSJY1GHWid3ndHtOG
	qNbS7X6iycLYYwyUdoqlRXIb/XvkqAgeVMVex0RdiovsjIkw/B5IxodN6mKWsbbZ
	G4VwnCsuv4gkYOUAqUzbgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053695; x=
	1738140095; bh=+q5iTlbbkTNZleju2hevzSbZuMfU/guOc2bXjkrp0tA=; b=F
	QLBNea1jHDaUwM/BHHJ2tMbv3jKHSY4HxuVBoWOWkKyp+1WDH1no4xPKXSOa9Ywo
	n5PDYW7FM/Dw5S4+O3Yg8saHUhwq2iFiBRblZq+rDxuyjsUT0ON3BlEH+NoAhnNR
	x9KzTecGgGQ3V55a2zG7YBFVg5qdjzHs4FIMkcU41Rj/QPZJCNVZtM0SEDKQYsZv
	dKdimext/tx/x22MsA4eVzGs0FjSbXq7f/0cnF+eIUPOeqlP0nbRzC8rLe7GtY89
	+qVtVXTt25Imtj6W3qyIXxoTX6w+lGX076sfnbj+1gCnKTbu7d8idiMdyi59GI7M
	opDASMkLuzb8m//yODvWg==
X-ME-Sender: <xms:PpiYZw2T-xllCmQwzQmQaJcPJ-UAHzepW9CVB2qmhA75RGF1IKkClQ>
    <xme:PpiYZ7FmLTQ-2L-C8nbWAJOd6aSROFw58l3NG3i_awncrAqAJ6eQY7xZml-C_EoOx
    fTa_-DV6nY7rNGhQw>
X-ME-Received: <xmr:PpiYZ44XJCJ5mQzi1tvsk5QW6IbaFLiaAqsFYFMs-LkySzsi_U1f0aGvVv30ToFrguz4UVEXiHoUBpqE9ZgJyshe6fC3Lgd9N-algHdEoLI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:PpiYZ50HUxZnfXeRtRgtZ17hvz5fNccdmVx04FpID6Xd5HL7wUZPkA>
    <xmx:PpiYZzEQMYFDgSq2tEnd0_JAstU4jQcWdotCVLy9AVKhlo9G13IShg>
    <xmx:PpiYZy-HggL0mTzW51JCK68D8tyd2OCUFMOxrNfnZPW3c-dM4FQUcw>
    <xmx:PpiYZ4la-SqZrYtciIzS_1REpaJ1JF1755kzIVQGvfzUWVU0GFDIIQ>
    <xmx:P5iYZ7ADPQVGFO_IyHofUeHCVNnooViBtEHAVb-Vr8cZqO3s3s8FvQjR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cab73eac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:28 +0100
Subject: [PATCH v4 02/10] git-compat-util: drop `z_const` define
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-2-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Before including <zlib.h> we explicitly define `z_const` to an empty
value. This has the effect that the `z_const` macro in "zconf.h" itself
will remain empty instead of being defined as `const`, which effectively
adapts a couple of APIs so that their parameters are not marked as being
constants.

It is dubious though whether this is something we actually want: not
marking a parameter as a constant doesn't make it any less constant than
it was. The define was added via 07564773c2 (compat: auto-detect if zlib
has uncompress2(), 2022-01-24), where it was seemingly carried over from
our internal compatibility shim for `uncompress2()` that was removed in
the preceding commit. The commit message doesn't mention why we carry
over the define and make it public, either, and I cannot think of any
reason for why we would want to have it.

Drop the define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index d50f487c00..c4b4b372b4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,7 +1537,6 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#define z_const
 #include <zlib.h>
 
 /*

-- 
2.48.1.362.g079036d154.dirty

