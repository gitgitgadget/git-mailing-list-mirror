Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2E1D9A50
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022125; cv=none; b=aoeBl1sZAynNo4WOGlyEhNZsuvftuWqrXhG2idb1XA55ybbmrNPooZPXtwH4HjlgcHxam+YkFWE3cx4QpWB144IWRAQZrmC1A9fkgJVCOrhl0+mjmSGNGjFKvM0HzKUDyQKveHUjTN5ZG5TYmUeYgFHZMw7GpgdBtl1GRAjymMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022125; c=relaxed/simple;
	bh=MWlPFfiBpAzkeR0o6hnl8YcAi49g/OO8o5/uZf3PM+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRarYAErOkNRPVMSwPjZtaFw8+DM1iU2dkRlPVEb0ip71/sKbkzVYBtxzsLzV9jyJu2F2wXa5r2u9cICES7mz92/O4mlYolxy2LE0j4qqp6U2ukSl3ad4n9TqBeArgJL38yJX1We932Rmj966lQcuYvWv0CnCXX9bhKiO49sr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eCOP2YZy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KzlvqAsY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eCOP2YZy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KzlvqAsY"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4DF8C2540115
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 05:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022123;
	 x=1737108523; bh=G8HxpO2ahXyXxrAWidSkaMlkET8k8/rI1blBbt+aKKM=; b=
	eCOP2YZyEqwWZlmf6A4Q/hCwh9PIn3lpWJgfcxxYv3sSeIwpay6ZRV0ChKlSQ9n2
	upP5bB1XbDhfhTLruFJSfyaCQfbE2IbbiV4/+8NMIkkn/RslesimrUzqlBLfveiH
	/q3fNvg3N/iWpzuS7oIGXbp8r3nwP/oOg/ORqsyks5cBSU0eGOLZww7jHjrbhUak
	863hl9dnkb4gvHo0HRr++rscTraqVCGxlRf2ebX4EwbeX6HV1YkEZCNK4y/Si8L4
	ep5cUrlkhBGwqA1B8EuGncxlHRLtjjMhM+mKhUoRzXds/2beyskXe3LpFoh36E5t
	Jr04347IiEhXfi/w2tyhwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022123; x=
	1737108523; bh=G8HxpO2ahXyXxrAWidSkaMlkET8k8/rI1blBbt+aKKM=; b=K
	zlvqAsYjBPCB+1c1u1k2k0QF7W8jsYO7QBb+8+iLHTzrGbKEegVgLPy2wNrm2d4r
	QE0TgY3gv0iD2LACzTCvsGf5ClrC7gyZDdgDhHD1WLh5WOuDsCDFw5nRJvN9H3KB
	OoR0tdFWpArxhfcw8wLMgvbl3ngadAHyNkKwv+h0O/kG1v2vcGpd0YHsXEuFq1OU
	SUg4rU7yW3xePswOFNr9Bqy3PwA4da5CkN7k8FyTFapC5s1pUOir0LdcKRBnzBRa
	sJ5mI/SugZsHhkX5Urzh6lRBr+zv96MgT34a3w/50hyzhw01cQ9ac8nvhHXhaXFr
	b1kgU5H9JbmOyT+OYdpxQ==
X-ME-Sender: <xms:q9qIZ05BYPJEeEvZCkcMGBvejb70EIcqlw1ik1bi3zOJ82vPdxCSZw>
    <xme:q9qIZ17-hc3_GZ7wlzCiFVIvFn7lGehN_NdOFITUcQ6PKNZ007f94VC6bPyXg_HyH
    zyMDEg3uRrxstDLhg>
X-ME-Received: <xmr:q9qIZzcant4yAjiZGX09n0gqXyV8sIm_DhzZabgmIwTIHxd_P-t60Wl3PM62VhdwGExtKKtWeuxuK8QKStepkpQPhEIgehu9dUftSmteN9XEGkU2Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqd
    dqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeer
    tdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesph
    hkshdrihhmqeenucggtffrrghtthgvrhhnpedtueekgfehtdegleeukedvkefgtdfhfedv
    udeiueelheelgeeujeetvdfgteevteenucffohhmrghinhepmhgrkhdruggvvhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q9qIZ5L_dfYZufHO_AtVHqyQ0Qx_adTmy1A83ucUG_mjJQlVbP7UrQ>
    <xmx:q9qIZ4LBtmb468eGRatoCpyCfEjYOErS2JOgjRgL00NAD6GFiMmOCw>
    <xmx:q9qIZ6zMaY7zK-ywpqqGzVLuiyyTAyuqhgJsZ2K5NL3x4fvcWRC_oA>
    <xmx:q9qIZ8I-HPq7sV2OeWlSsmtzcYsyBU6IScqjYM7pORL8BtZnwW-q1g>
    <xmx:q9qIZyirYsjNQ8l4rGxGuu9hYT_F6SwGIBRmR5WFWbyfcY02Qyn38Mng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d136730 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 11:08:33 +0100
Subject: [PATCH 01/10] meson: stop disabling -Wsign-compare
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-1-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 4f9264b0cd (config.mak.dev: drop `-Wno-sign-compare`, 2024-12-06) we
have started an effort to make our codebase compile with -Wsign-compare.
But while we removed the -Wno-sign-compare flag from "config.mak.dev",
we didn't adjust the Meson build instructions in the same way.

Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0064eb64f5..07744c73b1 100644
--- a/meson.build
+++ b/meson.build
@@ -708,7 +708,6 @@ if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argum
     # These are disabled because we have these all over the place.
     '-Wno-empty-body',
     '-Wno-missing-field-initializers',
-    '-Wno-sign-compare',
   ]
     if compiler.has_argument(cflag)
       libgit_c_args += cflag

-- 
2.48.0.257.gd3603152ad.dirty

