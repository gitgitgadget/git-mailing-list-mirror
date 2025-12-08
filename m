Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4B2BE7B6
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181074; cv=none; b=t1Ern6IrB1GjYz/dXyga03KE79QmSwFK788oCkzUZGj2Z+95ohfQnpF+lMV36pb4QNEnV8iKTWgYZTg7wyp/a/4V4ewmHLh5yfFlopCE6iZS/oKnauIg3bb47hj9uhJC2XvHmWy0HsptA3nJJYgxoIRJ31r8yS25z0ogdTH9Vhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181074; c=relaxed/simple;
	bh=29gRAn9KD3RQgFv2e481YKtNWYygGHUi0fjpOwyYZnA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ByN+3NnaRxX7wCXWj+hktfc+JchdtrBS+fSpJGvtaWYd3xRbxY1fL2QUH3vlua60d98/yhxMNcVwAGEebllhpMLaQ5FJ2UrghVygjpNhnVctsbYSXtUcTcDsOJGh7+hAuwYIXZ0Mezld5YYfyqRgFrWMuEYCmHJ4KlDZy111HvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rvtjFJm5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p/OKi7kq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rvtjFJm5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/OKi7kq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D30097A020D
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 03:04:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 03:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1765181071; x=1765267471; bh=bhQIm8XxaL
	mi1cXACvdsX8/tr7sj/jsKSQuAwmMZNQ4=; b=rvtjFJm5wJDavuMAfG19qdpL86
	f6y2HSEDG1XLzYGoOwbhGXxwn7fsJC7Ds0aoF1UlrZhIr98A/yHdyiaMFZ5xKyib
	b4/SAAkgkjb2xujEpIb22FsFiLs6JGgLNZw8kAsbxNAovnnOrj98AwV7bppHht1H
	kEORPgI/3tSFbk3MkdyzhhslpH4/OUepW19QFr+goM71cPAz1hG9UtUi/iNLKupV
	47Xs5gXKqeI2PQ6EzcDKIqPJnTgkQ1IGzry9fs5qUmy6W1Zcutfa1FWE2xJCn/nR
	3G04fj8MY1OmtHZqZI1vEVQBA/fVFlP4PKAHMLyQb/DG46ZV3OrAwvn7pkqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1765181071; x=1765267471; bh=bhQIm8XxaLmi1cXACvdsX8/tr7sj
	/jsKSQuAwmMZNQ4=; b=p/OKi7kq0K6IQ+94DKsz2G1n/FVDKP4CSUOe5Ke76tND
	AP7lOhmTRRQ4XmoB0rZK2tW+m5EIgbGpHkYp02sxi4KItLKkjSvl7fi+GX3I0+Fj
	YbyAPiqpvBSEELe3Utvbq/ArTowoQR8yVvO3mpdtph0mkR+S2SEcjcoNZIOghRBJ
	P2hJ3Ia9ZRrgP4eJhgW0EmWkNlD1xIpheTOaWxJrnMWzCRtMELAEj6wQUzIQx8De
	BunuwvX26Zd/VRK6dIuTinIuOFpCmk7YeAejycszqxVDOrv93/KGunG3QBC6wsje
	tyCHqYFOv9mvdg+rBMLn6+cvEmidwIFi6azogDPEig==
X-ME-Sender: <xms:j4Y2aeY5MVZFMR8MQKxm76O10fO2JTQTMVQXL_ZaVTuTfEv8WtSBBA>
    <xme:j4Y2aYVfomeM7HbCgdU-kWy1JLW-O0BuMfbXnzFHiNzJE4u7-g5XnCxBlBLodmP2V
    X_VxJRY7JzJAcrqQ7r0HShlWGl2AWAxaj43Xy34jadwJXOtUQhfkg>
X-ME-Received: <xmr:j4Y2aemUsuL6Eqm5ZNvlRsSMh8hJL_llhxUry0ZOqPPzLTykzF_KrL7P3lPAobreZpuE4scz0Z3sS6-1TTtIu9dZ8alfBmx8K2CKOawmQNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehue
    ehgfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j4Y2aVw-FLWgZ4XDrh-BDmnAEXg-NSexXGfsfZddm6CXausGotIw6g>
    <xmx:j4Y2aZgqmi-JuyKneEGeOofebo3eDlDOpOF5gmZUHxKeKILKyTO4mw>
    <xmx:j4Y2aaWfs5w5F8r3LII_19M_y_ZvhFgHz-3yG7IjBbwIzmHGJQyREg>
    <xmx:j4Y2ab1ABGsPLGz-5NaHAg2QAjnKYK2DXIFRTBenqOZrhnOrZLwQ9A>
    <xmx:j4Y2ac7cREZ1rckNuPTmfmaDt9Rri5iTTtpn6lud3ghHK8LV8bO8cKoo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 8 Dec 2025 03:04:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 765ce73c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 8 Dec 2025 08:04:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] Refactor handling of alternates to work via sources
Date: Mon, 08 Dec 2025 09:04:17 +0100
Message-Id: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIGGNmkC/x3NSwrDMAwA0asErStwTH70KqUL2VYT0WIHKQ2Fk
 LvHdPk2MwcYq7DBvTlAeReTkivaWwNxoTwzSqoG73zfejdg6HB9G5YUkD4ba6aNDXchtPLVyDg
 5n6YxhpCoh5pZlV/y+y8ez/O8AI03QWFyAAAA
X-Change-ID: 20251206-b4-pks-odb-alternates-via-source-802d87cbbda5
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

this patch series refactors how we handle alternate object directories
so that the interface is structured around the object database source.

Next to being simpler to reason about, it also allows us to eventually
abstract handling of alternates to use different mechanisms based on the
specific backend used. In a world of pluggable object databases not
every backend may use a physical directory, so it may not be possible to
read alternates via "objects/info/alternates". Consequently, formats may
need a different mechanism entirely to make this list available.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      odb: refactor parsing of alternates to be self-contained
      odb: resolve relative alternative paths when parsing
      odb: move computation of normalized objdir into `alt_odb_usable()`
      odb: adapt `odb_add_to_alternates_file()` to call `odb_add_source()`
      odb: remove mutual recursion when parsing alternates
      odb: drop forward declaration of `read_info_alternates()`
      odb: read alternates via sources
      odb: write alternates via sources

 odb.c | 307 ++++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 158 insertions(+), 149 deletions(-)


---
base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
change-id: 20251206-b4-pks-odb-alternates-via-source-802d87cbbda5

