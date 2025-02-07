Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D571EA7D3
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929141; cv=none; b=nxtp9K5pjidT/gO/eJ5nRJcRPuzJYzX2z4x/NFswYRU5bL+uTXjbmtB6qIDYVjq8Sag03SyBJcJ6dsUWUO2vM6DkD1UDnjL0FFb9b9oYaBKGn51ji5i/rRGC1P59z+YUgyXem93aMMb5jq+iBIIx18mjWuulCxTSu33BzadRBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929141; c=relaxed/simple;
	bh=UZSyDGHmyvtglQ5JWIG+H3n9BOt/hfmR8oI12SvqJoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GK1+V9Jr8mVTxE2LN8Quo4NzTSw+uC/EE01daARs5X/DPf/boXEusIY7tRr97i4DEbFfXhnnXE/iYLBsJs6uWkpOHQpNFWeuiEBeqPEzAGwVkT99PIv85H+VPrYVAYwZzL1deeGyqu4RJP4HRYKQwdrUDKjJ+Vac88xkwhof6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PGAO7cnl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4fL+MzQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PGAO7cnl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4fL+MzQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 144F213801AE;
	Fri,  7 Feb 2025 06:52:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 07 Feb 2025 06:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929139;
	 x=1739015539; bh=0cll7B6pvDOi+gm1xYCTi3Yl2LtzE0zaIQ/Na/k6dpc=; b=
	PGAO7cnl6AnxlQIXTcBrB/Ae+Kc63YKC8HXshUpvNHQeBeeVR8oJuAQflLrOpZOD
	Ov/c1e/arZ923rTbNXn+OzrY7+4nIMHAY9ld0Yo64wozoZAfYHojTXwDsviZP6l+
	zKVs8hkiPC4M1VG6l1Q02TDolSuSEY3KPwoavhuu0tDQkD/1D6Y64JNRQ7qlgKyX
	2zYSapNnrcUC7JYjicV4hrqmfRLkECOAvo2bUEePrjnnTdXC9SxdUrl+2DLN13UL
	nKbks8VEfm6EhnZon8gEin48ECdviwfKUFZt0NAFXbe9kYU5E+RJL2AFFvRWdVxE
	yvpPf3kUaMBaCv+RYses/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929139; x=
	1739015539; bh=0cll7B6pvDOi+gm1xYCTi3Yl2LtzE0zaIQ/Na/k6dpc=; b=k
	4fL+MzQbidy8tbDKWYH8ZkiTLGcDsetWWv31EnoGfM9uZEg4WXYdyzhmLkaqmq6h
	/12jeBnQCpr9S6OzXywOC2rL+/A4oLgy/QeiCvEfDr0vw21wFFEd26ldj6nckYE3
	Zpra3PfQ5XRQUBJz69kLadHtYX9qR3DEDUB67pmEJG6DymIvqUHjnFkCraD/RzmT
	Vg6J35Cr2Ax8pJw0EojB0S6cL5sju+DmD5FoHtwuNO2KllNovHEGnR37qMmFLNvU
	KGPTfNTXCV2I/O7q9tOqVw48je47S4fnUqpq2GYwypLU2djK9tTpzwtKlwAPRs7h
	DpCv7WnAzafUGOgRgOHUw==
X-ME-Sender: <xms:8vOlZ5CH0otYH_O5xSZWL4Teu34ibNGsvzPrs3WjMgAtFxZuL5Lgow>
    <xme:8vOlZ3g0Jc9McD7Qc8ZJx35PeyAXYcMcGswdg4sJOtUE5YAMhbEvnNKmIOKN8p-Kh
    -aLrVSqysVMFY1Zng>
X-ME-Received: <xmr:8vOlZ0l_-wVyu-pacuAWztPjR4-Ogn6_gEr_IvBo-u_i2eyYWUeLkuejYUSIDFluGBksrjfsOcV__UKFIjTKb7rzAEwhrHWxOTESxNP8QUscXnxf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:8vOlZzw0oGp9IzKhURxTq3Fr3oldOGTmWcSqr5mYIbhkZpFiQJ1ANg>
    <xmx:8vOlZ-Tpt8ANCPfzmJAH6XIOwDfF_Bho3jRqPWJ1yAPhaS0hm_cxeQ>
    <xmx:8vOlZ2YKiCEHQ60Aw7ul2-cgzXRi06-5FEyNE6iJDEYkfwIF56ogkA>
    <xmx:8vOlZ_Si6fwhr0a20U7DMkIGEJ8gJtq2bLGScK4dIV7eEkWLMbAj-A>
    <xmx:8_OlZ7Iw0hnvY6UsycAOdVvw2d9_72U7gL_jo7gMytmo_W_yzB1J1zd3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1867b355 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:13 +0100
Subject: [PATCH v5 18/18] Makefile: skip reftable library for Coccinelle
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-18-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

The reftable library does not use any of the common helpers that the Git
project has. Consequently, most of the rules that we have in Coccinelle
do not apply to the library at all and may even generate false positives
when a pattern can be converted to use a Git helper function.

Exclude reftable library sources from being checked by Coccinelle to
avoid such false positives.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d3011e30f7..dc2ac32e4a 100644
--- a/Makefile
+++ b/Makefile
@@ -946,7 +946,7 @@ FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))
 FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
 
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES) reftable/%,$(FOUND_C_SOURCES))
 
 LIB_H = $(FOUND_H_SOURCES)
 

-- 
2.48.1.538.gc4cfc42d60.dirty

