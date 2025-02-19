Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164971EA7C2
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970854; cv=none; b=hfkrvwIaJ3uzMXQZPIfKtIf8OXJQ7d3hImd6uhyutl0ZTecToSBVZyHfPwg+JQkXMK+lj3eu/QeoEonFiRfnM4ZQTHCfHjQqiZrkQk+jtxrIAXyx51KPoGlOQvtiWuQC9S1RaXFG1SWujL2D97InlNF3R0fT02TPJrmeR8JD5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970854; c=relaxed/simple;
	bh=gTMLGybaWvWQ3pjOoPFj17/B1oRBi0cH6+jroQcy/MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAar5KYM7MJMDf5N+BtWXEDbX+s2K6sKoWOI9Gvlqg0uvlT+vd3g3h1+mCBvHEg7YqFc4NEYazt1qwm4oaqB1u6B9rKkmIVW8cuSbEkknO7RjDg1sovRg+vOUQR9MBdeVj2yUYyjXrXMgHlTL35rsUw5dPuFHG+VpY77DkQX4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iM1/d1xR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r+LYx6Ex; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iM1/d1xR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r+LYx6Ex"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 160DF2540202;
	Wed, 19 Feb 2025 08:14:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 08:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970847;
	 x=1740057247; bh=6XDfuQyq6DMaf4dtdjQtc0eJ6cYncOUgpzOlNcQDWXg=; b=
	iM1/d1xRMdp/gCirYQpmwaOVUhd1+gqHvPoIS0kLQJPBOSEIU2Zb2HIaHjxq5Xy3
	pssevzeHvs+Y5LxVL2dY1frlBozxDIzDocO/2CeXaWgMgoRjtJVlE3P/SfGOID2Z
	3ed/EkSMgP6j1usyyQy5GAHd+juDwqKC/LOfRIv/GV5g/AZ7fVfjSRIEZoe3zfap
	yQ3v9kz+NCouDwgVktU4rTBgCzZNLgRKJMb46YmR2H5OnYB1iN0TJVVK7YDawlAP
	Rh4UJOMHDpyfu4qbKUVx+zKM/mtg9CNRh4tIOumsdqatj7eLLSoy4TWpLYCHqXtS
	ymxxA3ezKIZKnUStFf/HEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970847; x=
	1740057247; bh=6XDfuQyq6DMaf4dtdjQtc0eJ6cYncOUgpzOlNcQDWXg=; b=r
	+LYx6ExzrQO+cbc2+ydRATSf8b6W2ehJma//CFGdmm1GlHZEOyZyo9wZzpVFBKzH
	c4ILPhjmtTFyrWKAzr9jxouIO0944iSfOo4Bq5vBfPuiNFZ4ePun7xaaAjEV4/zW
	FTWnzGR5alCRe4nB0nLbN/eCoh1yak4goeSggoM2STTfecZB5MO0spmyaoS0cywe
	fbNxw20zf7/egq8gNgVKPNtNx4p31ZB03nKui3UawdRfMijJniPqZnZXCyZBOIv1
	GTJfQegV13Z50D03YtHgmjpBUMjqquJaebnMYgsijVj2+tVRFZmwJvpaCgrDcSZw
	28hP4AY3/lPDn4E+NGt0g==
X-ME-Sender: <xms:H9m1Z9IBhm24AlqhgvstNPFzQYgLJeyN8YOn3TduWx-V3CuoYkSoIg>
    <xme:H9m1Z5KOPxnvRI1JjhCuUOSFWB31rb76pCElM9F5cFOfifND2nzt9LEcIS_vtRhC3
    Ki5hFVR7RIdW46TLg>
X-ME-Received: <xmr:H9m1Z1s4H9wC_EYsY3Vlg0KqoDuhDJ6njWs6ChWXV5nKm_6PBvN9ZE4NU70KM0u1s26wfzZXayvOEejLGTlRIOEZHc5DrWi50q7BS1wQIYkkmes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgt
    khhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:H9m1Z-YstOiDx4V_M3IYSSY6uS3PETLSAgdEG9s23Vgr7zL2O9hrBQ>
    <xmx:H9m1Z0aGWQndpkuHg8efXP52rMCDzG0k0g5DFYm3VR7UxmLPuPqtvA>
    <xmx:H9m1ZyCsL2fQM5A99QXfQ8HJTC5AmQCYCsVrDh3BNqHDI8lX0pdsPw>
    <xmx:H9m1ZyabDqSXhjMuo3yThs5vQQ2t2A4kc5ZTcjdUGoJ0wwkK0VtfKQ>
    <xmx:H9m1Z7UorpOUCCCWzu3MBEpZbRbfASNh00hTwq7RH8fHg0d71id2iXWI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9b33e74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:14:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:49 +0100
Subject: [PATCH v2 09/10] ci: fix propagating UTF-8 test locale in
 musl-based Meson job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-9-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

The musl-based Meson job is supposed to explicitly specify the UTF-8
locale used for testing, which has been introduced with 84bb5eeace7 (ci:
switch linux-musl to use Meson, 2025-01-28). That commit had two issues
though:

  - We continue to refer to "linux-musl", even though the job has been
    renamed in the same commit to "linux-musl-meson".

  - We use the wrong option name to specify the locale. This was not
    noticed though due to the first issue.

Fix both of these issues by fixing both the job and option naems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 028fea0e7b5..84d11452650 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -348,8 +348,8 @@ case "$jobname" in
 linux32)
 	CC=gcc
 	;;
-linux-musl)
-	MESONFLAGS="$MESONFLAGS -DGIT_TEST_UTF8_LOCALE=C.UTF-8"
+linux-musl-meson)
+	MESONFLAGS="$MESONFLAGS -Dtest_utf8_locale=C.UTF-8"
 	;;
 linux-leaks|linux-reftable-leaks)
 	export SANITIZE=leak

-- 
2.48.1.666.gff9fcf71b7.dirty

