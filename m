Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153E1D88D7
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019049; cv=none; b=eBmVN5ydgSq+E93UolmxpRZo3hRCS3Z9DW4sIQy+7Vqql+WHoZJ55GrIUsiJ4koY7E2Vy/9teRHiTOEBbPYMdE89vhz4eMvvcCora/1ckVuKQCMdUSM9OcrJVqsU219GuEi0xzHfZnTCakmav/O0jm0bOljyOSFCK+htmbsgldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019049; c=relaxed/simple;
	bh=HDDNaLjWql+wxMeQWtRrf3ZJfly5TaBMOZ3OB5rCjho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BeVoE0FTxS2SPubMqVyVkOfWZm7fF5jIJR/mW8HkPWPssnOVD6SykcSdd9cHjEuy2urvaSeU1aF/pZ6fRN3nbR8u6L9Lza2us6YRouu+4sRg8mt5aXk0FSd43+trcA7xQ37LjgGULCUzJWNyga7cGGdfsi0Kmk5GaNLfwbpZrzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Eug8hEI3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ML3W2RJz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Eug8hEI3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ML3W2RJz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42255254017F;
	Thu, 16 Jan 2025 04:17:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Jan 2025 04:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019046;
	 x=1737105446; bh=Sm+dUne1jN6ypiwjhDc7tPDEUoLGYFi2/iXFk3/FZIk=; b=
	Eug8hEI3ybIKaLlsW0yZhfmGuJwsu8vp2uWWQGaXNZHuGQOmIf21ipOgdzlKK+GK
	/IVPqUw/YwMYISuL5ZLtUJGyxip1Yc20JnawCfffTSqWbOr+OW6OZ43HiiRw3Fm3
	YIJtZRMS6ceRljJWZjC0bD0f03cBPcG0x07XwWjeV9vUvZ7w3HKa7TsBiGWAloFk
	4VAXLLG1TYotPodrWIKxWbI9ZQ2uJU5bOWOb1XKgrZKE1ykSn7k0JMRGJQcV0oLa
	/Q+CKWXMRrWS23K6gOhwvwHKUBTWT0jfwY7HT99hnnjddAnJ0J+5uxlRNDp2GBOJ
	Z/GFPGn/R4FzeeXdRnNRLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019046; x=
	1737105446; bh=Sm+dUne1jN6ypiwjhDc7tPDEUoLGYFi2/iXFk3/FZIk=; b=M
	L3W2RJzGH5afP4br8+ZIRkJaU8Gk+A+FHT5WsEkbWUDQVRHPfQ6SYT0qDd0oDaKj
	rRggyJkT+jjtxCY1uWgXoxGT2TKc1biW3hhoKd0Xi9NWNU/K2tC0nGestp1biDTQ
	5fKfhxjs4TaLIjkcLTq2qrXa5magX/6SvSbAJh8JkiofxzHOJop9cukfXd6D7DBA
	exQ/d+qykpCPBQXFbgaiv5zINCAy2tqe3+PmoqCm3xd12p63B9Qhume4WK+Y7b9B
	s4R0ea14TCh2TZB/QlMOD5nIctdppJyktUgxqmnPXFsgF8hExiSX+r9wl9Sk/12C
	A7rwDa6sS/IEZkhw0Hi1A==
X-ME-Sender: <xms:pc6IZ5pg2cYyHsbr9Jjx5ivu-lnxIeAvVK3vl_Ks-UcUggNFwq2ixg>
    <xme:pc6IZ7qZRtnxk7zdaUrzn_dHp8yq_M3UfoYoW8QTxlvNrS79A6G5izMrZo1F9NLWd
    5xDH2pln5Vcn61Lrg>
X-ME-Received: <xmr:pc6IZ2PoBOwc543y3kpQWrujDXRHbm3-Y5YmADs2C3cCiL47gTUSvwzou2wRfD_QtDwMeBRIx2Skv0wsd8g10wrrxLj4kRileZjRaTTyagJFCZgk9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:pc6IZ05QB0F0V5PNwYHeica-YOeRv-1uv_U2yfRwZrwrg5NRuxbaxg>
    <xmx:pc6IZ44JbypmCmgehYHtoJf_5wbcwvWGKffTrZTMnBzDHzTdbdg-Tg>
    <xmx:pc6IZ8hBq0fKLAlpMDrN2JvlV6uUtnGNejq4Gix5F7BhyIXkiVWWiQ>
    <xmx:pc6IZ65DAuj4kYCE7GEW7-NvkUPOOEzE245cRogUdLUlLGLRP2emRw>
    <xmx:ps6IZ2kYfzqFYZ9H1xo_T1t2gLpgxgJBsjDJquAdA0UcKiCVjqNk-1EH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36b7eec9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:16 +0100
Subject: [PATCH v3 03/10] compat: introduce new "zlib.h" header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-3-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Introduce a new "compat/zlib-compat.h" header that we include instead of
including <zlib.h> directly. This will allow us to wire up zlib-ng as an
alternative backend for zlib compression in a subsequent commit.

Note that we cannot just call the file "compat/zlib.h", as that may
otherwise cause us to include that file instead of <zlib.h>.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/zlib-compat.h | 6 ++++++
 git-compat-util.h    | 2 +-
 reftable/block.c     | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
new file mode 100644
index 0000000000..bc20b884ef
--- /dev/null
+++ b/compat/zlib-compat.h
@@ -0,0 +1,6 @@
+#ifndef COMPAT_ZLIB_H
+#define COMPAT_ZLIB_H
+
+#include <zlib.h>
+
+#endif /* COMPAT_ZLIB_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index c4b4b372b4..1ca2671322 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,7 +1537,7 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#include <zlib.h>
+#include "compat/zlib-compat.h"
 
 /*
  * This include must come after system headers, since it introduces macros that
diff --git a/reftable/block.c b/reftable/block.c
index 9858bbc7c5..bc9b079634 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -13,7 +13,7 @@ license that can be found in the LICENSE file or at
 #include "record.h"
 #include "reftable-error.h"
 #include "system.h"
-#include <zlib.h>
+#include "compat/zlib-compat.h"
 
 int header_size(int version)
 {

-- 
2.48.0.257.gd3603152ad.dirty

