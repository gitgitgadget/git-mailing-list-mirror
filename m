Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C71B6CE9
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771791384; cv=none; b=rAb5j9lRezDaZZ4qezBPM/XzsLtPbnrJuz3IOprHVrjc2cffJgXK7ztE1wKQrh+y7JRb4sD1D+9IEFWnM3yK8cbvNUomty6zZiNCLuqDVGnuXzAx6Qs1bFL0uGiiU1hNlXiVgzvFrfzR/myYcPvS/TpjBk4fqk3xoWRN/4jN36I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771791384; c=relaxed/simple;
	bh=7mrzTLCk6yjZ4DQamMW3kFFw8XhupgrEAWrf9F89PfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Io+GYIKyotYnNan3PGjxC/NRopjcUImVSfdObekueQyMF4oyYH1226XN2P8p0SUBhB8QtWpcITQCIrji8MktmtFMaGqBQ4yKwFFQ8I4FXdk4DIgcJOPBPnjWiL6PVM8aZsQHrwtQHja+oGedgCDMzwxpjU4zLZjWjeHJ8Pvbx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a2FW6Oc1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jwF/OOA1; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a2FW6Oc1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jwF/OOA1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8243A1D00163;
	Sun, 22 Feb 2026 15:16:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 22 Feb 2026 15:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771791381; x=1771877781; bh=6XFDWzhxN5
	D44U/7enzk7Xc3bo/xtRshI5yBTCMTGE8=; b=a2FW6Oc18cHxwp+ABQev7xNYoL
	Si3Cp2/jEhe6qMLWDBiyv09VwVxtsFRdGat9bUOthnHXMI0Xkl+VDzX6mTc0oLg7
	XvfeEnQii/1l70OymCSvCX/ep7iH/7frLcZjLFc91AXKI3pgCb0+vCqleNgmtDBh
	UQkx6C5nbQzwLDCWhHA2SKXN/G5K6d4KxGxuwd+oW7kpYAU2TiRh1V71PXSPV7tH
	XkoXsffu/zutB5dtcgKX5IEUogvvnzFpVR5RP4i3mIcEXVzHklFBFLnbeo5x3bn4
	FFk8L5i+++k57KqUvTYP4fhjwgUnjQotlq4FrtsZFsolLh0iLEEnoW5oNrJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771791381; x=1771877781; bh=6XFDWzhxN5D44U/7enzk7Xc3bo/xtRshI5y
	BTCMTGE8=; b=jwF/OOA1l16ddGpR9qe4t8GbqCArCURXbFtXRsJQ6Zpt4Mmg1qB
	pxpt5DvADvLvhA4i1GvW6mJz1mVpu9Pdt0oVmoldOK0z6UIiJHejRvZ54rq/zRST
	31n6Ts2b7ATueao4/TRMwpXEEIh7JzA/+JtS65AuBjZSEEEDGP4MePCgO0ewK13N
	SZAXOAe07X1l8mwit3p2bPZ/XQvIDnADY7reTgCKrfwpNX/J+HGYm1ya0c1OnFqY
	EVgrlvBR4T81ZFKIGC2Z2J07XmkQwS9VkRDG1ttj6Xpz69wUrShpcxK6xBMEQVxE
	1K2TaUriHsLpUfFaRg7rzFxGNqnEpCrAk5A==
X-ME-Sender: <xms:FWSbaZliOFp8PghsSpN6FvLcXX0R3bbrrsU5is9l4sdoH1jkTVbB-w>
    <xme:FWSbab0x0ghGgLuOKFP9PlUtOZW2zwfsQaBuSrwHylOFgeAUAUzeOg_GodAzPOU_h
    9l-9yyw15O_GuWrJUAt2pCCqQ5tSLRmYcrzibk9x3Yzd8swjs_RsA>
X-ME-Received: <xmr:FWSbaUoJVch4E2XMBfAXPBwJTHMg9T57deaJ2ttC6zX1VTUXXMmUz5uFQwk6dvAaVw5CEav3pZ52pc1Yqme_PAgfJmjStCO7ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FWSbaYd-5Ucr18yxHoLfQU4eD9GBcR-MSVKynZvLAbb_Q2PIXypUfA>
    <xmx:FWSbaTpfGTCAj96AayXq-RRFoESG8bWaVlVhE28Ai0Nu2JsAHzOb8g>
    <xmx:FWSbaZH1aaqnWzB5WszCW6T35fKR-nlUQqGZRzxgwXFvX1h5yCaueQ>
    <xmx:FWSbaTvoVGl0qi_af1HZzz1bYSTkl4GmUkfTj6Fy6DegaoojrlC4ag>
    <xmx:FWSbaUmgstJmvsN0MPvzkfQX8ObHZS4h_T_yRX8cC4-LpNneDW_9MY4h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 15:16:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH] object-file.c: avoid container_of() of a NULL container
In-Reply-To: <xmqqms11qmsj.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	21 Feb 2026 23:07:08 -0800")
References: <20260218210120.1146078-1-jltobler@gmail.com>
	<xmqqms11qmsj.fsf@gitster.g>
Date: Sun, 22 Feb 2026 12:16:19 -0800
Message-ID: <xmqqh5r8r0to.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Even though the "struct odb_transaction" member is at the beginning
of the containing "struct odb_transaction_files", i.e., at offset 0,
using container_of() to add offset 0 to a NULL pointer gets flagged
as a bad behaviour under SANITIZE=undefined.

Use container_of_or_null() to work around this issue.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1a24f08978..bd580ef032 100644
--- a/object-file.c
+++ b/object-file.c
@@ -720,7 +720,7 @@ struct odb_transaction_files {
 static void prepare_loose_object_transaction(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
-		container_of(base, struct odb_transaction_files, base);
+		container_of_or_null(base, struct odb_transaction_files, base);
 
 	/*
 	 * We lazily create the temporary object directory
@@ -740,7 +740,7 @@ static void fsync_loose_object_transaction(struct odb_transaction *base,
 					   int fd, const char *filename)
 {
 	struct odb_transaction_files *transaction =
-		container_of(base, struct odb_transaction_files, base);
+		container_of_or_null(base, struct odb_transaction_files, base);
 
 	/*
 	 * If we have an active ODB transaction, we issue a call that
-- 
2.53.0-455-gd82541b467

