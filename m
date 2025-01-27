Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FB200BA1
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983074; cv=none; b=MQWn0Anodva/t4DS8huYPn7PcG1fJM4l0tTsVNd3w4V5XCyPzJdLEH2Dy3lOrgtlJjzJDSPIym8GR2gtYBk4RQUfhF07BCvyx7FcwwtKK4zV0EEIzT8PjOx1020viIFw3Frdc0zReJIrVjBz1RNK5dUP9I7KXlPzMPPJxq4Ob/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983074; c=relaxed/simple;
	bh=1cfGhv2CtVDI+uEnfhoidh6GGJu7m6+3q1YI4IY2DdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcm0PQAhkGkmMzhxyz/lDmiDD79JL/BA3qc0OWZBzewEPgdM3JZaphB1LpbK4XCmuZrUP06906T3Ye9RRPZkwoZHcmRHgyHrytwg9e/B1CfEnQK2fMvy2I40+kP/uEBc751U9uQhs9Db4H1GDjVRAwzSTWLF6tsk3C9Q31Ktj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qm+0U46f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPQN4PMq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qm+0U46f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPQN4PMq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DDFA1380B1B;
	Mon, 27 Jan 2025 08:04:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 08:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983072;
	 x=1738069472; bh=2YvloPgJ0adqNdO3FdP2VF6v6pumLPMKOE7ELd1HVTE=; b=
	qm+0U46fyjz1BgZ62P/w4ZpJ7X3cUjzzm4BJkkhiZrOhxex9RSP54FAVEhzlXzYT
	wOGRXPAPAnOfyQ4hWmUEk5IKs3skGOx+n2nCSJaSEg/wpwRgTetwrNXAKueIATan
	T0sJtaSdj2jKq2uUdeJfXS088B3cK4J/hMDSZECIzMfAgbeaAT/l7FUoVzRJVvLe
	xei9ePL2K8bLWZatuu9CTh9mG1tdLDH+4dx8AOKyAM1bsmc9+WpXWF5QDh+dOu+R
	Ovkhzu1R+Nb+h075kdiFFO+sWeBT4NgYRwJuF0SFMBccogvd6L0yL3jVMFAMHgM4
	AQCD7a1TDWqLGoM3pH+Wxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983072; x=
	1738069472; bh=2YvloPgJ0adqNdO3FdP2VF6v6pumLPMKOE7ELd1HVTE=; b=F
	PQN4PMqrIqJ87vy3DJpwfEFE7mJiVwaB+CwKC+oijAIMMBBVwdo4c6z8K2RkTV9g
	VT9trAQHi3/d2mN6F4uC4WPl2llpZ+tZnjliFY4wIZFC/QVtavPFlSL0AHc0ov42
	npAdBFWqhRt3NR+7ArDNOrtMm32BYBlkxMXj2QBwpPB4PnE7u7/dfV8VTlUbC6tV
	6SdXbcLTfqeO5sna+rxPbNX5Tupv9Ccs3Q+YnAEqNuFKwrx0aRFdpZSg8bNiyQyO
	nvAHH3u7psfOS8HJllPMOBV98MWe1Fejm37Xsu2cn8a0ZH+nV2/wdehKZ7UWwkfB
	wf77BL8bQ9y0o4Eu1nj/A==
X-ME-Sender: <xms:YISXZ54USuuQiIs3s8kVvDlwalnXTzR04h3EavC1Wp1Z-787RHgpAw>
    <xme:YISXZ27XrgoN6qtNqQ0wNO1S4bZHwOQmKJgifJv920teQM7m7gX94_JLyx72hiHPk
    Tji7frTm2e5O237UQ>
X-ME-Received: <xmr:YISXZwfmxpaH9IS67sITTjrpshrgrnujT-sB4cGgl3wTUemPGM5yRG7RKHxhtxBKMWNmM8H0qxb_AC0rGU62ZWVGS0yRpfe6rFPz0QJwBmkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:YISXZyKnsUq3hc0O0expLqr4EUeD1eR9BdkWGP51-XPPzioCCsXbmQ>
    <xmx:YISXZ9J5aDXZOgrjVCqGrJvIRpW3uVhHarGSAqOZykn-16cFAK8yLg>
    <xmx:YISXZ7wmbYUWK4zb1m0XucR3dHcG_gS477Q-Ebc6tj1V3mA2JsAWvg>
    <xmx:YISXZ5L3MxDVFzTWOFuf76lX_cut0MrbAkbJtepzbc-vRCjhruJiIQ>
    <xmx:YISXZ0UvRoxXC53k5Wz8-qNO-CsVfkrPODTGmeqL0eJc27U7CAuYNrPq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03817797 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:26 +0100
Subject: [PATCH 18/19] reftable: decouple from Git codebase by pulling in
 "compat/posix.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-18-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

The reftable library includes "git-compat-util.h" in order to get a
POSIX-like programming environment that papers over various differences
between platforms. The header also brings with it a couple of helpers
specific to the Git codebase though, and over time we have started to
use these helpers in the reftable library, as well.

This makes it very hard to use the reftable library as a standalone
library without the rest of the Git codebase, so other libraries like
e.g. libgit2 cannot easily use it. But now that we have removed all
calls to Git-specific functionality and have split out "compat/posix.h"
as a separate header we can address this.

Stop including "git-compat-util.h" and instead include "compat/posix.h"
to finalize the decoupling of the reftable library from the rest of the
Git codebase. The only bits which remain specific to Git are "system.h"
and "system.c", which projects will have to provide.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/system.c | 2 ++
 reftable/system.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/reftable/system.c b/reftable/system.c
index e25ccc0da3..1ee268b125 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -1,3 +1,5 @@
+#include "../git-compat-util.h"
+
 #include "system.h"
 #include "basics.h"
 #include "reftable-error.h"
diff --git a/reftable/system.h b/reftable/system.h
index 3bd4a4e322..e4a8944a70 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -11,7 +11,8 @@ license that can be found in the LICENSE file or at
 
 /* This header glues the reftable library to the rest of Git */
 
-#include "git-compat-util.h"
+#include "compat/posix.h"
+#include <zlib.h>
 
 /*
  * Return a random 32 bit integer. This function is expected to return

-- 
2.48.1.362.g079036d154.dirty

