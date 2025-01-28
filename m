Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E91DF73E
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052918; cv=none; b=cGs5K+4msJr+lYcGpGF7Ap90n/aPiSj8smaRV49O6dJa3fLtOCfU97HM8vQaEQhrgvTl8Tkj/wkwPkTrqGYA9QErWuv+2asgIoELkz6iRpiR7/fVFZSoLnDOLnnd29e7HQf6VlH22TJ53ZAPqH/QK+jQZ3ToYnxCuICCp0LhjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052918; c=relaxed/simple;
	bh=+8IM53TbqpUgRfB/inFpjOz9489TvwK+2iXKydpy3II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKOJDI5CXHZ2mf5NUbdZkaRxbivD412deju1X/qQ41Sua+ek5P+XsQnWPwCRPV59ri4WJ5pZ+IO66GeTG1zaXZQzGGtzlKDcY4JW0dc0WxNpYaOLbMsHMITkimprIKsJ4YP6jZTZPm1FdEPe5oP0IrnfMGqkoG3hi78u5LldzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I7OtqLjQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3/6SZeQ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I7OtqLjQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3/6SZeQ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF167254024E;
	Tue, 28 Jan 2025 03:28:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jan 2025 03:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052915;
	 x=1738139315; bh=fZf1W4LUEYyZlqON29LdWuZDASC2Q90kB/sAd3jZi9U=; b=
	I7OtqLjQa2Lb/wmfa1VZ002aQ+Kdb24Nkb1ljp/Lye8c4L8UAdHuQD3dbHKjrdJo
	Uv/bJ88785aYfpAcXh0NVDGb99xGaM1Z+C7jz+6FG60C9AQfW0wAPns1gYUmVnG0
	yQNXlFwsJIBKSSeW+RU2qMbKL0ZIIJYj09qWv49D88hS1FXwa731vv2ZXox2/9PG
	etWHxrgcIfXgyxw7EiGDyacdourYMf2BLVZctMmFdD3jR2n301PSjhw4gk1dAydE
	pT5E07jIToHYXILPsrqeRviVeiO3maaozkYeCAFhuNt1vKS2FEbhFYXOHqHS5/9d
	0IcYDcx6XxXA/4aJwVqTIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052915; x=
	1738139315; bh=fZf1W4LUEYyZlqON29LdWuZDASC2Q90kB/sAd3jZi9U=; b=i
	3/6SZeQXQcp8v5hoMO7dMM3otckbRsZacIeKYGNw9u2wCas2rKME4/cceXnSQgy1
	sWcp6SNA0yiytWRa/SfYYmxc5ZxR7kRgDk4ar6w/TZOrccE24781acAc4LLm5e1e
	2AdJZy4cZMnWPewCMBzXIewMANCXn+qLsIMCm+1fIv0RCCyzStzmp1QZr3bZyrzp
	SOb+PvfJ/IcBUYZM/pn06z3tlkZvVXEkjgcLLq2jR6PQtPr9E51LMuXUJK9/u/A2
	9sBWuuEfP4NR3kxm9XSs6yeI7Yi0UsrJqlZOd4PzwzDwPcr+yCd7XNCrWW+sfEZI
	o+VwZRPabevNJZSx+k26w==
X-ME-Sender: <xms:M5WYZ1jI0_hOdQVP5XBw78g6MtQSUiz8vnCPYcdjIW3oUeO7ARpOiQ>
    <xme:M5WYZ6B5QYFKEKz8HZGm4jLf6HKROR4p6jctdF5IDVOw1hhhoyVrAYIfWmsVLTrJg
    XrOMiYh3PLKysdbFA>
X-ME-Received: <xmr:M5WYZ1HhBrPyU2IvDt-30Ct5pVmaNeTKZLla6wKQfJahfMe6VFnNMdb8ky2EAWal166cdvGWHHxtsM1Rdr2zQCPtSntySKTSLq30DxVfcLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvght
    hhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:M5WYZ6Qh7KEo64IzPWPLtF7JKTflNhBNtrrNg7yyhbrfK0bCHGG82Q>
    <xmx:M5WYZyxvN4_zCCpa2Q4o0WKcLl-5PT5rLLby7YnVx-3kdtCBHQT0Rw>
    <xmx:M5WYZw568u26G_NvOsjejxDeY199N3lKq2itOpCC5LYmNNQ9aqV7Ow>
    <xmx:M5WYZ3wdbEUCO2avu-bSvlGDvbW08I2twWhP8Bh0RFwJR9rs8kyuiQ>
    <xmx:M5WYZ8tfHbUQUjp_KUoIVDeV2eUqiRs_egOmO9kbpdITzlwVdWT6rkJ->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f7259f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:21 +0100
Subject: [PATCH v2 20/20] Makefile: skip reftable library for Coccinelle
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-20-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.48.1.362.g079036d154.dirty

