Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAAA1D63CE
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864773; cv=none; b=Cbs3BPGSO+8N18ArJ9slYDgvkM0e+sE0HzzRXBaNoG6xpwp7kDd2jQEjKg+XrY1ip6LGeMVwOnqGiuISClaGU1atadrfQmet5Raix4AbrGK9PHMuv/wc/HlgqABW97dW7743Y3R222ijaufJkWU1yuN5CI7it0FBYVj32vb0EXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864773; c=relaxed/simple;
	bh=P7belojgmpWqg6uu+gumhfaimrGgyr69IOfM6F5m33M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqM2cQ621i0EGfornhj1Q7tX/Ms0ozuU/5/+UPB9F16yyTmuv2lySmuGu0IREXWNXLcNQhf2RSMSHW2+YKjR3FlAArndD+akXolsNOWsO3r3lXeKCfAk1Ky+Acwo7q2JdSjz+nrkIpo6rodsro2v4Q1yupbbtKi7jLlj3n0Wosk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rsGwwfLO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZ8FGRat; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rsGwwfLO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZ8FGRat"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E50C71140257;
	Tue, 18 Feb 2025 02:46:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 02:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864768;
	 x=1739951168; bh=SyCuoN07KpprDPsZYdCQnC/i7dD0nywt1RH8i+RgF20=; b=
	rsGwwfLOEZ50s/80hweFrj6K6Lg9uBEKduHmchnUtXgFsdHz7PGgLU62v9r8emGu
	9GqSOLn//YVVJnxYIFA6BuMPpvmVg6uJV2Qatc8dVooE4zhIcG0AeWq7lY59vv24
	avslCn7bAqJ7wRwu0Tr61KQO39BJijQ+SWv1W27+E+AAZw/oTpW6t4IggRq5VpZl
	lRF4tYxfhMB+yp7LRzJ7fNfjziZP/uJZJYFSCh04dTZfG4INFQx4NzhC1J7ODB0Q
	TbDFw6Lj6bj5JK6hxXYs/rE5yYpJDtUjzl2boixvrJ5/Bgh2Vqesbphd5ISzCgeG
	nji8qkzuNFMHrPvXfjTzPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864768; x=
	1739951168; bh=SyCuoN07KpprDPsZYdCQnC/i7dD0nywt1RH8i+RgF20=; b=d
	Z8FGRatoFf+YjdmhwfOhJTGv+Vw8hWFyULSJO5nL63BtWVgoChLXVqDA9jbXDNRH
	4lzVCfx9dzFtQjCK0LHU6mhcVs0NcmtNWfDyheQja0UCDcQaFBvQcyFfBuWjBi36
	kgoC1rCuJ0MFMLsVbtgR0TBPLDmM14EcgGT2nMiQynz4fX1jF0ongCOzSwkZkweY
	rDYMkuxUwb7vkCCbKrVTgTYqsj6jeN7q+21daKebVPmX76ilLLgnanQeDeYyToR3
	/Fc1kvazuFGOD0SAN+sRfrkG4jzMayRJNZrhGXPdBrBZmieYlhmps9xZ+SBtefw6
	743u61F3BtrP/WAB+ldzg==
X-ME-Sender: <xms:wDq0Z5NA1lj4yB_EP_wA6aG6bcCCWhnxLw332E0wcdyf7l-RXC8iHg>
    <xme:wDq0Z7-st5q5YEyiwuFXzDaLF8L_LVOjAE-SF84_lnZfybxDqo90NPR-UQXWTUKL2
    KmueqlThd3P0DuvEg>
X-ME-Received: <xmr:wDq0Z4R_3L6oBngp7Q-fCQNI-_rB6P_0579GDC2GUfe7dq8KfKnoQ-RlpOjtyNPZenIxRk8_VXSHOhnopZQnCCs2apjKLW9xiGUvEwCCV4tmCgDG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wDq0Z1tPBqnLaq1GbgmX2SDUizkKLlIs_punfOocVmlPrCfsUi9T4Q>
    <xmx:wDq0ZxdQI_GsPfqkBGE5QrrZS50zykq6m7Fs7jywDfQ-1KLXZlpcFQ>
    <xmx:wDq0Zx1gGK7a4ozH9Sj9Idmp_wPI2QHejck3AdXxyCRpAmVwcJIrGQ>
    <xmx:wDq0Z9-LFDolCaRjYTrdfYbM-wTrNTEDq-jdz9iRHWFoD0NXemlkfQ>
    <xmx:wDq0ZyqpaZ236wmpP1W9oUvs8zkOLL2H8jEG6uFp8NNhbZF2qqplPJeq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0b04632 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:51 +0100
Subject: [PATCH 03/12] contrib/credential: fix compilation of wincred
 helper with MSVC
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-3-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

From: M Hickford <mirth.hickford@gmail.com>

The git-credential-wincred helper does not compile on Windows with
Microsoft Visual Studio because of our use of `__attribute__()`, which
its compiler doesn't support. While the rest of our codebase would know
to handle this because we redefine the macro in "compat/msvc.h", this
stub isn't available here because we don't include "git-compat-util.h"
in the first place.

Fix the issue by making the attribute depend on the `_MSC_VER`
preprocessor macro.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/wincred/git-credential-wincred.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 4be0d58cd89..04145b51183 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -12,7 +12,9 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#ifndef _MSC_VER
 __attribute__((format (printf, 1, 2)))
+#endif
 static void die(const char *err, ...)
 {
 	char msg[4096];

-- 
2.48.1.666.gff9fcf71b7.dirty

