Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F32D9EFE
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059899; cv=none; b=i12xY2z9tpEGSDKbJmzMafbDIxROE1P3rRUFhus1fxYgNKApou8iBIVqS4HEv7uWKHSeVVZbANvdP6Gk+7ooy9Mp5opZe5XpttKpv1HysK8sgv+hucV9MK8cmqQFNvcoMotyN4DwcLahb/8LJVvYiG6NxirbZDRgG7LiYTcxjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059899; c=relaxed/simple;
	bh=Nro5CRxBjzfdPLas3HRTUxRdqB+pEjls15m4ikWDubk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WaJFwu7q/Sd4NpNOWm0N42cARAs2eyAaz+q5JPawC2I6EyBVBSv1Ehsl+AjGiYC7KDh3DDBOtRtu+sGMG464AtDxTpsWWVNbGxIc3RANbOggu+Wogq1OamV97tYMGystV9/rzfxGBn7io80LTnlSS9JGaDU89dHvj3S5lbiApA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b/AGN4kT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M15peoqs; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b/AGN4kT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M15peoqs"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 54961EC04CE
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:18:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Jul 2025 07:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059897;
	 x=1752146297; bh=RGxquupVtjfFyWEWp6gVX462kzxDh2ndpEsrrDT7l74=; b=
	b/AGN4kTLDusFb5TO+nhiqpk2sLE04RkCuZ1EGsMyGpXH4Hw+UYwCKDc5HW2RU/5
	EIl53rFppEte606teDP8i7UkyJlow6l9Slz0w00oo2suCdtJjoFfLNgFbD9ypsgt
	VZt5uP0T7TQyscAJJDjUvn4HwF7KubOVpWaJ/w/YbAv1l8nOzKtrgSib6WsLTMPi
	aMc6d0rPofYB25+kXfm0Y0ejcMoULaRYAyp8g4T3FruGYJykEwSjdW0I4MpQZ9v8
	LmgUnjqFYLYoIuDQ4c558CezZN86m+0HDM+CNo/DjZe+nVvGQNvLhsMZNLhHTSPC
	bfe2+FxrY+txJM/fJd0fLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059897; x=
	1752146297; bh=RGxquupVtjfFyWEWp6gVX462kzxDh2ndpEsrrDT7l74=; b=M
	15peoqsHKHQTXRQQrY50gXSW0e9IkwB6ZCIiDwr49FcPpBffVrkoJ0foK9LfS4qA
	nTZJwqT7r9GCmLt28CA/jQ/zCFTY2kmSYlvM3lCOY8qe6xgp+otXeosIVLy9ltU2
	7lseNrxK7xAY/zHqLt9CCoafs1j4PPrxKjrG2gWt0zFA44ORDryDzgSEmC7zjzMh
	uFtwtqqhQEYBnCWhoXJQ2VUZGhRrdzI757pAlZ1vlMdpKPh5nePdWB1/yinbKy9F
	bkIdrY4JvVX0vVYezgLAq0hJ03C8ksp+ufN0Emxd8rruKBYmg8QTkiGs8o+whdH8
	mQHLpYDGE3aa+XIAPRg9g==
X-ME-Sender: <xms:-U9uaJY9Iq9o_PahIBOd_2WiDHFZBTckLrOPyol4MSsdS6_-kwLuZg>
    <xme:-U9uaCZoU6un2dwZA2I4RHZHr40g5pyFMaFVgN3VsGiLvfV5dNmgYNVFTM6RR4nzI
    Bgy8xPJBSLzsaNg8w>
X-ME-Received: <xmr:-U9uaFX9kkH4i_X0GK6RBj0afZBf_SntUPIHV0Ukt6aaSBvBvlyB7YhrHJbmP0pFJYZq1PWZ7MsgjDopIrI2hJayLMMpHfJBFVXAAcOj6VZNeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:-U9uaJ0wsdwM0ZH2qG6y0qVjZz-GYlSamZD894eFHp8wdtWwyONOMw>
    <xmx:-U9uaMatheE1Suh5eVjSDnAOhrVPGiR4dGLZ7R9kjP7iwSvMyFv-DA>
    <xmx:-U9uaMrqkRXNnvj8jNjdggf0WqbAkwSgV7V4h1vEKtBgd2TCaf0PQA>
    <xmx:-U9uaIoT3r6SP8RHmCN_DaBb4fXE2s0tDUNjP3JNcEJn-AF4-9HraA>
    <xmx:-U9uaMy2rSS3vwiksnBLPSVDDL0EDjBSzvJex7KHZ3OBYKSB_p9_4AZO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:18:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5fea614 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:18:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:29 +0200
Subject: [PATCH 19/19] object-file: drop USE_THE_REPOSITORY_VARIABLE
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-19-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We do not depend on any global state anymore in "object-file.c", so we
can now get rid of the USE_THE_REPOSITORY_VARIABLE preprocessor macro.
Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 55396d4eaeb..9b4ae1bc82b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -7,8 +7,6 @@
  * creation etc.
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
 #include "convert.h"

-- 
2.50.1.327.g047016eb4a.dirty

